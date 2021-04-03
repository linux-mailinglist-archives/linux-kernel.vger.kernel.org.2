Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC333533F9
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 14:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbhDCMJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 08:09:08 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:48893 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbhDCMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 08:09:07 -0400
X-Originating-IP: 2.7.49.219
Received: from [192.168.1.100] (lfbn-lyo-1-457-219.w2-7.abo.wanadoo.fr [2.7.49.219])
        (Authenticated sender: alex@ghiti.fr)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 53949C0004;
        Sat,  3 Apr 2021 12:09:02 +0000 (UTC)
Subject: Re: [PATCH] driver: of: Properly truncate command line if too long
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210316193820.3137-1-alex@ghiti.fr>
From:   Alex Ghiti <alex@ghiti.fr>
Message-ID: <ee702ff7-f43c-745c-4157-b1cba53bb0b2@ghiti.fr>
Date:   Sat, 3 Apr 2021 08:09:01 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <20210316193820.3137-1-alex@ghiti.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 3/16/21 à 3:38 PM, Alexandre Ghiti a écrit :
> In case the command line given by the user is too long, warn about it
> and truncate it to the last full argument.
> 
> This is what efi already does in commit 80b1bfe1cb2f ("efi/libstub:
> Don't parse overlong command lines").
> 
> Reported-by: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> ---
>   drivers/of/fdt.c | 21 ++++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index dcc1dd96911a..de4c6f9bac39 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -25,6 +25,7 @@
>   #include <linux/serial_core.h>
>   #include <linux/sysfs.h>
>   #include <linux/random.h>
> +#include <linux/ctype.h>
>   
>   #include <asm/setup.h>  /* for COMMAND_LINE_SIZE */
>   #include <asm/page.h>
> @@ -1050,9 +1051,27 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,
>   
>   	/* Retrieve command line */
>   	p = of_get_flat_dt_prop(node, "bootargs", &l);
> -	if (p != NULL && l > 0)
> +	if (p != NULL && l > 0) {
>   		strlcpy(data, p, min(l, COMMAND_LINE_SIZE));
>   
> +		/*
> +		 * If the given command line size is larger than
> +		 * COMMAND_LINE_SIZE, truncate it to the last complete
> +		 * parameter.
> +		 */
> +		if (l > COMMAND_LINE_SIZE) {
> +			char *cmd_p = (char *)data + COMMAND_LINE_SIZE - 1;
> +
> +			while (!isspace(*cmd_p))
> +				cmd_p--;
> +
> +			*cmd_p = '\0';
> +
> +			pr_err("Command line is too long: truncated to %d bytes\n",
> +			       (int)(cmd_p - (char *)data + 1));
> +		}
> +	}
> +
>   	/*
>   	 * CONFIG_CMDLINE is meant to be a default in case nothing else
>   	 * managed to set the command line, unless CONFIG_CMDLINE_FORCE
> 

Any thought about that ?

Thanks,

Alex
