Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2123DD48D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 13:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhHBLUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 07:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbhHBLUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 07:20:46 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE92AC06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 04:20:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4GdbCN2p71z9s1l;
        Mon,  2 Aug 2021 21:20:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1627903233;
        bh=Ph52ycwEVB+Kr83e5k5zzEwv6lbCoXALW4ekLWI3mvY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OyD8Aq4AaqIcoMdaKfnwOqsE8epJkeGEPf9zJ0mxrHVywJVEKvSUZj+8YoIcH1VE0
         honyNi+z9ReapyZ4mk0fGsa4f3+TDmmba0/ty3GP7pNlm6LYVIBMCjhfutrxOxHu8U
         sXMxTIGfAExBHy4IhWp21JGrCbgJ+3wenHoU1iroNBQ5voTWW6vLvDn8IZF88BqEG1
         /H9zBHykLP4zxKizoJFitgHSqjAZTrCPkT/GNtGZIKgGPYlDfFDLg73RL/C+wl4gcp
         xLa/w0jrpy0Nr/i4gK3JpxGP4X4LK3JHpDAQ4j1a8uYsQjEqJM8BSwqNCeKElZLAQp
         CCvt/6/jf5VKA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, Robin Murphy <robin.murphy@arm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        iommu@lists.linux-foundation.org,
        Claire Chang <tientzu@chromium.org>,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] powerpc/svm: Don't issue ultracalls if
 !mem_encrypt_active()
In-Reply-To: <20210730114231.23445-1-will@kernel.org>
References: <20210730114231.23445-1-will@kernel.org>
Date:   Mon, 02 Aug 2021 21:20:30 +1000
Message-ID: <871r7cks8x.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will Deacon <will@kernel.org> writes:
> Commit ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> introduced a set_memory_encrypted() call to swiotlb_exit() so that the
> buffer pages are returned to an encrypted state prior to being freed.
>
> Sachin reports that this leads to the following crash on a Power server:
>
> [    0.010799] software IO TLB: tearing down default memory pool
> [    0.010805] ------------[ cut here ]------------
> [    0.010808] kernel BUG at arch/powerpc/kernel/interrupt.c:98!
>
> Nick spotted that this is because set_memory_encrypted() is issuing an
> ultracall which doesn't exist for the processor, and should therefore
> be gated by mem_encrypt_active() to mirror the x86 implementation.
>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Claire Chang <tientzu@chromium.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Fixes: ad6c00283163 ("swiotlb: Free tbl memory in swiotlb_exit()")
> Suggested-by: Nicholas Piggin <npiggin@gmail.com>
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/1905CD70-7656-42AE-99E2-A31FC3812EAC@linux.vnet.ibm.com/
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/powerpc/platforms/pseries/svm.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Thanks.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


I assume Konrad will take this via the swiotlb tree?

cheers
