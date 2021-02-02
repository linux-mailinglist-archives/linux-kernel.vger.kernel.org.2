Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF28E30BAD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 10:24:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232865AbhBBJWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 04:22:30 -0500
Received: from m12-17.163.com ([220.181.12.17]:39886 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232649AbhBBJVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 04:21:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=kOLO6
        CFmS18CGUHwNKlfxa7l9RiiR97TKzPZHIwMEQs=; b=R2pMlWQhr5HMiBFFBZoE3
        myTDL8NJNSrXDjTyRrGxdA5SFOBk28pf69gFZSxMQbmMAjmORjS4toYco/JoKFLo
        exrJbybefx/m1DkNtaiAVf3u1w9NChtHbODy1TZJOiydOJJ2+KUcNi02coH1POt/
        l1FaF0T+VhMJvDVFTisCsE=
Received: from localhost (unknown [101.228.31.219])
        by smtp13 (Coremail) with SMTP id EcCowAD3DouhAhlg5BEUjA--.23941S2;
        Tue, 02 Feb 2021 15:43:29 +0800 (CST)
Date:   Tue, 2 Feb 2021 15:43:29 +0800
From:   Hui Su <sh_def@163.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yogesh Lal <ylal@codeaurora.org>, linux-kernel@vger.kernel.org
Cc:     sh_def@163.com
Subject: [PATCH] lib/stackdepot.c: fix the compile warning
Message-ID: <20210202074329.GA1284542@server>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAD3DouhAhlg5BEUjA--.23941S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrur4UWF1DZw48Ary3Jr45GFg_yoWDZwbEk3
        40va1UWr1agrs7A3WrKr4Dtr1xCwsFgF1xJas7tFyYkr15Z3yrJ3Z5Zwn5Arn8Wr4Dt3Zr
        Aw1UA3W5Gr4FqjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUb1xRPUUUUU==
X-Originating-IP: [101.228.31.219]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiJgEtX1v2gT07egAAsF
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the compile warning introduced by commit b9779abb09a8 ("lib: stackdepot:
add support to disable stack depot")

../lib/stackdepot.c: In function ‘is_stack_depot_disabled’:
../lib/stackdepot.c:154:2: warning: ignoring return value of ‘kstrtobool’, declared with attribute warn_unused_result [-Wunused-result]
  154 |  kstrtobool(str, &stack_depot_disable);
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Signed-off-by: Hui Su <sh_def@163.com>
---
 lib/stackdepot.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index cc21116512a7..acd13f574f97 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -151,7 +151,9 @@ static struct stack_record **stack_table;
 
 static int __init is_stack_depot_disabled(char *str)
 {
-	kstrtobool(str, &stack_depot_disable);
+	int no_warn;
+
+	no_warn = kstrtobool(str, &stack_depot_disable);
 	if (stack_depot_disable) {
 		pr_info("Stack Depot is disabled\n");
 		stack_table = NULL;
-- 
2.25.1


