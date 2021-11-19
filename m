Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5444577C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 21:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhKSUer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 15:34:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:40349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235315AbhKSUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 15:34:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637353903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P2sZkZbNWImGK5CgW7dFwBi8zGA25zK0xwbZ1WxQTIw=;
        b=MkC+wTlV5ROXL+eUAyvnpaZiSILxFYkS/Az+1uhIk0WF6YzYCLe/QJY6I9AylhncEJk7Fr
        29+JXgWTM3nLmbZJUxegeWGfMegIng8QrPRoEVW6A/gy56GteX/MnednuLrW+eA6riT9Aw
        u7sDLlEoYidld/Emgih1/cxVEmF3xgU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-51-KMe5ecNjNUORrQG0PL-Vjw-1; Fri, 19 Nov 2021 15:31:40 -0500
X-MC-Unique: KMe5ecNjNUORrQG0PL-Vjw-1
Received: by mail-qt1-f197.google.com with SMTP id h20-20020ac85e14000000b002b2e9555bb1so7834909qtx.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 12:31:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P2sZkZbNWImGK5CgW7dFwBi8zGA25zK0xwbZ1WxQTIw=;
        b=yFk17Cl+RjoppNB8VnO/H3buBghKCQcPhAQwmh9eshgQ73YiKIqQ8qMEvXzpixsh7h
         lnrq9hxBl+abPTjoQCAG0d5Zt5IyWkDrIcRFNiU6E4F5S0iEDdSm14iSvRK64JOHfids
         GZKwJJAHrD9ElBT54dM1cCFOm9fBf43VxEx1D2ELkeJ8A4k42wZ8SALTp5S5XFJDnD2t
         EDoJkABVdfcv9KAFtu/7L7/9uj+tS/ODsxSLbYmbw/Zjk5podgKDDZTF/XUEUUaGxExu
         LosVYy3V/ecbh0Nv7IsisEYfeBb+iUcVmx9DWPY1pARNboZHusyZ8HLRglMbHnVZyuwX
         gXZg==
X-Gm-Message-State: AOAM532PPoYt2ZJ/E12slREjx0SnsIlwV7QMUxoEtCVHlbwaFlQ0ujYQ
        XB9keLdniwyXF8H/L2lSdF5RbUaGGWQH3C+tWSqDvJOF7VDu5QgCHXUCqikiay7WUrJswbFBxWM
        0X5WbC4HMgvGkUU1ja6r1yrRJ
X-Received: by 2002:ac8:7f52:: with SMTP id g18mr9425072qtk.190.1637353900224;
        Fri, 19 Nov 2021 12:31:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxkAXs81p/9fcPnMbXqzRfyHNHU69K8pzzXpDVQagmkQJ2qJyjzDlmUAcOqpRVDqAvK3rgV/w==
X-Received: by 2002:ac8:7f52:: with SMTP id g18mr9425020qtk.190.1637353899973;
        Fri, 19 Nov 2021 12:31:39 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id z13sm374393qkj.1.2021.11.19.12.31.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:31:39 -0800 (PST)
Date:   Fri, 19 Nov 2021 12:31:35 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>, kasan-dev@googlegroups.com,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH v2 23/23] objtool, kcsan: Remove memory barrier
 instrumentation from noinstr
Message-ID: <20211119203135.clplwzh3hyo5xddg@treble>
References: <20211118081027.3175699-1-elver@google.com>
 <20211118081027.3175699-24-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118081027.3175699-24-elver@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2021 at 09:10:27AM +0100, Marco Elver wrote:
> @@ -1071,12 +1071,7 @@ static void annotate_call_site(struct objtool_file *file,
>  		return;
>  	}
>  
> -	/*
> -	 * Many compilers cannot disable KCOV with a function attribute
> -	 * so they need a little help, NOP out any KCOV calls from noinstr
> -	 * text.
> -	 */
> -	if (insn->sec->noinstr && sym->kcov) {
> +	if (insn->sec->noinstr && sym->removable_instr) {
>  		if (reloc) {
>  			reloc->type = R_NONE;
>  			elf_write_reloc(file->elf, reloc);

I'd love to have a clearer name than 'removable_instr', though I'm
having trouble coming up with something.

'profiling_func'?

Profiling isn't really accurate but maybe it gets the point across.  I'm
definitely open to other suggestions.

Also, the above code isn't very self-evident so there still needs to be
a comment there, like:

	/*
	 * Many compilers cannot disable KCOV or sanitizer calls with a
	 * function attribute so they need a little help, NOP out any
	 * such calls from noinstr text.
	 */

> @@ -1991,6 +1986,32 @@ static int read_intra_function_calls(struct objtool_file *file)
>  	return 0;
>  }
>  
> +static bool is_removable_instr(const char *name)


> +{
> +	/*
> +	 * Many compilers cannot disable KCOV with a function attribute so they
> +	 * need a little help, NOP out any KCOV calls from noinstr text.
> +	 */
> +	if (!strncmp(name, "__sanitizer_cov_", 16))
> +		return true;

A comment is good here, but the NOP-ing bit seems out of place.

-- 
Josh

