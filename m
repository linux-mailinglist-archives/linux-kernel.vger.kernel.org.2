Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 908F9324208
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbhBXQZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 11:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbhBXQZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 11:25:01 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F237AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 08:24:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:
        Reply-To:Cc:Content-ID:Content-Description;
        bh=XDaX4omTjZoiDYDyauuQ0b/yWEWf9Flu16sKDshulWc=; b=XOtvB//PMhdv4BX9kKtzYr8ZxI
        91yBE42T7mJIqmn0dY6NROQBdGmyEI/Cb0E3mkt6JEtamNbXtdHvt3lWXAD+6+Uzlj7CYTAN+swuB
        duLQlU6n+UXbRK+92Y7kFN/oYNdtfgWbBUw9TTumKrtZnu4/cAehhuvlYbIHJyvNVPsj34GXF225w
        2zqOxQAR4Mj41zVxbCq/uZ5uJAtey3Jua16A1Cw1MnFbOylJkwR45VnJ36D6qlRB426TmlUuhNwI1
        acDi7D6/2KWm3MiKrfUhsKvqbQ1IBFlEAhIOLzk9EUZ4yypSRvBvOypN9Rto9GSW5LRDFCOmA16dC
        +PKxB7QA==;
Received: from [2601:1c0:6280:3f0::d05b]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lEwxS-0002rR-MM; Wed, 24 Feb 2021 16:24:15 +0000
Subject: Re: [PATCH] arch: powerpc: kernel: Change droping to dropping in the
 file traps.c
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        christophe.leroy@csgroup.eu, npiggin@gmail.com, jniethe5@gmail.com,
        alistair@popple.id.au, mikey@neuling.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20210224075547.763063-1-unixbhaskar@gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7b810bb2-4704-4882-79ce-3e41efc9ea55@infradead.org>
Date:   Wed, 24 Feb 2021 08:24:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210224075547.763063-1-unixbhaskar@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/23/21 11:55 PM, Bhaskar Chowdhury wrote:
> 
> s/droping/dropping/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

> ---
>  arch/powerpc/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
> index 1583fd1c6010..83a53b67412a 100644
> --- a/arch/powerpc/kernel/traps.c
> +++ b/arch/powerpc/kernel/traps.c
> @@ -405,7 +405,7 @@ void hv_nmi_check_nonrecoverable(struct pt_regs *regs)
>  	 * Now test if the interrupt has hit a range that may be using
>  	 * HSPRG1 without having RI=0 (i.e., an HSRR interrupt). The
>  	 * problem ranges all run un-relocated. Test real and virt modes
> -	 * at the same time by droping the high bit of the nip (virt mode
> +	 * at the same time by dropping the high bit of the nip (virt mode
>  	 * entry points still have the +0x4000 offset).
>  	 */
>  	nip &= ~0xc000000000000000ULL;
> --
> 2.30.1
> 


-- 
~Randy

