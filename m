Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51A5363A00
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbhDSEFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbhDSEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:48 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388E2C06138F;
        Sun, 18 Apr 2021 21:04:19 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVS6yCjz9vH2; Mon, 19 Apr 2021 14:04:16 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Bixuan Cui <cuibixuan@huawei.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210409090114.59396-1-cuibixuan@huawei.com>
References: <20210409090114.59396-1-cuibixuan@huawei.com>
Subject: Re: [PATCH -next] powerpc/pseries/pmem: Make symbol 'drc_pmem_match' static
Message-Id: <161880479788.1398509.10114956156127750502.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 17:01:14 +0800, Bixuan Cui wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/platforms/pseries/pmem.c:142:27: warning:
>  symbol 'drc_pmem_match' was not declared. Should it be static?
> 
> This symbol is not used outside of pmem.c, so this
> commit marks it static.

Applied to powerpc/next.

[1/1] powerpc/pseries/pmem: Make symbol 'drc_pmem_match' static
      https://git.kernel.org/powerpc/c/2235dea17d56238642121a8085b71d68598534bb

cheers
