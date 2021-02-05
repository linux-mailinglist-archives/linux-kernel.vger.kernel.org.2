Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 287CD311069
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 19:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbhBERLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 12:11:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:49672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233243AbhBERLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 12:11:16 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C369064DA5;
        Fri,  5 Feb 2021 18:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612551178;
        bh=UeP4cWGv5rtK74a32jB0nnmkJoxUA5+l9zruHAQr0i0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Sk6gYymuBeNW7XBVuQHMHqgxAlaFkA4j0HFbg4nH56hKHWer1QF0JyMixJF3tCWcd
         ETEpO1yrULexe4dX+6BJb1gGPpgc9KfLNu2pYT8tT4mh9BZb6Jz5iQFeOtLk8ZgTEF
         /xVTc9UfsS1YyW6q+Zv8S0NbtKQk5jAgLILQhcp6ZWOpv8KKCx21hgZqWtsA8dadnI
         e6m8Wn/QVJPe850XR9FT90wrzD0+JKOaqRWF4U9F9lJ2C5DOb6zj1iJ7AWVVETfqB2
         LjE6x+EoPXK4ycik3IyL5gIBy8y/KZXMrAR3/rJY8+E4aRj0TTOO6vpQUuC7NTNHx1
         IaZDC3CeNapKQ==
From:   Will Deacon <will@kernel.org>
To:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH V2 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Date:   Fri,  5 Feb 2021 18:52:50 +0000
Message-Id: <161254816916.731861.2448215186785582734.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
References: <1612239114-28428-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Feb 2021 09:41:52 +0530, Anshuman Khandual wrote:
> This series fixes pfn_valid() for ZONE_DEVICE based memory and also improves
> its performance for normal hotplug memory. While here, it also reorganizes
> pfn_valid() on CONFIG_SPARSEMEM. This series is based on v5.11-rc6.
> 
> Question - should pfn_section_valid() be tested both for boot and non boot
> memory as well ?
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
      https://git.kernel.org/arm64/c/fccf0a3dfeaf
[2/2] arm64/mm: Reorganize pfn_valid()
      https://git.kernel.org/arm64/c/387f3531116e

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
