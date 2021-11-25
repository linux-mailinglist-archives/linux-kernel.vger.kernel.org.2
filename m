Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968EC45DAC3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 14:12:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352103AbhKYNPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 08:15:11 -0500
Received: from pv50p00im-zteg10021301.me.com ([17.58.6.46]:59349 "EHLO
        pv50p00im-zteg10021301.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352357AbhKYNNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 08:13:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1637845800; bh=+ArmKywOdE09QNfbBo1DffDIX/nRSHFgP3KVGEK0QRk=;
        h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=fWEJ8S15hPUNtju4XKMDIzehtfNEj9cnibuTxkiwHhqKxQHDMcUzGXYJ3uSNoqzhY
         Lnq0KXZtMdgMHe+d3LAMY6dEI1nphQg18Mced5dDu7hyOFKULaR26lZ1fJwN4TnU/U
         FvGTWDp+bxvb4JdVzeDOOTifkjkRpdWaCYphB1B1DnvHkkjJjlIfOvxbNi4R8kMyKO
         NNumwk2ocWLlJtr4u3dPC5ubAKK8E6Wuscut/CkSffBP0oJx9rsKOB6Tt05LBD5m7B
         oawSoX5O0I64ZFjl9PFufQoDrlBlfiKItakJrATPte9oWb8fnoFRgQTTbQJMB32AzI
         mTYzDpU5o1VfQ==
Received: from xiongwei.. (unknown [120.245.2.185])
        by pv50p00im-zteg10021301.me.com (Postfix) with ESMTPSA id D0D3FCC0350;
        Thu, 25 Nov 2021 13:09:41 +0000 (UTC)
From:   sxwjean@me.com
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Xiongwei Song <sxwjean@gmail.com>,
        Arthur Marsh <arthur.marsh@internode.on.net>
Subject: [PATCH] mm: page_alloc: Fix building error on -Werror=array-compare
Date:   Thu, 25 Nov 2021 21:09:28 +0800
Message-Id: <20211125130928.32465-1-sxwjean@me.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.790
 definitions=2021-11-25_05:2021-11-25,2021-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=763 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2111250073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

Arthur Marsh reported we would hit the error below when building kernel
with gcc-12:
CC      mm/page_alloc.o
mm/page_alloc.c: In function ‘mem_init_print_info’:
mm/page_alloc.c:8173:27: error: comparison between two arrays [-Werror=array-compare]
 8173 |                 if (start <= pos && pos < end && size > adj) \
      |

In C++20, the comparision between arrays should be warned.

Reported-by: Arthur Marsh <arthur.marsh@internode.on.net>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..8f304c3d0e19 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8170,7 +8170,7 @@ void __init mem_init_print_info(void)
 	 */
 #define adj_init_size(start, end, size, pos, adj) \
 	do { \
-		if (start <= pos && pos < end && size > adj) \
+		if (&start[0] <= &pos[0] && &pos[0] < &end[0] && size > adj) \
 			size -= adj; \
 	} while (0)
 
-- 
2.30.2

