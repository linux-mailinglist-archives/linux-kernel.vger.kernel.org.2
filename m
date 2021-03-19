Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE31341375
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 04:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbhCSDaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 23:30:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54672 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229931AbhCSDaE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 23:30:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616124603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=X+Yp7EuHNuKLgdZgU27hXH9QEHhuoU1JhCFmbjObPSc=;
        b=Czat1yqyGOBK0ma8re/ezx5YKtgMgKa3XD3sJae8g9mqhYlC569hdEGxxRf5pU/o2lLdJE
        ZdyC6rrzcoN1nPCECWHZtXNej+iCOwU/0Sp05nnvcIGvkIhqaOl7WD7TQID+4XNdjYlRkn
        FEfQwMCfOUlCZSZY54kQ9QkdLrh9dUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-397-c5QA0z_CMJyz52qmqVnS6w-1; Thu, 18 Mar 2021 23:30:01 -0400
X-MC-Unique: c5QA0z_CMJyz52qmqVnS6w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C95DA800D53;
        Fri, 19 Mar 2021 03:29:59 +0000 (UTC)
Received: from treble (ovpn-113-46.rdu2.redhat.com [10.10.113.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D1D610013C1;
        Fri, 19 Mar 2021 03:29:57 +0000 (UTC)
Date:   Thu, 18 Mar 2021 22:29:55 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jgross@suse.com, mbenes@suse.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/14] objtool,x86: Rewrite retpoline thunk calls
Message-ID: <20210319032955.zdx6ihhprem5owbc@treble>
References: <20210318171103.577093939@infradead.org>
 <20210318171920.253147364@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210318171920.253147364@infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 06:11:17PM +0100, Peter Zijlstra wrote:
> When the compiler emits: "CALL __x86_indirect_thunk_\reg" for an
> indirect call, have objtool rewrite it to:
> 
> 	ALTERNATIVE "call __x86_indirect_thunk_\reg",
> 		    "call *%reg", ALT_NOT(X86_FEATURE_RETPOLINE)
> 
> Additionally, in order to not emit endless identical
> .altinst_replacement chunks, use a global symbol for them, see
> __x86_indirect_alt_*.
> 
> This also avoids objtool from having to do code generation.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This is better than I expected.  Nice workaround for not generating
code.

> +.macro ALT_THUNK reg
> +
> +	.align 1
> +
> +SYM_FUNC_START_NOALIGN(__x86_indirect_alt_call_\reg)
> +	ANNOTATE_RETPOLINE_SAFE
> +1:	call	*%\reg
> +2:	.skip	5-(2b-1b), 0x90
> +SYM_FUNC_END(__x86_indirect_alt_call_\reg)
> +
> +SYM_FUNC_START_NOALIGN(__x86_indirect_alt_jmp_\reg)
> +	ANNOTATE_RETPOLINE_SAFE
> +1:	jmp	*%\reg
> +2:	.skip	5-(2b-1b), 0x90
> +SYM_FUNC_END(__x86_indirect_alt_jmp_\reg)

This mysterious code needs a comment.  Shouldn't it be in
.altinstr_replacement or something?

Also doesn't the alternative code already insert nops?

> +int arch_rewrite_retpoline(struct objtool_file *file,
> +			   struct instruction *insn,
> +			   struct reloc *reloc)
> +{
> +	struct symbol *sym;
> +	char name[32] = "";
> +
> +	if (!strcmp(insn->sec->name, ".text.__x86.indirect_thunk"))
> +		return 0;
> +
> +	sprintf(name, "__x86_indirect_alt_%s_%s",
> +		insn->type == INSN_JUMP_DYNAMIC ? "jmp" : "call",
> +		reloc->sym->name + 21);
> +
> +	sym = find_symbol_by_name(file->elf, name);
> +	if (!sym) {
> +		sym = elf_create_undef_symbol(file->elf, name);
> +		if (!sym) {
> +			WARN("elf_create_undef_symbol");
> +			return -1;
> +		}
> +	}
> +
> +	elf_add_alternative(file->elf, insn, sym,
> +			    ALT_NOT(X86_FEATURE_RETPOLINE), 5, 5);
> +
> +	return 0;
> +}

Need to propagate the error.

-- 
Josh

