Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0667D4308B0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Oct 2021 14:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbhJQMfF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 08:35:05 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:57441 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236227AbhJQMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 08:35:04 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HXKCn0Cs3z4xqS;
        Sun, 17 Oct 2021 23:32:53 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <77d99037782ac4b3c3b0124fc4ae80ce7b760b05.1634035228.git.christophe.leroy@csgroup.eu>
References: <77d99037782ac4b3c3b0124fc4ae80ce7b760b05.1634035228.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Set max_mapnr correctly
Message-Id: <163447392455.1159469.4550193906855122845.b4-ty@ellerman.id.au>
Date:   Sun, 17 Oct 2021 23:32:04 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Oct 2021 12:40:37 +0200, Christophe Leroy wrote:
> max_mapnr is used by virt_addr_valid() to check if a linear
> address is valid.
> 
> It must only include lowmem PFNs, like other architectures.
> 
> Problem detected on a system with 1G mem (Only 768M are mapped), with
> CONFIG_DEBUG_VIRTUAL and CONFIG_TEST_DEBUG_VIRTUAL, it didn't report
> virt_to_phys(VMALLOC_START), VMALLOC_START being 0xf1000000.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Set max_mapnr correctly
      https://git.kernel.org/powerpc/c/602946ec2f90d5bd965857753880db29d2d9a1e9

cheers
