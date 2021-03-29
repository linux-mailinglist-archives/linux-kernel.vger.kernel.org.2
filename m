Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5ADA34D662
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 19:56:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhC2R4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 13:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbhC2Rzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 13:55:55 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1970C061762
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:55:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j3so15152128edp.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Mar 2021 10:55:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=anholt-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MnTmV7Ubg2sTi3Xa2Quc7eX0k5n11budl3ddfjJpTQ=;
        b=gJtMzc9yrdH/AglObhliCl1eLVPtYjBzEmGKhMs9v04xve8sR8xROi3HbQURzWGDBs
         x8hjM/XW/JAvIauCyjxGZxqaSPBn0pcf+T7fLRHs7eObNBz2kPQmyxHodjG+nu+2gJZy
         FIVdwhqEuY1c/omIMQ0qtK55Vk+CN/qmkvUprAWKV84JmQMF9rzoH+lH0KmtH7NZN+W6
         fxLZuGFGvtrYKg/jzLgyYqQQ+6MAMaONyDWHCjxn3cfuCalDKFQDPkJYCBBcW6SuypKs
         wssZhiDV5SEqInSyh8F8f74PMu8fBNBcKYbISCWdYueBbiapEn7mxGLyhaKBuVsq+1Nt
         6gpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MnTmV7Ubg2sTi3Xa2Quc7eX0k5n11budl3ddfjJpTQ=;
        b=XrX9sXTfxmFAYLF/+fpE8yxX+GDhcukBeLOCUT0jH8t8USqhuqXge8vY3JogHysIOd
         ApgU9f1iYpspLHxleO+h/xqbwUpC54PJnMQ6JbIqgUh2UIHeUeJP8q2nhjEKvKiOcze7
         Jd93QnuXPz1W7Krd+bkooBgskC6iE8gi5ayd23wXNfs9irOGb2UCJzwBbWeLwpA8lK5h
         cIv6HeGwMEDSVS90prrfm3vB84QIksVrqwMSzIOMbzHySC3H5rUu4vy/tyXQi8xT87EH
         beHhWuNoj6NGcguCvH3iPpejqa9PBtv+nvRZd0gpPZV5ULs2c+IGxRAY2zxHFd/WUYkA
         FRHw==
X-Gm-Message-State: AOAM532M2gNF9yBHDycYXPtj71w0ZOzG54HcTmfMxmVpuw1Ehz4BwVAI
        QeGf83UN99Bm26hX3Fvln9OIMs2DgHDKdcAxtvZWwg==
X-Google-Smtp-Source: ABdhPJyyEm9oNlLOtY/Bv1/0xqF/9Vl1Ci9LBjhH/1QbEkuGJ2ahfATbkAxlMF/PRkZVCCe8dvKLypvNECTtIrpoWYA=
X-Received: by 2002:aa7:d588:: with SMTP id r8mr29436114edq.88.1617040551435;
 Mon, 29 Mar 2021 10:55:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210326231303.3071950-1-eric@anholt.net> <20210329144729.GB4203@willie-the-truck>
In-Reply-To: <20210329144729.GB4203@willie-the-truck>
From:   Eric Anholt <eric@anholt.net>
Date:   Mon, 29 Mar 2021 10:55:40 -0700
Message-ID: <CADaigPV0yHFUnGt_ncsS=wBHCMyex_wp=PVAibxSaAMEs8GS=Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] iommu/arm-smmu-qcom: Skip the TTBR1 quirk for db820c.
To:     Will Deacon <will@kernel.org>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, freedreno@lists.freedesktop.org,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 7:47 AM Will Deacon <will@kernel.org> wrote:
>
> On Fri, Mar 26, 2021 at 04:13:02PM -0700, Eric Anholt wrote:
> > db820c wants to use the qcom smmu path to get HUPCF set (which keeps
> > the GPU from wedging and then sometimes wedging the kernel after a
> > page fault), but it doesn't have separate pagetables support yet in
> > drm/msm so we can't go all the way to the TTBR1 path.
>
> What do you mean by "doesn't have separate pagetables support yet"? The
> compatible string doesn't feel like the right way to determine this.

In my past experience with DT, software looking at the (existing)
board-specific compatibles has been a typical mechanism used to
resolve something like this "ok, but you need to actually get down to
what board is involved here to figure out how to play along with the
rest of Linux that later attaches to other DT nodes".  Do you have a
preferred mechanism here?
