Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BECF33CC3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 04:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232339AbhCPDnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 23:43:19 -0400
Received: from m12-12.163.com ([220.181.12.12]:39335 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234924AbhCPDmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 23:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=nkAio
        CLmXBaSA+tGDZwU131HnbVqVi9sxfko578ISqQ=; b=pwsXVfkDXV360HyCfFWzP
        9tmsI08fPI1e+TWjN6AqPccuGeGrxEu+iOfVvZ0NC0wYVa0gUVL9fs5XMTnmeJYr
        rQ8XhmTVutZ1zD8JwjE2d0W8QOkLsLKIF7GNPXtbXRhJNRATmPfsFR8DG2L1Vi8l
        OEbYjDD3n73Gx4GSjk+fyM=
Received: from COOL-20201210PM.ccdomain.com (unknown [218.94.48.178])
        by smtp8 (Coremail) with SMTP id DMCowABX3poLKVBg2XgqVA--.8618S2;
        Tue, 16 Mar 2021 11:42:09 +0800 (CST)
From:   zuoqilin1@163.com
To:     herbert@gondor.apana.org.au, smueller@chronox.de,
        marcelo.cerri@canonical.com, tianjia.zhang@linux.alibaba.com
Cc:     linux-kernel@vger.kernel.org, zuoqilin <zuoqilin@yulong.com>
Subject: [PATCH] include/linux: Fix typo issue
Date:   Tue, 16 Mar 2021 11:42:13 +0800
Message-Id: <20210316034213.780-1-zuoqilin1@163.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowABX3poLKVBg2XgqVA--.8618S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruFyrJrWxur17WF4fZFyftFb_yoWxZFb_Cw
        naqr48W3yfZrn7JayxtF92qr4F9w1xAr1kWF95XF17Xas0kws8Jw1kGFsFqr4fWa4kC3sr
        W3W8u3yfZr1agjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0niSJUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 52xr1xpolqiqqrwthudrp/1tbiThJXiVUDINs-pQAAs1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zuoqilin <zuoqilin@yulong.com>

Change 'bufer' to 'buffer'.

Signed-off-by: zuoqilin <zuoqilin@yulong.com>
---
 include/linux/mpi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mpi.h b/include/linux/mpi.h
index 3e5358f..6e6b15a 100644
--- a/include/linux/mpi.h
+++ b/include/linux/mpi.h
@@ -267,7 +267,7 @@ void mpi_ec_mul_point(MPI_POINT result,
 /**
  * mpi_get_size() - returns max size required to store the number
  *
- * @a:	A multi precision integer for which we want to allocate a bufer
+ * @a:	A multi precision integer for which we want to allocate a buffer
  *
  * Return: size required to store the number
  */
-- 
1.9.1


