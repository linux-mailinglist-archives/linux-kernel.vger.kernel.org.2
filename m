Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4488A3F051B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237897AbhHRNqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:46:46 -0400
Received: from ozlabs.org ([203.11.71.1]:53209 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237104AbhHRNqd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:46:33 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4GqTgm5LQJz9sX3; Wed, 18 Aug 2021 23:45:56 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/bug: Remove specific powerpc BUG_ON() and WARN_ON() on PPC32
Message-Id: <162929393381.3619265.1023243092279572637.b4-ty@ellerman.id.au>
Date:   Wed, 18 Aug 2021 23:38:53 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 16:38:09 +0000 (UTC), Christophe Leroy wrote:
> powerpc BUG_ON() and WARN_ON() are based on using twnei instruction.
> 
> For catching simple conditions like a variable having value 0, this
> is efficient because it does the test and the trap at the same time.
> But most conditions used with BUG_ON or WARN_ON are more complex and
> forces GCC to format the condition into a 0 or 1 value in a register.
> This will usually require 2 to 3 instructions.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/bug: Remove specific powerpc BUG_ON() and WARN_ON() on PPC32
      https://git.kernel.org/powerpc/c/db87a7199229b75c9996bf78117eceb81854fce2
[2/2] powerpc/bug: Provide better flexibility to WARN_ON/__WARN_FLAGS() with asm goto
      https://git.kernel.org/powerpc/c/1e688dd2a3d6759d416616ff07afc4bb836c4213

cheers
