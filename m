Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 208363DF1BB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 17:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236940AbhHCPnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 11:43:02 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59168
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236941AbhHCPnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 11:43:01 -0400
Received: from localhost (1.general.cking.uk.vpn [10.172.193.212])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPSA id 50CCD3F07A;
        Tue,  3 Aug 2021 15:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1628005369;
        bh=NGuo4/5NmnxC89j3QvU804ef/HB0LY2wSjcDEMa1lNI=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=J0L5Ehe/P3aJvRWzl526hIudkfwHj0l6lLwdnfJVqAw4rEM0IaWIOu7LDwWTW60q8
         VtsGJVDLTEOBSlirOQ76S5sF5Da5KnIHt1QZ7uDryiav5/eM3U9JH+orApgeLjGWQt
         tXwkW2Kdh1CP4667zEsgA8Fj7UmE80PrRBMTXPcxf6CUN4UTntz/3GIPSXYiYjaxs9
         3eGLekmhjOyXieWksoD2XWhhoFvpx5a83gYoufdD/8lrRbn+b/91KlY85oMRi7FVA4
         dR4KMN2SI1XUjyEtjTyhIhed2rzb9y2X+b9oExTgYDqxp9DDPZ39i/UdqF9ZOE9j/f
         3r2B346Xrlirw==
From:   Colin King <colin.king@canonical.com>
To:     Alasdair Kergon <agk@redhat.com>, dm-devel@redhat.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] dm ima: Fix resource leaks on error return path
Date:   Tue,  3 Aug 2021 16:42:49 +0100
Message-Id: <20210803154249.81251-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently there is an error check on r that immediately returns
on an error rather than taking the error clean-up exit path via
label 'error'. Fix this to avoid resource leaks.

Addresses-Coverity: ("Resourced leak")
Fixes: 0a3bec81a409 ("dm ima: measure data on table load")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/md/dm-ima.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/md/dm-ima.c b/drivers/md/dm-ima.c
index 2d796e439bee..91ea4a7202ab 100644
--- a/drivers/md/dm-ima.c
+++ b/drivers/md/dm-ima.c
@@ -216,7 +216,7 @@ void dm_ima_measure_on_table_load(struct dm_table *table, unsigned int status_fl
 
 	r = crypto_shash_init(shash);
 	if (r)
-		return;
+		goto error;
 
 	device_data_buf_len = strlen(device_data_buf);
 	memcpy(ima_buf + l, device_data_buf, device_data_buf_len);
-- 
2.31.1

