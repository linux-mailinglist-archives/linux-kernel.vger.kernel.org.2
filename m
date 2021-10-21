Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65522435ED2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhJUKRg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 06:17:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229765AbhJUKRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 06:17:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 337EA60F5D;
        Thu, 21 Oct 2021 10:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634811318;
        bh=3KefFL9wea8DymntAjOwwZ1IuPc4DgkYtD4ihJq/Jg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAuJ1gP781Re1GFx0uf+8Six0abPXdp+RqIPiZT4Fp4TTOW+do9UYc9J+0eDBoWc/
         r7K2iFyLkcQjqurZnrX8meqfVLV0YjbTi3JQyKUfBmYyaN+UMHDH7o3w+HhhSsRkJL
         EcJdrgy5kpWIPgUGK2I+49v6f84EJoQ6VdBUgSKJ/3SdY3uZGej/3Yjk1+aExRzf07
         MREitKO4Ez+0MhENJ7+W6vK/LkSFRGlwOd7pIbsvHUZqr1duatR4NIzMvcOsowfppE
         FyL2Z179gYlqHPk4X/vQmbiy+FL2JHgC/Npzv30jkZJEYlMRnv54E/55UQvS/41GSK
         Ur3Yo0plHKhQQ==
Date:   Thu, 21 Oct 2021 11:15:12 +0100
From:   Will Deacon <will@kernel.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ananth N Mavinakayanahalli <ananth@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 6/9] arm64: Recover kretprobe modified return address
 in stacktrace
Message-ID: <20211021101512.GA16485@willie-the-truck>
References: <163477765570.264901.3851692300287671122.stgit@devnote2>
 <163477770935.264901.1772964361191833681.stgit@devnote2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163477770935.264901.1772964361191833681.stgit@devnote2>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2021 at 09:55:09AM +0900, Masami Hiramatsu wrote:
> Since the kretprobe replaces the function return address with
> the kretprobe_trampoline on the stack, stack unwinder shows it
> instead of the correct return address.
> 
> This checks whether the next return address is the
> __kretprobe_trampoline(), and if so, try to find the correct
> return address from the kretprobe instance list. For this purpose
> this adds 'kr_cur' loop cursor to memorize the current kretprobe
> instance.
> 
> With this fix, now arm64 can enable
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE, and pass the
> kprobe self tests.
> 
> Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> ---
>  Changes in v2:
>   - Add comment for kr_cur.
>   - Make the kretprobe related code depends on CONFIG_KRETPROBES.
>   - Initialize "kr_cur" directly in start_backtrace() instead
>     of clearing "frame" data structure by memset().
> ---
>  arch/arm64/Kconfig                  |    1 +
>  arch/arm64/include/asm/stacktrace.h |    4 ++++
>  arch/arm64/kernel/stacktrace.c      |    7 +++++++
>  3 files changed, 12 insertions(+)

Acked-by: Will Deacon <will@kernel.org>

I'm not sure how you're planning to merge this, so please let me know if
you want me to queue any of the arm64 bits.

Will
