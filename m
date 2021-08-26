Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10E1F3F8C91
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 18:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243162AbhHZQ5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 12:57:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:53186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243135AbhHZQ5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 12:57:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCD6760F5C;
        Thu, 26 Aug 2021 16:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629997003;
        bh=ueeV4qBK6rbUIoZOJ7roKAYMRwCGRQFtUy2UrgVXrBQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mR4cTYFpWvhQzDtv/nQvQKLDUFm2xC+McT3K+GVpStyJ9YCgrQFNybUlz3hP2GE1J
         14MZEa+dskBlODXgYp6bjRFsZQYDYn37g/B5lTxhakxUWZZV9S78BVBdhltQfFPljd
         d3J9BmIW4x7feKmVDExgHUSaSRTO7pq1kcT6L2naBsGYa40BKOHn1VTZTcOv2BOfmd
         utokdkJ6+150QFBgsG874SZQyC1V7A/W3VxaZIb6ww9ikiiTW9TI7fbEPjMcbweTV5
         5JDwp6tmfn7z3Gc/qZPZJrJJ1IMpy7pGMsHi1WAOOE7dDXS0z9jlXWbvBbqlIBs/Yz
         JxN6TPwaydxAQ==
Subject: Re: [PATCH v2 08/14] x86/extable: Do not mark exception callback as
 CFI
To:     Sami Tolvanen <samitolvanen@google.com>, x86@kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
References: <20210823171318.2801096-1-samitolvanen@google.com>
 <20210823171318.2801096-9-samitolvanen@google.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <e33bdfc8-6de9-0e91-eec6-39e6aca61758@kernel.org>
Date:   Thu, 26 Aug 2021 09:56:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210823171318.2801096-9-samitolvanen@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 10:13 AM, Sami Tolvanen wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> The exception table entries are constructed out of a relative offset
> and point to the actual function, not the CFI table entry. For now,
> just mark the caller as not checking CFI

Does this *mark* the caller as not checking CFI or does it actually make
the caller stop checking CFI?  What are the semantics of a __nocfi function?

> The failure is most visible
> at boot with CONFIG_DEBUG_RODATA_TEST=y.

What's the failure?

> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  arch/x86/mm/extable.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
> index e1664e9f969c..d150d4d12d53 100644
> --- a/arch/x86/mm/extable.c
> +++ b/arch/x86/mm/extable.c
> @@ -155,6 +155,7 @@ enum handler_type ex_get_fault_handler_type(unsigned long ip)
>  		return EX_HANDLER_OTHER;
>  }
>  
> +__nocfi
>  int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
>  		    unsigned long fault_addr)
>  {
> 


This at least needs a comment explaining what's going on.  But maybe it
could be fixed better by either having the extable entry resolve to the
magic CFI table entry (can this be done?) or by marking the actual
indirect call or the type of the variable through which the call is done
as being a non-CFI call.

--Andy
