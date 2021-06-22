Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F813B0E7D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 22:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbhFVUUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 16:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFVUUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 16:20:45 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B174C061574
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:18:28 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id g192so461104pfb.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jun 2021 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HdvopMyQxXmK6HPWxf4Yo9uu2sK2aSj8ONTZ5GQmBlE=;
        b=lykzsAZUsF7cGv2D7gjRam0ECumyQaD2Htt10ideOeN+EqAc7hmZdTiNvkjakyUld+
         n9okSL9ElUt+Wm/M6PNhVAhwLNxUBmh5Hz+dNLCqPIFzZIVhr31GUP/DJIWz0z3Ad7hE
         +QutgZaZET9RK2PYaolTYHb475wpaaEuYYbr1LoSj0FqPYaDRXfM9vCVl4VtEH4OE/S5
         cGY8UGCubMijCzvpP1Vf3C9N8lOfP1pR1Mw8pKFfGaiXzVJ2SfQaaR+7GbD3vT5//gtK
         e778+wcH617Iwt4UfKWte53juenhGaSLJDGLFcdheMud9ls7zllo5YPFD69QNSsiatih
         kvfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HdvopMyQxXmK6HPWxf4Yo9uu2sK2aSj8ONTZ5GQmBlE=;
        b=qmdxmhftNSBs3vav+DONg0cOqFGvNwos9SrrnmarhL+1Kocu1i5VfPxaDWSjtNJlmw
         A/HrJNhYDcGimC42QfploVBU32VYWB0QFUN08y+2Q5y6u5+4UC8HfNKTDMIaNh4X+iUi
         CDhU4H7bPZbbiU1ROpXb1MYMhfLZo67EcHq2XgJUAjp+i0XgUKvOhX1iBCNZuJlqk4Z8
         jnb2gwImrUL9iruAqMe7LbIYTfO3gx7oc9S0z0bErDNnnQFkH0pWQTXCSUI7xWHWv7A6
         KHU1Oy7IVqlAhFTGif8yp+xJkg/rLiY0HD2kdsEiMQ9DRVUd9BNt8r/pmaCYHYCE3I6v
         vzjg==
X-Gm-Message-State: AOAM533FPkwL8s2i7L7p/RKRSdOd6PmD07YpvZMhN0SKLeH6/IyfWroA
        UdZPIlcMs1qFxYjwMBU2dye84Q==
X-Google-Smtp-Source: ABdhPJz7rYIoO6sWqSb4qylMzSqfWXaD89CLCbZ4g/7JKmY0IHSxAtjYc0zUCAFst0M4hzvoHPv/qA==
X-Received: by 2002:a63:64d:: with SMTP id 74mr384039pgg.13.1624393107639;
        Tue, 22 Jun 2021 13:18:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:632e:2fa3:1554:f07c])
        by smtp.gmail.com with ESMTPSA id f5sm170927pfe.79.2021.06.22.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 13:18:27 -0700 (PDT)
Date:   Tue, 22 Jun 2021 13:18:22 -0700
From:   Fangrui Song <maskray@google.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, "KE . LI" <like1@oppo.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Miroslav Benes <mbenes@suse.cz>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] kallsyms: strip LTO suffixes from static functions
Message-ID: <20210622201822.ayavok3d2fw3u2pl@google.com>
References: <20210622183858.2962637-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20210622183858.2962637-1-ndesaulniers@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-22, 'Nick Desaulniers' via Clang Built Linux wrote:
>Similar to:
>commit 8b8e6b5d3b01 ("kallsyms: strip ThinLTO hashes from static
>functions")
>
>It's very common for compilers to modify the symbol name for static
>functions as part of optimizing transformations. That makes hooking
>static functions (that weren't inlined or DCE'd) with kprobes difficult.
>
>Full LTO uses a different mangling scheme than thin LTO; full LTO
>imports all code into effectively one big translation unit. It must
>rename static functions to prevent collisions. Strip off these suffixes
>so that we can continue to hook such static functions.

See below. The message needs a change.

I can comment on the LTO side thing, but a maintainer needs to check
about the kernel side logic.

Reviewed-by: Fangrui Song <maskray@google.com>

>Reported-by: KE.LI(Lieke) <like1@oppo.com>
>Tested-by: KE.LI(Lieke) <like1@oppo.com>
>Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
>---
> kernel/kallsyms.c | 18 ++++++++++++++++++
> 1 file changed, 18 insertions(+)
>
>diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
>index 4067564ec59f..14cf3a6474de 100644
>--- a/kernel/kallsyms.c
>+++ b/kernel/kallsyms.c
>@@ -188,6 +188,24 @@ static inline bool cleanup_symbol_name(char *s)
>
> 	return res != NULL;
> }
>+#elif defined(CONFIG_LTO_CLANG_FULL)
>+/*
>+ * LLVM mangles static functions for full LTO so that two static functions with
>+ * the same identifier do not collide when all code is combined into one
>+ * module. The scheme used converts references to foo into
>+ * foo.llvm.974640843467629774, for example. This can break hooking of static
>+ * functions with kprobes.
>+ */

The comment should say ThinLTO instead.

The .llvm.123 suffix is for global scope promotion for local linkage
symbols. The scheme is ThinLTO specific. This ensures that a local
linkage symbol, when imported into multiple translation units, then
compiled into different object files, during linking, the copies can be
deduplicated. This matters for code size and for correctness when the
function address is taken.

Regular LTO (sometimes called full LTO) uses the regular name.\d+
scheme.

>+static inline bool cleanup_symbol_name(char *s)
>+{
>+	char *res;
>+
>+	res = strstr(s, ".llvm.");
>+	if (res)
>+		*res = '\0';
>+
>+	return res != NULL;
>+}
> #else
> static inline bool cleanup_symbol_name(char *s) { return false; }
> #endif
>-- 
>2.32.0.288.g62a8d224e6-goog

I wonder whether it makes sense to strip all `.something` suffixes.
For example, the recent -funique-internal-linkage-name (which can
improve sample profile accuracy) uses the `.__uniq.1234` scheme.

Function specialization/clones can create arbitrary `.123` suffixes.

>-- 
>You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
>To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
>To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20210622183858.2962637-1-ndesaulniers%40google.com.
