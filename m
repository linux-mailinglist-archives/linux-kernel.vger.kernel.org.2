Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9531D390E91
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhEZC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231380AbhEZC6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:58:02 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676CBC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:30 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id q25so7092317pfn.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xkanLPqi5ol7KoX7EbuFclwRAZagzb8ztuCHeHsTeLk=;
        b=fh84BKPzGBLUX+dgAR2OAm/T2zW/OHN6jKDfSMdz7m66fH/m5N60WUdFT3CEJ8+UKa
         cNb2rKr9C4cs0lt1dMx7B64xdMB4kB3bFvtvkt2PfESYu4v3of5BQkz3URRmBxNNAA6D
         gZ23XlpA3E6G4bGOYu5aOLm9HNVqpSBzH3RKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xkanLPqi5ol7KoX7EbuFclwRAZagzb8ztuCHeHsTeLk=;
        b=ctPPwMp5YmVVFugbbZi+M2exJuqEchaCdNmg4HNmTn6RVphv91cPMvLU56eAAndqXK
         pROizlNl3506WKh3E9cla5oCwUthR2qsIj2ZPbE0tLnxiNCAmA8Q8/713jbLToMf/40+
         22ODSuqu88kGvqOizkcLzJFeqoKReTct5K/2ZkUsLpPQPoDd2KlkzNGIFyWc0IKU3RED
         GuN1KvlHYnvigsKMyPYklcYwn2tOOmsrAuW0OIfULfEfBqOOhW2JgAOXllmR95q529n4
         4J3YsHfEJyyYBkXudftys/6HwAyaIt586fQ/YBhlAP9rJRnX13wW0rvZVFs62rzf4dO1
         uhWQ==
X-Gm-Message-State: AOAM533gZPss6IaFFFiRXOE6vW3TK6E997siFSgzaintd1eTkoBuEIEv
        CoVFQ+q3NXUzziMNeiPLZyP42Q==
X-Google-Smtp-Source: ABdhPJyjbBdzs379VlR6V1iDNs2B37WXFNjJbcWhKeycGJ5QtfLfxiJKfWgM3JxTL8VX0iht64NcSw==
X-Received: by 2002:a63:6c9:: with SMTP id 192mr22698285pgg.39.1621997789860;
        Tue, 25 May 2021 19:56:29 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5a1b:e4e5:eb10:8870])
        by smtp.gmail.com with ESMTPSA id 5sm2966295pjo.17.2021.05.25.19.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 19:56:29 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: [PATCH v2 2/4] slub: Actually use 'message' in restore_bytes()
Date:   Tue, 25 May 2021 19:56:23 -0700
Message-Id: <20210526025625.601023-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210526025625.601023-1-swboyd@chromium.org>
References: <20210526025625.601023-1-swboyd@chromium.org>
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

