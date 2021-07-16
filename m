Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9232E3CB07B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbhGPBif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:38:35 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.129]:24898 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhGPBie (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:38:34 -0400
X-Greylist: delayed 1265 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jul 2021 21:38:34 EDT
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 3F99B4B25
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 20:14:33 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 4CQzmZxYioIHn4CQzmp1ge; Thu, 15 Jul 2021 20:14:33 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Vg9ITUv3dvdluW4XbvT6qOkw4QFMgdzrrGPJ8XWGWaE=; b=Uj6B+gUH7WDB2k4RRHo4GqNNkM
        TvZwhKmRn7zBbRJ8hvUYvUbBPfBo6jTM5HMkRHHuVo3qUNIizZFKN2BGi6HbVuACoAj+RwYcSSAj2
        DFVFR9+w+rm4+7PtNhF0PJnfgwc5NsAlKtJMa3SnLEP5X6l5693Kf/wzBUgZWlNnYQPvhyr9Twgjn
        DXDg4i+PRkhli9YSA0t00beomVDCDwtai/NdTRna5SH34rMd+5a0G64n7whB/S2D1Ofj6eWQ4GHRx
        YVb9GqtcokiZ8GosuTiOuUSUGyMRY6Y2xn3mzfY2KdTWChL3ZebBfXQtCDxd7FNOQjgeYv4t9sxcV
        jOdCQDhg==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:40422 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1m4CQw-003OJB-57; Thu, 15 Jul 2021 20:14:30 -0500
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210714200523.GA10606@embeddedor>
 <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <5d170cc8-501d-0cec-bf03-2f53108a8486@embeddedor.com>
Date:   Thu, 15 Jul 2021 20:16:37 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.31.110
X-Source-L: No
X-Exim-ID: 1m4CQw-003OJB-57
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:40422
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/21 20:04, Linus Torvalds wrote:
> On Wed, Jul 14, 2021 at 1:03 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
>>
>>   git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/Wimplicit-fallthrough-clang-5.14-rc2
> 
> Grr.
> 
> I merged this, but when I actually tested it on my clang build, it
> turns out that the clang "-Wimplicit-fallthrough" flag is unbelievable
> garbage.
> 
> I get
> 
>    warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]

Kees just opened a bug report for this:

https://bugs.llvm.org/show_bug.cgi?id=51094

--
Gustavo

> 
> and the stupid warning doesn't even say WHERE THE PROBLEM HAPPENS.
> 
> No file name, no line numbers. Just this pointless garbage warning.
> 
> Honestly, how does a compiler even do something that broken? Am I
> supposed to use my sixth sense to guide me in finding the warning?
> 
> I like the concept of the fallthrough warning, but it looks like the
> clang implementation of it is so unbelievably broken that it's getting
> disabled again.
> 
> Yeah, I can
> 
>  (a) build the kernel without any parallelism
> 
>  (b) use ">&" to get both output and errors into the same file
> 
>  (c) see that it says
> 
>     CC      kernel/sched/core.o
>   warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]
>   1 warning generated.
> 
> and now I see at least which _file_ it is that causes that warning.
> 
> I can then use my incredible powers of deduction (it's almost like a
> sixth sense, but helped by the fact that there's only one single
> "fallthrough" statement in that file) to figure out that it's
> triggered by this code:
> 
>                 case cpuset:
>                         if (IS_ENABLED(CONFIG_CPUSETS)) {
>                                 cpuset_cpus_allowed_fallback(p);
>                                 state = possible;
>                                 break;
>                         }
>                         fallthrough;
>                 case possible:
> 
> and it all makes it clear that the clang warning is just incredibly
> broken garbage not only in that lack of filename and line number, but
> just in general.
> 
> Yeah, I'm a bit pissed off at this. This clang warning really is
> WRONG. It's so wrong in so many ways that I don't know what to say.
> 
> Except "yeah, that broken option is getting reverted again, because
> the clang people messed up completely".
> 
> It's sad to see that people wasted time and effort on trying to make
> clang happy, when it turns out that clang just gets this so _totally_
> wrong.
> 
>                      Linus
> 
