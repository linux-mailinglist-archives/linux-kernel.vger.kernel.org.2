Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6391342C048
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhJMMo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 08:44:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:45122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232366AbhJMMo0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 08:44:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9404261105
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:42:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634128943;
        bh=p8tzbQGHncvPUz9CxEELw2NXc20g3D1UwuPJy5Lcb8M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WGE7WWZYV9kJaZUrA2fCICy/Wfo8rSrpB1w2OyRrOHP9igb5M3dESjyPwJDpTbDZW
         82B1PHyMgoxpnw20K26+meotRUn/7w5++QDsrNHQXHbaF/d9LOvaLEyjvztIBBTVt3
         xsDun0YVMCxGsNx4pPJ5iG+yVa0dUTt/qegfMX3xmtAesjkrbpO8MtLWPYnjRzIExv
         +EMyZoc0Ukk9nutafYKyLBZHs2hnGWOcsx7KkyNkVk1oFbWKb/4s0DRrjkqdtNaNNM
         gGfZ99OM/Gi4psi7PXw/5hBu5JiMGJbnwmx4OT6/EW0HlajG3R4I+1vnYi7n2HtqkB
         /+BY93Y6rQh6Q==
Received: by mail-ua1-f51.google.com with SMTP id h19so4148062uax.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 05:42:23 -0700 (PDT)
X-Gm-Message-State: AOAM531MYFWBOoQOcBH6C6zqLmRu4392ynXzwpr0wwqtqyYP0caOCduk
        fQ7fOxTGwgSRe78qB9ylTYfX9XYr3ivCVp0ETPc=
X-Google-Smtp-Source: ABdhPJzDEcif+sB2unKqRYwClPkyoh1+OuVI4uCqADCHESp1eW7nKG2gDYZLYxzqpSU5/eQqKEBvUoPGcNrIMIspZfY=
X-Received: by 2002:a67:d88c:: with SMTP id f12mr38800185vsj.33.1634128942575;
 Wed, 13 Oct 2021 05:42:22 -0700 (PDT)
MIME-Version: 1.0
References: <20211013012149.2834212-1-guoren@kernel.org> <5eb20b41ca611f410cf802d4d4a9e945@kernel.org>
In-Reply-To: <5eb20b41ca611f410cf802d4d4a9e945@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 13 Oct 2021 20:42:11 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQmNvtK+9hZWCqHY6rVLZ=wJyo+DvWBG7+o8+c+xSDngg@mail.gmail.com>
Message-ID: <CAJF2gTQmNvtK+9hZWCqHY6rVLZ=wJyo+DvWBG7+o8+c+xSDngg@mail.gmail.com>
Subject: Re: [PATCH V3 1/2] dt-bindings: update riscv plic compatible string
To:     Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Guo Ren <guoren@linux.alibaba.com>,
        Rob Herring <robh@kernel.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 8:39 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On 2021-10-13 02:21, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > Add the compatible string "thead,c900-plic" to the riscv plic
> > bindings to support SOCs with thead,c9xx processor cores.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Cc: Rob Herring <robh@kernel.org>
> > Cc: Palmer Dabbelt <palmerdabbelt@google.com>
> > Cc: Anup Patel <anup@brainfault.org>
> > Cc: Atish Patra <atish.patra@wdc.com>
>
> Please add a cover letter when sending more than a single patch.
>
> This isn't complicated, and git will do it for you if you kindly ask.
Okay

>
>          M.
> --
> Jazz is not dead. It just smells funny...



-- 
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
