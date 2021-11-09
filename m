Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9248D44B166
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 17:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhKIQr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 11:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbhKIQr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 11:47:27 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47161C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 08:44:41 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id f3so45716963lfu.12
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 08:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEScOF3/fw9hfeuyrd9ku7cHldjk9nIyGiDu/7seULA=;
        b=MR++4vZ4vG4FCKdpRBfywjVFO5yNCXuVnyv1/SHgE9HW9k/XqOQwpFHl9QKRjiSEU2
         woWqOTktxEX30PFTbvJooXG61MnKG8DZP3wwbe2mVbmYch9iWdD/j6enby+LlYeddg+W
         lkxeOBGxiIIm8gDik8QWNiKoi/8drzHwjOHEucz2nMR0nKBkKnjgjUX0ZIz2wHPvJlo7
         l0OJrJObWp4pjLN9/xT8SErv9qPt9O/TAAX/MuMSvrS5GiHl2oBqk4HV2gYcarHA9ze6
         qMaU7SbGOUPgRq6WjRKbbqICd+oddVFAP3vJ+Btcbe/yQKcKmHVbdjOyFrcacQtwOeOl
         Ef7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gEScOF3/fw9hfeuyrd9ku7cHldjk9nIyGiDu/7seULA=;
        b=P5mIyWyErNxwJK/Ag8shUaw5jFHOnOVDU8FkKVLT2VwOqV3UHxnTEjLOxEu9fDHp0w
         fLdvm+cgKXvXvSZ3gxFvY62/sf11EGOz5LI4axS7SwPxr+LPhCGzsSQxV5HHz+OFSv+p
         GRt8t/a5PZO86JxAiEpTO4vx7vTljVwlPHcLyR7CBAEjCphE/gJ8pXgKuLiEgZy2U0D0
         oFvJ9mQniAe2vB+azHH/Zi7VpX73Gfd4lNSff8ZqxawEZfxz+L1IS3lks4k6TK7Wulwh
         HbcdlbP02ig960RGptK3FkHqBN/4zR6hoaYyKxWXj9Vin+FRrjy73X94qOh6x4rX4MbR
         U9eQ==
X-Gm-Message-State: AOAM533BCFOdZEgi2kpyugrNaDTj0rpis7/Tv9tkXw/vmWK9Lt3/Fq/H
        YERuLnxvmIWhrMft2+AFk7FQXQ==
X-Google-Smtp-Source: ABdhPJxaqTeGSD5hAODwamYztqyOG/300aI6Te+SWZ1OufFDsvmu2hOQiEmiz8iRKsklyuQnYX/HNA==
X-Received: by 2002:ac2:4313:: with SMTP id l19mr8161739lfh.132.1636476278151;
        Tue, 09 Nov 2021 08:44:38 -0800 (PST)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id w40sm2189475lfu.48.2021.11.09.08.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 08:44:37 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Sumit Semwal <sumit.semwal@linaro.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: [PATCH 0/2] clk: samsung: exynos850: Implement CMU_CMGP
Date:   Tue,  9 Nov 2021 18:44:34 +0200
Message-Id: <20211109164436.11098-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds CMU_CMGP clock domain to Exynos850 clock driver. In
particular it needs to enable HSI2C (High-Speed I2C) nodes. This series
depends on CMU_APM series [1].

Tested via /sys/kernel/debug/clk/clk_summary:

<<<<<<<<<<<<<<<<<<<<<<<<<<<< cut here >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
                                 enable  prepare  protect
   clock                          count    count    count        rate
---------------------------------------------------------------------

clk_rco_cmgp                         0        0        0    49152000
oscclk                               1        1        0    26000000
    mout_cmgp_adc                    0        0        0    26000000
...
    gout_clkcmu_cmgp_bus             1        1        0   399750000
       gout_cmgp_usi1_pclk           0        0        0   399750000
       gout_cmgp_usi0_pclk           0        0        0   399750000
       gout_gpio_cmgp_pclk           0        0        0   399750000
       dout_cmgp_adc                 0        0        0    28553572
       mout_cmgp_usi1                0        0        0   399750000
          dout_cmgp_usi1             0        0        0   199875000
             gout_cmgp_usi1_ipclk    0        0        0   199875000
       mout_cmgp_usi0                0        0        0   399750000
          dout_cmgp_usi0             0        0        0   199875000
             gout_cmgp_usi0_ipclk    0        0        0   199875000
<<<<<<<<<<<<<<<<<<<<<<<<<<<< cut here >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

[1] https://lkml.org/lkml/2021/10/22/979

Sam Protsenko (2):
  dt-bindings: clock: samsung: Document Exynos850 CMU_CMGP
  clk: samsung: exynos850: Implement CMU_CMGP domain

 .../clock/samsung,exynos850-clock.yaml        |  19 ++++
 drivers/clk/samsung/clk-exynos850.c           | 100 ++++++++++++++++++
 include/dt-bindings/clock/exynos850.h         |  17 +++
 3 files changed, 136 insertions(+)

-- 
2.30.2

