Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0A123BF962
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 13:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhGHL5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 07:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbhGHL5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 07:57:49 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 445BAC061574;
        Thu,  8 Jul 2021 04:55:06 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id p1so14577510lfr.12;
        Thu, 08 Jul 2021 04:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sCC2Bd3Tn+urUcYrm3jEWJH+8AhYlM496j93EpGunY=;
        b=bTqf4yjic2rDiWS+orAjXyEKJru+oQn1UGFnL5a4G97JLuyMcKfzAb4Diol6hGOkK/
         k0OnFELCnFddmCqM++Pw22CicpARykrG1UTAr8DQ9YGSf4LrxMqD36HtUpcByjj80G6L
         GKZeDVZeXxmq+asxsKTbb88gGCy38H1U1D2HYnDvBhs2+45Q0SanIF5fhZe1hW/hqtyP
         JxDIBEDyL+kTe9E8wLrnUV0vpasW/svJTGAn09XWjT/IK0XlJOZiQUrpJeifXIEwjqjH
         meABxWDJQX3X0YnKiUFN1n8PhaDkYRadom/aG49lKL/9BAjw7zTbeW+x0s+ksb1vIW4k
         htKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sCC2Bd3Tn+urUcYrm3jEWJH+8AhYlM496j93EpGunY=;
        b=dKiCnQ0ohXPWvujlRph+Tj+A0k7dmY+7NdZ92wc6yT1/HZyIssL61MotYwPA1CY4Dz
         +F4ZGzP7yKsyevp0Brov66eg8DZubjOsmEEJ+eNz66pzEs8CV43f0cK+89BbOGi4Ii0c
         YSu7jyA4WVeYTJLutYKNy/2k/4wmTicLlT4vgNJfj/1VTMODqDemxoKyC3Pzpfp8Yvpo
         ueEYacKveE99A/HiOsAevDpq9LcOtPUUDQXB/ew7NM2i4o70qcaVAPuFjOqjmXUByB8+
         2kIoF6gFlOCbHktyz82HPCY39JXUAuFJHqadenU3XqTS7G/Gf4VByssmpkl50bVuQ4/W
         Yd7g==
X-Gm-Message-State: AOAM530Xu2dKFXLUhJ/aUxytlzoaHKIBGt5Bt/rOpLzeA6vy8gsb+IjW
        lbyHyoucT8KPB4h7tePUl/Ku/kShT7z7oRPNcIc=
X-Google-Smtp-Source: ABdhPJyyP0lPdJAOb9msVU4E4hiWvjm1wD88vNW3My1f2et8PWNOB5d2yUbFzLSPcCsU1CQwhL4t/b6v5T0CMMRodcw=
X-Received: by 2002:a2e:9881:: with SMTP id b1mr23741766ljj.53.1625745304639;
 Thu, 08 Jul 2021 04:55:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210525143001.9298-1-cniedermaier@dh-electronics.com>
 <20210602195009.GA3870858@robh.at.kernel.org> <b765351a7c3542d2a66ab1168f1ff222@dh-electronics.com>
 <bfbd70ca-b5a6-f7a7-4c7d-72ac86874227@denx.de> <76d6cc846f4f473083e597303956ff11@dh-electronics.com>
In-Reply-To: <76d6cc846f4f473083e597303956ff11@dh-electronics.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 8 Jul 2021 08:54:53 -0300
Message-ID: <CAOMZO5AOjG__CpjDknnyK2Ox0V7dVPeSAWQV8DKtaREEJAeO=g@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: arm: fsl: Add DHCOM PicoITX and DHCOM
 DRC02 boards
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        kernel <kernel@dh-electronics.com>,
        "Marek MV. Vasut" <marex@denx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Thu, Jul 8, 2021 at 4:39 AM Christoph Niedermaier
<cniedermaier@dh-electronics.com> wrote:

> Is this Patch OK?

It looks good for me:

Reviewed-by: Fabio Estevam <festevam@gmail.com>
