Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFF031D9CB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhBQM4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:56:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:55590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230328AbhBQM41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:56:27 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 48C5464D92;
        Wed, 17 Feb 2021 12:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613566546;
        bh=17RKUiyV8HYsvPwtxjJkOW8n5oqEmDDV+0F6V0Ytj4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZmkVLoxLNnEGMM9bfr6m1g7nEMoaWnME/cx6wMwrS54qslEntPbV3V6pvIlIj3QZd
         TMNxBCOnGkftd3Pi30Cwwrff/RqnsHvv5ykw4ya1XPxbLyW2U1ufTgxzee7DczsCfA
         t5BFe98C1I6cDmOhecY2vrtIHGMYKCbDXRfXaePOA1ZG15pe12K0C9jXgnej793/Qn
         i/Joxt9U5LZKGjYd2hSA1kjqiKNlbIDRtStcFOh3m+YabS5lKdJjb9pVa4VxolCNnO
         qdnXMbl5waqWit13q5ej3zeStVsRcrmrlHYlfy4+lj1rAvgCWpwq9uMNTSuj4rjojt
         NQO27m/LLDrMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 080E640CD9; Wed, 17 Feb 2021 09:55:44 -0300 (-03)
Date:   Wed, 17 Feb 2021 09:55:43 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jianlin Lv <Jianlin.Lv@arm.com>
Cc:     john.garry@huawei.com, will@kernel.org, mathieu.poirier@linaro.org,
        leo.yan@linaro.org, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, irogers@google.com,
        agerstmayr@redhat.com, kan.liang@linux.intel.com,
        adrian.hunter@intel.com, iecedge@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] perf tools: Fix arm64 build error with gcc-11
Message-ID: <YC0ST0Q24LuCboKr@kernel.org>
References: <20210217115830.1414355-1-Jianlin.Lv@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210217115830.1414355-1-Jianlin.Lv@arm.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 17, 2021 at 07:58:30PM +0800, Jianlin Lv escreveu:
> gcc version: 11.0.0 20210208 (experimental) (GCC)
> 
> Following build error on arm64:
> 
> .......
> In function ‘printf’,
>     inlined from ‘regs_dump__printf’ at util/session.c:1141:3,
>     inlined from ‘regs__printf’ at util/session.c:1169:2:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:107:10: \
>   error: ‘%-5s’ directive argument is null [-Werror=format-overflow=]
> 
> 107 |   return __printf_chk (__USE_FORTIFY_LEVEL - 1, __fmt, \
>                 __va_arg_pack ());
> 
> ......
> In function ‘fprintf’,
>   inlined from ‘perf_sample__fprintf_regs.isra’ at \
>     builtin-script.c:622:14:
> /usr/include/aarch64-linux-gnu/bits/stdio2.h:100:10: \
>     error: ‘%5s’ directive argument is null [-Werror=format-overflow=]
>   100 |   return __fprintf_chk (__stream, __USE_FORTIFY_LEVEL - 1, __fmt,
>   101 |                         __va_arg_pack ());
> 
> cc1: all warnings being treated as errors
> .......
> 
> This patch fixes Wformat-overflow warnings. Add helper function to
> convert NULL to "unknown".

I think this is the right approach, but since both return a string, it
is strange that only one of them have its _str() at the end, what we
usually do in such cases is to have:

  const char *__perf_reg_name(int id)
  {
  	return NULL if id unknown;
  }

  And:

  static inline const char *perf_reg_name(int id)
  {
  	const char *name = __perf_reg_name(id);
	return name ?: "unknown";
  }

Ok?

- Arnaldo
 
> Signed-off-by: Jianlin Lv <Jianlin.Lv@arm.com>
> ---
> v2: Add ternary operator to avoid similar errors in other arch.
> v3: Declared reg_name in inner block.
> v4: Add helper function: perf_reg_name_str, update changelog.
> ---
>  tools/perf/builtin-script.c                           |  2 +-
>  tools/perf/util/perf_regs.h                           | 11 ++++++++++-
>  .../perf/util/scripting-engines/trace-event-python.c  |  2 +-
>  tools/perf/util/session.c                             |  2 +-
>  4 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
> index 42dad4a0f8cf..35cddca2c7a7 100644
> --- a/tools/perf/builtin-script.c
> +++ b/tools/perf/builtin-script.c
> @@ -643,7 +643,7 @@ static int perf_sample__fprintf_regs(struct regs_dump *regs, uint64_t mask,
>  
>  	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
>  		u64 val = regs->regs[i++];
> -		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name(r), val);
> +		printed += fprintf(fp, "%5s:0x%"PRIx64" ", perf_reg_name_str(r), val);
>  	}
>  
>  	return printed;
> diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
> index a45499126184..e4a0a6f5408e 100644
> --- a/tools/perf/util/perf_regs.h
> +++ b/tools/perf/util/perf_regs.h
> @@ -33,13 +33,22 @@ extern const struct sample_reg sample_reg_masks[];
>  
>  int perf_reg_value(u64 *valp, struct regs_dump *regs, int id);
>  
> +static inline const char *perf_reg_name_str(int id)
> +{
> +	const char *str = perf_reg_name(id);
> +
> +	if (!str)
> +		return "unknown";
> +	return str;
> +}
> +
>  #else
>  #define PERF_REGS_MASK	0
>  #define PERF_REGS_MAX	0
>  
>  #define DWARF_MINIMAL_REGS PERF_REGS_MASK
>  
> -static inline const char *perf_reg_name(int id __maybe_unused)
> +static inline const char *perf_reg_name_str(int id __maybe_unused)
>  {
>  	return "unknown";
>  }
> diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
> index c83c2c6564e0..361307026485 100644
> --- a/tools/perf/util/scripting-engines/trace-event-python.c
> +++ b/tools/perf/util/scripting-engines/trace-event-python.c
> @@ -702,7 +702,7 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
>  
>  		printed += scnprintf(bf + printed, size - printed,
>  				     "%5s:0x%" PRIx64 " ",
> -				     perf_reg_name(r), val);
> +				     perf_reg_name_str(r), val);
>  	}
>  
>  	return printed;
> diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
> index 25adbcce0281..0737d3e7e698 100644
> --- a/tools/perf/util/session.c
> +++ b/tools/perf/util/session.c
> @@ -1140,7 +1140,7 @@ static void regs_dump__printf(u64 mask, u64 *regs)
>  		u64 val = regs[i++];
>  
>  		printf(".... %-5s 0x%016" PRIx64 "\n",
> -		       perf_reg_name(rid), val);
> +		       perf_reg_name_str(rid), val);
>  	}
>  }
>  
> -- 
> 2.25.1
> 

-- 

- Arnaldo
