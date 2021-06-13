Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8863A58DC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 15:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231921AbhFMNnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 09:43:40 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53750 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231838AbhFMNnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 09:43:39 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lsQMr-0003KJ-D7; Sun, 13 Jun 2021 13:41:37 +0000
From:   Colin King <colin.king@canonical.com>
To:     Evgeniy Dushistov <dushistov@mail.ru>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ufs: remove redundant assignment to pointer p
Date:   Sun, 13 Jun 2021 14:41:37 +0100
Message-Id: <20210613134137.74131-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer p is being initialized with a value that is never
read before the function returns. The assignment is redundant
and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ufs/dir.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ufs/dir.c b/fs/ufs/dir.c
index b721d0bda5e5..23cb6c8787f3 100644
--- a/fs/ufs/dir.c
+++ b/fs/ufs/dir.c
@@ -176,7 +176,6 @@ static bool ufs_check_page(struct page *page)
 		   rec_len, ufs_get_de_namlen(sb, p));
 	goto fail;
 Eend:
-	p = (struct ufs_dir_entry *)(kaddr + offs);
 	ufs_error(sb, __func__,
 		   "entry in directory #%lu spans the page boundary"
 		   "offset=%lu",
-- 
2.31.1

