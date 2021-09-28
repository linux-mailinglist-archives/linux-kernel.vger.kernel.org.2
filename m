Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C8741ACC6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 12:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240177AbhI1KTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 06:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240169AbhI1KTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 06:19:10 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F51C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:17:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id b26so32869288edt.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 03:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qy/OhkG7/nBN/uH+Xm8mLuhr2toXlD8zRFmyBJAngNk=;
        b=n4R/gO+WpLz/LARVBdI+rPe42jV5ePxKm7MKiEnEa2dA+0AuYCow8Hxg860n7OVWoi
         78Hsl0SMnL5f1vjqdAz2mhEENPF5/usDuSZW+qoJ2dy9aQTIcI7ov4e211r/gyt4ZaZa
         SaEyhxsCzQ8/nivCEy80UNOa2P40ovsbNCCp0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qy/OhkG7/nBN/uH+Xm8mLuhr2toXlD8zRFmyBJAngNk=;
        b=xCsGlwk/ZJBO3OaO8DB6/PyID2Gr4giLKND1qcwZ9pTG4XEjsS9wByqHLhMn93uE8I
         tFZB7G1xey6AdZSO/YXWhroGduzBbvRg17rkZgJT5abWRPyIydaoBrdlWwA3amOig/Pf
         6LRTKbd7ldyLaPNM8iwjy4V9Ht39a1Bbyj7NMm3GDPG4eEZKlL/RKTfolS3rmCf1kjA3
         KCBPZt4GSv8ufaCHL8kUN58FxZy20P0v4h2bhmGy1Zvn3rMfjC98sW7R7p9qg2iifSDe
         cgbva57+ESKg8ZuzpJPUx9AfezHYxOqDko3PzDtykBCdCwT8m3x0N3u3JelfrVGZYqUG
         4KAg==
X-Gm-Message-State: AOAM530On6iBaVoKG2Cw5N69jC8vMpx6XPLVSGz/tILVAXCb/HYqDf4X
        K7CGnOAOKcvzw7f9zm5lMEAV2Q==
X-Google-Smtp-Source: ABdhPJy6NZ0BOuVQI1vFfC17Astd6UY/xUNYmy6YlAYEbVdMM3i5Z9Zhg0B+6qxSU9rwMZ9G3PtGCw==
X-Received: by 2002:a50:bf07:: with SMTP id f7mr6555611edk.288.1632824247838;
        Tue, 28 Sep 2021 03:17:27 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6664])
        by smtp.gmail.com with ESMTPSA id l18sm12788934edw.78.2021.09.28.03.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 03:17:27 -0700 (PDT)
Date:   Tue, 28 Sep 2021 11:17:26 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Ogness <john.ogness@linutronix.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        YueHaibing <yuehaibing@huawei.com>, Jessica Yu <jeyu@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] [v2] printk: avoid -Wsometimes-uninitialized warning
Message-ID: <YVLrttKajDU+1ZvX@chrisdown.name>
References: <20210928093456.2438109-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210928093456.2438109-1-arnd@kernel.org>
User-Agent: Mutt/2.1.3 (987dde4c) (2021-09-10)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:
>From: Arnd Bergmann <arnd@arndb.de>
>
>clang notices that the pi_get_entry() function would use
>uninitialized data if it was called with a non-NULL module
>pointer on a kernel that does not support modules:
>
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
>
>Fixes: 337015573718 ("printk: Userspace format indexing support")

This changelog should make it clear that this is theoretical and will never 
actually happen, which is salient information for people who are considering 
whether it should go in stable or similar.

>Suggested-by: Steven Rostedt <rostedt@goodmis.org>
>Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>--
>v2: use a simpler trick of having an 'else' in the #ifdef
>    block, as Steven suggested.
>---
> kernel/printk/index.c | 5 ++---
> 1 file changed, 2 insertions(+), 3 deletions(-)
>
>diff --git a/kernel/printk/index.c b/kernel/printk/index.c
>index d3709408debe..43b45a916ff6 100644
>--- a/kernel/printk/index.c
>+++ b/kernel/printk/index.c
>@@ -26,10 +26,9 @@ static struct pi_entry *pi_get_entry(const struct module *mod, loff_t pos)
> 	if (mod) {
> 		entries = mod->printk_index_start;
> 		nr_entries = mod->printk_index_size;
>-	}
>+	} else
> #endif
>-
>-	if (!mod) {
>+	{
> 		/* vmlinux, comes from linker symbols */
> 		entries = __start_printk_index;
> 		nr_entries = __stop_printk_index - __start_printk_index;
>-- 
>2.29.2
>
