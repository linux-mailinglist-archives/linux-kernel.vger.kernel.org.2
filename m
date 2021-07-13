Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04EC63C76B9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 20:54:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234061AbhGMS5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 14:57:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMS5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 14:57:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 666D460FEB;
        Tue, 13 Jul 2021 18:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626202452;
        bh=svx4BysCDN++nwq/Uq7Id8auGbV4pq5BbTPAk7gpD6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EA3gkdtjXdaxENdJpfXVN63km87jTp3narHN04n2MUypo8tVbHvLhQW1jIvb4VgHA
         MkvbqJsHfiraaaouaS4qJ6YB1B/O3Z0Daq9d/7MH4AYCg54rhL+8rxqECra5f1cS9T
         IKNVKAR91WpKuapaJQsyvc0Vee+JDN/iApGyen4h9lc4f3ECC7VK0U29nlQQkK4lxo
         Sj5erUOL45lD78pQDqBEk/v8a6oInE7pOokjcqujsX28TmZUMcJJkk+/2UVEve5S+9
         8n3iogtQrkh2dsAywLI6KcNjVuc+iLJczKYqyl7xFSUVg75cEqBjnXrIP65LUeBSOt
         tvwTrOIve4QPw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id A5343403F2; Tue, 13 Jul 2021 15:54:09 -0300 (-03)
Date:   Tue, 13 Jul 2021 15:54:09 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libperf: fix build error with LIBPFM4=1
Message-ID: <YO3hUUqRv5R/AxI5@kernel.org>
References: <20210713091907.1555560-1-hca@linux.ibm.com>
 <YO1dngCS/v0j3cAE@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YO1dngCS/v0j3cAE@krava>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Jul 13, 2021 at 11:32:14AM +0200, Jiri Olsa escreveu:
> On Tue, Jul 13, 2021 at 11:19:07AM +0200, Heiko Carstens wrote:
> > Fix build error with LIBPFM4=1:
> >   CC      util/pfm.o
> > util/pfm.c: In function ‘parse_libpfm_events_option’:
> > util/pfm.c:102:30: error: ‘struct evsel’ has no member named ‘leader’
> >   102 |                         evsel->leader = grp_leader;
> >       |                              ^~
> > 
> > Fixes: fba7c86601e2 ("libperf: Move 'leader' from tools/perf to perf_evsel::leader")
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> 
> Acked-by: Jiri Olsa <jolsa@redhat.com>

Argh, we have this in 'make -C tools/perf build-test'

⬢[acme@toolbox perf]$ grep libpfm tools/perf/tests/make
make_with_libpfm4   := LIBPFM4=1
run += make_with_libpfm4
⬢[acme@toolbox perf]$

But I forgot to install libpfm-devel :-\

Thanks, applied.

- Arnaldo
