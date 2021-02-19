Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49A831FB12
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbhBSOjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:39:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhBSOjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:39:45 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31A3C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:39:04 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id l17so7277950wmq.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Feb 2021 06:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmA/KV9e2ZyA8lcC+WdH41u9opqrjZNkfCRBCxD5ZNk=;
        b=cxbgewZ+RPJiWcAUAkXPEywDNxuM8rjqCG/rwZgzCLyLrRfv1FEfE7mcUBTzM2cgux
         wNvTv2Xz4fM+1FFDjqyjPpAUX3chnK9DmpUOT0+VxEmlpj83QI9gLCRI4hmNcHRRsZyQ
         uE1LpkSUsRKqqmlWHRAyE1X2t40kROfatOfO5vc8BfDMJu1o2LKoHvjBvz3ZgdfqwIdr
         qg2qEua0ru1+Y7rtw2tuYQirWRLaQg4sIXrxUotnGMFa/eefhzaTH3RYq3OFGa9Rn6cI
         q+NfH/s94yKjL7UIklAt4RtgqIcvblhsDUurWlr9c8tXVhDxFT8dhVuAKm3A1EJETCIy
         fF3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xmA/KV9e2ZyA8lcC+WdH41u9opqrjZNkfCRBCxD5ZNk=;
        b=Jc9Dh1ikNkrxly3UisAlHafw4x8erwZvbTwPQZvKf7Du1er/QZE71Jmxlvv1XxQquz
         A6LErPVLLKv6Xsa1K8+qc+Et4kjtq9LX4jUYLRAc+8tLU2UKlNUSzK2ykj6erWQZ73VK
         zVKPzwj0RQ3Is+kWM/4HGrfFZ9wUAC/JFzfSR57P9O0itwdbnSuL+F6beQozkO9dv8Kd
         Dk8+3iTdzRSSCuhufqvcRBJrvVFBEUUzhN1EmA37elBnzE+9eIdPWBHC4N6SELjkHmeY
         OlD67fehXnUiViVym+PTAIYQZHrM1wqE/9v2XGAw5Y+V5imldNs7z1uUMK1DtPkK9g8g
         EbFA==
X-Gm-Message-State: AOAM530ttL5ymsInsTaSXEU2OxyIv8eROpK5v+xz8ILWi81VaqJ/U3Xh
        c1U6Ov6XkmY1/JFtIpYSXOE=
X-Google-Smtp-Source: ABdhPJyBOJobgDyI4nY0tMF/lTWSKS2eZrzryQBmz5QcUFuGrzd6EPuqh8J63on+3nD3BuilAYvLgw==
X-Received: by 2002:a05:600c:3588:: with SMTP id p8mr8423631wmq.71.1613745543530;
        Fri, 19 Feb 2021 06:39:03 -0800 (PST)
Received: from ubuntudesktop.lan (205.158.32.217.dyn.plus.net. [217.32.158.205])
        by smtp.gmail.com with ESMTPSA id m23sm11530694wmc.31.2021.02.19.06.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:39:03 -0800 (PST)
From:   Lee Gibson <leegib@gmail.com>
To:     mchehab+huawei@kernel.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Lee Gibson <leegib@gmail.com>
Subject: [PATCH] staging: hikey9xx: Fix space tab style warnings
Date:   Fri, 19 Feb 2021 14:38:51 +0000
Message-Id: <20210219143851.83672-1-leegib@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the checkpatch warnings such as:

hi6421-spmi-pmic.c:51: WARNING: please, no space before tabs

Signed-off-by: Lee Gibson <leegib@gmail.com>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 4ebcfea9f3bf..626140cb96f2 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -48,9 +48,9 @@ enum hi6421_spmi_pmic_irq_list {
 /*
  * The IRQs are mapped as:
  *
- * 	======================  =============   ============	=====
- *	IRQ			MASK REGISTER 	IRQ REGISTER	BIT
- * 	======================  =============   ============	=====
+ *	======================  =============   ============	=====
+ *	IRQ			MASK REGISTER	IRQ REGISTER	BIT
+ *	======================  =============   ============	=====
  *	OTMP			0x0202		0x212		bit 0
  *	VBUS_CONNECT		0x0202		0x212		bit 1
  *	VBUS_DISCONNECT		0x0202		0x212		bit 2
@@ -66,7 +66,7 @@ enum hi6421_spmi_pmic_irq_list {
  *	SIM0_HPD_F		0x0203		0x213		bit 3
  *	SIM1_HPD_R		0x0203		0x213		bit 4
  *	SIM1_HPD_F		0x0203		0x213		bit 5
- * 	======================  =============   ============	=====
+ *	======================  =============   ============	=====
  */
 #define SOC_PMIC_IRQ_MASK_0_ADDR	0x0202
 #define SOC_PMIC_IRQ0_ADDR		0x0212
-- 
2.25.1

