Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F52145E843
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 08:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359216AbhKZHM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Nov 2021 02:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359115AbhKZHKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Nov 2021 02:10:45 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB0CC06175E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:42 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id j6-20020a17090a588600b001a78a5ce46aso9325508pji.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 23:05:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n3D0/obh+8GDy4NXpRzCcn/wksmLWSbTBh0aXEdpFCE=;
        b=ro65tUWhtJIjuY3swffGValIXVWIqHNXfKUfHp6mfXD/qpjHD8haXq/JoIP1128yZ/
         pKHxuCfKO1FA97DbbhPsAJMvo5PBi849ReGu+CMvsVN2wKS0sqZeZksRofWbJSSLXagf
         hLwgkmhp4qsgqXLAFzToo6OTpEP7gRa61NbJ4IGX5RxuEvUFr/tBKAVus0MUmZgqzppY
         i3F83POY6HFMfSkeh+PFcLDGGR7paYJm0WllNH7X6zsTdp/O5fr55HmugPfOCEDuzRwi
         D8WW1qNC2lSG+Zaj4UIWB7frSCoegqIrZ7g7US5rkl8aAAEc1isV0PjrXFDiouj/zDk/
         8TAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n3D0/obh+8GDy4NXpRzCcn/wksmLWSbTBh0aXEdpFCE=;
        b=stQiDyBXXij4N44lsNRW+dict3AfHpth6h8jxWdV1Zkdc5wLjpjZ3l7RZi7V2FLmdS
         ntYXagAF/DLPYZeZ/qPdwX6UCcWtUAxhv8XNcwOZN2uK+H//oeyWuhWGqTBS2vgiFluP
         YMW3NCd+RX7YAsrC+0MSmxOdvIfMx0sJKEAtCe6ifvGdXXfzqKjx2jJhFR9VJWQJnD2t
         cDOXFPVfxvhufSWULCxrJeHaIBZ+xWmEcIux8J3sMz83zFycGy2XjDbzoJyS7QUVpxZU
         pqJaTAm/z97IFbQ7SfcbRrMoqIUmK+4+AbKSr4N8ZWrQm9NSn6qHXHWgiQ4z7FjZ14Dv
         PkWA==
X-Gm-Message-State: AOAM531qz7loVZAcb6XQNCuEKuDF9YWgH6avYH5/qX763OxPTFUeTU/d
        xCif4jeq9is2FVMrZX1A8vZNEwbLalcE
X-Google-Smtp-Source: ABdhPJzKiBbRjTyDR5yzChLw+2o8Qnzvqhbx4YlFIRRMZU1zRnuU71MH9eWlM8kSdLOW1ntVb7tH5Q==
X-Received: by 2002:a17:902:dacb:b0:141:e931:3b49 with SMTP id q11-20020a170902dacb00b00141e9313b49mr35342773plx.45.1637910342291;
        Thu, 25 Nov 2021 23:05:42 -0800 (PST)
Received: from localhost.localdomain ([117.215.117.247])
        by smtp.gmail.com with ESMTPSA id d12sm4042104pgf.19.2021.11.25.23.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 23:05:42 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 6/6] ARM: dts: qcom: sdx55-t55: Enable IPA
Date:   Fri, 26 Nov 2021 12:35:20 +0530
Message-Id: <20211126070520.28979-7-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
References: <20211126070520.28979-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable IP Accelerator (IPA) on Thundercomm T55 board for getting data
connectivity from modem.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm/boot/dts/qcom-sdx55-t55.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-sdx55-t55.dts b/arch/arm/boot/dts/qcom-sdx55-t55.dts
index 2ffcd085904d..7ed8feb99afb 100644
--- a/arch/arm/boot/dts/qcom-sdx55-t55.dts
+++ b/arch/arm/boot/dts/qcom-sdx55-t55.dts
@@ -236,6 +236,12 @@ &blsp1_uart3 {
 	status = "ok";
 };
 
+&ipa {
+	status = "okay";
+
+	memory-region = <&ipa_fw_mem>;
+};
+
 &qpic_bam {
 	status = "ok";
 };
-- 
2.25.1

