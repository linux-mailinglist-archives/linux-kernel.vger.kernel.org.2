Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0587F3F99D9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245374AbhH0NXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:53877 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245418AbhH0NW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:22:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0k94crDz9ssD;
        Fri, 27 Aug 2021 23:22:09 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <6457eb4f327313323ed1f70e540bbb4ddc9178fa.1629701106.git.christophe.leroy@csgroup.eu>
References: <6457eb4f327313323ed1f70e540bbb4ddc9178fa.1629701106.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/syscalls: Remove __NR__exit
Message-Id: <163007015022.52768.8922934112571254736.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:15:50 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 23 Aug 2021 06:45:20 +0000 (UTC), Christophe Leroy wrote:
> __NR_exit is nowhere used. On most architectures it was removed by
> commit 135ab6ec8fda ("[PATCH] remove remaining errno and
> __KERNEL_SYSCALLS__ references") but not on powerpc.
> 
> powerpc removed __KERNEL_SYSCALLS__ in commit 3db03b4afb3e ("[PATCH]
> rename the provided execve functions to kernel_execve"), but __NR_exit
> was left over.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/syscalls: Remove __NR__exit
      https://git.kernel.org/powerpc/c/a00ea5b6f2bbef8b004b0b7228c61680a50c7c3f

cheers
