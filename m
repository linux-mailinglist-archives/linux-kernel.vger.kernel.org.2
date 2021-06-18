Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 380533AC1FA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbhFREZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbhFREY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:58 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCACEC06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:22:49 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m480SDCz9shn; Fri, 18 Jun 2021 14:22:47 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <8ab21fd93d6e0047aa71e6509e5e312f14b2991b.1620998075.git.christophe.leroy@csgroup.eu>
References: <8ab21fd93d6e0047aa71e6509e5e312f14b2991b.1620998075.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Don't handle ALTIVEC/SPE in ASM in _switch(). Do it in C.
Message-Id: <162398828971.1363949.11216180122568844562.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:29 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021 13:14:53 +0000 (UTC), Christophe Leroy wrote:
> _switch() saves and restores ALTIVEC and SPE status.
> For altivec this is redundant with what __switch_to() does with
> save_sprs() and restore_sprs() and giveup_all() before
> calling _switch().
> 
> Add support for SPI in save_sprs() and restore_sprs() and
> remove things from _switch().

Applied to powerpc/next.

[1/1] powerpc: Don't handle ALTIVEC/SPE in ASM in _switch(). Do it in C.
      https://git.kernel.org/powerpc/c/359c2ca74d2fede5c571fbf3f5ee16ba1ad98259

cheers
