Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF53A203B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhFIWiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:38:16 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:40958 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbhFIWiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:38:15 -0400
Received: by mail-il1-f181.google.com with SMTP id b14so27863177ilq.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:36:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+3Be2aADV7uPp72IR6w8DJQv7KxaXAQZAy5ctN+CH2I=;
        b=TXn397a52FqS+L7I4Ntuv2ciaDVD91K3vP+UR+IcwqhrvxeTGvnpgzwwXrTBRQO9cC
         diTaTT/wnrPLokSDh3i0Is5LZkUP8TDPCpq1IyrzCFjR74GLALa3X+WmZiWhE9E4ZanJ
         /71/x+n75SkYmA+Ldd1I+tuBBdlylmMwUdGIyDY3EV5r4ii6LrmbAjEdLmhx7MybAl2y
         GRBLoIKrKjhBWCcBCaVyXA4K036RGzf6hwxTZzP4xguADk3+jPO5UuU3ITr7VEMNyI73
         PbYN8sDoWPwzartr8NPoOIX77BbCPGt1ElMUndBqhPoZThYScyHY0janswYE1ph3iqia
         V97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+3Be2aADV7uPp72IR6w8DJQv7KxaXAQZAy5ctN+CH2I=;
        b=EXd40dxzzZ0GgLNc2v5n+h/9bfldvikfdVpDSAVZ4ev47eBfXbh0LdqxIa2vNaKlqO
         3iBqs0Alf794JtvVm9oE9CxflBhgOd6KG+wDQMyF9T6StLMR6ovbBQrPc4YU57Hm6jhc
         SGTXtYRkA8ach0jS2uoQiJ1VarO347pbHv7cTN22mIMojTCoynrTUaip2b5LqRwen3tR
         pO5Xd3d+wyoWdIsRAzy7XK2X5TYBhBvpr59HqMM1Yxl99vbQ7qtD2rOHyA+P1FPpB51m
         wSfboIBx/Ob32M+CqHhl4uMNUfCSN4rZQvucutIUjjPe+LQaiaoVfI1IkzidaFuYn0YL
         dkmw==
X-Gm-Message-State: AOAM531VDH4wSzlhNLB2Bcy2Yq8C39eIz+lCZGFFek+y9P5ptv/mr1/3
        pdmidICVVGHUXg87l9iy0HrU6g==
X-Google-Smtp-Source: ABdhPJwlEotrK1SG/KeE43VqpVL5wOoyTbfd1lUIuw3IrNQ5xNSgkyTSt8R8NpziUjSQmOjG9gx71w==
X-Received: by 2002:a05:6e02:219d:: with SMTP id j29mr670381ila.64.1623278107318;
        Wed, 09 Jun 2021 15:35:07 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c19sm750165ili.62.2021.06.09.15.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:35:07 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 01/11] net: ipa: define IPA_MEM_END_MARKER
Date:   Wed,  9 Jun 2021 17:34:53 -0500
Message-Id: <20210609223503.2649114-2-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210609223503.2649114-1-elder@linaro.org>
References: <20210609223503.2649114-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define a new pseudo memory region identifer that specifies the
offset at the end of IPA resident memory.  Use it instead of
IPA_MEM_UC_EVENT_RING in places where the size of that region was
defined to be 0.

The size of the IPA_MEM_END_MARKER pseudo region must be zero.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_data-v4.11.c | 2 +-
 drivers/net/ipa/ipa_data-v4.2.c  | 2 +-
 drivers/net/ipa/ipa_mem.c        | 2 ++
 drivers/net/ipa/ipa_mem.h        | 1 +
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ipa/ipa_data-v4.11.c b/drivers/net/ipa/ipa_data-v4.11.c
index 05806ceae8b54..e7bdb8b4400e7 100644
--- a/drivers/net/ipa/ipa_data-v4.11.c
+++ b/drivers/net/ipa/ipa_data-v4.11.c
@@ -325,7 +325,7 @@ static const struct ipa_mem ipa_mem_local_data[] = {
 		.size		= 0x100c,
 		.canary_count	= 2,
 	},
-	[IPA_MEM_UC_EVENT_RING] = {
+	[IPA_MEM_END_MARKER] = {
 		.offset		= 0x3000,
 		.size		= 0x0000,
 		.canary_count	= 1,
diff --git a/drivers/net/ipa/ipa_data-v4.2.c b/drivers/net/ipa/ipa_data-v4.2.c
index 8744f19c64011..95f75dbc3c3bc 100644
--- a/drivers/net/ipa/ipa_data-v4.2.c
+++ b/drivers/net/ipa/ipa_data-v4.2.c
@@ -304,7 +304,7 @@ static const struct ipa_mem ipa_mem_local_data[] = {
 		.size		= 0x140c,
 		.canary_count	= 0,
 	},
-	[IPA_MEM_UC_EVENT_RING] = {
+	[IPA_MEM_END_MARKER] = {
 		.offset		= 0x2000,
 		.size		= 0,
 		.canary_count	= 1,
diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 1624125e7459f..e3c43cf6e4412 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -120,6 +120,8 @@ static bool ipa_mem_valid(struct ipa *ipa, enum ipa_mem_id mem_id)
 	else if (mem->offset + mem->size > ipa->mem_size)
 		dev_err(dev, "region %u ends beyond memory limit (0x%08x)\n",
 			mem_id, ipa->mem_size);
+	else if (mem_id == IPA_MEM_END_MARKER && mem->size)
+		dev_err(dev, "non-zero end marker region size\n");
 	else
 		return true;
 
diff --git a/drivers/net/ipa/ipa_mem.h b/drivers/net/ipa/ipa_mem.h
index a422aec69e5da..5a4f865a45afa 100644
--- a/drivers/net/ipa/ipa_mem.h
+++ b/drivers/net/ipa/ipa_mem.h
@@ -70,6 +70,7 @@ enum ipa_mem_id {
 	IPA_MEM_STATS_DROP,		/* 0 canaries (IPA v4.0 and above) */
 	IPA_MEM_MODEM,			/* 0/2 canaries */
 	IPA_MEM_UC_EVENT_RING,		/* 1 canary */
+	IPA_MEM_END_MARKER,		/* 1 canary (not a real region) */
 	IPA_MEM_COUNT,			/* Number of regions (not an index) */
 };
 
-- 
2.27.0

