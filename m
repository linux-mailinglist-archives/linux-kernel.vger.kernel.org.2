Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 372DF30CDEB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 22:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhBBV0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 16:26:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230342AbhBBVZ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 16:25:56 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A155E64F91;
        Tue,  2 Feb 2021 21:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612301115;
        bh=q/AHKQS/UTdxbjT2xBAevA77VV6i8QOS9KBt7vh2G70=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ol484WxdKBQklY84oihzPNPU8ac9XYFNpZUXrvMpE+mU2fuK43sfJyi0Eb+pa+jKq
         f9k+R8swrnWQSlteDxip9JadB6Cq+Q5d6bWFW6xNek/mwU2B/9bxSaDVWHUoi/4KBO
         WMw4adhQ5sem7HLuXOgKb4RDFlRr33scRIpN4rb4rpEXcmRC1G9Ung6Mp0OFsd6E/O
         iFh7FZKKuqgCKPrAFr1f2u2XRoj2qrqoB0ECp98CJSeBM+OeNIE2jSey/3j+Ra9DQb
         bLifkPYwj4QabQYbo6VkCV+qYnb63QRCZM0m8Kaqnizlmyt2MyQhk8Ax53MMlYxW6z
         aTcc4VFVEbDpg==
From:   Will Deacon <will@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Hailong Liu <liuhailongg6@163.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Mark Brown <broonie@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Hailong Liu <liu.hailong6@zte.com.cn>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64/ptdump:display the Linear Mapping start marker
Date:   Tue,  2 Feb 2021 21:25:09 +0000
Message-Id: <161230035667.1648537.2590475174711736724.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210202150749.10104-1-liuhailongg6@163.com>
References: <20210202150749.10104-1-liuhailongg6@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 23:07:49 +0800, Hailong Liu wrote:
> The current /sys/kernel/debug/kernel_page_tables does not display the
> *Linear Mapping start* marker on arm64, which I think should be paired
> with the *Linear Mapping start* marker.
> 
> Since *Linear Mapping start* is the first marker, use level=-1 to display it.

Applied to arm64 (for-next/misc), thanks!

[1/1] arm64/ptdump:display the Linear Mapping start marker
      https://git.kernel.org/arm64/c/b9ba680969d1

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
