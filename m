Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1A0130D10F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 02:53:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbhBCBvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 20:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhBCBvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 20:51:00 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79E8FC06174A;
        Tue,  2 Feb 2021 17:50:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d16so22384211wro.11;
        Tue, 02 Feb 2021 17:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/sDnQCoBJzd+G1dm09IQlU+bQBdo7KOQBQfZsd1ArQ0=;
        b=nMRLLe8JMleMFMolDyysYg3G2GQLLGzj1p+0EBXMboUMqWvFbD+atIXFkqjAjLYCRk
         7q0uue/yRjX5F1PefvYifacevyoi+t3W9v/PsRcMdG7FP969aw/sZbN9C7jqRK2Kmjae
         +W83nZE99gLaJHAop3T+FycqEXEY5f3Jw1cKOgersHMzdqudPmhNe2yeWd77Xu7uwv51
         E9e8V2leRVC8tyhmmEL1rVBVeYDPuWn61QMwA2ErXa6s0fV+YYprSv5VaPqROjLnMkfA
         WtdiRiRCEWnDBAR3C1rzDR1NSDRnLmuZcAdu4l7nl0YXSuTlkyOehjqnfYu7pt7dHI/9
         OHBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/sDnQCoBJzd+G1dm09IQlU+bQBdo7KOQBQfZsd1ArQ0=;
        b=XFW7AjkZ8NaaEE6SPfoiBzoFRM0iG7sp+1PZQVUAXYEP5igeoiJC1Hwajc2MNT9eCb
         Rfp+KY04ukUOks1vBeCtm/RI1p9xngWFL+sSVXvmE0pRgscluuAST+gbolzVfq15IZwl
         l0ueGrMNsb/7opdhgSl9sJQmx3mNnkBizQefBFYzaJL2rQEYcm8rtWDk/QoOX30kggky
         RetLgaIg4ZwN+y8ml8H6jROEHk5fI2BLnD2D1BRcCiSwvVVYazegWg05JA4uRtXJqTG9
         cg8lVzcBKzscAAwdXIKIthCZDgzTm71at1cHruZ7jwbbe7J/SNtwQm7nZvEin6iTK04j
         jdnA==
X-Gm-Message-State: AOAM5331i8PKOj0pL9NwDWiJMG/Kq6rVuS5rNDlPMyH+7GPyXcg3HFzF
        uK+ZY/+gBlMoYIr4qbAo9D+VR/vXxM4mwU3C1AE=
X-Google-Smtp-Source: ABdhPJyPpgBrxvykPqF+w1syFYv3dXpj7oxP5i2ZCmF+lg81VymYeH3nMLCZptiI1ZZ9uX/6Lz60WIqiFW5oI4LMSkg=
X-Received: by 2002:adf:9427:: with SMTP id 36mr779616wrq.271.1612317019328;
 Tue, 02 Feb 2021 17:50:19 -0800 (PST)
MIME-Version: 1.0
References: <20210202073258.559443-3-zhang.lyra@gmail.com> <20210202104257.736836-1-zhang.lyra@gmail.com>
 <20210202140101.GA32671@8bytes.org> <992fad43-c457-d809-3bd7-7fd5b6e8fa22@arm.com>
 <20210202144126.GC32671@8bytes.org> <5e766b74-ab51-8c47-66c1-ca65bc5743cd@arm.com>
In-Reply-To: <5e766b74-ab51-8c47-66c1-ca65bc5743cd@arm.com>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Wed, 3 Feb 2021 09:49:43 +0800
Message-ID: <CAAfSe-s9ppQBuM81KB_KWaiY5hz3cFAycFP5jd8JXysicoqFGw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu: add Unisoc iommu basic driver
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Joerg Roedel <joro@8bytes.org>, DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Sheng Xu <sheng.xu@unisoc.com>,
        Linux IOMMU <iommu@lists.linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Feb 2021 at 02:02, Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-02-02 14:41, Joerg Roedel wrote:
> > On Tue, Feb 02, 2021 at 02:34:34PM +0000, Robin Murphy wrote:
> >> Nope, I believe if Arm Ltd. had any involvement in this I'd know about it :)
> >
> > Okay, got confused by thinking of ARM as the CPU architecture, not the
> > company :)
> > But given the intel/ and amd/ subdirectories refer to company names as
> > well, the same is true for arm/.
>
> Right, trying to group IOMMU drivers by supposed CPU architecture is
> already a demonstrable non-starter; does intel-iommu count as x86, or
> IA-64, or do you want two copies? :P
>
> I somehow doubt anyone would license one of Arm's SMMUs to go in a
> RISC-V/MIPS/etc. based SoC, but in principle, they *could*. In fact it's
> precisely cases like this one - where silicon vendors come up with their
> own little scatter-gather unit to go with their own display controller
> etc. - that I imagine are most likely to get reused if the vendor
> decides to experiment with different CPUs to reach new market segments.

Yes, I agree, I believe this iommu unit along with Unisoc's
multi-media modules can be used on other architecture SoCs, not only
ARM based.

>
> Robin.
