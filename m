Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27944403DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 18:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352333AbhIHQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352347AbhIHQsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 12:48:36 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF69CC06179A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 09:47:24 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id g14so4574555ljk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jt97OjPgOlwhkMU+9KY4C6kyYEYRZScwK0qfgdPvP7s=;
        b=AkaWDibe1d4zi2+EffnilOJ0ivSBKulI33gsSPtpT2aARGvKgOcNOj6Pqd5Nt1/3Ug
         ehQICKIF8BVDZbENDFCCkCZmAVxFltEioM2P+QQbUiK5ba7HNLtagSiJLbfgREIG9J/2
         VPM5qijcG/juMnCQY4ebU42mXDzauxWZ9Yxs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jt97OjPgOlwhkMU+9KY4C6kyYEYRZScwK0qfgdPvP7s=;
        b=BeFSWyBsLS92CAZoPlqZcxP9zbDxZaeIuE0QKMgTCh497m8UVL5EKAeqtkCGzeCZQB
         1psb0+0j/uqAC7AjsDExsa/w5a+CKG8z1noRB1sm63Lvk1cADzSCyKNPWZ2LfRMH4Jdu
         FdN9ti7Mt3k0kz62D3E3ELo8GZzHs2ZbKF4XXDhI3cSoiOI/S5TmMiwldzhcDiHacYj1
         RRK+K/xKMCRAVo1P1XyEL89YSMP6CVyr8mz7zXtTv1aB6YefB5mUJt4IyBMxiwtwqHKr
         s6FDnrZuJbramHYIDR1pzGYFEeAyj6cRrWFzTrjcY69iUwxcoZO9fe9IZMsvOKHEfAyb
         VPlA==
X-Gm-Message-State: AOAM530Y5uLgRb++WIqFVFcQjH3BOiOeQYSujmfA+xBjAj4vkY/p2Ofx
        CX0AROyNEHDolN0gBWL6ib2k2wAPOPcJ3u5G7fE=
X-Google-Smtp-Source: ABdhPJzxZd9mgOczqIizC3oj0G1VALWgiFsaRs1VQs1JO5UTNtZShRfuHjeUOhIzbJd9LefISv5muw==
X-Received: by 2002:a2e:90da:: with SMTP id o26mr3570785ljg.504.1631119642992;
        Wed, 08 Sep 2021 09:47:22 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id k17sm234631lfv.285.2021.09.08.09.47.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 09:47:20 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id s10so5643392lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 09:47:19 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr3240332lfr.173.1631119639612;
 Wed, 08 Sep 2021 09:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <69a0c6f17b000b54b8333ee42b3124c1d5a869e2.1631105737.git.robin.murphy@arm.com>
In-Reply-To: <69a0c6f17b000b54b8333ee42b3124c1d5a869e2.1631105737.git.robin.murphy@arm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Sep 2021 09:47:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=whm5tP-JDnZ=LCr2ZpnPaAZakZyN=wD_tY7pydQJRtJXw@mail.gmail.com>
Message-ID: <CAHk-=whm5tP-JDnZ=LCr2ZpnPaAZakZyN=wD_tY7pydQJRtJXw@mail.gmail.com>
Subject: Re: [PATCH] iommu: Clarify default domain Kconfig
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 5:55 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Although strictly it is the AMD and Intel drivers which have an existing
> expectation of lazy behaviour by default, it ends up being rather
> unintuitive to describe this literally in Kconfig. Express it instead as
> an architecture dependency, to clarify that it is a valid config-time
> decision.

Thanks, I think this describes the behavior much more naturally, even
if apparently the end result is pretty much identical.

I'm assuming I'll get it through the iommu tree eventually (no need to
expedite this),

           Linus
