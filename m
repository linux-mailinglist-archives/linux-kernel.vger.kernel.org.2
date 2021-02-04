Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264C030E912
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 02:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234409AbhBDA6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 19:58:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234381AbhBDA6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 19:58:39 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5AF5064F65;
        Thu,  4 Feb 2021 00:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612400293;
        bh=NfonJ2CnxwFOZfp4EL0xhCFbvwESLFn4PSFyF37/9ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfH85BfJAHV+Xc09o0umEuVB0DywLr9H2T2gr6Sg7I9N22Y+BCGgICuqCt8Nu898e
         JztcfJouHemL1PFp/jwCjpLBQfVc3hcMcpy+fCFnjGYWhONIfP3FgpjGElxIU3Vtwo
         IpZNRb6AMQy7fwzUiqPR1paYzSOJG1mnIleP/oMtG5szoNZa7Rh/meY0u/zeSNLPjR
         sxsFthte3f84noSri2B1HwE0K7BXb6/WE6B77XjUK3GIp5PI90NJd0eezLVpspJO65
         kMAVeb/TIPNB8jLp/N5oKsvS34OW4SEBRiX3j+1BK50x9FfGT35Z7Vt2bX+p6pVb2G
         LlNl0eSg+qj0g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 8865D40513; Wed,  3 Feb 2021 21:58:10 -0300 (-03)
Date:   Wed, 3 Feb 2021 21:58:10 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>
Subject: Re: [PATCH 2/2] perf parse-events: Break out tracepoint and printing.
Message-ID: <20210204005810.GZ854763@kernel.org>
References: <20210203052659.2975736-1-irogers@google.com>
 <20210203052659.2975736-2-irogers@google.com>
 <20210203162058.GE854763@kernel.org>
 <CAP-5=fVFeT6YtXJGHX0OC1BCa121bTC+ER7XDVO2g5rr8DYfDw@mail.gmail.com>
 <20210203205024.GM854763@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203205024.GM854763@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Feb 03, 2021 at 05:50:24PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Feb 03, 2021 at 10:38:41AM -0800, Ian Rogers escreveu:
> > On Wed, Feb 3, 2021 at 8:21 AM Arnaldo Carvalho de Melo <acme@kernel.org>
> > wrote:
> > 
> > > Em Tue, Feb 02, 2021 at 09:26:59PM -0800, Ian Rogers escreveu:
> > > > Move print_*_events functions out of parse-events.c into a new
> > > > print-events.c. Move tracepoint code into tracepoint.c or
> > > > trace-event-info.c (sole user). This reduces the dependencies of
> > > > parse-events.c and makes it more amenable to being a library in the
> > > > future.
> > > > Remove some unnecessary definitions from parse-events.h. Fix a
> > > > checkpatch.pl warning on using unsigned rather than unsigned int.
> > >
> > > Thanks, applied.
> > >
> > 
> > Wow, cool :-) I wasn't sure about the macros in the headers. Are you
> > staging these patches before pushing to your perf/core or using
> > tmp.perf/core ? I know you mentioned a different approach. When I look at:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/
> > 
> > I don't see anything newer than 9 days.
> 
> Right, I'm collecting some more patches, will do build tests and push,
> till then, lemme push tmp.perf/core with what I have.

Strange, some intermediary versions of Alpine Linux are complaining, I'll continue tomorrow morning :-\

[perfbuilder@five ~]$ time dm
Wed Feb  3 09:32:47 PM -03 2021
# export PERF_TARBALL=http://192.168.86.5/perf/perf-5.11.0-rc6.tar.xz
# dm
   1    72.90 alpine:3.4                    : Ok   gcc (Alpine 5.3.0) 5.3.0, clang version 3.8.0 (tags/RELEASE_380/final)
   2    74.62 alpine:3.5                    : Ok   gcc (Alpine 6.2.1) 6.2.1 20160822, clang version 3.8.1 (tags/RELEASE_381/final)
   3    76.69 alpine:3.6                    : Ok   gcc (Alpine 6.3.0) 6.3.0, clang version 4.0.0 (tags/RELEASE_400/final)
   4    84.43 alpine:3.7                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.0 (tags/RELEASE_500/final) (based on LLVM 5.0.0)
   5    84.17 alpine:3.8                    : Ok   gcc (Alpine 6.4.0) 6.4.0, Alpine clang version 5.0.1 (tags/RELEASE_501/final) (based on LLVM 5.0.1)
   6    16.71 alpine:3.9                    : FAIL gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 5.0.1 (tags/RELEASE_502/final) (based on LLVM 5.0.1)
                     from util/print-events.c:10:
    /usr/include/linux/swab.h:161:8: error: unknown type name '__always_inline'
     static __always_inline __u16 __swab16p(const __u16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:161:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab16p'
     static __always_inline __u16 __swab16p(const __u16 *p)
                                  ^~~~~~~~~
    /usr/include/linux/swab.h:174:8: error: unknown type name '__always_inline'
     static __always_inline __u32 __swab32p(const __u32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:174:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab32p'
     static __always_inline __u32 __swab32p(const __u32 *p)
                                  ^~~~~~~~~
    /usr/include/linux/swab.h:187:8: error: unknown type name '__always_inline'
     static __always_inline __u64 __swab64p(const __u64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:187:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab64p'
     static __always_inline __u64 __swab64p(const __u64 *p)
                                  ^~~~~~~~~
    /usr/include/linux/swab.h:242:23: error: expected ';' before 'void'
     static __always_inline void __swab32s(__u32 *p)
                           ^~~~~
                           ;
    /usr/include/linux/swab.h:255:23: error: expected ';' before 'void'
     static __always_inline void __swab64s(__u64 *p)
                           ^~~~~
                           ;
    In file included from /usr/include/asm/byteorder.h:5,
                     from /git/linux/tools/include/uapi/linux/perf_event.h:20,
                     from util/print-events.c:10:
    /usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type name '__always_inline'
     static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
     static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type name '__always_inline'
     static __always_inline __u64 __le64_to_cpup(const __le64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
     static __always_inline __u64 __le64_to_cpup(const __le64 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type name '__always_inline'
     static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
     static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type name '__always_inline'
     static __always_inline __u32 __le32_to_cpup(const __le32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
     static __always_inline __u32 __le32_to_cpup(const __le32 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type name '__always_inline'
     static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
     static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type name '__always_inline'
     static __always_inline __u16 __le16_to_cpup(const __le16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
     static __always_inline __u16 __le16_to_cpup(const __le16 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type name '__always_inline'
     static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
     static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type name '__always_inline'
     static __always_inline __u64 __be64_to_cpup(const __be64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
     static __always_inline __u64 __be64_to_cpup(const __be64 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type name '__always_inline'
     static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
     static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type name '__always_inline'
     static __always_inline __u32 __be32_to_cpup(const __be32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
     static __always_inline __u32 __be32_to_cpup(const __be32 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type name '__always_inline'
     static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
     static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type name '__always_inline'
     static __always_inline __u16 __be16_to_cpup(const __be16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
     static __always_inline __u16 __be16_to_cpup(const __be16 *p)
                                  ^~~~~~~~~~~~~~
    make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
   7    16.31 alpine:3.10                   : FAIL gcc (Alpine 8.3.0) 8.3.0, Alpine clang version 8.0.0 (tags/RELEASE_800/final) (based on LLVM 8.0.0)
                     from util/print-events.c:10:
    /usr/include/linux/swab.h:161:8: error: unknown type name '__always_inline'
     static __always_inline __u16 __swab16p(const __u16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:161:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab16p'
     static __always_inline __u16 __swab16p(const __u16 *p)
                                  ^~~~~~~~~
    /usr/include/linux/swab.h:174:8: error: unknown type name '__always_inline'
     static __always_inline __u32 __swab32p(const __u32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:174:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab32p'
     static __always_inline __u32 __swab32p(const __u32 *p)
                                  ^~~~~~~~~
    /usr/include/linux/swab.h:187:8: error: unknown type name '__always_inline'
     static __always_inline __u64 __swab64p(const __u64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:187:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab64p'
     static __always_inline __u64 __swab64p(const __u64 *p)
                                  ^~~~~~~~~
    /usr/include/linux/swab.h:242:23: error: expected ';' before 'void'
     static __always_inline void __swab32s(__u32 *p)
                           ^~~~~
                           ;
    /usr/include/linux/swab.h:255:23: error: expected ';' before 'void'
     static __always_inline void __swab64s(__u64 *p)
                           ^~~~~
                           ;
    In file included from /usr/include/asm/byteorder.h:5,
                     from /git/linux/tools/include/uapi/linux/perf_event.h:20,
                     from util/print-events.c:10:
    /usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type name '__always_inline'
     static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
     static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type name '__always_inline'
     static __always_inline __u64 __le64_to_cpup(const __le64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
     static __always_inline __u64 __le64_to_cpup(const __le64 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type name '__always_inline'
     static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
     static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type name '__always_inline'
     static __always_inline __u32 __le32_to_cpup(const __le32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
     static __always_inline __u32 __le32_to_cpup(const __le32 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type name '__always_inline'
     static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
     static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type name '__always_inline'
     static __always_inline __u16 __le16_to_cpup(const __le16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
     static __always_inline __u16 __le16_to_cpup(const __le16 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type name '__always_inline'
     static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
     static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type name '__always_inline'
     static __always_inline __u64 __be64_to_cpup(const __be64 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
     static __always_inline __u64 __be64_to_cpup(const __be64 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type name '__always_inline'
     static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
     static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type name '__always_inline'
     static __always_inline __u32 __be32_to_cpup(const __be32 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
     static __always_inline __u32 __be32_to_cpup(const __be32 *p)
                                  ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type name '__always_inline'
     static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
     static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
                                   ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type name '__always_inline'
     static __always_inline __u16 __be16_to_cpup(const __be16 *p)
            ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
     static __always_inline __u16 __be16_to_cpup(const __be16 *p)
                                  ^~~~~~~~~~~~~~
    make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
   8    18.59 alpine:3.11                   : FAIL gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 9.0.0 (https://git.alpinelinux.org/aports f7f0d2c2b8bcd6a5843401a9a702029556492689) (based on LLVM 9.0.0)
                     from util/print-events.c:10:
    /usr/include/linux/swab.h:161:8: error: unknown type name '__always_inline'
      161 | static __always_inline __u16 __swab16p(const __u16 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:161:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab16p'
      161 | static __always_inline __u16 __swab16p(const __u16 *p)
          |                              ^~~~~~~~~
    /usr/include/linux/swab.h:174:8: error: unknown type name '__always_inline'
      174 | static __always_inline __u32 __swab32p(const __u32 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:174:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab32p'
      174 | static __always_inline __u32 __swab32p(const __u32 *p)
          |                              ^~~~~~~~~
    /usr/include/linux/swab.h:187:8: error: unknown type name '__always_inline'
      187 | static __always_inline __u64 __swab64p(const __u64 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/swab.h:187:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__swab64p'
      187 | static __always_inline __u64 __swab64p(const __u64 *p)
          |                              ^~~~~~~~~
    /usr/include/linux/swab.h:242:23: error: expected ';' before 'void'
      242 | static __always_inline void __swab32s(__u32 *p)
          |                       ^~~~~
          |                       ;
    /usr/include/linux/swab.h:255:23: error: expected ';' before 'void'
      255 | static __always_inline void __swab64s(__u64 *p)
          |                       ^~~~~
          |                       ;
    In file included from /usr/include/asm/byteorder.h:5,
                     from /git/linux/tools/include/uapi/linux/perf_event.h:20,
                     from util/print-events.c:10:
    /usr/include/linux/byteorder/little_endian.h:44:8: error: unknown type name '__always_inline'
       44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:44:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le64p'
       44 | static __always_inline __le64 __cpu_to_le64p(const __u64 *p)
          |                               ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:48:8: error: unknown type name '__always_inline'
       48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:48:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le64_to_cpup'
       48 | static __always_inline __u64 __le64_to_cpup(const __le64 *p)
          |                              ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:52:8: error: unknown type name '__always_inline'
       52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:52:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le32p'
       52 | static __always_inline __le32 __cpu_to_le32p(const __u32 *p)
          |                               ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:56:8: error: unknown type name '__always_inline'
       56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:56:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le32_to_cpup'
       56 | static __always_inline __u32 __le32_to_cpup(const __le32 *p)
          |                              ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:60:8: error: unknown type name '__always_inline'
       60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:60:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_le16p'
       60 | static __always_inline __le16 __cpu_to_le16p(const __u16 *p)
          |                               ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:64:8: error: unknown type name '__always_inline'
       64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:64:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__le16_to_cpup'
       64 | static __always_inline __u16 __le16_to_cpup(const __le16 *p)
          |                              ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:68:8: error: unknown type name '__always_inline'
       68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:68:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be64p'
       68 | static __always_inline __be64 __cpu_to_be64p(const __u64 *p)
          |                               ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:72:8: error: unknown type name '__always_inline'
       72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:72:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be64_to_cpup'
       72 | static __always_inline __u64 __be64_to_cpup(const __be64 *p)
          |                              ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:76:8: error: unknown type name '__always_inline'
       76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:76:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be32p'
       76 | static __always_inline __be32 __cpu_to_be32p(const __u32 *p)
          |                               ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:80:8: error: unknown type name '__always_inline'
       80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:80:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be32_to_cpup'
       80 | static __always_inline __u32 __be32_to_cpup(const __be32 *p)
          |                              ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:84:8: error: unknown type name '__always_inline'
       84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:84:31: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__cpu_to_be16p'
       84 | static __always_inline __be16 __cpu_to_be16p(const __u16 *p)
          |                               ^~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:88:8: error: unknown type name '__always_inline'
       88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
          |        ^~~~~~~~~~~~~~~
    /usr/include/linux/byteorder/little_endian.h:88:30: error: expected '=', ',', ';', 'asm' or '__attribute__' before '__be16_to_cpup'
       88 | static __always_inline __u16 __be16_to_cpup(const __be16 *p)
          |                              ^~~~~~~~~~~~~~
    make[3]: *** [/git/linux/tools/build/Makefile.build:139: util] Error 2
   9   117.31 alpine:3.12                   : Ok   gcc (Alpine 9.3.0) 9.3.0, Alpine clang version 10.0.0 (https://gitlab.alpinelinux.org/alpine/aports.git 7445adce501f8473efdb93b17b5eaf2f1445ed4c)
  10   124.70 alpine:edge                   : Ok   gcc (Alpine 10.2.0) 10.2.0, Alpine clang version 10.0.1
  11    72.02 alt:p8                        : Ok   x86_64-alt-linux-gcc (GCC) 5.3.1 20151207 (ALT p8 5.3.1-alt3.M80P.1), clang version 3.8.0 (tags/RELEASE_380/final)
  12    87.30 alt:p9                        : Ok   x86_64-alt-linux-gcc (GCC) 8.4.1 20200305 (ALT p9 8.4.1-alt0.p9.1), clang version 10.0.0
  13    87.33 alt:sisyphus                  : Ok   x86_64-alt-linux-gcc (GCC) 10.2.1 20201125 (ALT Sisyphus 10.2.1-alt2), clang version 10.0.1
  14    70.23 amazonlinux:1                 : Ok   gcc (GCC) 7.2.1 20170915 (Red Hat 7.2.1-2), clang version 3.6.2 (tags/RELEASE_362/final)
  15   104.56 amazonlinux:2                 : Ok   gcc (GCC) 7.3.1 20180712 (Red Hat 7.3.1-12), clang version 7.0.1 (Amazon Linux 2 7.0.1-1.amzn2.0.2)
  16    23.52 android-ndk:r12b-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  17    21.96 android-ndk:r15c-arm          : Ok   arm-linux-androideabi-gcc (GCC) 4.9.x 20150123 (prerelease)
  18    27.58 centos:6                      : Ok   gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-23)
  19    33.35 centos:7                      : Ok   gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-44)
  20    98.93 centos:8                      : Ok   gcc (GCC) 8.3.1 20191121 (Red Hat 8.3.1-5), clang version 10.0.1 (Red Hat 10.0.1-1.module_el8.3.0+467+cb298d5b)
  21    69.01 clearlinux:latest             : Ok   gcc (Clear Linux OS for Intel Architecture) 10.2.1 20201217 releases/gcc-10.2.0-643-g7cbb07d2fc, clang version 10.0.1
  22    79.89 debian:8                      : Ok   gcc (Debian 4.9.2-10+deb8u2) 4.9.2, Debian clang version 3.5.0-10 (tags/RELEASE_350/final) (based on LLVM 3.5.0)

