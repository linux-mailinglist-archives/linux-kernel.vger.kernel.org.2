Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D7B3E021B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 15:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238227AbhHDNfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 09:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhHDNfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 09:35:06 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FDDC061799
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 06:34:53 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 14so2720062qkc.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 06:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSfNtUyU9x/YGEG2BT0B9uxjpaTMgrW+GMW+Gx0V97Q=;
        b=TpJYOKtrBFCaIgXuJrcHTL9EdQQt/csWAYYnG/TNqSXdjlttxf00i3FumuVwQpC/i0
         pyfQyywmeGDkG/1pH3aozxBecjgdjvF+ryY1UQ2NFBsNKqfCflLMbOzmDqL4qk/UYiJy
         js9SGtFIVZ+rhbM66/odc+gGx5HYgIko2j2ShmUO5qJgoiQig132zbESQ5bK//hFwj1c
         oyueGqgnhmdwYSYBk/5UjslheYVPlT9RMCqXz9RHPdBNwNKkkJMZvtt573O0tECXCWV/
         lkmiok0E7LQpt+rvED+wrD/Ln7HahrGdtgWIyvCItrhGEPAK1RFNudkEuAz3/xqjvXiX
         Qr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XSfNtUyU9x/YGEG2BT0B9uxjpaTMgrW+GMW+Gx0V97Q=;
        b=ltSxOvbH+qfxjGwvV0QuJ8PWB2WjRTwDSXjtafnP/FBh/iHbKeldeI9UkFkcRL4nT9
         9S5We6Rv37N4vvJtrH97Sq0ndWAWJMyrIWhgYKl8iKWIWZClYlcye4NKnhvyLEv3L5s7
         w6P0nl5BCFutlw3heaOaCLsSKgjTRyRbtFWVu/ucdPqy/0FucHiWsq2Wu2ysFi7Sq2me
         kgIig6jvTndMOJr87pbhiYx3pAzVPOalFuaBP3qXtVv3DIEHipCDajCTFNAsNIt6KN8O
         wgDlsz9pVHLVz3yKsY7ZzkrR4CC3gME8oFf3QCOvjLtb89pKOijmfJtGf++P0BtjN663
         h/QA==
X-Gm-Message-State: AOAM530FqTxpY80QFLf/iCU9hUS02DuqCms9IVXcjc809qWcb9wL7niE
        byrXngrILnW3j5703+rpYhmVQA==
X-Google-Smtp-Source: ABdhPJyk5Ylha0tBS0IPdf6k19JH5IiOL/TMwax3CAbXwe5mPVxvRQa2P0A+g9mDDJAgyUrioDgaTQ==
X-Received: by 2002:a05:620a:448c:: with SMTP id x12mr26075570qkp.39.1628084092359;
        Wed, 04 Aug 2021 06:34:52 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id z23sm847908qts.96.2021.08.04.06.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 06:34:51 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org,
        bjorn.andersson@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] cpufreq: blacklist Qualcomm sm8150 in cpufreq-dt-platdev
Date:   Wed,  4 Aug 2021 09:34:51 -0400
Message-Id: <20210804133451.2503674-1-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm sm8150 platform uses the qcom-cpufreq-hw driver, so
add it to the cpufreq-dt-platdev driver's blocklist.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 9d5a38a91f10..231e585f6ba2 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -141,6 +141,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sc7280", },
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sm8150", },
 
 	{ .compatible = "st,stih407", },
 	{ .compatible = "st,stih410", },
-- 
2.25.1

