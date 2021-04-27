Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487EE36C675
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbhD0Myo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 08:54:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:35348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235426AbhD0Mym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 08:54:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C623610A5;
        Tue, 27 Apr 2021 12:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619528039;
        bh=0wPMFSzfumuWdxhjKufVDIU2f/5A7naNmjXmYtbwGwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dcww0GN7G8SfGSNjBYdpLUl5wDXxrkOz3Hy+oN49P5JKEJtiZvf3LhbE0nx5mieL1
         PqIZVl9RzMaOpEmoQyr69SWwhPw5nXOASfA6AiwChsIp1DacWRZWnq40LfQzQoFFT6
         tIht2Itr4jTUsLxjjaznMsIIM1pmGhK98ujbXSogeuJUm+93Poa9VFI8YlWZSKtF68
         z8U1/zKur20q/1uQq+gf3Kt9mnDredMc7Vf5Aw6VEJ7f9r66I5L7ZeEfxlyajYaLmA
         v7T9fbcqwI0vG2K2ahLxZ5yBymvDEakdzi5m7hSWwbsx2tK6eWv4KbbWOPUclNfXTZ
         F6oaWxjT5f5Yw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0A94640647; Tue, 27 Apr 2021 09:53:56 -0300 (-03)
Date:   Tue, 27 Apr 2021 09:53:55 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Nicholas Fraser <nfraser@codeweavers.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Changbin Du <changbin.du@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Ulrich Czekalla <uczekalla@codeweavers.com>
Subject: Re: [PATCH v2] perf data: Add JSON export
Message-ID: <YIgJY5jejgvTWqmR@kernel.org>
References: <3884969f-804d-2f53-c648-e2b0bd85edff@codeweavers.com>
 <YIch1aRwL4Lk7iWJ@kernel.org>
 <YIcvjFr/hN2Syybc@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIcvjFr/hN2Syybc@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Apr 26, 2021 at 06:24:29PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Apr 26, 2021 at 05:25:58PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Mon, Apr 26, 2021 at 10:47:16AM -0400, Nicholas Fraser escreveu:
> > > This adds a feature to export perf data to JSON.
> > > 
> > > The resolved symbols are exported into the JSON so that external tools
> > > don't need to load the dsos themselves (or even have access to them at
> > > all.) This makes it easy to load and analyze perf data with standalone
> > > tools where direct perf or libbabeltrace integration is impractical.
> > > 
> > > The exporter uses a minimal inline JSON encoding without any external
> > > dependencies. Currently it only outputs some headers and sample metadata
> > > but it's easily extensible.
> > > 
> > > Use it like this:
> > > 
> > > perf data convert --to-json out.json
> 
> One more, clang complains:
> 
>    7    50.92 alpine:3.10                   : FAIL gcc version 8.3.0 (Alpine 8.3.0)
>     util/data-convert-json.c:126:32: error: address of array 'al->sym->name' will always evaluate to 'true' [-Werror,-Wpointer-bool-conversion]
>             if (al && al->sym && al->sym->name && strlen(al->sym->name) > 0) {
>                               ~~ ~~~~~~~~~^~~~
>     1 error generated.
>     make[3]: *** [/git/perf-5.12.0/tools/build/Makefile.build:139: util] Error 2

So the fix is the one below, applied and tested, thanks.

- Arnaldo

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index f24593d57f80be1b..355cd1948bdf006a 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -123,7 +123,7 @@ static void output_sample_callchain_entry(struct perf_tool *tool,
 	output_json_format(out, false, 4, "{");
 	output_json_key_format(out, false, 5, "ip", "\"0x%" PRIx64 "\"", ip);
 
-	if (al && al->sym && al->sym->name && strlen(al->sym->name) > 0) {
+	if (al && al->sym && al->sym->namelen) {
 		fputc(',', out);
 		output_json_key_string(out, false, 5, "symbol", al->sym->name);
 
