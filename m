Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47877405C9F
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 20:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243341AbhIISJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 14:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbhIISJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 14:09:54 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A58C061574;
        Thu,  9 Sep 2021 11:08:44 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id r3so4353904ljc.4;
        Thu, 09 Sep 2021 11:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xrhkwNFbE7CyeaYCdqoaVFTNPtiqwBmkiYhnEB4KRuk=;
        b=NCWnT6TeOOcjemqLK2rjAdshV8YqvLkJZVnOfCAonFtKk6+9c6m0/yjkKNNQTjQO8W
         XHyyzdsDv4iu1vTjGJPiMeyPJckL5XrOlDTWnTxpiPpdUbhFzc8T14syf3G9Aun7n5Yf
         /DkaS/dkaLRw6tBSXWSBUfZ5qIbNodI3B2qvfhVqsfb9GTPNC8XciqBIISeqO06KT/IA
         8KaX+gb01Bt0WpDfTRfug62bsalwc+AbzpfmOcSCNyPnDCVa8NdHDXWxA8B/9VoHH8S1
         LEKeGnlCLvRsNc3216TZVysnPMHl7INP2Ap6DPQ+Yma695/GwmtZqUu9lzYPmx2s+5M9
         Yx5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xrhkwNFbE7CyeaYCdqoaVFTNPtiqwBmkiYhnEB4KRuk=;
        b=ftm6pKVOsawgkeOo49ITsYdYiPtZw9P37hzhAR9GohRrNrfHXPCAzwPpfcPJC/ULTe
         3GkS67mT5BpQisyCqqliPnlgTYsVeqqN/is3sEUJ9CnuMbZee5fLhOv1EyKDp9pKqBAP
         x3/2JCeOJ+TE1CEvPCnNtV3OlfE2jy7sod0iHzge2GiCL5eEIbpRp1zR1UeEgPdHn15Y
         2B9c7DpW7o00Us5h58rr1CfyPOxPFkKFhHYSyJp/SPuGq5QOuqfbK6w7rD+JByhifBCx
         JeXcFad+jq3oGXoBPh90v3l05E4iuxJYabLsw1ZPKPKD4696EFvo4StEYgKwXACuqDFT
         h0RA==
X-Gm-Message-State: AOAM530z1vM5/FPKzopye3hDjhCmF476mht7BoevTpXvB1ErZyGPuvvD
        rG+6UrjnI0OqE7sM1ONtwcoQO+uOboJtBd4rTCP5unUR
X-Google-Smtp-Source: ABdhPJy4eqa9jtOaa4xArzlQb4HOKplkxI+t5trsMjGV1U0zBR3oDobhEBCzDskkISuQ6M+shbgxL9pEJSiFOI2J+v4=
X-Received: by 2002:a05:651c:4d4:: with SMTP id e20mr940782lji.402.1631210922576;
 Thu, 09 Sep 2021 11:08:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210909172555.435430-1-y.bas@phytec.de>
In-Reply-To: <20210909172555.435430-1-y.bas@phytec.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 9 Sep 2021 15:08:31 -0300
Message-ID: <CAOMZO5D6pt59PgNzdDYw2HrmG9Cjk--kcymp1KxeCHhhw6Bd9Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: imx6: phycore-som: Disable micro-SD write protection
To:     Yunus Bas <y.bas@phytec.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yunus,

On Thu, Sep 9, 2021 at 2:25 PM Yunus Bas <y.bas@phytec.de> wrote:
>
> The micro-SD card doesn't feature a write-protect pin. Set the
> corresponding property in the devicetree to handle this behavior
> correctly and suppress driver warnings.
>
> Signed-off-by: Yunus Bas <y.bas@phytec.de>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
