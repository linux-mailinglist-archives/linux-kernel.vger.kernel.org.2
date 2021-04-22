Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2A26368200
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 15:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbhDVN5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 09:57:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236365AbhDVN5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 09:57:48 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF46C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Apr 2021 06:57:13 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4FQzWC0CQdz9sV5;
        Thu, 22 Apr 2021 23:57:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1619099831;
        bh=vodDxdbMHgKzn3FZqqPkJFp2BSw+/poOlMN5woeQ7h0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IEwQvqr/Wt41NgGFe3I7tXI15JSRIevFn6iZ4x7dJw0jcqAg4bZGErLrd07H+5EmW
         AcBhGpeD+pnKR/qEvozsJtBK4SljBcFM4Jsxba3rVro0eStGCBMcfVCMnAE2/Mz+oB
         ahVxX/N8fMH3oA0mCMIQ7znIo04lmgO7X2AH5oH4DBwdehc9o8ovtW3eIckb8/KoSO
         nwLfxz5xAurz6mZG2AZmAj7LoksQ+TVPK7z5Dx+fWoWX9NrPeN/ciX+m7hCF9yhh5F
         h2ojbV+o3+PB3xv6rMt3g0HpjQILWBvKT1WtLN8GbHWU+RFjHdAqoKVy62MEowbgKn
         ncxCNaD6WoakA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/kconfig: Restore alphabetic order of the
 selects under CONFIG_PPC
In-Reply-To: <361ee3fc5009c709ae0ca592249bb0702c6ef073.1619024780.git.christophe.leroy@csgroup.eu>
References: <361ee3fc5009c709ae0ca592249bb0702c6ef073.1619024780.git.christophe.leroy@csgroup.eu>
Date:   Thu, 22 Apr 2021 23:57:09 +1000
Message-ID: <87eef2bex6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Commit a7d2475af7ae ("powerpc: Sort the selects under CONFIG_PPC")
> sorted all selects under CONFIG_PPC.
>
> 4 years later, several items have been introduced at wrong place,
> a few other have been renamed without moving them to their correct
> place.
>
> Reorder them now.
>
> While we are at it, simplify the test for a couple of them:
> - PPC_64 && PPC_PSERIES is simplified in PPC_PSERIES
> - PPC_64 && PPC_BOOK3S is simplified in PPC_BOOK3S_64
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
> v2: Rebased on d20f726744a0 ("Automatic merge of 'next' into merge (2021-04-21 22:57)")

This will conflict badly with other things in linux-next if I merge it
now.

The best time to do this is just before rc1. I'll try to remember :)

cheers
