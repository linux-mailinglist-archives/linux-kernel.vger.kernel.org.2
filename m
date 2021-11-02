Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF27442CCF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhKBLlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:03 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:56427 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230100AbhKBLk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:40:59 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7FW1t9Jz4xbs;
        Tue,  2 Nov 2021 22:38:23 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
References: <922bdab3a220781bae2360ff3dd5adb7fe4d34f1.1635226743.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/3] powerpc/nohash: Fix __ptep_set_access_flags() and ptep_set_wrprotect()
Message-Id: <163584791973.1845480.6138102753649053681.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:59 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Oct 2021 07:39:24 +0200, Christophe Leroy wrote:
> Commit 26973fa5ac0e ("powerpc/mm: use pte helpers in generic code")
> changed those two functions to use pte helpers to determine which
> bits to clear and which bits to set.
> 
> This change was based on the assumption that bits to be set/cleared
> are always the same and can be determined by applying the pte
> manipulation helpers on __pte(0).
> 
> [...]

Applied to powerpc/next.

[1/3] powerpc/nohash: Fix __ptep_set_access_flags() and ptep_set_wrprotect()
      https://git.kernel.org/powerpc/c/b1b93cb7e794e914787bf7d9936b57a149cdee4f
[2/3] powerpc/book3e: Fix set_memory_x() and set_memory_nx()
      https://git.kernel.org/powerpc/c/b6cb20fdc2735f8b2e082937066c33fe376c2ee2
[3/3] powerpc/fsl_booke: Fix setting of exec flag when setting TLBCAMs
      https://git.kernel.org/powerpc/c/44c14509b0dabb909ad1ec28800893ea71762732

cheers
