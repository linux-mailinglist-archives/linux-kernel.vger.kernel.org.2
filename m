Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D1C353936
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Apr 2021 19:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhDDRlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Apr 2021 13:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbhDDRlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Apr 2021 13:41:53 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1A4C061788
        for <linux-kernel@vger.kernel.org>; Sun,  4 Apr 2021 10:41:46 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 91-20020a9d08640000b0290237d9c40382so9441319oty.12
        for <linux-kernel@vger.kernel.org>; Sun, 04 Apr 2021 10:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ti6WoHsz7Zlbgo2CzLLD8u2iAE4onCIPC/xc2UxmFJs=;
        b=q7v/ZtoIP6tiq3K9PiNpnwNtZ7tXoCUN7Wsms2gM+yxytM2550C9QiP3fiZd6v20ug
         TuoyppMtIhuGFOGdqcYNh08ib9q2Y7pDmim+rebTtYoKt1rOhnW0q/lMFh5GDu6W7nHp
         BPjrgsqIwAKuFD3lny1YEauIWppCuZO1jahaJWxbyCOvbhE6PNdebjdrLCGQzhXyQDP3
         aFidUd8qw50P/c0rU484OJkPwY1erBF57E+VEADiQlSZbNBkTif2lhWPBeT3xVTm0Oh9
         IvxCJpujVcJ+BVv4WKm+6r17zkMf13L1GF4v/akRU+ed86aXP4X+DDWK92T1gTx/pJX8
         J+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ti6WoHsz7Zlbgo2CzLLD8u2iAE4onCIPC/xc2UxmFJs=;
        b=pa1FgT/wYgr/oM2uc66mPDwvXgvLSTEP5zz0eF9rm4FymOndJ1dZtNLRbLZj+aq/wA
         QTmsf14o8qd7Gxo6oledix0AM/WVph0TJLpxgIF0FyRt/NJBgKil1+JKESgjDHKE4fnv
         K2NrK0iYvalmu9AW/4w0B96pDu4hS2jfg+JViId5OAr5+3BhCzm3B8oyUJY7iddfiFbH
         238vxkeStpewEKnhi9u6d2V2l+UUyb0ac8yWacwotgI5F2qwnk56S3TwVLvZhJyqtxHK
         LyP/zUheN0MYG9tGezImUDg4vl/C7mVZe8CvZIPzx93NMqhAVE7JVK+YxkZIAU0RQJ/v
         naWw==
X-Gm-Message-State: AOAM5328xNBZ4Jz5rXko4PKyB15Ayx43h8lqznlcxPhU2Ea1sTlebyVK
        zKvyGM6nBezEwkNbwMQYzJElVdYQh5p3ww==
X-Google-Smtp-Source: ABdhPJz4dn7UOTKMDQfK19GfRDF9/qJYqjtbL8usgrR9XGnRSKr6pbZ1f8hG7SCNoqNAg0GYbLIxOQ==
X-Received: by 2002:a05:6830:210e:: with SMTP id i14mr19342717otc.229.1617558106129;
        Sun, 04 Apr 2021 10:41:46 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 62sm3404698oto.60.2021.04.04.10.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Apr 2021 10:41:45 -0700 (PDT)
Date:   Sun, 4 Apr 2021 12:41:43 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     satya priya <skakit@codeaurora.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, kgunda@codeaurora.org
Subject: Re: [PATCH V2 0/5] Add PMIC DT files for sc7280
Message-ID: <YGn6V6/hhXb1WaIc@builder.lan>
References: <1617268396-1837-1-git-send-email-skakit@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617268396-1837-1-git-send-email-skakit@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 01 Apr 04:13 CDT 2021, satya priya wrote:

> Changes in V2:
>  - As per Matthias's comments:
>     - I've Split the patch into per-PMIC patches and one sc7280 patch
>     - Removed 2nd critical point, thermal-governer property
> 	- s/pm8325_tz/pm7325_temp_alarm and s/pm7325_temp_alarm/pm7325_thermal
>     - Fixed few other minor errors.
> 
>  - As per Bjorn's comments, replaced '_' with '-' in node names and moved
>    DT files inclusion to board dts.
> 
> This series is dependent on below series which adds DT files for SC7280 SoC
> https://lore.kernel.org/patchwork/project/lkml/list/?series=488871

No need to mention this dependency, as you posted this after said series
had been picked up.

However, also picked up are patches from Vinod adding initial pm8350c
and pmk8350 files, so please rebase you changes onto linux-next - in
addition to follow up on Matthias feedback.

Thanks,
Bjorn

> 
> satya priya (5):
>   arm64: dts: qcom: pm7325: Add PMIC peripherals for pm7325
>   arm64: dts: qcom: pm8350c: Add PMIC peripherals for pm8350c
>   arm64: dts: qcom: pmk8350: Add PMIC peripherals for pmk8350
>   arm64: dts: qcom: pmr735a: Add PMIC peripherals for pmr735a
>   arm64: dts: sc7280: Include PMIC DT files for sc7280
> 
>  arch/arm64/boot/dts/qcom/pm7325.dtsi    |  53 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/pm8350c.dtsi   |  53 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmk8350.dtsi   | 100 ++++++++++++++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/pmr735a.dtsi   |  53 +++++++++++++++++
>  arch/arm64/boot/dts/qcom/sc7280-idp.dts |   4 ++
>  arch/arm64/boot/dts/qcom/sc7280.dtsi    |   3 +
>  6 files changed, 266 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/pm7325.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pm8350c.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmk8350.dtsi
>  create mode 100644 arch/arm64/boot/dts/qcom/pmr735a.dtsi
> 
> -- 
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
> of Code Aurora Forum, hosted by The Linux Foundation
> 
