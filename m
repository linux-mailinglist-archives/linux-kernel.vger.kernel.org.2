Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97364399394
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 21:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbhFBTfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 15:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbhFBTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 15:35:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86AB9C061756
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 12:33:56 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id pi6-20020a17090b1e46b029015cec51d7cdso2374022pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 12:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JfnxRQTN3fYAopB3rM/EPd4f4ei3Y6CI77SLlRBX5lE=;
        b=ak1rWd/+dydnlScK/+KBUfeK9WwMoemosKP3vGZ99cBy1SojbMbGOL6ATH8hYYPvwd
         eJUvPYb2FeiCQgYpUYy9/Emtbyj9lBxOW876aOrO4V0RuFNC2MbGNBBRpS/wQUYg82lt
         2YtItGAMmPGb+S0QVFJq1Ze9fLaSF2rc6qVsp3Ch1GLpjBsz3rmhywRo7NiSEg07WNqT
         UEJFQKHr7yHUoBecsNYqxGZ1KtJbI/Belx1jONuogKELstOFMOB/1vCFY1HURbZWI46h
         oga/UBPEmeXXL2WX8NILmkmquz8eLgPAVqbw6q407tLb29FlDCLW450aUi9HkSvitmp6
         Hnpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JfnxRQTN3fYAopB3rM/EPd4f4ei3Y6CI77SLlRBX5lE=;
        b=eu0NdtxWdqO7PDkUfl+QZMqDtW/rMJf55W1fmn+TqvfNlh1WxVUI7yLGPuEynG7z0x
         DjyNs01tFaQH6uDfJXyLMfH1aewxEz9jfwkPldXroxJPNPOnLSUJ2gGkpH21gIUNWPV+
         2XiuCLIGLNVeFd80QA+EwVm+Az0mIf83+hWzykE18Oo4+2ySUgpgKlCoTGRGK566al6z
         A53lD6fVSbUAZQ8WPYbDBbg3LFbw11t9mWHdmGHQOeoBuXEuzDP287WitytkLbAE/0uL
         zCA3DMlQVGU2EVY1pzZdoUaapnY1YtiZsiot4OAYGxhh8ukG06du8ejzfCXQ5cg61yTR
         iLbQ==
X-Gm-Message-State: AOAM530CRMQB3e2WdewcV+Iv6fe7s0iFCQJsXV7/0MzuV8AJKlNm3lsX
        0lBstV36+ktSYc9wP9Pry5o=
X-Google-Smtp-Source: ABdhPJx2RUoc6lWmR30Dng5SUbQyKOkySPlHFXM59H7D2maTkKUm32HpjN7DXhSumYn/h2QEuiTTLg==
X-Received: by 2002:a17:902:db0f:b029:f3:e5f4:87f1 with SMTP id m15-20020a170902db0fb02900f3e5f487f1mr31689978plx.26.1622662435026;
        Wed, 02 Jun 2021 12:33:55 -0700 (PDT)
Received: from localhost.localdomain ([183.82.156.141])
        by smtp.googlemail.com with ESMTPSA id 30sm520570pgo.7.2021.06.02.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 12:33:54 -0700 (PDT)
From:   Manikishan Ghantasala <manikishanghantasala@gmail.com>
Cc:     manikishanghantasala@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] staging: rtl8192u: put parentheses on macros with complex values in r8192U_hw.h
Date:   Thu,  3 Jun 2021 01:03:31 +0530
Message-Id: <20210602193334.11687-3-manikishanghantasala@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210602193334.11687-1-manikishanghantasala@gmail.com>
References: <20210602193334.11687-1-manikishanghantasala@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix "Macros with complex values should be enclosed in parentheses" checkpatch error.

Signed-off-by: Manikishan Ghantasala <manikishanghantasala@gmail.com>
---
 drivers/staging/rtl8192u/r8192U_hw.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8192u/r8192U_hw.h b/drivers/staging/rtl8192u/r8192U_hw.h
index b72cef3871b6..1de0605a9423 100644
--- a/drivers/staging/rtl8192u/r8192U_hw.h
+++ b/drivers/staging/rtl8192u/r8192U_hw.h
@@ -221,13 +221,13 @@ enum _RTL8192Usb_HW {
 #define	RATR_MCS14		0x04000000
 #define	RATR_MCS15		0x08000000
 // ALL CCK Rate
-#define RATE_ALL_CCK		RATR_1M | RATR_2M | RATR_55M | RATR_11M
-#define RATE_ALL_OFDM_AG	RATR_6M | RATR_9M | RATR_12M | RATR_18M |\
-				 RATR_24M | RATR_36M | RATR_48M | RATR_54M
-#define RATE_ALL_OFDM_1SS	RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
-				 RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7
-#define RATE_ALL_OFDM_2SS	RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
-				 RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15
+#define RATE_ALL_CCK		(RATR_1M | RATR_2M | RATR_55M | RATR_11M)
+#define RATE_ALL_OFDM_AG	(RATR_6M | RATR_9M | RATR_12M | RATR_18M |\
+				 RATR_24M | RATR_36M | RATR_48M | RATR_54M)
+#define RATE_ALL_OFDM_1SS	(RATR_MCS0 | RATR_MCS1 | RATR_MCS2 | RATR_MCS3 |\
+				 RATR_MCS4 | RATR_MCS5 | RATR_MCS6 | RATR_MCS7)
+#define RATE_ALL_OFDM_2SS	(RATR_MCS8 | RATR_MCS9 | RATR_MCS10 | RATR_MCS11 |\
+				 RATR_MCS12 | RATR_MCS13 | RATR_MCS14 | RATR_MCS15)
 	EPROM_CMD		= 0xfe58,
 #define Cmd9346CR_9356SEL	BIT(4)
 #define EPROM_CMD_OPERATING_MODE_SHIFT 6
-- 
2.25.1

