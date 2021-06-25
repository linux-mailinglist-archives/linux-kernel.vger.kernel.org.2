Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7257D3B44A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 15:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbhFYNkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 09:40:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:44874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhFYNks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 09:40:48 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 917446197C;
        Fri, 25 Jun 2021 13:38:26 +0000 (UTC)
Date:   Fri, 25 Jun 2021 09:38:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     jpoimboe@redhat.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, dvyukov@google.com, elver@google.com
Subject: Re: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
Message-ID: <20210625093824.03eb3cf7@oasis.local.home>
In-Reply-To: <20210624095147.818783799@infradead.org>
References: <20210624094059.886075998@infradead.org>
        <20210624095147.818783799@infradead.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jun 2021 11:41:02 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> +static void add_call_dest(struct objtool_file *file, struct instruction *insn,
> +			  struct symbol *dest, bool sibling)
> +{
> +	struct reloc *reloc = insn_reloc(file, insn);
> +
> +	insn->call_dest = dest;
> +	if (!dest)
> +		return;
> +
> +	if (insn->call_dest->static_call_tramp) {
> +		list_add_tail(&insn->call_node,
> +			      &file->static_call_list);
> +	}
> +
> +	if (insn->sec->noinstr &&
> +	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> +		if (reloc) {
> +			reloc->type = R_NONE;
> +			elf_write_reloc(file->elf, reloc);
> +		}
> +
> +		elf_write_insn(file->elf, insn->sec,
> +			       insn->offset, insn->len,
> +			       sibling ? arch_ret_insn(insn->len)
> +			               : arch_nop_insn(insn->len));
> +
> +		insn->type = sibling ? INSN_RETURN : INSN_NOP;
> +	}
> +
> +	if (mcount && !strcmp(insn->call_dest->name, "__fentry__")) {
> +		if (sibling)
> +			WARN_FUNC("Tail call to __fentry__ !?!?", insn->sec, insn->offset);

Have you ever triggered the above?

-- Steve

> +
> +		if (reloc) {
> +			reloc->type = R_NONE;
> +			elf_write_reloc(file->elf, reloc);
> +		}
> +
