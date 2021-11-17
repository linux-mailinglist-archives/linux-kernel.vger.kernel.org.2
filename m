Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF1E745459F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 12:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236802AbhKQL2o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Nov 2021 06:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233972AbhKQL2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Nov 2021 06:28:40 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 668ACC061570
        for <linux-kernel@vger.kernel.org>; Wed, 17 Nov 2021 03:25:42 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HvLFw4Gcwz4xdW;
        Wed, 17 Nov 2021 22:25:40 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
In-Reply-To: <20211109185015.615517-1-masahiroy@kernel.org>
References: <20211109185015.615517-1-masahiroy@kernel.org>
Subject: Re: [PATCH] powerpc: clean vdso32 and vdso64 directories
Message-Id: <163714821050.1508509.1378396894524200025.b4-ty@ellerman.id.au>
Date:   Wed, 17 Nov 2021 22:23:30 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2021 03:50:15 +0900, Masahiro Yamada wrote:
> Since commit bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of
> vgettimeofday.o"), "make ARCH=powerpc clean" does not clean up the
> arch/powerpc/kernel/{vdso32,vdso64} directories.
> 
> Use the subdir- trick to let "make clean" descend into them.
> 
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc: clean vdso32 and vdso64 directories
      https://git.kernel.org/powerpc/c/964c33cd0be621b291b5d253d8731eb2680082cb

cheers
