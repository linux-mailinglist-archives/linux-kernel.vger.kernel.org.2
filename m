Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CAE3D253D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 16:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232292AbhGVNaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 09:30:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:53066 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhGVNaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:30:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE25922674;
        Thu, 22 Jul 2021 14:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1626963058; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=znqZXEBvAg7dEbM5a2gQPS3YjNE0Yq928OYkD/5qLAI=;
        b=AZV3erzgxGYb6H+cbwB2i3k4ARqpI4fnEI/VqXsoGEdXqlEn3d7a3CXeJ7rd9yjpMP4j8S
        cgatLfrtzOrSESMbl05PfuIciKEyDPg1Z7EIFjTnwCGdEcybeT3Ol/OBHce0iDUEnNymg2
        bbuZ9x1ORBRKhWbdB2VxMcvuRNzWA+M=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A8FAF13DCE;
        Thu, 22 Jul 2021 14:10:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id UawqJ3J8+WC9VAAAMHmgww
        (envelope-from <ailiop@suse.com>); Thu, 22 Jul 2021 14:10:58 +0000
Date:   Thu, 22 Jul 2021 16:10:55 +0200
From:   Anthony Iliopoulos <ailiop@suse.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: fix debugfs initialization order
Message-ID: <YPl8b7KuoNBg52LE@technoir>
References: <20210722091818.13434-1-ailiop@suse.com>
 <1ea36b32-9bbc-a611-402d-9fa196eda166@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ea36b32-9bbc-a611-402d-9fa196eda166@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2021 at 11:10:24AM +0100, Robin Murphy wrote:
> On 2021-07-22 10:18, Anthony Iliopoulos wrote:
> > Due to link order, dma_debug_init is called before debugfs has a chance
> > to initialize (via debugfs_init which also happens in the core initcall
> > stage), so the directories for dma-debug are never created.
> > 
> > Move the dma_debug_init initcall from core to postcore stage so that
> > debugfs will already be initialized by the time this is called, making
> > it oblivious to link-ordering.
> 
> Playing initcall chicken here doesn't work so well - the later you
> initialise dma-debug itself, the more chance it has to miss early mappings
> and raise false positives later. As discussed previously[1] the better
> solution would be to decouple the debugfs setup so that just that part can
> be deferred until core_initcall_sync or later.

Thanks for pointing it out, makes sense. What about the following:

From: Anthony Iliopoulos <ailiop@suse.com>

Due to link order, dma_debug_init is called before debugfs has a chance
to initialize (via debugfs_init which also happens in the core initcall
stage), so the directories for dma-debug are never created.

Decouple dma_debug_fs_init from dma_debug_init and defer its init until
core_initcall_sync (after debugfs has been initialized) while letting
dma-debug initialization occur as soon as possible to catch any early
mappings, as suggested in [1].

[1] https://lore.kernel.org/linux-iommu/YIgGa6yF%2Fadg8OSN@kroah.com/

Fixes: 15b28bbcd567 ("dma-debug: move initialization to common code")
Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>
---
 kernel/dma/debug.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
index 14de1271463f..445754529917 100644
--- a/kernel/dma/debug.c
+++ b/kernel/dma/debug.c
@@ -794,7 +794,7 @@ static int dump_show(struct seq_file *seq, void *v)
 }
 DEFINE_SHOW_ATTRIBUTE(dump);

-static void dma_debug_fs_init(void)
+static int __init dma_debug_fs_init(void)
 {
 	struct dentry *dentry = debugfs_create_dir("dma-api", NULL);

@@ -807,7 +807,10 @@ static void dma_debug_fs_init(void)
 	debugfs_create_u32("nr_total_entries", 0444, dentry, &nr_total_entries);
 	debugfs_create_file("driver_filter", 0644, dentry, NULL, &filter_fops);
 	debugfs_create_file("dump", 0444, dentry, NULL, &dump_fops);
+
+	return 0;
 }
+core_initcall_sync(dma_debug_fs_init);

 static int device_dma_allocations(struct device *dev, struct dma_debug_entry **out_entry)
 {
@@ -892,8 +895,6 @@ static int dma_debug_init(void)
 		spin_lock_init(&dma_entry_hash[i].lock);
 	}

-	dma_debug_fs_init();
-
 	nr_pages = DIV_ROUND_UP(nr_prealloc_entries, DMA_DEBUG_DYNAMIC_ENTRIES);
 	for (i = 0; i < nr_pages; ++i)
 		dma_debug_create_entries(GFP_KERNEL);
