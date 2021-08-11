Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03B753E97E5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 20:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbhHKSrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 14:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhHKSrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 14:47:09 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18402C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:46:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id bo18so5055954pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 11:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vOZG0OEfM0tv6Sw0R2J+EgowlzGBirTXpSTC5NMiahE=;
        b=dz+0H/uG3sxVCZ77L/3Fy/0c3pkMSXsydjkbMmnvSb/8mCI/+OtS/Ddpn5ZFZa1dn2
         Z/ZH/tckXjueW+wR6NR3bPUWtxTQHnjCDxcfRhVuwWl4Kvq4K0s53QxT1jCL5S8wZ/iZ
         ZxErOSUwSGJfivNTYUHsXzJwpfRXBzBLJiWJw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vOZG0OEfM0tv6Sw0R2J+EgowlzGBirTXpSTC5NMiahE=;
        b=e+86Ek/qM/w2CG1AUTY3t1ChnhmmJ1zaAEcNOXHdKvLeRbfUjnizwaoS1GN8e4f+W/
         YJxyYstiSuA1HSFq1TeocPg/oRr6Z5nbHsxwzKN8bu9lVIdLEWZrzmzdK18YiyUnFlSe
         NEWfkBL6x76RRkFw4cwBB5jicDvxryPmzMK7bGFFzoIJBjsNkHv4JrmqFcPZVDZKyH34
         4WjBLBDllHoDqxRZ12OOQturdIogd0dzaKZwjpzZrcglssJx/pGCDixzcraVZfyAVRTd
         0uDto3i8/fFBniTEMA1ffXxS0X366HpyPt74TxXWmm0uNMUPheP0Gigon7Ft60XscoHQ
         qdUw==
X-Gm-Message-State: AOAM530BYNEhocIEQlp+HaGJT8eARJBo8e89Ki9KPpyFp0seEqn6A4SN
        r9odta1Bkf1sqRyZt6GvSn/AZg==
X-Google-Smtp-Source: ABdhPJx/17F1PdG/d53EEGcCSXX5cLU1gIv+TlqNPkUy4Ihq9mZSt6wEBbvRhp1Gk5+lk+LAR8rXpQ==
X-Received: by 2002:a17:902:7c01:b029:12c:25f:be9e with SMTP id x1-20020a1709027c01b029012c025fbe9emr258137pll.75.1628707605655;
        Wed, 11 Aug 2021 11:46:45 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s23sm230133pfg.208.2021.08.11.11.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 11:46:45 -0700 (PDT)
Date:   Wed, 11 Aug 2021 11:46:44 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Wiktor Garbacz <wiktorg@google.com>
Cc:     Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        Hsuan-Chi Kuo <hsuanchikuo@gmail.com>
Subject: Re: [PATCH] seccomp: Fix setting number of loaded filters
Message-ID: <202108111144.3519134B5@keescook>
References: <20210810125158.329849-1-wiktorg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210810125158.329849-1-wiktorg@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 10, 2021 at 02:51:58PM +0200, Wiktor Garbacz wrote:
> The value is only reported through procfs so this
> is purely cosmetic.

Hi,

Thanks for the patch! I thought this had already been fixed, but I see I
dropped the ball. :( Sorry!

I'll get the original fix landed[1], and add you as a reporter.

Out of curiosity, how did you (or Hsuan-Chi Kuo) find this? Broken
behavior, code reading, static analysis?

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/20210304233708.420597-1-hsuanchikuo@gmail.com/

> 
> Signed-off-by: Wiktor Garbacz <wiktorg@google.com>
> ---
>  kernel/seccomp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 057e17f3215d..6469eca8078c 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -602,7 +602,7 @@ static inline void seccomp_sync_threads(unsigned long flags)
>  		smp_store_release(&thread->seccomp.filter,
>  				  caller->seccomp.filter);
>  		atomic_set(&thread->seccomp.filter_count,
> -			   atomic_read(&thread->seccomp.filter_count));
> +			   atomic_read(&caller->seccomp.filter_count));
>  
>  		/*
>  		 * Don't let an unprivileged task work around
> -- 
> 2.32.0.605.g8dce9f2422-goog
> 

-- 
Kees Cook
