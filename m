Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFB7245B67E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 09:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241347AbhKXI2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 03:28:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41424 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233484AbhKXI1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 03:27:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637742282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nWczniTByWw7Gi4+S9JJwdXHUhW2CdmH1/a1jEe8mOE=;
        b=W8eVmSUKM0vgcMRBG8BPHp/FORE2KNJ70W9ic1DrxJ8RB9NbQj/O7LQDIXSvhG19MK3AT0
        UKYDHgrH4i9/mSeJL2iIdX/uQvL9wGoybq+8dv2wJs1J7hf1+OM/ZgnqwnANiputZ+qTZg
        qmDk0YRFnt9uurAkgbD/NPxY2ke4pNA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-566-MgtX3Zk4OjyFTu7aPnR2mQ-1; Wed, 24 Nov 2021 03:24:40 -0500
X-MC-Unique: MgtX3Zk4OjyFTu7aPnR2mQ-1
Received: by mail-wm1-f69.google.com with SMTP id i131-20020a1c3b89000000b00337f92384e0so2600398wma.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 00:24:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nWczniTByWw7Gi4+S9JJwdXHUhW2CdmH1/a1jEe8mOE=;
        b=Vl9wdWfvE8DzZXcHezydartL2mjkISp7Q7rmBA2C+fj6gC9U1LJJcx0xQWBsxjWZnO
         1q0sPJA87ohvEy0Q6m7ghuMdhfzXp68SJ+1tPWthxTV/RmfOQVCeb0jsWvLbpZeSeh7p
         aBfCvLdJscvTZE0Lx66JAsQFtQR6CIR1XTvcE+/3YHXhMsRBseP89R6Pmhrscv+XZz0n
         etPAcSr1ebTxJ0W1/Atv1syDauyhQ4YMjGDf/wVrjXZspyXDiXyKRcWvammyeI+kC4bq
         +R+CQKxCyOe0X3VWMl+ddSEtgcyzo2H135xz7o7Qi4JH6l8aoTY8ZBY/W7E/c3/QE512
         tF+A==
X-Gm-Message-State: AOAM5312I2tH2cxabq+h3kSX/CCIrzYPT21o9j1wd3hwuw25OA3n5iAK
        2EMWn17Jp8OkmD/TojYlSCqfc2nrMxj3xLEh3g7+BI42Ml8DTSbOUN1vvALDZW+TkB0YVZdKQQF
        woUXfldtMDoC6gjPkdaYKldza
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr15664885wrt.103.1637742279406;
        Wed, 24 Nov 2021 00:24:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLobZZKLR8cXQPqwU53pQKSuWBJzt7zqVX4q3QrVznBu5MbYpeMDQkf4pOjxVVRqIR10IF6w==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr15664853wrt.103.1637742279175;
        Wed, 24 Nov 2021 00:24:39 -0800 (PST)
Received: from redhat.com ([2.55.144.93])
        by smtp.gmail.com with ESMTPSA id r62sm3855940wmr.35.2021.11.24.00.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 00:24:38 -0800 (PST)
Date:   Wed, 24 Nov 2021 03:24:34 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Halil Pasic <pasic@linux.ibm.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        "Hetzelt, Felicitas" <f.hetzelt@tu-berlin.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "kaplan, david" <david.kaplan@amd.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>, mcgrof@kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V5 1/4] virtio_ring: validate used buffer length
Message-ID: <20211124032027-mutt-send-email-mst@kernel.org>
References: <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org>
 <87zgpupcga.fsf@mpe.ellerman.id.au>
 <CACGkMEteDZJVM8j5pir7_Hcn6Oq=tKbcg4DUiEQBGm5Kg9w30w@mail.gmail.com>
 <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com>
 <20211124022101-mutt-send-email-mst@kernel.org>
 <CACGkMEsn8xbdEgrCwCWpGz7u=NoX-yADotCaeB2oNbZy_u9iOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEsn8xbdEgrCwCWpGz7u=NoX-yADotCaeB2oNbZy_u9iOQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 03:59:12PM +0800, Jason Wang wrote:
> On Wed, Nov 24, 2021 at 3:22 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 10:33:28AM +0800, Jason Wang wrote:
> > > On Wed, Nov 24, 2021 at 10:26 AM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Wed, Nov 24, 2021 at 9:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > > > >
> > > > > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > > > > > On Tue, Nov 23, 2021 at 10:25:20AM +0800, Jason Wang wrote:
> > > > > >> On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
> > > > > >> >
> > > > > >> > On Mon, 22 Nov 2021 14:25:26 +0800
> > > > > >> > Jason Wang <jasowang@redhat.com> wrote:
> > > > > >> >
> > > > > >> > > I think the fixes are:
> > > > > >> > >
> > > > > >> > > 1) fixing the vhost vsock
> > > > > >> > > 2) use suppress_used_validation=true to let vsock driver to validate
> > > > > >> > > the in buffer length
> > > > > >> > > 3) probably a new feature so the driver can only enable the validation
> > > > > >> > > when the feature is enabled.
> > > > > >> >
> > > > > >> > I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> > > > > >> > feature. Frankly the set of such bugs is device implementation
> > > > > >> > specific and it makes little sense to specify a feature bit
> > > > > >> > that says the device implementation claims to adhere to some
> > > > > >> > aspect of the specification. Also what would be the semantic
> > > > > >> > of not negotiating F_DEV_Y_FIXED_BUG_X?
> > > > > >>
> > > > > >> Yes, I agree. Rethink of the feature bit, it seems unnecessary,
> > > > > >> especially considering the driver should not care about the used
> > > > > >> length for tx.
> > > > > >>
> > > > > >> >
> > > > > >> > On the other hand I see no other way to keep the validation
> > > > > >> > permanently enabled for fixed implementations, and get around the problem
> > > > > >> > with broken implementations. So we could have something like
> > > > > >> > VHOST_USED_LEN_STRICT.
> > > > > >>
> > > > > >> It's more about a choice of the driver's knowledge. For vsock TX it
> > > > > >> should be fine. If we introduce a parameter and disable it by default,
> > > > > >> it won't be very useful.
> > > > > >>
> > > > > >> >
> > > > > >> > Maybe, we can also think of 'warn and don't alter behavior' instead of
> > > > > >> > 'warn' and alter behavior. Or maybe even not having such checks on in
> > > > > >> > production, but only when testing.
> > > > > >>
> > > > > >> I think there's an agreement that virtio drivers need more hardening,
> > > > > >> that's why a lot of patches were merged. Especially considering the
> > > > > >> new requirements came from confidential computing, smart NIC and
> > > > > >> VDUSE. For virtio drivers, enabling the validation may help to
> > > > > >>
> > > > > >> 1) protect the driver from the buggy and malicious device
> > > > > >> 2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
> > > > > >> 3) force the have a smart driver that can do the validation itself
> > > > > >> then we can finally remove the validation in the core
> > > > > >>
> > > > > >> So I'd like to keep it enabled.
> > > > > >>
> > > > > >> Thanks
> > > > > >
> > > > > > Let's see how far we can get. But yes, maybe we were too aggressive in
> > > > > > breaking things by default, a warning might be a better choice for a
> > > > > > couple of cycles.
> > > >
> > > > Ok, considering we saw the issues with balloons I think I can post a
> > > > patch to use warn instead. I wonder if we need to taint the kernel in
> > > > this case.
> > >
> > > Rethink this, consider we still have some time, I tend to convert the
> > > drivers to validate the length by themselves. Does this make sense?
> > >
> > > Thanks
> >
> > That's separate but let's stop crashing guests for people ASAP.
> 
> Ok, will post a patch soon.
> 
> Thanks

So let's err on the side of caution now, I will just revert for this
release.

For the next one I think a good plan is:
- no checks by default
- module param to check and warn
- keep adding validation in the drivers as appropriate

> >
> >
> > > >
> > > > >
> > > > > This series appears to break the virtio_balloon driver as well.
> > > > >
> > > > > The symptom is soft lockup warnings, eg:
> > > > >
> > > > >   INFO: task kworker/1:1:109 blocked for more than 614 seconds.
> > > > >         Not tainted 5.16.0-rc2-gcc-10.3.0 #21
> > > > >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > > > >   task:kworker/1:1     state:D stack:12496 pid:  109 ppid:     2 flags:0x00000800
> > > > >   Workqueue: events_freezable update_balloon_size_func
> > > > >   Call Trace:
> > > > >   [c000000003cef7c0] [c000000003cef820] 0xc000000003cef820 (unreliable)
> > > > >   [c000000003cef9b0] [c00000000001e238] __switch_to+0x1e8/0x2f0
> > > > >   [c000000003cefa10] [c000000000f0a00c] __schedule+0x2cc/0xb50
> > > > >   [c000000003cefae0] [c000000000f0a8fc] schedule+0x6c/0x140
> > > > >   [c000000003cefb10] [c00000000095b6c4] tell_host+0xe4/0x130
> > > > >   [c000000003cefba0] [c00000000095d234] update_balloon_size_func+0x394/0x3f0
> > > > >   [c000000003cefc70] [c000000000178064] process_one_work+0x2c4/0x5b0
> > > > >   [c000000003cefd10] [c0000000001783f8] worker_thread+0xa8/0x640
> > > > >   [c000000003cefda0] [c000000000185444] kthread+0x1b4/0x1c0
> > > > >   [c000000003cefe10] [c00000000000cee4] ret_from_kernel_thread+0x5c/0x64
> > > > >
> > > > > Similar backtrace reported here by Luis:
> > > > >
> > > > >   https://lore.kernel.org/lkml/YY2duTi0wAyAKUTJ@bombadil.infradead.org/
> > > > >
> > > > > Bisect points to:
> > > > >
> > > > >   # first bad commit: [939779f5152d161b34f612af29e7dc1ac4472fcf] virtio_ring: validate used buffer length
> > > > >
> > > > > Adding suppress used validation to the virtio balloon driver "fixes" it, eg.
> > > > >
> > > > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > > > index c22ff0117b46..a14b82ceebb2 100644
> > > > > --- a/drivers/virtio/virtio_balloon.c
> > > > > +++ b/drivers/virtio/virtio_balloon.c
> > > > > @@ -1150,6 +1150,7 @@ static unsigned int features[] = {
> > > > >  };
> > > > >
> > > > >  static struct virtio_driver virtio_balloon_driver = {
> > > > > +       .suppress_used_validation = true,
> > > > >         .feature_table = features,
> > > > >         .feature_table_size = ARRAY_SIZE(features),
> > > > >         .driver.name =  KBUILD_MODNAME,
> > > >
> > > > Looks good, we need a formal patch for this.
> > > >
> > > > And we need fix Qemu as well which advertise non zero used length for
> > > > inflate/deflate queue:
> > > >
> > > > static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > > > ...
> > > >         virtqueue_push(vq, elem, offset);
> > > >
> > > > Thanks
> > > >
> > > > >
> > > > >
> > > > > cheers
> > > > >
> >

