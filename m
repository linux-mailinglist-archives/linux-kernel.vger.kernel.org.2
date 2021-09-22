Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A55341540F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 01:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238512AbhIVXqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 19:46:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:1586 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230455AbhIVXqO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:46:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="221839536"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="221839536"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 16:44:43 -0700
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="704227657"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 16:44:42 -0700
Date:   Wed, 22 Sep 2021 23:44:41 +0000
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
Message-ID: <YUu/6YPYwvaDwthy@otcwcpicx3.sc.intel.com>
References: <20210920192349.2602141-1-fenghua.yu@intel.com>
 <20210920192349.2602141-8-fenghua.yu@intel.com>
 <20210922210343.GU4323@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922210343.GU4323@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Peter,

On Wed, Sep 22, 2021 at 11:03:43PM +0200, Peter Zijlstra wrote:
> On Mon, Sep 20, 2021 at 07:23:48PM +0000, Fenghua Yu wrote:
> > +	ret = validate_enqcmd(file);
> > +	if (ret < 0)
> > +		goto out;
> > +	warnings += ret;
> > +
> >  	if (vmlinux && !validate_dup) {
> >  		ret = validate_vmlinux_functions(file);
> >  		if (ret < 0)
> 
> Since you're making it a fatal error, before doing much of anything
> else, you might at well fail decode and keep it all in the x86/decode.c
> file, no need to spread this 'knowledge' any further.
> 
> There's no actual state associated with it, you just want to avoid the
> instruction being present.
> 
> Much simpler patch too.

Is the following updated patch a right one?

Thanks.

-Fenghua

diff --git a/tools/objtool/arch/x86/decode.c b/tools/objtool/arch/x86/decode.c
index bc821056aba9..3e0f928e28a5 100644
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@ -110,7 +110,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 {
 	struct insn insn;
 	int x86_64, ret;
-	unsigned char op1, op2,
+	unsigned char op1, op2, op3,
 		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
@@ -137,6 +137,7 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 
 	op1 = insn.opcode.bytes[0];
 	op2 = insn.opcode.bytes[1];
+	op3 = insn.opcode.bytes[2];
 
 	if (insn.rex_prefix.nbytes) {
 		rex = insn.rex_prefix.bytes[0];
@@ -489,6 +490,16 @@ int arch_decode_instruction(const struct elf *elf, const struct section *sec,
 			/* nopl/nopw */
 			*type = INSN_NOP;
 
+		} else if (op2 == 0x38 && op3 == 0xf8) {
+			if (insn.prefixes.nbytes == 1 &&
+			    insn.prefixes.bytes[0] == 0xf2) {
+				/* ENQCMD cannot be used in the kernel. */
+				WARN("ENQCMD instruction at %s:%lx", sec->name,
+				     offset);
+
+				return -1;
+			}
+
 		} else if (op2 == 0xa0 || op2 == 0xa8) {
 
 			/* push fs/gs */
