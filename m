Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8C5442FD85
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 23:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243154AbhJOVh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 17:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238700AbhJOVhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 17:37:52 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 091A5C061762
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:35:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id lk8-20020a17090b33c800b001a0a284fcc2so10259348pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 14:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fXK9I7sL2UAvUUHr680VS0N7hcJaT8a/qC/oAjWAekg=;
        b=i/plbNWQsfMbAtipP0bedfIRhU9GtT0vQBPBSqxQOXPLHpycgRU2/2eFgrucmm2h2H
         jyUzWsmXl3g4lj7XR6uQJW5kj6zHZDhfr5oLknCnvhs4hYYOrFP7YzLzzikPK/mnLAUp
         qzqAv/u7xWCe7UATWzGpSateqcXcucSLev7S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fXK9I7sL2UAvUUHr680VS0N7hcJaT8a/qC/oAjWAekg=;
        b=uzT34TcEsmdo8YwjlYHi3Ltfv/i9hDoR0jenI1yyY8RcycemHod8P5JoTRqJPAKKBt
         i7Zejck68IGSk8V4dlBFtI5yPJH3FFkVU3198MS789pg7V8f30kL2aTHqrWb32anmKUa
         xjbb8SMEloslk2fJpu7f17hJiyzHdLtbw9zHhUT8p/CDwuGqG9yF1VsaG7ulTNmAcOaw
         jQDdX3YQUyxor3DWrb/gAY7FAWpp7C6DO9gQTRtkXHkDVulqfI4Gu0EUvvNXBJdXKukh
         8HbNmgLjJVvsHTTzq81b1CYTcpJJIkmQNE6wikCep61ZBRwxYbUder7YtnOE8zBaigcL
         egug==
X-Gm-Message-State: AOAM533xv6kNErHllrcA9GDuqkhvE+fdP4YhPTrp2ejUm713bjtOwHO8
        luKjWOVpf++IlAEjK2a+HiZ7qA==
X-Google-Smtp-Source: ABdhPJzGiIkXXBmy5DDoWMNsGgWcXqtw/xBNMBOjRI4bsAE2X+6lsLV+71+RhBCvt+ERtsGfcdpHpA==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr16246857pjb.120.1634333745601;
        Fri, 15 Oct 2021 14:35:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q10sm5538176pgn.31.2021.10.15.14.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 14:35:45 -0700 (PDT)
Date:   Fri, 15 Oct 2021 14:35:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 13/13] lkdtm: Add a test for function descriptors
 protection
Message-ID: <202110151433.6270D717@keescook>
References: <cover.1634190022.git.christophe.leroy@csgroup.eu>
 <08a3dfbc55e1c7a0a1917b22f0ca6cabd9895ab2.1634190022.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08a3dfbc55e1c7a0a1917b22f0ca6cabd9895ab2.1634190022.git.christophe.leroy@csgroup.eu>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 07:50:02AM +0200, Christophe Leroy wrote:
> Add WRITE_OPD to check that you can't modify function
> descriptors.
> 
> Gives the following result when function descriptors are
> not protected:
> 
> 	lkdtm: Performing direct entry WRITE_OPD
> 	lkdtm: attempting bad 16 bytes write at c00000000269b358
> 	lkdtm: FAIL: survived bad write
> 	lkdtm: do_nothing was hijacked!
> 
> Looks like a standard compiler barrier(); is not enough to force
> GCC to use the modified function descriptor. Add to add a fake empty
> inline assembly to force GCC to reload the function descriptor.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  drivers/misc/lkdtm/core.c  |  1 +
>  drivers/misc/lkdtm/lkdtm.h |  1 +
>  drivers/misc/lkdtm/perms.c | 22 ++++++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
> index fe6fd34b8caf..de092aa03b5d 100644
> --- a/drivers/misc/lkdtm/core.c
> +++ b/drivers/misc/lkdtm/core.c
> @@ -148,6 +148,7 @@ static const struct crashtype crashtypes[] = {
>  	CRASHTYPE(WRITE_RO),
>  	CRASHTYPE(WRITE_RO_AFTER_INIT),
>  	CRASHTYPE(WRITE_KERN),
> +	CRASHTYPE(WRITE_OPD),
>  	CRASHTYPE(REFCOUNT_INC_OVERFLOW),
>  	CRASHTYPE(REFCOUNT_ADD_OVERFLOW),
>  	CRASHTYPE(REFCOUNT_INC_NOT_ZERO_OVERFLOW),
> diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
> index c212a253edde..188bd0fd6575 100644
> --- a/drivers/misc/lkdtm/lkdtm.h
> +++ b/drivers/misc/lkdtm/lkdtm.h
> @@ -105,6 +105,7 @@ void __init lkdtm_perms_init(void);
>  void lkdtm_WRITE_RO(void);
>  void lkdtm_WRITE_RO_AFTER_INIT(void);
>  void lkdtm_WRITE_KERN(void);
> +void lkdtm_WRITE_OPD(void);
>  void lkdtm_EXEC_DATA(void);
>  void lkdtm_EXEC_STACK(void);
>  void lkdtm_EXEC_KMALLOC(void);
> diff --git a/drivers/misc/lkdtm/perms.c b/drivers/misc/lkdtm/perms.c
> index 96b3ebfcb8ed..3870bc82d40d 100644
> --- a/drivers/misc/lkdtm/perms.c
> +++ b/drivers/misc/lkdtm/perms.c
> @@ -44,6 +44,11 @@ static noinline void do_overwritten(void)
>  	return;
>  }
>  
> +static noinline void do_almost_nothing(void)
> +{
> +	pr_info("do_nothing was hijacked!\n");
> +}
> +
>  static void *setup_function_descriptor(func_desc_t *fdesc, void *dst)
>  {
>  	memcpy(fdesc, do_nothing, sizeof(*fdesc));
> @@ -143,6 +148,23 @@ void lkdtm_WRITE_KERN(void)
>  	do_overwritten();
>  }
>  
> +void lkdtm_WRITE_OPD(void)
> +{
> +	size_t size = sizeof(func_desc_t);
> +	void (*func)(void) = do_nothing;
> +
> +	if (!have_function_descriptors()) {
> +		pr_info("Platform doesn't have function descriptors.\n");

This should be more explicit ('xfail'):

	pr_info("XFAIL: platform doesn't use function descriptors.\n");

> +		return;
> +	}
> +	pr_info("attempting bad %zu bytes write at %px\n", size, do_nothing);
> +	memcpy(do_nothing, do_almost_nothing, size);
> +	pr_err("FAIL: survived bad write\n");
> +
> +	asm("" : "=m"(func));

Since this is a descriptor, I assume no icache flush is needed. Are
function descriptors strictly dcache? (Is anything besides just a
barrier needed?)

> +	func();
> +}
> +
>  void lkdtm_EXEC_DATA(void)
>  {
>  	execute_location(data_area, CODE_WRITE);
> -- 
> 2.31.1
> 

-- 
Kees Cook
