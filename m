Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB05393EA7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 10:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236093AbhE1IWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 04:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbhE1IWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 04:22:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0814FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:20:54 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m18so1653958wmq.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EoggRuztRaQb06EHbjm5w3ArdngW4v/4mBdTsb5ErtQ=;
        b=koocXNzabsa+z2FZjXCuOMKjhuLbFaZf1RMaPtHcyc1fETT2PbmvaL43QH00369ajd
         QgjBJVTG/df2YG7O7p6TkLNTOzgSEQIE784hPljU2rcguhdKqh4Ep2TsgsCVHe6c/Mam
         AaKZn0SyF/rxX8xVxO5j9dVaXFTR8tdeLuWPE//zpd7PSkF0oR9IJmr4q+zR8pd6xA6Q
         mOh0axHU+5CZvFr1ntNW57kbn0g0np6K/peiuA8mEZALfD+x0yyLvDrak8FGcGIoCKFc
         89kmbSEFnk6Wjb++wMFWX35GZRf78oQleY6Fn2Cm9+8D9+HWA41a0BiCPhNPST6IsBFG
         57XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EoggRuztRaQb06EHbjm5w3ArdngW4v/4mBdTsb5ErtQ=;
        b=FKh9acVMPTZp9o+4wcP4YvFEhfbTebuEX1mTKM8cvkXfr2C9UGPm1X3VPfk6L2rxpK
         QIa31Ds73VKRHmhQAL1VRjo2vJi0u6XuymC7W/GHPJ0WEIxnRAIBWeabqtCXkIi1P33U
         oGNZBpLD9psc5Re1iH82RxrDnt8FggbQRd1Hnd1yZsu+Soe2wRH8woY33sovO75Ip2l1
         txOYnh4YLZSEjE45LscH2Ab9wagduoPdyBJPJCrJ7oLCeRpFMo3l9sj5uF28AN0zDVhI
         oHIlzepzyM1d2YQ1rQe82BKqGEvfDDew8mM7V6JbSPf70VvtfvRAayrU0ML7SnZDlUDU
         MSNQ==
X-Gm-Message-State: AOAM530esbuRe+Nrt5eTId4Xn/KKxrSc9FlovYvo6/NYDFPKeXuDtsIq
        LqlxwUuh7EVpghTHYahrGyjAoQ==
X-Google-Smtp-Source: ABdhPJytUinbQud6bM2Ds2pPY24+kKqOPqnVudJSoC+UQpyMiZK/m4xWzouaOvkQE4EjS6/OgGbDoA==
X-Received: by 2002:a05:600c:244:: with SMTP id 4mr12398190wmj.163.1622190052387;
        Fri, 28 May 2021 01:20:52 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:90c:e290:668d:49f3:7f84:14a7])
        by smtp.gmail.com with ESMTPSA id j10sm6068985wrt.32.2021.05.28.01.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 01:20:51 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Neil Armstrong <narmstrong@baylibre.com>, khilman@baylibre.com,
        jbrunet@baylibre.com, martin.blumenstingl@googlemail.com
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/3] arm64: meson-sm1: add support for Banana PI BPI-M5
Date:   Fri, 28 May 2021 10:20:45 +0200
Message-Id: <162218886298.197461.17389630028036069974.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210514143255.3352774-1-narmstrong@baylibre.com>
References: <20210514143255.3352774-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 16:32:52 +0200, Neil Armstrong wrote:
> Banana Pi BPI-M5 is a credit card format SBC with the following features:
> - Amlogic S905X3 quad core Cortex-A55
> - Mali-G31 GPU
> - 4GB LPDDR4
> - 16GB eMMC flash
> - 4 USB 3.0
> - 1 GbE ethernet
> - HDMI output
> - 2x LEDS
> - SDCard
> - 2.5mm Jack with Stereo Audio + CVBS
> - Infrared Received
> - ADC Button
> - GPIO Button
> - 40 pins header + 3pins debug header
> 
> [...]

Applied, thanks!

[1/3] arm64: dts: meson-sm1: add toacodec node
      commit: ddbdaa4d596396e3aa0d60a0ab023d19822a3682
[2/3] dt-bindings: arm: amlogic: add Banana PI M5 bindings
      commit: c53ab8f96af1f1fcaa0c1bc851a7704ae4b413d2
[3/3] arm64: dts: meson-sm1: add Banana PI BPI-M5 board dts
      commit: 976e920183e406726637db925efdf8b407a2d03a

Best regards,
-- 
Neil Armstrong <narmstrong@baylibre.com>
