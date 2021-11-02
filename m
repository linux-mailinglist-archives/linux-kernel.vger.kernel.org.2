Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6052F442CD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhKBLl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbhKBLlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:07 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90121C061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fg22bMz4xcw;
        Tue,  2 Nov 2021 22:38:31 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
References: <d1ad9fdd9b27da3fdfa16510bb542ed51fa6e134.1634292136.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v1 1/8] powerpc/booke: Disable STRICT_KERNEL_RWX, DEBUG_PAGEALLOC and KFENCE
Message-Id: <163584790135.1845480.2173070961841776938.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:41 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021 12:02:42 +0200, Christophe Leroy wrote:
> fsl_booke and 44x are not able to map kernel linear memory with
> pages, so they can't support DEBUG_PAGEALLOC and KFENCE, and
> STRICT_KERNEL_RWX is also a problem for now.
> 
> Enable those only on book3s (both 32 and 64 except KFENCE), 8xx and 40x.
> 
> 
> [...]

Applied to powerpc/next.

[1/8] powerpc/booke: Disable STRICT_KERNEL_RWX, DEBUG_PAGEALLOC and KFENCE
      https://git.kernel.org/powerpc/c/68b44f94d6370e2c6c790fedd28e637fa9964a93
[2/8] powerpc/fsl_booke: Rename fsl_booke.c to fsl_book3e.c
      https://git.kernel.org/powerpc/c/3a75fd709c89cb45b8b1044b8ef0d15027a69f9b
[3/8] powerpc/fsl_booke: Take exec flag into account when setting TLBCAMs
      https://git.kernel.org/powerpc/c/01116e6e98b08ab0641fa516ddafb1b1b2088e64
[4/8] powerpc/fsl_booke: Enable reloading of TLBCAM without switching to AS1
      https://git.kernel.org/powerpc/c/a97dd9e2f760c6996a8f1385ddab0bfef325b364
[5/8] powerpc/fsl_booke: Tell map_mem_in_cams() if init is done
      https://git.kernel.org/powerpc/c/52bda69ae8b5102fe08c9db10f4a1514478e07d3
[6/8] powerpc/fsl_booke: Allocate separate TLBCAMs for readonly memory
      https://git.kernel.org/powerpc/c/0b2859a74306b2b89f6e77c216fe0992ff890fa6
[7/8] powerpc/fsl_booke: Update of TLBCAMs after init
      https://git.kernel.org/powerpc/c/d5970045cf9e266d9a43941ac0866865fd22a36a
[8/8] powerpc/fsl_booke: Enable STRICT_KERNEL_RWX
      https://git.kernel.org/powerpc/c/49e3d8ea62482625c3835f0a33ae9c1dda39ea8f

cheers
