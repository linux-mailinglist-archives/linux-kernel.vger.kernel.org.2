Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3601041A3CD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 01:24:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238178AbhI0X0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 19:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238153AbhI0X0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 19:26:05 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC92C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:24:26 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id u1-20020a17090ae00100b0019ec31d3ba2so376141pjy.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 16:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCzm4poULKgx57QgluC94f0t7RIOPooxQya71dloyms=;
        b=nCp0UtgIb73IG+2ORtKcI5uHOuMCAd3ZU1t1ZH3uVz98qBzlmRdBVAjizLKhkFLVrF
         Q/4TxiHYloWScmgXlT9fcRor3LzS+USZZl/gXQWkFuUZ3HNSedxFAESL3VHCqkPhqR7n
         IkTJUYFCnUg+HKJuB+jIz0LgO22a44o81p8C6b4rPkkmmu6jlaUBgA95E20j15Rk6lWv
         Lbc0BOYlR2hkWIhLjalbtOy28HcqL0968qLg77HPtUUZCiQBkpCext6QZXcAjRCGJYou
         rAM0/ZYLjJcDWzMQICW9QsGTBJSLeohpdWGAigpNvwTBjv3k8aqTP1UN2+Un0AbbdBu3
         bpeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GCzm4poULKgx57QgluC94f0t7RIOPooxQya71dloyms=;
        b=Ab0Ha8JoddG7XRc7Cth4FNPCZUJ1dJsrAW0k0Ed/f9rLLDlZtb/oLrF0dZFgZU1ocV
         2colmyqGg2oBkXTaYpMLJzOO5wJa8OkDOELos6ARt/ZQzI0uSSQe82Rj8upRnIvvgGM+
         UxvTPLZMRDlzBvgkd54/Ro4sjKawIEV0DXnFLozyTyUM/E7bXcKi8/gkXX0lzPk2/EMv
         67EcQar3DOVzZmRx63uHA/76tB2hnY4GbpKrpQTY6PHrcWsHeQBzYXUd6Iy8RwqtYmyq
         wb98DVIiVD7mxveis8CHbD2AUiPO4cuPXWXGDsVlCyY7Rch4OXF7ZYsigNYgHTkvgPNA
         wpow==
X-Gm-Message-State: AOAM531sRhhaxDnqtpgl7ukAbfCiJuw4a5ZJONHs4+UVWJTtOEUl+30g
        0XfmlwIftAzaV5aTr7thYAE=
X-Google-Smtp-Source: ABdhPJzfR1FtfapSlDY6H27NcruxHOaxPIHmWTQ5bSsaHoxTUvKD/lLOaBHjtgTFJhv4UTcOTFiVag==
X-Received: by 2002:a17:90b:4ac1:: with SMTP id mh1mr1854719pjb.238.1632785066359;
        Mon, 27 Sep 2021 16:24:26 -0700 (PDT)
Received: from vultr.guest ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id f27sm19145933pfq.78.2021.09.27.16.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 16:24:25 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sjpark@amazon.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH] mm/damon: remove unnecessary do_exit() from kdamond
Date:   Tue, 28 Sep 2021 07:24:21 +0800
Message-Id: <20210927232421.17694-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just return from the kthread function.

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 30e9211f494a..bc5f74348649 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -714,7 +714,7 @@ static int kdamond_fn(void *data)
 	nr_running_ctxs--;
 	mutex_unlock(&damon_lock);
 
-	do_exit(0);
+	return 0;
 }
 
 #include "core-test.h"
-- 
2.25.1

