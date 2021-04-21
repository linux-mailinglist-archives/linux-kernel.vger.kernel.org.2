Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03D73366C5F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242726AbhDUNPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 09:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbhDUNJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 09:09:51 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A543C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 06:09:18 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FQLVN1cWcz9vFl; Wed, 21 Apr 2021 23:09:15 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210420045404.438735-1-leobras.c@gmail.com>
References: <20210420045404.438735-1-leobras.c@gmail.com>
Subject: Re: [PATCH 1/1] powerpc/pseries/iommu: Fix window size for direct mapping with pmem
Message-Id: <161901050137.1961279.12627937904577975513.b4-ty@ellerman.id.au>
Date:   Wed, 21 Apr 2021 23:08:21 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021 01:54:04 -0300, Leonardo Bras wrote:
> As of today, if the DDW is big enough to fit (1 << MAX_PHYSMEM_BITS) it's
> possible to use direct DMA mapping even with pmem region.
> 
> But, if that happens, the window size (len) is set to
> (MAX_PHYSMEM_BITS - page_shift) instead of MAX_PHYSMEM_BITS, causing a
> pagesize times smaller DDW to be created, being insufficient for correct
> usage.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/pseries/iommu: Fix window size for direct mapping with pmem
      https://git.kernel.org/powerpc/c/a9d2f9bb225fd2a764aef57738ab6c7f38d782ae

cheers
