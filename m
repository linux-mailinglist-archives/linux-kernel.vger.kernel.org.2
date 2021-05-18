Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 145EE387AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 16:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349793AbhEROJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 10:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349790AbhEROJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 10:09:05 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6051EC061573
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:07:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r12so10410167wrp.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mK7d6oGFkXGXXI408kRUskU6kfH3r2iCF2LbWFRKjEo=;
        b=fG6R6/nJf0NcYu3xjatUO7NpsA+m68YbzkmBiOz4ECgF212/GaHRoNL/XMlRtgpa/5
         LroRcJGSyjrdC6UUo/3tNtApVifURGqoJFbmelwWx7DYevwCS68GBCzwOzKGZDZTSxp9
         2tcKutUpV4euvQHVCdQnK8rbJHdtNAfueRDC8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mK7d6oGFkXGXXI408kRUskU6kfH3r2iCF2LbWFRKjEo=;
        b=evS1tUwKKdZZ39emPVW/GTjuIpuBzZ8EGZON/NcRhJzMs8R2WV4RfOFpwKqHXeoMqN
         wDS2Vqej/YrHQ/CaIEVkDgt0K4xzRpXvKSSLBi0t3sDTW77RSn2KEiSXVsYftNGb1Zdg
         ZeOEKCJipBDNCtqbocggnzLawTPq0MkTkZ4MGCCu2p3Rs3D4OUiPwgsfQANrh0eViypY
         TQnw/nPjJ+g2ejNwoYC4sDywGvjjYB2vcJ/VqodpVgakEiyobpJbVs1Nk+Bn9BPp0Do6
         KTKlL1wvxGsPxzEBwU34nBK9BHWKtHfuOA0bgL6WBbXPV2L3g7mmntZ5k6RpNyFdicl+
         iJOw==
X-Gm-Message-State: AOAM530Gl3O9DKNuKx3KC4GgpE6AiQQjqGMYA2LNZ+hNaKn7kuIPYzX8
        C5BZA3IBY29RV5L2D0CpXNkIxw==
X-Google-Smtp-Source: ABdhPJzcP3UiXevuXLMg+u9PE7dLnBAGBOaf6hodAjE9rAwCW1e4Qzfu9wB5HHNksGXC0b6uHITEbQ==
X-Received: by 2002:a5d:5049:: with SMTP id h9mr7428369wrt.24.1621346865098;
        Tue, 18 May 2021 07:07:45 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:5c4a])
        by smtp.gmail.com with ESMTPSA id o1sm2686082wmc.6.2021.05.18.07.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 07:07:44 -0700 (PDT)
Date:   Tue, 18 May 2021 15:07:44 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Petr Mladek <pmladek@suse.com>,
        Jessica Yu <jeyu@kernel.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Kees Cook <keescook@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, kernel-team@fb.com
Subject: Re: [PATCH v6 3/4] printk: Userspace format indexing support
Message-ID: <YKPKMCNz2hccaXfR@chrisdown.name>
References: <cover.1621338324.git.chris@chrisdown.name>
 <05d25c65d3f5149c1e8537f74041a7a46bd489d6.1621338324.git.chris@chrisdown.name>
 <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <YKPBk+7lTzs8WFAk@smile.fi.intel.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Andy,

Thanks for the detailed feedback! All points not explicitly replied to here are 
acked and will be improved. :-)

Andy Shevchenko writes:
>> +static const char *pi_get_module_name(struct module *mod)
>> +{
>> +	return mod ? mod->name : "vmlinux";
>
>First of all, you have several occurrences of the "vmlinux" literal.
>Second, can't you get it from somewhere else? Is it even guaranteed that the
>name is always the same?

Hmm, I don't know if it's guaranteed, but we already have similar logic in (as 
one example) livepatch, which seems to suggest it's not obviously wrong:

     % grep -R '"vmlinux"' kernel/livepatch/
     kernel/livepatch/core.c:                       sympos, name, objname ? objname : "vmlinux");
     kernel/livepatch/core.c:        bool sec_vmlinux = !strcmp(sec_objname, "vmlinux");
     kernel/livepatch/core.c:                sym_vmlinux = !strcmp(sym_objname, "vmlinux");
     kernel/livepatch/core.c:        if (strcmp(objname ? objname : "vmlinux", sec_objname))
     kernel/livepatch/core.c:        name = klp_is_module(obj) ? obj->name : "vmlinux";
     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
     kernel/livepatch/core.c:                                klp_is_module(obj) ? obj->name : "vmlinux");
     kernel/livepatch/core.c:        if (!strcmp(mod->name, "vmlinux")) {

Is there another name or method you'd prefer? :-)

As for the literals, are you saying that you prefer that it's symbolised as a 
macro or static char, or do you know of an API where this kind of name can be 
canonically accessed?

>> +#define seq_escape_printf_format(s, src) \
>> +	seq_escape_str(s, src, ESCAPE_ANY | ESCAPE_NAP | ESCAPE_APPEND, "\"\\")
>
>Hmm... But after your ESCAPE_SPECIAL update why " is in @only?
>Not sure about back slash either.

Good question! It's because ESCAPE_NAP (used to reduce scope of ESCAPE_OCTAL) 
will cause double quote and backslash to be ignored for quoting otherwise, even 
with ESCAPE_SPECIAL from ESCAPE_ANY.

I touched on this briefly in the changelog for the patch adding the quote to 
ESCAPE_SPECIAL:

 From "string_helpers: Escape double quotes in escape_special":
> One can of course, alternatively, use ESCAPE_APPEND with a quote in
> @only, but without this patch quotes are coerced into hex or octal which
> can hurt readability quite significantly.

Maybe you know of a more intuitive way to deal with this? :-)

>> +static int __init pi_init(void)
>> +{
>> +	struct dentry *dfs_root = debugfs_create_dir("printk", NULL);
>> +
>> +	dfs_index = debugfs_create_dir("index", dfs_root);
>> +	pi_setup_module_notifier();
>> +	pi_create_file(NULL);
>> +
>> +	return 0;
>> +}
>
>No __exit? (There is a corresponding call for exit)

Hmm, can't printk only be built in to the kernel, so it can't be unloaded? At 
least it looks that way from Kconfig. Maybe I'm missing something and there's 
some other way that might be invoked?

Thanks a lot for the feedback! :-)
