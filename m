Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C313CAD52
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 21:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245647AbhGOT5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 15:57:48 -0400
Received: from mail-pf1-f177.google.com ([209.85.210.177]:34778 "EHLO
        mail-pf1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345106AbhGOTyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 15:54:43 -0400
Received: by mail-pf1-f177.google.com with SMTP id o201so6531436pfd.1;
        Thu, 15 Jul 2021 12:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xZLEXNXEvKK/ATe9o2Ld+14LkkyvorWKYSypyUoVK8=;
        b=PBveoAMzoIEqV4yTCRLZB/XgEKhnzaJ0h6eRwurulHwIbg1/GyYyVAN0loPZUsOIbW
         Dely1JVIUK4iJt9Z5fqPOIH5PHvj6EPbF4tnA/KosbyEH8gXEvcwyPfcodB2dpjDcvDb
         wccl6OskY+UdeTwZXUpAOlIg054kbT7QboJOj8TjHGPT4UxfI6ct5X7k3yZq/PgSbhAD
         lzu3u19MbGj0IpCvKeypcUKC0NAGm7+fMUZ+JBNf5H0QgJySQ9U2KW5FhE+SElQ7MGwN
         l94tNhTUgsrl5FSGsrohB3cyG6yMLPorUmooDgJ3A0YP7Q3CwgTHy8r3WKJfNDJ0+xrH
         8mcQ==
X-Gm-Message-State: AOAM533ySqwv6+I8EbFo4Yo/1/nBCTDVq11hJDMpt8q6ROXhc4bNDL6t
        JN9DGXPe373ODpgKU/andVY=
X-Google-Smtp-Source: ABdhPJwvsdITlgmFZz31zuvVhiX/yqFksvb7rTQTRC8uXgTJ8peNV0C9qKjGMnwVu/SzryqrQOsaVw==
X-Received: by 2002:a63:4e04:: with SMTP id c4mr5920581pgb.294.1626378708824;
        Thu, 15 Jul 2021 12:51:48 -0700 (PDT)
Received: from localhost ([191.96.120.37])
        by smtp.gmail.com with ESMTPSA id q11sm684450pjd.30.2021.07.15.12.51.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jul 2021 12:51:47 -0700 (PDT)
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     axboe@kernel.dk
Cc:     hare@suse.de, bvanassche@acm.org, ming.lei@redhat.com,
        hch@infradead.org, jack@suse.cz, osandov@fb.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/3] null_blk: add error handling support for add_disk()
Date:   Thu, 15 Jul 2021 12:51:40 -0700
Message-Id: <20210715195141.1882285-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210715195141.1882285-1-mcgrof@kernel.org>
References: <20210715195141.1882285-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We never checked for errors on add_disk() as this function
returned void. Now that this is fixed, use the shiny new
error handling. The actual cleanup in case of error is
already handled by the caller of null_gendisk_register().

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/block/null_blk/main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index d734e9ee1546..2a8f3eee7159 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -1721,8 +1721,7 @@ static int null_gendisk_register(struct nullb *nullb)
 			return ret;
 	}
 
-	add_disk(disk);
-	return 0;
+	return add_disk(disk);
 }
 
 static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
-- 
2.27.0

