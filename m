Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C237E4146C7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235041AbhIVKnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhIVKnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:43:19 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A990AC0613E4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:41:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so10093924lfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LrlsF27efhqSDhHZ0+WQsLB4CuB2tcAlNXfIpnl+oEE=;
        b=GMmTYRJcTJdQGPcaTgetE5LYtgfc/H+tD56rqgSQRsp9mf2hSQIyrCiH1aBSLDK0aE
         Yx+/xUVG3vMw3760RnA8Odn+c7vQJap5oULMunjXjD5Yd7ufQiK1L8MTJBpjUoT34djt
         ME3xtKij0kXNBqtebcXo7kmvDmZSmbZdUQa2VpIYmXTaT3hYUrLdQKqNXD/M6hVNIo6e
         kg7fj5L9rKJ5lTYwZKCYBfyObVs6T7BLFfd88a4RQLYnaMosEF26hfTv/1MBcvRz9J+d
         Xfn4BMG0eDOUemLQN2BjS4ydNVtaaPtbnSbvq7LxdR0rkL34CZxMLzVl3KlWzIVG4qRP
         hp2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LrlsF27efhqSDhHZ0+WQsLB4CuB2tcAlNXfIpnl+oEE=;
        b=uCB5w1LngimRITmz2e2USZs77WTJg51N+xGpuJC2w+EYlRTvV2q+xgoiEvec+DR+KI
         yQbXfQ9X7e5N3k/BB+AF2HCQmfxr7WB8yl22ngcHp3uD7GlBZ5xrhdf8o+BGd9OVuG37
         Yim1augFkZYP0L6whGD6w+/crY+FGeZRoO+FOGZcyp0ZBx63DIqbO7Vm3s+INmxQ3B5b
         BxFS72X2mp9EXOhrtHqcijG7fVQnSJ8FqwvHFikuS890q0A2jsb/7Q980aSdVXgmWm8L
         Ker5EL22ez3V4DHJZGJsL3uqaLYCnXVy+Uq8WAnehDjbqNIfym4Y8lakiQcCWlv7RIxh
         WCvA==
X-Gm-Message-State: AOAM532UnFfme0xQ6NJohsGI6L/FN1A/9T1DWLoPo+9po/e0hXIJLRMd
        aw60tcVsom8WfUn6vArkkb0=
X-Google-Smtp-Source: ABdhPJyJUpacwUYeRFhhpEJarhl42wzLcUFfWzfijADMAFHIALZ68YbT3IetphSwLtq/8+J36y+tPw==
X-Received: by 2002:a2e:a814:: with SMTP id l20mr21622219ljq.380.1632307304012;
        Wed, 22 Sep 2021 03:41:44 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u3sm53372lfm.4.2021.09.22.03.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 03:41:43 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 22 Sep 2021 12:41:41 +0200
To:     David Hildenbrand <david@redhat.com>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ping Fang <pifang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [PATCH v1] mm/vmalloc: fix exact allocations with an alignment >
 1
Message-ID: <20210922104141.GA27011@pc638.lan>
References: <20210908132727.16165-1-david@redhat.com>
 <CA+KHdyWadbqZ=xVBv6uZwxpZSEndAAk_inK+0962VcntY+mnSA@mail.gmail.com>
 <CA+KHdyUTQLwN0YASOX8XJoWCD_x1QwRmz81BGShCzb_8jZ93XQ@mail.gmail.com>
 <ea75df96-f381-6949-5627-1382a370dc71@redhat.com>
 <20210916193403.GA1940@pc638.lan>
 <221e38c1-4b8a-8608-455a-6bde544adaf0@redhat.com>
 <20210921221337.GA60191@pc638.lan>
 <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f62d710-ca85-7d33-332a-25ff88b5452f@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 10:34:55AM +0200, David Hildenbrand wrote:
> > > No, that's leaking implementation details to the caller. And no, increasing
> > > the range and eventually allocating something bigger (e.g., placing a huge
> > > page where it might not have been possible) is not acceptable for KASAN.
> > > 
> > > If you're terribly unhappy with this patch,
> > Sorry to say but it simple does not make sense.
> > 
> 
> Let's agree to disagree.
> 
> find_vmap_lowest_match() is imprecise now and that's an issue for exact
> allocations. We can either make it fully precise again (eventually degrading
> allocation performance) or just special-case exact allocations to fix the
> regression.
> 
> I decided to go the easy path and do the latter; I do agree that making
> find_vmap_lowest_match() fully precise again might be preferred -- we could
> have other allocations failing right now although there are still suitable
> holes.
> 
> I briefly thought about performing the search in find_vmap_lowest_match()
> twice. First, start the search without an extended range, and fallback to
> the extended range if that search fails. Unfortunately, I think that still
> won't make the function completely precise due to the way we might miss
> searching some suitable subtrees.
> 
> > > 
> > > please suggest something reasonable to fix exact allocations:
> > > a) Fixes the KASAN use case.
> > > b) Allows for automatic placement of huge pages for exact allocations.
> > > c) Doesn't leak implementation details into the caller.
> > > 
> > I am looking at it.
> 
I am testing this:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index dcf23d16a308..cdf3bda6313d 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -1161,18 +1161,14 @@ find_vmap_lowest_match(unsigned long size,
 {
 	struct vmap_area *va;
 	struct rb_node *node;
-	unsigned long length;
 
 	/* Start from the root. */
 	node = free_vmap_area_root.rb_node;
 
-	/* Adjust the search size for alignment overhead. */
-	length = size + align - 1;
-
 	while (node) {
 		va = rb_entry(node, struct vmap_area, rb_node);
 
-		if (get_subtree_max_size(node->rb_left) >= length &&
+		if (get_subtree_max_size(node->rb_left) >= size &&
 				vstart < va->va_start) {
 			node = node->rb_left;
 		} else {
@@ -1182,9 +1178,9 @@ find_vmap_lowest_match(unsigned long size,
 			/*
 			 * Does not make sense to go deeper towards the right
 			 * sub-tree if it does not have a free block that is
-			 * equal or bigger to the requested search length.
+			 * equal or bigger to the requested search size.
 			 */
-			if (get_subtree_max_size(node->rb_right) >= length) {
+			if (get_subtree_max_size(node->rb_right) >= size) {
 				node = node->rb_right;
 				continue;
 			}
@@ -1192,16 +1188,30 @@ find_vmap_lowest_match(unsigned long size,
 			/*
 			 * OK. We roll back and find the first right sub-tree,
 			 * that will satisfy the search criteria. It can happen
-			 * only once due to "vstart" restriction.
+			 * due to "vstart" restriction or an alignment overhead.
 			 */
 			while ((node = rb_parent(node))) {
 				va = rb_entry(node, struct vmap_area, rb_node);
 				if (is_within_this_va(va, size, align, vstart))
 					return va;
 
-				if (get_subtree_max_size(node->rb_right) >= length &&
+				if (get_subtree_max_size(node->rb_right) >= size &&
 						vstart <= va->va_start) {
+					/*
+					 * Shift the vstart forward, so we do not loop over same
+					 * sub-tree force and back. The aim is to continue tree
+					 * scanning toward higher addresses cutting off previous
+					 * ones.
+					 *
+					 * Please note we update vstart with parent's start address
+					 * adding "1" because we do not want to enter same sub-tree
+					 * one more time after it has already been inspected and no
+					 * suitable free block found there.
+					 */
+					vstart = va->va_start + 1;
 					node = node->rb_right;
+
+					/* Scan a sub-tree rooted at "node". */
 					break;
 				}
 			}
<snip>

so it handles any alignment and is accurate when it comes to searching the most
lowest free block when user wants to allocate with a special alignment value.

Could you please help and test the KASAN use case?

Thanks!

--
Vlad Rezki
