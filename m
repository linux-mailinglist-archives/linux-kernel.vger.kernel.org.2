Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFCEC35EB39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 05:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345658AbhDNDEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 23:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232009AbhDNDEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 23:04:36 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E81C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:04:14 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id e2so5003013plh.8
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 20:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YWlsnRSOQekuHI1nza1U/2ONG9pe3JCImgoC6OaquBA=;
        b=SXne9fh7omzAovHAQzanO8IhZ+//SWUNB4MkMEe45uUU0sYUSnLRltlNBuIBK9eJlf
         Lo9tasW+hDySRqLO+7tjixOAq7WnIPilXo10FJ+REohcVhguthzmHH5Vmw8qEU6RfDEr
         knc6b7AI/dgbzjUCvBUq8PM8SlyLWvzuvEKXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YWlsnRSOQekuHI1nza1U/2ONG9pe3JCImgoC6OaquBA=;
        b=JdKyBzcxB6OjwzCCTGh3fdFbgHFjHL/Wo8IBK5KHbWBFyL88DSuCB/uCZE7a1KcMUF
         tHdzNBc2Jrkm5clYVuwmqGVIfjnR16Vw+MP7xgPXqKEPOgI9o1HYt9fM/S3v7SytZKWV
         f/+XEVfNIGEYkyMXn4bmM/Zzt0eLV8TV/h62lAjR2wclfj9m2oVneI2R74AKUz6L1Y+y
         Uuy3b7sJW3PNlxb0VsJuP1xN7pNSYdaWUVYbm+EcpOaUvT4y+ZeVMcPHzRmirN67bFEo
         sz1zPIC5CVyH1qTjHpDy1YFV0aBzSmcNIGb/QbN4pPpU9ThspJBrlj7DZ65PRFzPZ1rF
         ZR4Q==
X-Gm-Message-State: AOAM532CVu+Nptbb+5ibkL175uupy7BAOytbGnLXrsNSU+hP5W0TZUho
        Vvt1K6OSddU06TdmWqdvilrMXg==
X-Google-Smtp-Source: ABdhPJwsrb7nChofgZXy5qyqkooUJJDW3SUr838kF2MWEpNvljqx4WE8BGxk1sgcKKBpjL0Nznrz3Q==
X-Received: by 2002:a17:90b:e0b:: with SMTP id ge11mr1038370pjb.127.1618369454295;
        Tue, 13 Apr 2021 20:04:14 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d4sm3408238pjs.1.2021.04.13.20.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 20:04:13 -0700 (PDT)
Date:   Tue, 13 Apr 2021 20:04:12 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 6/7] i915: Convert to verify_page_range()
Message-ID: <202104132002.F03F8616DA@keescook>
References: <20210412080012.357146277@infradead.org>
 <20210412080611.902470568@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210412080611.902470568@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2021 at 10:00:18AM +0200, Peter Zijlstra wrote:
> check_{present,absent}() only need R/O access, use verify_page_range()
> instead to remove modular use of apply_to_page_range().
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> --- a/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
> +++ b/drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c
> @@ -1225,9 +1225,9 @@ static int igt_mmap_gpu(void *arg)
>  	return 0;
>  }
>  
> -static int check_present_pte(pte_t *pte, unsigned long addr, void *data)
> +static int check_present_pte(pte_t pte, unsigned long addr, void *data)
>  {
> -	if (!pte_present(*pte) || pte_none(*pte)) {
> +	if (!pte_present(pte) || pte_none(pte)) {
>  		pr_err("missing PTE:%lx\n",
>  		       (addr - (unsigned long)data) >> PAGE_SHIFT);
>  		return -EINVAL;
> @@ -1236,9 +1236,9 @@ static int check_present_pte(pte_t *pte,
>  	return 0;
>  }
>  
> -static int check_absent_pte(pte_t *pte, unsigned long addr, void *data)
> +static int check_absent_pte(pte_t pte, unsigned long addr, void *data)
>  {
> -	if (pte_present(*pte) && !pte_none(*pte)) {
> +	if (pte_present(pte) && !pte_none(pte)) {
>  		pr_err("present PTE:%lx; expected to be revoked\n",
>  		       (addr - (unsigned long)data) >> PAGE_SHIFT);
>  		return -EINVAL;
> @@ -1249,14 +1249,14 @@ static int check_absent_pte(pte_t *pte,
>  
>  static int check_present(unsigned long addr, unsigned long len)
>  {
> -	return apply_to_page_range(current->mm, addr, len,
> -				   check_present_pte, (void *)addr);
> +	return verify_page_range(current->mm, addr, len,
> +				 check_present_pte, (void *)addr);
>  }

And this would be:

static int check_present(unsigned long addr, unsigned long len)
	unsigned long fail;

	fail = verify_page_range(current->mm, addr, len, check_present_pte);
	if (fail) {
  		pr_err("missing PTE:%lx\n", addr);
		return -EINVAL;
	}
}

(Oh, and I think I messed up the page shifting macro name in the earlier
one...)


-- 
Kees Cook
