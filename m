Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014473F4AE1
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbhHWMl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235881AbhHWMlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:41:25 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F64C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:40:42 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n27so4759207eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r6APdQhr7sUCo19xQL1I3KmdT4fVbUFVO7ySppiCmx4=;
        b=Xf39zK/oa9Y2pG9pzE8MK4eLgo9Ar70Ug/5kBF3kWLew+nNhq/aC+PjcrbBd/36xLq
         +bc2INpqCIKlExGlDvU03Jr1ppO+ce1lZk3+zTovH4/9+RLV8NJ9ycipiMaSIzHdBuSX
         k0aYn0mX/exWjWMvZHtkpNGQPv9TJi4h5FpFa89cc5VlIC+oH73+UMDjAYgvRROUiCh5
         VuGxVr0ZLFHOVUAMCDq0CEicARDpMXz8eyHYsJwAp0c2wlF8CfhRDDoB4ICDMX5ZwAhZ
         UOGY/Z3SYOpYGkBn5sfjYQHiR97gmO8vRuCSh7xhRAjGqRsNtir6pxM6WXoYHj7XVUp4
         u6ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r6APdQhr7sUCo19xQL1I3KmdT4fVbUFVO7ySppiCmx4=;
        b=PbVEmX1jGD9Pax115UVa2Tg6xGZKDBHGqJkfeUo28HLJTs6xs95Wt60FIKYujgxahn
         8jZGOa8s4e86j7mPL9IQYxN87laxaRy1HAKtC0b1pQaPhplCo7NJO40V/1M1Se3VmQBF
         ewzq0bYhEZN58pLNAFRJpUnJe8pysoYvOcaPGMoPTmh0E204u8WYBFXMdPBgza0sk/NA
         WEpOUj9mPjKJVqokiV4ZqWeSdkO0Cf67BPop2HOSR06bb4iohZEHjlvws/29TQb2xuBm
         D6mfuYSovynmqZ2EJ4HSWPenKKtktPe7pfI40Tt71Hz34tfQLHYNQU2FrPFQkvbHZKtR
         P4dQ==
X-Gm-Message-State: AOAM533jwxUOOq2srGIATqlAsEElrTPRUZdZM8thZRIxpQ1LbpTCBTj4
        Hi5rYzxQd2hP4dppPEYF/9KrnevfT8ZZfz13J9uL
X-Google-Smtp-Source: ABdhPJx2MQQpZtRWB29HJcYwEhirJQyHrQDqqBzi6O4/Rfx7P41vY6YxsKFmFB/jy03hig0jPIok8UO2hsF5QN+Dbkw=
X-Received: by 2002:a17:906:b25a:: with SMTP id ce26mr3732692ejb.174.1629722441252;
 Mon, 23 Aug 2021 05:40:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210809101609.148-1-xieyongji@bytedance.com> <e6ab104e-a18b-3f17-9cd8-6a6b689b56b4@nvidia.com>
 <CACycT3sNRRBrSTJOUr=POc-+BOAgfT7+qgFE2BLBTGJ30cZVsQ@mail.gmail.com>
 <dc8e7f6d-9aa6-58c6-97f7-c30391aeac5d@nvidia.com> <CACycT3v83sVvUWxZ-+SDyeXMPiYd0zi5mtmg8AkXYgVLxVpTvA@mail.gmail.com>
 <06af4897-7339-fca7-bdd9-e0f9c2c6195b@nvidia.com> <CACycT3usFyVyBuJBz2n5TRPveKKUXTqRDMo76VkGu7NCowNmvg@mail.gmail.com>
 <6d6154d7-7947-68be-4e1e-4c1d0a94b2bc@nvidia.com> <CACycT3sxeUQa7+QA0CAx47Y3tVHKigcQEfEHWi04aWA5xbgA9A@mail.gmail.com>
 <7f0181d7-ff5c-0346-66ee-1de3ed23f5dd@nvidia.com> <20210823080952-mutt-send-email-mst@kernel.org>
In-Reply-To: <20210823080952-mutt-send-email-mst@kernel.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 23 Aug 2021 20:40:30 +0800
Message-ID: <CACycT3sR6Y5XiK6_xX2ni8w9mqmSxkrb639ByDzV2W+Jz79Dnw@mail.gmail.com>
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config space
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Max Gurtovoy <mgurtovoy@nvidia.com>,
        Jason Wang <jasowang@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-block@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 23, 2021 at 8:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Mon, Aug 23, 2021 at 01:45:31PM +0300, Max Gurtovoy wrote:
> > It helpful if there is a justification for this.
> >
> > In this case, no such HW device exist and the only device that can cause
> > this trouble today is user space VDUSE device that must be validated by the
> > emulation VDUSE kernel driver.
> >
> > Otherwise, will can create 1000 commit like this in the virtio level (for
> > example for each feature for each virtio device).
>
> Yea, it's a lot of work but I don't think it's avoidable.
>
> > >
> > > > > > > And regardless of userspace device, we still need to fix it for other cases.
> > > > > > which cases ? Do you know that there is a buggy HW we need to workaround ?
> > > > > >
> > > > > No, there isn't now. But this could be a potential attack surface if
> > > > > the host doesn't trust the device.
> > > > If the host doesn't trust a device, why it continues using it ?
> > > >
> > > IIUC this is the case for the encrypted VMs.
> >
> > what do you mean encrypted VM ?
> >
> > And how this small patch causes a VM to be 100% encryption supported ?
> >
> > > > Do you suggest we do these workarounds in all device drivers in the kernel ?
> > > >
> > > Isn't it the driver's job to validate some unreasonable configuration?
> >
> > The check should be in different layer.
> >
> > Virtio blk driver should not cover on some strange VDUSE stuff.
>
> Yes I'm not convinced VDUSE is a valid use-case. I think that for
> security and robustness it should validate data it gets from userspace
> right there after reading it.
> But I think this is useful for the virtio hardening thing.
> https://lwn.net/Articles/865216/
>
> Yongji - I think the commit log should be much more explicit that
> this is hardening. Otherwise people get confused and think this
> needs a CVE or a backport for security.
>

OK, do I need to send a v6? This patch seems to be already merged into
Linus's tree.

Thanks,
Yongji
