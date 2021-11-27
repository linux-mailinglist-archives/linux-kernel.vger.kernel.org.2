Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8730A45FFED
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 16:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348747AbhK0Ppv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 10:45:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234853AbhK0Pnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 10:43:50 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB16C061748;
        Sat, 27 Nov 2021 07:40:35 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i12so10631524wmq.4;
        Sat, 27 Nov 2021 07:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IC/TlGTWkhJl4qcceepZ/CYaq+BBm6DPEjqCKhmnCsw=;
        b=GmzyqzXEbqYqGI9eVUKMe0UNzDtUmA4nqzsKU6AV+sLw89kJG9jR3U/d/MPyhkDBo4
         Sa86RIC0VNB2qn+yThFmo8sXr9mLmrrTLlhbNH1y3FJjf1LfdmwZ5Ddn1orqYsQrqLMt
         L1d3d1car9BsTzbz+4v01BwSPjrGkoz4ywbWyEJ/GnOddX94typXdtSK4QBfGUXOeadV
         bj+9OfmJZ1ZtAq9gcVXuvhiF9T2tTQIeEwarADNst5nx0++Ew1ob4d7yRRrWqfl92KbD
         +XYqw3mpJyMpTFpDEiN25SFMWsD1bUGTSEaqqHppMMqm42JTfZp+VsV/mb94P6qyAKbs
         E4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IC/TlGTWkhJl4qcceepZ/CYaq+BBm6DPEjqCKhmnCsw=;
        b=jA+/THVGyO0LrK1rLEcIys4nbjXmUV0LJvKg/0YbM2vKWqIH5xmevgIjTmxhCvOjEU
         BBlQBa+7wzKVAZ4AXxY+AfiVX29f9kUd/svjjx5lfOH68oWzWMSBeFIcHlq1oKqzj332
         BMsWeJ14r9/OVYypuTvYpseIacGrxtUa6PLHMKL+mjVymrrj7YSI4eERx5SHuME6Wp89
         e9+7HWH7oQ6LXDxUindqHYrq0b0k9YQZnknHnkGwKcgUjSGUXtAQEQlLIzTb3StXewh2
         3zRi3u3AVWrDwH8k+d9fKMveRgmAUgfc7lGqao0WJvPsftyE5vXfaazMrPq+aaE4Nexd
         VFjA==
X-Gm-Message-State: AOAM530z2ro8i97BakXMbOmS1G6D/GY2zWAiC/t9ZmQDAqalwT43B5r+
        uyUe7JQs17GqezINGWySswo=
X-Google-Smtp-Source: ABdhPJwHt9yyL6r5ZW3SqBbrC/vI1dL2cN7oRt6Sg68+OORzJCNZKs6/mZOH3anYctkkZTctKwGblg==
X-Received: by 2002:a05:600c:3b27:: with SMTP id m39mr24321389wms.132.1638027634111;
        Sat, 27 Nov 2021 07:40:34 -0800 (PST)
Received: from archbook.localnet (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id u23sm9200634wmc.7.2021.11.27.07.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 07:40:32 -0800 (PST)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] arm64: dts: rockchip: Add spi1 pins on Quartz64 A
Date:   Sat, 27 Nov 2021 16:40:26 +0100
Message-ID: <3750380.Q3bl6Pheio@archbook>
In-Reply-To: <acbd0e0a-b194-7b17-148d-49fdd348077e@gmail.com>
References: <20211127141910.12649-1-frattaroli.nicolas@gmail.com> <20211127141910.12649-4-frattaroli.nicolas@gmail.com> <acbd0e0a-b194-7b17-148d-49fdd348077e@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Samstag, 27. November 2021 16:29:33 CET Johan Jonker wrote:
> 
> On 11/27/21 3:19 PM, Nicolas Frattaroli wrote:
> > The Quartz64 Model A has the SPI pins broken out on its pin
> > header. The actual pins being used though are not the m0
> > variant, but the m1 variant, which also lacks the cs1 pin.
> > 
> > This commit overrides pinctrl-0 accordingly for this board.
> > 
> > spi1 is intentionally left disabled, as anyone wishing to add
> > SPI devices needs to edit the dts anyway, and the pins are more
> > useful as GPIOs for the rest of the users.
> > 
> > Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts | 5 +++++
> >  1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > index 4d4b2a301b1a..166399b7f13f 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3566-quartz64-a.dts
> > @@ -509,6 +509,11 @@ &spdif {
> >  	status = "okay";
> >  };
> >  
> > +&spi1 {
> 
> > +	pinctrl-names = "default";
> 
> With the removal off pinctrl-1 the pinctrl-names property is already
> correctly defined.
> 

If it ever gets re-added in the future, it no longer is, so it's better
to be explicit right now than to risk one board breaking in the future
when the SoC's definition changes.

Regards,
Nicolas Frattaroli




