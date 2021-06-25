Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 846B43B413B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhFYKO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 06:14:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39310 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231202AbhFYKO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 06:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624615926;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PE9EIWF/3w2qUWtzTSSjITswftaaWRHhhvJxur63Vm0=;
        b=UpkODaRR+eCrrjnzYhx0iEJpbqUCA4ogzFFxjF2YKdCdtG/M2hXtE4OKR0vBaO/1Nkj5AU
        ql2LnY9QDBlznDyYfwB9XH7XxRXeZe+JKyn+VPq5wCfhRn1RbiTUlNC5ZKB0vTNPXffNhn
        V2V2vZNOhw40rgOZVuMboccd1ZhFz6Q=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-ON-Ak7DLM3WBoO2XfeC27w-1; Fri, 25 Jun 2021 06:12:05 -0400
X-MC-Unique: ON-Ak7DLM3WBoO2XfeC27w-1
Received: by mail-ed1-f71.google.com with SMTP id w1-20020a0564022681b0290394cedd8a6aso4891385edd.14
        for <Linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 03:12:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=PE9EIWF/3w2qUWtzTSSjITswftaaWRHhhvJxur63Vm0=;
        b=nwFTz97Jdhs6wF+0VtOYYqL/vue/pWlqDT/jGoBYD9UVBcf009PR8NdXMg/pwXtHJW
         N6MLsrFU9l5mqhaGPOg2i2cNUzae9SY/WlJsul+WkAKY3LMnw6Uw3yfoLvbjYfS3l9E7
         xZWknuQ50+sYBLoOCLEoqJJLUQ99WOONXFkiTmB95tpBxmm7R8DLrZ9qP8ZStnAVGQIL
         w/enXBwmfu6qZCGyRlPtPPNYzPbEqAr0PpcYkGiLAS7qX93d2FKZXtna4tTH3i2+lPew
         6p/j67SHuiX6XjqWztHUzribReJLkg/XHKHXKHrWWY2TYydlDundeq2dQQbqCGfuxG/Y
         Er+g==
X-Gm-Message-State: AOAM531jViFRlW1YJkTUoFtMq0NE3enyxu7qUKoN+MlVXvB57ZslG/IF
        VgDeln2bNk/vTZzBhKGaMWXdB6cgpbxLsYhfTGjCMOa+8hTuY6F9fHd6cyxQ3V0Z/UW/yrXuEn3
        2nT+JOrQ95VPmDSVRTMH0bjdq
X-Received: by 2002:a05:6402:35cf:: with SMTP id z15mr13663680edc.208.1624615924076;
        Fri, 25 Jun 2021 03:12:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzwwiJxIZSOGCOwbaENRf7ISFZiLhu3OBhkranzdXvPRxaeRfAAv/nL1ygVQA23xtWR3kn9kw==
X-Received: by 2002:a05:6402:35cf:: with SMTP id z15mr13663656edc.208.1624615923874;
        Fri, 25 Jun 2021 03:12:03 -0700 (PDT)
Received: from krava ([5.171.190.148])
        by smtp.gmail.com with ESMTPSA id t6sm3529908edd.3.2021.06.25.03.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 03:12:02 -0700 (PDT)
Date:   Fri, 25 Jun 2021 12:11:59 +0200
From:   Jiri Olsa <jolsa@redhat.com>
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v1] perf tools: Fix pattern matching for same substring
 used in different pmu type
Message-ID: <YNWr7zsEaNPCn4CR@krava>
References: <20210609045738.1051-1-yao.jin@linux.intel.com>
 <982714a5-8a5d-8f8a-4e30-bd9a497ffa40@linux.intel.com>
 <4787334d-cf28-5b25-8d11-c767c52288f1@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4787334d-cf28-5b25-8d11-c767c52288f1@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 23, 2021 at 10:02:01AM +0800, Jin, Yao wrote:
> Hi Arnaldo, Jiri,
> 
> Any comments for this bug fix patch?
> 
> The issue does impact some uncore events and even some metrics.

sry for delay

SNIP

> > > Some different pmu types may have same substring. For example,
> > > on Icelake server, we have pmu types "uncore_imc" and
> > > "uncore_imc_free_running". Both pmu types have substring "uncore_imc".
> > > But the parser would wrongly think they are the same pmu type.
> > > 
> > > We enable an imc event,
> > > perf stat -e uncore_imc/event=0xe3/ -a -- sleep 1
> > > 
> > > Perf actually expands the event to:
> > > uncore_imc_0/event=0xe3/
> > > uncore_imc_1/event=0xe3/
> > > uncore_imc_2/event=0xe3/
> > > uncore_imc_3/event=0xe3/
> > > uncore_imc_4/event=0xe3/
> > > uncore_imc_5/event=0xe3/
> > > uncore_imc_6/event=0xe3/
> > > uncore_imc_7/event=0xe3/
> > > uncore_imc_free_running_0/event=0xe3/
> > > uncore_imc_free_running_1/event=0xe3/
> > > uncore_imc_free_running_3/event=0xe3/
> > > uncore_imc_free_running_4/event=0xe3/
> > > 
> > > That's because the "uncore_imc_free_running" matches the
> > > pattern "uncore_imc*".
> > > 
> > > Now we check that the last characters of pmu name is
> > > '_<digit>'.
> > > 
> > > Fixes: b2b9d3a3f021 ("perf pmu: Support wildcards on pmu name in dynamic pmu events")
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/util/parse-events.y |  2 ++
> > >   tools/perf/util/pmu.c          | 25 ++++++++++++++++++++++++-
> > >   tools/perf/util/pmu.h          |  1 +
> > >   3 files changed, 27 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > > index aba12a4d488e..7a694c7f7f1a 100644
> > > --- a/tools/perf/util/parse-events.y
> > > +++ b/tools/perf/util/parse-events.y
> > > @@ -317,6 +317,8 @@ event_pmu_name opt_pmu_config
> > >                   strncmp($1, "uncore_", 7))
> > >                   name += 7;
> > >               if (!fnmatch(pattern, name, 0)) {
> > > +                if (!perf_pmu__valid_suffix($1, name))
> > > +                    continue;

could this be part of the fnmatch's pattern?

> > >                   if (parse_events_copy_term_list(orig_terms, &terms))
> > >                       CLEANUP_YYABORT;
> > >                   if (!parse_events_add_pmu(_parse_state, list, pmu->name, terms, true, false))
> > > diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
> > > index 88c8ecdc60b0..78af01959830 100644
> > > --- a/tools/perf/util/pmu.c
> > > +++ b/tools/perf/util/pmu.c
> > > @@ -3,6 +3,7 @@
> > >   #include <linux/compiler.h>
> > >   #include <linux/string.h>
> > >   #include <linux/zalloc.h>
> > > +#include <linux/ctype.h>
> > >   #include <subcmd/pager.h>
> > >   #include <sys/types.h>
> > >   #include <errno.h>
> > > @@ -768,7 +769,7 @@ bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
> > >        */
> > >       for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
> > >           name = strstr(name, tok);
> > > -        if (!name) {
> > > +        if (!name || !perf_pmu__valid_suffix(tok, (char *)name)) {
> > >               res = false;
> > >               goto out;
> > >           }
> > > @@ -1872,3 +1873,25 @@ bool perf_pmu__has_hybrid(void)
> > >       return !list_empty(&perf_pmu__hybrid_pmus);
> > >   }
> > > +
> > > +bool perf_pmu__valid_suffix(char *tok, char *pmu_name)
> > > +{
> > > +    char *p;
> > > +
> > > +    /*
> > > +     * The pmu_name has substring tok. If the format of
> > > +     * pmu_name is <tok> or <tok>_<digit>, return true.
> > > +     */
> > > +    p = pmu_name + strlen(tok);
> > > +    if (*p == 0)
> > > +        return true;
> > > +
> > > +    if (*p != '_')
> > > +        return false;
> > > +
> > > +    ++p;
> > > +    if (*p == 0 || !isdigit(*p))
> > > +        return false;
> > > +
> > > +    return true;
> > > +}

hum, so we have pattern serch and then another function checking
if that search was ok.. I understand that's convenient, because
it's on 2 different places, but could we have some generic solution,
line one function/search that returns/search for valid pmu name?

thanks,
jirka

