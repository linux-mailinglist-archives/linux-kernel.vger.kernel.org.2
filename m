Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D188325748
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 21:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbhBYUHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 15:07:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:58756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229993AbhBYUHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 15:07:24 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B79460235;
        Thu, 25 Feb 2021 20:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1614283598;
        bh=CYRFdOJBvR/yxA/tEE02fkILr27KR8sdKgRLGbX0XJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S33rec2d419BnIoz2NtABr9//difXwnak25NChMOhjvN6ZTsyFaqfjV2ucFur3pq4
         fHya/yOpRzuBJn5cSTbd0GcRU6zLDuJOYQftypmqde19m1QDK/d5lLtSgMHIFEa3hX
         2RWT6bilc9L1vE/FyPF+lcKa9gjPUjzUPT7IQp3E=
Date:   Thu, 25 Feb 2021 12:06:37 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>,
        Marco Elver <elver@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Randy Dunlap <rdunlap@infradead.org>,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/compiler-clang.h: define HAVE_BUILTIN_BSWAP*
Message-Id: <20210225120637.8e2a234f192952829fc5f471@linux-foundation.org>
In-Reply-To: <202102251203.03762F77@keescook>
References: <20210225164513.3667778-1-arnd@kernel.org>
        <202102251203.03762F77@keescook>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Feb 2021 12:03:48 -0800 Kees Cook <keescook@chromium.org> wrote:

> On Thu, Feb 25, 2021 at 05:45:09PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > Separating compiler-clang.h from compiler-gcc.h inadventently dropped the
> > definitions of the three HAVE_BUILTIN_BSWAP macros, which requires falling
> > back to the open-coded version and hoping that the compiler detects it.
> > 
> > Since all versions of clang support the __builtin_bswap interfaces,
> > add back the flags and have the headers pick these up automatically.
> > 
> > This results in a 4% improvement of compilation speed for arm defconfig.
> > 
> > Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Cc: stable@vger.kernel.org

I figured 4% better compile time isn't significant enough to justify a
backport.  Thoughts?

> Reviewed-by: Kees Cook <keescook@chromium.org>

