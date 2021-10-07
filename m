Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312D74250B7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbhJGKK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 06:10:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:38764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232573AbhJGKKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 06:10:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B2026610E6;
        Thu,  7 Oct 2021 10:08:29 +0000 (UTC)
Date:   Thu, 7 Oct 2021 11:08:26 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, wanghaibin.wang@huawei.com,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] arm64: defconfig: drop obsolete ARCH_* configs
Message-ID: <YV7HGniKSKe7nXp/@arm.com>
References: <20210821030519.127-1-yuzenghui@huawei.com>
 <39c2b2f9-4de2-8e7d-2135-96f1dab750e0@canonical.com>
 <5991e347-18f0-30cd-58b9-9e3276bd98bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5991e347-18f0-30cd-58b9-9e3276bd98bd@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 07, 2021 at 05:42:46PM +0800, Zenghui Yu wrote:
> On 2021/8/23 21:01, Krzysztof Kozlowski wrote:
> > On 21/08/2021 05:05, Zenghui Yu wrote:
> > > Per commit 4a9a1a5602d8 ("arm64: socfpga: merge Agilex and N5X into
> > > ARCH_INTEL_SOCFPGA") and commit 89d4f98ae90d ("ARM: remove zte zx
> > > platform"), they can be dropped from defconfig now.
> > > 
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > > Cc: Arnd Bergmann <arnd@arndb.de>
> > > Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> > > ---
> > >  arch/arm64/configs/defconfig | 3 ---
> > >  1 file changed, 3 deletions(-)
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> 
> I have no idea about which tree should this patch go via, so a gentle
> ping here. I've verified that this can still be applied cleanly on top
> of today's -next.

Usually defconfig changes go in via the arm-soc tree rather than the
arm64 one.

-- 
Catalin
