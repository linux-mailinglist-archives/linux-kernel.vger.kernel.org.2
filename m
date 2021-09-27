Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 848324194F4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 15:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234550AbhI0NU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 09:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbhI0NU6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 09:20:58 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A82C061575
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:19:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y35so18073129ede.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 06:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=TGkYYxYMY9704XpvY0f5AEHt0EkjStSYqCKUbuGu+HA=;
        b=b4wG63MDZjK2m11e8k6xAmyzN38yWDpm5ZjOxm6OyLrntdchH9Pl+ZV1dp9spFZoiv
         X2whDFMFl1TxP9GDNrVD9Vro59sb5pEXMAjAwh9yQ8OqDFmgoal1pc+mcjxZdTt/Kpt4
         cJjP0GLP94JUw65TLWB0hnNYhEFJFznQSP1Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TGkYYxYMY9704XpvY0f5AEHt0EkjStSYqCKUbuGu+HA=;
        b=gKUdjwQTXQJgUf6VuGS7o1qVsPRCsoKNJQkUUpgHwwSJ74efvqoG1gdW6L0RpZTBH0
         5ibN7Kd5PqDclpZsxg4Apl0g2/dDEr5Q9Ki9Lw0ZKWwGM7uaaAxl5/4BbnFvt60ot1QY
         Shwvy3l/g0cXITcxcoZVvTl7kGiJwK+LdJWHW7eJJ+gkHGxe1DYIY4UPW/O75Nfd+JlA
         fEhtzsBBsgO4SSQWF3qkSsFZzxiLEc2uJXYZ2in6tHKroToVJOFSgceNjyBH13ceixqA
         ve7Pig0br9n8r7K34VZL5ITwMUDSH171BUQwd9NuHu0D3THuYTsusPaCuchJRTm5iW0b
         6oUA==
X-Gm-Message-State: AOAM53138vlhpHEfEtSYB3Gj3+uJkUWh2Qp0df81sHXuhVAbnywCXgwt
        7mxdGDUsR75QrRZLNvL4lCRIcw==
X-Google-Smtp-Source: ABdhPJwu3oh//1+a0FRI2G9uEQnHh7+1y4yE8IakxkxjuNBnuw+cVYa4H9XHGCGcdnOTZMGhFC2UkQ==
X-Received: by 2002:a05:6402:1607:: with SMTP id f7mr23223447edv.187.1632748759168;
        Mon, 27 Sep 2021 06:19:19 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6664])
        by smtp.gmail.com with ESMTPSA id p8sm8726489ejo.2.2021.09.27.06.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 06:19:18 -0700 (PDT)
Date:   Mon, 27 Sep 2021 14:19:18 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Jessica Yu <jeyu@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] printk: avoid -Wsometimes-uninitialized warning
Message-ID: <YVHE1qclD6ZyjvvD@chrisdown.name>
References: <20210927125007.1581919-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210927125007.1581919-1-arnd@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

Arnd Bergmann writes:
>From: Arnd Bergmann <arnd@arndb.de>
>
>clang notices that the pi_get_entry() function would use
>uninitialized data if it was called with a non-NULL module
>pointer on a kernel that does not support modules:

On a !CONFIG_MODULES kernel, we _never_ pass a non-NULL module pointer. This 
isn't just convention: we don't even have `struct module` fully fleshed out, so 
it technically cannot be so.

>kernel/printk/index.c:32:6: error: variable 'nr_entries' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>        if (!mod) {
>            ^~~~
>kernel/printk/index.c:38:13: note: uninitialized use occurs here
>        if (pos >= nr_entries)
>                   ^~~~~~~~~~
>kernel/printk/index.c:32:2: note: remove the 'if' if its condition is always true
>        if (!mod) {
>
>Rework the condition to make it clear to the compiler that we are always
>in the second case. Unfortunately the #ifdef is still required as the
>definition of 'struct module' is hidden when modules are disabled.

Having IS_ENABLED and then an #ifdef seems to hurt code readability to me.

>Fixes: 337015573718 ("printk: Userspace format indexing support")

Does this really fix anything, or just clang's ignorance? If the latter, clang 
needs to be smarter here: as far as I can see there are no occasions where 
there's even any opportunity for a non-NULL pointer to come in on a 
!CONFIG_MODULES kernel, since `struct module` isn't even complete.

>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>---
> kernel/printk/index.c | 6 ++----
> 1 file changed, 2 insertions(+), 4 deletions(-)
>
>diff --git a/kernel/printk/index.c b/kernel/printk/index.c
>index d3709408debe..b4d90bab6d4d 100644
>--- a/kernel/printk/index.c
>+++ b/kernel/printk/index.c
>@@ -22,14 +22,12 @@ static struct pi_entry *pi_get_entry(const struct module *mod, loff_t pos)
> 	struct pi_entry **entries;
> 	unsigned int nr_entries;
>
>+	if (IS_ENABLED(CONFIG_MODULES) && mod) {
> #ifdef CONFIG_MODULES
>-	if (mod) {
> 		entries = mod->printk_index_start;
> 		nr_entries = mod->printk_index_size;
>-	}
> #endif
>-
>-	if (!mod) {
>+	} else {
> 		/* vmlinux, comes from linker symbols */
> 		entries = __start_printk_index;
> 		nr_entries = __stop_printk_index - __start_printk_index;
>-- 
>2.29.2
>
