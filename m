Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE9639EF48
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 09:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFHHNn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 03:13:43 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:3785 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbhFHHNd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 03:13:33 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fzh9z58FVzWsgm;
        Tue,  8 Jun 2021 15:06:47 +0800 (CST)
Received: from dggpemm500006.china.huawei.com (7.185.36.236) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:38 +0800
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 dggpemm500006.china.huawei.com (7.185.36.236) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 15:11:37 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH 4/5] lib/ts_bm.c: remove trailing spaces and tabs
Date:   Tue, 8 Jun 2021 15:11:16 +0800
Message-ID: <20210608071117.12634-5-thunder.leizhen@huawei.com>
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

sed -r -i 's/[ \t]+$//' lib/ts_bm.c

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 lib/ts_bm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 4cf250031f0f..65e6489597a2 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -5,27 +5,27 @@
  * Authors:	Pablo Neira Ayuso <pablo@eurodev.net>
  *
  * ==========================================================================
- * 
+ *
  *   Implements Boyer-Moore string matching algorithm:
  *
  *   [1] A Fast String Searching Algorithm, R.S. Boyer and Moore.
- *       Communications of the Association for Computing Machinery, 
+ *       Communications of the Association for Computing Machinery,
  *       20(10), 1977, pp. 762-772.
  *       https://www.cs.utexas.edu/users/moore/publications/fstrpos.pdf
  *
  *   [2] Handbook of Exact String Matching Algorithms, Thierry Lecroq, 2004
  *       http://www-igm.univ-mlv.fr/~lecroq/string/string.pdf
  *
- *   Note: Since Boyer-Moore (BM) performs searches for matchings from right 
- *   to left, it's still possible that a matching could be spread over 
+ *   Note: Since Boyer-Moore (BM) performs searches for matchings from right
+ *   to left, it's still possible that a matching could be spread over
  *   multiple blocks, in that case this algorithm won't find any coincidence.
- *   
+ *
  *   If you're willing to ensure that such thing won't ever happen, use the
- *   Knuth-Pratt-Morris (KMP) implementation instead. In conclusion, choose 
- *   the proper string search algorithm depending on your setting. 
+ *   Knuth-Pratt-Morris (KMP) implementation instead. In conclusion, choose
+ *   the proper string search algorithm depending on your setting.
  *
- *   Say you're using the textsearch infrastructure for filtering, NIDS or 
- *   any similar security focused purpose, then go KMP. Otherwise, if you 
+ *   Say you're using the textsearch infrastructure for filtering, NIDS or
+ *   any similar security focused purpose, then go KMP. Otherwise, if you
  *   really care about performance, say you're classifying packets to apply
  *   Quality of Service (QoS) policies, and you don't mind about possible
  *   matchings spread over multiple fragments, then go BM.
@@ -70,9 +70,9 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 			break;
 
 		while (shift < text_len) {
-			DEBUGP("Searching in position %d (%c)\n", 
+			DEBUGP("Searching in position %d (%c)\n",
 				shift, text[shift]);
-			for (i = 0; i < bm->patlen; i++) 
+			for (i = 0; i < bm->patlen; i++)
 				if ((icase ? toupper(text[shift-i])
 				    : text[shift-i])
 					!= bm->pattern[bm->patlen-1-i])
@@ -124,7 +124,7 @@ static void compute_prefix_tbl(struct ts_bm *bm, int flags)
 			    = bm->patlen - 1 - i;
 	}
 
-	/* Compute the good shift array, used to match reocurrences 
+	/* Compute the good shift array, used to match reocurrences
 	 * of a subpattern */
 	bm->good_shift[0] = 1;
 	for (i = 1; i < bm->patlen; i++)
-- 
2.25.1


