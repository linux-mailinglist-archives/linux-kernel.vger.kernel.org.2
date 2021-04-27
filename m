Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C61336C132
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 10:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbhD0Itu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 04:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbhD0Itt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 04:49:49 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AEDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 01:49:06 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lbJOw-000d2e-62; Tue, 27 Apr 2021 10:49:02 +0200
Message-ID: <3d89a88fc9ed2a98aeab34dec8770653579ace53.camel@sipsolutions.net>
Subject: Re: [BISECTED] 5.12 hangs at reboot
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Harald Arnesen <harald@skogtun.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Tue, 27 Apr 2021 10:49:01 +0200
In-Reply-To: <CAHk-=wjjBEkOdj=C2HxjFu0zaKT46Yw52t7PyCCYFRaFdu57Sw@mail.gmail.com> (sfid-20210427_004952_690267_E7A79256)
References: <09464e67-f3de-ac09-28a3-e27b7914ee7d@skogtun.org>
         <CAHk-=wgA1Ma6e5qZO1EP9oMveLPJFbj=SC1R0ZewCmC-u0_r=A@mail.gmail.com>
         <34d778fa-343f-912f-2fd7-a8ba49bd1b95@skogtun.org>
         <54debab9a79df628cff86a637dde13c281001578.camel@sipsolutions.net>
         <151b7e41-a415-e780-eb90-6ca16c113066@skogtun.org>
         <CAHk-=wjjBEkOdj=C2HxjFu0zaKT46Yw52t7PyCCYFRaFdu57Sw@mail.gmail.com>
         (sfid-20210427_004952_690267_E7A79256)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 2021-04-26 at 15:49 -0700, Linus Torvalds wrote:
> 
> cfg80211_destroy_iface_wk() takes wiphy_lock
>  -> cfg80211_destroy_ifaces()
>   ->ieee80211_del_iface
>     ->ieeee80211_if_remove
>       ->cfg80211_unregister_wdev
>         ->unregister_netdevice_queue
>           ->dev_close_many
>             ->__dev_close_many
>               ->raw_notifier_call_chain
>                 ->cfg80211_netdev_notifier_call
> 
> and that wants the rtnl lock. Which it won't get, because something
> else is holding on to it.

Thanks. I don't think your conclusion is quite right - it doesn't want
the RTNL, it wants the "wiphy->mtx" mutex, otherwise the revert wouldn't
help anyway since the RTNL is held, and also the code in
cfg80211_netdev_notifier_call() never acquires the RTNL in the first
place since it always assumes it's called with it held.

> At a guess, there is some other sequence that takes the rtnl lock, and
> then takes the wiphy_lock inside of it, and we have a ABBA deadlock.

I think we just have "AA" deadlock, but we don't have the full lockdep
report if there was one, the 'task stuck' obliterated it.

> <insert-shocked-pikachu face>
> 
> I _hate_ that stupid rtnl lock. It's come up before. Several times.
> It's probably the most broken lock in the kernel.

Well, it's also _everywhere_, kind of like the "NBKL". In fact, in many
cases it has become a de-facto BLK again since there's basically no
(desktop) userspace that won't do _anything_ at all related to
networking, and thus it gets hit all the time. I've had things like a
crash with the RTNL held, and then I couldn't open new shell windows
anymore...

The sad thing is that the original commit that caused all this was meant
to alleviate problems with the RTNL, if you look at commit a05829a7222e
("cfg80211: avoid holding the RTNL when calling the driver"). The only
problem with that is of course that the RTNL is still required for all
the netdev management, and as such we need to be really careful around
it.



Anyway, back to the topic. This problem was supposed to be avoided by
the fact that cfg80211_unregister_wdev() sets

	wdev->registered = false;

and then in the notifier call we check

static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
                                         unsigned long state, void *ptr)
{
...
        case NETDEV_UNREGISTER:
                /*
                 * It is possible to get NETDEV_UNREGISTER multiple
times,
                 * so check wdev->registered.
                 */
                if (wdev->registered && !wdev->registering) {



But, looking carefully at the stack trace, that's not what we see - we
see in there "dev_close_many()", so that means we got here with IFF_UP
still set on the netdev.

You could confirm this by taking gdb, this:

$ gdb vmlinux
(gdb) l *cfg80211_netdev_notifier_call+0xe5


should show you that that's actually line 1415.


This means that 'iwd' is actually just getting killed without ever
having set the interface down (removing IFF_UP, the equivalent of what
"ip link set wlan0 down" would do).

Which - yeah, that's a special case with iwd.

A trivial fix for this special case would be to close the interface(s)
first, such as:

--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -345,11 +345,18 @@ ...
 static void cfg80211_destroy_iface_wk(struct work_struct *work)
 {
 	struct cfg80211_registered_device *rdev;
+	struct wireless_dev *wdev;
 
 	rdev = container_of(work, struct cfg80211_registered_device,
 			    destroy_work);
 
 	rtnl_lock();
+
+	list_for_each_entry(wdev, &rdev->wiphy.wdev_list, list) {
+		if (wdev->nl_owner_dead && wdev->netdev)
+			dev_close(wdev->netdev);
+	}
+
 	wiphy_lock(&rdev->wiphy);
 	cfg80211_destroy_ifaces(rdev);
 	wiphy_unlock(&rdev->wiphy);


But while that will almost certainly fix all the issues you're seeing,
it's not sufficient in general because it leaves a race if the other
caller of cfg80211_destroy_ifaces() ever needs to do anything (which
relatively unlikely), since it would still run into the same deadlock.


Looking at this more carefully, even the original commit that added this
code missed something in this case, however. Basically, it relied on the
driver unregistering the netdev, this causing the notifier, and this
would actually stop operation (e.g. disconnect from the AP) before
actually removing the interface etc. However, there are some virtual
interfaces that do not have a netdev at all, and in those cases the
operations would never be stopped appropriately. Most drivers will
probably kind of obviously do that ("if you tell me to remove the thing
I better stop using it first") but I wouldn't be surprised if there are
bugs in this area in the drivers.

In any case, I'll test it now/soon, but this should fix the issues:

https://p.sipsolutions.net/d458baf9b04f2c8f.txt

I'll test it and send a proper patch.

johannes

