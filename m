Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52FA3F5EE9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:24:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237544AbhHXNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:25:38 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:42889 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237520AbhHXNZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:25:37 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gv8wg40tBz9ssP;
        Tue, 24 Aug 2021 23:24:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1629811492;
        bh=hDmMWgLZDKPhAUavmwMYjiIkTsL9aGJyOGWvyuQf6/w=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=mkARf6/bwM+bNJncHzWWvTnHKV3p34icQ8fmrgNOyJb+LkedTebgCbW6JKsRrF2jl
         VvAokAkuVHwPr289qzS925UF9anXbLm40l2YiZJLV8vl5I2qTO6qJqrDUoA9YOk/0q
         Yfza1le7LdcqFZA/uWuAn/24p7LwdN43mvEF1DXCCnbNzHCpsjnytvyNMCibAh/j1R
         jg1RTl15r5J8lEGJzwYQuMN/B3F01raFYfnjMkKcW2CV6ExgKfftlF1TBwRvVFMg6o
         8XUcf71WJJh4UygSvih7uo0sfgTVkSvY6mRdpygHZKa7swWaTCJkqyegFoFbvpCtsk
         Mh7krD2BMdqQQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/audit: Convert powerpc to
 AUDIT_ARCH_COMPAT_GENERIC
In-Reply-To: <dc14509a28a993738b1325211f412be72a4f9b1e.1629701132.git.christophe.leroy@csgroup.eu>
References: <dc14509a28a993738b1325211f412be72a4f9b1e.1629701132.git.christophe.leroy@csgroup.eu>
Date:   Tue, 24 Aug 2021 23:24:50 +1000
Message-ID: <877dgbc6vx.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
>
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
>
> Convert powerpc to that bi-arch generic audit support.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2:
> - Missing 'git add' for arch/powerpc/include/asm/unistd32.h
> - Finalised commit description
> ---
>  arch/powerpc/Kconfig                |  5 +-
>  arch/powerpc/include/asm/unistd32.h |  7 +++
>  arch/powerpc/kernel/Makefile        |  3 --
>  arch/powerpc/kernel/audit.c         | 84 -----------------------------
>  arch/powerpc/kernel/compat_audit.c  | 44 ---------------
>  5 files changed, 8 insertions(+), 135 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/unistd32.h
>  delete mode 100644 arch/powerpc/kernel/audit.c
>  delete mode 100644 arch/powerpc/kernel/compat_audit.c

This looks OK, but I don't know much about audit.

Can you resend with the audit maintainers on Cc?

cheers
