Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF423AC20C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbhFRE0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:26:02 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:40841 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231800AbhFREZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:25:09 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m4M42x0z9sxS; Fri, 18 Jun 2021 14:22:59 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <4c54997edd3548fa54717915e7c6ebaf60f208c0.1622712515.git.christophe.leroy@csgroup.eu>
References: <4c54997edd3548fa54717915e7c6ebaf60f208c0.1622712515.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 1/6] powerpc/nohash: Refactor update of BDI2000 pointers in switch_mmu_context()
Message-Id: <162398828812.1363949.10092519584526889516.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:28 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Jun 2021 09:29:02 +0000 (UTC), Christophe Leroy wrote:
> Instead of duplicating the update of BDI2000 pointers in
> set_context(), do it directly from switch_mmu_context().

Applied to powerpc/next.

[1/6] powerpc/nohash: Refactor update of BDI2000 pointers in switch_mmu_context()
      https://git.kernel.org/powerpc/c/25910260ff69fa0c37e26541aac4e8f978e1f17f
[2/6] powerpc/nohash: Convert set_context() to C
      https://git.kernel.org/powerpc/c/a56ab7c7290f5922363d1ee11bbafc4da2b9bf51
[3/6] powerpc/nohash: Remove CONFIG_SMP #ifdefery in mmu_context.h
      https://git.kernel.org/powerpc/c/c13066e53aabd8f268f051d267270765e10343aa
[4/6] powerpc/nohash: Remove DEBUG_MAP_CONSISTENCY
      https://git.kernel.org/powerpc/c/dac3db1edf8b4c75859f07789f577322f2a51e3a
[5/6] powerpc/nohash: Remove DEBUG_CLAMP_LAST_CONTEXT
      https://git.kernel.org/powerpc/c/a36c0faf3dbc429d5ddcb941afe38dd6fe6c5901
[6/6] powerpc/nohash: Remove DEBUG_HARDER
      https://git.kernel.org/powerpc/c/e2c043163d44f7b3a9e65d9161af72b647b18451

cheers
