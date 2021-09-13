Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04FE5409D26
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241551AbhIMTfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:35:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235290AbhIMTfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:35:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AD33C610D1;
        Mon, 13 Sep 2021 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631561669;
        bh=g0tIIdgSDeIurjAE/QD6sn73WxhdlEKzfqhQN39LJK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aBem/p5lSBs9iB9zsb0fNODAumEfxGDVQlj9nZQ1fQgMPXKi2BRV0jR//MD8vFVum
         KbGgnaPlr2HEB4zP7TKR0Sk/g11zYNxoBv+a29k66IjZDoB8D7mFR6fhTYQzhI53bC
         x2x4C6O828dB4lH1o0TfYlLAg2+l+ee8IgqDDiWdBn/oA1EsRnDa2l4i6CxT8r+S/w
         oIvJ9pE1aNAusa6H06iLqwo2OUDUkxE+thzJtLXXVM0QKrhR0zlNh4Kena2Agg3fck
         haFt870alDb/CG1q8H+erJpEWTIYupDdPyni1GSXpjla04JTR06vWuZ3PJqBVhmizR
         y4/pyeG0ZGtXw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 10BC04038F; Mon, 13 Sep 2021 16:34:25 -0300 (-03)
Date:   Mon, 13 Sep 2021 16:34:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        acme@redhat.com, jolsa@redhat.com, kim.phillips@amd.com,
        namhyung@kernel.org, irogers@google.com
Subject: Re: [PATCH v1 11/13] perf tools: improve IBS error handling
Message-ID: <YT+nwP3jrzgxEdmu@kernel.org>
References: <20210909075700.4025355-1-eranian@google.com>
 <20210909075700.4025355-12-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210909075700.4025355-12-eranian@google.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Sep 09, 2021 at 12:56:58AM -0700, Stephane Eranian escreveu:
> From: Kim Phillips <kim.phillips@amd.com>
> 
> This patch improves the error message returned on failed perf_event_open() on
> AMD when using IBS.
> 
> Signed-off-by: Kim Phillips <kim.phillips@amd.com>
> ---
>  tools/perf/util/evsel.c | 42 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
> 
> diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
> index f61e5dd53f5d..f203f178fdb9 100644
> --- a/tools/perf/util/evsel.c
> +++ b/tools/perf/util/evsel.c
> @@ -2684,12 +2684,52 @@ static bool find_process(const char *name)
>  	return ret ? false : true;
>  }
>  
> +static bool is_amd;
> +
> +static char *fgrep(FILE *inf, const char *str)
> +{
> +	char line[256];
> +	int slen = strlen(str);
> +
> +	while (!feof(inf)) {
> +		if (!fgets(line, 256, inf))
> +			break;
> +		if (strncmp(line, str, slen))
> +			continue;
> +
> +		return strdup(line);
> +	}
> +
> +	return NULL;
> +}
> +
> +static void detect_amd(void)
> +{
> +	FILE *inf = fopen("/proc/cpuinfo", "r");
> +	char *res;
> +
> +	if (!inf)
> +		return;
> +
> +	res = fgrep(inf, "vendor_id");
> +
> +	if (res) {
> +		char *s = strchr(res, ':');
> +
> +		is_amd = s && !strcmp(s, ": AuthenticAMD\n");
> +		free(res);
> +	}
> +	fclose(inf);
> +}
> +

We have perf_env for such details, for instance in
tools/perf/util/sample-raw.c we have:o

        const char *arch_pf = perf_env__arch(evlist->env);
        const char *cpuid = perf_env__cpuid(evlist->env);

	        else if (arch_pf && !strcmp("x86", arch_pf) &&
                 cpuid && strstarts(cpuid, "AuthenticAMD") &&
                 evlist__has_amd_ibs(evlist)) {



>  int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			 int err, char *msg, size_t size)
>  {
>  	char sbuf[STRERR_BUFSIZE];
>  	int printed = 0, enforced = 0;
>  
> +	detect_amd();
> +
>  	switch (err) {
>  	case EPERM:
>  	case EACCES:
> @@ -2782,6 +2822,8 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
>  			return scnprintf(msg, size, "wrong clockid (%d).", clockid);
>  		if (perf_missing_features.aux_output)
>  			return scnprintf(msg, size, "The 'aux_output' feature is not supported, update the kernel.");
> +		if (is_amd && (evsel->core.attr.precise_ip || !strncmp(evsel->pmu_name, "ibs", 3)) && (evsel->core.attr.exclude_kernel))
> +			return scnprintf(msg, size, "AMD IBS can't exclude kernel events.  Try running at a higher privilege level.");
>  		break;
>  	case ENODATA:
>  		return scnprintf(msg, size, "Cannot collect data source with the load latency event alone. "
> -- 
> 2.33.0.153.gba50c8fa24-goog

-- 

- Arnaldo
