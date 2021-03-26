Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A87B34AB0E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 16:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbhCZPML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 11:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCZPLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 11:11:31 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56C3C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:30 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id u2so5323310ilk.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 08:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gq3i0wnBHrNwz9Pi4M/j7GEgiiLGmWSM/j0zInRMGy0=;
        b=mfJGjMk3qC8fryl2SB0+14KfpqSt36cPEfQ53Vszh/9NzcrX54yxes9Z5toBpl1axq
         LBRwoamhag4/lozkX/JaC5+Svdu5SIdbpwIIhWrss3ZJvvYZApLRN1IzOYPgjVZ4D4OZ
         kghUKYCRlbbReJ0LJxl7cOMDhbqhc9gTtVWM1IvAzpWxJ/YMtyfd+Ha041FrQGL2fKtG
         aiR9M1EmLjjnziCWvWUSedBoMwvJOjLOt520ngqhLfsOr1/y3DXIaAOCOp9XwFfeWUBt
         nzyEIKfuB04vAZYwjwblPMdIm1v0715NeSRPhgTmDt04skQWAXJQxOwQ5OlYWXsIOlNh
         D1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gq3i0wnBHrNwz9Pi4M/j7GEgiiLGmWSM/j0zInRMGy0=;
        b=WMXS2xS129/g0FvAJDtaugIDb8DIO3N81x/XVXrTvsnys9yREGnjpNWOwFthQOC7Yo
         5nbYBs77BcobKabr3CypXC3FhUYxoJMIpQlLMscBHscWqqH0uzVdoM+DTIeSqFH4BCwM
         Qnp3lz2hPCKEPaUydepGGkZdryShquAxZs5Qq4CkKNm5IL0EJI2PVFtxzFReLXilSFY+
         w8WdO23VzO1Chf8jD+Ksr22NkHwyTCA+p3xuvt1qdWclESuiK1+uqgDPIJgLFMV8PJyp
         vO6M67n6eicWo3GyWZYbNr4srL25EwT9leTbwnAGJ/X7TsEMrWx24nQbaL06hLkefrAn
         VGbg==
X-Gm-Message-State: AOAM532sW7lWhGf7wCQXtjW0H6ql4aD3bJdZrLigIc+04jzIJETeiJou
        E+1QdU26rLo2y64bIe9RcGw8TA==
X-Google-Smtp-Source: ABdhPJyTINzoOTO+ASB9bcDIi0FuTBMRjxOSqnVIfNLQX/gsKIwj+EN3ZKyrt4uZmEzcpsaAYgDRGA==
X-Received: by 2002:a92:dc83:: with SMTP id c3mr11445675iln.167.1616771490412;
        Fri, 26 Mar 2021 08:11:30 -0700 (PDT)
Received: from localhost.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id j17sm4537706iok.37.2021.03.26.08.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:11:30 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 04/12] net: ipa: add some missing resource limits
Date:   Fri, 26 Mar 2021 10:11:14 -0500
Message-Id: <20210326151122.3121383-5-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210326151122.3121383-1-elder@linaro.org>
References: <20210326151122.3121383-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the SDM845 configuration data defines resource limits for
the first two resource groups (for both source and destination
resource types).  The hardware supports additional resource groups,
and we should program the resource limits for those groups as well.

Even the "unused" destination resource group (number 2) should have
non-zero limits programmed in some cases, to ensure correct operation.

Add these missing resource group limit definitions to the SDM845
configuration data.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-sdm845.c | 32 +++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/ipa/ipa_data-sdm845.c b/drivers/net/ipa/ipa_data-sdm845.c
index b6ea6295e7598..3bc5fcfdf960c 100644
--- a/drivers/net/ipa/ipa_data-sdm845.c
+++ b/drivers/net/ipa/ipa_data-sdm845.c
@@ -178,6 +178,10 @@ static const struct ipa_resource_src ipa_resource_src[] = {
 			.min = 1,
 			.max = 255,
 		},
+		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
+			.min = 1,
+			.max = 63,
+		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_LISTS,
@@ -189,6 +193,10 @@ static const struct ipa_resource_src ipa_resource_src[] = {
 			.min = 10,
 			.max = 10,
 		},
+		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
+			.min = 8,
+			.max = 8,
+		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_DESCRIPTOR_BUFF,
@@ -200,6 +208,10 @@ static const struct ipa_resource_src ipa_resource_src[] = {
 			.min = 14,
 			.max = 14,
 		},
+		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
+			.min = 8,
+			.max = 8,
+		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_HPS_DMARS,
@@ -211,6 +223,14 @@ static const struct ipa_resource_src ipa_resource_src[] = {
 			.min = 0,
 			.max = 63,
 		},
+		.limits[IPA_RSRC_GROUP_SRC_MHI_DMA] = {
+			.min = 0,
+			.max = 63,
+		},
+		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
+			.min = 0,
+			.max = 63,
+		},
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_SRC_ACK_ENTRIES,
@@ -222,6 +242,10 @@ static const struct ipa_resource_src ipa_resource_src[] = {
 			.min = 20,
 			.max = 20,
 		},
+		.limits[IPA_RSRC_GROUP_SRC_UC_RX_Q] = {
+			.min = 14,
+			.max = 14,
+		},
 	},
 };
 
@@ -237,6 +261,10 @@ static const struct ipa_resource_dst ipa_resource_dst[] = {
 			.min = 4,
 			.max = 4,
 		},
+		.limits[IPA_RSRC_GROUP_DST_UNUSED_2] = {
+			.min = 3,
+			.max = 3,
+		}
 	},
 	{
 		.type = IPA_RESOURCE_TYPE_DST_DPS_DMARS,
@@ -248,6 +276,10 @@ static const struct ipa_resource_dst ipa_resource_dst[] = {
 			.min = 1,
 			.max = 63,
 		},
+		.limits[IPA_RSRC_GROUP_DST_UNUSED_2] = {
+			.min = 1,
+			.max = 2,
+		}
 	},
 };
 
-- 
2.27.0

