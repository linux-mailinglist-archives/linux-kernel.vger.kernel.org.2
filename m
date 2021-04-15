Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B507360B6F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Apr 2021 16:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbhDOOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Apr 2021 10:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230056AbhDOOGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Apr 2021 10:06:15 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DFFC061574;
        Thu, 15 Apr 2021 07:05:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id n8so39500500lfh.1;
        Thu, 15 Apr 2021 07:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPiY+FwH2gRVnDBLwBz7oG10TpGLnHGvMx4jxp9Wvb0=;
        b=Bm/MilRSFScyxsdyRbsaFklFyVzW5XBChpPpkddUspJnlJHDAHL2WaNfbwL4YYzeYf
         HY97f36MnQnI4+C3p3BFnwKUPY+1weOoouiJrlc7atEw+PTHqEAas7g9rZ+EJGfkzfk6
         6Lph8E6+JfDGxLl97XzI/+uTehOYt/rkI8rNVq8BFD+UUfsYBjNvL1urIVvpyHkLc5ui
         gN273E+h4hVoopBQdRdbl/jOH/7IivhCEr1YYsvo7geoP64CBvyU8eJT9Pe4eBn+QCPC
         pS7Wk1a//Fib5HW41jbelDx2/DguRhnZxYp215mcPHca397Su/a1Tyn4W3LNklKhrJVX
         kh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gPiY+FwH2gRVnDBLwBz7oG10TpGLnHGvMx4jxp9Wvb0=;
        b=UINMxaPpPfkcrF8cUAXqUK3IDl/W6OAiR5TnIjt2oB8gbZuAndQgQlXiwwPpRqkR3o
         car6BWzcnsCD0sWt6eHmsxkihvJHiUz8L4oAHC0QRbPHa6qOZsy8WMEZfS4lH7dkc/kc
         kvinhq8DJEW93JyJXRvwc/NbK00Zt7IoOd7vExL07swfBcvGIO/g4ihRWWwq5mXGWw0C
         zHtFsZr4cTSv1/ii2fgZHaWXCVVZs1tSOVQWzpJP91QbZbia8jZhqcHENRlEqpwTuc3u
         BIFESLG2+8pXhfYbk5Opx07PA0NqJOTvT4z/T7YqV5qbQlEtahH489U94CvqmCLo/4OO
         1rjg==
X-Gm-Message-State: AOAM531WKkFrrw+rPuCNnnuMollSxV6Gbh91RSnrUPEhNjSQ9l+Gk8W0
        ffDxRxs3BDjMgNo5wWKmejqYkdkpwppzTg==
X-Google-Smtp-Source: ABdhPJxAeJyOtPFkQla5RZUI+PSioepyRmiAJnqiyvMHao6fbwWN5/M8/Izt4TBFrDdx2Ps0RJLv6Q==
X-Received: by 2002:ac2:520a:: with SMTP id a10mr2814536lfl.362.1618495548924;
        Thu, 15 Apr 2021 07:05:48 -0700 (PDT)
Received: from home.paul.comp (paulfertser.info. [2001:470:26:54b:226:9eff:fe70:80c2])
        by smtp.gmail.com with ESMTPSA id l11sm679210lfh.16.2021.04.15.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 07:05:48 -0700 (PDT)
Received: from home.paul.comp (home.paul.comp [IPv6:0:0:0:0:0:0:0:1])
        by home.paul.comp (8.15.2/8.15.2/Debian-14~deb10u1) with ESMTP id 13FE5jxN011398;
        Thu, 15 Apr 2021 17:05:46 +0300
Received: (from paul@localhost)
        by home.paul.comp (8.15.2/8.15.2/Submit) id 13FE5hEH011397;
        Thu, 15 Apr 2021 17:05:43 +0300
From:   Paul Fertser <fercerpav@gmail.com>
To:     linux-aspeed@lists.ozlabs.org
Cc:     Paul Fertser <fercerpav@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm: dts: aspeed: tiogapass: add hotplug controller
Date:   Thu, 15 Apr 2021 17:05:00 +0300
Message-Id: <20210415140521.11352-1-fercerpav@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADM1278 IC is accessible on I2C bus and on both Wiwynn and Quanta
Tioga Pass implementations a pair of parallel 0.5 mOhm resistors is used
for current measurement.

Signed-off-by: Paul Fertser <fercerpav@gmail.com>
---
 arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
index 3cc2004fa2f2..500661956dea 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-tiogapass.dts
@@ -591,6 +591,11 @@
 &i2c7 {
 	status = "okay";
 	//HSC, AirMax Conn A
+	adm1278@0x45 {
+		compatible = "adm1275";
+		reg = <0x45>;
+		shunt-resistor-micro-ohms = <250>;
+	};
 };
 
 &i2c8 {
-- 
2.17.1

