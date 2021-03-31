Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5947A34A15D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 07:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbhCZGDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 02:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbhCZGCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 02:02:51 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24676C0613B0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:02:51 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m7so3881000pgj.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Mar 2021 23:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=Hs9OgF31bMON2rPAD0tIeR6wNV10U38bJiGXIHf5UOw=;
        b=OIUEqK7S1YRl3jUepx5bdUjpwjMzjf1s9/+ifSprr+jrcdJknDJ9DcFvV7/lqoD7vy
         454f8j+EdYyEUe4+8vtnY90vxaz+y44BjNZZ+KxIwikxHnpYodTCmjrkOTR9qs5B8xgL
         zqePz9LzrIFdmsCx0V6Um+qv0rLC7209kDvNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Hs9OgF31bMON2rPAD0tIeR6wNV10U38bJiGXIHf5UOw=;
        b=G1jDONevuBoq5Ov/QHyjjQ76exuggv9p7/nh4EAsI0KUWBn3TYhtag8alKO8YkcyfV
         5pyYxXPRIVGdGocspoEXpQcS40eH7a0ijam0sH9OMLjR5cMHIbZT6AzjcQoA2yLvGrF6
         x8aaI3O2V9bpNdoM7Er+HgOmveJWr0U12m9ApwLPYOznEZDx4CVLgg2CnDKqrIlnp7ek
         tdjJWLYjN3MkkdZXVONLxE05qiuUA8gN46VcL/SAJHFQ4CaPHeewi3dn/fOTlhjOlBDQ
         76971TugzkI+Nh0jsCBTLcB3T2x/CLndNSju4I+zUeepkA70DsXHfyZelZkWNbEPX9iG
         xvHg==
X-Gm-Message-State: AOAM5322khT9kizhjPZ1ZtvZWeqOMwiNHDxi+pbnwVB1KTafMV9n1QDR
        MMqBGKRY1H61nIP4/SAIvoDcNQ==
X-Google-Smtp-Source: ABdhPJyb9vEQTn14Ygn7ph6wsyHte+vZpEhCWA7YO0ZLL4Ybk2CFwm5mHZTO4rXc61h8McUbl0WXPw==
X-Received: by 2002:a63:1303:: with SMTP id i3mr10528838pgl.32.1616738570584;
        Thu, 25 Mar 2021 23:02:50 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-39c5-e677-fdb8-5d64.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:39c5:e677:fdb8:5d64])
        by smtp.gmail.com with ESMTPSA id i7sm7347282pgq.16.2021.03.25.23.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Mar 2021 23:02:50 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Aditya Srivastava <yashsri421@gmail.com>, leitao@debian.org
Cc:     rdunlap@infradead.org, herbert@gondor.apana.org.au, corbet@lwn.net,
        nayna@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, yashsri421@gmail.com,
        pfsmorigo@gmail.com, linux-crypto@vger.kernel.org,
        lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        davem@davemloft.net, paulus@samba.org
Subject: Re: [PATCH] crypto: vmx: fix incorrect kernel-doc comment syntax in files
In-Reply-To: <20210320202525.12562-1-yashsri421@gmail.com>
References: <20210320202525.12562-1-yashsri421@gmail.com>
Date:   Fri, 26 Mar 2021 17:02:47 +1100
Message-ID: <87o8f678qg.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aditya,

Thanks for your patch!

> The opening comment mark '/**' is used for highlighting the beginning of
> kernel-doc comments.
> There are certain files in drivers/crypto/vmx, which follow this syntax,
> but the content inside does not comply with kernel-doc.
> Such lines were probably not meant for kernel-doc parsing, but are parsed
> due to the presence of kernel-doc like comment syntax(i.e, '/**'), which
> causes unexpected warnings from kernel-doc.
>
> E.g., presence of kernel-doc like comment in the header line for
> drivers/crypto/vmx/vmx.c causes this warning by kernel-doc:
>
> "warning: expecting prototype for Routines supporting VMX instructions on the Power 8(). Prototype was for p8_init() instead"

checkpatch (scripts/checkpatch.pl --strict -g HEAD) complains about this line:
WARNING: Possible unwrapped commit description (prefer a maximum 75 chars per line)
but checkpatch should be ignored here, as you did the right thing by not
breaking an error message across multiple lines.

> Similarly for other files too.
>
> Provide a simple fix by replacing such occurrences with general comment
> format, i.e. '/*', to prevent kernel-doc from parsing it.

This makes sense.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

>
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> * Applies perfectly on next-20210319
>
>  drivers/crypto/vmx/aes.c     | 2 +-
>  drivers/crypto/vmx/aes_cbc.c | 2 +-
>  drivers/crypto/vmx/aes_ctr.c | 2 +-
>  drivers/crypto/vmx/aes_xts.c | 2 +-
>  drivers/crypto/vmx/ghash.c   | 2 +-
>  drivers/crypto/vmx/vmx.c     | 2 +-
>  6 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/crypto/vmx/aes.c b/drivers/crypto/vmx/aes.c
> index d05c02baebcf..ec06189fbf99 100644
> --- a/drivers/crypto/vmx/aes.c
> +++ b/drivers/crypto/vmx/aes.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * AES routines supporting VMX instructions on the Power 8
>   *
>   * Copyright (C) 2015 International Business Machines Inc.
> diff --git a/drivers/crypto/vmx/aes_cbc.c b/drivers/crypto/vmx/aes_cbc.c
> index d88084447f1c..ed0debc7acb5 100644
> --- a/drivers/crypto/vmx/aes_cbc.c
> +++ b/drivers/crypto/vmx/aes_cbc.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * AES CBC routines supporting VMX instructions on the Power 8
>   *
>   * Copyright (C) 2015 International Business Machines Inc.
> diff --git a/drivers/crypto/vmx/aes_ctr.c b/drivers/crypto/vmx/aes_ctr.c
> index 79ba062ee1c1..9a3da8cd62f3 100644
> --- a/drivers/crypto/vmx/aes_ctr.c
> +++ b/drivers/crypto/vmx/aes_ctr.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * AES CTR routines supporting VMX instructions on the Power 8
>   *
>   * Copyright (C) 2015 International Business Machines Inc.
> diff --git a/drivers/crypto/vmx/aes_xts.c b/drivers/crypto/vmx/aes_xts.c
> index 9fee1b1532a4..dabbccb41550 100644
> --- a/drivers/crypto/vmx/aes_xts.c
> +++ b/drivers/crypto/vmx/aes_xts.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * AES XTS routines supporting VMX In-core instructions on Power 8
>   *
>   * Copyright (C) 2015 International Business Machines Inc.
> diff --git a/drivers/crypto/vmx/ghash.c b/drivers/crypto/vmx/ghash.c
> index 14807ac2e3b9..5bc5710a6de0 100644
> --- a/drivers/crypto/vmx/ghash.c
> +++ b/drivers/crypto/vmx/ghash.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0
> -/**
> +/*
>   * GHASH routines supporting VMX instructions on the Power 8
>   *
>   * Copyright (C) 2015, 2019 International Business Machines Inc.
> diff --git a/drivers/crypto/vmx/vmx.c b/drivers/crypto/vmx/vmx.c
> index a40d08e75fc0..7eb713cc87c8 100644
> --- a/drivers/crypto/vmx/vmx.c
> +++ b/drivers/crypto/vmx/vmx.c
> @@ -1,5 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
> -/**
> +/*
>   * Routines supporting VMX instructions on the Power 8
>   *
>   * Copyright (C) 2015 International Business Machines Inc.
> -- 
> 2.17.1
