Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11830410F63
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 07:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbhITF7i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 01:59:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhITF7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 01:59:36 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A336C061760
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 22:58:10 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id v2so10294293plp.8
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 22:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+0o34hX5+MHO24oI1veVFWolKS99D91CBQbJfAxR2ho=;
        b=L2q62tfvMM8cZq0HwyyDu/pq8OD1J2L/NO/fg5svc0KNLSZwoJjazHFrWLdQpcPO+U
         0QffmXYHmZRPE+B/9+FAVwozUNgpPamL+d2uN7j7xK6zK03tlP1PJC6C+UAu6fzp550G
         AseKUemDSOsLnYnzHygW5wZcpjJZ9pjeXI548=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+0o34hX5+MHO24oI1veVFWolKS99D91CBQbJfAxR2ho=;
        b=GWc8rly8dYR/Z3bmx6SBNuYzPJ1aSoLZIX6/BMgNmE5Xk9Jr6nXUX3lj30KeIjdrTk
         1K8ngvCKwQFt79XGxt2YlZKdJzlr0FROHr6QFdXq91K/WijauF93VFDcW9IOqvV1tOWg
         hJCu8WjtL95rVpP6Ys5igBelJyQR2muu0iRomk+fW0CqEHWQULPU9l3kneHY9FlTPKXl
         Al/mG5iGoMr4Y69deI020j0mgvKvzUySa4Ey9KNIvJt3Xn/yXh8Nj4picIHNDPYji4mn
         iXMBFBsmdTjsdcPYDyrckaz0PT477RfEWTYrf3IoIe2XIvSdwNffCEfw0/EQi4f7vvh3
         pftw==
X-Gm-Message-State: AOAM530MbfQ6uHqAfIrmlC5SQ9DCBM0KIOz7Lr7CVKKDMfq9wUtHESWC
        GoG0swTn7XywLitwahf9miAaiPrHFi61fg==
X-Google-Smtp-Source: ABdhPJwnPpSYE6Badmmc/9HPD2wDyj/8JaCgZR5rFgaa7XH92xlYaf/hrtS+JDGvq+hYL0r5/Udl1g==
X-Received: by 2002:a17:90a:bb09:: with SMTP id u9mr27240755pjr.165.1632117489284;
        Sun, 19 Sep 2021 22:58:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id e7sm3467279pfc.114.2021.09.19.22.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 22:58:08 -0700 (PDT)
Date:   Sun, 19 Sep 2021 22:58:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Len Baker <len.baker@gmx.com>
Cc:     Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Prefer struct_size over
 open coded arithmetic
Message-ID: <202109192246.B438B42EF@keescook>
References: <20210918150500.21530-1-len.baker@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210918150500.21530-1-len.baker@gmx.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 18, 2021 at 05:05:00PM +0200, Len Baker wrote:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
> 
> So, switch to flexible array member in the struct attribute_set_obj and
> refactor the code accordingly to use the struct_size() helper instead of
> the argument "size + count * size" in the kzalloc() function.
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments
> 
> Signed-off-by: Len Baker <len.baker@gmx.com>
> ---
>  drivers/platform/x86/thinkpad_acpi.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> index 50ff04c84650..ed0b01ead796 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -1008,7 +1008,7 @@ struct attribute_set {
> 
>  struct attribute_set_obj {
>  	struct attribute_set s;
> -	struct attribute *a;
> +	struct attribute *a[];
>  } __attribute__((packed));

Whoa. I have so many questions... :)

> 
>  static struct attribute_set *create_attr_set(unsigned int max_members,
> @@ -1020,13 +1020,11 @@ static struct attribute_set *create_attr_set(unsigned int max_members,
>  		return NULL;
> 
>  	/* Allocates space for implicit NULL at the end too */
> -	sobj = kzalloc(sizeof(struct attribute_set_obj) +
> -		    max_members * sizeof(struct attribute *),
> -		    GFP_KERNEL);
> +	sobj = kzalloc(struct_size(sobj, a, max_members + 1), GFP_KERNEL);

Whoa, this needs a lot more detail in the changelog if this is actually
correct. The original code doesn't seem to match the comment? (Where is
the +1?) So is this also a bug-fix?

(I see the caller uses +2? Why? It seems to be using each of hotkey_attributes,
plus 1 more attr, plus a final NULL?)

>  	if (!sobj)
>  		return NULL;
>  	sobj->s.max_members = max_members;
> -	sobj->s.group.attrs = &sobj->a;
> +	sobj->s.group.attrs = sobj->a;
>  	sobj->s.group.name = name;

The caller also never sets a name?

Why is struct attribute_set_obj marked as __packed?

> 
>  	return &sobj->s;
> --
> 2.25.1
> 

-- 
Kees Cook
