Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C783743C206
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 07:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238228AbhJ0FKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 01:10:13 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:48737 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbhJ0FKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 01:10:12 -0400
Received: (Authenticated sender: alex@ghiti.fr)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5837520007;
        Wed, 27 Oct 2021 05:07:45 +0000 (UTC)
Subject: Re: [PATCH] RISC-V: Make CONFIG_RELOCATABLE user selectable
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Palmer Dabbelt <palmerdabbelt@google.com>
References: <20211026212847.43108-1-palmer@dabbelt.com>
From:   Alexandre ghiti <alex@ghiti.fr>
Message-ID: <c538d656-cef0-728f-2722-2bcc41b8f947@ghiti.fr>
Date:   Wed, 27 Oct 2021 07:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211026212847.43108-1-palmer@dabbelt.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Palmer,

On 10/26/21 11:28 PM, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
>
> This should really be up to the user, as it trades off portability for
> performance.
>
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/Kconfig | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 5dea03549493..f8a36034d54b 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -212,18 +212,6 @@ config PGTABLE_LEVELS
>  config LOCKDEP_SUPPORT
>  	def_bool y
>  
> -config RELOCATABLE
> -	bool
> -	depends on MMU && 64BIT && !XIP_KERNEL
> -	help
> -          This builds a kernel as a Position Independent Executable (PIE),
> -          which retains all relocation metadata required to relocate the
> -          kernel binary at runtime to a different virtual address than the
> -          address it was linked at.
> -          Since RISCV uses the RELA relocation format, this requires a
> -          relocation pass at runtime even if the kernel is loaded at the
> -          same address it was linked at.
> -
>  source "arch/riscv/Kconfig.socs"
>  source "arch/riscv/Kconfig.erratas"
>  
> @@ -433,6 +421,18 @@ config CRASH_DUMP
>  
>  	  For more details see Documentation/admin-guide/kdump/kdump.rst
>  
> +config RELOCATABLE
> +	bool "Build a relocatable kernel"
> +	depends on MMU && 64BIT && !XIP_KERNEL
> +	help
> +          This builds a kernel as a Position Independent Executable (PIE),
> +          which retains all relocation metadata required to relocate the
> +          kernel binary at runtime to a different virtual address than the
> +          address it was linked at.
> +          Since RISCV uses the RELA relocation format, this requires a
> +          relocation pass at runtime even if the kernel is loaded at the
> +          same address it was linked at.
> +
>  endmenu
>  
>  menu "Boot options"


Agreed, you can add:

Reviewed-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>

Thanks for the patch,

Alex

