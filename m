Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43C553FC26D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 08:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbhHaGGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 02:06:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:53801 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238919AbhHaGE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 02:04:58 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10092"; a="197967862"
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="197967862"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2021 23:04:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,365,1620716400"; 
   d="scan'208";a="498101151"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2021 23:04:00 -0700
Subject: Re: [PATCH] Add --sysroot when building dlfilters on cross build
 environments
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <YS1JwIMTNNWcbGdT@kernel.org>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <ba4c0d9a-6e80-41b3-24e3-5073353b298e@intel.com>
Date:   Tue, 31 Aug 2021 09:04:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YS1JwIMTNNWcbGdT@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/08/21 12:12 am, Arnaldo Carvalho de Melo wrote:
> Hi Adrian,
> 
> 	I had to add this cset to fix the build/link on cross build
> environments with a sysroot, like Android, EXTRA_CFLAGS is where it will
> get the needed --sysroot=/opt/android-ndk-r12b//platforms/android-24/arch-arm, please ack.
> 
> - Arnaldo
> 
> diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
> index 24623599113df215..e04313c4d8409a94 100644
> --- a/tools/perf/Makefile.perf
> +++ b/tools/perf/Makefile.perf
> @@ -785,10 +785,10 @@ endif
>  
>  $(OUTPUT)dlfilters/%.o: dlfilters/%.c include/perf/perf_dlfilter.h
>  	$(Q)$(MKDIR) -p $(OUTPUT)dlfilters
> -	$(QUIET_CC)$(CC) -c -Iinclude -o $@ -fpic $<
> +	$(QUIET_CC)$(CC) -c -Iinclude $(EXTRA_CFLAGS) -o $@ -fpic $<
>  
>  $(OUTPUT)dlfilters/%.so: $(OUTPUT)dlfilters/%.o
> -	$(QUIET_LINK)$(CC) -shared -o $@ $<
> +	$(QUIET_LINK)$(CC) $(EXTRA_CFLAGS) -shared -o $@ $<
>  
>  ifndef NO_JVMTI
>  LIBJVMTI_IN := $(OUTPUT)jvmti/jvmti-in.o
> 

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
