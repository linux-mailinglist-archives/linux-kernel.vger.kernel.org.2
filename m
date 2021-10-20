Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7829A4346F8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229639AbhJTIdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbhJTIdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:33:01 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AF3C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3OLZ7qJ08nHHBM2qZTVu1EJSQMFk9MZ440U4M+413G4=; b=RGk1jGc8JOBaFeW4F07MM+J0W9
        kq0fws2b1RIt1h60kYzTn4SBf2bSpGc6qk2s7+mVih9VllW+7Jd5Brth8UXAwaNTpl7iNTiyKnLI3
        iunG+ayUMuZhBvAu9pP3MG9Mlxop1SL2C+Gk5eoSXVa370/sn8piAVYQWr13HFGYdJyhazfboiWTT
        pkgH2ZyabI9d0aY0/RSi/tyRpFm7lHOVte7HjXkCn1LS4Sa4BRPiVimNaux1vcLLsUPQaq2BF7UcD
        dh452jZWYp5ygNqHGJouW411Xx1gUari7A9ehMx+2kwZPV5Ob5lJbAjUEHiorOvFYw++WQrY/0vyH
        wVm3o7Zg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md6ze-00AutD-EU; Wed, 20 Oct 2021 08:30:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 16597300221;
        Wed, 20 Oct 2021 10:30:38 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id ECCA020F080E8; Wed, 20 Oct 2021 10:30:37 +0200 (CEST)
Date:   Wed, 20 Oct 2021 10:30:37 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YW/TrQ4MFjz8yTWC@hirez.programming.kicks-ass.net>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013205259.44cvvaxiexiff5w5@treble>
 <YW6t5catO1mx+eCZ@hirez.programming.kicks-ass.net>
 <20211019164659.dybir4wgfmdt4r47@treble>
 <20211019164913.2dsyyethdeblqjlq@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019164913.2dsyyethdeblqjlq@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 19, 2021 at 09:49:13AM -0700, Josh Poimboeuf wrote:

> @@ -1087,9 +1109,7 @@ static int add_jump_destinations(struct objtool_file *file)
>  			else
>  				insn->type = INSN_JUMP_DYNAMIC_CONDITIONAL;
>  
> -			list_add_tail(&insn->call_node,
> -				      &file->retpoline_call_list);
> -
> +			add_call_dest(file, insn, reloc->sym, true);
>  			insn->retpoline_safe = true;
>  			continue;
>  		} else if (insn->func) {
> @@ -1218,20 +1238,14 @@ static int add_call_destinations(struct objtool_file *file)
>  
>  			add_call_dest(file, insn, dest, false);
>  
> -		} else if (arch_is_retpoline(reloc->sym)) {
> +		} else if (reloc->sym->retpoline) {
>  			/*
>  			 * Retpoline calls are really dynamic calls in
>  			 * disguise, so convert them accordingly.
>  			 */
>  			insn->type = INSN_CALL_DYNAMIC;
> +			add_call_dest(file, insn, reloc->sym, false);
>  			insn->retpoline_safe = true;
> -
> -			list_add_tail(&insn->call_node,
> -				      &file->retpoline_call_list);
> -
> -			remove_insn_ops(insn);
> -			continue;
> -
>  		} else
>  			add_call_dest(file, insn, reloc->sym, false);
>  	}

So the problem with add_call_dest() like this, is that the instructions
now get to have ->call_dest set, which is really strange for
INSN_CALL_DYNAMIC etc.. At the very least it makes call_dest_name()
misbehave.

I've added add_retpoline_call() that also does the ->type frobbing and
->retpoline_safe marking instead.
