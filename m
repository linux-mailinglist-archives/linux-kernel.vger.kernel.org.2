Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF5973814F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 03:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234780AbhEOBbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 21:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbhEOBbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 21:31:25 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A1CC061756
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 18:30:13 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id c17so309953vke.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 18:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xnKdVLmA6JV4gVRXBLAZ9YZgzU3RbAwYHw7sjvnZr2M=;
        b=VwV6MZUCTsR/21K6Nf4JfACfINmxMfGCBHGmn98b0KfWsmCZrSQ2JpyT8Bdp68jt86
         sDNDN7SbuawvPtvhjP9wKtwRygwgJzn0tfMmDDcZ+h4vVw6XJcnXLyVLstDDSixUw5Wg
         a/R/uOdLzy1G4+2g8s+miyc6pGFSjC8j19gPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xnKdVLmA6JV4gVRXBLAZ9YZgzU3RbAwYHw7sjvnZr2M=;
        b=GGKk5XK50/J/2VMKicEYag8PqIvChZRsQg5KPfunQQDl2gYW7hp85Hcj7DvFgOWq3w
         mFbQBTWbo92YvvMtJXJDuajAe8ipN6KmVIuJJROeZZPrP4B2D02TRdk+oMKs4zDH85eJ
         zV/bNIFVrQDEUfPx1TcFw6tpQl9WYHeRgLDXNkrozf8sJjLLCqmuihWP9mpCiParugvj
         H8b2JBVfZcdt06r/MKSc9Wdor+t2FV99fmLvSs2okCaMkyuPm7vu6+rDpSO0F4d1xIHQ
         HgJsdl0MRZLHyjmY0NOqo/gcYbwNZll3DbyrpUFA0h6kginLjXu28ILbBGiU3RYbOEhx
         xnJw==
X-Gm-Message-State: AOAM5321Vx31gWNskw1ULD62LozPOL0EKTajnFRoAfIyYVLen+Rn5SVh
        O4UVLjNKkgNk3F5nm6+a+x/lGew8pFxDXPL2ffM6hw==
X-Google-Smtp-Source: ABdhPJx3fj4K/0hK+tGEFHOV0fBGKfWSZTp6om4TbcQ6XfQmzQb1l75qCqJGUbHXGY2nyNG5LbOZQsO3ewg/M0mqnt4=
X-Received: by 2002:a1f:c704:: with SMTP id x4mr2701192vkf.9.1621042210632;
 Fri, 14 May 2021 18:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210421052855.1279713-1-drinkcat@chromium.org>
 <c91746ce-88b6-5612-74a5-74600c7761e8@baylibre.com> <CAAEAJfD3i+L4w1NuE5pUkMuH=R3CfBztDn-ZLcYR=onkcZ4Gxg@mail.gmail.com>
 <373d0803-8658-9413-2f51-1e9804c39126@baylibre.com> <ce401ca2-e285-4fcf-0583-c1dae94dba6a@arm.com>
In-Reply-To: <ce401ca2-e285-4fcf-0583-c1dae94dba6a@arm.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Sat, 15 May 2021 09:29:59 +0800
Message-ID: <CANMq1KDwVdhw+4UnshoG8Ex5Axyhk1d2WeUxbL=mJTGRsAMJGA@mail.gmail.com>
Subject: Re: [PATCH v13 0/4] drm/panfrost: Add support for mt8183 GPU
To:     Steven Price <steven.price@arm.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        devicetree <devicetree@vger.kernel.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Fei Shao <fshao@chromium.org>, David Airlie <airlied@linux.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kristian Kristensen <hoegsberg@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 14, 2021 at 11:27 PM Steven Price <steven.price@arm.com> wrote:
> [snip]
> >>> Seems this version is ready to be applied if we get a review on the DT ?
> >>>
> >>> Mathias ? could you have a look ?
> >>>
> >>
> >> Given Rob has Acked the DT bindings, I think it's OK to apply patches
> >> 1, 3 and 4 via drm-misc, letting Mediatek people sort out the DT changes.
> >>
> >> My two unsolicited cents :-)
>
> You make a convincing point - and if everyone is happy for the DT
> changes to be handled separately I don't see a reason for the other
> patches to be held up.
>
> > Yeah sure, is there a panfrost maintainer in the room ? I can apply them if you ack me.
>
> I seem to be applying most Panfrost changes these days, so I'll save you
> the effort and push 1,3,4 to drm-misc-next.

Thanks Steve!!

>
> Thanks,
>
> Steve
