Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7DB377ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 05:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhEJDrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 May 2021 23:47:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbhEJDri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 May 2021 23:47:38 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1773FC061573
        for <linux-kernel@vger.kernel.org>; Sun,  9 May 2021 20:46:33 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 10so12824930pfl.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 May 2021 20:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Jld4DKjBPzAzH7/qJhoedPeTLTKVP/GYejO0dGLt3lY=;
        b=gHFtNq79FVRgIAkg4x8LAJiAGBNODW/t/ytvxWvjgOO6qr38H6c1ZDgk/1C9UECmeI
         QmNDAzBawT1UMHxR8wq4KWLiRoCQemJVpTK2wMvlTIM+YNpclOQQTQqP5Sw2V0kJHY17
         dF51tBIyQV62akSzIwWIGxG0VdxyAOTHqdSNQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Jld4DKjBPzAzH7/qJhoedPeTLTKVP/GYejO0dGLt3lY=;
        b=m2Lx6IyG0n+WetIWYiL0wGavTb7I407udOD/bDjKAkckBOFIHLCxAGWgSW89D4/lfn
         J+gBPFsJ/yKGih3Ee0N5hj4f8z1IOlef3Grl6ZgqsBwIVWm58es61+vbH/Ix9nhGHg79
         N+/V8CJhlTGQqS1HO7u0u5B42r9DKvd0FhJdH+waDb2ATwRZPA+KGpgYatueoKXBAHES
         QBFTiJGsHcIiN0WpG6BPLh3Hyo8qHHkBX+/2SXvZWjjqRZTwsZwZZY0RnASyn6KY223C
         d1CU1cOz1UYN5WKY2/5nHjS+ZpZ2K2zgT0j0v601qtfABY2Mv7wPSMV99L4uqR6p8K0D
         GNhg==
X-Gm-Message-State: AOAM530S9cbT7yng6za9I9dHzhlL1f9ERjrlF8qnq/yN3+L4TkWy8SBD
        jLRn+UCSCkat1k1+eVEwRX5FvQ==
X-Google-Smtp-Source: ABdhPJwGfFgGtAmJ1netLqZooHZSFIoE2i5WHF3GZKv3PgJtOGcGaYSHMGZeRTmsMst6PgNY7yZPZA==
X-Received: by 2002:a63:b247:: with SMTP id t7mr9740503pgo.408.1620618392550;
        Sun, 09 May 2021 20:46:32 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:f055:559a:ad7f:e975])
        by smtp.gmail.com with ESMTPSA id dw18sm17847469pjb.36.2021.05.09.20.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 May 2021 20:46:31 -0700 (PDT)
Date:   Mon, 10 May 2021 12:46:24 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Jia He <justin.he@arm.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ftp.linux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC 2/3] lib/vsprintf.c: make %pD print full path for file
Message-ID: <YJiskAS4WivETLC9@google.com>
References: <20210508122530.1971-1-justin.he@arm.com>
 <20210508122530.1971-3-justin.he@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210508122530.1971-3-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/05/08 20:25), Jia He wrote:
> +++ b/lib/vsprintf.c
> @@ -27,6 +27,7 @@
>  #include <linux/string.h>
>  #include <linux/ctype.h>
>  #include <linux/kernel.h>
> +#include <linux/dcache.h>
>  #include <linux/kallsyms.h>
>  #include <linux/math64.h>
>  #include <linux/uaccess.h>
> @@ -923,10 +924,17 @@ static noinline_for_stack
>  char *file_dentry_name(char *buf, char *end, const struct file *f,
>  			struct printf_spec spec, const char *fmt)
>  {
> +	const struct path *path = &f->f_path;
> +	char *p;
> +	char tmp[128];

This doesn't look ideal. Why 128 bytes and why on the stack?
