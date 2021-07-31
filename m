Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7DC3DC40E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 08:37:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237046AbhGaGhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 02:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbhGaGht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 02:37:49 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D554C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:37:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id e2-20020a17090a4a02b029016f3020d867so17542579pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jul 2021 23:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MMWnZBP/iiPeKj/j1MYwfBpBFKoHSl81Cqk/jEOD+dk=;
        b=Ex6B0uTyBCucaWwm4DkcyqTKLU5vqD52HVobkEzFBK/LreWdw3g5cbIDphJJ7rHRrI
         Bl5z+Fa3yETB01dx151ljz+vzjaNtGg8s4M67q2TPpjI1ZIdl+ZJl/QQ/ZGcvgIqXaxw
         BhKFPF5SnUIEdnC0ZOHQzKSn93KPi+32J96+xYBUl9Kf6ExlsAzOoaBraTeR7sHgyGmK
         aA8eyLJWDMrdRkcnvZB90Ts6Z/wvf7uiDqCeo/WIpdecmPKfJZvpT5LAmE6JUtLxMHat
         Q0eVQJVukaCBH+xfrvrByXA3aF6gh5uWHh7LZi9HhSZFbvHme5wmwj7jmJmu03AmFnub
         xkBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MMWnZBP/iiPeKj/j1MYwfBpBFKoHSl81Cqk/jEOD+dk=;
        b=hwQG90Cd62iJ+dJ9GsSt+jYfbf57qpaXkYLq2/nHfeBl25IOlfJUux1JxsvTYm91eD
         YIfzwSJMnvdQ9IvxBZujBss+rQ46WjdVqZQFRRJcKaIyJcAemGbJDQyTWaynWlmJvzeh
         a2bfE2Ja5lpGKwsYznBWO52OnUv/AtXbV9sSrztBgfqdNa4BRJJ5uJto4+K8Bmd/fHVB
         cCW8Keqym2RD/+qjkBv/ydfUoshzjEYk2P5EqVA4ue7vGELdRDteVRzzH5BWwPkN2pbY
         Ak9N71RHkcHmn6KtYVLn8WLsuB0stysFoaIsoZAAjubn9YlNVenP0YzbRe/YwNtvLEu1
         SUSA==
X-Gm-Message-State: AOAM532+wDczYu9MD8juzweX63L2VCQ7WzRavvlK3ob/BthyGNoow3oA
        8GUf/2qYDOt2UFLRSJ+7d6aZ6Q==
X-Google-Smtp-Source: ABdhPJyZDJkISj/cYTjZwpsaiftbjyQdqIO8oupnyxMgOgBsQkcrLbSAuww67M64iJplMutf07cKwA==
X-Received: by 2002:a62:52cc:0:b029:3b1:1f36:8bbc with SMTP id g195-20020a6252cc0000b02903b11f368bbcmr4057867pfb.16.1627713462550;
        Fri, 30 Jul 2021 23:37:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([204.124.181.43])
        by smtp.gmail.com with ESMTPSA id f4sm5359079pgs.3.2021.07.30.23.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 23:37:41 -0700 (PDT)
Date:   Sat, 31 Jul 2021 14:37:31 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     James Clark <james.clark@arm.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Al Grant <al.grant@arm.com>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/6] perf cs-etm: Save TRCDEVARCH register
Message-ID: <20210731063731.GC7437@leoy-ThinkPad-X240s>
References: <20210721090706.21523-1-james.clark@arm.com>
 <20210721090706.21523-4-james.clark@arm.com>
 <CAJ9a7Vjz_CMugYrLcAqr_aFsK6jYcqR3xLwJUi9KTXB3aPjnEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vjz_CMugYrLcAqr_aFsK6jYcqR3xLwJUi9KTXB3aPjnEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 21, 2021 at 10:48:25AM +0100, Mike Leach wrote:
> HI James,
> 
> On Wed, 21 Jul 2021 at 10:07, James Clark <james.clark@arm.com> wrote:
> >
> > Now that the metadata has a length field we can add extra registers
> > without breaking any previous versions of perf.
> >
> > Save the TRCDEVARCH register so that it can be used to configure the ETE
> > decoder in the next commit. If the sysfs file doesn't exist then 0 will
> > be saved which is an impossible register value and can also be used to
> > signify that the file couldn't be read.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >  tools/perf/arch/arm/util/cs-etm.c | 13 ++++++++++++-
> >  tools/perf/util/cs-etm.c          |  1 +
> >  tools/perf/util/cs-etm.h          |  5 +++--
> >  3 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > index 85168d87b2d7..65a863bdf5cc 100644
> > --- a/tools/perf/arch/arm/util/cs-etm.c
> > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > @@ -53,6 +53,7 @@ static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
> >         [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
> >         [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
> >         [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
> > +       [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch"

ETMv4 supports TRCDEVARCH, so I think it's good to use the naming
"CS_ETMV4_TRCDEVARCH"?

> >  };
> >
> >  static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> > @@ -73,7 +74,7 @@ static int cs_etm_set_context_id(struct auxtrace_record *itr,
> >         if (!cs_etm_is_etmv4(itr, cpu))
> >                 goto out;
> >
> > -       /* Get a handle on TRCIRD2 */
> > +       /* Get a handle on TRCIDR2 */

This is typo fixing; it's irrelevant to the topic in this patch, it's
good to use a separate patch for the typo fixing.

> >         snprintf(path, PATH_MAX, "cpu%d/%s",
> >                  cpu, metadata_etmv4_ro[CS_ETMV4_TRCIDR2]);
> >         err = perf_pmu__scan_file(cs_etm_pmu, path, "%x", &val);
> > @@ -643,6 +644,16 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> >                         cs_etm_get_ro(cs_etm_pmu, cpu,
> >                                       metadata_etmv4_ro
> >                                       [CS_ETMV4_TRCAUTHSTATUS]);
> > +               /*
> > +                * ETE uses the same registers as ETMv4 plus TRCDEVARCH. It's also backwards
> > +                * compatible, so don't change the magic number otherwise that will reduce the
> > +                * number of versions of perf that can open it. Just append TRCDEVARCH to the end of
> > +                * the register block and allow newer versions of perf to make use. cs_etm_get_ro()
> > +                * returns 0 if it couldn't be read.
> > +                */
> 
> ETE is a superset of ETMv4, but an old perf that only knows ETMv4
> cannot be guaranteed to decode all ETE due to new packet types.
> Therefore do we want to allow old perfs to decode only some ETE,
> possibly with errors?
> 
> I think it would be better to add in a new magic number for the new
> decoder rather than have some grey overlap area were an "older" perf
> might work intermittently dependent on the packets generated in a
> particular trace run.

I checked ETMv4.3 and ETMv4.4 spec (ARM IHI0064E for ETMv4.3 and ARM
IHI0064F for ETMv4.4), both clarify ETMv4 has the register TRCDEVARCH;
thus TRCDEVARCH is not a new register introduced by ETE.

For this case, it's good to directly add a new field in the metadata
array for recording register TRCDEVARCH.

If there have any new registers are introduced by ETE, then Mike's
suggestion for using new magic number is the right thing to do.

> > +               info->priv[*offset + CS_ETE_TRCDEVARCH] =
> > +                       cs_etm_get_ro(cs_etm_pmu, cpu,
> > +                                     metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> >
> >                 /* How much space was used */
> >                 increment = CS_ETMV4_PRIV_MAX;
> > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > index 62769a84a53f..68978f6707a8 100644
> > --- a/tools/perf/util/cs-etm.c
> > +++ b/tools/perf/util/cs-etm.c
> > @@ -2508,6 +2508,7 @@ static const char * const cs_etmv4_priv_fmts[] = {
> >         [CS_ETMV4_TRCIDR2]      = "     TRCIDR2                        %llx\n",
> >         [CS_ETMV4_TRCIDR8]      = "     TRCIDR8                        %llx\n",
> >         [CS_ETMV4_TRCAUTHSTATUS] = "    TRCAUTHSTATUS                  %llx\n",
> > +       [CS_ETE_TRCDEVARCH]     = "     TRCDEVARCH                     %llx\n"
> >  };
> >
> >  static const char * const param_unk_fmt =
> > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > index d65c7b19407d..52d82dce9d59 100644
> > --- a/tools/perf/util/cs-etm.h
> > +++ b/tools/perf/util/cs-etm.h
> > @@ -59,7 +59,7 @@ enum {
> >  /* define fixed version 0 length - allow new format reader to read old files. */
> >  #define CS_ETM_NR_TRC_PARAMS_V0 (CS_ETM_ETMIDR - CS_ETM_ETMCR + 1)
> >
> > -/* ETMv4 metadata */
> > +/* ETMv4 + ETE metadata */
> >  enum {
> >         /* Dynamic, configurable parameters */
> >         CS_ETMV4_TRCCONFIGR = CS_ETM_COMMON_BLK_MAX_V1,
> > @@ -70,7 +70,8 @@ enum {
> >         CS_ETMV4_TRCIDR2,
> >         CS_ETMV4_TRCIDR8,
> >         CS_ETMV4_TRCAUTHSTATUS,
> > -       CS_ETMV4_PRIV_MAX,
> > +       CS_ETE_TRCDEVARCH,
> > +       CS_ETMV4_PRIV_MAX

Spurious change for "CS_ETMV4_PRIV_MAX"?

Thanks,
Leo
