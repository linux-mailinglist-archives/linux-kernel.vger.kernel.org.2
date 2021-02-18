Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91031F036
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 20:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhBRTne (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Feb 2021 14:43:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:53946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233734AbhBRTM1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Feb 2021 14:12:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5E45064E6F;
        Thu, 18 Feb 2021 19:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613675506;
        bh=W6FbYZcDa4fCCk3chYeIBXg9qK0sWVNYW3DzjCGJpXY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eL+4ALNRdzODd6rQyzKSHtUjPaTGMIyYTMPitPbPbGbQTOrhPGkRnx5+olVQhkOk5
         hwTJL9JsvVX9fRNGgnTRFFrSEXuWAohEuKrCqapERo7w7mrgHTS6pEDOcHb+5lYp5+
         UHbtj3SLHVqr6c3Yy3GQ7so5SCDKcAUb35IHfijW/m5SJfhGL9LTjjxHkszAZITJz+
         f2CzjO3qrebEepmXcLqhSzCOBVWdYCqA359eNywsVD8BjjmwyKO7u/lU+nw/L/GXV0
         LWsELJEquAiMYabo9wneOF60F11sSdDvhYokIMXMmbkSoAAsmlOdrnTog6jjwEzLF6
         LDrTWMUThUlyg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 33E6B40CD9; Thu, 18 Feb 2021 16:11:44 -0300 (-03)
Date:   Thu, 18 Feb 2021 16:11:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf auxtrace: Automatically group aux-output events
Message-ID: <YC678HNaG41BF9MN@kernel.org>
References: <20210121140418.14705-1-adrian.hunter@intel.com>
 <20210123231125.GC138414@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210123231125.GC138414@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Jan 24, 2021 at 12:11:25AM +0100, Jiri Olsa escreveu:
> On Thu, Jan 21, 2021 at 04:04:18PM +0200, Adrian Hunter wrote:
> > aux-output events need to have an AUX area event as the group leader.
> > However, grouping events does not allow the AUX area event to be given
> > an address filter because the --filter option must come after the event,
> > which conflicts with the grouping syntax.
> > 
> > To allow filtering in that case, automatically create a group since that
> > is the requirement anyway.
> > 
> > Example: (requires Intel Tremont)
> > 
> >   perf record -c 500 -e 'intel_pt//u' --filter 'filter main @ /bin/ls' -e 'cycles/aux-output/pp' ls
> 
> great, nice to see this working

Thanks, applied.

- Arnaldo

 
> jirka
> 
> > 
> > Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> > ---
> >  tools/perf/builtin-record.c |  2 ++
> >  tools/perf/util/auxtrace.c  | 15 +++++++++++++++
> >  tools/perf/util/auxtrace.h  |  6 ++++++
> >  3 files changed, 23 insertions(+)
> > 
> > diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
> > index 8a0127d4fb52..687f1449a845 100644
> > --- a/tools/perf/builtin-record.c
> > +++ b/tools/perf/builtin-record.c
> > @@ -731,6 +731,8 @@ static int record__auxtrace_init(struct record *rec)
> >  	if (err)
> >  		return err;
> >  
> > +	auxtrace_regroup_aux_output(rec->evlist);
> > +
> >  	return auxtrace_parse_filters(rec->evlist);
> >  }
> >  
> > diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
> > index a60878498139..953f4afacd3b 100644
> > --- a/tools/perf/util/auxtrace.c
> > +++ b/tools/perf/util/auxtrace.c
> > @@ -788,6 +788,21 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr,
> >  	return auxtrace_validate_aux_sample_size(evlist, opts);
> >  }
> >  
> > +void auxtrace_regroup_aux_output(struct evlist *evlist)
> > +{
> > +	struct evsel *evsel, *aux_evsel = NULL;
> > +	struct evsel_config_term *term;
> > +
> > +	evlist__for_each_entry(evlist, evsel) {
> > +		if (evsel__is_aux_event(evsel))
> > +			aux_evsel = evsel;
> > +		term = evsel__get_config_term(evsel, AUX_OUTPUT);
> > +		/* If possible, group with the AUX event */
> > +		if (term && aux_evsel)
> > +			evlist__regroup(evlist, aux_evsel, evsel);
> > +	}
> > +}
> > +
> >  struct auxtrace_record *__weak
> >  auxtrace_record__init(struct evlist *evlist __maybe_unused, int *err)
> >  {
> > diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
> > index 7e5c9e1552bd..a4fbb33b7245 100644
> > --- a/tools/perf/util/auxtrace.h
> > +++ b/tools/perf/util/auxtrace.h
> > @@ -559,6 +559,7 @@ int auxtrace_parse_snapshot_options(struct auxtrace_record *itr,
> >  int auxtrace_parse_sample_options(struct auxtrace_record *itr,
> >  				  struct evlist *evlist,
> >  				  struct record_opts *opts, const char *str);
> > +void auxtrace_regroup_aux_output(struct evlist *evlist);
> >  int auxtrace_record__options(struct auxtrace_record *itr,
> >  			     struct evlist *evlist,
> >  			     struct record_opts *opts);
> > @@ -740,6 +741,11 @@ int auxtrace_parse_sample_options(struct auxtrace_record *itr __maybe_unused,
> >  	return -EINVAL;
> >  }
> >  
> > +static inline
> > +void auxtrace_regroup_aux_output(struct evlist *evlist __maybe_unused)
> > +{
> > +}
> > +
> >  static inline
> >  int auxtrace__process_event(struct perf_session *session __maybe_unused,
> >  			    union perf_event *event __maybe_unused,
> > -- 
> > 2.17.1
> > 
> 

-- 

- Arnaldo
