Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58339437AAD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 18:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233247AbhJVQPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 12:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232176AbhJVQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 12:15:43 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C067BC061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:13:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id kk10so3327213pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 09:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tHwsQIjdQw6vQG2oDI90G+6hdIow4dPq3mfJw3rvPJk=;
        b=VaVSPX7aUyvodJLlwuBHjqJE5C5b+WuijCyhAvPOCwqRv8Oxk1/vO/LCLVV5ztodgs
         Bs1hoL4ZrVlBJYIYitDMx63nbzlwJPsL42q7FpJYvHJyg6ygVHW6qzRau0ONBX/bwak9
         RnfqJvfdEJRDDWnfROyNZcrjXzd3qRce2nSFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tHwsQIjdQw6vQG2oDI90G+6hdIow4dPq3mfJw3rvPJk=;
        b=3NZ3S7RbOAxrRCx1RW7osM+d0wwT6Usz/q6lMMHPnolr96PJxpZg85YVbNMSqXT5ID
         lVtXh+nJHYCfhsExINMwVaD4c9LLYlYFSFPlR5+BCq3yhqR/mD7IU8LPNHn8oVYzCm9g
         BZ7MuYop7r4KBjNHihTJry26HsQrztoVttIV7+AE6wiLLhWzxbKNKesSBeNol8NScHKV
         ElyLLfw+7CgbAFcdXB7KPXoOP9asSN039YlI6OJZZDRFeE1ZctfopUy4fGWYR98qPJMx
         6EIekQ1U7wuEeTBmLL5qDT4aGZw2cKouQNk1bwu1R4vQUpEe5XXMXc4MuA0bGXrxy9zH
         ADoQ==
X-Gm-Message-State: AOAM530MyOdnZPJm7lDrNmDF7PmCkL2HCgmj710s+O9S3r5LWBwlmxPB
        PPu/h1rVD2Cz1kzJNcbPfXT75Q==
X-Google-Smtp-Source: ABdhPJx8blIG/g6yOrMQ+jbPzh/VGgug9ASZQQQwGQyUB12nBxA4FGCf7ZVO/ro9KcMcSlmLbWeKpw==
X-Received: by 2002:a17:902:aa02:b0:13a:6c8f:407f with SMTP id be2-20020a170902aa0200b0013a6c8f407fmr326684plb.59.1634919204159;
        Fri, 22 Oct 2021 09:13:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q8sm11189832pfu.167.2021.10.22.09.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 09:13:23 -0700 (PDT)
Date:   Fri, 22 Oct 2021 09:13:22 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, akpm@linux-foundation.org,
        mark.rutland@arm.com, zhengqi.arch@bytedance.com,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        mpe@ellerman.id.au, paul.walmsley@sifive.com, palmer@dabbelt.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-arch@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 6/7] arch: __get_wchan() || ARCH_STACKWALK
Message-ID: <202110220910.0D3C298F73@keescook>
References: <20211022150933.883959987@infradead.org>
 <20211022152104.487919043@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022152104.487919043@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 05:09:39PM +0200, Peter Zijlstra wrote:
> Use ARCH_STACKWALK to implement a generic __get_wchan().
> 
> STACKTRACE should be possible, but the various implementations of
> stack_trace_save_tsk() are not consistent enough for this to work.
> ARCH_STACKWALK is a smaller set of architectures with a better defined
> interface.
> 
> Since get_wchan() pins the task in a blocked state, it is not
> necessary to take a reference on the task stack, the task isn't going
> anywhere.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Nice, this looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
