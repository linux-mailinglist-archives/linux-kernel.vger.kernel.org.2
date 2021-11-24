Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C080A45B125
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 02:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhKXBdp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 20:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbhKXBdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 20:33:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85099C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 17:30:35 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HzNk06BF0z4xYy;
        Wed, 24 Nov 2021 12:30:32 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1637717433;
        bh=Yrg03mcXwnqIwmX7rtcngoa+D83tQx01y1/QUQparZY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=pZPxeuqrVlGliXCGMbFLVGKGbXdjCrOU9ndQSlbMISZda5ycSB8RojmRDugOlKS5Z
         j1q4SVaXhNPh2ZOCwOfJ3F6qlEchyQyfv4izZbPpkEVrht2HHFW3OHU2/edC6Li4JM
         ZczuHVe6Ayitqi3uhuuLH520dsoaUL7qms1hkmaHNI4A2eSlTakQFCB4lBNVillbYK
         zb+6AnS1BOqSWAL0GwswR/dlv78yjZSkoDj26L8/GoGZIv3/Vax/jHx1rdFmBun2OI
         Ev6/qzdGAtU7rUYRxJSyd/XAteFkIR1bfHY5jfgPl8pAG2eCvgWKtIH5jm28Dk/6BQ
         KTAlDhn6tyIsg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>, mcgrof@kernel.org,
        david@redhat.com
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
In-Reply-To: <20211123055906-mutt-send-email-mst@kernel.org>
References: <20211027022107.14357-1-jasowang@redhat.com>
 <20211027022107.14357-2-jasowang@redhat.com>
 <20211119160951.5f2294c8.pasic@linux.ibm.com>
 <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org>
Date:   Wed, 24 Nov 2021 12:30:29 +1100
Message-ID: <87zgpupcga.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:
> On Tue, Nov 23, 2021 at 10:25:20AM +0800, Jason Wang wrote:
>> On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
>> >
>> > On Mon, 22 Nov 2021 14:25:26 +0800
>> > Jason Wang <jasowang@redhat.com> wrote:
>> >
>> > > I think the fixes are:
>> > >
>> > > 1) fixing the vhost vsock
>> > > 2) use suppress_used_validation=true to let vsock driver to validate
>> > > the in buffer length
>> > > 3) probably a new feature so the driver can only enable the validation
>> > > when the feature is enabled.
>> >
>> > I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
>> > feature. Frankly the set of such bugs is device implementation
>> > specific and it makes little sense to specify a feature bit
>> > that says the device implementation claims to adhere to some
>> > aspect of the specification. Also what would be the semantic
>> > of not negotiating F_DEV_Y_FIXED_BUG_X?
>> 
>> Yes, I agree. Rethink of the feature bit, it seems unnecessary,
>> especially considering the driver should not care about the used
>> length for tx.
>> 
>> >
>> > On the other hand I see no other way to keep the validation
>> > permanently enabled for fixed implementations, and get around the problem
>> > with broken implementations. So we could have something like
>> > VHOST_USED_LEN_STRICT.
>> 
>> It's more about a choice of the driver's knowledge. For vsock TX it
>> should be fine. If we introduce a parameter and disable it by default,
>> it won't be very useful.
>> 
>> >
>> > Maybe, we can also think of 'warn and don't alter behavior' instead of
>> > 'warn' and alter behavior. Or maybe even not having such checks on in
>> > production, but only when testing.
>> 
>> I think there's an agreement that virtio drivers need more hardening,
>> that's why a lot of patches were merged. Especially considering the
>> new requirements came from confidential computing, smart NIC and
>> VDUSE. For virtio drivers, enabling the validation may help to
>> 
>> 1) protect the driver from the buggy and malicious device
>> 2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
>> 3) force the have a smart driver that can do the validation itself
>> then we can finally remove the validation in the core
>> 
>> So I'd like to keep it enabled.
>> 
>> Thanks
>
> Let's see how far we can get. But yes, maybe we were too aggressive in
> breaking things by default, a warning might be a better choice for a
> couple of cycles.

This series appears to break the virtio_balloon driver as well.

The symptom is soft lockup warnings, eg:

  INFO: task kworker/1:1:109 blocked for more than 614 seconds.
        Not tainted 5.16.0-rc2-gcc-10.3.0 #21
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
  task:kworker/1:1     state:D stack:12496 pid:  109 ppid:     2 flags:0x00000800
  Workqueue: events_freezable update_balloon_size_func
  Call Trace:
  [c000000003cef7c0] [c000000003cef820] 0xc000000003cef820 (unreliable)
  [c000000003cef9b0] [c00000000001e238] __switch_to+0x1e8/0x2f0
  [c000000003cefa10] [c000000000f0a00c] __schedule+0x2cc/0xb50
  [c000000003cefae0] [c000000000f0a8fc] schedule+0x6c/0x140
  [c000000003cefb10] [c00000000095b6c4] tell_host+0xe4/0x130
  [c000000003cefba0] [c00000000095d234] update_balloon_size_func+0x394/0x3f0
  [c000000003cefc70] [c000000000178064] process_one_work+0x2c4/0x5b0
  [c000000003cefd10] [c0000000001783f8] worker_thread+0xa8/0x640
  [c000000003cefda0] [c000000000185444] kthread+0x1b4/0x1c0
  [c000000003cefe10] [c00000000000cee4] ret_from_kernel_thread+0x5c/0x64

Similar backtrace reported here by Luis:

  https://lore.kernel.org/lkml/YY2duTi0wAyAKUTJ@bombadil.infradead.org/

Bisect points to:

  # first bad commit: [939779f5152d161b34f612af29e7dc1ac4472fcf] virtio_ring: validate used buffer length

Adding suppress used validation to the virtio balloon driver "fixes" it, eg.

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index c22ff0117b46..a14b82ceebb2 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -1150,6 +1150,7 @@ static unsigned int features[] = {
 };
 
 static struct virtio_driver virtio_balloon_driver = {
+	.suppress_used_validation = true,
 	.feature_table = features,
 	.feature_table_size = ARRAY_SIZE(features),
 	.driver.name =	KBUILD_MODNAME,


cheers
