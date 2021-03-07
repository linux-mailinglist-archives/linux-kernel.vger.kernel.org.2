Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6645632FF45
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Mar 2021 07:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbhCGGaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Mar 2021 01:30:10 -0500
Received: from gate.crashing.org ([63.228.1.57]:38712 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229619AbhCGGaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Mar 2021 01:30:01 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 1276NdCi026488;
        Sun, 7 Mar 2021 00:23:39 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 1276NbRn026484;
        Sun, 7 Mar 2021 00:23:37 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 7 Mar 2021 00:23:36 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Fangrui Song <maskray@google.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH] Replace __toc_start + 0x8000 with .TOC.
Message-ID: <20210307062336.GD29191@gate.crashing.org>
References: <20210307051433.2756645-1-maskray@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210307051433.2756645-1-maskray@google.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sat, Mar 06, 2021 at 09:14:33PM -0800, Fangrui Song wrote:
> TOC relocations are like GOT relocations on other architectures.
> However, unlike other architectures, GNU ld's ppc64 port defines .TOC.
> relative to the .got output section instead of the linker synthesized
> .got input section. LLD defines .TOC. as the .got input section plus
> 0x8000. When CONFIG_PPC_OF_BOOT_TRAMPOLINE=y,
> arch/powerpc/kernel/prom_init.o is built, and LLD computed .TOC. can be
> different from __toc_start defined by the linker script.
> 
> Simplify kernel_toc_addr with asm label .TOC. so that we can get rid of
> __toc_start.
> 
> With this change, powernv_defconfig with CONFIG_PPC_OF_BOOT_TRAMPOLINE=y
> is bootable with LLD. There is still an untriaged issue with Alexey's
> configuration.

Do you have any explanation why this *does* work, while the original
doesn't?  Some explanation that says *what* is wrong.  To me it doesn't
look like the kernel script is.


Segher
