Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CBD3639FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbhDSEFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:01 -0400
Received: from ozlabs.org ([203.11.71.1]:54329 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233881AbhDSEEo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:44 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVQ0MPcz9vG3; Mon, 19 Apr 2021 14:04:13 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210409090119.59444-1-cuibixuan@huawei.com>
References: <20210409090119.59444-1-cuibixuan@huawei.com>
Subject: Re: [PATCH -next] powerpc/perf: Make symbol 'isa207_pmu_format_attr' static
Message-Id: <161880479814.1398509.6067179315782910479.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 17:01:19 +0800, Bixuan Cui wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/perf/isa207-common.c:24:18: warning:
>  symbol 'isa207_pmu_format_attr' was not declared. Should it be static?
> 
> This symbol is not used outside of isa207-common.c, so this
> commit marks it static.

Applied to powerpc/next.

[1/1] powerpc/perf: Make symbol 'isa207_pmu_format_attr' static
      https://git.kernel.org/powerpc/c/107dadb046178173dea18e0a78ff8ea3cc27c213

cheers
