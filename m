Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B203F5F56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237500AbhHXNji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbhHXNjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:39:36 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7082FC061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:38:52 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id d11so44353702eja.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 06:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0i/EAJiVM/GK2DpVQdqUJjnCvCVwMYUlwKwDqof3koc=;
        b=BotU59b9aw2PRb8fDkqI4VT5ehmjVoFI3/buS/muYikLgOclIpxR/QuBaEezPwonJw
         KBcCPsRlH1UQzlGS09llDuNJcLUQK9N2M6Ko9qgUUx6gks1cXYX2ldPp+bh19w8IIwxI
         fv8zWJo9Of10xWaktniSF/xfy7ioZck31+Mj+lVT8/5zQ7QPhlKFq3G+arr4bZzXBBAv
         ry1VqTUYhEzH1CmGV8M/2JWuPS6Dd97SHKmoDiFP+yI/R7uMZvuJHaKdC8Ksw2Ms+oVk
         WXwu+KQmVpXxL+VWE5PUCWlhMrtKmfpAqP4QQv2l8p8quDzT3iuOSXOBDJETC8DODdDL
         YO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0i/EAJiVM/GK2DpVQdqUJjnCvCVwMYUlwKwDqof3koc=;
        b=R8sHwvnC6jIgR04tXxTb7fHQAb2OmWhaWBsSw6M34vjmCzbwZoMG2vOfqDHgBX+Qox
         KlA69To32Sa0JQdR63d/FzGnH6uRNVi+e9gW1sqw8bRrcpyEujC8Cq7af8zZmJjPWqCn
         fuvW7vQIeqdrNUR8MZAms73IA2dLrya1qEhn/AyI8opv6STd3c5rMWZNVpH18SYS1DnB
         7RtE77CXQGlbih4KW+nBg2fsl5Y6BRnpRDAetIQyBxaeFg0oTzHO+sqstVMMTFtX3mlM
         h8RL6Zr3rhCRGa/e/oB2aJyw1FPzqp5pGtMkyKOvxV8HpYQMoaPrmufTdH2/8enEkcS4
         IiSw==
X-Gm-Message-State: AOAM530vXbDfAYRpmQ5IdiXgbbLqOUzACzgUMEF4iSGSQn4L/oAyntHT
        rI7xZBweM58xJKjEJ4wkWcIgpYadujff5ztYsldA
X-Google-Smtp-Source: ABdhPJwepSTrfBWJ1QkAgJibG6SflWaX9hVIlVBo+y0PsaDHAEUg2kQpaGNb05zqr5ZhSuPP0VVx+1w5xmdNY/Xchw4=
X-Received: by 2002:a17:906:454b:: with SMTP id s11mr41357598ejq.1.1629812330934;
 Tue, 24 Aug 2021 06:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com> <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com> <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com> <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com> <20210823080952-mutt-send-email-mst@kernel.org>
 <b9636f39-1237-235e-d1fe-8f5c0d422c7d@nvidia.com> <CACGkMEuc0C0=te3O6z76BniiuHJgfxHnaAZoX=+PCy4Y7DxRow@mail.gmail.com>
 <c238448b-9915-a4fc-4ec8-c807a06b359f@nvidia.com> <CACycT3vCfydrCq8vR9-WMq+-KDJx1Z+q1saOmp0yW0TRvLrqGg@mail.gmail.com>
 <fe2d623c-c0aa-a27e-fbe3-2c012b863140@nvidia.com>
In-Reply-To: <fe2d623c-c0aa-a27e-fbe3-2c012b863140@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 24 Aug 2021 21:38:40 +0800
Message-ID: <CACycT3s=PBbwsFYtQ+afuXgoKLZYsCXaR_fu02TyfmYKOP9GaQ@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 9:30 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/24/2021 3:52 PM, Yongji Xie wrote:
> > On Tue, Aug 24, 2021 at 6:11 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 8/24/2021 5:47 AM, Jason Wang wrote:
> >>> On Tue, Aug 24, 2021 at 6:31 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>> On 8/23/2021 3:13 PM, Michael S. Tsirkin wrote:
> >>>>> On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> >>>>>> It helpful if there is a justification for this.
> >>>>>>
> >>>>>> In this case, no such HW device exist and the only device that can cause
> >>>>>> this trouble today is user space VDUSE device that must be validated by the
> >>>>>> emulation VDUSE kernel driver.
> >>>>>>
> >>>>>> Otherwise, will can create 1000 commit like this in the virtio level (for
> >>>>>> example for each feature for each virtio device).
> >>>>> Yea, it's a lot of work but I don't think it's avoidable.
> >>>>>
> >>>>>>>>>>> And regardless of userspace device, we still need to fix it for other cases.
> >>>>>>>>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
> >>>>>>>>>>
> >>>>>>>>> No, there isn't now. But this could be a potential attack surface if
> >>>>>>>>> the host doesn't trust the device.
> >>>>>>>> If the host doesn't trust a device, why it continues using it ?
> >>>>>>>>
> >>>>>>> IIUC this is the case for the encrypted VMs.
> >>>>>> what do you mean encrypted VM ?
> >>>>>>
> >>>>>> And how this small patch causes a VM to be 100% encryption supported ?
> >>>>>>
> >>>>>>>> Do you suggest we do these workarounds in all device drivers in the kernel ?
> >>>>>>>>
> >>>>>>> Isn't it the driver's job to validate some unreasonable configuration?
> >>>>>> The check should be in different layer.
> >>>>>>
> >>>>>> Virtio blk driver should not cover on some strange VDUSE stuff.
> >>>>> Yes I'm not convinced VDUSE is a valid use-case. I think that for
> >>>>> security and robustness it should validate data it gets from userspace
> >>>>> right there after reading it.
> >>>>> But I think this is useful for the virtio hardening thing.
> >>>>> https://lwn.net/Articles/865216/
> >>>> I don't see how this change is assisting confidential computing.
> >>>>
> >>>> Confidential computingtalks about encrypting guest memory from the host,
> >>>> and not adding some quirks to devices.
> >>> In the case of confidential computing, the hypervisor and hard device
> >>> is not in the trust zone. It means the guest doesn't trust the cloud
> >>> vendor.
> >> Confidential computing protects data during processing ("in-use" data).
> >>
> >> Nothing to do with virtio feature negotiation.
> >>
> > But if a misbehaving device can corrupt the guest memory, I think it
> > should be avoided.
>
> So don't say it's related to confidential computing, and fix it in the
> VDUSE kernel driver in the hypervisor.
>

What I mean is in confidential computing cases. An untrusted device
might corrupt the protected guest memory, it should be avoided.

Thanks,
Yongji
