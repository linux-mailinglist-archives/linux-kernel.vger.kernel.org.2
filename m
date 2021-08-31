Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1B703FCDEA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240896AbhHaThG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 15:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240873AbhHaThB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 15:37:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48113C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 12:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=dPXocIsffJsC7BTSpE9Q2xOCkrLHiRU6IRBDs6FOToM=; b=N7/N1vFlPNSH3sd7UPyxfrzNz1
        mUx1IQmO1vueD+YazoemijtCcvqG03/UM6gwQR4rYcGmyS8TPaNjlcCuJ9BeNXnZgWjkBszl+wNZg
        hX/pPum7jQTOTql/dRF2wo7s02AsSKp6LDplK3JXDHtZRK9gYOdtGVQ+Un1lFe3fzxL1J4K3CYW4I
        ZSq38C6fU83c2DMD1WwIi5s0JLgOumid8mP5n2Ay9xsdKZy0eF+rU+6XgngRzUgIEKlCQS87QQCq+
        f7BJxLF1+LEWyh3FNSzW4tFNCLyqYrGM5CQig8d8+NWBdDFI2+aD7tVCuM/BzmTcGMhdJSyLsRpSi
        Poa69JJw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mL9Wm-001Va5-0F; Tue, 31 Aug 2021 19:34:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id C1D0B98176D; Tue, 31 Aug 2021 21:34:30 +0200 (CEST)
Date:   Tue, 31 Aug 2021 21:34:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 05/24] x86/entry: Introduce __entry_text for entry code
 written in C
Message-ID: <20210831193430.GL4353@worktop.programming.kicks-ass.net>
References: <20210831175025.27570-1-jiangshanlai@gmail.com>
 <20210831175025.27570-6-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210831175025.27570-6-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 01, 2021 at 01:50:06AM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> Some entry code will be implemented in traps.c.  We need __entry_text
> to set them in .entry.text section.
> 
> Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> ---
>  arch/x86/entry/traps.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/entry/traps.c b/arch/x86/entry/traps.c
> index f71db7934f90..ef07ae5fb3a0 100644
> --- a/arch/x86/entry/traps.c
> +++ b/arch/x86/entry/traps.c
> @@ -69,6 +69,11 @@
>  extern unsigned char native_irq_return_iret[];
>  extern unsigned char asm_load_gs_index_gs_change[];
>  
> +/* Entry code written in C. Must be only used in traps.c */
> +#define __entry_text							\
> +	noinline notrace __attribute((__section__(".entry.text")))	\
> +	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage

Urgh, that's bound to get out of sync with noinstr.. How about you make
noinstr something like:

#define __noinstr_section(section) \
	noinline notrace __attribute((__section__(section)))	\
	__no_kcsan __no_sanitize_address __no_profile __no_sanitize_coverage

#define noinstr __noinstr_section(".noinstr.text")

and then write the above like:

#define __entry_text __noinstr_section(".entry.text")


