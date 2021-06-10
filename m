Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D33A32D2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 20:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbhFJSQu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 14:16:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230376AbhFJSQt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 14:16:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 417CB613F5;
        Thu, 10 Jun 2021 18:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623348892;
        bh=PADwB9sqrvEq0/W9oqNmCqgADNHwyj1AM7E076Ndpy8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rZ+gjzX8DykFeOrU9l9xA6YbyKgbjW3VSyTWrXErzTZjJVtlG0k+8+V5gXquBEFcZ
         96b4z8yhyIGmBDKQlL0cT0tg4jnWusockBru+bZhC459GHXRabWR140+sC/3fggx8G
         8HrZA4aMbS78v82eDFlsqIDIzbyyJCgZiw6lLmaLyI6D6a0UUeoRljJjTYdgzdRBV1
         GhdJIUqYyZQMPOjEkak5pdNiUnigZnBNkRUnEwU0exoybZpW5VH5HGwwwGrDoi2/lw
         sfdywd8Php3R3LtChihtunu909tYgKb34zIX9sJAhYnQs/e7CniU8GY5SB7Rn5Pr31
         fQD6LEyJikx2w==
Date:   Thu, 10 Jun 2021 11:14:51 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, jpoimboe@redhat.com, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, linux-kernel@vger.kernel.org,
        samitolvanen@google.com, ndesaulniers@google.com,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 01/13] objtool: Rewrite hashtable sizing
Message-ID: <YMJWmzXgSipOqXAf@DESKTOP-1V8MEUQ.localdomain>
References: <20210506193352.719596001@infradead.org>
 <20210506194157.452881700@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506194157.452881700@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Thu, May 06, 2021 at 09:33:53PM +0200, Peter Zijlstra wrote:
> Currently objtool has 5 hashtables and sizes them 16 or 20 bits
> depending on the --vmlinux argument.
> 
> However, a single side doesn't really work well for the 5 tables,
> which among them, cover 3 different uses. Also, while vmlinux is
> larger, there is still a very wide difference between a defconfig and
> allyesconfig build, which again isn't optimally covered by a single
> size.
> 
> Another aspect is the cost of elf_hash_init(), which for large tables
> dominates the runtime for small input files. It turns out that all it
> does it assign NULL, something that is required when using malloc().
> However, when we allocate memory using mmap(), we're guaranteed to get
> zero filled pages.
> 
> Therefore, rewrite the whole thing to:
> 
>  1) use more dynamic sized tables, depending on the input file,
>  2) avoid the need for elf_hash_init() entirely by using mmap().
> 
> This speeds up a regular kernel build (100s to 98s for
> x86_64-defconfig), and potentially dramatically speeds up vmlinux
> processing.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>

This patch as commit 25cf0d8aa2a3 ("objtool: Rewrite hashtable sizing")
in -tip causes a massive compile time regression with allmodconfig +
ThinLTO.

At v5.13-rc1, the performance penalty is only about 23%, as measured with
hyperfine for two runs [1]:

Benchmark #1: allmodconfig
  Time (mean ± σ):     625.173 s ±  2.198 s    [User: 35120.895 s, System: 2176.868 s]
  Range (min … max):   623.619 s … 626.727 s    2 runs

Benchmark #2: allmodconfig with ThinLTO
  Time (mean ± σ):     771.034 s ±  0.369 s    [User: 39706.084 s, System: 2326.166 s]
  Range (min … max):   770.773 s … 771.295 s    2 runs

Summary
  'allmodconfig' ran
    1.23 ± 0.00 times faster than 'allmodconfig with ThinLTO'

However, at 25cf0d8aa2a3, it is almost 150% on a 64-core server.

Benchmark #1: allmodconfig
  Time (mean ± σ):     624.759 s ±  2.153 s    [User: 35114.379 s, System: 2145.456 s]
  Range (min … max):   623.237 s … 626.281 s    2 runs

Benchmark #2: allmodconfig with ThinLTO
  Time (mean ± σ):     1555.377 s ± 12.806 s    [User: 40558.463 s, System: 2310.139 s]
  Range (min … max):   1546.321 s … 1564.432 s    2 runs

Summary
  'allmodconfig' ran
    2.49 ± 0.02 times faster than 'allmodconfig with ThinLTO'

Adding Sami because I am not sure why this patch would have much of an impact
in relation to LTO. https://git.kernel.org/tip/25cf0d8aa2a3 is the patch in
question.

If I can provide any further information or help debug, please let me know.

If you are interested in reproducing this locally, you will need a
fairly recent LLVM stack (I used the stable release/12.x branch) and to
cherry-pick commit 976aac5f8829 ("kcsan: Fix debugfs initcall return
type") to fix an unrelated build failure. My script [2] can build a
self-contained toolchain fairly quickly if you cannot get one from your
package manager. A command like below will speed up the build a bit:

$ ./build-llvm.py \
    --branch "release/12.x" \
    --build-stage1-only \
    --install-stage1-only \
    --projects "clang;lld" \
    --targets X86

After adding the "install/bin" directory to PATH:

$ echo "CONFIG_GCOV_KERNEL=n
CONFIG_KASAN=n
CONFIG_LTO_CLANG_THIN=y" >allmod.config

$ make -skj"$(nproc)" LLVM=1 LLVM_IAS=1 allmodconfig all

[1]: https://github.com/sharkdp/hyperfine
[2]: https://github.com/ClangBuiltLinux/tc-build

Cheers,
Nathan
