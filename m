Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC79738ECA5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 17:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhEXPUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 11:20:50 -0400
Received: from pv50p00im-hyfv10011601.me.com ([17.58.6.43]:54632 "EHLO
        pv50p00im-hyfv10011601.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234487AbhEXPHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 11:07:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1621868783; bh=wvA5ikLwZnEI3QS9n87SZab2KPDLJgG1LFxrfbcnH6Y=;
        h=From:To:Subject:Date:Message-Id;
        b=UycgsU+owGV4UizBJ0XMDKcFlf7nZ7LUJuMLTFdAF0liRX6EfyWw80Oh9NSSc8j9M
         SFce8ssG+fR/4n6WD7dtaCzsjkjtraYMmCjBPwPK8hUILqLyZ6BIqwChwQBRjsbn6A
         H5LwVCV/JG8iejiq4RsHIa/svVVMwWrny3NZ3mrhNOEwSO7FuAWIvcI9WIzCySKBXt
         aKuVNWTbPTwcnI1utzL7mRM1K6aitAzVyu3dslTZ9aRDU480tPUrioNmlbuDt8iFiq
         3YSvpf/X5g4DrJpb2NNvqeSh5LVNoAvxBxRRd4/1i4xsTsvPQRMrUGZjPm2C319gHC
         eiy1OmRtDtdRA==
Received: from pek-xsong2-d1.wrs.com (unknown [60.247.85.82])
        by pv50p00im-hyfv10011601.me.com (Postfix) with ESMTPSA id 826BA3804F0;
        Mon, 24 May 2021 15:06:20 +0000 (UTC)
From:   Xiongwei Song <sxwjean@me.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, corbet@lwn.net
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiongwei Song <sxwjean@gmail.com>
Subject: [PATCH] docs: lockdep-design: improve readability of the block matrix
Date:   Mon, 24 May 2021 23:05:45 +0800
Message-Id: <1621868745-23311-1-git-send-email-sxwjean@me.com>
X-Mailer: git-send-email 2.7.4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-24_08:2021-05-24,2021-05-24 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=680 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-2009150000 definitions=main-2105240094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiongwei Song <sxwjean@gmail.com>

The block condition matrix is using 'E' as the writer notation, however,
the writer reminder below the matrix is using 'W', to make them consistent
and make the matrix more readable, we'd better to use 'W' to represent
writer.

Suggested-by: Waiman Long <llong@redhat.com>
Suggested-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
---
 Documentation/locking/lockdep-design.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/locking/lockdep-design.rst b/Documentation/locking/lockdep-design.rst
index 9f3cfca..82f36ca 100644
--- a/Documentation/locking/lockdep-design.rst
+++ b/Documentation/locking/lockdep-design.rst
@@ -453,9 +453,9 @@ There are simply four block conditions:
 Block condition matrix, Y means the row blocks the column, and N means otherwise.
 
 	+---+---+---+---+
-	|   | E | r | R |
+	|   | W | r | R |
 	+---+---+---+---+
-	| E | Y | Y | Y |
+	| W | Y | Y | Y |
 	+---+---+---+---+
 	| r | Y | Y | N |
 	+---+---+---+---+
-- 
2.7.4

