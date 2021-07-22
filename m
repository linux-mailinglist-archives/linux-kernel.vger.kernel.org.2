Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD133D2756
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 18:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbhGVPb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 11:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGVPby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 11:31:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240B1C061757;
        Thu, 22 Jul 2021 09:12:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id i94so6518330wri.4;
        Thu, 22 Jul 2021 09:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zst8QWS9wJcufrSJq8cn6Yi8f38cET0pmK8IThgydIc=;
        b=M2hUKSI68kKEBDfWO47+Amg8uxCWD5J4+fkI2bNhMN5wbGrFC4VGUpdDVKdn2aSJ0D
         8CoxyKcI92o+WtYXemT3lhBklzf5SyhNV/K81nmZGXYCShHR2cxXeltc/6plV9tPys5Q
         v2rJ3ffTlUL98O+2ehYUSkxwYWI25kz23v52gqlsQD2bwNt84kcacy8psazBU0CrIzDO
         +YB5ScJq6MfDwObEvVLKtqGEGvfRRz5aO5xNU/pWl4Nfi2vAswcOW0BTqmsQ9rriqvm+
         j+4/MC8BfFAsVMJJmN4ZZmkfkUfm/xrzTW54joFPWK37o9A3THjg7OcMgungdTIzHigJ
         dadQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zst8QWS9wJcufrSJq8cn6Yi8f38cET0pmK8IThgydIc=;
        b=mHoCwVw7j6+Vz7TNJR0vINu2q79cBC3aI2A/4xafBBXMIPfNR6TynFvWMZrsPGFEjm
         aiJa2JP0N2C8qBr0vtiM1WChRjd1Csr02fkb7ZvFH4Nj44npm4nLn49K4v24/pcp1T3t
         77RSaXTkj2odrBpJMq72mMw8MXuI6yhwVJmq7GAY43zWpF1CqFueyewy1gTnKNDdCew/
         cjpy7jX7TYUd+xcQPZQPHFxar1Wo5bq4g8seGKkR/Q+Q+/SbbUE04lsoqiOlpe5IdV5S
         +doYQHW3eSpLYfOB2V+9VjRDsmtM1Jkb97mhlWicUsM48NXeO/o6QQFQ+DRyqX42uIBI
         YFiw==
X-Gm-Message-State: AOAM533aQ4j2ZSM1CwZQ/j/SXSwMO2Ex3AtyN3H7i1Oc9s6+hdA4zxS3
        9mXWQuPNhPZGKiqmcX8Yv84DDdpdpGLL5JoO
X-Google-Smtp-Source: ABdhPJy/k15RJ7Q3aQbvZX4M3mqsTXXPmO7taXgfUcuksfH4NZcIRUMr214cVnZVemve7sija4A1EA==
X-Received: by 2002:adf:c448:: with SMTP id a8mr724940wrg.103.1626970347778;
        Thu, 22 Jul 2021 09:12:27 -0700 (PDT)
Received: from kista.localdomain (cpe-86-58-46-198.static.triera.net. [86.58.46.198])
        by smtp.gmail.com with ESMTPSA id z6sm3585363wmp.1.2021.07.22.09.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 09:12:27 -0700 (PDT)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, jernej.skrabec@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: allwinner: h6: tanix-tx6: Fix regulator node names
Date:   Thu, 22 Jul 2021 18:12:18 +0200
Message-Id: <20210722161220.51181-2-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210722161220.51181-1-jernej.skrabec@gmail.com>
References: <20210722161220.51181-1-jernej.skrabec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Regulator node names don't reflect class of the device. Fix that by
prefixing names with "regulator-".

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index be81330db14f..02641191682e 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -32,14 +32,14 @@ hdmi_con_in: endpoint {
 		};
 	};
 
-	reg_vcc3v3: vcc3v3 {
+	reg_vcc3v3: regulator-vcc3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "vcc3v3";
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 	};
 
-	reg_vdd_cpu_gpu: vdd-cpu-gpu {
+	reg_vdd_cpu_gpu: regulator-vdd-cpu-gpu {
 		compatible = "regulator-fixed";
 		regulator-name = "vdd-cpu-gpu";
 		regulator-min-microvolt = <1135000>;
-- 
2.32.0

