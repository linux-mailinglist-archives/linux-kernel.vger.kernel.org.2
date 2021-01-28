Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B51307CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 18:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbhA1RmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 12:42:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36398 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233202AbhA1RhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 12:37:05 -0500
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611855382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYjYAT4gLF1Z++rDaWeH0FhiuveVOiDaFNbMe8MMBzY=;
        b=z/luVnTFXCBDr7SQKkAm1FGidZcpkP5cmOeevip55y8XfftzavzTCDTSbRyK1ku9AQZMC/
        VWxVaIersiUmPSi4lzH1EyFyC9phbWJUVhEkjLytlsqPg6trIxntfnB+Gbb3Zb4nX9BM3Q
        FddayJ5mxIIiztmObno5nq10LerWs5pVVYE8PtGN9FnpPOicL8F5IXVLgWmi/v7sovLiCk
        NDP/7XcYg6No3XWz8JDWoqxnJTf5VMHmrSdLiliyXO4KC6Y8OtOq14HfLEcItWQJC3EnNK
        vUSRAxrohbTxvbhaF4XUoHxoX2j6LMkyyk5ARZ537BJX58uYrjo6dtLtepXwGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611855382;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VYjYAT4gLF1Z++rDaWeH0FhiuveVOiDaFNbMe8MMBzY=;
        b=2U2tdRmFJ1DCKKgZL4FoGELw1vVNQvBZJkd+ztuS55Myg9ZGYLxxb/xOyiq/KLkbX4LNnt
        QZgcoRzG6ogWMcDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com, zhengjun.xing@linux.intel.com
Subject: Re: [printk]  b031a684bf: INFO:rcu_tasks_detected_stalls_on_tasks
In-Reply-To: <YBLoGNQNMkFivh34@alley>
References: <20210122081311.GA12834@xsang-OptiPlex-9020> <YAr7d6A4CkMpgx+g@alley> <YA+gAV1kW8Ru1+Bo@jagdpanzerIV.localdomain> <87bldaaxcc.fsf@jogness.linutronix.de> <YBJ2CjN2YntC1o3j@jagdpanzerIV.localdomain> <87czxpmhe1.fsf@jogness.linutronix.de> <YBLPhkHQ8cXFiY1X@alley> <877dnxm5ju.fsf@jogness.linutronix.de> <YBLoGNQNMkFivh34@alley>
Date:   Thu, 28 Jan 2021 18:42:21 +0106
Message-ID: <871re5m0a2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-28, Petr Mladek <pmladek@suse.com> wrote:
>> [  903.189448][  T356] [  778.825864] [  655.250559] [  531.607066] [  407.120936] tasks-torture:torture_onoff task: online 0 failed: errno -5
>> 
>> These multi-timestamp lines are odd. And they are almost exactly 124
>> seconds apart.
>
> Yup, this looks suspicious.
>
> Here are my few ideas. Feel free to ignore them and do your own
> debugging. I do not want to distract you.
>
> The test produces the same messages over and over again. It is
> possible that something has overflown after some amount of messages.
> And the regular intervals are just a coincidence.
>
> Are all messages broken this way? Or does it start later?

They are all OK until about 325 seconds. From the console output I see
that a couple seconds before there is:

[  324.855442] 2021-01-28 17:26:24 rmmod rcutorture

> Are this exact messages printed correctly at some points?

Yes. Although once the multi-timestamps show up, there are empty lines
after the correct printing. These have a different timestamp, so I am
thinking they are probably failed prb_reserve() descriptors.

[  324.817659] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  324.826111] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  324.855442] 2021-01-28 17:26:24 rmmod rcutorture
[  324.855454]
[  324.867910] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  324.875689] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  324.886632] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  324.894394] tasks-torture:torture_onoff task: online 0 failed: errno -5
...
[  325.270579] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.278558] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.292705] [  167.091786] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.292716]
[  325.298241] [  167.098621] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.298251]
[  325.302613] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.319995] [  167.105552] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.320006]
[  325.325588] [  167.120620] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.325597]
[  325.335480] [  167.131624] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.335490]
[  325.346576] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.357828] [  167.138722] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.357840]
[  325.362434] [  167.157591] tasks-torture:torture_onoff task: online 0 failed: errno -5
[  325.362445]

> Is this console output? Or dmesg?

Console output. I still need to figure out how to get at dmesg from
lkp. In particular, the output from /dev/kmsg would be quite
interesting.

> Are you able to reproduce it with the current Linus's master.
> I wonder if it is something that we have already fixed.

Unfortunately when I switch to Linus's master, the error messages go
away. So it probably won't trigger.

However, I did forward port all printk changes and I am still seeing the
same behavior.

I think once I get at /dev/kmsg, there should be some clarity.

John Ogness
