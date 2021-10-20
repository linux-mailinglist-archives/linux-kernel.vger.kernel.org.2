Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97024346D5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 10:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbhJTI2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 04:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbhJTI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 04:28:20 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE97C061746
        for <linux-kernel@vger.kernel.org>; Wed, 20 Oct 2021 01:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rOJsmtKqHI3ca8h7TQv1QgPq4t/FlSc8JZWKfh2ltEw=; b=Ummb3graQeR1ca+E2zpkYAvdDf
        Hdg5X+oj5cHUPOnYb8iC0JXFGF6PItLL/OPkwjITWjCJiX+1WYMPDAZokwE6HamSpWbYjXRZWxFu/
        sh+xmSmaVOpM/zyQMDTfuaUdJWvKK9HaT+2ZFC+IpLaVA0tMlbYq8bIZkswh34JXElLyxRrHswiEp
        f3UUqMzXj4WqreLi+AMwKRgKoImW6dA5shIHvxdVjyjYVU9rsdNLpyb0W2AIB2Ck7ewg6UDXfbo/H
        fKkImviN4uLKw4pVYgdLbcFLifesF1UZKwYqdMTKAyY7zDtRre6jqXQ+Sqn3Bc+lLWcgp4+aouaUj
        voLGCgJQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1md6v5-00Auqk-7H; Wed, 20 Oct 2021 08:25:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A156B3002BC;
        Wed, 20 Oct 2021 10:25:52 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 89E5E20F080E8; Wed, 20 Oct 2021 10:25:52 +0200 (CEST)
Date:   Wed, 20 Oct 2021 10:25:52 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     x86@kernel.org, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, alexei.starovoitov@gmail.com,
        ndesaulniers@google.com
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <YW/SkCW9wSnFiivN@hirez.programming.kicks-ass.net>
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

> @@ -1916,8 +1930,25 @@ static int read_static_call_tramps(struct objtool_file *file)
>  		list_for_each_entry(func, &sec->symbol_list, list) {
>  			if (func->bind == STB_GLOBAL &&
>  			    !strncmp(func->name, STATIC_CALL_TRAMP_PREFIX_STR,
> -				     strlen(STATIC_CALL_TRAMP_PREFIX_STR)))
> +				     strlen(STATIC_CALL_TRAMP_PREFIX_STR))) {
>  				func->static_call_tramp = true;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int read_retpoline_thunks(struct objtool_file *file)
> +{
> +	struct section *sec;
> +	struct symbol *func;
> +
> +	for_each_sec(file, sec) {
> +		list_for_each_entry(func, &sec->symbol_list, list) {
> +			if (func->bind == STB_GLOBAL && arch_is_retpoline(func)) {
> +				func->retpoline = true;
> +			}
>  		}
>  	}

I've folded these two identical loops over all symbols into a single
classify_symbols() function.

