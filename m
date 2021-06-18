Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C5D53ACBD8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 15:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbhFRNQQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 09:16:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhFRNQP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 09:16:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D18CA608FC;
        Fri, 18 Jun 2021 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624022046;
        bh=Vhw2bavG97DxbteynC+3b57+ILuhQuvVwoJc1tc9rt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E8Uf8+CqYxhOpbZf6WdTEqaBOQFT/7XRGP+/3P+6Kso5XuhD0deVR6eLGyZRkVkrE
         Q29WeU6gSpWOqMjIgYBanbqeBUCYKebVRU0yqf5fAJKwzfU6N6wrvjEXYamor6vuWA
         TJw17JuTLkzLaiuNYj2LulLxBggW+avBEDPs+grCMXnOh+u+K7WtxdFnhbUaHmbRqW
         Gt+5SiDId9Zd0YuOIbWX8Vis1GM743e6URuiaH0XM70ZKtm+2xwlRHseFdddeOCUvd
         KLCyJd/EZMBJcUEQz+bsb5oaaTIkkGlij4fmVgpKxoUwgdO8J92b+aFPJAkRNy5qcg
         25NW7bCyJoA+A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 7AEFD40B1A; Fri, 18 Jun 2021 10:14:02 -0300 (-03)
Date:   Fri, 18 Jun 2021 10:14:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 3/3] perf/probe: Add --bootconfig to output definition in
 bootconfig format
Message-ID: <YMycGkhkPuo4xTc4@kernel.org>
References: <162282409255.452340.4645118932261585719.stgit@devnote2>
 <162282412351.452340.14871995440005640114.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <162282412351.452340.14871995440005640114.stgit@devnote2>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jun 05, 2021 at 01:28:43AM +0900, Masami Hiramatsu escreveu:
> Now the boot-time tracing supports the kprobes events and that
> must be written in bootconfig file as following format.
> 
> ftrace.event.kprobes.<EVENT_NAME>.probes = <PROBE-DEF>
> 
> The perf probe already supports --definition (-D) action to
> show the probe definitions, but the format is for the tracefs.

You forgot to add the tools/perf/Documentation/perf-probe.txt entry for
this new command line option, please sent it as a followup patch.

Applied.

- Arnaldo
 
> [p|r][:EVENT_NAME] <PROBE-DEF>
> 
> This adds --bootconfig option for -D action so that it output
> the probe definitions in bootconfig fromat. E.g.
> 
>  $ perf probe --bootconfig -D "path_lookupat:7 err:s32 s:string"
>  ftrace.event.kprobes.path_lookupat_L7.probe = 'path_lookupat.isra.0+309 err_s32=%ax:s32 s_string=+0(%r13):string'
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  tools/perf/builtin-probe.c    |   12 ++++++-
>  tools/perf/util/probe-event.c |   72 +++++++++++++++++++++++++++++++++++++++++
>  tools/perf/util/probe-event.h |    2 +
>  3 files changed, 85 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/perf/builtin-probe.c b/tools/perf/builtin-probe.c
> index 6b1507566770..2bfd41df621c 100644
> --- a/tools/perf/builtin-probe.c
> +++ b/tools/perf/builtin-probe.c
> @@ -347,7 +347,10 @@ static int perf_add_probe_events(struct perf_probe_event *pevs, int npevs)
>  		goto out_cleanup;
>  
>  	if (params.command == 'D') {	/* it shows definition */
> -		ret = show_probe_trace_events(pevs, npevs);
> +		if (probe_conf.bootconfig)
> +			ret = show_bootconfig_events(pevs, npevs);
> +		else
> +			ret = show_probe_trace_events(pevs, npevs);
>  		goto out_cleanup;
>  	}
>  
> @@ -581,6 +584,8 @@ __cmd_probe(int argc, const char **argv)
>  		   "Look for files with symbols relative to this directory"),
>  	OPT_CALLBACK(0, "target-ns", NULL, "pid",
>  		     "target pid for namespace contexts", opt_set_target_ns),
> +	OPT_BOOLEAN(0, "bootconfig", &probe_conf.bootconfig,
> +		    "Output probe definition with bootconfig format"),
>  	OPT_END()
>  	};
>  	int ret;
> @@ -692,6 +697,11 @@ __cmd_probe(int argc, const char **argv)
>  		}
>  		break;
>  	case 'D':
> +		if (probe_conf.bootconfig && params.uprobes) {
> +			pr_err("  Error: --bootconfig doesn't support uprobes.\n");
> +			return -EINVAL;
> +		}
> +		__fallthrough;
>  	case 'a':
>  
>  		/* Ensure the last given target is used */
> diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
> index 505c0702dbe2..f1348fa3dd1b 100644
> --- a/tools/perf/util/probe-event.c
> +++ b/tools/perf/util/probe-event.c
> @@ -3564,6 +3564,78 @@ int show_probe_trace_events(struct perf_probe_event *pevs, int npevs)
>  	return ret;
>  }
>  
> +static int show_bootconfig_event(struct probe_trace_event *tev)
> +{
> +	struct probe_trace_point *tp = &tev->point;
> +	struct strbuf buf;
> +	char *ret = NULL;
> +	int err;
> +
> +	if (strbuf_init(&buf, 32) < 0)
> +		return -ENOMEM;
> +
> +	err = synthesize_kprobe_trace_def(tp, &buf);
> +	if (err >= 0)
> +		err = synthesize_probe_trace_args(tev, &buf);
> +	if (err >= 0)
> +		ret = strbuf_detach(&buf, NULL);
> +	strbuf_release(&buf);
> +
> +	if (ret) {
> +		printf("'%s'", ret);
> +		free(ret);
> +	}
> +
> +	return err;
> +}
> +
> +int show_bootconfig_events(struct perf_probe_event *pevs, int npevs)
> +{
> +	struct strlist *namelist = strlist__new(NULL, NULL);
> +	struct probe_trace_event *tev;
> +	struct perf_probe_event *pev;
> +	char *cur_name = NULL;
> +	int i, j, ret = 0;
> +
> +	if (!namelist)
> +		return -ENOMEM;
> +
> +	for (j = 0; j < npevs && !ret; j++) {
> +		pev = &pevs[j];
> +		if (pev->group && strcmp(pev->group, "probe"))
> +			pr_warning("WARN: Group name %s is ignored\n", pev->group);
> +		if (pev->uprobes) {
> +			pr_warning("ERROR: Bootconfig doesn't support uprobes\n");
> +			ret = -EINVAL;
> +			break;
> +		}
> +		for (i = 0; i < pev->ntevs && !ret; i++) {
> +			tev = &pev->tevs[i];
> +			/* Skip if the symbol is out of .text or blacklisted */
> +			if (!tev->point.symbol && !pev->uprobes)
> +				continue;
> +
> +			/* Set new name for tev (and update namelist) */
> +			ret = probe_trace_event__set_name(tev, pev,
> +							  namelist, true);
> +			if (ret)
> +				break;
> +
> +			if (!cur_name || strcmp(cur_name, tev->event)) {
> +				printf("%sftrace.event.kprobes.%s.probe = ",
> +					cur_name ? "\n" : "", tev->event);
> +				cur_name = tev->event;
> +			} else
> +				printf(", ");
> +			ret = show_bootconfig_event(tev);
> +		}
> +	}
> +	printf("\n");
> +	strlist__delete(namelist);
> +
> +	return ret;
> +}
> +
>  int apply_perf_probe_events(struct perf_probe_event *pevs, int npevs)
>  {
>  	int i, ret = 0;
> diff --git a/tools/perf/util/probe-event.h b/tools/perf/util/probe-event.h
> index 4f0eb3a20c36..65769d7949a3 100644
> --- a/tools/perf/util/probe-event.h
> +++ b/tools/perf/util/probe-event.h
> @@ -15,6 +15,7 @@ struct probe_conf {
>  	bool	force_add;
>  	bool	no_inlines;
>  	bool	cache;
> +	bool	bootconfig;
>  	int	max_probes;
>  	unsigned long	magic_num;
>  };
> @@ -163,6 +164,7 @@ int add_perf_probe_events(struct perf_probe_event *pevs, int npevs);
>  int convert_perf_probe_events(struct perf_probe_event *pevs, int npevs);
>  int apply_perf_probe_events(struct perf_probe_event *pevs, int npevs);
>  int show_probe_trace_events(struct perf_probe_event *pevs, int npevs);
> +int show_bootconfig_events(struct perf_probe_event *pevs, int npevs);
>  void cleanup_perf_probe_events(struct perf_probe_event *pevs, int npevs);
>  
>  struct strfilter;
> 

-- 

- Arnaldo
