Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 306F042BBE0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 11:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239163AbhJMJq1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 05:46:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239137AbhJMJq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 05:46:26 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34C06C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:44:23 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r201so1792104pgr.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 02:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=309T4j0nNawHtdA5gB6WVyac2BbPJSi45edgVcgCIZM=;
        b=RC2+mHWgzNL1l9Uw9h9wyZCz36StP/awqP32lB4aGm6GKU72y/CymYLgb2nXPGodTs
         8+bmEXyIzLR7fWDi54KHWqwc0oekSmtim1753Oo02ZWXnsMYKk8rWWU/hTIzV7EMi1nn
         eAAhOr5IX0koMLgZNpQj9wP3KIcMUeDWU/Z66kPXDl/DeEH8a7ROMmrN+uKUWfEGInJy
         jWlJkhr7fprG0KVe2j/FMGhiQhAjqqbj2pbuEeTXrH/Rb795gcmXf6eFdQB/pF0wxr5E
         Fy/g0iP5TthUsa+1PkoQ0HcrStAkdfBff6wna2PM6l90+SyjIA/1k68F/PTRJrR9lD+e
         uhUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=309T4j0nNawHtdA5gB6WVyac2BbPJSi45edgVcgCIZM=;
        b=OvXneBR5LP/gnXethZhjJRufnHgdE/4TPZlUaljp3HsD+MbEfDp7QV/r5UzT7dVawX
         pq3tYKREdpGmGLuDB+eso61NkW7C6RqF2axg/B6aPTdan3ZAWJRBhp6//JprNeisKWcF
         x7PVVySHOeMzWINxQsP/QGerhRSA9ap7Iibjy+tqbX4CSYr88xZ3AM2UNfBGnWV/IOjC
         8/MNDaLvxr85cW39Ex1pUKJ8ayLX+NK0wOb4brgVq9reU0hOxJvYXLtzKr+Y9TlRQeEa
         DEtXhwTKlQOIDMjkUYQulMziEe/q2V/UJ50Ajb/3ej4KZFbZZHAt6X5w2Wwzy80XDJti
         6/XQ==
X-Gm-Message-State: AOAM532A5wkDMgcwORKmM/qgwXiJlKwSXqgCIHL1dZ8iCpC1zPXfkMEO
        J+rhBqBWC3rSXMn9MpKjAOO4lsVjghFiIA==
X-Google-Smtp-Source: ABdhPJz0jjcuXnTewZgN2TT4N95DlzSFOe1oMfFx2udq4eQSpccgSQro5ZXj7osy6fZ+SWwloob+uA==
X-Received: by 2002:a62:9215:0:b0:44c:4de1:f777 with SMTP id o21-20020a629215000000b0044c4de1f777mr36612292pfd.31.1634118262763;
        Wed, 13 Oct 2021 02:44:22 -0700 (PDT)
Received: from tj.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id v20sm14338080pgc.38.2021.10.13.02.44.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 02:44:22 -0700 (PDT)
From:   Yue Hu <zbestahu@gmail.com>
To:     xiang@kernel.org, chao@kernel.org
Cc:     linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        huyue2@yulong.com, zhangwen@yulong.com, zbestahu@163.com
Subject: [PATCH] erofs: fix the per-CPU buffer decompression for small output size
Date:   Wed, 13 Oct 2021 17:29:05 +0800
Message-Id: <20211013092906.1434-1-zbestahu@gmail.com>
X-Mailer: git-send-email 2.29.2.windows.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yue Hu <huyue2@yulong.com>

Note that z_erofs_lz4_decompress() will return a positive value if
decompression succeeds. However, we do not copy_from_pcpubuf() due
to !ret. Let's fix it.

Signed-off-by: Yue Hu <huyue2@yulong.com>
---
 fs/erofs/decompressor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/erofs/decompressor.c b/fs/erofs/decompressor.c
index a5bc4b1..e4cab4e 100644
--- a/fs/erofs/decompressor.c
+++ b/fs/erofs/decompressor.c
@@ -326,7 +326,7 @@ static int z_erofs_decompress_generic(struct z_erofs_decompress_req *rq,
 
 			rq->inplace_io = false;
 			ret = alg->decompress(rq, dst);
-			if (!ret)
+			if (ret > 0)
 				copy_from_pcpubuf(rq->out, dst, rq->pageofs_out,
 						  rq->outputsize);
 
-- 
1.9.1

