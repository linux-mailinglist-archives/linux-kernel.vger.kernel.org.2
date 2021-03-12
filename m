Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E59B3398C9
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 22:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbhCLU7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 15:59:42 -0500
Received: from mail.skyhub.de ([5.9.137.197]:59334 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235077AbhCLU7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 15:59:13 -0500
Received: from zn.tnic (p200300ec2f0953007a8976408030422b.dip0.t-ipconnect.de [IPv6:2003:ec:2f09:5300:7a89:7640:8030:422b])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A8AC21EC02FE;
        Fri, 12 Mar 2021 21:59:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615582751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=DZaT+F7TXKdXQFYhA98s3hBMwbiR8xjEaN4FAAts3ic=;
        b=NPHfWuNiwUI2EQnN6eBiRCzz4FWCOzwWnMwTUdB51DaJJSD3RccrRgaoWZPgnUfppQq8ui
        PGyazh9IYz596Meedyuaa+1De7QlfyFEgE+YQQ1cNxzpmg7Z7xaWUWTAVQrGgfNH+aeMcX
        uv/NwsxS/saCwyNA2v1AtxlO98azd8c=
Date:   Fri, 12 Mar 2021 21:59:14 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        torvalds@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-toolchains@vger.kernel.org, jpoimboe@redhat.com,
        alexei.starovoitov@gmail.com, mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210312205914.GG22098@zn.tnic>
References: <20210312113253.305040674@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210312113253.305040674@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 12:32:53PM +0100, Peter Zijlstra wrote:
> Since ultimate performance of a 10 year old chip (Intel Sandy Bridge, 2011) is
> simply irrelevant today, remove variable NOPs and use NOPL.

Just ran them on my SNB box:

cpu family      : 6
model           : 45
model name      : Intel(R) Xeon(R) CPU E5-1620 0 @ 3.60GHz
stepping        : 7

with the usual perf stat kernel build workload with
CONFIG_DYNAMIC_FTRACE and CONFIG_FUNCTION_TRACER where each function has
a NOP at its beginning when ftrace is disabled (thx Steve).

./tools/perf/perf stat --repeat 5 --sync --pre=/root/bin/pre-build-kernel.sh -- make -s -j9 bzImage

before: tip-master

 Performance counter stats for 'make -s -j9 bzImage' (5 runs):

      3,213,728.10 msec task-clock                #    7.307 CPUs utilized            ( +-  0.01% )
           339,270      context-switches          #    0.106 K/sec                    ( +-  0.09% )
            31,472      cpu-migrations            #    0.010 K/sec                    ( +-  0.64% )
        62,070,684      page-faults               #    0.019 M/sec                    ( +-  0.01% )
11,498,198,009,323      cycles                    #    3.578 GHz                      ( +-  0.01% )  (83.33%)
 8,235,957,366,696      stalled-cycles-frontend   #   71.63% frontend cycles idle     ( +-  0.01% )  (83.33%)
 5,976,456,688,814      stalled-cycles-backend    #   51.98% backend cycles idle      ( +-  0.02% )  (66.67%)
 7,553,156,344,376      instructions              #    0.66  insn per cycle         
                                                  #    1.09  stalled cycles per insn  ( +-  0.00% )  (83.33%)
 1,635,468,917,524      branches                  #  508.901 M/sec                    ( +-  0.00% )  (83.34%)
    51,888,292,932      branch-misses             #    3.17% of all branches          ( +-  0.02% )  (83.33%)

           439.809 +- 0.156 seconds time elapsed  ( +-  0.04% )


after: tip-master-nops

 Performance counter stats for 'make -s -j9 bzImage' (5 runs):

      3,217,113.67 msec task-clock                #    7.307 CPUs utilized            ( +-  0.03% )
           339,425      context-switches          #    0.106 K/sec                    ( +-  0.20% )
            31,724      cpu-migrations            #    0.010 K/sec                    ( +-  0.54% )
        62,027,130      page-faults               #    0.019 M/sec                    ( +-  0.01% )
11,508,779,965,901      cycles                    #    3.577 GHz                      ( +-  0.03% )  (83.34%)
 8,241,212,210,440      stalled-cycles-frontend   #   71.61% frontend cycles idle     ( +-  0.04% )  (83.33%)
 5,982,615,533,177      stalled-cycles-backend    #   51.98% backend cycles idle      ( +-  0.06% )  (66.66%)
 7,546,407,430,314      instructions              #    0.66  insn per cycle         
                                                  #    1.09  stalled cycles per insn  ( +-  0.00% )  (83.33%)
 1,634,187,006,479      branches                  #  507.967 M/sec                    ( +-  0.00% )  (83.33%)
    51,941,580,371      branch-misses             #    3.18% of all branches          ( +-  0.01% )  (83.33%)

           440.266 +- 0.195 seconds time elapsed  ( +-  0.04% )


So here's numbers talk, bullshit walks. And with those numbers no
bullshit can remain lingering around anyway.

Cheers!

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
