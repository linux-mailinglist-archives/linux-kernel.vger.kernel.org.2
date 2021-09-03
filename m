Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4703040078A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 23:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhICVsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 17:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235948AbhICVsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 17:48:04 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E9C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 14:47:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id y17so518233pfl.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 14:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R1bYmjTKExX6JhEiFOJnD/oqcz6UJ6jC0pHYWsTKBDs=;
        b=OfbJLxMQu6pj30fFIOlmMUIGQCvb6KKk+9r2hRYvK14B0p9yAa4u4lckrNox3opWlv
         e+CnUR4dvZ5OkgpAbUqMh+PBobSMior4wj6wcNd4ot99aaW3T7fu0L6jDnAlM+s2/k8v
         O8l6zG7Gq5rTedFzfLdpshq7BjPr6Zahzhxew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R1bYmjTKExX6JhEiFOJnD/oqcz6UJ6jC0pHYWsTKBDs=;
        b=ciJNukauVRpiRlvLt2FUQti48sc2yleELUTTbQjXfPU4J8mLoRMPO7orP+Zdq0LQbs
         +4zSFP7xBlrJtFIRtHpEteih9xz6DBMXSX2FngCeGRbjKFFk6UZPOey7c12vJ/1OdL5F
         d5ykfWho98ALNWpXVhjyGz7TqcdCj3XeaNqJ2DeBERzG8E/daSXDfbnhJCFWBB1pY0pq
         7ox0AnwbjJjPKfwlZA4QfXdk3f/+EyY5SknMghxK4OcynRSRuOijQAW1ViDAEcCG37iJ
         eBtAi4elvUgShnawOwo52lQaItxx3Z7UofBPxvKUO54QsukuYzzWsEnJJ0l6Bk8LYdmC
         kAwQ==
X-Gm-Message-State: AOAM532pojiA8PQlQ3AMHY7M1aNgtJm7g1kxvvGBBw/4MbSJktbz8yP7
        zAl0y3IgoQJg09wwZAcXeCBqMQ==
X-Google-Smtp-Source: ABdhPJz+Ei3gb17X1dhyb0eeklFvEiEXy52fab+dYlg6aQf2iyHFV7bY1p9iHQxqzKWYOqV5wJ9yLQ==
X-Received: by 2002:a62:1d10:0:b0:408:9989:3c88 with SMTP id d16-20020a621d10000000b0040899893c88mr845229pfd.22.1630705623613;
        Fri, 03 Sep 2021 14:47:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m28sm335674pgl.9.2021.09.03.14.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 14:47:02 -0700 (PDT)
Date:   Fri, 3 Sep 2021 14:47:01 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     akpm@linux-foundation.org, ccross@google.com,
        sumit.semwal@linaro.org, mhocko@suse.com, dave.hansen@intel.com,
        willy@infradead.org, kirill.shutemov@linux.intel.com,
        vbabka@suse.cz, hannes@cmpxchg.org, corbet@lwn.net,
        viro@zeniv.linux.org.uk, rdunlap@infradead.org,
        kaleshsingh@google.com, peterx@redhat.com, rppt@kernel.org,
        peterz@infradead.org, catalin.marinas@arm.com,
        vincenzo.frascino@arm.com, chinwen.chang@mediatek.com,
        axelrasmussen@google.com, aarcange@redhat.com, jannh@google.com,
        apopple@nvidia.com, jhubbard@nvidia.com, yuzhao@google.com,
        will@kernel.org, fenghua.yu@intel.com, thunder.leizhen@huawei.com,
        hughd@google.com, feng.tang@intel.com, jgg@ziepe.ca, guro@fb.com,
        tglx@linutronix.de, krisman@collabora.com, chris.hyser@oracle.com,
        pcc@google.com, ebiederm@xmission.com, axboe@kernel.dk,
        legion@kernel.org, eb@emlix.com, gorcunov@gmail.com,
        songmuchun@bytedance.com, viresh.kumar@linaro.org,
        thomascedeno@google.com, sashal@kernel.org, cxfcosmos@gmail.com,
        linux@rasmusvillemoes.dk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, kernel-team@android.com
Subject: Re: [PATCH v9 2/3] mm: add a field to store names for private
 anonymous memory
Message-ID: <202109031439.B58932AF0@keescook>
References: <20210902231813.3597709-1-surenb@google.com>
 <20210902231813.3597709-2-surenb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902231813.3597709-2-surenb@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Sorry, a few more things jumped out at me when I looked again...)

On Thu, Sep 02, 2021 at 04:18:12PM -0700, Suren Baghdasaryan wrote:
> [...]
> diff --git a/kernel/sys.c b/kernel/sys.c
> index 72c7639e3c98..25118902a376 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2299,6 +2299,64 @@ int __weak arch_prctl_spec_ctrl_set(struct task_struct *t, unsigned long which,
>  
>  #define PR_IO_FLUSHER (PF_MEMALLOC_NOIO | PF_LOCAL_THROTTLE)
>  
> +#ifdef CONFIG_MMU
> +
> +#define ANON_VMA_NAME_MAX_LEN	256
> +
> +static inline bool is_valid_name_char(char ch)
> +{
> +	/* printable ascii characters, except [ \ ] */
> +	return (ch > 0x1f && ch < 0x5b) || (ch > 0x5d && ch < 0x7f);
> +}

In the back of my mind, I feel like disallowing backtick would be nice,
but then if $, (, and ) are allowed, it doesn't matter, and that seems
too limiting. :)

> +
> +static int prctl_set_vma(unsigned long opt, unsigned long addr,
> +			 unsigned long size, unsigned long arg)
> +{
> +	struct mm_struct *mm = current->mm;
> +	const char __user *uname;
> +	char *name, *pch;
> +	int error;
> +
> +	switch (opt) {
> +	case PR_SET_VMA_ANON_NAME:
> +		uname = (const char __user *)arg;
> +		if (!uname) {
> +			/* Reset the name */
> +			name = NULL;
> +			goto set_name;
> +		}
> +
> +		name = strndup_user(uname, ANON_VMA_NAME_MAX_LEN);
> +
> +		if (IS_ERR(name))
> +			return PTR_ERR(name);
> +
> +		for (pch = name; *pch != '\0'; pch++) {
> +			if (!is_valid_name_char(*pch)) {
> +				kfree(name);
> +				return -EINVAL;
> +			}
> +		}
> +set_name:
> +		mmap_write_lock(mm);
> +		error = madvise_set_anon_name(mm, addr, size, name);
> +		mmap_write_unlock(mm);
> +		kfree(name);
> +		break;

This is a weird construct with a needless goto. Why not:

	switch (opt) {
	case PR_SET_VMA_ANON_NAME:
		uname = (const char __user *)arg;
		if (uname) {
			name = strndup_user(uname, ANON_VMA_NAME_MAX_LEN);
			if (IS_ERR(name))
				return PTR_ERR(name);

			for (pch = name; *pch != '\0'; pch++) {
				if (!is_valid_name_char(*pch)) {
					kfree(name);
					return -EINVAL;
				}
			}
		} else {
			/* Reset the name */
			name = NULL;
		}
		mmap_write_lock(mm);
		error = madvise_set_anon_name(mm, addr, size, name);
		mmap_write_unlock(mm);
		kfree(name);
		break;


-- 
Kees Cook
