Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B632930EB13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 04:38:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbhBDDiC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 22:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbhBDDh2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 22:37:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29D2C0613D6
        for <linux-kernel@vger.kernel.org>; Wed,  3 Feb 2021 19:36:47 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx20so975673pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Feb 2021 19:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=z/pPsjpNFL1AOj/V+7CEjl7TXj+nEWHQjNVxoyWjhMA=;
        b=JpENPKrAHYNY/1bfV8ya7o3ydolLhfwkhhlfiq8Y3ndGsBDNZyyREvA3oxsFX5NrLu
         4OIN/wsPWAe+9uxm8bYw9PRkGKOpaNMyy1bZxgMADjqDFDWavvkIW8pfwnbtdMYJVHiS
         aoa+yBHC35SfUiJyFFSbt64rikzTW9O/Pe9aifCLXGqIgqIeRGqJDDIGCS80tEyxjz9O
         YGQ7TOZc/0YQWMv7mv9sabhRHFo7ehY3pS8Z5iFZFdZ+ituSWgAW9m7MSMJow24O6OhV
         H6R2lzwkZaFSLHYN7CU1mIExLhtBG5+jJ09bmAhUjVp4LRbBEHuBFwN0pxsZtoianbJs
         bINQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=z/pPsjpNFL1AOj/V+7CEjl7TXj+nEWHQjNVxoyWjhMA=;
        b=TwH6O0xzc97w4i3BERSN8RvFu1/L8/4YcrVi0Us3c86I8nS6y1aMuTetsopZnJmFKz
         FS7amcO3PLiJiBqN5N5NUZFua0tjkCrR/q8mKo1vhLmn1V4yHUYpAAtLVYEaNsX08Gby
         Eu/gei5x55X5DJ3GftHF6cyg5x9pBmEwjika7+q44IbdcmNKQiV98J54dh3ejd1K+qXN
         DadPAH+mbnjqXN7k6EeiVujoXHqzYpl+kRf5Cl6qDHxpihK2i9KqkzZzd89UPUXrxYxP
         VpJD8LN6Z3HbMQemRFMTF3J9Gu32Xvs22Q5Y61flA0umlKzKSlT2ShQ+/WXExc7jbYzX
         COCg==
X-Gm-Message-State: AOAM533Fne2OZ5yg7ReXQDJrJRxK7xJXcq8tDjNbBEriRdQdKCYK6qKJ
        e933p5Q6OhS7w3GSGQyiYEv+AA==
X-Google-Smtp-Source: ABdhPJzbPCh4kVIug8LRnR3bHrD8di6i9tGyckVHug4fny38LYmXqhAqJ9xCPXH7CsEth7n7+NrJew==
X-Received: by 2002:a17:902:503:b029:e1:82d:bd4f with SMTP id 3-20020a1709020503b02900e1082dbd4fmr6078956plf.28.1612409807296;
        Wed, 03 Feb 2021 19:36:47 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([202.131.71.236])
        by smtp.gmail.com with ESMTPSA id w13sm3936565pfc.7.2021.02.03.19.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:36:46 -0800 (PST)
Date:   Thu, 4 Feb 2021 11:36:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Daniel Kiss <Daniel.Kiss@arm.com>,
        Denis Nikitin <denik@chromium.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/7] coresight: etm-perf: Clarify comment on perf
 options
Message-ID: <20210204033639.GD11059@leoy-ThinkPad-X240s>
References: <20210202163842.134734-1-leo.yan@linaro.org>
 <20210202163842.134734-2-leo.yan@linaro.org>
 <071d1235-c8c4-7b3f-11ce-91c1f907ea8d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <071d1235-c8c4-7b3f-11ce-91c1f907ea8d@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Suzuki,

On Tue, Feb 02, 2021 at 11:00:42PM +0000, Suzuki Kuruppassery Poulose wrote:
> Hi Leo
> 
> On 2/2/21 4:38 PM, Leo Yan wrote:
> > In theory, the options should be arbitrary values and are neutral for
> > any ETM version; so far perf tool uses ETMv3.5/PTM ETMCR config bits
> > except for register's bit definitions, also uses as options.
> > 
> > This can introduce confusion, especially if we want to add a new option
> > but the new option is not supported by ETMv3.5/PTM ETMCR.  But on the
> > other hand, we cannot change options since these options are generic
> > CoreSight PMU ABI.
> > 
> > For easier maintenance and avoid confusion, this patch refines the
> > comment to clarify perf options, and gives out the background info for
> > these bits are coming from ETMv3.5/PTM.  Afterwards, we should take
> > these options as general knobs, and if there have any confliction with
> > ETMv3.5/PTM, should consider to define saperate macros for ETMv3.5/PTM
> > ETMCR config bits.
> > 
> > Suggested-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > Signed-off-by: Leo Yan <leo.yan@linaro.org>
> 
> The patch looks good to me.  The only concern I have is, whether
> we should split this patch to kernel vs tools ? As the kernel
> changes go via coresight tree and the tools patch may go via
> perf tree ?

Yes, will split the patch.

> Either way, for the patch:
> 
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

Thanks for review and suggestion.

> > ---
> >   .../hwtracing/coresight/coresight-etm-perf.c    |  5 ++++-
> >   include/linux/coresight-pmu.h                   | 17 ++++++++++++-----
> >   tools/include/linux/coresight-pmu.h             | 17 ++++++++++++-----
> >   3 files changed, 28 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > index bdc34ca449f7..465ef1aa8c82 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> > @@ -27,7 +27,10 @@ static bool etm_perf_up;
> >   static DEFINE_PER_CPU(struct perf_output_handle, ctx_handle);
> >   static DEFINE_PER_CPU(struct coresight_device *, csdev_src);
> > -/* ETMv3.5/PTM's ETMCR is 'config' */
> > +/*
> > + * The PMU formats were orignally for ETMv3.5/PTM's ETMCR 'config';
> > + * now take them as general formats and apply on all ETMs.
> > + */
> >   PMU_FORMAT_ATTR(cycacc,		"config:" __stringify(ETM_OPT_CYCACC));
> >   PMU_FORMAT_ATTR(contextid,	"config:" __stringify(ETM_OPT_CTXTID));
> >   PMU_FORMAT_ATTR(timestamp,	"config:" __stringify(ETM_OPT_TS));
> > diff --git a/include/linux/coresight-pmu.h b/include/linux/coresight-pmu.h
> > index b0e35eec6499..5dc47cfdcf07 100644
> > --- a/include/linux/coresight-pmu.h
> > +++ b/include/linux/coresight-pmu.h
> > @@ -10,11 +10,18 @@
> >   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> >   #define CORESIGHT_ETM_PMU_SEED  0x10
> > -/* ETMv3.5/PTM's ETMCR config bit */
> > -#define ETM_OPT_CYCACC  12
> > -#define ETM_OPT_CTXTID	14
> > -#define ETM_OPT_TS      28
> > -#define ETM_OPT_RETSTK	29
> > +/*
> > + * Below are the definition of bit offsets for perf option, and works as
> > + * arbitrary values for all ETM versions.
> > + *
> > + * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
> > + * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> > + * directly use below macros as config bits.
> > + */
> > +#define ETM_OPT_CYCACC		12
> > +#define ETM_OPT_CTXTID		14
> > +#define ETM_OPT_TS		28
> > +#define ETM_OPT_RETSTK		29
> >   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> >   #define ETM4_CFG_BIT_CYCACC	4
> > diff --git a/tools/include/linux/coresight-pmu.h b/tools/include/linux/coresight-pmu.h
> > index b0e35eec6499..5dc47cfdcf07 100644
> > --- a/tools/include/linux/coresight-pmu.h
> > +++ b/tools/include/linux/coresight-pmu.h
> > @@ -10,11 +10,18 @@
> >   #define CORESIGHT_ETM_PMU_NAME "cs_etm"
> >   #define CORESIGHT_ETM_PMU_SEED  0x10
> > -/* ETMv3.5/PTM's ETMCR config bit */
> > -#define ETM_OPT_CYCACC  12
> > -#define ETM_OPT_CTXTID	14
> > -#define ETM_OPT_TS      28
> > -#define ETM_OPT_RETSTK	29
> > +/*
> > + * Below are the definition of bit offsets for perf option, and works as
> > + * arbitrary values for all ETM versions.
> > + *
> > + * Most of them are orignally from ETMv3.5/PTM's ETMCR config, therefore,
> > + * ETMv3.5/PTM doesn't define ETMCR config bits with prefix "ETM3_" and
> > + * directly use below macros as config bits.
> > + */
> > +#define ETM_OPT_CYCACC		12
> > +#define ETM_OPT_CTXTID		14
> > +#define ETM_OPT_TS		28
> > +#define ETM_OPT_RETSTK		29
> >   /* ETMv4 CONFIGR programming bits for the ETM OPTs */
> >   #define ETM4_CFG_BIT_CYCACC	4
> > 
> 
