Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1559D44D444
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232475AbhKKJsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 04:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60422 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229668AbhKKJsx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 04:48:53 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A2F11610FC;
        Thu, 11 Nov 2021 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636623964;
        bh=3OLkwWk/NZSEDP1NahNmJ1beXxLc2iY3gP7DvD9SdqQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ux8c7LmhPMx5KGDLJ6Ojw2y7xqoSoecV35sIZjwzPqzL1QKOShaAsGKx69Ld4/pf7
         44BuT/wWaXUXkZkdCEcLenUyD6XsNn5Fz9GdC+xvOkKQ9NvcJZV/7YjdObWOCntBO2
         PvvYLzN+I949FUOnZCBuQAiss+0OszfAB8B9d1BgvyQ96/hlTJYKY+M8Yit7cEXbDg
         ns3EK+/1Epk9PNA79YIDNi7QtEA9uyYDQx0nckxAJJX3HhpBIqxy1Ls033vkb2t3P1
         +gIQdg+CboASafJvmX4e/g9zq7M0yZs47x+wyWYymopxybNRNkUf0X1j7nussDgLOa
         E1b2uOFJBGh0A==
Date:   Thu, 11 Nov 2021 11:45:56 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     akpm@linux-foundation.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux@armlinux.org.uk, rppt@linux.ibm.com, tony@atomide.com,
        wangkefeng.wang@huawei.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v3 0/4] memblock, arm: fixes for freeing of the memory map
Message-ID: <YYzmVEmKPRmA2EOW@kernel.org>
References: <20210630071211.21011-1-rppt@kernel.org>
 <20211111073329.13095-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211111073329.13095-1-mark-pk.tsai@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Nov 11, 2021 at 03:33:29PM +0800, Mark-PK Tsai wrote:
> Hi,
> 
> The lts kernel also have this issue. (we use 5.4-lts kernel.)
> Currently we patch our custom kernel to select CONFIG_HOLES_IN_ZONE for arch arm.
> But I think the formal solution should backport to lts.
> 
> Would you help to backport this patch series? (including the below commit)

There were a couple of changes between 5.4 and this set, so you'd need to
"apply" the first two patches to arm::free_unused_memmap(). Other than
that, I don't see any pitfalls here.

Feel free to CC me when you post the backported series.
 
> (024591f9a6e0 arm: ioremap: don't abuse pfn_valid() to check if pfn is in RAM)
> 
> Thanks!

-- 
Sincerely yours,
Mike.
