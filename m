Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 073C3390E93
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 04:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbhEZC6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 22:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhEZC6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 22:58:06 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7262AC061756
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id 22so24744368pfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 19:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bid5eWeyAf/EDHZJqBvx8IkfWVIQDlnQOV7qBWhlldY=;
        b=YHUqpCGUaU3XGiG1Ugi9+sX324g45J0nlIN8TArCl5WEd2PdLVGMIeH6G1Yt996sq+
         UJdg6ioHLzksl8pw795D9Vb6zf2cEXOM8B4go2oDXjRxZQAcFMdwH2zvNqmizJrxZZa6
         9si9+9pgvOZWHvgTHo5bnyOExv1q/Y1kLfGPQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bid5eWeyAf/EDHZJqBvx8IkfWVIQDlnQOV7qBWhlldY=;
        b=LQLGGtVM05ZVwg95TKwOFw4i9eNBEc80JFlxJbyYPUE03l4zMLWVGIZd+8WO/JRYw3
         BrgeWvXYXusWpeMftCrr/AG7APDY1lm/LpyUA695F77Qcq9KYYq9zX3CMwu2HFM0dm7X
         h1XS0xrkrUy2vCFURQwMbu52xRLab9JqAzcj3MyeelmosPgYtE7XNJz4z4w3AeprbzWW
         AmxzGrLgRrZQsiWLJJdcOFqjump/uo9vvEvhp8P/E2f0TTu/kbvagVV3rWJPfYoKGAoo
         M5s+HDBfmqbqfHagBpnE7hnGysrcLJwHmLLNuqaXfDXmZBB3/nAAWh5HEljiWCsispAi
         44vg==
X-Gm-Message-State: AOAM5320VY9F0nP5u24wQc8FoAtpFFEw9jqy1/HptAIgzmTk8KAAVYFm
        c4cCHpBbpi6J8mPQthX63pIbCQ==
X-Google-Smtp-Source: ABdhPJyv2XEnYPCYkiPG/atAIHMxyIZSy2O0IOFxWNkuHMQUjnM1/Z8UFarQXTAHQUcrudUKJj6e5A==
X-Received: by 2002:a63:fd46:: with SMTP id m6mr5658896pgj.403.1621997792024;
        Tue, 25 May 2021 19:56:32 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:201:5a1b:e4e5:eb10:8870])
        by smtp.gmail.com with ESMTPSA id 5sm2966295pjo.17.2021.05.25.19.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 19:56:31 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: [PATCH v2 4/4] slub: Force on no_hash_pointers when slub_debug is enabled
Date:   Tue, 25 May 2021 19:56:25 -0700
Message-Id: <20210526025625.601023-5-swboyd@chromium.org>
X-Mailer: git-send-email 2.31.1.818.g46aad6cb9e-goog
In-Reply-To: <20210526025625.601023-1-swboyd@chromium.org>
References: <20210526025625.601023-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obscuring the pointers that slub shows when debugging makes for some
confusing slub debug messages:

 Padding overwritten. 0x0000000079f0674a-0x000000000d4dce17

Those addresses are hashed for kernel security reasons. If we're trying
to be secure with slub_debug on the commandline we have some big
problems given that we dump whole chunks of kernel memory to the kernel
logs. Let's force on the no_hash_pointers commandline flag when
slub_debug is on the commandline. This makes slub debug messages more
meaningful and if by chance a kernel address is in some slub debug
object dump we will have a better chance of figuring out what went
wrong.

Note that we don't use %px in the slub code because we want to reduce
the number of places that %px is used in the kernel. This also nicely
prints a big fat warning at kernel boot if slub_debug is on the
commandline so that we know that this kernel shouldn't be used on
production systems.

Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---

I opted for extern because I guess we don't want to advertise
no_hash_pointers_enable() in some sort of header file? It can be put in
a header file but I see that the no_hash_pointers variable is also not 
in a header file but exported as symbol.

 lib/vsprintf.c | 2 +-
 mm/slub.c      | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index f0c35d9b65bf..cc281f5895f9 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -2186,7 +2186,7 @@ char *fwnode_string(char *buf, char *end, struct fwnode_handle *fwnode,
 bool no_hash_pointers __ro_after_init;
 EXPORT_SYMBOL_GPL(no_hash_pointers);
 
-static int __init no_hash_pointers_enable(char *str)
+int __init no_hash_pointers_enable(char *str)
 {
 	if (no_hash_pointers)
 		return 0;
diff --git a/mm/slub.c b/mm/slub.c
index bf4949115412..1c30436d3e6c 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4451,6 +4451,8 @@ static struct kmem_cache * __init bootstrap(struct kmem_cache *static_cache)
 	return s;
 }
 
+extern int no_hash_pointers_enable(char *str);
+
 void __init kmem_cache_init(void)
 {
 	static __initdata struct kmem_cache boot_kmem_cache,
@@ -4470,6 +4472,10 @@ void __init kmem_cache_init(void)
 	for_each_node_state(node, N_NORMAL_MEMORY)
 		node_set(node, slab_nodes);
 
+	/* Print slub debugging pointers without hashing */
+	if (static_branch_unlikely(&slub_debug_enabled))
+		no_hash_pointers_enable(NULL);
+
 	create_boot_cache(kmem_cache_node, "kmem_cache_node",
 		sizeof(struct kmem_cache_node), SLAB_HWCACHE_ALIGN, 0, 0);
 
-- 
https://chromeos.dev

