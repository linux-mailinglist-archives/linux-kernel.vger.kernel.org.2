Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E193AC201
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbhFREZm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:42 -0400
Received: from ozlabs.org ([203.11.71.1]:34195 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231455AbhFREZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:01 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4D0scNz9sjD; Fri, 18 Jun 2021 14:22:51 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        trix@redhat.com, Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <bf1e074f6fb213a1c4cc4964370bdce4b648d647.1622706812.git.christophe.leroy@csgroup.eu>
References: <bf1e074f6fb213a1c4cc4964370bdce4b648d647.1622706812.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Remove CONFIG_PPC_MMU_NOHASH_32
Message-Id: <162398828829.1363949.4502364876568416205.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 07:53:49 +0000 (UTC), Christophe Leroy wrote:
> Since commit Fixes: 555904d07eef ("powerpc/8xx: MM_SLICE is not needed anymore"),
> CONFIG_PPC_MMU_NOHASH_32 has not been used.
> 
> Remove it.

Applied to powerpc/next.

[1/1] powerpc: Remove CONFIG_PPC_MMU_NOHASH_32
      https://git.kernel.org/powerpc/c/c0ca0fe08c9213a5187e4513b5506667f249030f

cheers
