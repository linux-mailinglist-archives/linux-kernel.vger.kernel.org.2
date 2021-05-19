Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6D1389217
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354529AbhESO6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 10:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239447AbhESO6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 10:58:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242E4C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:57:30 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id g18so8411958pfr.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 07:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fVahKLjhQR6w9YEu/iIUhR87O8vnOphv8dCD1jgEVFs=;
        b=XMaatkUyTuQSg8cEqw8JY/+QYAyqz/LWB7V6cVEIkJULEevSQIOobzw6FQ/OFxmY47
         F35yy10kMVSMRh0nu2MXkR7aj81SEsujN3fpTLE0qq4+5SYNO8AkN8o0WgOwBdbvS2fH
         mQnoREDSWil63mPsS2vLv7JnAS0f/SKDWWkHuFkYG79g4y1J0P8YC1mTha5uLBy5kLM4
         2EeaC2H54XqL4dr6NhgeRaKENC0d/DESKfeSirlIhJnyZ8MdxcsBGEzwBAkc9+uBS+z8
         eeRu/3e8BJ9c3viXPCowksXaWvdWzOWKkAda7mdOHw1tk2DXlfAiD00AKtYShqeJaJGv
         6M9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fVahKLjhQR6w9YEu/iIUhR87O8vnOphv8dCD1jgEVFs=;
        b=iCVVO3EelgxY0xnuFUuIxh6PGmvGTf2LzjBFm7sMJwroEPPKp3LMAIgnDbo1iLJOS7
         bo81/HMjPkjlpEzoGFo7Xv3iBfK2RHlxeMqyIoBhDuoWz733qFVL7uJoekNEcc3H8Ttw
         sk7+mtfNVCApRe0xL37LmrqzHV8lXcbAJwkW8A88FrcuIqOlnyUDqNyu5pz+AY9qj4lf
         3NNQVuc8D9ZlMIa26pDm5b0tsoallTDrnG0tNCqoMEtO+17ER8azpGMMCxeGQXs/K/YT
         fmd037qRSOjwmIBifdQg1AfjYFM4ctFB6QrRnFp+FAYj7mWDjtQ01vgFDHCt2e+hdrnb
         mPOw==
X-Gm-Message-State: AOAM530sU3BHKQiZQqJWKf3/efjNTbg9SgAVU8G68kw6mFRZxdNzEShF
        Zh+ARWO5ryNZev2HAMxRmhrhEw==
X-Google-Smtp-Source: ABdhPJx79MI7Hi+bJlq76qQhld11ZDCycxVB2zyUylIL/r+K36HqxOxICez+TeRJvDpXpDb3frrFjg==
X-Received: by 2002:a65:414d:: with SMTP id x13mr11296094pgp.86.1621436249600;
        Wed, 19 May 2021 07:57:29 -0700 (PDT)
Received: from [192.168.10.23] (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
        by smtp.gmail.com with UTF8SMTPSA id e186sm6496714pfa.145.2021.05.19.07.57.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 07:57:28 -0700 (PDT)
Message-ID: <45533d24-46e6-7d3b-09cc-0fe674404d78@ozlabs.ru>
Date:   Thu, 20 May 2021 00:57:23 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:89.0) Gecko/20100101
 Thunderbird/89.0
Subject: Re: [PATCH v2 2/2] powerpc/legacy_serial: Use early_ioremap()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        chris.packham@alliedtelesis.co.nz
References: <0d51620eacf036d683d1a3c41328f69adb601dc0.1618925560.git.christophe.leroy@csgroup.eu>
 <103ed8ee9e5973c958ec1da2d0b0764f69395d01.1618925560.git.christophe.leroy@csgroup.eu>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <103ed8ee9e5973c958ec1da2d0b0764f69395d01.1618925560.git.christophe.leroy@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2021 23:32, Christophe Leroy wrote:
> From: Christophe Leroy <christophe.leroy@c-s.fr>
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

My POWER9 box silently reboots with the upstream kernel which has this.

This hunk:

diff --git a/arch/powerpc/kernel/legacy_serial.c 
b/arch/powerpc/kernel/legacy_serial.c
index f061e06e9f51..6bdb3f5f64e3 100644
--- a/arch/powerpc/kernel/legacy_serial.c
+++ b/arch/powerpc/kernel/legacy_serial.c
@@ -336,6 +336,16 @@ static void __init setup_legacy_serial_console(int 
console)
                 if (addr == NULL)
                         return;
                 udbg_uart_init_mmio(addr, stride);
+
+
+               {
+                       void *ea = early_ioremap(info->taddr, 0x1000);
+                       pr_err("___K___ (%u) %s %u: ior=%lx early=%lx\n",
+                               smp_processor_id(), __func__, __LINE__,
+                                       (unsigned long) addr, (unsigned 
long) ea);
+                       early_iounmap(ea, 0x1000);
+               }
+


produced:

[    0.000000] ___K___ (0) setup_legacy_serial_console 345: 
ior=c00a0000800003f8 early=ffffffffffc003f8 



The early address just does not look right - ffffffffffc003f8. Do you 
have a quick idea what is exactly wrong before I wake up and dig more? 
:)  It is powernv_defconfig. Thanks,



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

-- 
Alexey
