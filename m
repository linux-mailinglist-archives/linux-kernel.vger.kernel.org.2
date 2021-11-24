Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7B45CD3C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 20:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351176AbhKXTdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:33:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350997AbhKXTdx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:33:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637782243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FYTjFsBMpevNXGnlva+JSC1+iPmKa2vQ8bvWhRzsInc=;
        b=VzT1Tz80SYDtqfY3bka/ZLJEJHsioYU19Sb/g5LsCxQA0PKS4t+La6kkpr9l2WtOghXOB4
        xX/cwsBCsX2QErIkKhRoDeojFfwgsJKpRv6FXePs6QW6V+J6I2rcVk4MKBw1PMj5hHynGE
        Q1qWQgjqpegCX6KPeHo1WfkriqtZtmc=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-384-JWLynr87OcOyZu1WTQtNEg-1; Wed, 24 Nov 2021 14:30:41 -0500
X-MC-Unique: JWLynr87OcOyZu1WTQtNEg-1
Received: by mail-ot1-f71.google.com with SMTP id v13-20020a9d69cd000000b00563c36fd48cso2201721oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 11:30:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FYTjFsBMpevNXGnlva+JSC1+iPmKa2vQ8bvWhRzsInc=;
        b=WcVkcwqxNrfvh9pIfmksbxOEnUGrg4z2koZLAi5wuTpEFdDQoup/uHbQtCJ5MSiRMU
         thfKWIbh3LKKQeFLJTOC7xNB6yk7RPDPh6RbXOwSUnnX23N+Igy3ovaEPhcucbowSsz2
         S7O7nlvUa9M+Ke2YZeUVFuM98GBZFZ9bEzjR3Y+YGE3CzZrGw84s+cItIT1a98F37X75
         WoI2Oagj68u+htZztvT2wn2APQmSNRIiNXOVq7CG3LxrlQprqH+WAyDeXnzwzLvtURe6
         tKCJFqM4BluVdMJ5l0jS+tE2htl9Ob/m2eMBQ7kBaRyH39oAbRzRNx80gmBeQ2i1sGRv
         OPbw==
X-Gm-Message-State: AOAM532ZZWfH8nyr2yVHGQryOk7JyZnxNQmGDotisfZMZKCLJhXRyi04
        ij2djyDw1pbCAuvpwYdCfy+mjfb3qB1RIaYrRZmCFyKXg65zcOKvjdwzNgNLKqO3mxjA8AILRdz
        MdrNhfsvduIEAYbQF+P8Rz8jf
X-Received: by 2002:a9d:7d83:: with SMTP id j3mr15577903otn.236.1637782241188;
        Wed, 24 Nov 2021 11:30:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXeeqX9nuFtya7riSQElOkc7/KAiOq09ZvC3Mls+9bytrR1E5OrNcJVmbpmxKqyrFbiI60Vw==
X-Received: by 2002:a9d:7d83:: with SMTP id j3mr15577881otn.236.1637782240961;
        Wed, 24 Nov 2021 11:30:40 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id t11sm123292otj.24.2021.11.24.11.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 11:30:40 -0800 (PST)
Date:   Wed, 24 Nov 2021 11:30:37 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com
Subject: Re: [RFC][PATCH 6/6] objtool: Add IBT validation / fixups
Message-ID: <20211124193037.nu7q4pa3sianzqtc@treble>
References: <20211122170301.764232470@infradead.org>
 <20211122170805.338489412@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211122170805.338489412@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2021 at 06:03:07PM +0100, Peter Zijlstra wrote:
> +static int validate_ibt_reloc(struct objtool_file *file, struct reloc *reloc, char **name)
> +{
> +	struct instruction *dest;
> +	struct section *sec;
> +	unsigned long off;
> +
> +	sec = reloc->sym->sec;
> +	off = reloc->sym->offset + reloc->addend;
> +
> +	dest = find_insn(file, sec, off);
> +	if (!dest)
> +		return 0;
> +
> +	if (name && dest->func)
> +		*name = dest->func->name;

I think these checks can be further narrowed down by only looking for
X86_64_64 relocs.

> +	list_for_each_entry(insn, &file->endbr_list, call_node) {
> +		if (ibt_seal) {
> +			elf_write_insn(file->elf, insn->sec,
> +				       insn->offset, insn->len,
> +				       arch_nop_insn(insn->len));
> +		}

Like the retpoline rewriting, I'd much rather have objtool create
annotations which the kernel can then read and patch itself.

e.g. have '.ibt.direct_call_sites' and '.ibt.unused_endbr_insns'
sections.

-- 
Josh

