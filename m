Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DFB4011C6
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 23:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238201AbhIEVZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 17:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbhIEVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 17:25:49 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1390C061757
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 14:24:42 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id g138so3203489wmg.4
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 14:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NmfLkQad+p0ifzAvcRkEPaCQdyDT8KhDn4j0E2VCtro=;
        b=EgnaiyZfWQABGW5JCNXHVnlqQta3alXsnsBU7oRcLJU9S7VzyRNdIs6BrYAO8j7YNx
         ssheol6g9zw6YxydO3mE6cG/CY0AaSt61exoIgoGOYaaG+A090RZOPHEZFC1aFclax1J
         1hlJr8Gmaj/Wlt2T2vZYajXmgKRRblhiK0jJfGaX55QAuXCDwLTMjPe44h/8oipvGkNl
         yMPFHCJhblfpBY5Izb3L3TyrgMC916SoF4GCQPVWOYuGmtZg7HLn6LoPfXkhoyKe3ZTT
         +kzLp9jmpSYHhhHGKn9OjOPwctOoKPf+JPYk47CXyCHmreysq6qNIMAO2QoGmhyVtLoQ
         rJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NmfLkQad+p0ifzAvcRkEPaCQdyDT8KhDn4j0E2VCtro=;
        b=BZ25aWMiemoFa0x+pj/4Kek3ZOxKw++7RnxLyqe+3iZpSUP0UkYY8VwAOA8qiW6d0l
         qpndepUj5nUab3FtbryzyKdUX0hGdGxTLrJIIEum5hCYg2ZPqlZemHdlaYxNfakMf8to
         vmERqeDsCqZMVXHvsbHhVYl4uWrqOW/Bju/wC8Zu7H2tEfBPGskpoMIMxKCq0OHLCf2S
         qY1kyoxwvVhKKkTW1WCQ6jBZBBSJnYlfvmUQcMBQZN+fn5m3yxY6VOlPA3rWqCvjHWBB
         gU2CSuQNUllLBfPebBBvKeUNEhc49bH74pVbW4WFqh7V+G0AdWFvtCk+DCZU4Vj5kUvC
         GYFg==
X-Gm-Message-State: AOAM531F5hJmTjNuqSfVRFv6U7TAI/O2ZZmP5HBI3b1ZO3z13Hzn5MSg
        479TGJbPKH0K79XsJLN5o4zQRYaBOWmFFZ62m7BItg==
X-Google-Smtp-Source: ABdhPJzzzbR0IkYoE9I2ghyOMV7GZNcNjZChpGrYke/mnMkKKXBwEjhPguvIhJd/JTPzUxnPd4Cl+qLBBsfUpnY50e4=
X-Received: by 2002:a05:600c:a44:: with SMTP id c4mr8424172wmq.83.1630877080704;
 Sun, 05 Sep 2021 14:24:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210806134109.1182235-1-james.clark@arm.com> <20210806134109.1182235-5-james.clark@arm.com>
 <44a386f9-7c02-2004-9e81-7c19cd9ce623@arm.com> <YTID5PkUAPHlbD18@kernel.org>
In-Reply-To: <YTID5PkUAPHlbD18@kernel.org>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Sun, 5 Sep 2021 22:24:29 +0100
Message-ID: <CAJ9a7Vj2R7=SnZa9dyyz0whQSUet=NNtv-P98SO6OBBSn8g+uw@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] perf cs-etm: Save TRCDEVARCH register
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Coresight ML <coresight@lists.linaro.org>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Mike Leach <mike.leach@linaro.org>


On Fri, 3 Sept 2021 at 12:15, Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
>
> Em Fri, Sep 03, 2021 at 10:08:22AM +0100, Suzuki K Poulose escreveu:
> > Hi James
> >
> > On 06/08/2021 14:41, James Clark wrote:
> > > When ETE is present save the TRCDEVARCH register and set a new magic
> > > number. It will be used to configure the decoder in a later commit.
> > >
> > > Old versions of perf will not be able to open files with this new magic
> > > number, but old files will still work with newer versions of perf.
> > >
> >
> > The patch looks good to me. There are some minor style related comments
> > below.
> >
> > > Signed-off-by: James Clark <james.clark@arm.com>
> > > ---
> > >   tools/perf/arch/arm/util/cs-etm.c | 49 +++++++++++++++++++++++++++----
> > >   tools/perf/util/cs-etm.c          | 16 ++++++++--
> > >   tools/perf/util/cs-etm.h          | 10 +++++++
> > >   3 files changed, 68 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
> > > index ecb6fa55a210..e3500b79d972 100644
> > > --- a/tools/perf/arch/arm/util/cs-etm.c
> > > +++ b/tools/perf/arch/arm/util/cs-etm.c
> > > @@ -47,15 +47,17 @@ static const char *metadata_etmv3_ro[CS_ETM_PRIV_MAX] = {
> > >     [CS_ETM_ETMIDR]         = "mgmt/etmidr",
> > >   };
> > > -static const char *metadata_etmv4_ro[CS_ETMV4_PRIV_MAX] = {
> > > +static const char * const metadata_etmv4_ro[] = {
> > >     [CS_ETMV4_TRCIDR0]              = "trcidr/trcidr0",
> > >     [CS_ETMV4_TRCIDR1]              = "trcidr/trcidr1",
> > >     [CS_ETMV4_TRCIDR2]              = "trcidr/trcidr2",
> > >     [CS_ETMV4_TRCIDR8]              = "trcidr/trcidr8",
> > >     [CS_ETMV4_TRCAUTHSTATUS]        = "mgmt/trcauthstatus",
> > > +   [CS_ETE_TRCDEVARCH]             = "mgmt/trcdevarch"
> > >   };
> > >   static bool cs_etm_is_etmv4(struct auxtrace_record *itr, int cpu);
> > > +static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu);
> > >   static int cs_etm_set_context_id(struct auxtrace_record *itr,
> > >                              struct evsel *evsel, int cpu)
> > > @@ -533,7 +535,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> > >                   struct evlist *evlist __maybe_unused)
> > >   {
> > >     int i;
> > > -   int etmv3 = 0, etmv4 = 0;
> > > +   int etmv3 = 0, etmv4 = 0, ete = 0;
> > >     struct perf_cpu_map *event_cpus = evlist->core.cpus;
> > >     struct perf_cpu_map *online_cpus = perf_cpu_map__new(NULL);
> > > @@ -544,7 +546,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> > >                         !cpu_map__has(online_cpus, i))
> > >                             continue;
> > > -                   if (cs_etm_is_etmv4(itr, i))
> > > +                   if (cs_etm_is_ete(itr, i))
> > > +                           ete++;
> > > +                   else if (cs_etm_is_etmv4(itr, i))
> > >                             etmv4++;
> > >                     else
> > >                             etmv3++;
> > > @@ -555,7 +559,9 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> > >                     if (!cpu_map__has(online_cpus, i))
> > >                             continue;
> > > -                   if (cs_etm_is_etmv4(itr, i))
> > > +                   if (cs_etm_is_ete(itr, i))
> > > +                           ete++;
> > > +                   else if (cs_etm_is_etmv4(itr, i))
> > >                             etmv4++;
> > >                     else
> > >                             etmv3++;
> > > @@ -565,6 +571,7 @@ cs_etm_info_priv_size(struct auxtrace_record *itr __maybe_unused,
> > >     perf_cpu_map__put(online_cpus);
> > >     return (CS_ETM_HEADER_SIZE +
> > > +          (ete   * CS_ETE_PRIV_SIZE) +
> > >            (etmv4 * CS_ETMV4_PRIV_SIZE) +
> > >            (etmv3 * CS_ETMV3_PRIV_SIZE));
> > >   }
> > > @@ -607,6 +614,27 @@ static int cs_etm_get_ro(struct perf_pmu *pmu, int cpu, const char *path)
> > >     return val;
> > >   }
> > > +#define TRCDEVARCH_ARCHPART_SHIFT 0
> > > +#define TRCDEVARCH_ARCHPART_MASK  GENMASK(11, 0)
> > > +#define TRCDEVARCH_ARCHPART(x)    (((x) & TRCDEVARCH_ARCHPART_MASK) >> TRCDEVARCH_ARCHPART_SHIFT)
> > > +
> > > +#define TRCDEVARCH_ARCHVER_SHIFT 12
> > > +#define TRCDEVARCH_ARCHVER_MASK  GENMASK(15, 12)
> > > +#define TRCDEVARCH_ARCHVER(x)    (((x) & TRCDEVARCH_ARCHVER_MASK) >> TRCDEVARCH_ARCHVER_SHIFT)
> > > +
> > > +static bool cs_etm_is_ete(struct auxtrace_record *itr, int cpu)
> > > +{
> > > +   struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
> > > +   struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> > > +   int trcdevarch = cs_etm_get_ro(cs_etm_pmu, cpu, metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> > > +
> > > +   /*
> > > +    * ETE if ARCHVER is 5 (ARCHVER is 4 for ETM) and ARCHPART is 0xA13.
> > > +    * See ETM_DEVARCH_ETE_ARCH in coresight-etm4x.h
> > > +    */
> > > +   return TRCDEVARCH_ARCHVER(trcdevarch) == 5 && TRCDEVARCH_ARCHPART(trcdevarch) == 0xA13;
> > > +}
> > > +
> > >   static void cs_etm_save_etmv4_header(__u64 data[], struct auxtrace_record *itr, int cpu)
> > >   {
> > >     struct cs_etm_recording *ptr = container_of(itr, struct cs_etm_recording, itr);
> > > @@ -640,7 +668,18 @@ static void cs_etm_get_metadata(int cpu, u32 *offset,
> > >     struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
> > >     /* first see what kind of tracer this cpu is affined to */
> > > -   if (cs_etm_is_etmv4(itr, cpu)) {
> > > +   if (cs_etm_is_ete(itr, cpu)) {
> > > +           magic = __perf_cs_ete_magic;
> > > +           /* ETE uses the same registers as ETMv4 plus TRCDEVARCH */
> > > +           cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
> > > +           info->priv[*offset + CS_ETE_TRCDEVARCH] =
> > > +                   cs_etm_get_ro(cs_etm_pmu, cpu,
> > > +                                 metadata_etmv4_ro[CS_ETE_TRCDEVARCH]);
> > > +
> >
> > minor nit: It may be nicer to have a helper function like we do for etmv4.
> > i.e,
> >               cs_etm_save_ete_header();
> >
> > to keep the code consistent.
> >
> > > +           /* How much space was used */
> > > +           increment = CS_ETE_PRIV_MAX;
> > > +           nr_trc_params = CS_ETE_PRIV_MAX - CS_ETM_COMMON_BLK_MAX_V1;
> > > +   } else if (cs_etm_is_etmv4(itr, cpu)) {
> > >             magic = __perf_cs_etmv4_magic;
> > >             cs_etm_save_etmv4_header(&info->priv[*offset], itr, cpu);
> > > diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
> > > index f4b2bff533f3..d540512a3c96 100644
> > > --- a/tools/perf/util/cs-etm.c
> > > +++ b/tools/perf/util/cs-etm.c
> >
> >
> > >             for (j = 0; j < total_params; j++, i++) {
> > >                     /* if newer record - could be excess params */
> > > -                   if (j >= CS_ETMV4_PRIV_MAX)
> > > +                   if (j >= CS_ETE_PRIV_MAX)
> > >                             fprintf(stdout, param_unk_fmt, j, val[i]);
> > >                     else
> > >                             fprintf(stdout, cs_etmv4_priv_fmts[j], val[i]);
> > > @@ -2943,6 +2949,12 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
> > >                     /* The traceID is our handle */
> > >                     trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> > > +           } else if (ptr[i] == __perf_cs_ete_magic) {
> > > +                   metadata[j] =
> > > +                           cs_etm__create_meta_blk(ptr, &i, CS_ETE_PRIV_MAX, -1);
> >
> > minor nit: I would prefer the arguments to be split into the next line,
> > rather than moving the function call to the next line. i.e,
> >
> >                       metatdata[j] = cs_etm_create_meta_blk(ptr, &i,
> >                                                             ....
>
> He did it for consistency with the previous else blocks, but I think it
> should even be all in just one line, 92 chars is ok, I'd say.
>
> Here I have:
>
>   $ echo $COLUMNS
>   273
>   $
>
> :-)
>
> I did it as there are plenty of other lines in this file that are over
> 100 chars in width.
>
> > > +
> > > +                   /* ETE shares first part of metadata with ETMv4 */
> > > +                   trcidr_idx = CS_ETMV4_TRCTRACEIDR;
> > >             }
> > >             if (!metadata[j]) {
> > > diff --git a/tools/perf/util/cs-etm.h b/tools/perf/util/cs-etm.h
> > > index d65c7b19407d..08b84c21f065 100644
> > > --- a/tools/perf/util/cs-etm.h
> > > +++ b/tools/perf/util/cs-etm.h
> > > @@ -76,6 +76,14 @@ enum {
> > >   /* define fixed version 0 length - allow new format reader to read old files. */
> > >   #define CS_ETMV4_NR_TRC_PARAMS_V0 (CS_ETMV4_TRCAUTHSTATUS - CS_ETMV4_TRCCONFIGR + 1)
> > > +/* ETE metadata is ETMv4 plus TRCDEVARCH register and doesn't support header V0 since it was
> >
> > minor nit: comment style.
> >
> >       /*
> >        * ETE metadata...
> >        *
> >        */
>
> Yeah, being even consistent with other multi line comments on this same
> file.
>
> - Arnaldo



--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
