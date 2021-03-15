Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E033B49C
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 14:32:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbhCONbi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 09:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbhCONbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 09:31:22 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17836C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 06:31:22 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4Dzcks38stz9sW1; Tue, 16 Mar 2021 00:31:17 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        segher@kernel.crashing.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
References: <a7aa198a88bcd33c6e35e99f70f86c7b7f2f9440.1615270757.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
Message-Id: <161581505500.387233.5713425984426626454.b4-ty@ellerman.id.au>
Date:   Tue, 16 Mar 2021 00:31:17 +1100 (AEDT)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Mar 2021 06:19:30 +0000 (UTC), Christophe Leroy wrote:
> With some defconfig including CONFIG_CC_OPTIMIZE_FOR_SIZE,
> (for instance mvme5100_defconfig and ps3_defconfig), gcc 5
> generates a call to _restgpr_31_x.
> 
> Until recently it went unnoticed, but
> commit 42ed6d56ade2 ("powerpc/vdso: Block R_PPC_REL24 relocations")
> made it rise to the surface.
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/vdso32: Add missing _restgpr_31_x to fix build failure
      https://git.kernel.org/powerpc/c/08c18b63d9656e0389087d1956d2b37fd7019172

cheers
