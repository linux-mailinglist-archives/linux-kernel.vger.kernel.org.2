Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15BAC45C721
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 15:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355798AbhKXOVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 09:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357876AbhKXOUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 09:20:43 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22EDC111928
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:44:44 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id e136so6939191ybc.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 04:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6YcgzZLwDUNcL02PHE9Uaenl/CwhsN1SwBv9B1Ruuzc=;
        b=eo3Rc02HwuWVktpOIxv+10QH9q901HbfiAdG925qhXSyAdU5Tpdm6+D2e55a67DWhJ
         zAXb/sN2oDHTRAncZ5KFNY+yw5oOT4J0yZMVDgUl+HN6HjR+Zb7olKXgmRfMsGLQyrBg
         u5XAg51I5akwR8REPC6Ux9GjZHA+l3+yULmXTWwJJ3TJzKGTh1bk92wu3iPadLuEwckb
         Alh9sQuApLdhl2b4zJ/sxeU8KP+Tmv3EloyPoB7WplvZ3pp7lvqvSWhPULsF35JWMtIi
         9p5epIEEXrS7JX+LAHKjDqIqYJ6/zagARF5ePSp3dVvVUir+cYQzZ/IWa+qi0wgBjQJb
         A0BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6YcgzZLwDUNcL02PHE9Uaenl/CwhsN1SwBv9B1Ruuzc=;
        b=dQMrY4NfVk5fEYubUqlfH1zN/zqdrMjHS/SvcPmWDY+kfK5v3e9CTkbLRSoLcNb9HO
         sniu5MGm/cHAZIu5LYVbAckkvlBVMkdUFhJQmUkcWI2DtZxGjScSjFny8o9Lf/q0PXPh
         2p6O5kSm+xRvTs6buX1QL3t6fxzNxFkeJrhOSnOfNdkPiyxPTyVkhR/VvitpI0esmyPJ
         t9sLzY+BYKulDZTxPK3OG5XJQBDbCc6HsfTe2/406o8xLTz1lnA6/DpXpEVuGrcRyBXo
         Vj0EwW3+aABfq/UoDpm6FQnmq8/a9Q2XhmJDSeyqmQAvHrOFGMLTXOjkcsBFX5jmXUnT
         Hnfg==
X-Gm-Message-State: AOAM532TjZUIGYOBT1wB6LFv67m07fmJqSuv1uFqiCXK8l6C8KgFvm/9
        2mh9t/UF0ssbGCbvexyl3W6jCBaFoAfH1xvTqgI=
X-Google-Smtp-Source: ABdhPJysYTZnsf7KZmH2S6chrFbipTzxZtp2LIae4nRuHTZSh4Lg/2XMgNatlNQNMjW97PSDu9QTKTA1qcAgFyAK6VY=
X-Received: by 2002:a25:45:: with SMTP id 66mr18207748yba.464.1637757883804;
 Wed, 24 Nov 2021 04:44:43 -0800 (PST)
MIME-Version: 1.0
References: <20211124021325.858139-1-knaerzche@gmail.com> <2895944.ZOkXcVNkQQ@diego>
In-Reply-To: <2895944.ZOkXcVNkQQ@diego>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Wed, 24 Nov 2021 07:44:32 -0500
Message-ID: <CAMdYzYo=6H3NaBDZ2rQnDUr89rnA0rvxWGfEbRP6sQGt7+vB3w@mail.gmail.com>
Subject: Re: [PATCH] iommu/rockchip: Fix PAGE_DESC_HI_MASKs for RK3568
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Alex Bee <knaerzche@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        iommu <iommu@lists.linux-foundation.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 5:36 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Am Mittwoch, 24. November 2021, 03:13:25 CET schrieb Alex Bee:
> > With the submission of iommu driver for RK3568 a subtle bug was
> > introduced: PAGE_DESC_HI_MASK1 and PAGE_DESC_HI_MASK2 have to be
> > the other way arround - that leads to random errors, especially when
> > addresses beyond 32 bit are used.
> >
> > Fix it.
> >
> > Fixes: c55356c534aa ("iommu: rockchip: Add support for iommu v2")
> > Signed-off-by: Alex Bee <knaerzche@gmail.com>
> > ---
> >
> > I've found this bug, when testing the recent VOP2 submission, which is
> > the first perpherial which uses iommu for RK356x. I could use it on my
> > quartz64 8GB board only, when limiting the available memory to less 4GB=
.
> >
> > This patch fixes it.
> >
> >  drivers/iommu/rockchip-iommu.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-io=
mmu.c
> > index 5cb260820eda..7f23ad61c094 100644
> > --- a/drivers/iommu/rockchip-iommu.c
> > +++ b/drivers/iommu/rockchip-iommu.c
> > @@ -200,8 +200,8 @@ static inline phys_addr_t rk_dte_pt_address(u32 dte=
)
> >  #define DTE_HI_MASK2 GENMASK(7, 4)
> >  #define DTE_HI_SHIFT1        24 /* shift bit 8 to bit 32 */
> >  #define DTE_HI_SHIFT2        32 /* shift bit 4 to bit 36 */
> > -#define PAGE_DESC_HI_MASK1   GENMASK_ULL(39, 36)
> > -#define PAGE_DESC_HI_MASK2   GENMASK_ULL(35, 32)
> > +#define PAGE_DESC_HI_MASK1   GENMASK_ULL(35, 32)
> > +#define PAGE_DESC_HI_MASK2   GENMASK_ULL(39, 36)
>
> With this change the PAGE_DESC_HI_MASK* now match the other
> constants above them in what bits they access, so
>
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
>
>

Tested on the quartz64-a board with the experimental vop2 driver,
confirmed it fixed the issue.

Tested-by: Peter Geis <pgwipeout@gmail.com>

>
>
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
