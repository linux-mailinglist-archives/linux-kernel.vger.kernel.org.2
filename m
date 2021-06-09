Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031083A2033
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhFIWiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:38:04 -0400
Received: from mail-il1-f172.google.com ([209.85.166.172]:35353 "EHLO
        mail-il1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbhFIWiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:38:03 -0400
Received: by mail-il1-f172.google.com with SMTP id b9so28207510ilr.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DoVedes8aza4XbMfRyN+dmWQLI3QtjACwFQ/YsnMRHY=;
        b=V9uiK2YzOXjx6eGXKkaB3OXMmx7G6C0bUntsmLdJU0PNDAbd4hciqVmHv4rcfqt0zf
         Os44L7bG9I6+vUVCT0o1tmMlt9z294ZdYiLGtEGqiSx4TW3BNG5vjb2r9j2TyJ1f8voS
         V87XLEzVjxzK1B15+SYA5KvvACq45tMTCUTN6JTTpxsR0zBClI7t0/bXSgn/4oXnXYdJ
         tNdZHNnfl0+Gy4/BITFYAx0QXC4KsXFkSe4QwiXRKobuHLH4zIt11jjrKm7afAHMkE/1
         efvni8Rs5oprPzySHiRhaDEnmPPL4HgMmjtR+bT1eEmMK21PEZ3gV78uW+mMNDCnnm0L
         ZHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DoVedes8aza4XbMfRyN+dmWQLI3QtjACwFQ/YsnMRHY=;
        b=QK5E1UWK4eKehFs/59e46VbwQniVHG7qxoITTzd7PBBClQkAjBkHiLIXNEZez/W2ea
         tdQhbpGxfL3Geu79cf11dzoJPN/olGTmLjpQglqCXf6mwLTiTKKU5k0rYff59IbJSRTF
         AxYj/5vYXsJy3zarFef2nwbHmRu/ycDa69DkpeuPLspM9B4cluajqw0q/+9tW2X8s0JU
         n4RsjfvQvlyhHBrqM9nFyj4XyMfSB4glIS7iktqPvQbZ6Jp41YtuDlL5L6uAcO31oy1c
         iU0B0144G7w7h3SSar6GjzXA1OJjv47N5rKZhnGdBT6frha6/m/LuC1SMFqBdOHf+flE
         gXTA==
X-Gm-Message-State: AOAM5304Ydx9m6nshxITlWqeaOGNDS0s8BiGgsbHgrIEsjRXga8Wo8oy
        baOCqE4as4Sa85WnsX+zIhIpAaHmwxvUOJAd
X-Google-Smtp-Source: ABdhPJztAYz7f7OAYVUeDDSZ2xsQTgXR+qn7x+TDczP363Z06/OnQu3JYStWAR7R+v6ydNVxcY7WmA==
X-Received: by 2002:a05:6e02:5ce:: with SMTP id l14mr1521252ils.94.1623278108345;
        Wed, 09 Jun 2021 15:35:08 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c19sm750165ili.62.2021.06.09.15.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:35:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 02/11] net: ipa: store memory region id in descriptor
Date:   Wed,  9 Jun 2021 17:34:54 -0500
Message-Id: <20210609223503.2649114-3-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210609223503.2649114-1-elder@linaro.org>
References: <20210609223503.2649114-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Store the memory region ID in the memory descriptor structure.  This
is a move toward *not* indexing the array by the ID, but for now we
must still specify those index values.  Define an explicitly
undefined region ID, value 0, so uninitialized entries in the array
won't use an otherwise valid ID.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-v3.5.1.c | 15 +++++++++++++++
 drivers/net/ipa/ipa_data-v4.11.c  | 22 ++++++++++++++++++++++
 drivers/net/ipa/ipa_data-v4.2.c   | 18 ++++++++++++++++++
 drivers/net/ipa/ipa_data-v4.5.c   | 23 +++++++++++++++++++++++
 drivers/net/ipa/ipa_data-v4.9.c   | 26 +++++++++++++++++++++++++-
 drivers/net/ipa/ipa_mem.h         |  3 +++
 6 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ipa/ipa_data-v3.5.1.c b/drivers/net/ipa/ipa_data-v3.5.1.c
index ead1a82f32f5c..945d45b72b247 100644
--- a/drivers/net/ipa/ipa_data-v3.5.1.c
+++ b/drivers/net/ipa/ipa_data-v3.5.1.c
@@ -272,76 +272,91 @@ static const struct ipa_resource_data ipa_resource_data = {
 /* IPA-resident memory region data for an SoC having IPA v3.5.1 */
 static const struct ipa_mem ipa_mem_local_data[] = {
 	[IPA_MEM_UC_SHARED] = {
+		.id		= IPA_MEM_UC_SHARED,
 		.offset		= 0x0000,
 		.size		= 0x0080,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_UC_INFO] = {
+		.id		= IPA_MEM_UC_INFO,
 		.offset		= 0x0080,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_V4_FILTER_HASHED] = {
+		.id		= IPA_MEM_V4_FILTER_HASHED,
 		.offset		= 0x0288,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_FILTER] = {
+		.id		= IPA_MEM_V4_FILTER,
 		.offset		= 0x0308,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER_HASHED] = {
+		.id		= IPA_MEM_V6_FILTER_HASHED,
 		.offset		= 0x0388,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER] = {
+		.id		= IPA_MEM_V6_FILTER,
 		.offset		= 0x0408,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V4_ROUTE_HASHED,
 		.offset		= 0x0488,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE] = {
+		.id		= IPA_MEM_V4_ROUTE,
 		.offset		= 0x0508,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V6_ROUTE_HASHED,
 		.offset		= 0x0588,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE] = {
+		.id		= IPA_MEM_V6_ROUTE,
 		.offset		= 0x0608,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_MODEM_HEADER] = {
+		.id		= IPA_MEM_MODEM_HEADER,
 		.offset		= 0x0688,
 		.size		= 0x0140,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_MODEM_PROC_CTX] = {
+		.id		= IPA_MEM_MODEM_PROC_CTX,
 		.offset		= 0x07d0,
 		.size		= 0x0200,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_PROC_CTX] = {
+		.id		= IPA_MEM_AP_PROC_CTX,
 		.offset		= 0x09d0,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM] = {
+		.id		= IPA_MEM_MODEM,
 		.offset		= 0x0bd8,
 		.size		= 0x1024,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_UC_EVENT_RING] = {
+		.id		= IPA_MEM_UC_EVENT_RING,
 		.offset		= 0x1c00,
 		.size		= 0x0400,
 		.canary_count	= 1,
diff --git a/drivers/net/ipa/ipa_data-v4.11.c b/drivers/net/ipa/ipa_data-v4.11.c
index e7bdb8b4400e7..2ff3fcf4e21fa 100644
--- a/drivers/net/ipa/ipa_data-v4.11.c
+++ b/drivers/net/ipa/ipa_data-v4.11.c
@@ -221,111 +221,133 @@ static const struct ipa_resource_data ipa_resource_data = {
 /* IPA-resident memory region data for an SoC having IPA v4.11 */
 static const struct ipa_mem ipa_mem_local_data[] = {
 	[IPA_MEM_UC_SHARED] = {
+		.id		= IPA_MEM_UC_SHARED,
 		.offset		= 0x0000,
 		.size		= 0x0080,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_UC_INFO] = {
+		.id		= IPA_MEM_UC_INFO,
 		.offset		= 0x0080,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_V4_FILTER_HASHED] = {
+		.id		= IPA_MEM_V4_FILTER_HASHED,
 		.offset		= 0x0288,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_FILTER] = {
+		.id		= IPA_MEM_V4_FILTER,
 		.offset		= 0x0308,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER_HASHED] = {
+		.id		= IPA_MEM_V6_FILTER_HASHED,
 		.offset		= 0x0388,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER] = {
+		.id		= IPA_MEM_V6_FILTER,
 		.offset		= 0x0408,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V4_ROUTE_HASHED,
 		.offset		= 0x0488,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE] = {
+		.id		= IPA_MEM_V4_ROUTE,
 		.offset		= 0x0508,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V6_ROUTE_HASHED,
 		.offset		= 0x0588,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE] = {
+		.id		= IPA_MEM_V6_ROUTE,
 		.offset		= 0x0608,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_MODEM_HEADER] = {
+		.id		= IPA_MEM_MODEM_HEADER,
 		.offset		= 0x0688,
 		.size		= 0x0240,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_HEADER] = {
+		.id		= IPA_MEM_AP_HEADER,
 		.offset		= 0x08c8,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM_PROC_CTX] = {
+		.id		= IPA_MEM_MODEM_PROC_CTX,
 		.offset		= 0x0ad0,
 		.size		= 0x0200,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_PROC_CTX] = {
+		.id		= IPA_MEM_AP_PROC_CTX,
 		.offset		= 0x0cd0,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_NAT_TABLE] = {
+		.id		= IPA_MEM_NAT_TABLE,
 		.offset		= 0x0ee0,
 		.size		= 0x0d00,
 		.canary_count	= 4,
 	},
 	[IPA_MEM_PDN_CONFIG] = {
+		.id		= IPA_MEM_PDN_CONFIG,
 		.offset		= 0x1be8,
 		.size		= 0x0050,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_QUOTA_MODEM] = {
+		.id		= IPA_MEM_STATS_QUOTA_MODEM,
 		.offset		= 0x1c40,
 		.size		= 0x0030,
 		.canary_count	= 4,
 	},
 	[IPA_MEM_STATS_QUOTA_AP] = {
+		.id		= IPA_MEM_STATS_QUOTA_AP,
 		.offset		= 0x1c70,
 		.size		= 0x0048,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_TETHERING] = {
+		.id		= IPA_MEM_STATS_TETHERING,
 		.offset		= 0x1cb8,
 		.size		= 0x0238,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_DROP] = {
+		.id		= IPA_MEM_STATS_DROP,
 		.offset		= 0x1ef0,
 		.size		= 0x0020,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM] = {
+		.id		= IPA_MEM_MODEM,
 		.offset		= 0x1f18,
 		.size		= 0x100c,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_END_MARKER] = {
+		.id		= IPA_MEM_END_MARKER,
 		.offset		= 0x3000,
 		.size		= 0x0000,
 		.canary_count	= 1,
diff --git a/drivers/net/ipa/ipa_data-v4.2.c b/drivers/net/ipa/ipa_data-v4.2.c
index 95f75dbc3c3bc..f06eb07a7895d 100644
--- a/drivers/net/ipa/ipa_data-v4.2.c
+++ b/drivers/net/ipa/ipa_data-v4.2.c
@@ -220,91 +220,109 @@ static const struct ipa_resource_data ipa_resource_data = {
 /* IPA-resident memory region data for an SoC having IPA v4.2 */
 static const struct ipa_mem ipa_mem_local_data[] = {
 	[IPA_MEM_UC_SHARED] = {
+		.id		= IPA_MEM_UC_SHARED,
 		.offset		= 0x0000,
 		.size		= 0x0080,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_UC_INFO] = {
+		.id		= IPA_MEM_UC_INFO,
 		.offset		= 0x0080,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_V4_FILTER_HASHED] = {
+		.id		= IPA_MEM_V4_FILTER_HASHED,
 		.offset		= 0x0288,
 		.size		= 0,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_FILTER] = {
+		.id		= IPA_MEM_V4_FILTER,
 		.offset		= 0x0290,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER_HASHED] = {
+		.id		= IPA_MEM_V6_FILTER_HASHED,
 		.offset		= 0x0310,
 		.size		= 0,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER] = {
+		.id		= IPA_MEM_V6_FILTER,
 		.offset		= 0x0318,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V4_ROUTE_HASHED,
 		.offset		= 0x0398,
 		.size		= 0,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE] = {
+		.id		= IPA_MEM_V4_ROUTE,
 		.offset		= 0x03a0,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V6_ROUTE_HASHED,
 		.offset		= 0x0420,
 		.size		= 0,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE] = {
+		.id		= IPA_MEM_V6_ROUTE,
 		.offset		= 0x0428,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_MODEM_HEADER] = {
+		.id		= IPA_MEM_MODEM_HEADER,
 		.offset		= 0x04a8,
 		.size		= 0x0140,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_MODEM_PROC_CTX] = {
+		.id		= IPA_MEM_MODEM_PROC_CTX,
 		.offset		= 0x05f0,
 		.size		= 0x0200,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_PROC_CTX] = {
+		.id		= IPA_MEM_AP_PROC_CTX,
 		.offset		= 0x07f0,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_PDN_CONFIG] = {
+		.id		= IPA_MEM_PDN_CONFIG,
 		.offset		= 0x09f8,
 		.size		= 0x0050,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_STATS_QUOTA_MODEM] = {
+		.id		= IPA_MEM_STATS_QUOTA_MODEM,
 		.offset		= 0x0a50,
 		.size		= 0x0060,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_STATS_TETHERING] = {
+		.id		= IPA_MEM_STATS_TETHERING,
 		.offset		= 0x0ab0,
 		.size		= 0x0140,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM] = {
+		.id		= IPA_MEM_MODEM,
 		.offset		= 0x0bf0,
 		.size		= 0x140c,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_END_MARKER] = {
+		.id		= IPA_MEM_END_MARKER,
 		.offset		= 0x2000,
 		.size		= 0,
 		.canary_count	= 1,
diff --git a/drivers/net/ipa/ipa_data-v4.5.c b/drivers/net/ipa/ipa_data-v4.5.c
index 5f67a3a909ee0..1c8a9099639ab 100644
--- a/drivers/net/ipa/ipa_data-v4.5.c
+++ b/drivers/net/ipa/ipa_data-v4.5.c
@@ -266,116 +266,139 @@ static const struct ipa_resource_data ipa_resource_data = {
 /* IPA-resident memory region data for an SoC having IPA v4.5 */
 static const struct ipa_mem ipa_mem_local_data[] = {
 	[IPA_MEM_UC_SHARED] = {
+		.id		= IPA_MEM_UC_SHARED,
 		.offset		= 0x0000,
 		.size		= 0x0080,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_UC_INFO] = {
+		.id		= IPA_MEM_UC_INFO,
 		.offset		= 0x0080,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_V4_FILTER_HASHED] = {
+		.id		= IPA_MEM_V4_FILTER_HASHED,
 		.offset		= 0x0288,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_FILTER] = {
+		.id		= IPA_MEM_V4_FILTER,
 		.offset		= 0x0308,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER_HASHED] = {
+		.id		= IPA_MEM_V6_FILTER_HASHED,
 		.offset		= 0x0388,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER] = {
+		.id		= IPA_MEM_V6_FILTER,
 		.offset		= 0x0408,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V4_ROUTE_HASHED,
 		.offset		= 0x0488,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE] = {
+		.id		= IPA_MEM_V4_ROUTE,
 		.offset		= 0x0508,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V6_ROUTE_HASHED,
 		.offset		= 0x0588,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE] = {
+		.id		= IPA_MEM_V6_ROUTE,
 		.offset		= 0x0608,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_MODEM_HEADER] = {
+		.id		= IPA_MEM_MODEM_HEADER,
 		.offset		= 0x0688,
 		.size		= 0x0240,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_HEADER] = {
+		.id		= IPA_MEM_AP_HEADER,
 		.offset		= 0x08c8,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM_PROC_CTX] = {
+		.id		= IPA_MEM_MODEM_PROC_CTX,
 		.offset		= 0x0ad0,
 		.size		= 0x0b20,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_PROC_CTX] = {
+		.id		= IPA_MEM_AP_PROC_CTX,
 		.offset		= 0x15f0,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_NAT_TABLE] = {
+		.id		= IPA_MEM_NAT_TABLE,
 		.offset		= 0x1800,
 		.size		= 0x0d00,
 		.canary_count	= 4,
 	},
 	[IPA_MEM_STATS_QUOTA_MODEM] = {
+		.id		= IPA_MEM_STATS_QUOTA_MODEM,
 		.offset		= 0x2510,
 		.size		= 0x0030,
 		.canary_count	= 4,
 	},
 	[IPA_MEM_STATS_QUOTA_AP] = {
+		.id		= IPA_MEM_STATS_QUOTA_AP,
 		.offset		= 0x2540,
 		.size		= 0x0048,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_TETHERING] = {
+		.id		= IPA_MEM_STATS_TETHERING,
 		.offset		= 0x2588,
 		.size		= 0x0238,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_FILTER_ROUTE] = {
+		.id		= IPA_MEM_STATS_FILTER_ROUTE,
 		.offset		= 0x27c0,
 		.size		= 0x0800,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_DROP] = {
+		.id		= IPA_MEM_STATS_DROP,
 		.offset		= 0x2fc0,
 		.size		= 0x0020,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM] = {
+		.id		= IPA_MEM_MODEM,
 		.offset		= 0x2fe8,
 		.size		= 0x0800,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_UC_EVENT_RING] = {
+		.id		= IPA_MEM_UC_EVENT_RING,
 		.offset		= 0x3800,
 		.size		= 0x1000,
 		.canary_count	= 1,
 	},
 	[IPA_MEM_PDN_CONFIG] = {
+		.id		= IPA_MEM_PDN_CONFIG,
 		.offset		= 0x4800,
 		.size		= 0x0050,
 		.canary_count	= 0,
diff --git a/drivers/net/ipa/ipa_data-v4.9.c b/drivers/net/ipa/ipa_data-v4.9.c
index e41be790f45e5..f77169709eb2a 100644
--- a/drivers/net/ipa/ipa_data-v4.9.c
+++ b/drivers/net/ipa/ipa_data-v4.9.c
@@ -264,115 +264,139 @@ static const struct ipa_resource_data ipa_resource_data = {
 /* IPA-resident memory region data for an SoC having IPA v4.9 */
 static const struct ipa_mem ipa_mem_local_data[] = {
 	[IPA_MEM_UC_SHARED] = {
+		.id		= IPA_MEM_UC_SHARED,
 		.offset		= 0x0000,
 		.size		= 0x0080,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_UC_INFO] = {
+		.id		= IPA_MEM_UC_INFO,
 		.offset		= 0x0080,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
-	[IPA_MEM_V4_FILTER_HASHED] = { .offset		= 0x0288,
+	[IPA_MEM_V4_FILTER_HASHED] = {
+		.id		= IPA_MEM_V4_FILTER_HASHED,
+		.offset		= 0x0288,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_FILTER] = {
+		.id		= IPA_MEM_V4_FILTER,
 		.offset		= 0x0308,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER_HASHED] = {
+		.id		= IPA_MEM_V6_FILTER_HASHED,
 		.offset		= 0x0388,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_FILTER] = {
+		.id		= IPA_MEM_V6_FILTER,
 		.offset		= 0x0408,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V4_ROUTE_HASHED,
 		.offset		= 0x0488,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V4_ROUTE] = {
+		.id		= IPA_MEM_V4_ROUTE,
 		.offset		= 0x0508,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE_HASHED] = {
+		.id		= IPA_MEM_V6_ROUTE_HASHED,
 		.offset		= 0x0588,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_V6_ROUTE] = {
+		.id		= IPA_MEM_V6_ROUTE,
 		.offset		= 0x0608,
 		.size		= 0x0078,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_MODEM_HEADER] = {
+		.id		= IPA_MEM_MODEM_HEADER,
 		.offset		= 0x0688,
 		.size		= 0x0240,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_HEADER] = {
+		.id		= IPA_MEM_AP_HEADER,
 		.offset		= 0x08c8,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM_PROC_CTX] = {
+		.id		= IPA_MEM_MODEM_PROC_CTX,
 		.offset		= 0x0ad0,
 		.size		= 0x0b20,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_AP_PROC_CTX] = {
+		.id		= IPA_MEM_AP_PROC_CTX,
 		.offset		= 0x15f0,
 		.size		= 0x0200,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_NAT_TABLE] = {
+		.id		= IPA_MEM_NAT_TABLE,
 		.offset		= 0x1800,
 		.size		= 0x0d00,
 		.canary_count	= 4,
 	},
 	[IPA_MEM_STATS_QUOTA_MODEM] = {
+		.id		= IPA_MEM_STATS_QUOTA_MODEM,
 		.offset		= 0x2510,
 		.size		= 0x0030,
 		.canary_count	= 4,
 	},
 	[IPA_MEM_STATS_QUOTA_AP] = {
+		.id		= IPA_MEM_STATS_QUOTA_AP,
 		.offset		= 0x2540,
 		.size		= 0x0048,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_TETHERING] = {
+		.id		= IPA_MEM_STATS_TETHERING,
 		.offset		= 0x2588,
 		.size		= 0x0238,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_FILTER_ROUTE] = {
+		.id		= IPA_MEM_STATS_FILTER_ROUTE,
 		.offset		= 0x27c0,
 		.size		= 0x0800,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_STATS_DROP] = {
+		.id		= IPA_MEM_STATS_DROP,
 		.offset		= 0x2fc0,
 		.size		= 0x0020,
 		.canary_count	= 0,
 	},
 	[IPA_MEM_MODEM] = {
+		.id		= IPA_MEM_MODEM,
 		.offset		= 0x2fe8,
 		.size		= 0x0800,
 		.canary_count	= 2,
 	},
 	[IPA_MEM_UC_EVENT_RING] = {
+		.id		= IPA_MEM_UC_EVENT_RING,
 		.offset		= 0x3800,
 		.size		= 0x1000,
 		.canary_count	= 1,
 	},
 	[IPA_MEM_PDN_CONFIG] = {
+		.id		= IPA_MEM_PDN_CONFIG,
 		.offset		= 0x4800,
 		.size		= 0x0050,
 		.canary_count	= 0,
diff --git a/drivers/net/ipa/ipa_mem.h b/drivers/net/ipa/ipa_mem.h
index 5a4f865a45afa..ce692f948d59a 100644
--- a/drivers/net/ipa/ipa_mem.h
+++ b/drivers/net/ipa/ipa_mem.h
@@ -43,6 +43,7 @@ struct ipa_mem_data;
 
 /* IPA-resident memory region ids */
 enum ipa_mem_id {
+	IPA_MEM_UNDEFINED = 0,		/* undefined region */
 	IPA_MEM_UC_SHARED,		/* 0 canaries */
 	IPA_MEM_UC_INFO,		/* 0 canaries */
 	IPA_MEM_V4_FILTER_HASHED,	/* 2 canaries */
@@ -76,11 +77,13 @@ enum ipa_mem_id {
 
 /**
  * struct ipa_mem - IPA local memory region description
+ * @id:			memory region identifier
  * @offset:		offset in IPA memory space to base of the region
  * @size:		size in bytes base of the region
  * @canary_count:	Number of 32-bit "canary" values that precede region
  */
 struct ipa_mem {
+	enum ipa_mem_id id;
 	u32 offset;
 	u16 size;
 	u16 canary_count;
-- 
2.27.0

