Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 389B9416204
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 17:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242011AbhIWP1z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 11:27:55 -0400
Received: from mga09.intel.com ([134.134.136.24]:1942 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241976AbhIWP1u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 11:27:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="223899452"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="223899452"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 08:26:17 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="702771098"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 08:26:16 -0700
Date:   Thu, 23 Sep 2021 15:26:14 +0000
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] tools/objtool: Check for use of the ENQCMD
 instruction in the kernel
Message-ID: <YUycliX+lPSMhWfR@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
 <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
 <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUwp7VkjApRQr/pb@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Thu, Sep 23, 2021 at 09:17:01AM +0200, Peter Zijlstra wrote:
> On Wed, Sep 22, 2021 at 11:44:41PM +0000, Fenghua Yu wrote:
> 
> > > Since you're making it a fatal error, before doing much of anything
> > > else, you might at well fail decode and keep it all in the x86/decode.c
> > > file, no need to spread this 'knowledge' any further.
> 
> > Is the following updated patch a right one?
> 
> Yes, that's what I was thinking of.
> 
> > diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
> > index bc821056aba9..3e0f928e28a5 100644
> > --- a/tools/objtool/arch/x86/decode.c
> > +++ b/tools/objtool/arch/x86/decode.c
> > @@ -110,7 +110,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
> >  {
> >  	struct insn insn;
> >  	int x86_64, ret;
> > -	unsigned char op1, op2,
> > +	unsigned char op1, op2, op3,
> >  		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
> >  		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
> >  		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
> > @@ -137,6 +137,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
> >  
> >  	op1 = insn.opcode.bytes[0];
> >  	op2 = insn.opcode.bytes[1];
> > +	op3 = insn.opcode.bytes[2];
> >  
> >  	if (insn.rex_prefix.nbytes) {
> >  		rex = insn.rex_prefix.bytes[0];
> > @@ -489,6 +490,16 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
> >  			/* nopl/nopw */
> >  			*type = INSN_NOP;
> >  
> > +		} else if (op2 == 0x38 && op3 == 0xf8) {
> > +			if (insn.prefixes.nbytes == 1 &&
> > +			    insn.prefixes.bytes[0] == 0xf2) {
> > +				/* ENQCMD cannot be used in the kernel. */
> > +				WARN("ENQCMD instruction at %s:%lx", sec->name,
> > +				     offset);
> > +
> > +				return -1;
> > +			}
> 
> The only concern here is if we want it to be fatal or not. But otherwise
> this seems to be all that's required.

objtool doesn't fail kernel build on this fatal warning.

Returning -1 here stops checking the rest of the file and won't report any
further warnings unless this ENQCMD warning is fixed. Not returning -1
continues checking the rest of the file and may report more warnings.
Seems that's the only difference b/w them.

Should I keep this "return -1" or not? Please advice.

-Fenghua
