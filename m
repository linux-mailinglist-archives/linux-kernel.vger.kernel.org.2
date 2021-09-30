Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B17641D0C4
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 02:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347089AbhI3BBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 21:01:38 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:63180 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbhI3BBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 21:01:36 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210930005953epoutp0375a5606b11c67568a9a96401a1bc71a3~pc7x3UqMA2392123921epoutp03k
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 00:59:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210930005953epoutp0375a5606b11c67568a9a96401a1bc71a3~pc7x3UqMA2392123921epoutp03k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1632963593;
        bh=Hmrht/E5BxEbIYYeu0hx6z1MushbCu0sIpLHFV6KIxs=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=sj/EyOF413SUbtyW8oXYSaEm/v/EFETwVOfRA4CkrYvcbN6mZ1HZzvAiorp2Z+UAX
         +AXesCl5L4kGbN0LnU63mm46x4TcXK2GfM/UGtzMbYRwWJ1U4SMDSwOLHD6G8VaREk
         v6Lge5+1kdmD1ikb3qn1y+b4ofkBiMW1pM2RKvzA=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20210930005952epcas2p48cd1057fa3b2260997dbc75f1db6b174~pc7xcC_KZ1553315533epcas2p4I;
        Thu, 30 Sep 2021 00:59:52 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.97]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4HKZdp4N6nz4x9QZ; Thu, 30 Sep
        2021 00:59:42 +0000 (GMT)
X-AuditID: b6c32a48-d75ff70000002500-58-61550bfb2484
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        25.30.09472.BFB05516; Thu, 30 Sep 2021 09:59:39 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] f2fs: fix to use WHINT_MODE
Reply-To: keosung.park@samsung.com
Sender: Keoseong Park <keosung.park@samsung.com>
From:   Keoseong Park <keosung.park@samsung.com>
To:     "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>
CC:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tanghuan@vivo.com" <tanghuan@vivo.com>,
        "changfengnan@vivo.com" <changfengnan@vivo.com>,
        Daejun Park <daejun7.park@samsung.com>,
        Jinyoung CHOI <j-young.choi@samsung.com>,
        Sung-Jun Park <sungjun07.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20210930005939epcms2p7303bf6f96c824720f824989746491cba@epcms2p7>
Date:   Thu, 30 Sep 2021 09:59:39 +0900
X-CMS-MailID: 20210930005939epcms2p7303bf6f96c824720f824989746491cba
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
X-CPGSPASS: Y
X-CPGSPASS: Y
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmue5v7tBEg90/ZCzW9O1isjg99SyT
        xctDmharHoRb9PZvZbN4sn4Ws8WlRe4Wl3fNYbPonL6GxWLO0U52By6PTas62Tx2L/jM5NG3
        ZRWjx+dNch4bPnUwB7BGZdtkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam
        2iq5+AToumXmAJ2kpFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwL9ArTswtLs1L
        18tLLbEyNDAwMgUqTMjO6Nl9ga1gOmfFm/VLmRsYb7B3MXJySAiYSGx69oypi5GLQ0hgB6PE
        4tebWLoYOTh4BQQl/u4QBqkRFtCX2D7xPFi9kICSRNfCrcwQcQOJddP3gNlsAnoSU37fYQSx
        RQRCJF5PbgGbySzwjUni29OHbBDLeCVmtD9lgbClJbYv38oIYWtI/FjWywxhi0rcXP2WHcZ+
        f2w+VI2IROu9s1A1ghIPfu5mBLlTQkBS4sxhV4hwucTC88vYQfZKCHQwSrz+vgBqjr7EtY6N
        YHt5BXwlbu9uB+tlEVCVWHVKFaLERWLekktgJcwC8hLb385hBilhFtCUWL9LH2KTssSRWyww
        jzRs/M2OzmYW4JPoOPwXLr5j3hMmCFtN4tGCLawQtozExTnnmCcwKs1ChPMsJHtnIexdwMi8
        ilEstaA4Nz212KjABB61yfm5mxjBaVPLYwfj7Lcf9A4xMnEwHmKU4GBWEuH9IR6cKMSbklhZ
        lVqUH19UmpNafIjRFOjhicxSosn5wMSdVxJvaGJpYGJmZmhuZGpgriTOO/efU6KQQHpiSWp2
        ampBahFMHxMHp1QD016HFI3WdzX7rF27QzUvtTZ8Y+er3u+qNE3o4ssH9/2lUx3f17vnmiy7
        E8Clp+ckbf7Mg989YEX9WvN77qZzP1h0t3EGatyMjxBwYFk0P8jyvIpMWUjW23LxnUsM8mIe
        KET7KX4MuZKjuHyb3/kXy3dP4pyWbRUzLXBC9fUlEjfiHFVs9c9X3tQQmtA7P0DueHp8VcHC
        2Rwdd+xNFpx0ZRJK6F00447ikkOLuI9l1fOff35z2sKOg+9vdW4rqrn78+Lbi8IacTEl6nzq
        D8UWKqqmLi9J0zkZtyr4V/ephYuuat2O8tfjn89Zzflm4bYV8yNybtU1aDjN9j4Wy2GzqtCS
        Pdz59DqZEvO+KauUWIozEg21mIuKEwE6XthxJAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210930005939epcms2p7303bf6f96c824720f824989746491cba
References: <CGME20210930005939epcms2p7303bf6f96c824720f824989746491cba@epcms2p7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since active_logs can be set to 2 or 4 or NR_CURSEG_PERSIST_TYPE(6),
it cannot be set to NR_CURSEG_TYPE(8).
That is, whint_mode is always off.

Therefore, the condition is changed from NR_CURSEG_TYPE to NR_CURSEG_PERSIST_TYPE.

Cc: Chao Yu <chao@kernel.org>
Reported-by: Huan Tang <tanghuan@vivo.com>
Signed-off-by: Fengnan Chang <changfengnan@vivo.com>
Signed-off-by: Keoseong Park <keosung.park@samsung.com>
---
v1 -> v2:
	* Merge Signed-off and Reported tags for the same fix patch.

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
