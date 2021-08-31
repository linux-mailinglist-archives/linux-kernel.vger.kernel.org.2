Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3732E3FC92B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233561AbhHaOAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 10:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238068AbhHaN7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:59:16 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEA7C061575
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 06:58:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GzTL141Fwz9sxS;
        Tue, 31 Aug 2021 23:58:17 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
References: <c5a07fadea33d640ad10cecf0ac8faaec1c524e0.1629898474.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Redefine HMT_xxx macros as empty on PPC32
Message-Id: <163041821923.889087.15635336796899145978.b4-ty@ellerman.id.au>
Date:   Tue, 31 Aug 2021 23:56:59 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Aug 2021 13:34:45 +0000 (UTC), Christophe Leroy wrote:
> HMT_xxx macros are macros for adjusting thread priority
> (hardware multi-threading) are macros inherited from PPC64
> via commit 5f7c690728ac ("[PATCH] powerpc: Merged ppc_asm.h")
> 
> Those instructions are pointless on PPC32, but some common
> fonctions like arch_cpu_idle() use them.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Redefine HMT_xxx macros as empty on PPC32
      https://git.kernel.org/powerpc/c/8149238ffd210875f5a77e3c654bb59b58da35e3

cheers
