Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4FAF3A3395
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhFJS4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:56:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229935AbhFJS4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:56:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6C399613B0;
        Thu, 10 Jun 2021 18:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623351290;
        bh=UgDy/YIt0wcpF3ZFwRGLuTVpW0LrD/15mzM1MbySke0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=UVcjrF6tcIWAwppxNnC9vo54gFl1xDCWWPPdU+nAG9e76MrBYDxIm8NtmJgvu2o8f
         4aCh5Dd7Qbbrw6LnWSrcqXxlzga8tCfsVxodq4mX4rD3/lCRUwIm1NDKQZGfZf6aPo
         +ySG5os3M0Pm88ldw+khux3FgUFGfEmlLjEqNOuO3V4sursnspIM9yDAkDDguLl70V
         Y4LCnWliy4i0+mPqLglSbDhZxGIeORHh8sBJ8W1heMFyt2VX+WMVHO6Xmj6nWrzFqg
         J/RTBZJP36ppI1QeGgWiDk5dK4NYqJ2j0LFoGvwyD1DRkzhHmuFWkwGJFr6Lrqwp0S
         WYdvFpnL1933Q==
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        samitolvanen@google.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com
References: <20210506193352.719596001@infradead.org>
 <20210506194157.452881700@infradead.org>
 <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
 <YMJdYdCR0vD2t2WC@hirez.programming.kicks-ass.net>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <7165b24e-0628-c273-f1e2-67a75358991f@kernel.org>
Date:   Thu, 10 Jun 2021 11:54:50 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMJdYdCR0vD2t2WC@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/10/2021 11:43 AM, Peter Zijlstra wrote:
> On Thu, Jun 10, 2021 at 11:14:51AM -0700, Nathan Chancellor wrote:
> 
>> This patch as commit 25cf0d8aa2a3 ("objtool: Rewrite hashtable sizing")
>> in -tip causes a massive compile time regression with allmodconfig +
>> ThinLTO.
> 
> Moo... the allyesconfig builds I used it on were much faster, but that
> was on regular GCC vmlinux.o after linking.
> 
>> Adding Sami because I am not sure why this patch would have much of an impact
>> in relation to LTO. https://git.kernel.org/tip/25cf0d8aa2a3 is the patch in
>> question.
>>
>> If I can provide any further information or help debug, please let me know.
>>
>> If you are interested in reproducing this locally, you will need a
>> fairly recent LLVM stack (I used the stable release/12.x branch) and to
>> cherry-pick commit 976aac5f8829 ("kcsan: Fix debugfs initcall return
>> type") to fix an unrelated build failure. My script [2] can build a
>> self-contained toolchain fairly quickly if you cannot get one from your
>> package manager. A command like below will speed up the build a bit:
> 
> Would something like llvm-13 from Debian be good enough?
> 
> $ clang-13 --version
> Debian clang version 13.0.0-++20210418105309+a0898f0cecc7-1~exp1
> Target: x86_64-pc-linux-gnu
> Thread model: posix
> InstalledDir: /usr/bin
> 

Yes, that would work. That is what we use in our CI.

Looks like Sami gave a reply that explains it.

Cheers,
Nathan
