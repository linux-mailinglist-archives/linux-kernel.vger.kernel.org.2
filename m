Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124F530D91F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 12:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbhBCLrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 06:47:01 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:52637 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234358AbhBCLq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 06:46:58 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4DW0J76QHCz9tkZ; Wed,  3 Feb 2021 22:46:15 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Michal Suchanek <msuchanek@suse.de>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>,
        Nicholas Piggin <npiggin@gmail.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Greentime Hu <green.hu@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20201223171142.707053-1-masahiroy@kernel.org>
References: <20201223171142.707053-1-masahiroy@kernel.org>
Subject: Re: [PATCH 1/2] powerpc/vdso: fix unnecessary rebuilds of vgettimeofday.o
Message-Id: <161235275232.1521894.16951995123573238099.b4-ty@ellerman.id.au>
Date:   Wed,  3 Feb 2021 22:46:15 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Dec 2020 02:11:41 +0900, Masahiro Yamada wrote:
> vgettimeofday.o is unnecessarily rebuilt. Adding it to 'targets' is not
> enough to fix the issue. Kbuild is correctly rebuilding it because the
> command line is changed.
> 
> PowerPC builds each vdso directory twice; first in vdso_prepare to
> generate vdso{32,64}-offsets.h, second as part of the ordinary build
> process to embed vdso{32,64}.so.dbg into the kernel.
> 
> [...]

Applied to powerpc/fixes.

[1/2] powerpc/vdso: fix unnecessary rebuilds of vgettimeofday.o
      https://git.kernel.org/powerpc/c/bce74491c3008e27dd6e8f79a83b4faa77a08f7e
[2/2] powerpc/vdso64: remove meaningless vgettimeofday.o build rule
      https://git.kernel.org/powerpc/c/66f0a9e058fad50e569ad752be72e52701991fd5

cheers
