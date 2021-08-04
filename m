Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C613E0210
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbhHDNcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbhHDNci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:32:38 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE04C061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 06:32:25 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d2so1359515qto.6
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 06:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=civBfwB3HrpSlIjKk8pP7evwtiL4N367MAc+aTcz/k8=;
        b=tYDhB8XRdjWX2pDVyog2BICL0SGFaer15flROq24PNXXcS94H0XULaC4ZFrvA/A3Oi
         oeNKF3UKbuqZgvrjs/x1qA4zpLNZfhBH/anCiPcpYktQ6HcXYNFdV/RDs7pv4KHp7C5C
         Q1FWEfzD8Gd8Ov8L/I94J2VWyuK5XM0nvzlN4wOblnVbZ5p1A2hngv04a61V0UdgB/5u
         Ve/eJHWyv/SwrYBfq+NVPtWdEevzbxl9X0fORMy/xcLw5dEdGDndftIlChCZ505cTm39
         5w9hfkbdLimiDUfBRqvrZQ04U6z9tDEHcRkjt25uyktHYK0nEybRxuqo0xJN3ACPqxtX
         cvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=civBfwB3HrpSlIjKk8pP7evwtiL4N367MAc+aTcz/k8=;
        b=JljoOgOipDvEeK1FtcjgL/Ki7iLUlXrqVS8EEaXKuZdye0yfsb8g7cgVuvA+Pq3H39
         4+bRaYo4Bsh0YomreNV745yYE/EY4gfmr7AVSdD1CI8EBrnapotgdn+0hNJ4P7V9riva
         xvvYHMpbIr44CGX1NzeaSfVosUWtP4RIsRQqqGyR7qR+YCg/EMz5XCnC0l0L+dkc/UsX
         wy51bjmkpkXP77RK/tEJ6+ZZUXj3JpZOL18/4ZUj/VItW4rc8a+YVfuNZlPK4WD3mSq5
         pHM1CFJkqa2PB4JchxrqMFM2Q8r3D+2kn8XF1LCigK1T6icHqKqmxB5kTt6CSKPigOA7
         /1bQ==
X-Gm-Message-State: AOAM530O04syBwE14PvaKMd8hg5526zOReGnbKySPFNsmdreDtO+XEhj
        Nx3kEriTYlaWbMoiEI6/bt/wyQ==
X-Google-Smtp-Source: ABdhPJwB+xMBFnnnZHgiFAmAyEYSPVcPjFjU8xKJn9wvvvbdkYQLO4ea69Dm1RaiYgT6jL1gJBrlzA==
X-Received: by 2002:ac8:7f85:: with SMTP id z5mr22980574qtj.354.1628083944949;
        Wed, 04 Aug 2021 06:32:24 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id r4sm860140qtc.66.2021.08.04.06.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 06:32:24 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8150-mtp: Add 8150 compatible string
Date:   Wed,  4 Aug 2021 09:32:23 -0400
Message-Id: <20210804133223.2503517-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add "qcom,sm8150" as one of the platform compatible strings.
This will be later used by cpufreq-dt-platdev to exclude using
cpufreq-dt cpufreq driver.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8150-mtp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
index 53edf7541169..b484371a6044 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
+++ b/arch/arm64/boot/dts/qcom/sm8150-mtp.dts
@@ -15,7 +15,7 @@
 
 / {
 	model = "Qualcomm Technologies, Inc. SM8150 MTP";
-	compatible = "qcom,sm8150-mtp";
+	compatible = "qcom,sm8150-mtp", "qcom,sm8150";
 
 	aliases {
 		serial0 = &uart2;
-- 
2.25.1

