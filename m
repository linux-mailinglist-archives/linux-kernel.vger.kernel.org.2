Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53AD442FA35
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242530AbhJOR0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242350AbhJORZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:25:27 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09831C061766
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:32 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id p6-20020a9d7446000000b0054e6bb223f3so13791925otk.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 10:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8GXf6iIkeLSmbnCwp/TnDsH3fwbQUD1XiOH8muSbIdM=;
        b=AzlT/VF3vNrvaXMA6yupvoTzvJVIPoxbKtPfW8YnVJaJ6TvF75GPEm8I4v8TBAuHwD
         xXYMe3/F5qzdc2toQmMpBJSi9ufh/kCygFWvbceu3OB5hvfjZenyOaoDv/DaCxg8Pr5b
         b3A+1O8vmB3bA6FY9c4XPjwoTNYLEvt4DEKLfLyVisJRLl/sj4+qjBYAS4JL+Aje633l
         UJ6BvkSmhvdUJYWiRgjmsebeqbbwUFMELtCNLmRyjheSv8M6Sq2bsWw1onXUQEIWWN++
         693DPX65oIdROYAMmDNG8DTq/cOg5xD9+/IHzoeqmtl72bYa+FJHBSrFOwpyxe+bKkmY
         g5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8GXf6iIkeLSmbnCwp/TnDsH3fwbQUD1XiOH8muSbIdM=;
        b=mWPN7b+VMX7JsZptsxlNGbnbz57OSjYw2vfKs7Glw2n0JAJCNe8PB952HMYR2gDGTx
         wZD00oup24WuccgRY6oGCxxltVuwdbjqRlcHDDacJyfhKaRgKZ/XP5A4d3AZmCx4vkbG
         EkYP6ZDNLTA4yn1KalMEboooo8QhKEgzGTv4fxST7n0oaRVOaPiZRCe+K5CZtoNeuMT5
         NSaoJ9whXERMK2fpxxLi/JD2ny0g8S0D/3TZHSKahMM1D8GGJzZ6TAnJ3/TGrZfPacDN
         7Dt+xwuX8gvJyHZccPAIoh6os1M+vAUAXBjPHMyPqKXMiAmbjXgXih0nQiBCkIb/NAcX
         YMwA==
X-Gm-Message-State: AOAM532HHqKvxEjbhAXwIYCDFJJnUIauE3cixeyJVK7hrDShOtIpsHzR
        7gx0ImnakZP+Qya7JwyfWpm/sA==
X-Google-Smtp-Source: ABdhPJw43C2jPHke2r6UygEFoXfBVXJc2rkJUM25RFmbv18wSheOEBVNo3sZzMCBhf8p+nKZSpfNiQ==
X-Received: by 2002:a05:6830:2805:: with SMTP id w5mr9028837otu.248.1634318549944;
        Fri, 15 Oct 2021 10:22:29 -0700 (PDT)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id s206sm1289635oia.33.2021.10.15.10.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 10:22:29 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        linux-kernel@vger.kernel.org
Cc:     dmaengine@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-gpio@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/9] treewide: simplify getting .driver_data
Date:   Fri, 15 Oct 2021 12:22:20 -0500
Message-Id: <163431847249.251657.9669509178222541492.b4-ty@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
References: <20210920090522.23784-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Sep 2021 11:05:12 +0200, Wolfram Sang wrote:
> I got tired of fixing this in Renesas drivers manually, so I took the big
> hammer. Remove this cumbersome code pattern which got copy-pasted too much
> already:
> 
> -	struct platform_device *pdev = to_platform_device(dev);
> -	struct ep93xx_keypad *keypad = platform_get_drvdata(pdev);
> +	struct ep93xx_keypad *keypad = dev_get_drvdata(dev);
> 
> [...]

Applied, thanks!

[1/9] dmaengine: stm32-dmamux: simplify getting .driver_data
      (no commit info)
[2/9] firmware: meson: simplify getting .driver_data
      (no commit info)
[3/9] gpio: xilinx: simplify getting .driver_data
      (no commit info)
[4/9] drm/msm: simplify getting .driver_data
      (no commit info)
[5/9] drm/panfrost: simplify getting .driver_data
      (no commit info)
[6/9] iio: common: cros_ec_sensors: simplify getting .driver_data
      (no commit info)
[7/9] net: mdio: mdio-bcm-iproc: simplify getting .driver_data
      (no commit info)
[8/9] platform: chrome: cros_ec_sensorhub: simplify getting .driver_data
      (no commit info)
[9/9] remoteproc: omap_remoteproc: simplify getting .driver_data
      commit: c34bfafd7c6ce8bdb5205aa990973b6ec7a6557c

Best regards,
-- 
Bjorn Andersson <bjorn.andersson@linaro.org>
