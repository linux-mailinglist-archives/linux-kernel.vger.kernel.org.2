Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800E93F4DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 18:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhHWQDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 12:03:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33087 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230241AbhHWQDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 12:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629734585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VGHv+t7XJoBwzuDgFH5TfVqMsvYX/VooC0Y/PX4tAJg=;
        b=G7DcbcK+yr8woorkZOtfubxTkFMR3gHlASe4k8l07BFzJ2E2nrHjwVyuTEhnyvmfsFMFc2
        MEpzZ6nvo9WZzMtpf7TveF6PwL+97eIlORiaKKwF5kYPQAFFTN8Rew4UUfxoP74eg0Rqbm
        GWsGqITtCEN6wKeK2cCdjve1ikZGgQE=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-GT8HftJuOSShlcHCagImGA-1; Mon, 23 Aug 2021 12:03:03 -0400
X-MC-Unique: GT8HftJuOSShlcHCagImGA-1
Received: by mail-ed1-f70.google.com with SMTP id s25-20020a50d499000000b003c1a8573042so3274244edi.11
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 09:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VGHv+t7XJoBwzuDgFH5TfVqMsvYX/VooC0Y/PX4tAJg=;
        b=scb3Q6ZVqAPafNOo7TF69nOQkFBSzU5HrjyqTycxjbEQxdXHaiz55b1ng49uhPgWEu
         m/g8M4BH7nZ8PMQ+if77oXMJToccct8GxrJlJdeiLj3Eq0V1b+qT0JqwQE0R0a6YRzqK
         T9fTcZwHyINeuT+4HAU9YsTSkHZC1PxEM4JMo5eRneGK0eW3RzsU3/GIqkstKetHX5kO
         uihInh+iYJvCBNZ2AGd+j7NmQ3IuePz1OrC6m5oHGK0dFe5i4F5Vt6DfEN3nopr0J15G
         LOg6/7/YYlA2GA+TuKI25ibob1GuxzPkxSgK4QDg/IweEhAYOQ8Kq4S8gX+XHnDbIxG/
         q+vQ==
X-Gm-Message-State: AOAM530ZhlLtDvUPBZbVE60/FxjT6qonITCIVmO4ZF7ZbbUuLgztY/K3
        V4q7kydtM61qgrBKhEBAs9FLbSLf7ufQHE7mahVXbxjLDALwMHYuf2qMvbPArkD+g0AZFgXLjte
        Drcyg3P+31syGgp5dl+ITDJUG
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr36533886ejo.216.1629734582686;
        Mon, 23 Aug 2021 09:03:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxxp+uh6vvWHOggK+XZVQUmVCS8/2sf2bFFTaajhAycYy86aqPRfIaBgTC4eogFB5ay7zzGmA==
X-Received: by 2002:a17:906:7d83:: with SMTP id v3mr36533860ejo.216.1629734582438;
        Mon, 23 Aug 2021 09:03:02 -0700 (PDT)
Received: from redhat.com ([2.55.137.225])
        by smtp.gmail.com with ESMTPSA id f8sm9832100edy.57.2021.08.23.09.03.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 09:03:01 -0700 (PDT)
Date:   Mon, 23 Aug 2021 12:02:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
Message-ID: <20210823120229-mutt-send-email-mst@kernel.org>
References: <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com>
 <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com>
 <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com>
 <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
 <20210823080952-mutt-send-email-mst@kernel.org>
 <CACycT3sR6Y5XiK6_xX2ni8w9mqmSxkrb639ByDzV2W+Jz79Dnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3sR6Y5XiK6_xX2ni8w9mqmSxkrb639ByDzV2W+Jz79Dnw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 08:40:30PM +0800, Yongji Xie wrote:
> On Mon, Aug 23, 2021 at 8:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> > > It helpful if there is a justification for this.
> > >
> > > In this case, no such HW device exist and the only device that can cause
> > > this trouble today is user space VDUSE device that must be validated by the
> > > emulation VDUSE kernel driver.
> > >
> > > Otherwise, will can create 1000 commit like this in the virtio level (for
> > > example for each feature for each virtio device).
> >
> > Yea, it's a lot of work but I don't think it's avoidable.
> >
> > > >
> > > > > > > > And regardless of userspace device, we still need to fix it for other cases.
> > > > > > > which cases ? Do you know that there is a buggy HW we need to workaround ?
> > > > > > >
> > > > > > No, there isn't now. But this could be a potential attack surface if
> > > > > > the host doesn't trust the device.
> > > > > If the host doesn't trust a device, why it continues using it ?
> > > > >
> > > > IIUC this is the case for the encrypted VMs.
> > >
> > > what do you mean encrypted VM ?
> > >
> > > And how this small patch causes a VM to be 100% encryption supported ?
> > >
> > > > > Do you suggest we do these workarounds in all device drivers in the kernel ?
> > > > >
> > > > Isn't it the driver's job to validate some unreasonable configuration?
> > >
> > > The check should be in different layer.
> > >
> > > Virtio blk driver should not cover on some strange VDUSE stuff.
> >
> > Yes I'm not convinced VDUSE is a valid use-case. I think that for
> > security and robustness it should validate data it gets from userspace
> > right there after reading it.
> > But I think this is useful for the virtio hardening thing.
> > https://lwn.net/Articles/865216/
> >
> > Yongji - I think the commit log should be much more explicit that
> > this is hardening. Otherwise people get confused and think this
> > needs a CVE or a backport for security.
> >
> 
> OK, do I need to send a v6? This patch seems to be already merged into
> Linus's tree.
> 
> Thanks,
> Yongji

No, it's a comment for the future - I assume you will keep adding this
kind of validation in other places.

-- 
MST

