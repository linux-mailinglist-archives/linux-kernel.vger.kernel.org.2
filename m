Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8B373FC5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 13:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbhHaKeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 06:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhHaKeA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 06:34:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED3EC061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:33:05 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m26so14625877pff.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 03:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY7cMjg+mzN0KnlEN3YeG65WmdAqZbIaUV7izU0+6iA=;
        b=pXOGWJD/kF4bFfzqbJTMhhqOLUZCXwq5his6RVcYXxe6Ug2dEZbmgeW1EP48CEntsg
         6vt6JEW9W9bR9pa6ZviNOt4p9sVybqUjN9uljkT/0ornDslUS1pJJsi7zEJ2hg7TuHn1
         u6IbKftygKlL22GzKKzQoY/UGL40FKl4AYdzakYJ5slhuDl65LH6Vuo8KxfmhujlBPmM
         LQvoRZcuIS6VaH2VQq/OVGC6UkE9ZOiXDlf5UmVghXWWFN1uz75PAe388s7pU3As7o3y
         Xf7pxcRWOWbK2uID2M1KFA4Vv4xE/QTQAlEVan9hUBInAine95l6xjDqKL8xtYdLsGeJ
         kxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KY7cMjg+mzN0KnlEN3YeG65WmdAqZbIaUV7izU0+6iA=;
        b=pazrIWe0M3yNGcrQu94ZF1hFk4XWN4qFxTr6a48Z5nBUurHAsDQ8a7IjZSOCbd8cPL
         j4LiNusGB2kjvG4Wg+HuxNASAs3uXmW3P3RPVsSZtxG+l8S8YoayLAmReYNQmpzTmem8
         b3z3l4PxaU3R6n6MRS8+KBdp4YPr96XSuABXCkq2LMKwtZ5EPIXOvVakySQjHXJuiudT
         2uuXbygJh7gprxq7JJDZIfPr55nP+GZ6Emuw+N9dCsWL79MTDlJ8Gco4wLLd2/i7jV3o
         pcy4T5omEqJh2h0y3u3HUl/0iHnEPhp5X6WDky2KQ0VQQKipIR8UYwZ70jDCbbRIwexy
         cCfw==
X-Gm-Message-State: AOAM533TxsF/7n2teKGSj4+IUZ3I76AU3iWmQ5ZfnuJcTZL+xIbrunGH
        fv11YBfdlzUSFBPMTJtoJgI=
X-Google-Smtp-Source: ABdhPJxj5IwugF/48Cxv7in/gjqkyeaxFTK3PbcrGKLmNvMJkH2iPhE3TvqKrf22P/bQLjYCRwaKig==
X-Received: by 2002:a05:6a00:1349:b0:3fd:9054:e243 with SMTP id k9-20020a056a00134900b003fd9054e243mr12357785pfu.38.1630405984922;
        Tue, 31 Aug 2021 03:33:04 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id m11sm2417535pjl.14.2021.08.31.03.33.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 03:33:04 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org, huyue2@yulong.com, zbestahu@163.com
Subject: [PATCH] erofs: remove the pagepool parameter from z_erofs_shifted_transform()
Date:   Tue, 31 Aug 2021 18:32:04 +0800
Message-Id: <20210831103204.881-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

We don't use the pagepool for plain format, remove it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/decompressor.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1..8f50a36 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -360,8 +360,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 	return ret;
 }
 
-static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq,
-				     struct list_head *pagepool)
+static int z_erofs_shifted_transform(const struct z_erofs_decompress_req *rq)
 {
 	const unsigned int nrpages_out =
 		PAGE_ALIGN(rq->pageofs_out + rq->outputsize) >> PAGE_SHIFT;
@@ -403,6 +402,6 @@ int z_erofs_decompress(struct z_erofs_decompress_req *rq,
 		       struct list_head *pagepool)
 {
 	if (rq->alg == Z_EROFS_COMPRESSION_SHIFTED)
-		return z_erofs_shifted_transform(rq, pagepool);
+		return z_erofs_shifted_transform(rq);
 	return z_erofs_decompress_generic(rq, pagepool);
 }
-- 
1.9.1

