Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03C003F4BB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 15:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbhHWNaa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 09:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233514AbhHWNa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 09:30:28 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B1AC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 06:29:46 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id n27so5088075eja.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 06:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZzAS6d5SoNpyFEOG1nN+QHEZYRPRGiJlkEZo4kbWHVc=;
        b=m9Sqr/u36/VD+Jg7yl6lLtMzyqT1jvN43qYFNLC4a7VwtFk5TN3JC84YhZqogex3uk
         aVMy+BBAECZePD6wm8ruVnWMgNqJFKxVgKqexq637wqLGF2JO56mWqEYyyMjHoCJzcjR
         B5nKQ5hwfVo6/fRjLPM+ANZStbB2LZ7Hk7tf+BioeAmQ2MGdUI9WzZ7SMkCjOQp7/d5n
         6uamUuo6H4usXXoKdmem6haJToJuLR5g0dHTifTnSw27+8A8byrHZdPy2s1A4InTlXs5
         CAaNJwb5GRXfhzMIQK8pIVbQpLM3EGfGCpezbJ5wl5Bfxd1/wY+2VKAkMsXlwGPYcRYm
         K6sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZzAS6d5SoNpyFEOG1nN+QHEZYRPRGiJlkEZo4kbWHVc=;
        b=QCu6AXuihSJJUkYPreTk9zpktkTs8DdsW68YnER8XEPvrC/ePeTWoauOl9jlhpjCbn
         L45bs9sbSAIIWmapCtYRQxPQy2kfzO7pOqWA/pTMoTGooU145W6TM/CBF5P2y5BYThuw
         jL9fE/lY7jjTzmAgjTNlTqsAtWxb2nX/KoU0F+D2KAoUJ3koHJi55VIQU5wZ0aw2KXA9
         8znOazv6rruJmnqyivuOgY51MERMONPYGWwJWkmVwSOreKSpnUa4xYN9nBRCjvH1gtCG
         FTpjpcuxMORnqQSDbBWGoCdGWZlgC6nlhljlAJVJK2eUzzi74Q+HanQ7nXtF7GvYUllt
         82rQ==
X-Gm-Message-State: AOAM531m3ox92Aka/tvNmeqobUw6sqC3/jW2ERWFtdeqsrSqJim+Y9C6
        4kZawu9f5u1k345tUrBhhpRn8t4WmVSkGiNd5b05tw==
X-Google-Smtp-Source: ABdhPJwO2ELw3p5hZojnTdXaANerTM83mayFHUGmW3GkWzFD6K9zoHjPN0sOUOL94omXdv1oSrta0pkaceOlYnflPk4=
X-Received: by 2002:a17:906:4149:: with SMTP id l9mr4240515ejk.388.1629725384496;
 Mon, 23 Aug 2021 06:29:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210822115755.3171937-1-knaerzche@gmail.com> <CAAEAJfDLvctAk3omLgFBBbzvufFKwSW5_cQZ+MjvyN4khGOe_w@mail.gmail.com>
 <24767661.6Emhk5qWAg@phil>
In-Reply-To: <24767661.6Emhk5qWAg@phil>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Mon, 23 Aug 2021 10:29:33 -0300
Message-ID: <CAAEAJfA0QGcDJLOh=-zZKnd7=UFchDAqkK+OSMgm4yv524OHuA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Re-add interrupt-names for RK3399's vpu
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Alex Bee <knaerzche@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Johan Jonker <jbx6244@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2021 at 17:25, Heiko Stuebner <heiko@sntech.de> wrote:
>
> Hi,
>
> Am Sonntag, 22. August 2021, 16:37:24 CEST schrieb Ezequiel Garcia:
> > Hi Alex, Heiko,
> >
> > On Sun, 22 Aug 2021 at 08:58, Alex Bee <knaerzche@gmail.com> wrote:
> > >
> > > Commit a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
> > > intended to remove the interrupt-names property for mmu nodes, but it
> > > also removed it for the vpu node in rk3399.dtsi. That makes the driver
> > > fail probing currently.
> > > Fix this by re-adding the property for this node.
> > >
> > > Fixes: a728c10dd62a ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
> >
> > AFAICS a728c10dd62a removed lots of interrupt-names properties
> > from devices other than IOMMU.
> >
> > Maybe it's best to revert it?
>
> where did you see more mistakes in it?
>
> I.e. first of all, at least when grepping through my kernel history, I only see
>   commit 53a05c8f6e8e ("arm64: dts: rockchip: remove interrupt-names from iommu nodes")
> with a different hash and at least there I see a lot of iommu interrupt removals
> and this one line removing the vpu irqs in error.
>
> So from my glance at it, applying Alex' patch should solve the issue?
>

Ah, seems you are right. Sorry for the noise!

Thanks,
Ezequiel
