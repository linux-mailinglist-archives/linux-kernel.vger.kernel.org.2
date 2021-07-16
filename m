Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38DD73CB06A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 03:27:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbhGPB34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 21:29:56 -0400
Received: from gateway36.websitewelcome.com ([192.185.193.119]:18076 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229603AbhGPB3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 21:29:55 -0400
Received: from cm16.websitewelcome.com (cm16.websitewelcome.com [100.42.49.19])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 0C44C40153B79
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 20:26:58 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 4Cd0mkqcsuMjb4Cd0mXJ28; Thu, 15 Jul 2021 20:26:58 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=4ffx1bAv414YMi1a8ax0I4veMZTSEXNs7IRiNasuJUI=; b=ixPCJxq321RHehbRKwj1q8fkZ5
        9a7GJWJKgizpVgnD1Q3b+ncjd9I25RWnvhwzOv7m678V4BFtpDlYDT9IiaF3JQtHAjD+GIf5zuwCF
        b9YJlSychUOKeon8UJ62vNgIZBSgLQJNL4Njcji3lf13ov5C2ytc9u8zlBtP/w3RQIIEvJXxM5n5l
        rinWp9aEaaKxqrAxO9b4UVb2RwJkyyrMXvz+WOaBIxc86SJcHG1vXq/2XXy8/JEViWJz1ovgoQCs7
        xdbkIc7K+QmUZabqAw3pvNHmlOzgzlAgTojXBhfbUFJyCGsyQGbZerqkCfQy8fSZrocJ0D7syEjcm
        MGzDgalw==;
Received: from 187-162-31-110.static.axtel.net ([187.162.31.110]:40530 helo=[192.168.15.8])
        by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <gustavo@embeddedor.com>)
        id 1m4Ccx-003ZSU-Ko; Thu, 15 Jul 2021 20:26:55 -0500
Subject: Re: [GIT PULL] fallthrough fixes for Clang for 5.14-rc2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
References: <20210714200523.GA10606@embeddedor>
 <CAHk-=wjQeeUiv+P_4cZfCy-hY13yGqCGS-scKGhuJ-SAzz2doA@mail.gmail.com>
 <5d170cc8-501d-0cec-bf03-2f53108a8486@embeddedor.com>
 <CAHk-=wj8GqP8ughGBbwcyrBNNdtcXVo_G=XjQ1MAUVUuJfUtGg@mail.gmail.com>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Message-ID: <31b951ff-9c65-b774-87a9-35c28e54636a@embeddedor.com>
Date:   Thu, 15 Jul 2021 20:29:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=wj8GqP8ughGBbwcyrBNNdtcXVo_G=XjQ1MAUVUuJfUtGg@mail.gmail.com>
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
X-Exim-ID: 1m4Ccx-003ZSU-Ko
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-31-110.static.axtel.net ([192.168.15.8]) [187.162.31.110]:40530
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/15/21 20:22, Linus Torvalds wrote:
> On Thu, Jul 15, 2021 at 6:14 PM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
>>
>> Kees just opened a bug report for this:
>>
>> https://bugs.llvm.org/show_bug.cgi?id=51094
> 
> I don't have an account on that bugzilla, but it might be worth adding
> the note that no warning or error should EVER not say where it
> happens.

Yeah; I'll add that to the report.

Here is the current description of the bug:

"There are some places in the kernel where the "fallthrough;" annotation is used after a portion of code that may get elided at build time:

case 1:
    if (something || !IS_ENALBED(CONFIG_SOMETHING))
        return blah;
    fallthrough;
case 2:
This looks like:

case 1:
    fallthrough;
case 2:
And a warning is generated:

warning: fallthrough annotation in unreachable code [-Wimplicit-fallthrough]

But isn't a useful warning in this case, and should likely be silenced or adjust to not warn where there was actually code there before getting elided. At the
least, this warning would be best moved to a separate flag so it can be disabled on kernel builds (i.e. GCC does not warn about these cases).

Some specific examples:

https://github.com/ClangBuiltLinux/continuous-integration2/runs/3058126539?check_suite_focus=true#step:5:120
https://github.com/ClangBuiltLinux/continuous-integration2/runs/3058126329?check_suite_focus=true#step:5:92
"

> That's the thing that made me pissed off in the first place. I build
> my kernels with "make -j128", and if the warning doesn't specify the
> filename and the line number, the warning is just unacceptably bad.
> 
> How can a compiler _ever_ give a warning without specifying where it is?
> 
> The fact that the warning is also entirely wrong-headed in the first
> place is just the extra cherry on top.
> 
> But at least it should hopefully make it easy to fix in clang - just
> remove the incredibly broken thing entirely.
> 
>              Linus
> 

--
Gustavo
