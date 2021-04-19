Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 340FB3639FF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233767AbhDSEFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234109AbhDSEEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:04:48 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7C8C06138E;
        Sun, 18 Apr 2021 21:04:18 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4FNtVR5nzHz9tl3; Mon, 19 Apr 2021 14:04:15 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Bixuan Cui <cuibixuan@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>
Cc:     kernel-janitors@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210409090109.59347-1-cuibixuan@huawei.com>
References: <20210409090109.59347-1-cuibixuan@huawei.com>
Subject: Re: [PATCH -next] powerpc/pseries: Make symbol '__pcpu_scope_hcall_stats' static
Message-Id: <161880479761.1398509.15398715314309643145.b4-ty@ellerman.id.au>
Date:   Mon, 19 Apr 2021 13:59:57 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 17:01:09 +0800, Bixuan Cui wrote:
> The sparse tool complains as follows:
> 
> arch/powerpc/platforms/pseries/hvCall_inst.c:29:1: warning:
>  symbol '__pcpu_scope_hcall_stats' was not declared. Should it be static?
> 
> This symbol is not used outside of hvCall_inst.c, so this
> commit marks it static.

Applied to powerpc/next.

[1/1] powerpc/pseries: Make symbol '__pcpu_scope_hcall_stats' static
      https://git.kernel.org/powerpc/c/193e4cd8ed9dd01092d01df7706a6b344c946af4

cheers
