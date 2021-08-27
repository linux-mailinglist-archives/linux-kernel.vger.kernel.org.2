Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48353F99DA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 15:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245377AbhH0NXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 09:23:25 -0400
Received: from ozlabs.org ([203.11.71.1]:35665 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245421AbhH0NXB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 09:23:01 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Gx0kC2ppdz9t0T;
        Fri, 27 Aug 2021 23:22:11 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <373ec500f386374bc5735007df3d3869eac47be1.1624618701.git.christophe.leroy@csgroup.eu>
References: <373ec500f386374bc5735007df3d3869eac47be1.1624618701.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/syscalls: Simplify do_mmap2()
Message-Id: <163007016188.52768.15412686650316297072.b4-ty@ellerman.id.au>
Date:   Fri, 27 Aug 2021 23:16:01 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021 10:58:33 +0000 (UTC), Christophe Leroy wrote:
> When shift is nul, operations remain valid so no test needed.
> 
> And 'ret' is unnecessary.
> 
> And use IS_ALIGNED() to check alignment, that's more clear.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/syscalls: Simplify do_mmap2()
      https://git.kernel.org/powerpc/c/316389e904f968d24d44cd96a6d171ee1ef269cf

cheers
