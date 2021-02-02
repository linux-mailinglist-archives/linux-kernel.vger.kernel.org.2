Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E730C30CC5B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhBBTxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 14:53:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56578 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232808AbhBBTwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 14:52:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C0DD264DC4;
        Tue,  2 Feb 2021 19:51:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612295496;
        bh=kFRho8LthVAJM6ke+5o7WVG/qGQoHqd05ziE2IHu2R4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XvUU5HXVRDbcdBkyH7xGWnYT1gEebYzQUMrnNZ6noFkANZZ3lClzZ605TXBsK6lba
         k3LWv0NZAkjoviMxfpd7VeZHylmBHbB5QdAjarbAnpoQChV8yAIRllT39siPgb5lcA
         g+WYeA/9Zs7JraHW3WbWVN7JikcJgfYkpn1ZOrhOFG2cyaf8t1uPRk8qkmIAJVcF0I
         V0kvrpeZcmAV8k3p8T5rQLjvIrdblB2ResTZ4aYnITKSls1g5JhRm5wCC2xIv3I6Bo
         Ls49/svh39FXlSh4Rt3GJTCsYE1iq5xgcuKI0jbJJQGRz7yZOosC8lRIuM3AKcKZXR
         TTRX8n9P/4vcA==
Date:   Tue, 2 Feb 2021 12:51:33 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: Make CPU_BIG_ENDIAN depend on !LD_IS_LLD
Message-ID: <20210202195133.GA1481999@localhost>
References: <20210202022441.1451389-1-nathan@kernel.org>
 <CAK8P3a2864oSVkhaYynoadyYMcYDh0LvDDFSJ2D8OTHSszuSQA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2864oSVkhaYynoadyYMcYDh0LvDDFSJ2D8OTHSszuSQA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 02, 2021 at 09:04:34AM +0100, Arnd Bergmann wrote:
> On Tue, Feb 2, 2021 at 3:25 AM Nathan Chancellor <nathan@kernel.org> wrote:
> >
> > Similar to commit 28187dc8ebd9 ("ARM: 9025/1: Kconfig: CPU_BIG_ENDIAN
> > depends on !LD_IS_LLD"), ld.lld does not support aarch64 big endian,
> > leading to the following build error when CONFIG_CPU_BIG_ENDIAN is
> > selected:
> >
> > ld.lld: error: unknown emulation: aarch64linuxb
> 
> While this is the original error message I reported, I think it would be
> better to explain that lld actually does support linking big-endian
> kernels but they don't boot, for unknown reasons.

That statement seems to contradict what Peter Smith says:

https://github.com/ClangBuiltLinux/linux/issues/1288#issuecomment-770693582

https://reviews.llvm.org/D58655#1410282

> I can send a patch to address the build error and mark big-endian
> as "depends on !LD_IS_LLD || COMPILE_TEST" to reflect that
> and help with randconfig testing.

I have no strong opinion on handling this though.

Cheers,
Nathan
