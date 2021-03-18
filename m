Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BCFF33FD46
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 03:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbhCRCeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 22:34:14 -0400
Received: from m12-17.163.com ([220.181.12.17]:56016 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229720AbhCRCeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 22:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=CpYMd
        PsprCRjXvYnmb1EM2qnPp9FdkTspwNPYhwSUV0=; b=fadU3hnXdriW+QBKcE8S+
        IoYsz+jLg6u9xpQqaaBZavHkvXO2tSi+KbeR0RsmbJirT4uYF4lORlv0BUrB9Btu
        tFiBsSZRYm3Saut+9NEuxKdDCDFxwvqZfLCksFjWyw2FCmkjA5Dqm7RMfmj7X9No
        uPzN6m9BgIvPgl1/4as9us=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowADHzZ38u1JgNBNbqg--.26621S2;
        Thu, 18 Mar 2021 10:33:45 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     gustavoars@kernel.org, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangchunyou@yulong.com
Subject: [PATCH] drivers/video/fbdev:modify 0 to NULL
Date:   Thu, 18 Mar 2021 10:33:29 +0800
Message-Id: <20210318023329.488-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADHzZ38u1JgNBNbqg--.26621S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZryruFWkKF4xJw43Gw45Jrb_yoWxZrg_Cr
        4kZrZrWrWqkr1Syrn7A39avryrtw4UZ3Z7ZFnaqry3Cry3Cr1Fqr1UZrn29w4UWr1UXr9r
        WrnFgrW0vr1SkjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU8C38UUUUUU==
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/1tbiTgVYUVUDIPi7GQABsv
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

modify 0 to NULL,info is a pointer,it should be

compared with NULL,not 0

Signed-off-by: tangchunyou <tangchunyou@yulong.com>
---
 drivers/video/fbdev/offb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index 4501e84..cd1042f 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -412,7 +412,7 @@ static void __init offb_init_fb(const char *name,
 
 	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
 
-	if (info == 0) {
+	if (info == NULL) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
-- 
1.9.1


