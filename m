Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE18230AFA4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:42:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232749AbhBASmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbhBASOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:14:51 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234E9C061797
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:03 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id f63so12121923pfa.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CnVnyNqTZ1zzjJCrFT2+4AV5x1r9Ds8A+SATYgEzXLw=;
        b=jF+yWrdkivTBGi6/W8tX5H5x01E5l6AITQlQa9mM67G3Tjm1rvHZ9jM2Q5NEr56lPi
         VmpfIGEYyBVhZq7CMGyl3GRXu7mAe09JFS19wgeNWcCghYo0i2RzIwPb0pyNPsuMEZPy
         8FAXn/E+LLDYrvB9RZlDpAbwHuiPad1sBxeVLs9k8PhbnRl6gRcQoJIfuxJkLt2Pv1VH
         3Fhm2eRAaXpOVYsK/qPyWXslIrjRpZRNFHGAtkndSgNeEup3fT+nr33vBImzVJiK6mnj
         10ETO4J5pCEPqnA1rQPhmOk4kh0fEa8D9hYvO0v31nmORsbWlMwrzm4JiEnYKM5BKNZh
         fXYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CnVnyNqTZ1zzjJCrFT2+4AV5x1r9Ds8A+SATYgEzXLw=;
        b=UAvAMZo7989pSAHP+EmmU4PCTE0YqB81gU/zAzcZIcU6dMsklNQaXzui3LaISMOIW6
         okPiIa/1J3lrzJU9EwepgbQgB6EpL3Re2mbhjIhIONabpkLK8S7P5H2fRYNsOYygOCGc
         Xl+nN1HM+ptVCjb/MNkeJsH9nNFLF877NhzyedvesxE/NI/EXincbe+dDXSKus/RPVGa
         23o2kZV83cBpT//3KNoUP3upmY/g9Qppek/HMF0Z3NVNMBdkry9kuigqgsNr0DFg+5Wt
         HfcZt59w1jjVuFYtpPIJop8Iu/JDIpoi9TOFyqp11n4ve7o5kU+9UvFsG39kwEHRa5yg
         7n5A==
X-Gm-Message-State: AOAM531PZ2is8Ljr3O4asey8JNPrrkkle157BwmOL5kXTI+w46YpcvvN
        IL3HYHvc5tSRA8cttxY0RFHZ9w==
X-Google-Smtp-Source: ABdhPJxWANO/umUDUgrviRdL+IMi52eSuWeOHTFEOlYeZYuFSQc4Dzl6GknsGI4twhiiunAirey4iQ==
X-Received: by 2002:a65:418b:: with SMTP id a11mr18278641pgq.231.1612203242770;
        Mon, 01 Feb 2021 10:14:02 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:02 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 09/31] coresight: etm4x: Always read the registers on the host CPU
Date:   Mon,  1 Feb 2021 11:13:29 -0700
Message-Id: <20210201181351.1475223-10-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

As we are about to add support for sysreg access to ETM4.4+ components,
make sure that we read the registers only on the host CPU.

Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210110224850.1880240-8-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 .../coresight/coresight-etm4x-sysfs.c         | 23 ++++++++-----------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index 989ce7b8ade7..c4781d4e5886 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -2344,23 +2344,20 @@ static u32 etmv4_cross_read(const struct device *dev, u32 offset)
 	return reg.data;
 }
 
-#define coresight_etm4x_reg(name, offset)			\
-	coresight_simple_reg32(struct etmv4_drvdata, name, offset)
-
 #define coresight_etm4x_cross_read(name, offset)			\
 	coresight_simple_func(struct etmv4_drvdata, etmv4_cross_read,	\
 			      name, offset)
 
-coresight_etm4x_reg(trcpdcr, TRCPDCR);
-coresight_etm4x_reg(trcpdsr, TRCPDSR);
-coresight_etm4x_reg(trclsr, TRCLSR);
-coresight_etm4x_reg(trcauthstatus, TRCAUTHSTATUS);
-coresight_etm4x_reg(trcdevid, TRCDEVID);
-coresight_etm4x_reg(trcdevtype, TRCDEVTYPE);
-coresight_etm4x_reg(trcpidr0, TRCPIDR0);
-coresight_etm4x_reg(trcpidr1, TRCPIDR1);
-coresight_etm4x_reg(trcpidr2, TRCPIDR2);
-coresight_etm4x_reg(trcpidr3, TRCPIDR3);
+coresight_etm4x_cross_read(trcpdcr, TRCPDCR);
+coresight_etm4x_cross_read(trcpdsr, TRCPDSR);
+coresight_etm4x_cross_read(trclsr, TRCLSR);
+coresight_etm4x_cross_read(trcauthstatus, TRCAUTHSTATUS);
+coresight_etm4x_cross_read(trcdevid, TRCDEVID);
+coresight_etm4x_cross_read(trcdevtype, TRCDEVTYPE);
+coresight_etm4x_cross_read(trcpidr0, TRCPIDR0);
+coresight_etm4x_cross_read(trcpidr1, TRCPIDR1);
+coresight_etm4x_cross_read(trcpidr2, TRCPIDR2);
+coresight_etm4x_cross_read(trcpidr3, TRCPIDR3);
 coresight_etm4x_cross_read(trcoslsr, TRCOSLSR);
 coresight_etm4x_cross_read(trcconfig, TRCCONFIGR);
 coresight_etm4x_cross_read(trctraceid, TRCTRACEIDR);
-- 
2.25.1

