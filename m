Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6822741EE52
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 15:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbhJANSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 09:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhJANS1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 09:18:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05FEC061775
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 06:16:43 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633094202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+kV/4LlovLrkHhLiK2uVWcembQwhED6OJtKlyJ2tP4=;
        b=OKFDHJM3IcrZ28W9C78B8g6p2SIzusJRgkVJJ2nd9SgDINzwc5czJrvpK6HQ40FaxajeiB
        iFz8Eb35whdXwcyc1nby4jJayb3lrubL4DYjOYnn1Zb6cGzQ+LtAi2C94vrijr9WxMNAKY
        kG4MzLfpTMcsKJzACyWHvVW0hfYkuJ3JzkEiqzTFEfDpW0sBMwQIYNZOzZcXBhNMUyOx9A
        frRsZ6Z+4lMmLNKl5L+QCmYd6wqL9UnUdNRmOBdRTv85q/lVbe40UE5YZksm1KpOfMJ+aG
        wAQQnSo4jvVp3YCyKAC9qd0ZT8vnK4Hn5RuFLR3ne2ChKtjFsbhjYi1AaLzGbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633094202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q+kV/4LlovLrkHhLiK2uVWcembQwhED6OJtKlyJ2tP4=;
        b=YUxBWO9a94r3uezIzob+HMEPeZNQtUsPmkELttKB5GEhBOBpMMis/8zf72t1w09c+s+1Jn
        dBgaIKXGdkWwizCA==
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        luto@kernel.org, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, lenb@kernel.org, dave.hansen@intel.com,
        thiago.macieira@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v10 05/28] x86/fpu/xstate: Add a new variable to
 indicate dynamic user states
In-Reply-To: <20210825155413.19673-6-chang.seok.bae@intel.com>
References: <20210825155413.19673-1-chang.seok.bae@intel.com>
 <20210825155413.19673-6-chang.seok.bae@intel.com>
Date:   Fri, 01 Oct 2021 15:16:41 +0200
Message-ID: <87bl486g1y.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25 2021 at 08:53, Chang S. Bae wrote:
> +/*
> + * This represents user xstates, a subset of xfeatures_mask_all, saved in a
> + * dynamic kernel XSAVE buffer.
> + */
> +u64 xfeatures_mask_user_dynamic __ro_after_init;
> +
>  static unsigned int xstate_offsets[XFEATURE_MAX] __ro_after_init =
>  	{ [ 0 ... XFEATURE_MAX - 1] = -1};
>  static unsigned int xstate_sizes[XFEATURE_MAX] __ro_after_init =
> @@ -709,6 +715,7 @@ static int __init init_xstate_size(void)
>  static void fpu__init_disable_system_xstate(void)
>  {
>  	xfeatures_mask_all = 0;
> +	xfeatures_mask_user_dynamic = 0;

It's zero at boot already, isn't it?

>  	cr4_clear_bits(X86_CR4_OSXSAVE);
>  	setup_clear_cpu_cap(X86_FEATURE_XSAVE);
>  }
> @@ -780,6 +787,8 @@ void __init fpu__init_system_xstate(void)
>  
>  	/* Store it for paranoia check at the end */
>  	xfeatures = xfeatures_mask_all;
> +	/* Do not support the dynamically allocated buffer yet. */
> +	xfeatures_mask_user_dynamic = 0;
>  
>  	/* Enable xstate instructions to be able to continue with initialization: */
>  	fpu__init_cpu_xstate();
