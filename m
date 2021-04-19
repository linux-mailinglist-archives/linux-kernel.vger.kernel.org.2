Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97621363A04
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbhDSEFc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbhDSEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:48 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4D3C061760;
        Sun, 18 Apr 2021 21:04:15 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVP1HGSz9vGp; Mon, 19 Apr 2021 14:04:13 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Madhavan Srinivasan <maddy@linux.ibm.com>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Kajol Jain <kjain@linux.ibm.com>,
        "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc:     kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210409090124.59492-1-cuibixuan@huawei.com>
References: <20210409090124.59492-1-cuibixuan@huawei.com>
Subject: Re: [PATCH -next] powerpc/perf/hv-24x7: Make some symbols static
Message-Id: <161880479840.1398509.5195313938984929332.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:58 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 17:01:24 +0800, Bixuan Cui wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/perf/hv-24x7.c:229:1: warning:
>  symbol '__pcpu_scope_hv_24x7_txn_flags' was not declared. Should it be static?
> arch/powerpc/perf/hv-24x7.c:230:1: warning:
>  symbol '__pcpu_scope_hv_24x7_txn_err' was not declared. Should it be static?
> arch/powerpc/perf/hv-24x7.c:236:1: warning:
>  symbol '__pcpu_scope_hv_24x7_hw' was not declared. Should it be static?
> arch/powerpc/perf/hv-24x7.c:244:1: warning:
>  symbol '__pcpu_scope_hv_24x7_reqb' was not declared. Should it be static?
> arch/powerpc/perf/hv-24x7.c:245:1: warning:
>  symbol '__pcpu_scope_hv_24x7_resb' was not declared. Should it be static?
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/perf/hv-24x7: Make some symbols static
      https://git.kernel.org/powerpc/c/cc331eee03eadd750af1fb957d020b3f24e5e056

cheers
