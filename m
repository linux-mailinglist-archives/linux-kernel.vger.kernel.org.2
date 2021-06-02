Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0456397DA9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 02:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbhFBA2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 20:28:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:58362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229586AbhFBA2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 20:28:43 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7E2BA6124B;
        Wed,  2 Jun 2021 00:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1622593619;
        bh=qDr3ZE7diO9NQ3VqHna2Ok1cPmbxMJAtcu+G0KjSh3o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TeHg5CyHAzCr1Pw6ge2pgVf6xLZaoeDP8ZsxqPO5vAUebYvQ9UpPvLpMhqLVl2yI7
         FzMWwYU700eNhF+fCdOXK32nZFt7P3YuxjUXb3xya+EQGsDl4hPSCi0voHGDcghKqu
         CU3E6bv8FE8islmq7DdOEfPAbvwjSMBsJV9wWgIo=
Date:   Tue, 1 Jun 2021 17:26:59 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Stephen Boyd <swboyd@chromium.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org,
        Christoph Lameter <cl@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Petr Mladek <pmladek@suse.com>, Joe Perches <joe@perches.com>
Subject: Re: [PATCH v3 4/4] slub: Force on no_hash_pointers when slub_debug
 is enabled
Message-Id: <20210601172659.fd8c40a6548a1bd43be1bf11@linux-foundation.org>
In-Reply-To: <202106020644.UDFIJOUU-lkp@intel.com>
References: <20210601182202.3011020-5-swboyd@chromium.org>
        <202106020644.UDFIJOUU-lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Jun 2021 06:45:55 +0800 kernel test robot <lkp@intel.com> wrote:

> >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
>            if (static_branch_unlikely(&slub_debug_enabled))
>                                        ^
> >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
> >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
> >> mm/slub.c:4464:30: error: use of undeclared identifier 'slub_debug_enabled'
> >> mm/slub.c:4464:6: error: invalid argument type 'void' to unary expression
>            if (static_branch_unlikely(&slub_debug_enabled))
>                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Thanks.  Stephen, how about this?

--- a/mm/slub.c~slub-force-on-no_hash_pointers-when-slub_debug-is-enabled-fix
+++ a/mm/slub.c
@@ -117,12 +117,26 @@
  */
 
 #ifdef CONFIG_SLUB_DEBUG
+
 #ifdef CONFIG_SLUB_DEBUG_ON
 DEFINE_STATIC_KEY_TRUE(slub_debug_enabled);
 #else
 DEFINE_STATIC_KEY_FALSE(slub_debug_enabled);
 #endif
-#endif
+
+static inline bool __slub_debug_enabled(void)
+{
+	return static_branch_unlikely(&slub_debug_enabled);
+}
+
+#else		/* CONFIG_SLUB_DEBUG */
+
+static inline bool __slub_debug_enabled(void)
+{
+	return false;
+}
+
+#endif		/* CONFIG_SLUB_DEBUG */
 
 static inline bool kmem_cache_debug(struct kmem_cache *s)
 {
@@ -4493,7 +4507,7 @@ void __init kmem_cache_init(void)
 		slub_max_order = 0;
 
 	/* Print slub debugging pointers without hashing */
-	if (static_branch_unlikely(&slub_debug_enabled))
+	if (__slub_debug_enabled())
 		no_hash_pointers_enable(NULL);
 
 	kmem_cache_node = &boot_kmem_cache_node;
_

