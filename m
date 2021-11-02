Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3F16442CE3
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbhKBLln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231548AbhKBLlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671ADC06120B
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fn3n7xz4xdK;
        Tue,  2 Nov 2021 22:38:37 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <a9ff3bc98035f63b122c051f02dc47c7aed10430.1635256089.git.christophe.leroy@csgroup.eu>
References: <a9ff3bc98035f63b122c051f02dc47c7aed10430.1635256089.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/boot: Set LC_ALL=C in wrapper script
Message-Id: <163584791652.1845480.7970376759421988538.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:56 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 15:48:29 +0200, Christophe Leroy wrote:
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
> [...]

Applied to powerpc/next.

[1/1] powerpc/boot: Set LC_ALL=C in wrapper script
      https://git.kernel.org/powerpc/c/b949d009dd52ecdced248889cf11297677f9e8a6

cheers
