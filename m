Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C28E366065
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 21:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbhDTTs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 15:48:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34410 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhDTTs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 15:48:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618948075;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SiFW4cLK3dCh2r8aGQaiYzHAG/F7jfTRpzCXN26gydY=;
        b=NRGAg4IBxCx1y0f1am1qwYvd3GknwHOaVO+9zWZmPZ80UZFy9FcVx+n0eb0MR6KdZbevIC
        RBUlLyGSC4jDaY6jQdxfsi5W+pu/widqpw7L7kgSs944EIX/wsKudfK8X9ZiwirY3hKLKP
        OktfJV9ml5fHJKK4xfqOaH84hrUQ+84=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-QlukleblN5-y3fJuwxPo2Q-1; Tue, 20 Apr 2021 15:47:53 -0400
X-MC-Unique: QlukleblN5-y3fJuwxPo2Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9B2F01006C83;
        Tue, 20 Apr 2021 19:47:50 +0000 (UTC)
Received: from treble (ovpn-115-229.rdu2.redhat.com [10.10.115.229])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 798B65D9CA;
        Tue, 20 Apr 2021 19:47:49 +0000 (UTC)
Date:   Tue, 20 Apr 2021 14:47:47 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     x86@kernel.org, Kees Cook <keescook@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 02/15] objtool: Add CONFIG_CFI_CLANG support
Message-ID: <20210420194747.3snxvaaa4amfnbah@treble>
References: <20210416203844.3803177-1-samitolvanen@google.com>
 <20210416203844.3803177-3-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210416203844.3803177-3-samitolvanen@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2021 at 01:38:31PM -0700, Sami Tolvanen wrote:
> +static int fix_cfi_relocs(const struct elf *elf)
> +{
> +	struct section *sec, *tmpsec;
> +	struct reloc *reloc, *tmpreloc;
> +
> +	list_for_each_entry_safe(sec, tmpsec, &elf->sections, list) {
> +		list_for_each_entry_safe(reloc, tmpreloc, &sec->reloc_list, list) {

These loops don't remove structs from the lists, so are the "safe"
iterators really needed?

> +			struct symbol *sym;
> +			struct reloc *func_reloc;
> +
> +			/*
> +			 * CONFIG_CFI_CLANG replaces function relocations to refer
> +			 * to an intermediate jump table. Undo the conversion so
> +			 * objtool can make sense of things.
> +			 */

I think this comment could be clearer if it were placed above the
function.

> +			if (!reloc->sym->sec->cfi_jt)
> +				continue;
> +
> +			if (reloc->sym->type == STT_SECTION)
> +				sym = find_func_by_offset(reloc->sym->sec,
> +							  reloc->addend);
> +			else
> +				sym = reloc->sym;
> +
> +			if (!sym || !sym->sec)
> +				continue;

This should be a fatal error, it probably means something's gone wrong
with the reading of the jump table.

> +
> +			/*
> +			 * The jump table immediately jumps to the actual function,
> +			 * so look up the relocation there.
> +			 */
> +			func_reloc = find_reloc_by_dest_range(elf, sym->sec, sym->offset, 5);

The jump instruction's reloc is always at offset 1, so this can maybe be
optimized to:

			func_reloc = find_reloc_by_dest(elf, sym->sec, sym->offset+1);

though of course that will probably break (future) arm64 objtool.  Maybe
an arch-specific offset from the start of the insn would be good.

> +			if (!func_reloc || !func_reloc->sym)
> +				continue;

This should also be an error.

> +
> +			reloc->sym = func_reloc->sym;

I think we should also do 'reloc->addend = 0', because of the
STT_SECTION case:

  0000000000000025  0000259e0000000b R_X86_64_32S           0000000000000000 .text..L.cfi.jumptable.8047 + 8

which then translates to

  0000000000000009  0000063200000004 R_X86_64_PLT32         0000000000000000 x2apic_prepare_cpu - 4

so the original addend of '8' is no longer valid.  Copying the '-4'
wouldn't be right either, because that only applies to a PLT32 text
reloc.  A '0' should be appropriate for the 32S data reloc.

This addend might not actually be read by any code, so it may not
currently be an actual bug, but better safe than sorry.

-- 
Josh

