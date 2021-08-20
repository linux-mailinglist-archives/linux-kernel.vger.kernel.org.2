Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90D3F366B
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232835AbhHTW2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:28:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48593 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231817AbhHTW2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:28:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629498481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eS7fhHIQ2qirqBvc4RyvAMzpvowqZYHrj8dsTvRpK1U=;
        b=Nus07rgdv829879ENVfGuEP4OPqao78IAlpfcg2ZNFLZFYEZu5H+Ak6SoIrnufC1hMghLV
        ZPdaIei5NMQwJzoQbttZxOUqlRLQKFblJEox7vNmul0/fJo8o8G9hWUZM09Ie62XZgE8//
        U/r+onipTDUo8I9SjDI95S8KLhkhN0E=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-aGZ3tyt8OOCLmLUG8XJjWg-1; Fri, 20 Aug 2021 18:27:59 -0400
X-MC-Unique: aGZ3tyt8OOCLmLUG8XJjWg-1
Received: by mail-qv1-f72.google.com with SMTP id b2-20020a0cc9820000b0290352b2c7d7e1so7918655qvk.9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:27:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eS7fhHIQ2qirqBvc4RyvAMzpvowqZYHrj8dsTvRpK1U=;
        b=KA/KUs0TAhecmt3PdPuJgkBEmRNLjEwCTol9RkYbb9NqtJMrpxkj1BP3rcnHW8a96c
         TGwkm3YP3ACAm9uSwYpPWDQ2gFPz8agGWS6O97G5d/sowjsyzstPFHzM8iW80qERQAVL
         lhg7HDsn8mFoHOmWsY1EWh/p6rquznUzsVRSWPwrnz6jpoyL52V0vn3g3zzSk6zfjkgS
         Z4mBgPJYedwNr+RC+LihEzqioByrOcMGZUfznhXiBD+JiKtVWlbo9OJ5rwSDgu4TzQaL
         p3OHDBtrvf9PQSl8Q0D4kCDjarIUbCR2Hwzd0ikKuuAWRySZlSVG+/XCEo+VnTCI872A
         ntDg==
X-Gm-Message-State: AOAM531xT2ELt0xUf3nefDrDOHtoHPq8jn4+XdCxJcCv/RSBsfQfCAFY
        dPG81UYU17rTqyQd4BoSa4UCjiBvInRUO7OThywxYW8JYGpJ4N2vKFL3oIXp33kvgk6AI2/OeEY
        tYE3AXI8541KMfHaUyiqLgAj/
X-Received: by 2002:a37:445:: with SMTP id 66mr10926201qke.376.1629498479471;
        Fri, 20 Aug 2021 15:27:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyGYUjrfBVJuqY04ICr5WnytIwhE46F8unwhnoRLA9vf66xb8bxhRG1cE8mXgCUqc3mtv0o7w==
X-Received: by 2002:a37:445:: with SMTP id 66mr10926185qke.376.1629498479241;
        Fri, 20 Aug 2021 15:27:59 -0700 (PDT)
Received: from treble ([68.74.140.199])
        by smtp.gmail.com with ESMTPSA id j18sm3943306qkg.31.2021.08.20.15.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:27:58 -0700 (PDT)
Date:   Fri, 20 Aug 2021 15:27:55 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, joro@8bytes.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, x86@kernel.org,
        mbenes@suse.com, rostedt@goodmis.org, dvyukov@google.com,
        elver@google.com, Andi Kleen <andi@firstfloor.org>
Subject: Re: [PATCH v2 02/24] objtool: Introduce CFI hash
Message-ID: <20210820222755.sqtlzframoz7k5cb@treble>
References: <20210624094059.886075998@infradead.org>
 <20210624095147.756759107@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210624095147.756759107@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2021 at 11:41:01AM +0200, Peter Zijlstra wrote:
> Andi reported that objtool on vmlinux.o consumes more memory than his
> system has, leading to horrific performance.
> 
> This is in part because we keep a struct instruction for every
> instruction in the file in-memory. Shrink struct instruction by
> removing the CFI state (which includes full register state) from it
> and demand allocating it.
> 
> Given most instructions don't actually change CFI state, there's lots
> of repetition there, so add a hash table to find previous CFI
> instances.
> 
> Reduces memory consumption (and runtime) for processing an
> x86_64-allyesconfig:
> 
>   pre:  4:40.84 real,   143.99 user,    44.18 sys,      30624988 mem
>   post: 2:14.61 real,   108.58 user,    25.04 sys,      16396184 mem

Excellent.

> +static struct cfi_state *cfi_alloc(void)
> +{
> +	struct cfi_state *cfi = calloc(sizeof(struct cfi_state), 1);
> +	if (!cfi) {
> +		WARN("calloc failed");
> +		exit(1);
> +	}
> +	nr_cfi++;
> +	init_cfi_state(cfi);
> +	return cfi;
> +}

I'm thinking this should also add it to the hash.  i.e. I don't think
there's a scenario where you'd alloc a cfi and not want to add it to the
hash.  The more sharing the better.

> +
> +struct cfi_state *insn_get_cfi(struct instruction *insn)
> +{
> +	if (!insn->cfip)
> +		insn->cfip = cfi_alloc();
> +
> +	return insn->cfip;
> +}

Call it something like insn_get_or_alloc_cfi()?

Also, the function can be static.

> +static struct cfi_state *cfi_hash_find(struct cfi_state *cfi)
> +{
> +	struct hlist_head *head = &cfi_hash[hash_min(cfi_key(cfi), cfi_bits)];
> +	struct cfi_state *obj;
> +
> +	hlist_for_each_entry(obj, head, hash) {
> +		if (!cficmp(cfi, obj)) {
> +			nr_cfi_cache++;
> +			return obj;
> +		}
> +	}
> +
> +	obj = cfi_alloc();
> +	*obj = *cfi;
> +	hlist_add_head(&obj->hash, head);
> +
> +	return obj;

cfi_hash_find_or_alloc_cfi()?

> @@ -2725,15 +2820,24 @@ static int validate_branch(struct objtoo
>  
>  			if (insn->visited & visited)
>  				return 0;
> -		}
> +		} else
> +			nr_visited++;
>  
>  		if (state.noinstr)
>  			state.instr += insn->instr;
>  
> -		if (insn->hint)
> -			state.cfi = insn->cfi;
> -		else
> -			insn->cfi = state.cfi;
> +		if (insn->hint) {
> +			state.cfi = *insn->cfip;
> +		} else {
> +			/* XXX track if we actually changed state.cfi */

Why would we do that?

> +++ b/tools/objtool/include/objtool/check.h
> @@ -60,9 +60,11 @@ struct instruction {
>  	struct list_head alts;
>  	struct symbol *func;
>  	struct list_head stack_ops;
> -	struct cfi_state cfi;
> +	struct cfi_state *cfip;

Not sure about this rename.  Pointers generally don't need a 'p' postfix.

-- 
Josh

