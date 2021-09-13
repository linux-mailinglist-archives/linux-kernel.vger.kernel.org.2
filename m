Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D5740861E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 10:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237848AbhIMIMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 04:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234684AbhIMIMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 04:12:37 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C18C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:11:22 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id g13-20020a17090a3c8d00b00196286963b9so5975368pjc.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvOYThHcl3IfPpkGUW857bIF0MtnLJVLT78BX5LtdSs=;
        b=mzbsaSwXhT/fbT1xHXk+vafkJGAVrLz47A4XMz6XAqRRwDiQnia13wokwBoTDb/MAk
         MdCa1FSt3tWDCDOarbYXNhBT4eQdpC6CjMfQNsMNZ5hUECb73H5SnO6Ln4HF5bj6uEiw
         k0uUPkEG3fz3i/kswTTW8PhGLVIIXHT4xByHe4uPa7GVnPQ4EqEOtBc/N83nGYSJhbkM
         smY7p2dyeGpb+jP3z1KNNjLzt4zvPJiiLtcBgJLQh+ORWUOu5QOBoOCUGBuLijr2i2iv
         pfXG0Fb96KUpuVPcP1EGQOZLWID0iFegp1KoViYhVXDGT2PE+DOpeLE6hHxgZWyeLO2o
         Og3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tvOYThHcl3IfPpkGUW857bIF0MtnLJVLT78BX5LtdSs=;
        b=HZWIvMqviEM69PotkohiUSvNzTmI51VgnI6/3iCjgPxUZAi0x7uKDjE4oi6yr00Qnr
         Q1ODLOWs213qaMdttiVcWCyUh4NJkHOv8E4dAI/V1jC8gtguwEvK/aFEYqV+YrWg12hZ
         Tk8MhOLX4Pdy46/oGPTQoqiWzGzzy64dzYk0V4hmKA73eZ8LKZvTmZtZEJGwegDH3h5O
         SBFqaI5Ini+tv/wgIfPwfaxqWoFVY7pyopr6B1O1sEcsFew4kEHEZh9qhnA9mC5XVlAE
         5VLhwdo4gcddvehzWWV2X7NF8IY8+/o9Kcsj8bwGp0dCvGaAvVxr4nLl7KCFtEyoaH9R
         zu5g==
X-Gm-Message-State: AOAM531U+Sc//207RBXP4JXIziaPeYJqchA4wjVAqGJFSPi7bdkwqvZJ
        vh2KdSuun4CF38ctGSgWPIU=
X-Google-Smtp-Source: ABdhPJw8M6sWJAmOoBx1yoKXaLZ6TakzpoBOgxlMYLSNouLejcEG3YQ+7RNHtvp8whdxzi02euWD5A==
X-Received: by 2002:a17:902:a60d:b0:13b:7dad:9a5 with SMTP id u13-20020a170902a60d00b0013b7dad09a5mr8570771plq.41.1631520681903;
        Mon, 13 Sep 2021 01:11:21 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 77sm6104322pfz.118.2021.09.13.01.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 01:11:21 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: xu.xin16@zte.com.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] mm/folio-compat: fix potential NULL pointer access 
Date:   Mon, 13 Sep 2021 08:11:13 +0000
Message-Id: <20210913081113.79975-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xu xin <xu.xin16@zte.com.cn>

The pointer 'folio' might be NULL, but the structure it points to is accessed.
Accordingly, we add a check of NULL pointer by 'if (!folio)'.
Secondly, there is no need to check if folio is pointer or value with 'xa_is_value(folio)' 
because folio is alwayse pointer.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: xu xin <xu.xin16@zte.com.cn>
---
 mm/folio-compat.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/folio-compat.c b/mm/folio-compat.c
index 5b6ae1da314e..a1b60310c7ba 100644
--- a/mm/folio-compat.c
+++ b/mm/folio-compat.c
@@ -123,7 +123,9 @@ struct page *pagecache_get_page(struct address_space *mapping, pgoff_t index,
 	struct folio *folio;
 
 	folio = __filemap_get_folio(mapping, index, fgp_flags, gfp);
-	if ((fgp_flags & FGP_HEAD) || !folio || xa_is_value(folio))
+	if (!folio)
+		return NULL;
+	if ((fgp_flags & FGP_HEAD))
 		return &folio->page;
 	return folio_file_page(folio, index);
 }
-- 
2.25.1

