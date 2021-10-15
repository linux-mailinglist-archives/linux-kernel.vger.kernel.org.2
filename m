Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB3F42EEFC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 12:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235271AbhJOKoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 06:44:08 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:46696
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229690AbhJOKoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 06:44:07 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 4D8183FFE6;
        Fri, 15 Oct 2021 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1634294520;
        bh=v7OdXv/RsyUKyO5vRptejlwsl38tWRiS52N/qECPZZ0=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=aa29kGmvgw8ZkuF7H9Hwb3eKR2RfhxAhdJcSTTi2Wue+Jx3Zpeo/9ti6/6iX6wJY7
         y2F4G/be6OX0NUTTMhopoXe+PtxOORcXiDVz+ag2Azy7zPgTv/Opg4taYOYxqO67Uc
         Z3P58yMeHeGV06iHQeCU+XrOWgSzAK+ftR4q9WEORMpTuV/HIdvVS+Wbo931zmE5J2
         Jnf79GNKpYMsGqMLgPihacFy43xHirk6dH+t5qspCuxnh4HUs0DIt6G0cQq+YCxeck
         ZfR/WHjqpO8qRWq7ko7GJHLIgRB5SvaMrgdQe9xSbEfGBvV0bpeNxWFAbMFD+/kxjs
         RKcqZojYxi83A==
From:   Colin King <colin.king@canonical.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] lib/stackdepot: Fix spelling mistake and grammar in pr_err message
Date:   Fri, 15 Oct 2021 11:41:59 +0100
Message-Id: <20211015104159.11282-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake of the work allocation so fix this and
re-phrase the message to make it easier to read.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/stackdepot.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 8894a5171b25..8b6c41585203 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -186,7 +186,7 @@ __ref int stack_depot_init(void)
 			for (i = 0; i < STACK_HASH_SIZE;  i++)
 				stack_table[i] = NULL;
 		} else {
-			pr_err("Stack Depot failed hash table allocationg, disabling\n");
+			pr_err("Stack Depot hash table allocation failed, disabling\n");
 			stack_depot_disable = true;
 			mutex_unlock(&stack_depot_init_mutex);
 			return -ENOMEM;
-- 
2.32.0

