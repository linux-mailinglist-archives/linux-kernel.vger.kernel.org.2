Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E70E3D5A1C
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 15:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233438AbhGZMcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhGZMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:32:42 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6103C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:13:10 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a80-20020a1c98530000b0290245467f26a4so6290933wme.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZtU7fvZEyyOLQgnySOlDvGY7f3ikYJEH6+mfO2JIeiw=;
        b=YFyKwtLN1bSSFHloIhy0fW6Dhxolu5g2e/6SEkdyGH1aiDKhpgyhOGUJHd1xSooBXA
         UpvvIqh+avoVzy3OYPWTNNy5ahUcREJDczLQ01VVwk3UKTyvHawERdAeLrXAEa0Jj+k+
         adbZCEMgpl2zRM89TwupWHr68qDbMaFItJ+MTlezkUjQSwzdN1HIBhE2/bqOxmbv3wz7
         Wi/T620Hs0l757Y8lVpPETU0D1YKKVdWNKKRcEeBGAUCnENLQ5LFdNONRT2I1Re/VAdB
         xXsmlyhQtfVry/uGikW3+jSh0sfhWnOqAu/I7Wclztk+OLiUdmTEBfWCQXpB2xvd3ju9
         GyDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZtU7fvZEyyOLQgnySOlDvGY7f3ikYJEH6+mfO2JIeiw=;
        b=GJQj4AAQX0ZCBa1us5RhiYdrAMs4DAgESQgVzgbkrOMO3a2q5FuB6rFvjoCm/eYosR
         Jt4qy+HQjSY7mKQgY38G+4YQFxtRJHwcyqtNWQ9O5FHTe1Os5pl63+LeU05i29JmTOJc
         rE0KwdyejAJATLzzUQ+CWy/OC4kLClZb43P5yxtgPgsA+enBXqSVEnB+3X1HAUQLPFCh
         DaJk1LZV3ZIWZXTMfULiCvZT7bp8LGph12lef3hzX4iR+YXxKVNaSvv+ZIYXoPZt5MoY
         AUa+g6ecDtGGlXBls+KxdVhFnltPCGY0jMwCtYfdPn5eqwqGzw7vFy9K5aTY1KtxLGif
         MUEg==
X-Gm-Message-State: AOAM533OQPesdgjtbEBO2LEp9EQW6cKFBkMWMP/IoyX4ufq33nu93gkc
        oCZlu1fJ+V/nIH/7Jkp1NwEKUQ==
X-Google-Smtp-Source: ABdhPJw3iV0iD0VNKcKvIFGEO/4SIbrCzeF0z8XajY3jrjx5HJnK1HWQwzfNfl/GjgZNs2EuDMsB/A==
X-Received: by 2002:a1c:3886:: with SMTP id f128mr1889070wma.85.1627305189353;
        Mon, 26 Jul 2021 06:13:09 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:c468:e033:fa2b:3a6])
        by smtp.gmail.com with ESMTPSA id x8sm42479052wrt.93.2021.07.26.06.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 06:13:09 -0700 (PDT)
Date:   Mon, 26 Jul 2021 14:13:06 +0100
From:   Quentin Perret <qperret@google.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     james.morse@arm.com, alexandru.elisei@arm.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, ardb@kernel.org, qwandor@google.com,
        tabba@google.com, dbrazdil@google.com, kernel-team@android.com
Subject: Re: [PATCH v2 04/16] KVM: arm64: Optimize host memory aborts
Message-ID: <YP604j6B1pkhAnT1@google.com>
References: <20210726092905.2198501-1-qperret@google.com>
 <20210726092905.2198501-5-qperret@google.com>
 <87pmv5e529.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmv5e529.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 Jul 2021 at 11:35:10 (+0100), Marc Zyngier wrote:
> On Mon, 26 Jul 2021 10:28:53 +0100,
> Quentin Perret <qperret@google.com> wrote:
> > +static int host_stage2_find_range(u64 addr, struct kvm_mem_range *range)
> 
> nit: I find 'find_range' a bit odd. We already have found a
> range. We're just trying to narrow it down to something that fits in a
> single block mapping. How about 'host_stage2_adjust_range'?

Ack.

> > +{
> > +	u64 granule, start, end;
> > +	kvm_pte_t pte;
> > +	u32 level;
> > +	int ret;
> > +
> > +	ret = kvm_pgtable_get_leaf(&host_kvm.pgt, addr, &pte, &level);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (kvm_pte_valid(pte))
> > +		return -EAGAIN;
> > +
> > +	if (pte)
> > +		return -EPERM;
> > +
> > +	do {
> > +		granule = kvm_granule_size(level);
> > +		start = ALIGN_DOWN(addr, granule);
> > +		end = start + granule;
> > +		level++;
> > +	} while ((level < KVM_PGTABLE_MAX_LEVELS) &&
> > +			(!kvm_level_supports_block_mapping(level) ||
> > +			 start < range->start || range->end < end));
> > +
> 
> This expression does my head in. You are trying to find the largest
> block mapping that entirely fits in range, right? Can we just express
> that directly (with a global negation for the purpose of the loop)?
> 
> 	do {
> 		[...]
> 	} while (level < KVM_PGTABLE_MAX_LEVELS &&
> 		 !(kvm_level_supports_block_mapping(level) &&
> 		   start >= range->start &&
> 		   end <= range->end));
> 
> I personally find this much more readable, because it expresses the
> condition we are looking for rather than a lot of conditions forcing
> us to continue.
> 
> You could also use a kvm_mem_range for the iteration, and add a helper
> that checks for the inclusion.

Something like this (untested)?

diff --git a/arch/arm64/kvm/hyp/nvhe/mem_protect.c b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
index 75273166d2c5..07d228163090 100644
--- a/arch/arm64/kvm/hyp/nvhe/mem_protect.c
+++ b/arch/arm64/kvm/hyp/nvhe/mem_protect.c
@@ -234,9 +234,15 @@ static inline int __host_stage2_idmap(u64 start, u64 end,
                __ret;                                                  \
         })

+static inline bool range_included(struct kvm_mem_range *child,
+                                 struct kvm_mem_range *parent)
+{
+       return parent->start <= child->start && child->end <= parent->end;
+}
+
 static int host_stage2_find_range(u64 addr, struct kvm_mem_range *range)
 {
-       u64 granule, start, end;
+       struct kvm_mem_range cur;
        kvm_pte_t pte;
        u32 level;
        int ret;
@@ -252,16 +258,15 @@ static int host_stage2_find_range(u64 addr, struct kvm_mem_range *range)
                return -EPERM;

        do {
-               granule = kvm_granule_size(level);
-               start = ALIGN_DOWN(addr, granule);
-               end = start + granule;
+               u64 granule = kvm_granule_size(level);
+               cur.start = ALIGN_DOWN(addr, granule);
+               cur.end = cur.start + granule;
                level++;
        } while ((level < KVM_PGTABLE_MAX_LEVELS) &&
-                       (!kvm_level_supports_block_mapping(level) ||
-                        start < range->start || range->end < end));
+                       !(kvm_level_supports_block_mapping(level) &&
+                         range_included(&cur, parent)));

-       range->start = start;
-       range->end = end;
+       *range = cur;

        return 0;
 }
