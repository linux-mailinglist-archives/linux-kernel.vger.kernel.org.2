Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77BEE3A7BAA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 12:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhFOKXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 06:23:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:37082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230519AbhFOKXv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 06:23:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9465A613E4;
        Tue, 15 Jun 2021 10:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623752506;
        bh=RBmrNzdD29pbkZY04hPSjy26BGIJY0hwdDMa9N3theY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F56c6OpeqSZfrDKzx1bTTwU++gXnN5bX++AXdS2dlrOmMSfLF+lPoMhTx4mtkh3+R
         Oo2Lo2o4mONwM8ia2kY5e1rcCAituYqu0AV7M8jdaa3AjKX7rZjO1Q5ATn3zTiKCF6
         r8+uwhiYuZjQO9dPeSZKmwFiIDUDXtzK+9/8yfz28VzpjWGevjcjHhvn26bB1XjZsz
         JjAxH9X5n6q9jw/gtryoSE0Y6ME2I30kDlOjsSedWoyYbZg+ORCd8+dy4DDDJQ6OTR
         tLJ8i9gM6sS/t0hrAXxljqpWLb+j9ItWIVJ2pS5zI5+eWVyqEFCDbQdhXCsPgsMR+U
         bqnXYEP7g+MlA==
Date:   Tue, 15 Jun 2021 11:21:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Dmitry Safonov <dima@arista.com>
Cc:     linux-kernel@vger.kernel.org,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 04/23] arm64: Use in_compat_task() in
 arch_setup_additional_pages()
Message-ID: <20210615102140.GA20225@willie-the-truck>
References: <20210611180242.711399-1-dima@arista.com>
 <20210611180242.711399-5-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611180242.711399-5-dima@arista.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 11, 2021 at 07:02:23PM +0100, Dmitry Safonov wrote:
> Instead of providing compat_arch_setup_additional_pages(), check if the
> task is compatible from personality, which is set earlier in
> load_elf_binary(). That will align code with powerpc and sparc, also
> it'll allow to completely remove compat_arch_setyp_addtional_pages()
> macro after doing the same for x86, simiplifying the binfmt code
> in the end and leaving elf loader single function.
> 
> Cc: linux-arm-kernel@lists.infradead.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> ---
>  arch/arm64/include/asm/elf.h |  5 -----
>  arch/arm64/kernel/vdso.c     | 21 ++++++++++-----------
>  2 files changed, 10 insertions(+), 16 deletions(-)

Acked-by: Will Deacon <will@kernel.org>

Will
