Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FEDC442CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhKBLlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbhKBLlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FA2FC061714
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 04:38:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FZ5K3qz4xcG;
        Tue,  2 Nov 2021 22:38:26 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <6184b08088312a7d787d450eb902584e4ae77f7a.1632317816.git.christophe.leroy@csgroup.eu>
References: <6184b08088312a7d787d450eb902584e4ae77f7a.1632317816.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc/breakpoint: Cleanup
Message-Id: <163584791327.1845480.13420556004410793688.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021 15:37:18 +0200, Christophe Leroy wrote:
> cache_op_size() does exactly the same as l1_dcache_bytes().
> 
> Remove it.
> 
> MSR_64BIT already exists, no need to enclode the check
> around #ifdef __powerpc64__
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/breakpoint: Cleanup
      https://git.kernel.org/powerpc/c/a61ec782a754229b24aae2d6c2109510d6420ae6

cheers
