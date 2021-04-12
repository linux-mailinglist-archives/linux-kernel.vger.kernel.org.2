Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7A235D1BF
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 22:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237018AbhDLUJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 16:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237247AbhDLUI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 16:08:59 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013C8C061574
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:08:41 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id k21so995768pll.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 13:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Bn1v8weQCAphlvQ2nM+cq8dnXhBumoE40YxXGULtULQ=;
        b=CpjlAH7Ye2g+AXc5oigkyHtOnUNSSWCic8/dc1mTorgE/ym0laLcE3728KKNMBi4S1
         xgp1w4MsZ1MNDzcncqY4HfknPHwxpIoJ9ZQZsGYKRzxxxVMXbf72LTCflLWCQfkdO0p/
         KH436pTfgTCP/y5s95xqU6T3MXGQQOloo2beM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Bn1v8weQCAphlvQ2nM+cq8dnXhBumoE40YxXGULtULQ=;
        b=MmU7K1xo5MLRD+JmclRQZBr9a9hMHVWLrtUjhGQ6VWkUehnlW1R7jY5ZAi1YW4jMyO
         /mZXICRGNNpY5lxte/i4I1tM0OILj26I1fkW2KBP7a1+pS5vYOXRsFtcDsQ2zrihQ87O
         3lc8h2FSPpYtIbdQZL3BycFpkR/+Hq0QhaijOcayhxeNkTKF2GvVk5Dd08WVafl7JW6J
         ITA4P2lls/GGBptuWg8fcv8w114ZJwIwf9e+ae5Gqry3LueT0cqa6deb9hqdQ2kRdW8f
         qa0FkDW9Vu+Zglk5CalLSFOL+r3n12wQkwL5GkqR8P44sIXx5T0k91JTTzqWWsRh6WIp
         AI3w==
X-Gm-Message-State: AOAM533Y7Q7DpOCuBQRamO6xnQQemsjGNA0smTlwBD3Wn9n+0H5hT18Y
        A8eFwcMgN1LdyQjOdfRtA3UIAw==
X-Google-Smtp-Source: ABdhPJzyB/+5iJRCnS7BNuWsoTebOn4RtTSF+akuP7MK8gjMLNkMyY7+nAJxYt0IjiolcskY6F8FhQ==
X-Received: by 2002:a17:902:7c0b:b029:eb:24a:1209 with SMTP id x11-20020a1709027c0bb02900eb024a1209mr5612813pll.43.1618258120487;
        Mon, 12 Apr 2021 13:08:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h16sm10401469pfc.194.2021.04.12.13.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 13:08:39 -0700 (PDT)
Date:   Mon, 12 Apr 2021 13:08:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, x86@kernel.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, chris@chris-wilson.co.uk,
        intel-gfx@lists.freedesktop.org, linux-mm@kvack.org, hch@lst.de
Subject: Re: [PATCH 6/7] i915: Convert to verify_page_range()
Message-ID: <202104121306.3A73BEB0A5@keescook>
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

For example, switch to returning bad addr through verify_page_range(),
or have a by-reference value, etc:

	unsigned long failed;

	failed = verify_page_range(current->mm< addr, len, check_present_pte);
	if (failed) {
  		pr_err("missing PTE:%lx\n",
  		       (addr - failed) >> PAGE_SHIFT);


-- 
Kees Cook
