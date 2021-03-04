Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA02D32D946
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhCDSHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 13:07:41 -0500
Received: from mail.skyhub.de ([5.9.137.197]:44034 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233464AbhCDSHi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 13:07:38 -0500
Received: from zn.tnic (p200300ec2f0f5900f7833063514d8659.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:5900:f783:3063:514d:8659])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 91D801EC0324;
        Thu,  4 Mar 2021 19:06:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1614881217;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DBQmN0juID0E7QS/e5Irp/7OAq4ViI0o2vsXUBKrIXg=;
        b=gAtCZULtilWg279lGZftb+UjMvC2CWSL0PTYDcCojTPLwIG+qE3Gvp5iaHehOlqNBPoEfP
        g3XUamW+T2mrl6NXi2kWQqnpBOWL3V7PkIwZ8S1gpEqC7f0fmTTSaLczgcpXK8vYCS+XK3
        IIPtSv42oo4d2XbSh7/djzp0zgvWgc0=
Date:   Thu, 4 Mar 2021 19:06:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 17/21] tools/objtool: Convert to insn_decode()
Message-ID: <20210304180652.GE15496@zn.tnic>
References: <20210304174237.31945-1-bp@alien8.de>
 <20210304174237.31945-18-bp@alien8.de>
 <YEEdlNN3OIi59hbr@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YEEdlNN3OIi59hbr@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 04, 2021 at 06:49:08PM +0100, Peter Zijlstra wrote:
> This is going to have trivial rejects/fuzz against tip/objtool/core.

I was just wondering whether to you show you how I resolved :)

diff --cc tools/objtool/arch/x86/decode.c
index 431bafb881d4,8380d0b1d933..22a53ee322ea
--- a/tools/objtool/arch/x86/decode.c
+++ b/tools/objtool/arch/x86/decode.c
@@@ -104,14 -90,12 +104,14 @@@ int arch_decode_instruction(const struc
  			    struct list_head *ops_list)
  {
  	struct insn insn;
- 	int x86_64;
 -	int x86_64, sign, ret;
 -	unsigned char op1, op2, rex = 0, rex_b = 0, rex_r = 0, rex_w = 0,
 -		      rex_x = 0, modrm = 0, modrm_mod = 0, modrm_rm = 0,
 -		      modrm_reg = 0, sib = 0;
++	int x86_64, ret;
 +	unsigned char op1, op2,
 +		      rex = 0, rex_b = 0, rex_r = 0, rex_w = 0, rex_x = 0,
 +		      modrm = 0, modrm_mod = 0, modrm_rm = 0, modrm_reg = 0,
 +		      sib = 0, /* sib_scale = 0, */ sib_index = 0, sib_base = 0;
  	struct stack_op *op = NULL;
  	struct symbol *sym;
 +	u64 imm;
  
  	x86_64 = is_x86_64(elf);
  	if (x86_64 == -1)

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
