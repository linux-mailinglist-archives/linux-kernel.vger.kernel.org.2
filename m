Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9971399B10
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Jun 2021 08:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFCGzR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Jun 2021 02:55:17 -0400
Received: from m12-12.163.com ([220.181.12.12]:53122 "EHLO m12-12.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229635AbhFCGzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jun 2021 02:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=mBvMJ
        Eh9aqlScxKpyPWsWaK3wDZYy+MwI4+SHB8/0bE=; b=Sfa2SbecY83/DFgg6igSU
        K1dvCDI1k82ohqYWVKafE5t8nO2bFvJau9Xms+hXDXq/mFvIZ2r+VL2W4/TRLgS8
        Auh23auov+suak7X5OD0lvHTKMC4ERIyQBQ7Is49haTAKMZdSRWPe1Jy/M5KhLBv
        NqE/QpvYqzBi7LWYGkGzFg=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp8 (Coremail) with SMTP id DMCowAAHvTQqfLhg_u8kHw--.41627S2;
        Thu, 03 Jun 2021 14:52:27 +0800 (CST)
From:   13145886936@163.com
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] mm: opt code indent
Date:   Wed,  2 Jun 2021 23:52:15 -0700
Message-Id: <20210603065215.3313-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DMCowAAHvTQqfLhg_u8kHw--.41627S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrCF18GFyDGw4kCFW8Gr4DJwb_yoWxGrX_JF
        ykJr4IqayUAr93W347Z3WavrWvqw1kuay3ZF1Y9Fyft34Dtay0gas8Zr4ktryUt3yruF9x
        G39a9rZxCr129jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnivtJUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBdgumg1UMRIepUQAAs6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

Code indent should use tabs where possible.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ba1068a1837f..a8163cff10a0 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2669,7 +2669,7 @@ generic_file_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 		} else {
 			retval = filemap_write_and_wait_range(mapping,
 						iocb->ki_pos,
-					        iocb->ki_pos + count - 1);
+						iocb->ki_pos + count - 1);
 			if (retval < 0)
 				return retval;
 		}
-- 
2.25.1


