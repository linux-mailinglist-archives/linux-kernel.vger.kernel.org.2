Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 390AC347FCC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 18:51:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237304AbhCXRuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 13:50:46 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52727 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237197AbhCXRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 13:50:18 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212])
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1lP7e4-0004zH-LD; Wed, 24 Mar 2021 17:50:16 +0000
Subject: Re: [PATCH] x86/kprobes: Remove dead code
To:     Muhammad Usama Anjum <musamaanjum@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        dan.carpenter@oracle.com
References: <20210324173641.GA404706@LEGION>
From:   Colin Ian King <colin.king@canonical.com>
Message-ID: <5fcd5b04-0fab-3672-c5d2-6e8f73f93bbc@canonical.com>
Date:   Wed, 24 Mar 2021 17:50:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210324173641.GA404706@LEGION>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2021 17:36, Muhammad Usama Anjum wrote:
> The condition in switch statement `opcode & 0xf0` cannot evaluate to
> 0xff. So this case statement will never execute. Remove it.
> 
> Fixes: 6256e668b7 ("x86/kprobes: Use int3 instead of debug trap for single-step")
> Signed-off-by: Muhammad Usama Anjum <musamaanjum@gmail.com>
> ---
>  arch/x86/kernel/kprobes/core.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> index 89d9f26785c7..3b7bcc077020 100644
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -177,9 +177,6 @@ int can_boost(struct insn *insn, void *addr)
>  	case 0xf0:
>  		/* clear and set flags are boostable */
>  		return (opcode == 0xf5 || (0xf7 < opcode && opcode < 0xfe));
> -	case 0xff:
> -		/* indirect jmp is boostable */
> -		return X86_MODRM_REG(insn->modrm.bytes[0]) == 4;
>  	default:
>  		/* CS override prefix and call are not boostable */
>  		return (opcode != 0x2e && opcode != 0x9a);
> 

The 0xff case was added with some form of intention to be executed so I
suspect removing it is not an appropriate fix.

