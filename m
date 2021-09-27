Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2E25418EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 08:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhI0GIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 02:08:32 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18559 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232924AbhI0GIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 02:08:31 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20210927060651epoutp02af262d5ec5ad44328bbe47b523e6bc7f~omL80BEn82358123581epoutp02J
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:06:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20210927060651epoutp02af262d5ec5ad44328bbe47b523e6bc7f~omL80BEn82358123581epoutp02J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632722811;
        bh=arZ5Z5z9yCYJLYv6BmzcDUc6j2jcFI4JwqTbvTfJDHc=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=DLK2WntUwoXO9xRj+QvJ00m7Fh8ZuPujv0VktjGPnelUKm2f7mS8oIqxZFhRkF6/O
         0UKwhilrdisYQDJLbdHlOBtGwJWK1sLGMbKAB/dNPrEtJAXtwYnBlCUl2ilUpr4ouz
         CEhWFR9y9B9ITcI4eJeE8AENDsP6882/XVIz7lrk=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20210927060651epcas2p3c2d70f0365b5e788ec4076101340e276~omL8SLJl32960229602epcas2p3E;
        Mon, 27 Sep 2021 06:06:51 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.40.187]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4HHsbZ0g8Jz4x9QY; Mon, 27 Sep
        2021 06:06:50 +0000 (GMT)
X-AuditID: b6c32a45-4c1ff700000025f5-b2-61515f791519
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.6E.09717.97F51516; Mon, 27 Sep 2021 15:06:49 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] f2fs: fix to use WHINT_MODE
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jinyoung CHOI <j-young.choi@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210927060648epcms2p4fb042fab3a79cdffba4bf995e1270831@epcms2p4>
Date:   Mon, 27 Sep 2021 15:06:48 +0900
X-CMS-MailID: 20210927060648epcms2p4fb042fab3a79cdffba4bf995e1270831
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdljTTLcyPjDR4P53LovTU88yWbw8pGmx
        6kG4RW//VjaLJ+tnMVtcWuRucXnXHDaLzulrWBw4PDat6mTz2L3gM5NH35ZVjB6fN8kFsETl
        2GSkJqakFimk5iXnp2TmpdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3aCkUJaY
        UwoUCkgsLlbSt7Mpyi8tSVXIyC8usVVKLUjJKTA0LNArTswtLs1L10vOz7UyNDAwMgWqTMjJ
        +P3lIWvBS/aKjVMuszYwHmfrYuTkkBAwkbjy+jQ7iC0ksINR4tvuwi5GDg5eAUGJvzuEQcLC
        AjoSK/bvZIIoUZLoWriVGSJuILFu+h4wm01AT2LK7zuMILaIwCtGiTOrRbsYuTiYBZoYJW6t
        7YXaxSsxo/0pC4QtLbF9+VZGCFtD4seyXmYIW1Ti5uq37DD2+2PzoWpEJFrvnYWqEZR48HM3
        I8idEgKSEmcOu0KEyyUWnl/GDrJXQqCDUeL19wVQc/QlrnVsBNvLK+Ar8eTeWzCbRUBV4vzS
        FqgaF4nvzRvBnmQWkJfY/nYOM8h8ZgFNifW79CFWKUscucUC80nDxt/s6GxmAT6JjsN/4eI7
        5j1hgrDVJB4t2MIKYctIXJxzjnkCo9IsREDPQrJ3FsLeBYzMqxjFUguKc9NTi40KDJGjdhMj
        ODVque5gnPz2g94hRiYOxkOMEhzMSiK8wSz+iUK8KYmVValF+fFFpTmpxYcYTYE+nsgsJZqc
        D0zOeSXxhqZGZmYGlqYWpmZGFkrivHP/OSUKCaQnlqRmp6YWpBbB9DFxcEo1MGU8F400kGAp
        +vP3u++d58qrjqvNs4w9+nvx5qC9JWah9990SZ/j2voofsrrC7+meXO9tTAtUUwVSNAxs7sk
        X1FkUxZztGOuTHKOgszuhatLTjVmii/e+2/WwVOr1rQfad8ktOKoloXp653v3Yo//mq7Pd+9
        Pk9c1Xfj+m87bBge9h17+LBXzmlFb+PT1avb97YHRPZuOx0Ut9ZHPdfOa/ap2XO2aS85Fae7
        P8vglOiU6fyfN9VPWNg9mzOY+47zq47Ljt8KvizilHBSdFh/rOleqahNuvUNXe4Xt6/WZrpV
        PUk+8EudPX0JR8myV6UXIkSDjngKRJi/lSpZa2oYeFRnBaeQaXXkZpEPube00pRYijMSDbWY
        i4oTAW/0q4AWBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210927060648epcms2p4fb042fab3a79cdffba4bf995e1270831
References: <CGME20210927060648epcms2p4fb042fab3a79cdffba4bf995e1270831@epcms2p4>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since active_logs can be set to 2 or 4 or NR_CURSEG_PERSIST_TYPE(6),
it cannot be set to NR_CURSEG_TYPE(8).
That is, whint_mode is always off.

Therefore, the condition is changed from NR_CURSEG_TYPE to NR_CURSEG_PERSIST_TYPE.

Cc: Chao Yu <chao@kernel.org>
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
 fs/f2fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78ebc306ee2b..86eeb019cc52 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1292,7 +1292,7 @@ static int parse_options(struct super_block *sb, char *options, bool is_remount)
 	/* Not pass down write hints if the number of active logs is lesser
 	 * than NR_CURSEG_PERSIST_TYPE.
 	 */
-	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_TYPE)
+	if (F2FS_OPTION(sbi).active_logs != NR_CURSEG_PERSIST_TYPE)
 		F2FS_OPTION(sbi).whint_mode = WHINT_MODE_OFF;
 
 	if (f2fs_sb_has_readonly(sbi) && !f2fs_readonly(sbi->sb)) {
-- 
2.17.1
