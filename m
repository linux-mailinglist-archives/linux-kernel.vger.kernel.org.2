Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6204044D5
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 07:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350635AbhIIFPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Sep 2021 01:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350607AbhIIFPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Sep 2021 01:15:02 -0400
X-Greylist: delayed 150 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 08 Sep 2021 22:13:53 PDT
Received: from resqmta-po-07v.sys.comcast.net (resqmta-po-07v.sys.comcast.net [IPv6:2001:558:fe16:19:96:114:154:166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56780C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 22:13:53 -0700 (PDT)
Received: from resomta-po-12v.sys.comcast.net ([96.114.154.236])
        by resqmta-po-07v.sys.comcast.net with ESMTP
        id OCLImHVDhiCWIOCLIm86i2; Thu, 09 Sep 2021 05:11:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=20190202a; t=1631164280;
        bh=oystJQKPfSMh33cVgzrK3+/ksD/HrMaCUgOL0qJ19n8=;
        h=Received:Received:Subject:To:From:Message-ID:Date:MIME-Version:
         Content-Type;
        b=i7D2RaqhRtv7H2XrX8+hr9kZYU8Se8L2e8gmyLJ2BhdoYep6Rec1/fCHmJGDJ7QZ3
         na/BxsioK5sbZQbxt3GLTuopqga0/nQDk141DmOomNmv9CaH3eT+r5PqCcmx7H0u6n
         PITv2Arpxlmajuv3thD52Q9YpRxqQuKAsJ3ldbeyPKksY/P13WprudRrx3qOb8CyD4
         ToEs6cafG7iAxplpN+PgqxQKgSropuYAk/Pz9DvjJbJl31PYovxbakFy+f+RTymFNB
         q7VJjYVElj+KjO5+Arh3IaZIIxvLdmD3+nNkgpTj2lZrrE5d/iHjvXOHJJvveFNmnx
         aJZPQRjl+Kpbg==
Received: from [IPv6:2601:647:4700:284:1e0c:aa38:8744:8d36]
 ([IPv6:2601:647:4700:284:1e0c:aa38:8744:8d36])
        by resomta-po-12v.sys.comcast.net with ESMTPSA
        id OCLEmsKh5ILMGOCLEm9Jyo; Thu, 09 Sep 2021 05:11:18 +0000
X-Xfinity-VMeta: sc=-100.00;st=legit
Subject: Re: [PATCH] riscv: set default pm_power_off to NULL
To:     Dimitri John Ledkov <dimitri.ledkov@canonical.com>,
        linux-riscv@lists.infradead.org
Cc:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org
References: <20210907002847.111633-1-dimitri.ledkov@canonical.com>
From:   Ron Economos <w6rz@comcast.net>
Message-ID: <31e42fe2-0a9b-6d2d-33fe-be66d516b9cf@comcast.net>
Date:   Wed, 8 Sep 2021 22:11:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210907002847.111633-1-dimitri.ledkov@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/6/21 5:28 PM, Dimitri John Ledkov wrote:

> Set pm_power_off to NULL like on all other architectures, check if it
> is set in machine_halt() and machine_power_off() and fallback to
> default_power_off if no other power driver got registered.
>
> This brings riscv architecture inline with all other architectures,
> and allows to reuse exiting power drivers unmodified.
>
> Kernels without legacy SBI v0.1 extensions (CONFIG_RISCV_SBI_V01 is
> not set), do not set pm_power_off to sbi_shutdown(). There is no
> support for SBI v0.3 system reset extension either. This prevents
> using gpio_poweroff on SiFive HiFive Unmatched.
>
> Tested on SiFive HiFive unmatched, with a dtb specifying gpio-poweroff
> node and kernel complied without CONFIG_RISCV_SBI_V01.
>
> BugLink: https://bugs.launchpad.net/bugs/1942806
> Signed-off-by: Dimitri John Ledkov <dimitri.ledkov@canonical.com>
> ---
>   arch/riscv/kernel/reset.c | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/arch/riscv/kernel/reset.c b/arch/riscv/kernel/reset.c
> index ee5878d968..9c842c4168 100644
> --- a/arch/riscv/kernel/reset.c
> +++ b/arch/riscv/kernel/reset.c
> @@ -12,7 +12,7 @@ static void default_power_off(void)
>   		wait_for_interrupt();
>   }
>   
> -void (*pm_power_off)(void) = default_power_off;
> +void (*pm_power_off)(void) = NULL;
>   EXPORT_SYMBOL(pm_power_off);
>   
>   void machine_restart(char *cmd)
> @@ -23,10 +23,16 @@ void machine_restart(char *cmd)
>   
>   void machine_halt(void)
>   {
> -	pm_power_off();
> +	if (pm_power_off != NULL)
> +		pm_power_off();
> +	else
> +		default_power_off();
>   }
>   
>   void machine_power_off(void)
>   {
> -	pm_power_off();
> +	if (pm_power_off != NULL)
> +		pm_power_off();
> +	else
> +		default_power_off();
>   }

Works good here. Tested on HiFive Unmatched, Ubuntu 21.04 and kernel 5.14.2

Tested-by: Ron Economos <w6rz@comcast.net>


