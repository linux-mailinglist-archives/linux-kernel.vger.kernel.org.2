Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B63533F0
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 13:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236775AbhDCLwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 07:52:24 -0400
Received: from ozlabs.org ([203.11.71.1]:60625 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236698AbhDCLwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 07:52:20 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FCFdq60Bkz9sX5; Sat,  3 Apr 2021 22:52:15 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        masahiroy@kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <8bb015bc98c51d8ced581415b7e3d157e18da7c9.1617181918.git.christophe.leroy@csgroup.eu>
References: <8bb015bc98c51d8ced581415b7e3d157e18da7c9.1617181918.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/vdso: Make sure vdso_wrapper.o is rebuilt everytime vdso.so is rebuilt
Message-Id: <161745070569.936361.16001284768397289607.b4-ty@ellerman.id.au>
Date:   Sat, 03 Apr 2021 22:51:45 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Mar 2021 09:12:19 +0000 (UTC), Christophe Leroy wrote:
> Commit bce74491c300 ("powerpc/vdso: fix unnecessary rebuilds of
> vgettimeofday.o") moved vdso32_wrapper.o and vdso64_wrapper.o out
> of arch/powerpc/kernel/vdso[32/64]/ and removed the dependencies in
> the Makefile. This leads to the wrappers not being re-build hence the
> kernel embedding the old vdso library.
> 
> Add back missing dependencies to ensure vdso32_wrapper.o and vdso64_wrapper.o
> are rebuilt when vdso32.so.dbg and vdso64.so.dbg are changed.

Applied to powerpc/fixes.

[1/1] powerpc/vdso: Make sure vdso_wrapper.o is rebuilt everytime vdso.so is rebuilt
      https://git.kernel.org/powerpc/c/791f9e36599d94af5a76d3f74d04e16326761aae

cheers
