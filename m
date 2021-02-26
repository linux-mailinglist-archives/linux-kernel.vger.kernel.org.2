Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C343261AB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Feb 2021 12:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhBZLAZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Feb 2021 06:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbhBZLAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Feb 2021 06:00:18 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E886C061574
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:59:38 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id i7so820638wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Feb 2021 02:59:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fo8kxQ4qJJM2hMS9tJdOXhE6q1LoinqW4MyTVHjxcOw=;
        b=fy3n8m8JuruG8diPmtODUBtZ9jgV5geGqIpBAnjyravc3vlzUzvKO+U+ziDxxYhoWp
         8qdEBObBKdD5itNFFzmrmGG3+i73ZkMEZrvgSLxRttM1rXRoHm+nbE5GuyMNqzNdwELy
         10rDXm2uuX3rc8G7p5iGvc/7Z4zAqxsOPKC5bc3+AZCL/PQgEHrmwvyA6YQR1HRSa3aA
         cHijBp75rLRcqH06EkcyR4P6t0ZMhIHOSDRRYfmqMSCBlINdbPoYF1OErRHe85sLImbR
         zofsY5586afBxyVd+dY1DpI1HOf+k7HA0EMLxb87r89Xs8GeLL8YhIrCeDy/BMMZ78Yb
         pfhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fo8kxQ4qJJM2hMS9tJdOXhE6q1LoinqW4MyTVHjxcOw=;
        b=VxsRSIbhuIXUlYyosjIdH4OZMbU6Fv5/nS+lSiPmj54UI2O4nORT4wx7CvHb3jeiB6
         9PngctJSl4FFPh6Iao/eVv+2mXnfsOfQeihsEzi48goeYPus/j0oSspm6oD1jGFCHIkr
         aea0rtSPDDy8tPiEw8GoD1u+v4JIMhOr+a9E9dQE+ADwO2wMZWi+brLHpacKXDTwW9TO
         2I7f4sXDaZY4Rmf6a6/eqiCsKvhYkBTl2MAYioHKpcG8VKtlO5K7+fZ981aKIwjEdYHq
         iAxQutjgi28fqqx0MZf8eaeNZZnadgXPEbY9/3Lpe8XQPNcs/9YNNQxpOZM0htUygOKK
         or0A==
X-Gm-Message-State: AOAM533gWd4z27tdoV+506iihj0jcETZPZBrOVQRP32AzMKTVM+cyxtI
        tB/kAy9ruZudzX+HxLXOCgccSA==
X-Google-Smtp-Source: ABdhPJwIOJ6fFvVSJ5kBYtd2psAXOTCzGWFDo3o2VutegQrMaZI2qchJbhUSDGWDUWFvNSRlxhhfyg==
X-Received: by 2002:a1c:4342:: with SMTP id q63mr2231079wma.112.1614337177200;
        Fri, 26 Feb 2021 02:59:37 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id c2sm13067929wrx.70.2021.02.26.02.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Feb 2021 02:59:36 -0800 (PST)
Date:   Fri, 26 Feb 2021 10:59:34 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] kdb: Get rid of custom debug heap allocator
Message-ID: <20210226105934.gmppt6kubfadv4uf@maple.lan>
References: <20210226095306.1236539-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210226095306.1236539-1-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 03:23:06PM +0530, Sumit Garg wrote:
> Currently the only user for debug heap is kdbnearsym() which can be
> modified to rather ask the caller to supply a buffer for symbol name.
> So do that and modify kdbnearsym() callers to pass a symbol name buffer
> allocated statically and hence remove custom debug heap allocator.

Why make the callers do this?

The LRU buffers were managed inside kdbnearsym() why does switching to
an approach with a single buffer require us to push that buffer out to
the callers?


> diff --git a/kernel/debug/kdb/kdb_main.c b/kernel/debug/kdb/kdb_main.c
> index 9d69169582c6..6efe9ec53906 100644
> --- a/kernel/debug/kdb/kdb_main.c
> +++ b/kernel/debug/kdb/kdb_main.c
> @@ -526,6 +526,7 @@ int kdbgetaddrarg(int argc, const char **argv, int *nextarg,

The documentation comment for this function has not been updated to
describe the new contract on callers of this function (e.g. if they
consume the symbol name they must do so before calling kdbgetaddrarg()
(and maybe kdbnearsym() again).


>  	char symbol = '\0';
>  	char *cp;
>  	kdb_symtab_t symtab;
> +	static char namebuf[KSYM_NAME_LEN];
>  
>  	/*
>  	 * If the enable flags prohibit both arbitrary memory access
> diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
> index b59aad1f0b55..9b907a84f2db 100644
> --- a/kernel/debug/kdb/kdb_support.c
> +++ b/kernel/debug/kdb/kdb_support.c
> @@ -57,8 +57,6 @@ int kdbgetsymval(const char *symname, kdb_symtab_t *symtab)
>  }
>  EXPORT_SYMBOL(kdbgetsymval);
>  
> -static char *kdb_name_table[100];	/* arbitrary size */
> -
>  /*
>   * kdbnearsym -	Return the name of the symbol with the nearest address
>   *	less than 'addr'.

Again the documentation comment has not been updated and, in this case,
is now misleading.

If we move the static buffer here then the remarks section on this
function is a really good place to describe what the callers must do to
manage the static buffer safely as well as a convenient place to mention
that we tolerate the reuse of the static buffer if kdb is re-entered
becase a) kdb is broken if that happens and b) we are crash resilient
if if does.


> @@ -79,13 +77,11 @@ static char *kdb_name_table[100];	/* arbitrary size */
>   *	hold active strings, no kdb caller of kdbnearsym makes more
>   *	than ~20 later calls before using a saved value.
>   */
> -int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab)
> +int kdbnearsym(unsigned long addr, kdb_symtab_t *symtab, char *namebuf)

As above, I don't understand why we need to add namebuf here. I think
the prototype can remain the same.

Think of it simple that we have reduce the cache from having 100 entries
to having just 1 ;-) .


Daniel.
