Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2899442CD5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231436AbhKBLlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:16 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:44613 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhKBLlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:05 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fd596nz4xcb;
        Tue,  2 Nov 2021 22:38:29 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <24d4ca0ada683c9436a5f812a7aeb0a1362afa2b.1630398606.git.christophe.leroy@csgroup.eu>
References: <24d4ca0ada683c9436a5f812a7aeb0a1362afa2b.1630398606.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/machdep: Remove stale functions from ppc_md structure
Message-Id: <163584790792.1845480.7374008304551839348.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:47 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Aug 2021 08:30:24 +0000 (UTC), Christophe Leroy wrote:
> ppc_md.iommu_save() is not set anymore by any platform after
> commit c40785ad305b ("powerpc/dart: Use a cachable DART").
> So iommu_save() has become a nop and can be removed.
> 
> ppc_md.show_percpuinfo() is not set anymore by any platform after
> commit 4350147a816b ("[PATCH] ppc64: SMU based macs cpufreq support").
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/machdep: Remove stale functions from ppc_md structure
      https://git.kernel.org/powerpc/c/8f7fadb4ba87f6639d817a9b2d99112e9507dc63

cheers
