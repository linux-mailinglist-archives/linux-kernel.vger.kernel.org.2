Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD78344596
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhCVNX6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 09:23:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231696AbhCVNUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 09:20:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B4E9461931;
        Mon, 22 Mar 2021 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616419216;
        bh=a2pnwEddemU5DYSt5oOYkVSLleQPxXPsYezqw86iIdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jvxDaAIcToW8kVmgY+C7RUibu8v84OzJh5Ujr3g7Kb0Zi79BjY3RSgfs8PDyqpbqb
         CMpJZBnh9GUJ1ICRVbkq+wdhAhZXFzriogBO26Xf2XAsSmFk6YxLKQIZYrJF3RSrKX
         W4fanvT70QgwY7gvbEe2zJF1LwAKZArDftVCQy24q4ICBs7E9T2qgBTJkUiNr/HVNm
         w2cZFW8176BisgRnhP9vxLGePVC/lLT0Eq9A1lE3ED68yonVWaiyn53yje3XdEREGR
         z4L5S0Tspb5Dn3vZw79pgEnzpaM9EWLMXFoD0FBssYE3Y4mHV6fZUxUDP/hcJWzzxj
         VYoNL9XTRgJ7A==
From:   Will Deacon <will@kernel.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org,
        logang@deltatee.com, mhocko@suse.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        rppt@kernel.org, jmorris@namei.org, tyhicks@linux.microsoft.com,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     kernel-team@android.com, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 0/1] correct the inside linear map range during hotplug check
Date:   Mon, 22 Mar 2021 13:19:58 +0000
Message-Id: <161641726115.3901166.7580035330760911434.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210216150351.129018-1-pasha.tatashin@soleen.com>
References: <20210216150351.129018-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Feb 2021 10:03:50 -0500, Pavel Tatashin wrote:
> v3:	- Sync with linux-next where arch_get_mappable_range() was
> 	  introduced.
> v2:	- Added test-by Tyler Hicks
> 	- Addressed comments from Anshuman Khandual: moved check under
> 	  IS_ENABLED(CONFIG_RANDOMIZE_BASE), added
> 	  WARN_ON(start_linear_pa > end_linear_pa);
> 
> [...]

Applied to arm64 (for-next/fixes), thanks!

[1/1] arm64: mm: correct the inside linear map range during hotplug check
      https://git.kernel.org/arm64/c/ee7febce0519

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
