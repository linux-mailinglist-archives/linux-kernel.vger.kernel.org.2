Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1F83A203A
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 00:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbhFIWiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 18:38:15 -0400
Received: from mail-il1-f181.google.com ([209.85.166.181]:43872 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230417AbhFIWiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 18:38:12 -0400
Received: by mail-il1-f181.google.com with SMTP id x18so28157841ila.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jun 2021 15:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMjjpQs8M9kSqCO6ZvuGUH0+GwK5H/54utg6EraTogs=;
        b=ssxJcMWayGRPdGFk8seuDEbiPT0gGpO8Yt1Vu7q1Y73l7POmJVrKeua49bkoXQJujC
         mPOTH0J9PcRsj2gwh78uxmLjxnvCVyoaJGVIY3RDupNLbn0PnomToNIx/2/xa4sp6lym
         MlKcXD+mCCT28Wu5xtquKoJ+9cYjXdbtMrXu4llHa3WGSi9aLDyNLJS1IcDWNjsOkn5d
         TG3yuiZCDqRZzYPY4iyp8JVtbE37OWZjp7DwaVXjm/vTDUcwRYiGsua0WzHu9pvo1R3m
         u7eSa+AgD0/Ooy4RuyGkLoqodcKhp4tZrbROb3c5RP4RaOPkS8kAh34nEtOmH0XwZUUD
         pKdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMjjpQs8M9kSqCO6ZvuGUH0+GwK5H/54utg6EraTogs=;
        b=l7UlP/C575bv8zo9NjBK5Fx0y+bThq3R1rIZcthO7sOfs4NRLHKVLkXINDMkGQdPyu
         O2fWJEUZFY6sjHfYkQRxHYK9GU1HTZk2XdEJASJ6MZB2zuBnCJyG0pgcNv/edDNX72DV
         rDw8N8uT1eeW05UfWfRsN/cs4HWW9NLND+kvqce2OHDvfx/WWbdteXoOT+EZSHXe+K9H
         6q3uCO7ul8945yUfKc2YJa8Cvj7b3G6lZHGPjqnxf4I+LSYj7e3EuGXMaMMeLUr9E5i3
         7KfikmqpId4byNmIg2P0119ASPceZxz0SrGZ03P6BS8qDq4tKEpWbVZmtPf4Ecl/WGkC
         WJ6w==
X-Gm-Message-State: AOAM532UDB9kjY7dOhJhGQRaseKOsjXB//0VpEGPR6GpLf+2YfkaxNpb
        uMEeNa3d8YvUkPv7u3VXndfssg==
X-Google-Smtp-Source: ABdhPJzLHswDmsiNLhV1wSn9D/fcKQCpUvxoLzsGLi7opKbz9s/gLMG3xMvg2aVWgs0cJju13UF1Ug==
X-Received: by 2002:a92:cd8d:: with SMTP id r13mr1444229ilb.93.1623278117230;
        Wed, 09 Jun 2021 15:35:17 -0700 (PDT)
Received: from presto.localdomain (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.gmail.com with ESMTPSA id c19sm750165ili.62.2021.06.09.15.35.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 15:35:16 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, kuba@kernel.org
Cc:     bjorn.andersson@linaro.org, evgreen@chromium.org,
        cpratapa@codeaurora.org, subashab@codeaurora.org, elder@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 11/11] net: ipa: use bitmap to check for missing regions
Date:   Wed,  9 Jun 2021 17:35:03 -0500
Message-Id: <20210609223503.2649114-12-elder@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210609223503.2649114-1-elder@linaro.org>
References: <20210609223503.2649114-1-elder@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ipa_mem_valid(), wait until regions have been marked in the memory
region bitmap, and check all that are not found there to ensure they
are not required.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_mem.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ipa/ipa_mem.c b/drivers/net/ipa/ipa_mem.c
index 7b79aeb5f68fc..ef9fdd3b88750 100644
--- a/drivers/net/ipa/ipa_mem.c
+++ b/drivers/net/ipa/ipa_mem.c
@@ -249,19 +249,16 @@ static bool ipa_mem_valid(struct ipa *ipa, const struct ipa_mem_data *mem_data)
 		if (mem->offset)
 			dev_warn(dev, "empty region %u has non-zero offset\n",
 				 mem_id);
-
-		if (ipa_mem_id_required(ipa, mem_id)) {
-			dev_err(dev, "required memory region %u missing\n",
-				mem_id);
-			return false;
-		}
 	}
 
 	/* Now see if any required regions are not defined */
-	while (mem_id < IPA_MEM_COUNT)
-		if (ipa_mem_id_required(ipa, mem_id++))
+	for (mem_id = find_first_zero_bit(regions, IPA_MEM_COUNT);
+	     mem_id < IPA_MEM_COUNT;
+	     mem_id = find_next_zero_bit(regions, IPA_MEM_COUNT, mem_id + 1)) {
+		if (ipa_mem_id_required(ipa, mem_id))
 			dev_err(dev, "required memory region %u missing\n",
 				mem_id);
+	}
 
 	return true;
 }
-- 
2.27.0

