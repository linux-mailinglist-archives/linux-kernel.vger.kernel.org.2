Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285453979FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 20:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbhFASXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 14:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234706AbhFASXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 14:23:50 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C2C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 11:22:07 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e22so20915pgv.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 11:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ygkZRpJtxBAyCydNU/Hc832/XMSlgUwkfRH5mV2uRBM=;
        b=V5cR/uUPn4j+j/v3rnXqnTHLEL60rTQmpSJA/zTs+MosIrYnjqbhR1hO6pixmpGGIa
         MQOfqdXKl5yMDKpZ8OlVE5ulRRdCFBJgbYTTQVrwgmP4FEUSRisSB5Lcsdvanah4BRNB
         R2OGtp1GrfG0SURmkQuZiDCQe1GGe4uUsTmfo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ygkZRpJtxBAyCydNU/Hc832/XMSlgUwkfRH5mV2uRBM=;
        b=k0LgQ/XQ1Q+2HqJ+pR3u6UCBtmyFcmTYH2nyv+dugDRVFFW1bY2y226s1Zi0qQANzS
         KuvnHfNgPB/mCl2aEOmimQMHg61S5Gpvd+nDZ5/9d7Ng19zr4yO4J5/DMVUlnVOpfsZx
         bSViQlUzxN/ySroRgpHT4MQwoN+kg8GfbEYFRBiTz6NAN+Qr0OJLqMmZn8+MHItx9KTh
         7jGCVaOjI6LRM93+eFbrCp+5d7cFldYdC411Ai9pMBmSPls8M4YSf8eA1k+8F/U1CQ7Y
         y/UzBWg0oEgY9AnWHhHED3imRbVHF1IJIcYdrJ1aJk1sDne04eCrowggfYPQNqQ4J97I
         ticQ==
X-Gm-Message-State: AOAM533qE54nJUZiUHV2uhXeXFplItUKYNQ+5RH1lR/PfkNIOSFjBUqy
        px5kdiwIPVlg1sjwaw1BhjeUvHq+a5W6eA==
X-Google-Smtp-Source: ABdhPJyMK0zd7wSBmjoDltZpDuRAb+v7/WzhrOFJ8PwnBFx9sh/48W1TJNxDEx+HJWAIrfzOv6+pGA==
X-Received: by 2002:a65:6884:: with SMTP id e4mr4457991pgt.71.1622571727493;
        Tue, 01 Jun 2021 11:22:07 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:ee82:b2a7:c8bd:18e7])
        by smtp.gmail.com with ESMTPSA id g29sm14510982pgm.11.2021.06.01.11.22.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 11:22:07 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/4] slub: Actually use 'message' in restore_bytes()
Date:   Tue,  1 Jun 2021 11:22:00 -0700
Message-Id: <20210601182202.3011020-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.32.0.rc0.204.g9fa02ecfa5-goog
In-Reply-To: <20210601182202.3011020-1-swboyd@chromium.org>
References: <20210601182202.3011020-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The message argument isn't used here. Let's pass the string to the
printk message so that the developer can figure out what's happening,
instead of guessing that a redzone is being restored, etc.

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
Acked-by: David Rientjes <rientjes@google.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 mm/slub.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/slub.c b/mm/slub.c
index 2f53e8a9c28e..6168b3ce1b3e 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -777,7 +777,7 @@ static void init_object(struct kmem_cache *s, void *object, u8 val)
 static void restore_bytes(struct kmem_cache *s, char *message, u8 data,
 						void *from, void *to)
 {
-	slab_fix(s, "Restoring 0x%p-0x%p=0x%x\n", from, to - 1, data);
+	slab_fix(s, "Restoring %s 0x%p-0x%p=0x%x\n", message, from, to - 1, data);
 	memset(from, data, to - from);
 }
 
-- 
https://chromeos.dev

