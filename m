Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACED440BDE9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 04:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234683AbhIOCzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 22:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbhIOCzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 22:55:49 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46228C061766
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:54:31 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id j66so2183476oih.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 19:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BZeoBKUFa4ew4uv0EZ30vPzxQarHfe3j0m8mhnfs+zw=;
        b=JcqNRZTiVw3QdMoQVVGBc+8k5VQThZIIlM6OMkWDZXKT/CwqCvnHfe3/HAV3ZctsOs
         W8K7MhJVU/xzn6g8TJpc1/xHNhR5YEbhZVrmh60VRZkUwRXGZMOb3peAv3hyUVreL9qG
         S4xHC8SbOocObLCSheCrObrrZz7VgGeomQn4aqYIRmzXVZDO12+thgbz19R9uU8YVvzo
         HxuEPlelMKe1sw6m+KQP/ElHXWNhakdgniKAo7i27ZQhjY5RQ3DukB9GdtQnjA4o3xxU
         KKxbgBeP/RXg22B7l9P7f1bwjW6cuidiiCu3hd3tkMnloWIQ4LsjI7gFgRPSvZFmGCkO
         Kz4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BZeoBKUFa4ew4uv0EZ30vPzxQarHfe3j0m8mhnfs+zw=;
        b=zQWkY1s9GtaxEmpSQkqIhtEZs5kxtc5o9BjnNiRcienA6YzjOEq3RCPCZUZQjpTN5d
         zrc07fOSRXBdy55hg33yKshuy/kBGEH+O15JFXqbB/RX+TZMDZJEeaVAwwEq8/ianuBe
         3phJrJYqxgCJkqq4bJqGD4l9vgEziwrTcws8TTaC7FKnp/z6x9wExhT8PSbge+ff6eeC
         IFbVWx7WjW3yKPCSoacWeUVTdoOqWPfwVOWcBiHbWjfTzA7uxyF8Ui4w5Rbv9kiLOGn0
         3b2igaVhIlpF1Or2RqorW0m0R67h2PM4UwuJvnche+adrYwK5avu8N1iU7Cl6D5hFlfh
         X94g==
X-Gm-Message-State: AOAM533CginnnyO1LjChKSvXYBEFJdEQLuZuxkot6T3LC5ViVFbKsZ3u
        SQ86Hg2+xI6rpmPzlQe+VmZ6wQ==
X-Google-Smtp-Source: ABdhPJzbdhz88XinGhshynrR89pS2iPgi7Zypps5yKSPbFugPDtM4QDa/rKa8jNWUlN/gUKSY5bC9g==
X-Received: by 2002:aca:6041:: with SMTP id u62mr3737643oib.82.1631674470457;
        Tue, 14 Sep 2021 19:54:30 -0700 (PDT)
Received: from ripper (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id k21sm3037906ots.53.2021.09.14.19.54.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 19:54:30 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:55:21 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Shawn Guo <shawn.guo@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] clk: qcom: smd-rpm: Add rate hooks for
 clk_smd_rpm_branch_ops
Message-ID: <YUFgmdhYK/p2v1LS@ripper>
References: <20210914025554.5686-1-shawn.guo@linaro.org>
 <20210914025554.5686-2-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914025554.5686-2-shawn.guo@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 13 Sep 19:55 PDT 2021, Shawn Guo wrote:

> On QCM2290 platform, the clock xo_board runs at 38400000, while the
> child clock bi_tcxo needs to run at 19200000.  That said,
> clk_smd_rpm_branch_ops needs the capability of setting rate. Add rate
> hooks into clk_smd_rpm_branch_ops to make it possible.
> 

Most platforms has a crystal oscillator ticking at 38.4MHz feeding the
PMIC (represented by the rpmcc and its "xo" parent) and out comes the
bi_tcxo with a fixed 19.2MHz rate.

Is there a problem with the way sdm660_bi_tcxo is defined in this
regard?

Regards,
Bjorn

> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/clk/qcom/clk-smd-rpm.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-smd-rpm.c b/drivers/clk/qcom/clk-smd-rpm.c
> index 66d7807ee38e..2380e45b6247 100644
> --- a/drivers/clk/qcom/clk-smd-rpm.c
> +++ b/drivers/clk/qcom/clk-smd-rpm.c
> @@ -416,6 +416,9 @@ static const struct clk_ops clk_smd_rpm_ops = {
>  static const struct clk_ops clk_smd_rpm_branch_ops = {
>  	.prepare	= clk_smd_rpm_prepare,
>  	.unprepare	= clk_smd_rpm_unprepare,
> +	.set_rate	= clk_smd_rpm_set_rate,
> +	.round_rate	= clk_smd_rpm_round_rate,
> +	.recalc_rate	= clk_smd_rpm_recalc_rate,
>  };
>  
>  DEFINE_CLK_SMD_RPM(msm8916, pcnoc_clk, pcnoc_a_clk, QCOM_SMD_RPM_BUS_CLK, 0);
> -- 
> 2.17.1
> 
