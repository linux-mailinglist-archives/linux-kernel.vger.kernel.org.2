Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B0C45B544
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbhKXHZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:25:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:50844 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229977AbhKXHZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:25:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637738555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E6WFGjVQQFfu4/xYy6Ry5Q73f/AHod2mIktGVdEbY9U=;
        b=F3kRvHYtsnNZlqm47OyLqEQjf5QaTZNnQnmNpsDb8FMqKaIvRLFSPIJjTZMMAaSPyPl/nr
        80KY+XT7yxMmGYlsL7UIfl2jtulKjKLdA5PS5kIjKokXHBvVXZDcuLeKQNcbYfgOTxRIIP
        PaMZsBZylMTfArNUKElSahYEqedvb18=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-497-zYqc5WRyOdCDr9m70bzUsA-1; Wed, 24 Nov 2021 02:22:34 -0500
X-MC-Unique: zYqc5WRyOdCDr9m70bzUsA-1
Received: by mail-wr1-f70.google.com with SMTP id v18-20020a5d5912000000b001815910d2c0so221445wrd.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:22:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E6WFGjVQQFfu4/xYy6Ry5Q73f/AHod2mIktGVdEbY9U=;
        b=iyGLNd3ZqCSCcXkkZ9fJE6vNLQlZk7wbEa3NTJRJO/LGkBIAQZqh2oSieSOezyuaWb
         +3qNvwpEuxP6e4ma8DQP93OP6mCChwICoAZeoPfsFrkjASheGmoDBk1EHRbHek47ZJu8
         m8UIe3XVZyBiIV3S+mY9L9VQbb7GY0kCzkgvUSEUD1BYuS6CwJsXhs/jivlNubONbPir
         a/Na4FxUxboYBSfWP13wJsj1DAMy5b0ctlh6D3WiOusLO/WjShJNY8K6y1xNRBs2fRi4
         euS6X9TdAtAwQbtcPDnkPE2mzny3vjVsAEeYjilWOa8j+mu5ZJQjy8UABv5SAN0UOpa7
         urdA==
X-Gm-Message-State: AOAM533fzegTu6PRicoCJ65zBKbGGjPy4ROAK+pP4yRWRpYB14KQxaQo
        9Dz5SSv3oFNpg1lzrHSCnYhsKBK1X/ZDtsl2KgMEs1eu6hf+LP4vBMwUIhBGK3hAIovLkno+1Aj
        TDMJGyy49Y6CZX672HxzLUJEA
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr11627126wmm.189.1637738553040;
        Tue, 23 Nov 2021 23:22:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxQKvKPPFvku25rYvyd1PlwJ61cLBLLr0rKP1rK41xVNhHhjqYQuS1a6Sg34h+WdPq64mfPTQ==
X-Received: by 2002:a05:600c:4154:: with SMTP id h20mr11627097wmm.189.1637738552824;
        Tue, 23 Nov 2021 23:22:32 -0800 (PST)
Received: from redhat.com ([2.55.144.93])
        by smtp.gmail.com with ESMTPSA id j134sm3740552wmj.3.2021.11.23.23.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 23:22:32 -0800 (PST)
Date:   Wed, 24 Nov 2021 02:22:28 -0500
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
Message-ID: <20211124022101-mutt-send-email-mst@kernel.org>
References: <CACGkMEtja2TPC=ujgMrpaPmdsy+zHowbBTvPj8k7nm_+zB8vig@mail.gmail.com>
 <20211122063518.37929c01.pasic@linux.ibm.com>
 <20211122064922.51b3678e.pasic@linux.ibm.com>
 <CACGkMEu+9FvMsghyi55Ee5BxetP-YK9wh2oaT8OgLiY5+tV0QQ@mail.gmail.com>
 <20211122212352.4a76232d.pasic@linux.ibm.com>
 <CACGkMEtmhwDEAvMuMhQEUB-b+=n713pVvjyct8QAqMUk1H-A-g@mail.gmail.com>
 <20211123055906-mutt-send-email-mst@kernel.org>
 <87zgpupcga.fsf@mpe.ellerman.id.au>
 <CACGkMEteDZJVM8j5pir7_Hcn6Oq=tKbcg4DUiEQBGm5Kg9w30w@mail.gmail.com>
 <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEs086P=qfMieMQ3wPhcarsdO++iRTwVHtN-4cgKLm8opA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 10:33:28AM +0800, Jason Wang wrote:
> On Wed, Nov 24, 2021 at 10:26 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 9:30 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > > > On Tue, Nov 23, 2021 at 10:25:20AM +0800, Jason Wang wrote:
> > > >> On Tue, Nov 23, 2021 at 4:24 AM Halil Pasic <pasic@linux.ibm.com> wrote:
> > > >> >
> > > >> > On Mon, 22 Nov 2021 14:25:26 +0800
> > > >> > Jason Wang <jasowang@redhat.com> wrote:
> > > >> >
> > > >> > > I think the fixes are:
> > > >> > >
> > > >> > > 1) fixing the vhost vsock
> > > >> > > 2) use suppress_used_validation=true to let vsock driver to validate
> > > >> > > the in buffer length
> > > >> > > 3) probably a new feature so the driver can only enable the validation
> > > >> > > when the feature is enabled.
> > > >> >
> > > >> > I'm not sure, I would consider a F_DEV_Y_FIXED_BUG_X a perfectly good
> > > >> > feature. Frankly the set of such bugs is device implementation
> > > >> > specific and it makes little sense to specify a feature bit
> > > >> > that says the device implementation claims to adhere to some
> > > >> > aspect of the specification. Also what would be the semantic
> > > >> > of not negotiating F_DEV_Y_FIXED_BUG_X?
> > > >>
> > > >> Yes, I agree. Rethink of the feature bit, it seems unnecessary,
> > > >> especially considering the driver should not care about the used
> > > >> length for tx.
> > > >>
> > > >> >
> > > >> > On the other hand I see no other way to keep the validation
> > > >> > permanently enabled for fixed implementations, and get around the problem
> > > >> > with broken implementations. So we could have something like
> > > >> > VHOST_USED_LEN_STRICT.
> > > >>
> > > >> It's more about a choice of the driver's knowledge. For vsock TX it
> > > >> should be fine. If we introduce a parameter and disable it by default,
> > > >> it won't be very useful.
> > > >>
> > > >> >
> > > >> > Maybe, we can also think of 'warn and don't alter behavior' instead of
> > > >> > 'warn' and alter behavior. Or maybe even not having such checks on in
> > > >> > production, but only when testing.
> > > >>
> > > >> I think there's an agreement that virtio drivers need more hardening,
> > > >> that's why a lot of patches were merged. Especially considering the
> > > >> new requirements came from confidential computing, smart NIC and
> > > >> VDUSE. For virtio drivers, enabling the validation may help to
> > > >>
> > > >> 1) protect the driver from the buggy and malicious device
> > > >> 2) uncover the bugs of the devices (as vsock did, and probably rpmsg)
> > > >> 3) force the have a smart driver that can do the validation itself
> > > >> then we can finally remove the validation in the core
> > > >>
> > > >> So I'd like to keep it enabled.
> > > >>
> > > >> Thanks
> > > >
> > > > Let's see how far we can get. But yes, maybe we were too aggressive in
> > > > breaking things by default, a warning might be a better choice for a
> > > > couple of cycles.
> >
> > Ok, considering we saw the issues with balloons I think I can post a
> > patch to use warn instead. I wonder if we need to taint the kernel in
> > this case.
> 
> Rethink this, consider we still have some time, I tend to convert the
> drivers to validate the length by themselves. Does this make sense?
> 
> Thanks

That's separate but let's stop crashing guests for people ASAP.


> >
> > >
> > > This series appears to break the virtio_balloon driver as well.
> > >
> > > The symptom is soft lockup warnings, eg:
> > >
> > >   INFO: task kworker/1:1:109 blocked for more than 614 seconds.
> > >         Not tainted 5.16.0-rc2-gcc-10.3.0 #21
> > >   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > >   task:kworker/1:1     state:D stack:12496 pid:  109 ppid:     2 flags:0x00000800
> > >   Workqueue: events_freezable update_balloon_size_func
> > >   Call Trace:
> > >   [c000000003cef7c0] [c000000003cef820] 0xc000000003cef820 (unreliable)
> > >   [c000000003cef9b0] [c00000000001e238] __switch_to+0x1e8/0x2f0
> > >   [c000000003cefa10] [c000000000f0a00c] __schedule+0x2cc/0xb50
> > >   [c000000003cefae0] [c000000000f0a8fc] schedule+0x6c/0x140
> > >   [c000000003cefb10] [c00000000095b6c4] tell_host+0xe4/0x130
> > >   [c000000003cefba0] [c00000000095d234] update_balloon_size_func+0x394/0x3f0
> > >   [c000000003cefc70] [c000000000178064] process_one_work+0x2c4/0x5b0
> > >   [c000000003cefd10] [c0000000001783f8] worker_thread+0xa8/0x640
> > >   [c000000003cefda0] [c000000000185444] kthread+0x1b4/0x1c0
> > >   [c000000003cefe10] [c00000000000cee4] ret_from_kernel_thread+0x5c/0x64
> > >
> > > Similar backtrace reported here by Luis:
> > >
> > >   https://lore.kernel.org/lkml/YY2duTi0wAyAKUTJ@bombadil.infradead.org/
> > >
> > > Bisect points to:
> > >
> > >   # first bad commit: [939779f5152d161b34f612af29e7dc1ac4472fcf] virtio_ring: validate used buffer length
> > >
> > > Adding suppress used validation to the virtio balloon driver "fixes" it, eg.
> > >
> > > diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> > > index c22ff0117b46..a14b82ceebb2 100644
> > > --- a/drivers/virtio/virtio_balloon.c
> > > +++ b/drivers/virtio/virtio_balloon.c
> > > @@ -1150,6 +1150,7 @@ static unsigned int features[] = {
> > >  };
> > >
> > >  static struct virtio_driver virtio_balloon_driver = {
> > > +       .suppress_used_validation = true,
> > >         .feature_table = features,
> > >         .feature_table_size = ARRAY_SIZE(features),
> > >         .driver.name =  KBUILD_MODNAME,
> >
> > Looks good, we need a formal patch for this.
> >
> > And we need fix Qemu as well which advertise non zero used length for
> > inflate/deflate queue:
> >
> > static void virtio_balloon_handle_output(VirtIODevice *vdev, VirtQueue *vq)
> > ...
> >         virtqueue_push(vq, elem, offset);
> >
> > Thanks
> >
> > >
> > >
> > > cheers
> > >

