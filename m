Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58ECC3AC204
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhFREZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:45 -0400
Received: from ozlabs.org ([203.11.71.1]:34195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231631AbhFREZD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:03 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4G37Fnz9sXb; Fri, 18 Jun 2021 14:22:54 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <a069a348ee3c2fe3123a5a93695c2b35dc42cb40.1623340691.git.christophe.leroy@csgroup.eu>
References: <a069a348ee3c2fe3123a5a93695c2b35dc42cb40.1623340691.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/signal32: Remove impossible #ifdef combinations
Message-Id: <162398829818.1363949.2552824132149811468.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Jun 2021 15:58:34 +0000 (UTC), Christophe Leroy wrote:
> PPC_TRANSACTIONAL_MEM is only on book3s/64
> SPE is only on booke
> 
> PPC_TRANSACTIONAL_MEM selects ALTIVEC and VSX
> 
> Therefore, within PPC_TRANSACTIONAL_MEM sections,
> ALTIVEC and VSX are always defined while SPE never is.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/signal32: Remove impossible #ifdef combinations
      https://git.kernel.org/powerpc/c/ac3d085368b3abf19b24d8505b897454c7372855

cheers
