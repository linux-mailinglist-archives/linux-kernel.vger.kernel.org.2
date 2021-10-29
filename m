Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEB343F42F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 02:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbhJ2BBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 21:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbhJ2BBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 21:01:00 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8282CC061570;
        Thu, 28 Oct 2021 17:58:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id t40so7610583qtc.6;
        Thu, 28 Oct 2021 17:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHckMV0NLdWS9FKVte90nvwxIvajXuPQr1oy0D13+Jg=;
        b=IT/uopC6YVy6fowzr1JPrxxpbdzvQRPZhqlicCjNONO2OSVYk2erQfS9i4KxDzlB6z
         HXZDoYy1Q4nsqo97TsomH3/nIa4pFIiq1t7EGWIg6omRrU33rBsE7S8gpxSLx0Ak1avb
         nF071ne6e6pdRaboMKIW/FoNJJXWuIw4X+qujBQqvlJNUXvqGDeA8l9f5C9tK+6pNssi
         5v2+TutfSW9d2ETSSGG/nJoPgpE7n1gbARsCBlyTotf2xp5vWk4fKezEGrSEPrnSu6Wg
         VY5zSkHoVgSYjWMU8M8dGUAI8KjBovGWiHCfyxIJdtQazQPqdqgRx/pk4ZgvxB7kBPNl
         9pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LHckMV0NLdWS9FKVte90nvwxIvajXuPQr1oy0D13+Jg=;
        b=sdQURs7xR3HC4bQgYmwCveyWLOoVtEJnVDj2NnC7XrKARQ3eo4SePNDaADlgStuxrG
         akvrZji0Ht+WbBV6l5bEveZmoIm5dyUik/8rVTZRR/jcLEE6ef+nR8TNs5KvfVNO7Z2D
         v83yf1G0lpP6EaJm6HM9hc8G9WqMl2y9TANJsb7oXbv8YTrkRcHdX0c6JN3Y2dIer6R8
         XaG9lY4utfsD+FIQ8T7CoBdZuEZsNpodveBIy1jEmvPYLbsasiAU9ocuIbWCJVVFqIZJ
         Q6RVLTU18NgpIGfNxsDYA47/3WNGzivGTJ0t4UVet78+gBOvCwNdcAeRdYrCI2I/WkGK
         d1hw==
X-Gm-Message-State: AOAM531z0iWzVS5uvggIdWW4p0HgPcCQpQsNbQXFuwsmplAVbj+FB9zq
        RL3kPWkUG8bPhaO0FXoBK57GQxKNqUg=
X-Google-Smtp-Source: ABdhPJxsAvXIYiOS7WDBhE58FJaHZ6gsUkmLCP9iZJUPov1i1h2Q1QbMVt5HRp3aLepoKxl6H2p7Rg==
X-Received: by 2002:ac8:5ace:: with SMTP id d14mr4475560qtd.214.1635469111600;
        Thu, 28 Oct 2021 17:58:31 -0700 (PDT)
Received: from localhost.localdomain (c-67-187-90-124.hsd1.tn.comcast.net. [67.187.90.124])
        by smtp.gmail.com with ESMTPSA id g18sm3033394qto.71.2021.10.28.17.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Oct 2021 17:58:31 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] of: unittest: fix dts for interrupt-map provider build warning
Date:   Thu, 28 Oct 2021 19:58:02 -0500
Message-Id: <20211029005802.2047081-1-frowand.list@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

Fix kernel build warning:
drivers/of/unittest-data/tests-interrupts.dtsi:32.26-35.6: Warning (interrupt_map): /testcase-data/interrupts/intmap1: Missing '#address-cells' in interrupt-map provider

A recently implemented dtc compiler warning reported the dts problem.

Signed-off-by: Frank Rowand <frank.rowand@sony.com>
---
 drivers/of/unittest-data/tests-interrupts.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/unittest-data/tests-interrupts.dtsi b/drivers/of/unittest-data/tests-interrupts.dtsi
index 9b60a549f502..8c2b91b998aa 100644
--- a/drivers/of/unittest-data/tests-interrupts.dtsi
+++ b/drivers/of/unittest-data/tests-interrupts.dtsi
@@ -31,6 +31,7 @@ test_intmap0: intmap0 {
 
 			test_intmap1: intmap1 {
 				#interrupt-cells = <2>;
+				#address-cells = <1>;
 				interrupt-map = <0x5000 1 2 &test_intc0 15>;
 			};
 
-- 
Frank Rowand <frank.rowand@sony.com>

