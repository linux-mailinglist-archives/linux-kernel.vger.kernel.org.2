Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B92A391C4D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 17:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235429AbhEZPqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 11:46:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:35862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235332AbhEZPqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 11:46:22 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9ADD1613D3;
        Wed, 26 May 2021 15:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622043890;
        bh=0SRqv5DLareSxFH7yZ3agLefitGL127UPBROq2ISqVM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fzNPgeuYCJWHwI4w7TnliIrHcK39jlRekXDxL56LtQp/HLobt142p0ZQndSdDUyRZ
         IRQeFv0S3yJQCjS5TJFd+rKIaY6nG804Rk+rSASUGaz+x/wlcCnd5gmq3ni120mENk
         n6Q4DQ3vy5l+tqStMfTtusQ0ocaUAKsKpINuNPEeQl4KmY3ak13LHkhyBqUMzE06D3
         QjXi5Kzf5ia2HmY2panJ2wvmiBdvSKfTSQyIuKegp+1Puwn005ycqLDeIOHsIPj6PJ
         yWbv3i+NuBNzKQQn/7wK1dZjHb/D7V82/4ChAUNO58IoMaLI9OyxvtdqlJNAFzVLkE
         a/y0o8nyTINew==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id C862E4011C; Wed, 26 May 2021 12:44:47 -0300 (-03)
Date:   Wed, 26 May 2021 12:44:47 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco)" 
        <dzagorui@cisco.com>
Cc:     "jolsa@redhat.com" <jolsa@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>
Subject: Re: [PATCH v7 1/3] perf report: compile tips.txt in perf binary
Message-ID: <YK5s7xKIKGuJkXYr@kernel.org>
References: <20210522062016.84677-1-dzagorui@cisco.com>
 <YK5WO3is6EW9TNrX@kernel.org>
 <BY5PR11MB40248ABAFED285B92AE9F01CD9249@BY5PR11MB4024.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BY5PR11MB40248ABAFED285B92AE9F01CD9249@BY5PR11MB4024.namprd11.prod.outlook.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, May 26, 2021 at 02:50:24PM +0000, Denys Zagorui -X (dzagorui - GLOBALLOGIC INC at Cisco) escreveu:
> > [perfbuilder@five ~]$ export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0-rc3.tar.xz
> > [perfbuilder@five ~]$ time dm
> > Wed May 26 11:04:00 AM -03 2021
> > # export PERF_TARBALL=http://192.168.100.2/perf/perf-5.13.0-rc3.tar.xz
> > # dm
> >   1     9.39 alpine:3.4                    : FAIL gcc version 5.3.0 (Alpine 5.3.0)
> >    builtin-report.c: In function 'cmd_report':
> >    builtin-report.c:560:3: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >       fprintf(stdout, "#\n# (%s)\n#\n", help);
> >       ^
> >    builtin-report.c:622:20: note: 'prev' was declared here
> >      char *tok, *tmp, *prev;
> > <SNIP>
> >
> >  10    13.35 alpine:3.13                   : FAIL gcc version 10.2.1 20201203 (Alpine 10.2.1_pre1)
> >    builtin-report.c: In function 'cmd_report':
> >    builtin-report.c:560:3: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >      560 |   fprintf(stdout, "#\n# (%s)\n#\n", help);
> >          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    builtin-report.c:622:20: note: 'prev' was declared here
> >      622 |  char *tok, *tmp, *prev;
> >          |                    ^~~~
> >    cc1: all warnings being treated as errors
> >  11    13.77 alpine:edge                   : FAIL gcc version 10.3.1 20210424 (Alpine 10.3.1_git20210424)
> >    builtin-report.c: In function 'cmd_report':
> >    builtin-report.c:560:3: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> >      560 |   fprintf(stdout, "#\n# (%s)\n#\n", help);
> >          |   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >    builtin-report.c:622:20: note: 'prev' was declared here
> >      622 |  char *tok, *tmp, *prev;
> >          |                    ^~~~
> >    cc1: all warnings being treated as errors
> >
> >
> > I'll check later...
> 
> prev should be initialized to _binary_Documentation_tips_txt_start, i can resend 


More problems with that patch, so I'm removing it for now, till we have
these addressed.

- Arnaldo

When cross-building to Risc-V 64-bit:

  LD       /tmp/build/perf/Documentation/tips.o
riscv64-linux-gnu-ld: --relax and -r may not be used together
Documentation/Build:7: recipe for target '/tmp/build/perf/Documentation/tips.o' failed
make[4]: *** [/tmp/build/perf/Documentation/tips.o] Error 1
/git/perf-5.13.0-rc3/tools/build/Makefile.build:139: recipe for target 'Documentation' failed
make[3]: *** [Documentation] Error 2
make[3]: *** Waiting for unfinished jobs....

Ditto for m68k

  LD       /tmp/build/perf/Documentation/tips.o
m68k-linux-gnu-ld: failed to merge target specific data of file Documentation/tips.txt
Documentation/Build:7: recipe for target '/tmp/build/perf/Documentation/tips.o' failed
make[4]: *** [/tmp/build/perf/Documentation/tips.o] Error 1
/git/perf-5.13.0-rc3/tools/build/Makefile.build:139: recipe for target 'Documentation' failed
make[3]: *** [Documentation] Error 2
make[3]: *** Waiting for unfinished jobs....



That same problem, for other targets:

  42     7.55 fedora:34-x-ARC-uClibc        : FAIL gcc version 8.3.1 20190225 (ARCv2 ISA Linux uClibc toolchain 2019.03-rc1)
    builtin-report.c: In function 'cmd_report':
    builtin-report.c:560:3: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
       fprintf(stdout, "#\n# (%s)\n#\n", help);
       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    builtin-report.c:622:20: note: 'prev' was declared here
      char *tok, *tmp, *prev;
                        ^~~~

  19     9.46 debian:8                      : FAIL gcc version 4.9.2 (Debian 4.9.2-10+deb8u2)
    builtin-report.c: In function 'cmd_report':
    builtin-report.c:654:7: error: 'prev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
       ret = evlist__tui_browse_hists(evlist, help, NULL, rep->min_percent,
           ^
    builtin-report.c:622:20: note: 'prev' was declared here
      char *tok, *tmp, *prev;
                        ^
    cc1: all warnings being treated as errors
