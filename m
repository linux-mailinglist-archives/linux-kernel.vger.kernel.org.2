Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7903AC1F5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 06:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbhFREZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 00:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231203AbhFREY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 00:24:56 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BA8C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 21:22:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4G5m460fdXz9sf8; Fri, 18 Jun 2021 14:22:45 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <98394503e92d6fd6d8f657e0b263b32f21cf2790.1623438478.git.christophe.leroy@csgroup.eu>
References: <98394503e92d6fd6d8f657e0b263b32f21cf2790.1623438478.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/32: Display modules range in virtual memory layout
Message-Id: <162398829836.1363949.3616148004557919453.b4-ty@ellerman.id.au>
Date:   Fri, 18 Jun 2021 13:51:38 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 19:08:54 +0000 (UTC), Christophe Leroy wrote:
> book3s/32 and 8xx don't use vmalloc for modules.
> 
> Print the modules area at startup as part of the virtual memory layout:
> 
> [    0.000000] Kernel virtual memory layout:
> [    0.000000]   * 0xffafc000..0xffffc000  : fixmap
> [    0.000000]   * 0xc9000000..0xffafc000  : vmalloc & ioremap
> [    0.000000]   * 0xb0000000..0xc0000000  : modules
> [    0.000000] Memory: 118480K/131072K available (7152K kernel code, 2320K rwdata, 1328K rodata, 368K init, 854K bss, 12592K reserved, 0K cma-reserved)

Applied to powerpc/next.

[1/1] powerpc/32: Display modules range in virtual memory layout
      https://git.kernel.org/powerpc/c/baf24d23be7d2357a2aa9c5ffb6a2d680ac2a68c

cheers
