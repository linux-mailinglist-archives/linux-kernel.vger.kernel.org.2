Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC2833A410
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 11:05:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235111AbhCNKB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 06:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbhCNKBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 06:01:22 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452FEC061763
        for <linux-kernel@vger.kernel.org>; Sun, 14 Mar 2021 03:01:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Dyw742KnCz9sWP; Sun, 14 Mar 2021 21:01:20 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        npiggin@gmail.com, Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
References: <53f3a1f719441761000c41154602bf097d4350b5.1614148356.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/syscall: Force inlining of __prep_irq_for_enabled_exit()
Message-Id: <161571587077.138988.9146414828000820575.b4-ty@ellerman.id.au>
Date:   Sun, 14 Mar 2021 21:01:20 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Feb 2021 06:34:22 +0000 (UTC), Christophe Leroy wrote:
> As reported by kernel test robot, a randconfig with high amount of
> debuging options can lead to build failure for undefined reference
> to replay_soft_interrupts() on ppc32.
> 
> This is due to gcc not seeing that __prep_irq_for_enabled_exit()
> always returns true on ppc32 because it doesn't inline it for
> some reason.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/syscall: Force inlining of __prep_irq_for_enabled_exit()
      https://git.kernel.org/powerpc/c/91b6c5dbe9e072dbdb181eed89c5c824e92ac0f5

cheers
