Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDBA405988
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 16:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348119AbhIIOqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 10:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhIIOqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 10:46:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EADDC0698CB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Sep 2021 07:34:29 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q11so2875561wrr.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Sep 2021 07:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nTTI9fJR/qM7ozJYSx1rxkor0L9sEKASsodkOmW8A8=;
        b=fIa8tYe0sEqJnaZ53jWh67g8LVs64Kam7BGgDNvI+68l8fld//reUe1tdelEj4Z+3p
         MI605fr+zVcVUvGfe8aX6qo94alDXJnk7idIEuorKUQRvVRz9VgVW7MaF82X/BbjGst8
         cXyB+RuIzfwLYM2E/EEB/sPLx/AL2JiRAt+YWKA/ZPo79cPPIAadJXBR7Q7NWykMQLwE
         3X8AtSEUqcazA5acWXIOvqmaoko2nASb0DwF5shSZk+XcdFazsIgpgPQYK9BvtD+6CBh
         5DPmqT9VUZPTHbWnh049Jym/sSKMjxGaIZQQuPIpU9TqdTaPNBqP032nsP4yByPvcFXE
         Eo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0nTTI9fJR/qM7ozJYSx1rxkor0L9sEKASsodkOmW8A8=;
        b=EOKFbFNFNexN2H7vZZ7npj/9ra+AXZgLaFi6wb3l8Ty50nNvmrLWPIcAJmltZtGACf
         5abyqeLy1v91Rt42oz6NPmuSfPB9I6siotySqYZsk4Cm77y062uB77EpwT06TEZGT0Gy
         DCmXBi+xL7jQtf5AfWzYVZJFOmgQLpE2Nci7ck2E9iUgUFfCPxzZpzqAdoGVHxWUHkOy
         vdc69vp1woaPsrSofky9stzcNaqI2uQVlPvr3xLbZGHllM4iEF2GhiccCM0m0n5KMuAd
         t2rTa0LIMKnjFKdbC1Cx1SLSSJArgLVVTzipkGkT9bb2o1UKmdImVBqfgcIXwqNkCH2b
         Wx7A==
X-Gm-Message-State: AOAM533t/W4Zw8qfFuceivGgNOYPIv1/P+3i3ChCULFIPrt2LFEMTB2R
        kCQu0mh/RO7twTrWnRo2G80HyG6jS71fng==
X-Google-Smtp-Source: ABdhPJxE7rceeVQrDJHc/kI5y512R8aGvkYcPrPtasecjxsQ1UrBAs2ubz4WTbKTUiGVx0v390FSAg==
X-Received: by 2002:a05:6000:10:: with SMTP id h16mr4109692wrx.24.1631198068069;
        Thu, 09 Sep 2021 07:34:28 -0700 (PDT)
Received: from localhost.localdomain ([95.148.6.201])
        by smtp.gmail.com with ESMTPSA id f18sm1709423wmc.6.2021.09.09.07.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 07:34:27 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] mfd: b4: Submission for testing out b4
Date:   Thu,  9 Sep 2021 15:34:26 +0100
Message-Id: <20210909143426.1334054-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not a genuine patch.  Nothing to see here.

Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 578db280dedf8..c582f73dc4d97 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -2,6 +2,7 @@
 #
 # Multifunction miscellaneous devices
 #
+# Testing `b4` - please ignore this patch/mail
 
 if HAS_IOMEM
 menu "Multifunction device drivers"
-- 
2.33.0.153.gba50c8fa24-goog

