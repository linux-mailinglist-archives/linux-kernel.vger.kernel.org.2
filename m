Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80347365731
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 13:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhDTLLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 07:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230408AbhDTLLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 07:11:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 18B1760232;
        Tue, 20 Apr 2021 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618917031;
        bh=w0FRQodGWakmPnYMK0KmC1dYxddRJwzHm6cr9r+pO0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p4OFgLhVW5PFrJ+F8UH5UV3/77KhGzxgDbwDohJtGq3CN885lKlg2HGcGKfkTR6B1
         6tfANhwPV9qVv64hUn4cGmAs+Zktm3yq9+UBIOigoSkCu9SXF9XMyijtN7zCa+3oBk
         z7HLgx6t8+X14CFCjly14kpH5/cLHC4ck1Xdq+4Aspz7Pw6C1W8gckoMGF/w16GQxE
         2Bmoz6sHIYMUKJX3XxjZfbgIA8+vTJyPt9ZbPXCw6RvOqIy6UG1akHkRU7dOh0Ku6i
         RTAid6t3IdN/bsLn91YhfqACPZpn3ynmxlD0mjQNsuiRnmbplJ6gc4n853InWwPva4
         YpG9s1V1Z6tsg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6DA0B40647; Tue, 20 Apr 2021 08:10:27 -0300 (-03)
Date:   Tue, 20 Apr 2021 08:10:27 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Itaru Kitayama <itaru.kitayama@gmail.com>
Subject: Re: [PATCH v8 4/4] libperf: Add support for user space counter access
Message-ID: <YH62o3A6DXQPiylT@kernel.org>
References: <20210414155412.3697605-1-robh@kernel.org>
 <20210414155412.3697605-4-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414155412.3697605-4-robh@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 14, 2021 at 11:07:39AM -0500, Rob Herring escreveu:
> x86 and arm64 can both support direct access of event counters in
> userspace. The access sequence is less than trivial and currently exists
> in perf test code (tools/perf/arch/x86/tests/rdpmc.c) with copies in
> projects such as PAPI and libpfm4.
> 
> In order to support usersapce access, an event must be mmapped first
> with perf_evsel__mmap(). Then subsequent calls to perf_evsel__read()
> will use the fast path (assuming the arch supports it).

Had to apply this to fix the build on the other arches:
 
> +#if defined(__i386__) || defined(__x86_64__)
> +static u64 read_perf_counter(unsigned int counter)
> +{
> +	unsigned int low, high;
> +
> +	asm volatile("rdpmc" : "=a" (low), "=d" (high) : "c" (counter));
> +
> +	return low | ((u64)high) << 32;
> +}
> +
> +static u64 read_timestamp(void)
> +{
> +	unsigned int low, high;
> +
> +	asm volatile("rdtsc" : "=a" (low), "=d" (high));
> +
> +	return low | ((u64)high) << 32;
> +}
> +#else
> +static u64 read_perf_counter(unsigned int counter) { return 0; }
> +static u64 read_timestamp(void) { return 0; }
> +#endif

diff --git a/tools/lib/perf/mmap.c b/tools/lib/perf/mmap.c
index 915469f00cf4c3fb..c89dfa5f67b3a408 100644
--- a/tools/lib/perf/mmap.c
+++ b/tools/lib/perf/mmap.c
@@ -295,7 +295,7 @@ static u64 read_timestamp(void)
 	return low | ((u64)high) << 32;
 }
 #else
-static u64 read_perf_counter(unsigned int counter) { return 0; }
+static u64 read_perf_counter(unsigned int counter __maybe_unused) { return 0; }
 static u64 read_timestamp(void) { return 0; }
 #endif
 
