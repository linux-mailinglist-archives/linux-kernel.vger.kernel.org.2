Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F5C39EF45
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhFHHNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:13:37 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:4394 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbhFHHNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:13:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzhC764Jwz6vXV;
        Tue,  8 Jun 2021 15:07:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:37 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 2/5] Fonts: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:11:14 +0800
Message-ID: <20210608071117.12634-3-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210608071117.12634-1-thunder.leizhen@huawei.com>
References: <20210608071117.12634-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500006.china.huawei.com (7.185.36.236)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Run the following command to find and remove the trailing spaces and tabs:

find lib/fonts/ -type f | xargs sed -r -i 's/[ \t]+$//'

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/fonts/font_acorn_8x8.c | 2 +-
 lib/fonts/font_mini_4x6.c  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/fonts/font_acorn_8x8.c b/lib/fonts/font_acorn_8x8.c
index 18755c33d249..af5fa72aa8b7 100644
--- a/lib/fonts/font_acorn_8x8.c
+++ b/lib/fonts/font_acorn_8x8.c
@@ -68,7 +68,7 @@ static const struct font_data acorndata_8x8 = {
 /* 3A */  0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x00, /* : */
 /* 3B */  0x00, 0x00, 0x18, 0x18, 0x00, 0x18, 0x18, 0x30, /* ; */
 /* 3C */  0x0C, 0x18, 0x30, 0x60, 0x30, 0x18, 0x0C, 0x00, /* < */
-/* 3D */  0x00, 0x00, 0x7E, 0x00, 0x7E, 0x00, 0x00, 0x00, /* = */ 
+/* 3D */  0x00, 0x00, 0x7E, 0x00, 0x7E, 0x00, 0x00, 0x00, /* = */
 /* 3E */  0x30, 0x18, 0x0C, 0x06, 0x0C, 0x18, 0x30, 0x00, /* > */
 /* 3F */  0x3C, 0x66, 0x0C, 0x18, 0x18, 0x00, 0x18, 0x00, /* ? */
 /* 40 */  0x3C, 0x66, 0x6E, 0x6A, 0x6E, 0x60, 0x3C, 0x00, /* @ */
diff --git a/lib/fonts/font_mini_4x6.c b/lib/fonts/font_mini_4x6.c
index 8d39fd447952..cc21dc70cfd1 100644
--- a/lib/fonts/font_mini_4x6.c
+++ b/lib/fonts/font_mini_4x6.c
@@ -18,15 +18,15 @@
 s{((0x)?[0-9a-fA-F]+)(.*\[([\*\ ]{4})\])}{
 
 	($num,$pat,$bits) = ($1,$3,$4);
-	
+
 	$bits =~ s/([^\s0])|(.)/ defined($1) + 0 /ge;
-	
+
 	$num = ord(pack("B8", $bits));
 	$num |= $num >> 4;
 	$num = sprintf("0x%.2x", $num);
-	
+
 	#print "$num,$pat,$bits\n";
-	
+
 	$num . $pat;
 }ge;
 
-- 
2.25.1


