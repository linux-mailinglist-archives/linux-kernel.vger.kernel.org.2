Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5739CEE6
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 14:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230353AbhFFMO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 08:14:29 -0400
Received: from ozlabs.org ([203.11.71.1]:47201 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230214AbhFFMN7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 08:13:59 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Fyb3D30H9z9sXL; Sun,  6 Jun 2021 22:12:07 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <62743846cbd493e5d9a02e197c2672a1d30df149.1620366342.git.christophe.leroy@csgroup.eu>
References: <62743846cbd493e5d9a02e197c2672a1d30df149.1620366342.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/mmu: Don't duplicate radix_enabled()
Message-Id: <162298131640.2353459.1671497661726891156.b4-ty@ellerman.id.au>
Date:   Sun, 06 Jun 2021 22:08:36 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 May 2021 05:45:52 +0000 (UTC), Christophe Leroy wrote:
> mmu_has_feature(MMU_FTR_TYPE_RADIX) can be evaluated regardless of
> CONFIG_PPC_RADIX_MMU.
> 
> When CONFIG_PPC_RADIX_MMU is not set, mmu_has_feature(MMU_FTR_TYPE_RADIX)
> will evaluate to 'false' at build time because MMU_FTR_TYPE_RADIX
> wont be included in MMU_FTRS_POSSIBLE.

Applied to powerpc/next.

[1/1] powerpc/mmu: Don't duplicate radix_enabled()
      https://git.kernel.org/powerpc/c/fe3dc333d2ed50c9764d281869d87bae0d795ce5

cheers
