Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC03D3514
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 09:12:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbhGWGbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 02:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbhGWGbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 02:31:34 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184D4C061575
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:12:08 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id f1so2194917plt.7
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 00:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B4pG5X92n/pg5azzZDZyLdDsyeHis75paHHHy3/0sK4=;
        b=hDXynN/MXkoVdK5vfUN2Uq+JsGwfyDkLpdp9vKKyIZm1j7wl6RFjzSJ/U1poKmWBHd
         ZYHPH/xXHmDteW3YISF2z7Mgt74TEiTPFNcJZRszGwUaTphtOpNPQLKsGrF8GTM/t0bS
         pUOfFK8dvYQb2CcA0htsXpnXHt3FANpN663kNeyiXFEjhQfffDzCB14WfhLNDskhUghH
         qSnQ4yYZnKfVntehKgfLOb715qs+npc+DvHBgHcBO3AlneM6E712OA2q/YRaUxdyOLuc
         5zpSXpaH9aGM6yQ+imbqvzevn8Y+CJxMhDCpqKLM/w7QIgBWSuXNrE7V3GnRAkRoyo0P
         IiHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B4pG5X92n/pg5azzZDZyLdDsyeHis75paHHHy3/0sK4=;
        b=lrndnrBcGaNooFMs9K/3Bthn97/tKGq9PJBsD1UdyyboPc3uUgsisAP7ZfIQFxGNEP
         C1mokz/dEc3I9vMuQRMF6TFZq02zJaAj2GuUSd+apaoj3tkyWD9MUzL2L5gpGjfsaKb4
         a31/p29guzFyA9QCvl05+8IzmYAhDcEFfW7okHRRPeaN4mDE4ro0HYdQq6d/UYFoVeNM
         YiWcMRFDg5WDO8Z4IvC3ZK2vQ7hTY0NS5VtJiENCnnfkfYkepRNqjXIWwelxHNwjHS86
         /Cxj45mOQma0WwoxzRByejSbVpA3kmHX9s++5F65fHvEM01L9MkDAkgw/bmlCGqi/EXK
         ua/w==
X-Gm-Message-State: AOAM533zfKdJAf1w29Jn2oEt3bIFaXbG85dEI6e/jvGP1q/0cD3Beu0E
        6Tgw5FuYuB+cTmZ6KMolvnL/vQ==
X-Google-Smtp-Source: ABdhPJzltA+1/fGBVtRfH6ySuIQYPXO1zU/U8FHD4pWJ4597K4g8VMOR4HZ+7M//ZFE+V+jEBXf2Bg==
X-Received: by 2002:aa7:95a4:0:b029:332:f4e1:1dac with SMTP id a4-20020aa795a40000b0290332f4e11dacmr3154708pfk.34.1627024327574;
        Fri, 23 Jul 2021 00:12:07 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([202.155.204.36])
        by smtp.gmail.com with ESMTPSA id z24sm4971018pju.55.2021.07.23.00.12.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 00:12:06 -0700 (PDT)
Date:   Fri, 23 Jul 2021 15:11:59 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     "Hunter, Adrian" <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 10/11] perf env: Set flag for kernel is 64-bit mode
Message-ID: <20210723071159.GF179035@leoy-ThinkPad-X240s>
References: <20210711104105.505728-1-leo.yan@linaro.org>
 <20210711104105.505728-11-leo.yan@linaro.org>
 <YOyGi9Zdrio7OmBX@kernel.org>
 <20210713150953.GC748506@leoy-ThinkPad-X240s>
 <PH0PR11MB56264B3A7E4709CB0635F320E0149@PH0PR11MB5626.namprd11.prod.outlook.com>
 <YO7t1UTrPh4TsiI9@kernel.org>
 <YO7uDIQYB9wduMd6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YO7uDIQYB9wduMd6@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On Wed, Jul 14, 2021 at 11:00:44AM -0300, Arnaldo Carvalho de Melo wrote:

[...]

> > So, I wasn't suggesting to add this info to the perf.data file header,
> > just to the in-memory 'struct perf_env'.
> > 
> > And also we should avoid unconditionally initializing things that we may
> > never need, please structure it as:
> 
> Oops, forgot these:
>  
> > static void perf_env__init_kernel_mode(struct perf_env *env)
> > {
> >        const char *arch = perf_env__raw_arch(env);
> > 
> >        if (!strncmp(arch, "x86_64", 6)   || !strncmp(arch, "aarch64", 7) ||
> >            !strncmp(arch, "arm64", 5)    || !strncmp(arch, "mips64", 6) ||
> >            !strncmp(arch, "parisc64", 8) || !strncmp(arch, "riscv64", 7) ||
> >            !strncmp(arch, "s390x", 5)    || !strncmp(arch, "sparc64", 7))
> >                kernel_is_64_bit = 1;
>                  env->kernel_is_64_bit = 1;
> >        else
> >                kernel_is_64_bit = 0;
>                  env->kernel_is_64_bit = 0;
> > }
> > 
> > 
> > void perf_env__init(struct perf_env *env)
> > {
> > 	...
> > 	env->kernel_is_64_bit = -1;
> > 	...
> > }
> > 
> > bool perf_env__kernel_is_64_bit(struct perf_env *env)
> > {
> > 	if (env->kernel_is_64_bit == -1)
> > 		perf_env__init_kernel_mode(env);
> > 
> > 	return env->kernel_is_64_bit;
> > }

Thanks a lot for the suggestion; this is much clear for me, will spin
new patch set by following it.

Sorry for slow response due to my bandwidth was occupied by a task in
hand.

Thanks,
Leo
