Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2A7344C63
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 17:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbhCVQyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 12:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhCVQyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 12:54:23 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3F8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 09:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VAtX5/PSZBpHdx4o/M2SW17GNefrFYOFyvVs60qWgBk=; b=XH52/sDRPASnsmUK9dlh3D9jfU
        AlKwJJ3jtZmv1cZu5ptbV3ib9huMU/RseW9LG6JSvWXdc9tP88lFEm9/2b65eWc8Z9bKQyXVb2nnQ
        QKrvZwmXy+IZLSOS3/qgHgQn5NNx9Vr1sQlFUptMD8fzpg2C5XraAxtxXkg7D9kgUeSCENl9O5fNS
        QOVV1uJYuXxRSqnoeBCcPRB0oyP8oE/VylIEcT3hvmWUaZJKV3mfsuBZhZn7DR43qgRC4Y2LVWwaV
        KoZpoJP7+zM1HT5ZhCp4K6NIqVuxfSs40NICZmevHLhO2K9myc9n/nd16G9nlk0OYdrD2AnJXcGML
        x/wdRFDA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lONoX-00C6Cc-LU; Mon, 22 Mar 2021 16:54:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 715593003E1;
        Mon, 22 Mar 2021 17:54:00 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5958D2007DF02; Mon, 22 Mar 2021 17:54:00 +0100 (CET)
Date:   Mon, 22 Mar 2021 17:54:00 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        jbaron@akamai.com, ardb@kernel.org, linux-kernel@vger.kernel.org,
        sumit.garg@linaro.org, oliver.sang@intel.com, jarkko@kernel.org
Subject: Re: [PATCH 3/3] static_call: Fix static_call_update() sanity check
Message-ID: <YFjLqKV9GxGSXcAr@hirez.programming.kicks-ass.net>
References: <20210318113156.407406787@infradead.org>
 <20210318113610.739542434@infradead.org>
 <20210318161308.vu3dhezp2lczch6f@treble>
 <YFOGvmWiJUDOHy7D@hirez.programming.kicks-ass.net>
 <YFSfwimq/VLmo1Lw@hirez.programming.kicks-ass.net>
 <20210319140005.7ececb11@gandalf.local.home>
 <YFT8wDrWvfpQoIWw@hirez.programming.kicks-ass.net>
 <20210319165749.0f3c8281@gandalf.local.home>
 <YFiuphGw0RKehWsQ@gunter>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFiuphGw0RKehWsQ@gunter>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 03:50:14PM +0100, Jessica Yu wrote:

> It should be doable. If you want the exit sections to be treated the same as
> module init, the following patch should stuff any exit sections into the module
> init "region" (completely untested). Hence it should be freed together with the
> init sections and it would identify as init through within_module_init(). Let
> me know if this works for you.

That does indeed seem to DTRT from a quick scan of module.c. Very nice
tidy patch. I was afraid it'd be much worse.

Assuming it actually works; for your Changelog:

"Dynamic code patching (alternatives, jump_label and static_call) can
have sites in __exit code, even it __exit is never executed. Therefore
__exit must be present at runtime, at least for as long as __init code
is.

Additionally, for jump_label and static_call, the __exit sites must also
identify as within_module_init(), such that the infrastructure is aware
to never touch them after module init -- alternatives are only ran once
at init and hence don't have this particular constraint.

By making __exit identify as __init for UNLOAD_MODULE, the above is
satisfied."

Thanks!

> ---
> 
> diff --git a/kernel/module.c b/kernel/module.c
> index 30479355ab85..1c3396a9dd8b 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -2802,7 +2802,11 @@ void * __weak module_alloc(unsigned long size)
> 
>  bool __weak module_init_section(const char *name)
>  {
> -       return strstarts(name, ".init");
> +#ifndef CONFIG_UNLOAD_MODULE
> +       return strstarts(name, ".init") || module_exit_section(name);
> +#else
> +       return strstarts(name, ".init")
> +#endif
>  }
> 
>  bool __weak module_exit_section(const char *name)
> @@ -3116,11 +3120,6 @@ static int rewrite_section_headers(struct load_info *info, int flags)
>                  */
>                 shdr->sh_addr = (size_t)info->hdr + shdr->sh_offset;
> 
> -#ifndef CONFIG_MODULE_UNLOAD
> -               /* Don't load .exit sections */
> -               if (module_exit_section(info->secstrings+shdr->sh_name))
> -                       shdr->sh_flags &= ~(unsigned long)SHF_ALLOC;
> -#endif
>         }
> 
>         /* Track but don't keep modinfo and version sections. */
> 
