Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036E043B666
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 18:05:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237219AbhJZQHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 12:07:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:33407 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234271AbhJZQHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 12:07:33 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 19QFxfkQ012472;
        Tue, 26 Oct 2021 10:59:41 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 19QFxeef012468;
        Tue, 26 Oct 2021 10:59:40 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 26 Oct 2021 10:59:40 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/boot: Set LC_ALL=C in wrapper script
Message-ID: <20211026155940.GX614@gate.crashing.org>
References: <a9ff3bc98035f63b122c051f02dc47c7aed10430.1635256089.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a9ff3bc98035f63b122c051f02dc47c7aed10430.1635256089.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 03:48:29PM +0200, Christophe Leroy wrote:
> While trying to build a simple Image for ACADIA platform, I got the
> following error:
> 
> 	  WRAP    arch/powerpc/boot/simpleImage.acadia
> 	INFO: Uncompressed kernel (size 0x6ae7d0) overlaps the address of the wrapper(0x400000)
> 	INFO: Fixing the link_address of wrapper to (0x700000)
> 	powerpc64-linux-gnu-ld : mode d'émulation non reconnu : -T
> 	Émulations prises en charge : elf64ppc elf32ppc elf32ppclinux elf32ppcsim elf64lppc elf32lppc elf32lppclinux elf32lppcsim
> 	make[1]: *** [arch/powerpc/boot/Makefile:424 : arch/powerpc/boot/simpleImage.acadia] Erreur 1
> 	make: *** [arch/powerpc/Makefile:285 : simpleImage.acadia] Erreur 2
> 
> Trying again with V=1 shows the following command
> 
> 	powerpc64-linux-gnu-ld -m -T arch/powerpc/boot/zImage.lds -Ttext 0x700000 --no-dynamic-linker -o arch/powerpc/boot/simpleImage.acadia -Map wrapper.map arch/powerpc/boot/fixed-head.o arch/powerpc/boot/simpleboot.o ./zImage.3278022.o arch/powerpc/boot/wrapper.a
> 
> The argument of '-m' is missing.
> 
> This is due to the wrapper script calling 'objdump -p vmlinux' and
> looking for 'file format', whereas the output of objdump is:
> 
> 	vmlinux:     format de fichier elf32-powerpc
> 
> 	En-tête de programme:
> 	    LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
> 	         filesz 0x0069e1d4 memsz 0x006c128c flags rwx
> 	    NOTE off    0x0064591c vaddr 0xc063591c paddr 0x0063591c align 2**2
> 	         filesz 0x00000054 memsz 0x00000054 flags ---
> 
> Add LC_ALL=C at the beginning of the wrapper script in order to get the
> output expected by the script:
> 
> 	vmlinux:     file format elf32-powerpc
> 
> 	Program Header:
> 	    LOAD off    0x00010000 vaddr 0xc0000000 paddr 0x00000000 align 2**16
> 	         filesz 0x0069e1d4 memsz 0x006c128c flags rwx
> 	    NOTE off    0x0064591c vaddr 0xc063591c paddr 0x0063591c align 2**2
> 	         filesz 0x00000054 memsz 0x00000054 flags ---
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

Acked-by: Segher Boessenkool <segher@kernel.crashing.org>

Thanks,


Segher
