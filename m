Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD83B6D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 06:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbhF2EPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Jun 2021 00:15:06 -0400
Received: from m12-16.163.com ([220.181.12.16]:49033 "EHLO m12-16.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhF2EPF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jun 2021 00:15:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=gN8+r
        u9G1aWjpKkK/nlS+FNZkPyTjjQoPydTg18qpoU=; b=qTNgTB4cyf/7xeS+zUW4B
        AR50yaMrATUvWdgYNQtfkN/dZiCaip6gqjU5DqA1ZCj1ba4d8vnSsIuT3WNBjKmC
        vGj94LiGfMjcxoexB6tR0CQhEM48sdrx1oGHJ/oEbacDyf94rlVrC+KW5Q7Y7Xme
        D/mOirARlVpp6k1yo1uWrw=
Received: from ubuntu.localdomain (unknown [218.17.89.92])
        by smtp12 (Coremail) with SMTP id EMCowACnrLysndpgJcwkzw--.17257S2;
        Tue, 29 Jun 2021 12:12:29 +0800 (CST)
From:   13145886936@163.com
To:     hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        gushengxian <gushengxian@yulong.com>
Subject: [PATCH] Orangef: Removed unused variable: "file"
Date:   Mon, 28 Jun 2021 21:12:06 -0700
Message-Id: <20210629041206.708134-1-13145886936@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowACnrLysndpgJcwkzw--.17257S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Jw1fKF13Gr4fAw1ftFWkZwb_yoW3Cwb_A3
        42vr48Cay8WrWxtay5CwsIqFW8uw1rWrW2y3W5KFyfK345trsY9wn5Jrs5ZrZrXr48ZFZx
        CrnaqFySyr12yjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU55CztUUUUU==
X-Originating-IP: [218.17.89.92]
X-CM-SenderInfo: 5zrdx5xxdq6xppld0qqrwthudrp/xtbBzg3Ag1QHNDZjaQAAsb
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: gushengxian <gushengxian@yulong.com>

In function orangefs_launder_page() the varialbe "file" is defined.
However it has not been used throughout the function.
At the same time, the entire directory was compiled,
and no error was found.

Signed-off-by: gushengxian <gushengxian@yulong.com>
---
 fs/orangefs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 207cbf19fba1..16ac617df7d7 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -249,7 +249,6 @@ static void orangefs_readahead(struct readahead_control *rac)
 {
 	loff_t offset;
 	struct iov_iter iter;
-	struct file *file = rac->file;
 	struct inode *inode = rac->mapping->host;
 	struct xarray *i_pages;
 	struct page *page;
-- 
2.25.1


