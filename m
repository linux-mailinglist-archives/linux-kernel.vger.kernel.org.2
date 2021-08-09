Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 003FE3E48C6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 17:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhHIP0S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 11:26:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59714 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235677AbhHIPZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 11:25:47 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 934B7EA99E;
        Mon,  9 Aug 2021 11:25:25 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=An3Ysq0BWcQIGV5ILuMU43T335Y2wnTACUY2jQ
        9zklw=; b=sW8LjIVWOZNO0FC/Dc8G4gEsSAzkFeUhZmEUOVysufPfgdWksqWOFm
        UYYFBcI8LxRXZtP7gHdai6CKQ2/LDlY8AmWKEwuI4OK7J/sTxK0WPlxGJPvC8Zem
        3KXOyWgY3E34qmje+igCzKLfGz+d4o309O4osAn+zMQKPGrSOhb2I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8A98FEA99D;
        Mon,  9 Aug 2021 11:25:25 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=An3Ysq0BWcQIGV5ILuMU43T335Y2wnTACUY2jQ9zklw=; b=pY8OdQ6ZAEnGtsf/WYvRaxUXTMdNBDkOVgahHv1In8oXBU83Ov+OLjcvD63xDIpnzzlXA3XqhEUjMM6SOi70l7/a6DW7vsc9I05KwUASrRrmNpRm4+zW3Q/4q+Pdz1JVCOl2+t7nG88NrEPOZTOYKVUB08iNzoLGvuxUh+sYU10=
Received: from yoda.home (unknown [96.21.170.108])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0A180EA99C;
        Mon,  9 Aug 2021 11:25:25 -0400 (EDT)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 1E0272DA0B8A;
        Mon,  9 Aug 2021 11:25:24 -0400 (EDT)
Date:   Mon, 9 Aug 2021 11:25:24 -0400 (EDT)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     David Heidelberg <david@ixit.cz>
cc:     Arnd Bergmann <arnd@arndb.de>, Jon Medhurst <tixy@linaro.org>,
        Russell King <linux@arm.linux.org.uk>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: atags_to_fdt: don't warn about stack size
In-Reply-To: <20210809151021.5137-1-david@ixit.cz>
Message-ID: <5qs88614-n75s-1rn5-353r-o1p96s5qp59n@syhkavp.arg>
References: <20210809151021.5137-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: 04DD028C-F926-11EB-90B2-FD8818BA3BAF-78420484!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Aug 2021, David Heidelberg wrote:

> The merge_fdt_bootargs() function by definition consumes more than 1024
> bytes of stack because it has a 1024 byte command line on the stack,
> meaning that we always get a warning when building this file:
> 
> arch/arm/boot/compressed/atags_to_fdt.c: In function 'merge_fdt_bootargs':
> arch/arm/boot/compressed/atags_to_fdt.c:98:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> However, as this is the decompressor and we know that it has a very shallow
> call chain, and we do not actually risk overflowing the kernel stack
> at runtime here.
> 
> This just shuts up the warning by disabling the warning flag for this
> file.
> 
> Tested on Nexus 7 2012 builds.
> 
> Original Author: Arnd Bergmann <arnd@arndb.de>
> Reference: https://lore.kernel.org/lkml/8232115.18ykgQ6J5T@wuerfel/
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Nicolas Pitre <nico@linaro.org>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>

Acked-by: Nicolas Pitre <nico@fluxnic.net>

> ---
>  arch/arm/boot/compressed/Makefile | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
> index 9d91ae1091b0..91265e7ff672 100644
> --- a/arch/arm/boot/compressed/Makefile
> +++ b/arch/arm/boot/compressed/Makefile
> @@ -85,6 +85,8 @@ compress-$(CONFIG_KERNEL_LZ4)  = lz4
>  libfdt_objs := fdt_rw.o fdt_ro.o fdt_wip.o fdt.o
>  
>  ifeq ($(CONFIG_ARM_ATAG_DTB_COMPAT),y)
> +CFLAGS_REMOVE_atags_to_fdt.o += -Wframe-larger-than=${CONFIG_FRAME_WARN}
> +CFLAGS_atags_to_fdt.o += -Wframe-larger-than=1280
>  OBJS	+= $(libfdt_objs) atags_to_fdt.o
>  endif
>  ifeq ($(CONFIG_USE_OF),y)
> -- 
> 2.30.2
> 
> 
