Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB9AE3F72DA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:20:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239029AbhHYKV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239735AbhHYKVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:21:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E8EC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 03:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/BUsftWLYUFbAVcNCxOeiIICKCu2cQABxz+Pxz0KUR4=; b=rZ+iuTO2TXyrfSjdLCY40uUSqk
        xgMrf9PZcy1IuzB1RX2tL7puFuAPeilu/3DN9Q1sQCW9yYxJ9rzaxrJ62g4V66Gm8eG+jQyCgN6FI
        nmQUZOk5K5L9qp8CV9kqWbgep8+zfbyCJDYRF/TXVMwFlxMwSZwFfwuEAvQUQRLKvHJDOgF88Iz7w
        Jbr4hGmx9022PeeW8M4+qxHcQ1saXRqksCemdGzCZmb0pjLqdEhHKeP5t40y8GvjEt/0yhjdVCt0A
        6YSFpy1/Vy8K/rhSgsBs0ijGGQzAeKyWncliBtgb79SYVIzqQFTychv2ysPGSWNDhU2/4Yt5UpF8Z
        TSGjzsOg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mIq0Z-00CshA-VT; Wed, 25 Aug 2021 10:19:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 0E766300399;
        Wed, 25 Aug 2021 12:19:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E3FBD200E4A2F; Wed, 25 Aug 2021 12:19:46 +0200 (CEST)
Date:   Wed, 25 Aug 2021 12:19:46 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com
Subject: Re: [PATCH v2 03/24] objtool: Handle __sanitize_cov*() tail calls
Message-ID: <YSYZQsS5MA6BTyfj@hirez.programming.kicks-ass.net>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.818783799@infradead.org>
 <20210820231744.76clopxwcqeum4k7@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210820231744.76clopxwcqeum4k7@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 20, 2021 at 04:17:44PM -0700, Josh Poimboeuf wrote:
> On Thu, Jun 24, 2021 at 11:41:02AM +0200, Peter Zijlstra wrote:
> > +	if (insn->sec->noinstr &&
> > +	    !strncmp(insn->call_dest->name, "__sanitizer_cov_", 16)) {
> > +		if (reloc) {
> > +			reloc->type = R_NONE;
> > +			elf_write_reloc(file->elf, reloc);
> > +		}
> > +
> > +		elf_write_insn(file->elf, insn->sec,
> > +			       insn->offset, insn->len,
> > +			       sibling ? arch_ret_insn(insn->len)
> > +			               : arch_nop_insn(insn->len));
> > +
> > +		insn->type = sibling ? INSN_RETURN : INSN_NOP;
> > +	}
> 
> It'd be nice to keep the comment for this case that was in
> add_call_destinations().

Done!
