Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1FD438453
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Oct 2021 18:34:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhJWQex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Oct 2021 12:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Oct 2021 12:34:52 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F57BC061714
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 09:32:32 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id d13so1787138ljg.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Oct 2021 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4V16LcyUt1jl2ypUk7NcsToIlbbKRMSOSDQeVvA2i6Y=;
        b=sXVcIx2Xqt9IS48GswWDPTVh5OjM8rAej7nm1JxjseE0S7VkCunRujzRMifEAQUi6G
         VoKa39046MtBKCmp7/K6DOhPQMBngBL03Owl77DGEDSbw8CH4oGb7T3kQQrQCqpmmr5F
         XFynvIVOmIHUeaD7D5RuB9JqZiNw4Y9v3oFCzID8B5tGBKTI2WL+g7OBCgef0eMeuWy2
         2J/eLGh+XUDmh0M/3ZbuFS8DomYS4m6AHj7Y8BtldoucIS9yzDZhNIQMcLpA4j9hoSn4
         7fUUz+ryguHKdrTWcWw+XxZZKfs4lvGsCpX0QHXrT7Z8tUwPmQzXbpzrnuM961R2W6/e
         yORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4V16LcyUt1jl2ypUk7NcsToIlbbKRMSOSDQeVvA2i6Y=;
        b=Dfo67KZLN63IEfWA2LktR4Jr/QbmaYwMHIUSrppqYnT8i8G52o51QQNOxtS4paRrDW
         sGVeE0H3pt1uQrWxjQdN7vULaboJq3yqdcBxm4HJgAxlAP97aP1Az1rBJoqpnofYXPn4
         allf5BUAF1msOK3pqFoyy8EubC+DIKMRMCPR0UDXmR9BGVnRrCHjZpJE9r8UpVWwz0cx
         6dUilVzT8QNzkO85rzdEBonw0C2r8y3j8UrUaCl2TI19kFKmBkggVgbGYYQqJSzg+uI3
         HKgZY6U++vhZffOQrVAtLjLFLUbaNH3bm1Dpl5+R4U6WL01wmsEr3W9vKD57pBQQHr7n
         +NYg==
X-Gm-Message-State: AOAM530q4MpwzG/PHsr47RVA5lezhDrJZhdiHKGVulRUw6GT5bibobXL
        RLnvU5o3WR5UBfR3r/jdEhDTsw==
X-Google-Smtp-Source: ABdhPJw8/0qYB/F4SecPmVFX60JBQmGt+54CBQodWqFMbkxjhINrlsT0GJJmM0XbAKiAqGkEnKq8MQ==
X-Received: by 2002:a05:651c:510:: with SMTP id o16mr7519345ljp.359.1635006751114;
        Sat, 23 Oct 2021 09:32:31 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id h2sm1079992lfe.134.2021.10.23.09.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:32:29 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 0B5BC103099; Sat, 23 Oct 2021 19:32:34 +0300 (+03)
Date:   Sat, 23 Oct 2021 19:32:34 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Sean Christopherson <seanjc@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
Subject: Re: [PATCH 2/3] x86/insn-eval: Introduce insn_decode_mmio()
Message-ID: <20211023163234.vlgdbbcylkwqw5dv@box.shutemov.name>
References: <20211018153333.8261-1-kirill.shutemov@linux.intel.com>
 <20211018153333.8261-3-kirill.shutemov@linux.intel.com>
 <YW2YjRjUg8MzV0rJ@hirez.programming.kicks-ass.net>
 <20211018164941.3nqq73pupep3cejz@box.shutemov.name>
 <YW6DJZBLe0eJaQMu@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW6DJZBLe0eJaQMu@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 10:34:45AM +0200, Peter Zijlstra wrote:
> On Mon, Oct 18, 2021 at 07:49:41PM +0300, Kirill A. Shutemov wrote:
> > On Mon, Oct 18, 2021 at 05:53:49PM +0200, Peter Zijlstra wrote:
> > > On Mon, Oct 18, 2021 at 06:33:32PM +0300, Kirill A. Shutemov wrote:
> > > 
> > > > diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
> > > > index fbaa3fa24bde..2ab29d8d6731 100644
> > > > --- a/arch/x86/lib/insn-eval.c
> > > > +++ b/arch/x86/lib/insn-eval.c
> > > > @@ -1559,3 +1559,85 @@ bool insn_decode_from_regs(struct insn *insn, struct pt_regs *regs,
> > > >  
> > > >  	return true;
> > > >  }
> > > > +
> > > > +/**
> > > > + * insn_decode_mmio() - Decode a MMIO instruction
> > > > + * @insn:	Structure to store decoded instruction
> > > > + * @bytes:	Returns size of memory operand
> > > > + *
> > > > + * Decodes instruction that used for Memory-mapped I/O.
> > > > + *
> > > > + * Returns:
> > > > + *
> > > > + * Type of the instruction. Size of the memory operand is stored in
> > > > + * @bytes. If decode failed, MMIO_DECODE_FAILED returned.
> > > > + */
> > > > +enum mmio_type insn_decode_mmio(struct insn *insn, int *bytes)
> > > > +{
> > > > +	int type = MMIO_DECODE_FAILED;
> > > > +
> > > > +	*bytes = 0;
> > > > +
> > > > +	insn_get_opcode(insn);
> > > 
> > > insn_get_opcode() can fail. Either you assume it's already called and
> > > don't call it, or you can't assume anything and get to do error
> > > handling.
> > 
> > Fair enough. I will return MMIO_DECODE_FAILED if insn_get_opcode() fails.
> > 
> > BTW, looks like is_string_insn() suffers from the same issue. Not sure how
> > to fix it though.
> 
> AFAICT all callers of insn_get_addr_ref() (which is what
> is_string_insn() seems to be part of) do a insn_decode_*() call with
> error checking before.
> 
> So it looks like that insn_get_opcode() in there is superfluous.
> probably same for insn_has_rep_prefix() / get_seg_reg_override_idx() /
> get_eff_addr_modrm_*(). That all wants cleaning up.
> 
> The esaiest way is probably to push those things up the callchains into
> the !static function and have it fail early there.

Looks like insn_get_addr_ref() is the only non-static callsite:

	is_string_insn
	  check_seg_overrides
	    resolve_seg_reg
	      get_seg_base_limit
		get_addr_ref_XX
		  insn_get_addr_ref
	  resolve_default_seg
	    resolve_seg_reg (as above)

What about this:

From 576a390de4759f591709c9961b5d7add02c814f0 Mon Sep 17 00:00:00 2001
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Date: Sat, 23 Oct 2021 19:26:07 +0300
Subject: [PATCH] x86/insn-eval: Handle insn_get_opcode() failure

is_string_insn() calls insn_get_opcode() that can fail, but does not
handle the failure.

is_string_insn() interface does not allow to communicate an error to the
caller.

Push insn_get_opcode() to the only non-static user of is_string_insn()
and fail it early if insn_get_opcode() fails.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/lib/insn-eval.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 1714359f48bd..ccbc7b253d98 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -37,8 +37,6 @@ enum reg_type {
  */
 static bool is_string_insn(struct insn *insn)
 {
-	insn_get_opcode(insn);
-
 	/* All string instructions have a 1-byte opcode. */
 	if (insn->opcode.nbytes != 1)
 		return false;
@@ -1425,6 +1423,9 @@ void __user *insn_get_addr_ref(struct insn *insn, struct pt_regs *regs)
 	if (!insn || !regs)
 		return (void __user *)-1L;
 
+	if (insn_get_opcode(insn))
+		return (void __user *)-1L;
+
 	switch (insn->addr_bytes) {
 	case 2:
 		return get_addr_ref_16(insn, regs);
-- 
 Kirill A. Shutemov
