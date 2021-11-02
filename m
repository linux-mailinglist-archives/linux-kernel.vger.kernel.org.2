Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB025442CDA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 12:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhKBLlb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 07:41:31 -0400
Received: from gandalf.ozlabs.org ([150.107.74.76]:43817 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbhKBLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 07:41:08 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7Fh55K6z4xd9;
        Tue,  2 Nov 2021 22:38:32 +1100 (AEDT)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <fb324f1c8f2ddb57cf6aad1cea26329558f1c1c0.1631887021.git.christophe.leroy@csgroup.eu>
References: <fb324f1c8f2ddb57cf6aad1cea26329558f1c1c0.1631887021.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc/8xx: Simplify TLB handling
Message-Id: <163584791161.1845480.3784540326503366028.b4-ty@ellerman.id.au>
Date:   Tue, 02 Nov 2021 21:11:51 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2021 15:57:12 +0200, Christophe Leroy wrote:
> In the old days, TLB handling for 8xx was using tlbie and tlbia
> instructions directly as much as possible.
> 
> But commit f048aace29e0 ("powerpc/mm: Add SMP support to no-hash
> TLB handling") broke that by introducing out-of-line unnecessary
> complex functions for booke/smp which don't have tlbie/tlbia
> instructions and require more complex handling.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/8xx: Simplify TLB handling
      https://git.kernel.org/powerpc/c/63f501e07a8557bc8ab79d17ef76ae21df1e395d

cheers
