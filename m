Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 534D330B4BE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 02:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhBBBfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 20:35:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbhBBBer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 20:34:47 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B94C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 17:34:06 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m6so13273524pfk.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 17:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3rRC5L1HAgk1eG9rrmQ31gof/zzPM5U9FXhi6qF+2c=;
        b=NIcPfkwVcNyZufJvoDC8Yc4amsiAcsdClUUVjpuGA3I1VtTQ/6DtBBEKnp86ICwo17
         Xtv94cH1H29Sd7g2XhAH8RBW7+b7Qya1l0Ll3PFELL7ZlB50ohGQaqM89hE5eAjw4wmw
         5b1Tda9TJWsscnhNVS3F5UC2RX9d4VNCQFDOg5IIx9LXZiBxH3e9qQ5n7dyZcmvq5WHe
         F73bYMUvfGVsSmJ/TsBQE72uSGUMk4MV7tcE6Pp9LrIzkOQDgAvSgjgMaTqYjKx0ZXMW
         A4mCj0N4y5li/9rRi4F63YkLhiyog0b/hLmzgFH+r2TfQQTZY2xSNqAanlWK4lRku5Ij
         onjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3rRC5L1HAgk1eG9rrmQ31gof/zzPM5U9FXhi6qF+2c=;
        b=YReZPtXnCRg7rpa3Fqr61LiMKojdZbeC4Ov/3r24purus6XI86aZT9M9LektUscrAq
         gZUN82jUWZT0ECiXVG7Dp16XBkuVLIe1CaDK6CoytwMfgugEwDc7jm28gSIYDyElC4JJ
         IFrNJmrzNQU4LtA0ct49AJl8qeKu8gkImL7KaO72K0uXu+x2RfjUNahLd5sazbJA7uT4
         EKwKOP827TCyI72nvIUVvbu9QPS3uXLXBEV5bFWY0VVshsTqEXSBgL1lVTZqDucsW9Xr
         oEfFU4+QvNWeY6tDFi6aWNe5CAX+/cX/tB/iil1w0djiluITx4XSXQ//S1EzfIjUBdx/
         fMog==
X-Gm-Message-State: AOAM530Puz+mxcik6+5gGH1KTZhvvpKRGN5id/GcXBqNpqMWmm2hwWpI
        V3qb4oCzbiNd8I3Kr9aBdjAECg==
X-Google-Smtp-Source: ABdhPJwTCtggTZhrizDeqgjMyE+0YzjsUBWfwlMYXtcoQKaPLKcM4lEHGWbT4x7ItRHiiZjNIxnW7g==
X-Received: by 2002:a63:a301:: with SMTP id s1mr19860278pge.325.1612229645965;
        Mon, 01 Feb 2021 17:34:05 -0800 (PST)
Received: from google.com ([2620:15c:f:10:829:fccd:80d7:796f])
        by smtp.gmail.com with ESMTPSA id g15sm18709108pfb.30.2021.02.01.17.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 17:34:05 -0800 (PST)
Date:   Mon, 1 Feb 2021 17:33:58 -0800
From:   Sean Christopherson <seanjc@google.com>
To:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] KVM: Scalable memslots implementation
Message-ID: <YBisBkSYPoaOM42F@google.com>
References: <ceb96527b6f7bb662eec813f05b897a551ebd0b2.1612140117.git.maciej.szmigiero@oracle.com>
 <4d748e0fd50bac68ece6952129aed319502b6853.1612140117.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d748e0fd50bac68ece6952129aed319502b6853.1612140117.git.maciej.szmigiero@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch numbering and/or threading is messed up.  This should either be a
standalone patch, or fully incorporated into the same series as the selftests
changes.  But, that's somewhat of a moot point...

On Mon, Feb 01, 2021, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> The current memslot code uses a (reverse) gfn-ordered memslot array for
> keeping track of them.
> This only allows quick binary search by gfn, quick lookup by hva is not
> possible (the implementation has to do a linear scan of the whole memslot
> array).
> 
> Because the memslot array that is currently in use cannot be modified
> every memslot management operation (create, delete, move, change flags)
> has to make a copy of the whole array so it has a scratch copy to work
> on.
> 
> Strictly speaking, however, it is only necessary to make copy of the
> memslot that is being modified, copying all the memslots currently
> present is just a limitation of the array-based memslot implementation.
> 
> Two memslot sets, however, are still needed so the VM continues to
> run on the currently active set while the requested operation is being
> performed on the second, currently inactive one.
> 
> In order to have two memslot sets, but only one copy of the actual
> memslots it is necessary to split out the memslot data from the
> memslot sets.
> 
> The memslots themselves should be also kept independent of each other
> so they can be individually added or deleted.
> 
> These two memslot sets should normally point to the same set of
> memslots. They can, however, be desynchronized when performing a
> memslot management operation by replacing the memslot to be modified
> by its copy.
> After the operation is complete, both memslot sets once again
> point to the same, common set of memslot data.
> 
> This commit implements the aforementioned idea.

This needs split into at least 5+ patches, and probably more like 10+ to have
a realistic chance of getting it thoroughly reviewed.

E.g. changes that can easily be split out:

  - Move s390's "approximate" logic into search_memslots.
  - Introduce n_memslots_pages
  - Using a hash for id_to_index
  - Changing KVM_USER_MEM_SLOTS to SHRT_MAX
  - kvm_zap_gfn_range() changes/optimizations

AFAICT, tracking both the active and inactive memslot in memslots_all could also
be done in a separate patch, though I can't tell if that would actually gain
anything.

> The new implementation uses two trees to perform quick lookups:
> For tracking of gfn an ordinary rbtree is used since memslots cannot
> overlap in the guest address space and so this data structure is
> sufficient for ensuring that lookups are done quickly.

Switching to a rbtree for the gfn lookups also appears to be a separate change,
though that's little more than a guess based on a quick read of the changes.

> For tracking of hva, however, an interval tree is needed since they
> can overlap between memslots.

...

> Making lookup and memslot management operations O(log(n)) brings
> some performance benefits (tested on a Xeon 8167M machine):
> 509 slots in use:
> Test		Before		After		Improvement
> Map		0,0246s		0,0240s		 2%
> Unmap		0,0833s		0,0318s		62%
> Unmap 2M	0,00177s	0,000917s	48%
> Move active	0,0000959s	0,0000816s	15%
> Move inactive	0,0000960s	0,0000799s	17%

I assume "move" refers to the gfn?  If so, I believe this can be ignored for the
most part as it's not a common operation, and already has a lot of leading zeros :-)

> Slot setup	0,0107s		0,00825s	23%

What does "slot setup" measure?  I assume it's one-time pain?  If so, then we
can probably ignore this as use cases that care about millisecond improvements
in boot time are unlikely to have 50 memslots, let alone 500+ memslots.

I'm not nitpicking the benchmarks to discredit your measurements, rather to
point out that I suspect the only thing that's "broken" and that anyone truly
cares about is unmapping, i.e. hva->memslot lookups.  If that is indeed the
case, would it be sufficient to focus on speeding up _just_ the hva lookups?

Specifically, I think we can avoid copying the "active vs. inactive" scheme that
is used for the main gfn-based array by having the hva tree resolve to an _id_,
not to the memslot itself.  I.e. bounce through id_to_index, which is coupled
with the main array, so that lookups are always done on the "active" memslots,
without also having to implement an "inactive" hva tree.

For deletion, seeing the defunct/invalid memslot is not a functional problem;
it's technically a performance "problem", but one that we already have.  For
creation, id_to_index will be -1, and so the memslot lookup will return NULL
until the new memslot is visible.

All hva lookups would obviously need to be changed, but the touchpoint for the
write would be quite small, e.g.

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8367d88ce39b..c03beb4833b2 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1220,6 +1220,20 @@ static int kvm_set_memslot(struct kvm *kvm,
        if (r)
                goto out_slots;

+       /*
+        * Update the hva=>id tree if a memslot is being deleted or created.
+        * No update is required for moving a memslot or changing its flags,
+        * as those don't affect its _id_.  For deletion, the memslot has been
+        * zapped and flushed, fast hva lookups are guaranteed to be nops.  For
+        * creation, the new memslot isn't visible until the final installation
+        * is complete.  Fast hva lookups may prematurely see the entry, but
+        * id_to_memslot() will return NULL upon seeing id_to_index[id] == -1.
+        */
+       if (change == KVM_MR_DELETE)
+               kvm_hva_tree_remove(...);
+       else if (change == KVM_MR_CREATE)
+               kvm_hva_tree_insert(...);
+
        update_memslots(slots, new, change);
        slots = install_new_memslots(kvm, as_id, slots);


I'm not opposed to using more sophisticated storage for the gfn lookups, but
only if there's a good reason for doing so.  IMO, the rbtree isn't simpler, just
different.  Memslot modifications are unlikely to be a hot path (and if it is,
x86's "zap everything" implementation is a far bigger problem), and it's hard to
beat the memory footprint of a raw array.  That doesn't leave much motivation
for such a big change to some of KVM's scariest (for me) code.
