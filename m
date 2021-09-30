Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E6541E04D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 19:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352805AbhI3Rn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 13:43:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50126 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1352744AbhI3RnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 13:43:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633023702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Vq6gTi9Bep6mtPf9nDMlF9035dfiR/XYgA5X2QHKj40=;
        b=XGWl/Z0/Pbvir8vh7hMERMD2b72b1NWqp4Fq6WMoH4FbtYsdGWgZH9zgaqfBauq9yNvtst
        yDRncaiig5ap+yVgD6cupKHV95Kpkfc9TxpSQPIkOqUdPHARodDWy5G8toSrDjfgiuXHfG
        1gJISoWGotv8RlpuWKwvllRKwKkDiWg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-PBRwz0iDO9WBlAnE-evyvg-1; Thu, 30 Sep 2021 13:41:41 -0400
X-MC-Unique: PBRwz0iDO9WBlAnE-evyvg-1
Received: by mail-ot1-f72.google.com with SMTP id m12-20020a0568301e6c00b005469f1a7d70so4761772otr.15
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 10:41:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vq6gTi9Bep6mtPf9nDMlF9035dfiR/XYgA5X2QHKj40=;
        b=ULy/4VjSreYfCDq8Jc25aN2fmkrpYutlO9TgkQ1QwXJD43N0NO8blxngWa9wCUhLlO
         DzR13Qstn56fTuAhR+XJV4QKZ7A0yu0o6lRsXwQA96zgDFoI6ipf5G00uho5bNSyU3Nl
         i1kbRdxzOOfCi2kJBVklABttGPPhmERFAFpFwIlsPI55DlN27/Xv1qSi7BHNZBwAeERh
         AS98rsTtCnbkinacDt1PyZQzwuo8zf/8ecX2PQZK1hpo5RzZLVad7Wcr12HLY6179kSF
         01d+Z92HompnTzJKoARDhDAP2qoW2rb3RPs4NxLKjphgIcLc9/kIOv+kSAHxNFUh4aTJ
         5ofA==
X-Gm-Message-State: AOAM532Uf1R+49WtK9PbS5zLW1nQ6Xh2ONLNWYu//eEBUo+EHTydv0Zq
        3BlOra2lT3sN13hiTstms0Ti8uo802rcfYIZUkgzr/nBKgjNdiXtrf3StzcFzyR8ov+q2439Yur
        IrN+882UGFKLqW0On47Jg6GqD
X-Received: by 2002:aca:b142:: with SMTP id a63mr373419oif.115.1633023700395;
        Thu, 30 Sep 2021 10:41:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxaXC4q6QrGV266RqllNNcjg/6qBIcDvhoxMmAAPlV8rD4YdbwYCIVH9myRfNWtSOphc/Tgog==
X-Received: by 2002:aca:b142:: with SMTP id a63mr373408oif.115.1633023700157;
        Thu, 30 Sep 2021 10:41:40 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id u77sm653168oie.46.2021.09.30.10.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 10:41:39 -0700 (PDT)
Date:   Thu, 30 Sep 2021 10:41:37 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, sfr@canb.auug.org.au,
        mbenes@suse.cz
Subject: Re: [PATCH] objtool: Teach get_alt_entry() about more relocation
 types
Message-ID: <20210930174137.atf6tuzgd2iivx3c@treble>
References: <YVWUvknIEVNkPvnP@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YVWUvknIEVNkPvnP@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 12:43:10PM +0200, Peter Zijlstra wrote:
> 
> Occasionally objtool encounters symbol (as opposed to section)
> relocations in .altinstructions. Typically they are the alternatives
> written by elf_add_alternative() as encountered on a noinstr
> validation run on vmlinux after having already ran objtool on the
> individual .o files.
> 
> Basically this is the counterpart of commit 44f6a7c0755d ("objtool:
> Fix seg fault with Clang non-section symbols"), because when these new
> assemblers (binutils now also does this) strip the section symbols,
> elf_add_reloc_to_insn() is forced to emit symbol based relocations.
> 
> As such, teach get_alt_entry() about different relocation types.
> 
> Fixes: 9bc0bb50727c ("objtool/x86: Rewrite retpoline thunk calls")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Reported-by: Borislav Petkov <bp@alien8.de>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  tools/objtool/special.c |   32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> --- a/tools/objtool/special.c
> +++ b/tools/objtool/special.c
> @@ -58,6 +58,24 @@ void __weak arch_handle_alternative(unsi
>  {
>  }
>  
> +static bool reloc2sec_off(struct reloc *reloc, struct section **sec, unsigned long *off)

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

Though I'd prefer U change it 2 a function name which doesn't look like
a Prince song title.

-- 
Josh

