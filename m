Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A657A41CB3E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 19:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345417AbhI2Ru0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 13:50:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:45374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345291AbhI2RuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 13:50:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A106061361;
        Wed, 29 Sep 2021 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632937724;
        bh=8bRYESk7HoGUvf9Wpc7n6mnuhVchTufCacY+5UOqb+8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gCWrNKDYN2tVGmGm/R5uQbR9+/fg9Hxov0AMyAFqH2pHKkR7FgZ7D8dn57oxNIm3M
         yWGFUpVTH08UEho9S2pnYuPP9I/5RZzt9/hA64oxMsQElA37NGiFq5iYkZm24CnT2h
         wAj4Rrul1Znn9xfjPevJGdb1Q4j3c9GWkfp1fLfGca+aGXg1Yhg37a5bCsohODIXSM
         kI/ZXRzyFTq2Y6UMNur36cp2nP60DJAxkmIvXzDK+r6xvZQFNNcfGOhtmWVjDWIXGE
         p+sLpU6zxXW9GFqgo04F7vktnHV44OY7f8705koWFEop7rh1aQIO5rOX9//ATHd0Rg
         o85PxjL4H0FRg==
From:   Will Deacon <will@kernel.org>
To:     Chris Goldsworthy <quic_cgoldswo@quicinc.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        Georgi Djakov <quic_c_gdjako@quicinc.com>,
        Sudarshan Rajagopalan <quic_sudaraja@quicinc.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: arm64: mm: update max_pfn after memory hotplug
Date:   Wed, 29 Sep 2021 18:48:27 +0100
Message-Id: <163293186685.928897.8618689831730989496.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
References: <cover.1632853776.git.quic_cgoldswo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021 11:51:48 -0700, Chris Goldsworthy wrote:
> Follow up of RFC patch:
> 
> https://lore.kernel.org/linux-mm/a3bf84c4-8f35-f273-145c-55928a06f332@quicinc.com/T/#m219937b1acdd40318bbe90ab39f187804775eb74
> 
> On arm64 we set max_pfn at boot in arch/arm64/mm/init.c. If you
> hotplug in memory after booting up, max_pfn is not updated. This
> breaks diagnostic functions executed from user space like
> read_page_owner():
> 
> [...]

Applied to arm64 (for-next/mm), thanks!

[1/1] arm64: mm: update max_pfn after memory hotplug
      https://git.kernel.org/arm64/c/8fac67ca236b

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
