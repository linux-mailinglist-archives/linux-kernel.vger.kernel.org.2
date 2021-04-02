Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D61352762
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 10:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhDBIVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 04:21:46 -0400
Received: from m12-18.163.com ([220.181.12.18]:40063 "EHLO m12-18.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229599AbhDBIVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 04:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WBGZ8
        NPmSkgQT8o+cSmOjdtv5qvHbIIjaiEt196mLxs=; b=PqC4MaLPIbGieBKpTrv9a
        V8RY4hf4Ed99kig+YW2+EKQ0l9yyaJeCDdy5aGjnZLknKzcGQlcfg2L2IuqcmLid
        NoEvIZNOsOZBB5SIzWHioqO9WASIyWV4y7VNV/YTk/XvDB0o8sUmWzIt4zmW2l+d
        ALPZK0MWvAVPghReYhIvBE=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp14 (Coremail) with SMTP id EsCowADHzeXA02Zg7huobw--.28567S2;
        Fri, 02 Apr 2021 16:20:19 +0800 (CST)
From:   zuoqilin1@163.com
To:     linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] arm/mm: Convert to DEFINE_SHOW_ATTRIBUTE
Date:   Fri,  2 Apr 2021 16:20:26 +0800
Message-Id: <20210402082026.568-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowADHzeXA02Zg7huobw--.28567S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWDGF4fKFW8Cw18GF4DArb_yoWfKrbEk3
        yIqa1UGr48ZFyrX393C3W5urs3Ca90gF1rXwn0gFs3Jw4rWFZ3AryvgFsaqrWDXr4fGFnx
        JrW8Xr1UAr12gjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU81xRDUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbipRVniVUMdJmefwABsK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 arch/arm/mm/ptdump_debugfs.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/arch/arm/mm/ptdump_debugfs.c b/arch/arm/mm/ptdump_debugfs.c
index 598b636..6a62bce 100644
--- a/arch/arm/mm/ptdump_debugfs.c
+++ b/arch/arm/mm/ptdump_debugfs.c
@@ -12,17 +12,7 @@ static int ptdump_show(struct seq_file *m, void *v)
 	return 0;
 }
 
-static int ptdump_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, ptdump_show, inode->i_private);
-}
-
-static const struct file_operations ptdump_fops = {
-	.open		= ptdump_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
+DEFINE_SHOW_ATTRIBUTE(ptdump);
 
 void ptdump_debugfs_register(struct ptdump_info *info, const char *name)
 {
-- 
1.9.1


