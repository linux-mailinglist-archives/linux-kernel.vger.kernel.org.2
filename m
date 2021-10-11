Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A68B428C99
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 14:07:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236420AbhJKMJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 08:09:52 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:47613 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233561AbhJKMJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 08:09:51 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScxd5hktz4xbc;
        Mon, 11 Oct 2021 23:07:49 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, kernel test robot <lkp@intel.com>,
        Alistair Popple <alistair@popple.id.au>,
        linux-kernel@vger.kernel.org
In-Reply-To: <aa6055769b92a5d8685b8d0adab99c48a0b0ef4b.1631956926.git.christophe.leroy@csgroup.eu>
References: <aa6055769b92a5d8685b8d0adab99c48a0b0ef4b.1631956926.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/476: Fix sparse report
Message-Id: <163395399612.4094789.12159474891179171395.b4-ty@ellerman.id.au>
Date:   Mon, 11 Oct 2021 23:06:36 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sep 2021 11:22:32 +0200, Christophe Leroy wrote:
> 	arch/powerpc/platforms/44x/ppc476.c:236:17: warning: cast removes address space '__iomem' of expression
> 	arch/powerpc/platforms/44x/ppc476.c:241:34: warning: incorrect type in argument 1 (different address spaces)
> 	arch/powerpc/platforms/44x/ppc476.c:241:34:    expected void const volatile [noderef] __iomem *addr
> 	arch/powerpc/platforms/44x/ppc476.c:241:34:    got unsigned char [usertype] *
> 	arch/powerpc/platforms/44x/ppc476.c:243:17: warning: incorrect type in argument 1 (different address spaces)
> 	arch/powerpc/platforms/44x/ppc476.c:243:17:    expected void volatile [noderef] __iomem *addr
> 	arch/powerpc/platforms/44x/ppc476.c:243:17:    got unsigned char [usertype] *[assigned] fpga
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/476: Fix sparse report
      https://git.kernel.org/powerpc/c/494f238a3861863d908af7b98a369f6d8a986c85

cheers
