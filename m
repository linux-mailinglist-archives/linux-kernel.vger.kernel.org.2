Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEFE417B5C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 20:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345618AbhIXS6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 14:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49564 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344443AbhIXS6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 14:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632509829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eKyMCL43iCKZzcaZnOuuPGl1m1uGP2CvTJrJ5eMrzFc=;
        b=S/wJPUNOineQAMMsDY0Kbky98zjAWXKOTixOfM5Dhk1oLgTgMYTXR7reqlGocfPJs/6vnJ
        B+f5Ot40FEiXbV91d8NbaoQt+thxO++4jcM72W/Xfup+i0vH4poM8tUPhyYCkzx3m0LPud
        rQL9y58zjGqdV7YLgvXiBLC0e+7waos=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-1nUaaoOqNcSQBHnJO3xpFw-1; Fri, 24 Sep 2021 14:57:08 -0400
X-MC-Unique: 1nUaaoOqNcSQBHnJO3xpFw-1
Received: by mail-qv1-f69.google.com with SMTP id e6-20020a0cb446000000b0037eeb9851dfso37279810qvf.17
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 11:57:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eKyMCL43iCKZzcaZnOuuPGl1m1uGP2CvTJrJ5eMrzFc=;
        b=BP+2BZw408EzpF2o3FDG38i5y2AU6YRGKm/wDr75qrQJvLYkIk5OCVVZ+gvvFi7eIO
         ZXo307MuRWCaY/7t0LftdhVUN/jEDPD95EKRzcQkwoCVD9bj06cL4eqI0KLlnoHijSck
         uU75LeuqDC0W6UGcdc7bHfGXY+8aZVMu7YOPQIAdOuDSIdTyHTW1BduFNpq4d+DyBrQX
         G4HrmdbozFHB0T40XxM7aLxmQqZpRngJtX0YuzXBl+1ScHopdWzORrGwMdoS9/rxuI05
         H2t2yH5/NG3Y2/mAnHRYbj4/QPe+pfZseyHesyWY9iG8h3IHIaOkBKlvcQZWKK/ou1Wc
         aZLA==
X-Gm-Message-State: AOAM531oQTqwrFug3w2WkTPWT4IEfwOtwnuumiL33spm8WyD+gWdn4aU
        NWhnwjQ3tok8tj1sQOp7rsiAE2CGB/S9XicoNXW+hXze2fTvtlW/J6Q8hnvDthhB5Ud4fdiSdWI
        poLUjLnh0+EhJaoAjqM4mSnJj
X-Received: by 2002:a37:6249:: with SMTP id w70mr12039260qkb.326.1632509828423;
        Fri, 24 Sep 2021 11:57:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzy8ciGyYBn2Zv4GZs5NODQTqy8mKkxKxYAe9NspblaP9YtINDqsCzSluwxs6y0Ba0BS3cIrg==
X-Received: by 2002:a37:6249:: with SMTP id w70mr12039235qkb.326.1632509828122;
        Fri, 24 Sep 2021 11:57:08 -0700 (PDT)
Received: from jsavitz.bos.csb (c-73-119-23-82.hsd1.ma.comcast.net. [73.119.23.82])
        by smtp.gmail.com with ESMTPSA id w11sm832879qts.9.2021.09.24.11.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 11:57:07 -0700 (PDT)
Date:   Fri, 24 Sep 2021 14:57:05 -0400
From:   Joel Savitz <jsavitz@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     gor@linux.ibm.com, jpoimboe@redhat.com, jikos@kernel.org,
        mbenes@suse.cz, pmladek@suse.com, mingo@kernel.org,
        linux-kernel@vger.kernel.org, joe.lawrence@redhat.com,
        fweisbec@gmail.com, tglx@linutronix.de, hca@linux.ibm.com,
        svens@linux.ibm.com, sumanthk@linux.ibm.com,
        live-patching@vger.kernel.org, paulmck@kernel.org
Subject: Re: [RFC][PATCH 6/7] context_tracking: Provide SMP ordering using RCU
Message-ID: <20210924185705.GA1264192@jsavitz.bos.csb>
References: <20210922110506.703075504@infradead.org>
 <20210922110836.244770922@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922110836.244770922@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:05:12PM +0200, Peter Zijlstra wrote:
> ---
>  include/linux/context_tracking_state.h |   12 ++++++++++++
>  kernel/context_tracking.c              |    7 ++++---
>  2 files changed, 16 insertions(+), 3 deletions(-)
> 
> --- a/include/linux/context_tracking_state.h
> +++ b/include/linux/context_tracking_state.h
> @@ -45,11 +45,23 @@ static __always_inline bool context_trac
>  {
>  	return __this_cpu_read(context_tracking.state) == CONTEXT_USER;
>  }
> +
> +static __always_inline bool context_tracking_state_cpu(int cpu)
> +{
> +	struct context_tracking *ct = per_cpu_ptr(&context_tracking);
> +
> +	if (!context_tracking_enabled() || !ct->active)
> +		return CONTEXT_DISABLED;
> +
> +	return ct->state;
> +}
> +
>  #else
>  static inline bool context_tracking_in_user(void) { return false; }
>  static inline bool context_tracking_enabled(void) { return false; }
>  static inline bool context_tracking_enabled_cpu(int cpu) { return false; }
>  static inline bool context_tracking_enabled_this_cpu(void) { return false; }
> +static inline bool context_tracking_state_cpu(int cpu) { return CONTEXT_DISABLED; }
>  #endif /* CONFIG_CONTEXT_TRACKING */
>  
>  #endif

Should context_tracking_state_cpu return an enum ctx_state rather than a
bool? It appears to be doing an implicit cast.

I don't know if it possible to run livepatch with
CONFIG_CONTEXT_TRACKING disabled, but if so, then klp_check_task() as
modified by patch 7 will always consider the transition complete even if
the current task is in kernel mode. Also in the general case, the CPU
will consider the task complete if has ctx_state CONTEXT_GUEST though the
condition does not make it explicit.

I'm not sure what the correct behavior should be here as I am not very
experienced with this sybsystem but the patch looks a bit odd to me.

> --- a/kernel/context_tracking.c
> +++ b/kernel/context_tracking.c
> @@ -82,7 +82,7 @@ void noinstr __context_tracking_enter(en
>  				vtime_user_enter(current);
>  				instrumentation_end();
>  			}
> -			rcu_user_enter();
> +			rcu_user_enter(); /* smp_mb */
>  		}
>  		/*
>  		 * Even if context tracking is disabled on this CPU, because it's outside
> @@ -149,12 +149,14 @@ void noinstr __context_tracking_exit(enu
>  		return;
>  
>  	if (__this_cpu_read(context_tracking.state) == state) {
> +		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
> +
>  		if (__this_cpu_read(context_tracking.active)) {
>  			/*
>  			 * We are going to run code that may use RCU. Inform
>  			 * RCU core about that (ie: we may need the tick again).
>  			 */
> -			rcu_user_exit();
> +			rcu_user_exit(); /* smp_mb */
>  			if (state == CONTEXT_USER) {
>  				instrumentation_begin();
>  				vtime_user_exit(current);
> @@ -162,7 +164,6 @@ void noinstr __context_tracking_exit(enu
>  				instrumentation_end();
>  			}
>  		}
> -		__this_cpu_write(context_tracking.state, CONTEXT_KERNEL);
>  	}
>  	context_tracking_recursion_exit();
>  }
> 
> 

