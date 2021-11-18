Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90CA045594C
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 11:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245723AbhKRKqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 05:46:09 -0500
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51981 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244339AbhKRKqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 05:46:07 -0500
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.94)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1mnesh-003VDt-Kw; Thu, 18 Nov 2021 11:43:03 +0100
Received: from p57bd9804.dip0.t-ipconnect.de ([87.189.152.4] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.94)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1mnesh-000icS-BO; Thu, 18 Nov 2021 11:43:03 +0100
Message-ID: <da752ffc-1694-d76b-cd65-ebbbec11b8ea@physik.fu-berlin.de>
Date:   Thu, 18 Nov 2021 11:43:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] ia64: module: use swap() to make code cleaner
Content-Language: en-US
To:     cgel.zte@gmail.com, akpm@linux-foundation.org
Cc:     slyfox@gentoo.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yao Jing <yao.jing2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211118062002.164121-1-yao.jing2@zte.com.cn>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
In-Reply-To: <20211118062002.164121-1-yao.jing2@zte.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.152.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 11/18/21 07:20, cgel.zte@gmail.com wrote:
> From: Yao Jing <yao.jing2@zte.com.cn>
> 
> Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
> opencoding it.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yao Jing <yao.jing2@zte.com.cn>
> ---
>  arch/ia64/kernel/module.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
> index 2cba53c1da82..360f36b0eb3f 100644
> --- a/arch/ia64/kernel/module.c
> +++ b/arch/ia64/kernel/module.c
> @@ -848,7 +848,7 @@ register_unwind_table (struct module *mod)
>  {
>  	struct unw_table_entry *start = (void *) mod->arch.unwind->sh_addr;
>  	struct unw_table_entry *end = start + mod->arch.unwind->sh_size / sizeof (*start);
> -	struct unw_table_entry tmp, *e1, *e2, *core, *init;
> +	struct unw_table_entry *e1, *e2, *core, *init;
>  	unsigned long num_init = 0, num_core = 0;
>  
>  	/* First, count how many init and core unwind-table entries there are.  */
> @@ -865,9 +865,7 @@ register_unwind_table (struct module *mod)
>  	for (e1 = start; e1 < end; ++e1) {
>  		for (e2 = e1 + 1; e2 < end; ++e2) {
>  			if (e2->start_offset < e1->start_offset) {
> -				tmp = *e1;
> -				*e1 = *e2;
> -				*e2 = tmp;
> +				swap(*e1, *e2);
>  			}
>  		}
>  	}

I will test this patch later this week.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

