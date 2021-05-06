Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8063754A8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 15:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhEFNXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 09:23:32 -0400
Received: from cmccmta2.chinamobile.com ([221.176.66.80]:7479 "EHLO
        cmccmta2.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhEFNXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 09:23:31 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.11]) by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56093eb65f18-a2159; Thu, 06 May 2021 21:13:12 +0800 (CST)
X-RM-TRANSID: 2ee56093eb65f18-a2159
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[112.22.251.0])
        by rmsmtp-syy-appsvr06-12006 (RichMail) with SMTP id 2ee66093eb639af-b000e;
        Thu, 06 May 2021 21:13:11 +0800 (CST)
X-RM-TRANSID: 2ee66093eb639af-b000e
From:   Tang Bin <tangbin@cmss.chinamobile.com>
To:     akpm@linux-foundation.org, ch0.han@lge.com
Cc:     linux-kernel@vger.kernel.org,
        Tang Bin <tangbin@cmss.chinamobile.com>,
        Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Subject: [PATCH] tools/vm/page_owner_sort.c: Fix the potential stack overflow risk
Date:   Thu,  6 May 2021 21:14:02 +0800
Message-Id: <20210506131402.10416-1-tangbin@cmss.chinamobile.com>
X-Mailer: git-send-email 2.20.1.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add judgment to fix the potential stack overflow risk

Signed-off-by: Zhang Shengju <zhangshengju@cmss.chinamobile.com>
Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
---
 tools/vm/page_owner_sort.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 85eb65ea1..bb7c35b77 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -132,6 +132,10 @@ int main(int argc, char **argv)
 	qsort(list, list_size, sizeof(list[0]), compare_txt);
 
 	list2 = malloc(sizeof(*list) * list_size);
+	if (!list2) {
+		printf("Out of memory\n");
+		exit(1);
+	}
 
 	printf("culling\n");
 
-- 
2.20.1.windows.1



