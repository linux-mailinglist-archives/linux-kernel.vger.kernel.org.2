Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22983872DD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 09:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346947AbhERHKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 03:10:30 -0400
Received: from m12-12.163.com ([220.181.12.12]:46957 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239487AbhERHK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 03:10:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gR7RI
        OpX6zkUmX5SlpvaSqTebq9Ai+U60pEfa+WwMKg=; b=kGk379SrFSBJg7pQk/j+D
        MtULMARqjA6ImN2erlbc446uPYlEBB+M7fPWxd8t6X1OdCY3awesFsiqERPNsFD+
        VyAsGj8xJBXsAEoaoZBY/PSnSN2/c/dtoSfSEaQtuAUydTAbQ/oXN4L7n0l24D0G
        s3xtmNkTIf3jAIx53xvN1c=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowAD3rVrxZ6NgC8k0Ew--.2553S2;
        Tue, 18 May 2021 15:08:36 +0800 (CST)
From:   zuoqilin1@163.com
To:     unixbhaskar@gmail.com, adobriyan@gmail.com, gustavoars@kernel.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] ipc: Assign value when defining variables
Date:   Tue, 18 May 2021 15:08:42 +0800
Message-Id: <20210518070842.273-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAD3rVrxZ6NgC8k0Ew--.2553S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7XFWfKry3tF1xKr4rJw1DJrb_yoW8JF4Upa
        n8twn5KrWfX3yxW3s2vayDWr1jva4kJr9rGrZxJa4Svw13tF4rWr1xKw1jyF1UAF9YqFZI
        9a9Ygw15uw48ArJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jyApnUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiHhSWiVSIumdofAAAsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

When defining variables and assigning values can be done at the same time.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 ipc/sem.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/ipc/sem.c b/ipc/sem.c
index e0ec239..475d5bf 100644
--- a/ipc/sem.c
+++ b/ipc/sem.c
@@ -1104,9 +1104,8 @@ static int count_semcnt(struct sem_array *sma, ushort semnum,
 {
 	struct list_head *l;
 	struct sem_queue *q;
-	int semcnt;
+	int semcnt = 0;
 
-	semcnt = 0;
 	/* First: check the simple operations. They are easy to evaluate */
 	if (count_zero)
 		l = &sma->sems[semnum].pending_const;
@@ -1986,7 +1985,7 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 	struct sembuf fast_sops[SEMOPM_FAST];
 	struct sembuf *sops = fast_sops, *sop;
 	struct sem_undo *un;
-	int max, locknum;
+	int max = 0, locknum;
 	bool undos = false, alter = false, dupsop = false;
 	struct sem_queue queue;
 	unsigned long dup = 0, jiffies_left = 0;
@@ -2018,7 +2017,6 @@ static long do_semtimedop(int semid, struct sembuf __user *tsops,
 		jiffies_left = timespec64_to_jiffies(timeout);
 	}
 
-	max = 0;
 	for (sop = sops; sop < sops + nsops; sop++) {
 		unsigned long mask = 1ULL << ((sop->sem_num) % BITS_PER_LONG);
 
-- 
1.9.1


