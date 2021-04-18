Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB07336355E
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Apr 2021 15:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhDRNBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Apr 2021 09:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhDRNBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Apr 2021 09:01:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1859C061763
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 06:00:49 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id n2so48771065ejy.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Apr 2021 06:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snejp.pl; s=gmail;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=6Ow1NlEM7DKtr4mIJK66YbpuR1k+LjlGbnW7/7eKM+w=;
        b=ZAzrDKi0WrNy99E2xve9lRvUjc4y9pEfsTbOA8rOglKFYPdhSZpk9sn41KFyifW207
         mNCMthaZUyAG4M3JuWBar9NVWdsjzL8m6XImXPr5eW79YHfWu11l37h66T1/G1dzr+4p
         d2LnXEOzeQ4rwxCrOgBXAvCu2lJjfeIRBt8zhBIs+8MPUDoi/lwSlqcxVGTwyul8YqM/
         ZtxAgrmNjcvb17Du8X6TWI0UUYuvwnE6oF9Cd6Z76pqffWCMifOe1iJHdTBRNiReagJo
         GjODWwgQ7qZsBHXytLHXYNnEKuk2KUoWU6hxmj79hoOqCJaisYCe05el6SB6U9nd1Mcs
         gU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6Ow1NlEM7DKtr4mIJK66YbpuR1k+LjlGbnW7/7eKM+w=;
        b=JQsnW3JYsA9nnXhP2LsQlHnoI5d9Et2iCF5TchA/i4k9ygttaGMad/Vo3ToN+5JExT
         kzkUykrlI5EygcopzVwSWe/TCs9KP+oKL/7nOQXCp2PwhwzC+I2o2npwehxnGOm/vM3l
         bx/tWvJSZgoLCYMyxsl3KfjAaTp/IzVylc8B3LqfjHANGR/XIfJXbGUlXs9T/j1cjYMe
         c+ntERA0Y2GYwhzK/aLLyQ2JJu2Tbqj6vBYJWmujS1Q+BxV+92P0uXhjhvNu1UfQntrS
         vTdQybdH87k4+CB0imT7abGd2rxhw5ZfAQ12p6KtbXDd8IeCmGKzhSajN1pi8XfMFmVJ
         EFzg==
X-Gm-Message-State: AOAM531Z7JKRdDY2ybMnXl3cKdm2J/ViAEXZT7jSyxmIq3DAJeERtpBa
        gM2GgmtNYqyfuXhUirY+5JVNCw==
X-Google-Smtp-Source: ABdhPJynk440pimUYGjeiYWc8ykH5SQkOAlqUmul4ohk1LNdpMwCBfj4JfqjQMI6VpxBPwNUI4EKaw==
X-Received: by 2002:a17:907:76a7:: with SMTP id jw7mr17228065ejc.322.1618750847955;
        Sun, 18 Apr 2021 06:00:47 -0700 (PDT)
Received: from PackardBell (87-49-44-144-mobile.dk.customer.tdc.net. [87.49.44.144])
        by smtp.googlemail.com with ESMTPSA id r10sm8436629ejd.112.2021.04.18.06.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Apr 2021 06:00:47 -0700 (PDT)
Received: from localhost (PackardBell [local])
        by PackardBell (OpenSMTPD) with ESMTPA id 03f6b92d;
        Sun, 18 Apr 2021 13:00:45 +0000 (UTC)
Date:   Sun, 18 Apr 2021 15:00:45 +0200
From:   Bartosz Dudziak <bartosz.dudziak@snejp.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 0/5] Samsung Galaxy S III Neo Initial DTS
Message-ID: <20210418130045.GA73531@PackardBell>
References: <20210326145816.9758-1-bartosz.dudziak@snejp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326145816.9758-1-bartosz.dudziak@snejp.pl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 03:58:11PM +0100, Bartosz Dudziak wrote:
> This series of patches enables to boot MSM8226 SoC in Samsung Galaxy S III Neo
> mobile phone. Implemented clocks are on top of MSM8974 GCC driver because there
> is really little difference between them. UART serial communication is working.
> I have working patches for the regulators, EMMC, multithreading and Wifi for
> this device but they are not clean and ready to submit.
> 
> Bartosz Dudziak (5):
>   dt-bindings: clock: qcom: Add MSM8226 GCC clock bindings
>   clk: qcom: gcc: Add support for Global Clock controller found on
>     MSM8226
>   arm: dts: qcom: Add support for MSM8226 SoC
>   dt-bindings: arm: qcom: Document MSM8226 SoC binding
>   arm: dts: qcom: Add initial DTS file for Samsung Galaxy S III Neo
>     phone
> 
>  .../devicetree/bindings/arm/qcom.yaml         |   6 +
>  .../devicetree/bindings/clock/qcom,gcc.yaml   |  13 +-
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/qcom-msm8226-samsung-s3ve3g.dts  |  25 +++
>  arch/arm/boot/dts/qcom-msm8226.dtsi           | 152 ++++++++++++++
>  drivers/clk/qcom/gcc-msm8974.c                | 185 ++++++++++++++++--
>  6 files changed, 364 insertions(+), 18 deletions(-)
>  create mode 100644 arch/arm/boot/dts/qcom-msm8226-samsung-s3ve3g.dts
>  create mode 100644 arch/arm/boot/dts/qcom-msm8226.dtsi
> 
> -- 
> 2.25.1
> 

I have sent version V2 of the patches
