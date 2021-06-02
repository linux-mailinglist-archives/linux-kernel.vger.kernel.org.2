Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB4E43991DA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbhFBRo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 13:44:27 -0400
Received: from mail-pj1-f41.google.com ([209.85.216.41]:52010 "EHLO
        mail-pj1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbhFBRoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 13:44:25 -0400
Received: by mail-pj1-f41.google.com with SMTP id k5so2079502pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 10:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ShPxXvSOAqFpgb+RTz9vV7r8VTjJc/BWtAFmiYwez5s=;
        b=oJB2bwyTumxjEThcmTx3LN7QgZZ2pyIWhf90OeZShGUU8lIRhqlgF4pB/VYBU2B/ih
         kzIQsTaI/XY6HpIPhOwHKuzmbQ1VHCpkLYvPNhNAhSWCBfpCmQzmsKAT/ITBUezsVlKU
         4w2vXP+IhtjpfhpR8LWPD2w5KZERWJwZXMris=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ShPxXvSOAqFpgb+RTz9vV7r8VTjJc/BWtAFmiYwez5s=;
        b=H3oxWs0N499P+D9RuIBFtGwTuIYd9flpbxI3IxjpXDMJC+SCzc8C3dUmymlu1zv5jU
         7zvk8Xnj57bbAfcdWNSasNeLHOsk3F9B6RM58daQ/bLL7mPp4xSDHxdl5lTH/rWWwTWH
         18tkmEr9oBk4A0Q1gT6XZh4SOzJfNpDA9tz5wqJ23x5+RPdkwoAQaAZugKjShuw4Dqhj
         aqBBT2khDxiE/fU/a/ItepYRZumOcAtBeKxG7FO+CLT2xjBYJZtVFT6+qoH0egN8NzfD
         yD3cpsu8BPwgiY1nBtp+YlFYZaQB4fIIkbJrM9I3mHtGSWT79X1U/0uG3Ji3iMABzp/D
         TZqg==
X-Gm-Message-State: AOAM530XIXT7PO0ko1tJM4vB9yhAV/71D4EDEdFEUrhuzUb8PcUlWSbY
        4c8iPLfqS+GbYJKr0YLPey2fjA==
X-Google-Smtp-Source: ABdhPJxQ5cleNBqC4gl9XaQIQxW9IbNVMJN3fW0tGd/3o/W3UZ8FraAaESApPvI2607wtWHGfumT2g==
X-Received: by 2002:a17:90b:2250:: with SMTP id hk16mr6487537pjb.95.1622655689709;
        Wed, 02 Jun 2021 10:41:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g19sm225497pfj.138.2021.06.02.10.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jun 2021 10:41:29 -0700 (PDT)
Date:   Wed, 2 Jun 2021 10:41:28 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jarmo Tiitto <jarmo.tiitto@gmail.com>
Cc:     Sami Tolvanen <samitolvanen@google.com>,
        Bill Wendling <wcw@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        morbo@google.com
Subject: Re: [PATCH 1/1] pgo: Fix allocate_node() handling of non-vmlinux
 nodes.
Message-ID: <202106021037.09943A41@keescook>
References: <20210602005702.9650-1-jarmo.tiitto@gmail.com>
 <20210602005702.9650-2-jarmo.tiitto@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602005702.9650-2-jarmo.tiitto@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 03:57:04AM +0300, Jarmo Tiitto wrote:
> Currently allocate_node() will reserve nodes even if *p
> doesn't point into __llvm_prf_data_start - __llvm_prf_data_end
> range.
> 
> Fix it by checking if p points into vmlinux range
> and otherwise return NULL.
> 
> Signed-off-by: Jarmo Tiitto <jarmo.tiitto@gmail.com>
> ---
>  kernel/pgo/instrument.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/pgo/instrument.c b/kernel/pgo/instrument.c
> index 0e07ee1b17d9..9bca535dfa91 100644
> --- a/kernel/pgo/instrument.c
> +++ b/kernel/pgo/instrument.c
> @@ -55,6 +55,10 @@ void prf_unlock(unsigned long flags)
>  static struct llvm_prf_value_node *allocate_node(struct llvm_prf_data *p,
>  						 u32 index, u64 value)
>  {
> +	/* check if p points into vmlinux. If not, don't allocate. */
> +	if (p < __llvm_prf_data_start || p >= __llvm_prf_data_end)
> +		return NULL;

This should be a tighter check (struct llvm_prf_data has size, so just
checking for p < __llvm_prf_data_end isn't sufficient. I recommend using
the memory_contains() helper.

And I think this should be louder as it's entirely unexpected right
now. Perhaps:

	if (WARN_ON_ONCE(!memory_contains(__llvm_prf_data_start,
					  __llvm_prf_data_end,
					  p, sizeof(*p))))
		return NULL;

> +
>  	if (&__llvm_prf_vnds_start[current_node + 1] >= __llvm_prf_vnds_end)
>  		return NULL; /* Out of nodes */
>  
> -- 
> 2.31.1
> 

-- 
Kees Cook
