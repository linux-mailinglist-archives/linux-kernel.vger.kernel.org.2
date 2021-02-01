Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB9F130A6A8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 12:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbhBALfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 06:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbhBALev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 06:34:51 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94E2C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 03:34:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id p15so16140517wrq.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 03:34:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mZNr3sMKKnD+FnPD7K7m44WYel5d+QW2CiDuUnxj1K0=;
        b=pOgF7050DDMF+0ni2siGBRYu9wk/5bIonCV8Ux4PP0U3H035s88/lCu8cCr11nX6mT
         O0kHxaLea3EfF0CM50eJX3d9oM7F1TQisk8YbmApU78zbMm1tufyACMBtuEqJtHsTNK/
         ckyJ9ZRdVTS4+mogDT6AqR0d+8hfSkO4UruRULHFYvJ6B2JDSAaNzSs+jhphr2n7Bzq3
         UNsh9O2YePInbFYZq4mgWgQKxPm3rNYqbos4cE4spwJ8XqwMKUgbTWySLD1boEuSNk5F
         eRpnL0fEDsYCyFNS7ORO/wDK1Gt9UNtzdOqv050cvwehmWQ5ZDONUZLjA4aL5um4sXXk
         Dp5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mZNr3sMKKnD+FnPD7K7m44WYel5d+QW2CiDuUnxj1K0=;
        b=Q9Fc/HSYZ8DZpADzxDjS1LEWhCvVGeNYuT8jQNThbjMIbkyhqAPgdR3iM7wpRNvxd0
         4etQT9zKVdffstnKa3sp8bYAMWeavq+3LR/zAUfFELL/VhnkqaPheJTC7WnRvHvgYtqn
         uqOlvqrAD8olNOslwLMDE4DcN1Zo8uIiWAMYp/nMPUAYG05hSqJ16fbcjEU1ikRO4Ne/
         14BF5Z1akBS+ajIZ8Ptv/Yuh8Kj1pCoYBHSTt+DquDUwkFZwE/V/GnyRB7O6WDUlMpsW
         tV4jlBOAXCiUqUj/23pJ0mAvAkGEIO/sfrQIiovrM2CqGdxFJ5NNmrcpxXCsNABF9xtl
         wUmA==
X-Gm-Message-State: AOAM533hC3BbZrGE7K8FidUQULBUzksw9pp/gndNRJ58wOfn3gOdwCOx
        fvXikL9xtI+U7Ub8F0JXFVI=
X-Google-Smtp-Source: ABdhPJw2S2gHxASL2Jaw8ZDxBzTE3cbM0wCuuk8Uefr0JFOky3ssVY2sOlUg5/XpIByXJQJXFq6mWA==
X-Received: by 2002:a05:6000:12c7:: with SMTP id l7mr17511316wrx.103.1612179249622;
        Mon, 01 Feb 2021 03:34:09 -0800 (PST)
Received: from a-VirtualBox (cpc141888-watf13-2-0-cust663.15-2.cable.virginm.net. [86.14.42.152])
        by smtp.gmail.com with ESMTPSA id 62sm21188427wmd.34.2021.02.01.03.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 03:34:09 -0800 (PST)
Date:   Mon, 1 Feb 2021 16:34:04 +0500
From:   Bilal Wasim <bilalwasim676@gmail.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        enric.balletbo@collabora.com, hsinyi@chromium.org,
        weiyi.lu@mediatek.com
Subject: Re: [PATCH 1/2] soc: mediatek: pm-domains: Use correct mask for
 bus_prot_clr
Message-ID: <20210201163404.0429fe00@a-VirtualBox>
In-Reply-To: <e4961c5e-db52-148d-c414-25f16101fb3f@gmail.com>
References: <20210201054542.1470695-1-Bilal.Wasim@imgtec.com>
        <20210201054542.1470695-2-Bilal.Wasim@imgtec.com>
        <e4961c5e-db52-148d-c414-25f16101fb3f@gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Feb 2021 09:59:47 +0100
Matthias Brugger <matthias.bgg@gmail.com> wrote:

> On 01/02/2021 06:45, Bilal Wasim wrote:
> > When "bus_prot_reg_update" is false, the driver should use
> > INFRA_TOPAXI_PROTECTEN for both setting and clearing the bus
> > protection. However, the driver does not use this mask for
> > clearing bus protection which causes failure when booting
> > the imgtec gpu.
> > 
> > Corrected and tested with mt8173 chromebook.
> > 
> > Signed-off-by: Bilal Wasim <Bilal.Wasim@imgtec.com>
> > ---
> >  drivers/soc/mediatek/mtk-pm-domains.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/mediatek/mtk-pm-domains.h
> > b/drivers/soc/mediatek/mtk-pm-domains.h index
> > 141dc76054e6..7454c0b4f768 100644 ---
> > a/drivers/soc/mediatek/mtk-pm-domains.h +++
> > b/drivers/soc/mediatek/mtk-pm-domains.h @@ -60,7 +60,7 @@
> >  #define BUS_PROT_UPDATE_TOPAXI(_mask)
> > 	\ BUS_PROT_UPDATE(_mask,				\
> >  				INFRA_TOPAXI_PROTECTEN,
> > 	\
> > -				INFRA_TOPAXI_PROTECTEN_CLR,
> > \
> > +				INFRA_TOPAXI_PROTECTEN,
> > 	\  
> 
> BUS_PROT_UPDATE sets bus_prot_reg_update to true, which contradicts
> what you say in the commit message.
> 
> Please clarify.
> 

Yes, that's a problem in the commit message - Will fix and send out a
v2.

Thanks,
Bilal

> Regards,
> Matthias
> 
> >  				INFRA_TOPAXI_PROTECTSTA1)
> >  
> >  struct scpsys_bus_prot_data {
> >   

