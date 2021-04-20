Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 968E1365A55
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 15:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhDTNjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 09:39:43 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:41466 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231661AbhDTNjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:39:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FPlCH1bXtz9v0D3;
        Tue, 20 Apr 2021 15:39:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id czzfRPgP9jMC; Tue, 20 Apr 2021 15:39:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FPlCH0j68z9v0D2;
        Tue, 20 Apr 2021 15:39:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 62FFF8B807;
        Tue, 20 Apr 2021 15:39:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id y3otevbcdMcC; Tue, 20 Apr 2021 15:39:08 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id DD6C18B7ED;
        Tue, 20 Apr 2021 15:39:07 +0200 (CEST)
Subject: Re: [PATCH v2 2/2] powerpc/legacy_serial: Use early_ioremap()
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        chris.packham@alliedtelesis.co.nz
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <0d51620eacf036d683d1a3c41328f69adb601dc0.1618925560.git.christophe.leroy@csgroup.eu>
 <103ed8ee9e5973c958ec1da2d0b0764f69395d01.1618925560.git.christophe.leroy@csgroup.eu>
Message-ID: <fe1c0be9-68fb-2c2e-f939-40aa2fe5745a@csgroup.eu>
Date:   Tue, 20 Apr 2021 15:39:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <103ed8ee9e5973c958ec1da2d0b0764f69395d01.1618925560.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 20/04/2021 à 15:32, Christophe Leroy a écrit :
> From: Christophe Leroy <christophe.leroy@c-s.fr>

Oops, I forgot to reset the Author. Michael if you apply this patch please update the author and 
remove the old Signed-off-by

Thanks

> 
> [    0.000000] ioremap() called early from find_legacy_serial_ports+0x3cc/0x474. Use early_ioremap() instead
> 
> find_legacy_serial_ports() is called early from setup_arch(), before
> paging_init(). vmalloc is not available yet, ioremap shouldn't be
> used that early.
> 
> Use early_ioremap() and switch to a regular ioremap() later.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>   arch/powerpc/kernel/legacy_serial.c | 33 +++++++++++++++++++++++++----
>   1 file changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/legacy_serial.c b/arch/powerpc/kernel/legacy_serial.c
> index f061e06e9f51..8b2c1a8553a0 100644
> --- a/arch/powerpc/kernel/legacy_serial.c
> +++ b/arch/powerpc/kernel/legacy_serial.c
> @@ -15,6 +15,7 @@
>   #include <asm/udbg.h>
>   #include <asm/pci-bridge.h>
>   #include <asm/ppc-pci.h>
> +#include <asm/early_ioremap.h>
>   
>   #undef DEBUG
>   
> @@ -34,6 +35,7 @@ static struct legacy_serial_info {
>   	unsigned int			clock;
>   	int				irq_check_parent;
>   	phys_addr_t			taddr;
> +	void __iomem			*early_addr;
>   } legacy_serial_infos[MAX_LEGACY_SERIAL_PORTS];
>   
>   static const struct of_device_id legacy_serial_parents[] __initconst = {
> @@ -325,17 +327,16 @@ static void __init setup_legacy_serial_console(int console)
>   {
>   	struct legacy_serial_info *info = &legacy_serial_infos[console];
>   	struct plat_serial8250_port *port = &legacy_serial_ports[console];
> -	void __iomem *addr;
>   	unsigned int stride;
>   
>   	stride = 1 << port->regshift;
>   
>   	/* Check if a translated MMIO address has been found */
>   	if (info->taddr) {
> -		addr = ioremap(info->taddr, 0x1000);
> -		if (addr == NULL)
> +		info->early_addr = early_ioremap(info->taddr, 0x1000);
> +		if (info->early_addr == NULL)
>   			return;
> -		udbg_uart_init_mmio(addr, stride);
> +		udbg_uart_init_mmio(info->early_addr, stride);
>   	} else {
>   		/* Check if it's PIO and we support untranslated PIO */
>   		if (port->iotype == UPIO_PORT && isa_io_special)
> @@ -353,6 +354,30 @@ static void __init setup_legacy_serial_console(int console)
>   	udbg_uart_setup(info->speed, info->clock);
>   }
>   
> +static int __init ioremap_legacy_serial_console(void)
> +{
> +	struct legacy_serial_info *info = &legacy_serial_infos[legacy_serial_console];
> +	struct plat_serial8250_port *port = &legacy_serial_ports[legacy_serial_console];
> +	void __iomem *vaddr;
> +
> +	if (legacy_serial_console < 0)
> +		return 0;
> +
> +	if (!info->early_addr)
> +		return 0;
> +
> +	vaddr = ioremap(info->taddr, 0x1000);
> +	if (WARN_ON(!vaddr))
> +		return -ENOMEM;
> +
> +	udbg_uart_init_mmio(vaddr, 1 << port->regshift);
> +	early_iounmap(info->early_addr, 0x1000);
> +	info->early_addr = NULL;
> +
> +	return 0;
> +}
> +early_initcall(ioremap_legacy_serial_console);
> +
>   /*
>    * This is called very early, as part of setup_system() or eventually
>    * setup_arch(), basically before anything else in this file. This function
> 
