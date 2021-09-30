Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD4541E1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 20:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344172AbhI3S7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 14:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbhI3S7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 14:59:31 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74611C06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:57:48 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id n18so7171932pgm.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnzhfOKOJZwXoB/tTHTiy8y1Uvk2z9itqVPLfpQ/E2o=;
        b=BlRWjiTQWUA9jq/gVqi+31U/NUWHs478NFv92nPVvRgFFmriXt0b2FbdBPTAOWFj2X
         WOux/XmwHmCp3HxT5V6GVmjZcZ8t5muOZFeiQaeZdsylYqYw+qtI7WmtjKyTj9M+JTXc
         7xE6xaTMqCz5bFJaISRfvkrZlmzyDXF2avLvtecjix7/chY2euHCGHBtXZVnNpeavp7N
         /d61awiLZocViItuNXB9t/KkEO+FZvZavxN1dFZsHqsP0rrvRQTgF6GhgddIctN/Cctv
         xKURo95OsthT5Kn6WCV6ipbgaGSPOpTDMNq3OQwEybn2H5lcOk4uQuDku6IDsMP84ymo
         JqlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnzhfOKOJZwXoB/tTHTiy8y1Uvk2z9itqVPLfpQ/E2o=;
        b=p3yOGofbZtQnEF6fOfUp3VGqyt/DT3dgjZ386SmF3GuuKwp33c+GJ0XAaKc6DNmjGV
         IreobZeQRplwG4HNss2ivcOQI2Kft//X2UINEcBFsjkKM6xMDUHmaXYzdx+JpaVJjEnn
         GC5LZs0P+79QT09BzKCP8Y9kEK+4V9Q7C9nk8bmsZJMECJEC5jAITrOEZw8JrUCvuuBx
         rB0LeXgr8APA3cYaAcLQh+njvp6pM5hXnDMVFrqjWSruaaWgf4YpMZXBL51QqwCVnBHQ
         g2XIWleCx3g+1v2YPY2MwJhydSF7BEagOkARxcjbPCl6qzLvTt5wEg0yOWuZ38eSmFJS
         zxKA==
X-Gm-Message-State: AOAM530GUjis0w+b+RZ8qFE8vWSn5E19ZEy5S5ccvUUSpkszYaVsk4b/
        o3JFoQ1r8S/TV1inTDdvyCZ8p27ybGWX2w==
X-Google-Smtp-Source: ABdhPJzPzuoI1ni2jtTQHFP2JvzXU4Ndo0d9bFu6WaJspZ4oKx1+B7qIZ2B92qhhWgkECn+2vcoJhA==
X-Received: by 2002:a63:e116:: with SMTP id z22mr3281880pgh.223.1633028267890;
        Thu, 30 Sep 2021 11:57:47 -0700 (PDT)
Received: from localhost.localdomain ([122.172.224.206])
        by smtp.gmail.com with ESMTPSA id l144sm3920997pfd.193.2021.09.30.11.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 11:57:46 -0700 (PDT)
From:   Amit Pundir <amit.pundir@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        John Stultz <john.stultz@linaro.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dt <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845-db845c: Add msm-id and board-id
Date:   Fri,  1 Oct 2021 00:27:41 +0530
Message-Id: <20210930185742.117928-1-amit.pundir@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add qcom,msm-id and qcom,board-id for Dragonboard 845c.
This will help us boot the device with newer Android boot
image header versions, which package dtb separately
instead of the default Image.gz-dtb (appended dtb) format.

Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 2d5533dd4ec2..a6ea5bb5f5cb 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -17,6 +17,8 @@
 / {
 	model = "Thundercomm Dragonboard 845c";
 	compatible = "thundercomm,db845c", "qcom,sdm845";
+	qcom,msm-id = <341 0x20001>;
+	qcom,board-id = <8 0>;
 
 	aliases {
 		serial0 = &uart9;
-- 
2.25.1

