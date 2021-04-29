Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C143D36E51C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 08:51:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237102AbhD2Gvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 02:51:41 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:54301 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhD2Gvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 02:51:39 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210429065051epoutp0258d126ace0da38238fae9a52b11ed5b8~6QYQiT_j51654716547epoutp02y
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 06:50:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210429065051epoutp0258d126ace0da38238fae9a52b11ed5b8~6QYQiT_j51654716547epoutp02y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1619679051;
        bh=tlw0avSX2wOoEZ1KYfcEj/kTJmF/Mffz5DkEvg1IGFQ=;
        h=Subject:Reply-To:From:To:Date:References:From;
        b=EY6ZkIOqlC+9QEA4lhu0CbhrfiC+xePsp7uxmplPv0a3cau3NYsfA91uplRFp6L/K
         lD1P+va+TcvSeaJhXUzdk6o915GTEpJXJEpq8bDcs10hX1ObcHUUnJlnbWHZbqydkx
         Pl2rpaksEoRD0lX0Z32B2yJ105DgA9cIqNYEqPXE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20210429065048epcas2p28806dc6a3ffe0af4cd9b2c924ca329c0~6QYNZqFOw2841528415epcas2p2j;
        Thu, 29 Apr 2021 06:50:48 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.185]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4FW5jz1Ft4z4x9Pw; Thu, 29 Apr
        2021 06:50:47 +0000 (GMT)
X-AuditID: b6c32a46-e01ff700000025de-a1-608a5744395d
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        A0.DC.09694.4475A806; Thu, 29 Apr 2021 15:50:44 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] f2fs: refactoring nat and sit functions
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Chao Yu <yuchao0@huawei.com>,
        Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210429065038epcms2p538390e44af97feae43437fb97aa0759e@epcms2p5>
Date:   Thu, 29 Apr 2021 15:50:38 +0900
X-CMS-MailID: 20210429065038epcms2p538390e44af97feae43437fb97aa0759e
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQtclvCvB4Od5VYvTU88yWbw8pGmx
        6kG4xZP1s5gtLi1yt7i8aw6bxdTHa1kd2D1ajrxl9di0qpPNY/eCz0wefVtWMXp83iQXwBqV
        Y5ORmpiSWqSQmpecn5KZl26r5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDdIOSQlli
        TilQKCCxuFhJ386mKL+0JFUhI7+4xFYptSAlp8DQsECvODG3uDQvXS85P9fK0MDAyBSoMiEn
        Y/3WzWwFB40q5r/YzNrAeFmzi5GTQ0LARKJn+R+mLkYuDiGBHYwSt2fOYO5i5ODgFRCU+LtD
        GKRGWMBC4kz7WiYQW0hASWL9xVnsEHE9iVsP1zCC2GwCOhLTT9xnB5kjIrCJSWLJks3MEAt4
        JWa0P2WBsKUlti/fyghha0j8WNYLVSMqcXP1W3YY+/2x+VA1IhKt985C1QhKPPi5GyouKXFs
        9wcmCLteYuudX4wgiyUEehglDu+8xQqR0Je41rERbDGvgK/Eytn/wRpYBFQlzu+/C7XMRWLh
        yh1gQ5kF5CW2v50D9jyzgKbE+l36IKaEgLLEkVssMK80bPzNjs5mFuCT6Dj8Fy6+Y94TqNPU
        JNb9XM8EMUZG4tY8qOs9JNbNes84gVFxFiKgZyE5YRbCCQsYmVcxiqUWFOempxYbFRghx+0m
        RnBy1HLbwTjl7Qe9Q4xMHIyHGCU4mJVEeH+v60wQ4k1JrKxKLcqPLyrNSS0+xGgK9PxEZinR
        5Hxges4riTc0NTIzM7A0tTA1M7JQEuf9mVqXICSQnliSmp2aWpBaBNPHxMEp1cB0ViSm279a
        4Eilmn5lMKOyaYe/j379dTEbG6OyQNFXPwuOzdHcf+9479ms5e1bPwQ9ZQjYq/hbb4LR15Rj
        mg9m/N3YqX85V5996xYGbvvAzL5Uj2Mqb251tpdXl5S1i8Tsaa08MXWfvFXRwYcT139yO/v5
        xK/6mPmd13tYmv9Pe3VP9ujcrNpmt5rNrFK2PzT36xUe3Bx7b3rY9i/CKrGnFnyQKzr9+JPr
        bae4iV+Yo7emTHebuernmQVtSzgO1jD5heg7+2rO2XTVdoK0tO+tkL43l+f236lqdFj8etlN
        859TpjL4sFZPte4N+bvm795gvZwT1q0J+31bm0Kflb99crrR97NUou+T5A3XPd8osRRnJBpq
        MRcVJwIAzfgARxcEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210429065038epcms2p538390e44af97feae43437fb97aa0759e
References: <CGME20210429065038epcms2p538390e44af97feae43437fb97aa0759e@epcms2p5>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch separates the APIs for nat and sit.

f2fs_lookup_journal_in_cursum -> f2fs_lookup_journal_{nats|sits}_in_cursum
__has_cursum_space -> __has_{nats|sits}_in_cursum_space

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/f2fs/f2fs.h    | 16 +++++++++++-----
 fs/f2fs/node.c    | 11 +++++------
 fs/f2fs/segment.c | 46 +++++++++++++++++++++++++++-------------------
 3 files changed, 43 insertions(+), 30 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index b9d5317db0a7..e264fedacc9e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -416,11 +416,15 @@ static inline int update_sits_in_cursum(struct f2fs_journal *journal, int i)
 	return before;
 }
 
-static inline bool __has_cursum_space(struct f2fs_journal *journal,
-							int size, int type)
+static inline bool __has_nats_in_cursum_space(struct f2fs_journal *journal,
+					      int size)
+{
+	return size <= MAX_NAT_JENTRIES(journal);
+}
+
+static inline bool __has_sits_in_cursum_space(struct f2fs_journal *journal,
+					      int size)
 {
-	if (type == NAT_JOURNAL)
-		return size <= MAX_NAT_JENTRIES(journal);
 	return size <= MAX_SIT_JENTRIES(journal);
 }
 
@@ -3420,7 +3424,9 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 								block_t len);
 void f2fs_write_data_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
 void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk);
-int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
+int f2fs_lookup_journal_sits_in_cursum(struct f2fs_journal *journal,
+			unsigned int val, int alloc);
+int f2fs_lookup_journal_nats_in_cursum(struct f2fs_journal *journal,
 			unsigned int val, int alloc);
 void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc);
 int f2fs_fix_curseg_write_pointer(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index e67ce5f13b98..cb295eb8ed91 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -554,7 +554,7 @@ int f2fs_get_node_info(struct f2fs_sb_info *sbi, nid_t nid,
 
 	/* Check current segment summary */
 	down_read(&curseg->journal_rwsem);
-	i = f2fs_lookup_journal_in_cursum(journal, NAT_JOURNAL, nid, 0);
+	i = f2fs_lookup_journal_nats_in_cursum(journal, nid, 0);
 	if (i >= 0) {
 		ne = nat_in_journal(journal, i);
 		node_info_from_raw_nat(ni, &ne);
@@ -2891,7 +2891,7 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	 * #2, flush nat entries to nat page.
 	 */
 	if (enabled_nat_bits(sbi, cpc) ||
-		!__has_cursum_space(journal, set->entry_cnt, NAT_JOURNAL))
+		!__has_nats_in_cursum_space(journal, set->entry_cnt))
 		to_journal = false;
 
 	if (to_journal) {
@@ -2914,8 +2914,8 @@ static int __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 		f2fs_bug_on(sbi, nat_get_blkaddr(ne) == NEW_ADDR);
 
 		if (to_journal) {
-			offset = f2fs_lookup_journal_in_cursum(journal,
-							NAT_JOURNAL, nid, 1);
+			offset = f2fs_lookup_journal_nats_in_cursum(journal,
+							nid, 1);
 			f2fs_bug_on(sbi, offset < 0);
 			raw_ne = &nat_in_journal(journal, offset);
 			nid_in_journal(journal, offset) = cpu_to_le32(nid);
@@ -2985,8 +2985,7 @@ int f2fs_flush_nat_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * into nat entry set.
 	 */
 	if (enabled_nat_bits(sbi, cpc) ||
-		!__has_cursum_space(journal,
-			nm_i->nat_cnt[DIRTY_NAT], NAT_JOURNAL))
+		!__has_nats_in_cursum_space(journal, nm_i->nat_cnt[DIRTY_NAT]))
 		remove_nats_in_journal(sbi);
 
 	while ((found = __gang_lookup_nat_set(nm_i,
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index efac388d2468..63bfbc2603ae 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4013,25 +4013,33 @@ void f2fs_write_node_summaries(struct f2fs_sb_info *sbi, block_t start_blk)
 	write_normal_summaries(sbi, start_blk, CURSEG_HOT_NODE);
 }
 
-int f2fs_lookup_journal_in_cursum(struct f2fs_journal *journal, int type,
+int f2fs_lookup_journal_nats_in_cursum(struct f2fs_journal *journal,
 					unsigned int val, int alloc)
 {
 	int i;
 
-	if (type == NAT_JOURNAL) {
-		for (i = 0; i < nats_in_cursum(journal); i++) {
-			if (le32_to_cpu(nid_in_journal(journal, i)) == val)
-				return i;
-		}
-		if (alloc && __has_cursum_space(journal, 1, NAT_JOURNAL))
-			return update_nats_in_cursum(journal, 1);
-	} else if (type == SIT_JOURNAL) {
-		for (i = 0; i < sits_in_cursum(journal); i++)
-			if (le32_to_cpu(segno_in_journal(journal, i)) == val)
-				return i;
-		if (alloc && __has_cursum_space(journal, 1, SIT_JOURNAL))
-			return update_sits_in_cursum(journal, 1);
-	}
+	for (i = 0; i < nats_in_cursum(journal); i++)
+		if (le32_to_cpu(nid_in_journal(journal, i)) == val)
+			return i;
+
+	if (alloc && __has_nats_in_cursum_space(journal, 1))
+		return update_nats_in_cursum(journal, 1);
+
+	return -1;
+}
+
+int f2fs_lookup_journal_sits_in_cursum(struct f2fs_journal *journal,
+					unsigned int val, int alloc)
+{
+	int i;
+
+	for (i = 0; i < sits_in_cursum(journal); i++)
+		if (le32_to_cpu(segno_in_journal(journal, i)) == val)
+			return i;
+
+	if (alloc && __has_sits_in_cursum_space(journal, 1))
+		return update_sits_in_cursum(journal, 1);
+
 	return -1;
 }
 
@@ -4174,7 +4182,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 	 * entries, remove all entries from journal and add and account
 	 * them in sit entry set.
 	 */
-	if (!__has_cursum_space(journal, sit_i->dirty_sentries, SIT_JOURNAL) ||
+	if (!__has_sits_in_cursum_space(journal, sit_i->dirty_sentries) ||
 								!to_journal)
 		remove_sits_in_journal(sbi);
 
@@ -4192,7 +4200,7 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 		unsigned int segno = start_segno;
 
 		if (to_journal &&
-			!__has_cursum_space(journal, ses->entry_cnt, SIT_JOURNAL))
+			!__has_sits_in_cursum_space(journal, ses->entry_cnt))
 			to_journal = false;
 
 		if (to_journal) {
@@ -4220,8 +4228,8 @@ void f2fs_flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
 			}
 
 			if (to_journal) {
-				offset = f2fs_lookup_journal_in_cursum(journal,
-							SIT_JOURNAL, segno, 1);
+				offset = f2fs_lookup_journal_sits_in_cursum(
+						journal, segno, 1);
 				f2fs_bug_on(sbi, offset < 0);
 				segno_in_journal(journal, offset) =
 							cpu_to_le32(segno);
-- 
2.25.1

