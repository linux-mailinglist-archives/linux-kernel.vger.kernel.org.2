Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 236F5339DC0
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 12:24:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhCMLX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 06:23:59 -0500
Received: from mail.skyhub.de ([5.9.137.197]:40068 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233114AbhCMLXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 06:23:36 -0500
Received: from zn.tnic (p200300ec2f1971005e6485920b35c85a.dip0.t-ipconnect.de [IPv6:2003:ec:2f19:7100:5e64:8592:b35:c85a])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7CBE21EC01B5;
        Sat, 13 Mar 2021 12:23:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1615634614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=mZJ3ZwbQAuU0i3orBn/SyT/bwZaFTwL5Qo9sFvWJZfI=;
        b=fQyvKkwAnIohit7dxsYAPlZ9wRyzvoLV5VIi/8jQNOQZFMisrWjsMRr/7b9j1mYVlDbSfJ
        9QSny0gXcvmoB5ouUdqzkj5Otqg3xlDuCyk1zb3uVPm77b78YgUE6O65vmVUYZZKcss5tA
        X+in/doaLRscp1t4sP61NcSaWya3MV4=
Date:   Sat, 13 Mar 2021 12:23:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
Message-ID: <20210313112328.GB16144@zn.tnic>
References: <20210312113253.305040674@infradead.org>
 <20210312205914.GG22098@zn.tnic>
 <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210313084923.GA16144@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 13, 2021 at 09:49:23AM +0100, Borislav Petkov wrote:
> Lemme rerun here with clang.

clang11 is almost twice as slow as gcc but difference is still
negligible: ~0.6 seconds.

./tools/perf/perf stat --repeat 5 --sync --pre=/root/bin/pre-build-kernel.sh -- make -s -j9 LLVM=1 LLVM_IAS=1 bzImage

before:

 Performance counter stats for 'make -s -j9 LLVM=1 LLVM_IAS=1 bzImage' (5 runs):

      5,576,081.48 msec task-clock                #    7.664 CPUs utilized            ( +-  0.03% )
           496,841      context-switches          #    0.089 K/sec                    ( +-  0.11% )
            30,245      cpu-migrations            #    0.005 K/sec                    ( +-  0.53% )
        49,702,714      page-faults               #    0.009 M/sec                    ( +-  0.00% )
19,954,704,926,347      cycles                    #    3.579 GHz                      ( +-  0.02% )  (83.33%)
15,920,125,996,460      stalled-cycles-frontend   #   79.78% frontend cycles idle     ( +-  0.03% )  (83.33%)
13,177,812,137,935      stalled-cycles-backend    #   66.04% backend cycles idle      ( +-  0.04% )  (66.67%)
 8,778,060,061,848      instructions              #    0.44  insn per cycle
                                                  #    1.81  stalled cycles per insn  ( +-  0.00% )  (83.33%)
 1,852,121,066,032      branches                  #  332.155 M/sec                    ( +-  0.00% )  (83.33%)
    84,048,262,434      branch-misses             #    4.54% of all branches          ( +-  0.02% )  (83.33%)

           727.572 +- 0.305 seconds time elapsed  ( +-  0.04% )

after:

 Performance counter stats for 'make -s -j9 LLVM=1 LLVM_IAS=1 bzImage' (5 runs):

      5,581,654.38 msec task-clock                #    7.665 CPUs utilized            ( +-  0.01% )
           496,274      context-switches          #    0.089 K/sec                    ( +-  0.12% )
            30,645      cpu-migrations            #    0.005 K/sec                    ( +-  0.54% )
        49,711,551      page-faults               #    0.009 M/sec                    ( +-  0.01% )
19,968,933,753,686      cycles                    #    3.578 GHz                      ( +-  0.01% )  (83.33%)
15,925,776,797,854      stalled-cycles-frontend   #   79.75% frontend cycles idle     ( +-  0.01% )  (83.33%)
13,182,158,323,446      stalled-cycles-backend    #   66.01% backend cycles idle      ( +-  0.01% )  (66.67%)
 8,778,619,885,119      instructions              #    0.44  insn per cycle
                                                  #    1.81  stalled cycles per insn  ( +-  0.00% )  (83.33%)
 1,852,096,100,464      branches                  #  331.818 M/sec                    ( +-  0.01% )  (83.33%)
    84,264,257,355      branch-misses             #    4.55% of all branches          ( +-  0.03% )  (83.33%)

          728.2400 +- 0.0613 seconds time elapsed  ( +-  0.01% )

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
