Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0E2331712
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbhCHTQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:16:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:46374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231380AbhCHTQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:16:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E177A65295;
        Mon,  8 Mar 2021 19:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615230968;
        bh=Njq+rNWM473tqa/EUDnWxV5WQWQvNjm/Yf6AcdGBGFY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oHuXcXUUlyfCIOuQlXJZ6encXAfWHiqK5VI7QRGq229TRAWIp1rg8ed5vE/2vS1Db
         zIN3Jbz+Sf7qPuUwUwnOWLWCeNk2VKLaS0xxovVSFpoHi3D7iHepg888/yoUy2dXM4
         rLCE4pGSriNewD/PQBt3cRC3oOQeUNHAxmbfwe95tKSpS+acecOAaL8gYGatgrVk6F
         TzoavQ9iJ96XhdGq9vhU2hMxgOnZKMrdZZEYuJcFi3M8ZZJ2xdRFfJov3QuwmTW3TT
         Le7Y2+qXH97ABdZEOkIyMYtC+mVtTKHwYVVn19Se5W4hg4wuqXukEeqdlcJKmeMNTN
         C82LH42YGyCjg==
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        James Morse <james.morse@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Veronika Kabatova <vkabatov@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>
Subject: Re: [PATCH V3 0/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
Date:   Mon,  8 Mar 2021 19:16:00 +0000
Message-Id: <161522664065.2443375.11063143181620758255.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
References: <1614921898-4099-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Mar 2021 10:54:56 +0530, Anshuman Khandual wrote:
> This series fixes pfn_valid() for ZONE_DEVICE based memory and also improves
> its performance for normal hotplug memory. While here, it also reorganizes
> pfn_valid() on CONFIG_SPARSEMEM. This series is based on v5.12-rc1.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Jérôme Glisse <jglisse@redhat.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Mike Rapoport <rppt@linux.ibm.com>
> Cc: Veronika Kabatova <vkabatov@redhat.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/2] arm64/mm: Fix pfn_valid() for ZONE_DEVICE based memory
      https://git.kernel.org/arm64/c/eeb0753ba27b
[2/2] arm64/mm: Reorganize pfn_valid()
      https://git.kernel.org/arm64/c/093bbe211ea5

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
