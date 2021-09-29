Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC0D841CCA9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 21:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbhI2Teh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 15:34:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:56678 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229561AbhI2Tef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 15:34:35 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCAD86128E;
        Wed, 29 Sep 2021 19:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632943974;
        bh=AgmUtjurDRy/V3ukd7KBPAsKg/oVbPEBdWmS6bH0Q3o=;
        h=Date:From:To:Cc:Subject:From;
        b=eW8uN1GaceGUDlmceoKN1OPhFSy2VOGtP3B5NE/+4Q/mcqfOxMKFfqGLDdCpWnQlA
         Jf8vlaMUpieuUtgnHy3qDram/20eSFKY55+o0VvfUpA45EPNyPkH7AYGlnfRMJ8fJM
         Ue4p/9ux+fpJlM9rxMxIn4+Rw541duhRvgPv9ZU5C7BjMW0ybeHLUeVqzOd1pYOqF4
         xWlHRglERxVn9XbraEWVgIArK/bHd+QpDs82z+7Xqj48U9FwbP3/DZ6J5hWfRhkA9r
         0jz4xcmO50h7bCL5/E2isqOQgZo3awQwwCUaqQ4BFhadDAxa4wKrQ97bySzisgwhy1
         vwFtgR+WtT3mg==
Date:   Wed, 29 Sep 2021 14:36:58 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] staging: r8188eu: Replace zero-length array with
 flexible-array member
Message-ID: <20210929193658.GA339070@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One-element and zero-length arrays are deprecated and should be
replaced with flexible-array members[1].

Replace zero-length array with flexible-array member and make use
of the struct_size() helper in kmalloc().

[1] https://www.kernel.org/doc/html/v5.10/process/deprecated.html#zero-length-and-one-element-arrays

Link: https://github.com/KSPP/linux/issues/78
Link: https://github.com/KSPP/linux/issues/160
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/staging/r8188eu/include/osdep_service.h | 2 +-
 drivers/staging/r8188eu/os_dep/osdep_service.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index da85a9681c4a..4622ce400e41 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -289,7 +289,7 @@ struct rtw_cbuf {
 	u32 write;
 	u32 read;
 	u32 size;
-	void *bufs[0];
+	void *bufs[];
 };
 
 bool rtw_cbuf_empty(struct rtw_cbuf *cbuf);
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index 002c75f16725..d7d03c1417fd 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -262,7 +262,7 @@ struct rtw_cbuf *rtw_cbuf_alloc(u32 size)
 {
 	struct rtw_cbuf *cbuf;
 
-	cbuf = kmalloc(sizeof(*cbuf) + sizeof(void *) * size, GFP_KERNEL);
+	cbuf = kmalloc(struct_size(cbuf, bufs, size), GFP_KERNEL);
 
 	if (cbuf) {
 		cbuf->write = 0;
-- 
2.27.0

