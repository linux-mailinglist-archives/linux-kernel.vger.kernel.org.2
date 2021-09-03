Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18563FFB7C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 10:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348145AbhICIE4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 04:04:56 -0400
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:48968
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348111AbhICIDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:03:35 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id B14E6401AC;
        Fri,  3 Sep 2021 08:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1630656123;
        bh=ByAsbR20s9NhcFCO7C8upmZ5fdtQCFGKXyg6z4SBVX4=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=SU+z/nuqk6f1yohYbo71bpUvQlLjL5HS75dJQ7mWEqQyxBPf1OuljahOkg1IPvihk
         I8vwMLtg0BzVLd4GPpQHm+C53HnZ1K1UONUCAYHZGbXs3yFRzhoF4a3soBoUJ3HVn1
         oj6Nmc0lrolJaABUmwnWQmC2JDw3mZd21akUdbN8KO/hqQI4/QiQvGFjnvUZuDqCT2
         xnYL760Xf/SeLFxeRpBvu/J0+Aj1uP03pG4SN40aLmTrH9P0puKh5h1O1wrpHIB22P
         YCJ45SeSw+njFlRDI+W+TNJCOnMDnqZEGrwxhRT/XO1qgLE5LtMrClBGzig06CQkYR
         wod9EPWMi/zmA==
From:   Colin King <colin.king@canonical.com>
To:     Oded Gabbay <ogabbay@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] habanalabs: Fix spelling mistake "FEADBACK" -> "FEEDBACK"
Date:   Fri,  3 Sep 2021 09:02:03 +0100
Message-Id: <20210903080203.6136-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/misc/habanalabs/gaudi/gaudi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 383865be3c2c..1d5fcca1ee0c 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -395,7 +395,7 @@ static struct hl_hw_obj_name_entry gaudi_so_id_to_str[] = {
 
 static struct hl_hw_obj_name_entry gaudi_monitor_id_to_str[] = {
 	{ .id = 200, .name = "MON_OBJ_DMA_DOWN_FEEDBACK_RESET" },
-	{ .id = 201, .name = "MON_OBJ_DMA_UP_FEADBACK_RESET" },
+	{ .id = 201, .name = "MON_OBJ_DMA_UP_FEEDBACK_RESET" },
 	{ .id = 203, .name = "MON_OBJ_DRAM_TO_SRAM_QUEUE_FENCE" },
 	{ .id = 204, .name = "MON_OBJ_TPC_0_CLK_GATE" },
 	{ .id = 205, .name = "MON_OBJ_TPC_1_CLK_GATE" },
-- 
2.32.0

