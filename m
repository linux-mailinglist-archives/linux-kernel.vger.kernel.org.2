Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BDC83F49F3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 13:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235813AbhHWLmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 07:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbhHWLmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 07:42:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA992C061757
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:41:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id x11so36478805ejv.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 04:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3/aDKv3231L9FChnRw0PgEXrYLvniJWf+a0yu+fQ/6o=;
        b=IJzB6+IbHHRkMlxR8AF+Vw8Onn6cQ2oI6MU/XCvspndQYkfz0wUWssmQKXn0RiC3rf
         v3GVlmTSPJEjQxALDbjelJxY/90FVUMA5npGAPabmO3OEOfEF7T74+/GC+EL9n0LVJqj
         /scJJIJZN5s/BIcQWdygZe9+DoQBPM5REwXJzBBDFeqZO3y0kfj7BjmPIwJZApAkkKlb
         mEeavil9u9+kt/VYlUIfU5xwT+slxJROrhMkFZ5dP15+5hXrtkB87Nzof3x5HTDamHXI
         Ttz7RyiRTHVPuk8mWw5h60+1VIoKFDDOEidRG2/shMOOBP82Vr9Zb+9GL873gwJ74+md
         gWnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3/aDKv3231L9FChnRw0PgEXrYLvniJWf+a0yu+fQ/6o=;
        b=rLauv5ql47r7p17VVGa4UHHnCyFHTnRO+APKDhRKNVgjrmbY9sAHCByWo30pnHM4T0
         uJ1HRYG1VfRAijO0H+voePmoH8A22DXOxClUgY50bxlnrweXY8JeI1GUYfbIi5PME+1C
         RfQNfjB4SFOK14BtYTw1WeGPiRaoJqTA3mAVLvDNDyAUOg1I5hcdMgqzhbPYW6UX6Hi+
         v5ml3UHWM51aM3g/BzXqmbeYYeRPeMZACg5mtJ1d+kytSRyQ28UDPamg6TJCNq/tixur
         /llb+rxJ/iRA+Tzbxar0Cb8YBUoyBqIlAnt/4oO0Tec48Bd7rWmzV0jpt+mni6wSOYTs
         C4/w==
X-Gm-Message-State: AOAM531zfgtRTx8OLS9YyYMh+omCqB3sYLC2b8lY1CRfJkxjjEQTAtf6
        PSUtdTvC/n9ei07pmFmZODtVJmP7h2tr3iZJlBxc
X-Google-Smtp-Source: ABdhPJyBit3aEh9LZ5GcV02+AWcdtN6P8P6wW+PvnXikrPVS38GetlRSsd0O9zWHcOmHow3639pIqgHWHs/CR9sKRZA=
X-Received: by 2002:a17:906:58c7:: with SMTP id e7mr34479271ejs.197.1629718915291;
 Mon, 23 Aug 2021 04:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com> <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com> <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com> <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
In-Reply-To: <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 19:41:44 +0800
Message-ID: <CACycT3sMga=-_e2DSui23iZBei1muniBzDf=g7O9FJCbxnYxnw@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 6:45 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
>
>
> On 8/23/2021 1:33 PM, Yongji Xie wrote:
> > On Mon, Aug 23, 2021 at 5:38 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>
> >> On 8/23/2021 12:27 PM, Yongji Xie wrote:
> >>> On Mon, Aug 23, 2021 at 5:04 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>> On 8/23/2021 11:35 AM, Yongji Xie wrote:
> >>>>> On Mon, Aug 23, 2021 at 4:07 PM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>>>> On 8/23/2021 7:31 AM, Yongji Xie wrote:
> >>>>>>> On Mon, Aug 23, 2021 at 7:17 AM Max Gurtovoy <mgurtovoy@nvidia.com> wrote:
> >>>>>>>> On 8/9/2021 1:16 PM, Xie Yongji wrote:
> >>>>>>>>> An untrusted device might presents an invalid block size
> >>>>>>>>> in configuration space. This tries to add validation for it
> >>>>>>>>> in the validate callback and clear the VIRTIO_BLK_F_BLK_SIZE
> >>>>>>>>> feature bit if the value is out of the supported range.
> >>>>>>>> This is not clear to me. What is untrusted device ? is it a buggy device ?
> >>>>>>>>
> >>>>>>> A buggy device, the devices in an encrypted VM, or a userspace device
> >>>>>>> created by VDUSE [1].
> >>>>>>>
> >>>>>>> [1] https://lore.kernel.org/kvm/20210818120642.165-1-xieyongji@bytedance.com/
> >>>>>> if it's a userspace device, why don't you fix its control path code
> >>>>>> instead of adding workarounds in the kernel driver ?
> >>>>>>
> >>>>> VDUSE kernel module would not touch (be aware of) the device specific
> >>>>> configuration space. It should be more reasonable to fix it in the
> >>>>> device driver. There is also some existing interface (.validate()) for
> >>>>> doing that.
> >>>> who is emulating the device configuration space ?
> >>>>
> >>> A userspace daemon will initialize the device configuration space and
> >>> pass the contents to the VDUSE kernel module. The VDUSE kernel module
> >>> will handle the access of the config space from the virtio device
> >>> driver, but it doesn't need to know the contents (although we can know
> >>> that).
> >> So you add a workaround in the guest kernel drivers instead of checking
> >> these quirks in the hypervisor ?
> >>
> > I didn't see any problem adding this validation in the device driver.
> >
> >> VDUSE kernel should enforce the security for the devices it
> >> emulates/presents to the VM.
> >>
> > I agree that the VDUSE kernel should enforce the security for the
> > emulated devices. But I still think the virtio device driver should
> > handle this case since nobody can make sure the device can always set
> > the correct value. Adding this validation would be helpful.
>
> It helpful if there is a justification for this.
>
> In this case, no such HW device exist and the only device that can cause
> this trouble today is user space VDUSE device that must be validated by
> the emulation VDUSE kernel driver.
>
> Otherwise, will can create 1000 commit like this in the virtio level
> (for example for each feature for each virtio device).
>

Maybe not. Most of the configuration fields have already been
validated at the virtio level.

> >
> >>>>> And regardless of userspace device, we still need to fix it for other cases.
> >>>> which cases ? Do you know that there is a buggy HW we need to workaround ?
> >>>>
> >>> No, there isn't now. But this could be a potential attack surface if
> >>> the host doesn't trust the device.
> >> If the host doesn't trust a device, why it continues using it ?
> >>
> > IIUC this is the case for the encrypted VMs.
>
> what do you mean encrypted VM ?
>

The guest memory is encrypted, the host can not read or write any
guest memory not explicitly shared with it. In this case, the guest
doesn't trust the host. There are already some efforts [1] [2] to
protect this kind of guest from untrusted devices.

[1] https://lwn.net/ml/linux-kernel/20210421032117.5177-1-jasowang@redhat.com/
[2] https://www.spinics.net/lists/linux-virtualization/msg50182.html

> And how this small patch causes a VM to be 100% encryption supported ?
>

I'm not sure if there will be some ways to leak data in an encrypted
VM with the invalid block size.

Thanks,
Yongji
