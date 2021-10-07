Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5A48425276
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 14:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241159AbhJGMGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 08:06:55 -0400
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:48182
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230453AbhJGMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 08:06:40 -0400
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 8A89E40008
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 12:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633608285;
        bh=YbQ14jGkFrd5cVE7B20rk9z4X5SjheHPbtlwUglFswg=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=wSDcBwHKTFM+CzcoJxlpQvAX0KC5/B8dJQ/gb/qe7n6tHuTsYTcJg4uGsZLB+dUsu
         8dXSC/6MP0MDgPXS+pNDS95uo+Qv9mAWZqjnOAzkeB9BeDkALD/gO7vFNgfbLqxK85
         ldMRTRd4rTeLnO4RnBHiT+3paHst9gjXgkTHMxOa2uX4d79uG0XlUfVDNHmi2QX7oF
         JuI70Jjf5sMD9ln0t7OyI1X6UfwsuT6usLC1qOCZPv5zPFVac2DSq5h/0vAMyGrWNe
         YDtpPxJt16voBf5zYzyVHy8YDb5PnL05E4Ec24YWHkb1eRFwbeM/n7x3XXCaDCUwDK
         4jxFO85Jc6iRQ==
Received: by mail-pg1-f198.google.com with SMTP id z19-20020a631913000000b00252ede336caso3314044pgl.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 05:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YbQ14jGkFrd5cVE7B20rk9z4X5SjheHPbtlwUglFswg=;
        b=Hljf7FB30ffg6EJZS1ByNn4c67u010zGiYHBlRVwwQ1EUibJwuSXq60jq1m/15U5cd
         OeRPCPH0EgWauTbf+XNU2v2+R1blUklZDvjeGjNTf2vltwRpGtHsWKD8+zvYy3zC2xp8
         2Qf8eJptDnC5VHUbvYVIGQN73doqaioG+pHqF1ePLCiNCgmoJGo57PD+tXCDYt0XWA4x
         NfyARnzJeYMEYD6apg2/BgRTjgiSWtmFWlWetLscN6qu4/P/xNfTncJBAqlKFM6Sd1/k
         34+x9Z6MX8YwiJjBG37kQJm49wuzMUzEUU8viJ7nW0ATqIP8Z5CUx7UnviYIacLixSYH
         tzYA==
X-Gm-Message-State: AOAM5319QXj9QsBzo5/U+j0LbT5cLQQkji+TaQEdIt5U+INoJ38KUzZE
        765zCrxQJ7Mb8esiF5FwiqcNUaa46ft1gv5PAtRB6WwnyYTBbMDnu95nT4t/zyHfiqYQ48yi/wD
        0IidDbGR7hvk/VPwZbF9nlFt5UvS1WAJyg8SwdM+nig==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr3027884pgl.67.1633608283529;
        Thu, 07 Oct 2021 05:04:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzHiZNAb241oCCwiqFrfpR6uZjW3GKfzxCOUU6/XE4t0x2GIQeJU/6lqla5VAFWAbn+IKTGdg==
X-Received: by 2002:a63:4c5c:: with SMTP id m28mr3027855pgl.67.1633608283272;
        Thu, 07 Oct 2021 05:04:43 -0700 (PDT)
Received: from localhost.localdomain ([69.163.84.166])
        by smtp.gmail.com with ESMTPSA id m2sm24386874pgd.70.2021.10.07.05.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 05:04:42 -0700 (PDT)
From:   Tim Gardner <tim.gardner@canonical.com>
To:     pkushwaha@marvell.com
Cc:     tim.gardner@canonical.com, Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shai Malin <smalin@marvell.com>,
        Omkar Kulkarni <okulkarni@marvell.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2][next] qed: Initialize debug string array
Date:   Thu,  7 Oct 2021 06:04:13 -0600
Message-Id: <20211007120413.8642-1-tim.gardner@canonical.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <MWHPR18MB10712FAF925C572621A5B1EDB2B19@MWHPR18MB1071.namprd18.prod.outlook.com>
References: <MWHPR18MB10712FAF925C572621A5B1EDB2B19@MWHPR18MB1071.namprd18.prod.outlook.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Coverity complains of an uninitialized variable.

CID 120847 (#1 of 1): Uninitialized scalar variable (UNINIT)
3. uninit_use_in_call: Using uninitialized value *sw_platform_str when calling qed_dump_str_param. [show details]
1344        offset += qed_dump_str_param(dump_buf + offset,
1345                                     dump, "sw-platform", sw_platform_str);

Fix this by removing dead code that references sw_platform_str.

Fixes: 6c95dd8f0aa1d ("qed: Update debug related changes")

Cc: Ariel Elior <aelior@marvell.com>
Cc: GR-everest-linux-l2@marvell.com
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Shai Malin <smalin@marvell.com>
Cc: Omkar Kulkarni <okulkarni@marvell.com>
Cc: Prabhakar Kushwaha <pkushwaha@marvell.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org (open list)
Signed-off-by: Tim Gardner <tim.gardner@canonical.com>
---

v2 - Arrive at the propoer fix per Prabhakar's suggestion.

---
 drivers/net/ethernet/qlogic/qed/qed_debug.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/qlogic/qed/qed_debug.c b/drivers/net/ethernet/qlogic/qed/qed_debug.c
index 6d693ee380f1..f6198b9a1b02 100644
--- a/drivers/net/ethernet/qlogic/qed/qed_debug.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_debug.c
@@ -1315,7 +1315,6 @@ static u32 qed_dump_common_global_params(struct qed_hwfn *p_hwfn,
 					 u8 num_specific_global_params)
 {
 	struct dbg_tools_data *dev_data = &p_hwfn->dbg_info;
-	char sw_platform_str[MAX_SW_PLTAFORM_STR_SIZE];
 	u32 offset = 0;
 	u8 num_params;
 
@@ -1341,8 +1340,6 @@ static u32 qed_dump_common_global_params(struct qed_hwfn *p_hwfn,
 				     dump,
 				     "platform",
 				     s_hw_type_defs[dev_data->hw_type].name);
-	offset += qed_dump_str_param(dump_buf + offset,
-				     dump, "sw-platform", sw_platform_str);
 	offset += qed_dump_num_param(dump_buf + offset,
 				     dump, "pci-func", p_hwfn->abs_pf_id);
 	offset += qed_dump_num_param(dump_buf + offset,
-- 
2.33.0

