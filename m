Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D80238F43F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 22:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbhEXUWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 16:22:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:48410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233079AbhEXUW3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 16:22:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6B4DC6140B;
        Mon, 24 May 2021 20:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621887661;
        bh=P0vqZlRTqthWHcQOTzgWGwJfAtBMMHR0cIa54Goqc7U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k9UNHGE5oAI98Q6Lzryn34l1pTJad95uj0M5XjlI//JDhiPTNmIrdf0XzOjJAQ0zM
         0Bh/1OxjGyxGmJdD8Zw4SyfVznwXsVC6FveM5D9s6Y2LH2NpbM6M0t0KB2qB/YWH8c
         D7K4hppc8nqDMu60DK8JHe6IbC7u07ORJ2dEucVMeC93EOtLetzfHXqlftx2DTTMMc
         ksWnGhWG8mmjlCRMxK98P3iufvOaV+Y9rFsAFLy8nKmajajWQl4hvsHL94Dh6O9Y/j
         vk+yuENDBF1eibuz7/yQDvpJ9XQZkD1G8ybr6Fts5nJLAbBzexq+2Nvvt87/qqpICV
         94LN3NmtTcvTw==
Date:   Mon, 24 May 2021 21:20:55 +0100
From:   Will Deacon <will@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Nitesh Lal <nilal@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, Frank Li <Frank.li@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
Subject: Re: [patch 0/8] genirq, perf: Cleanup the abuse of
 irq_set_affinity_hint()
Message-ID: <20210524202054.GA15545@willie-the-truck>
References: <20210518091725.046774792@linutronix.de>
 <20210518104849.GB7770@willie-the-truck>
 <874kf0doq7.ffs@nanos.tec.linutronix.de>
 <87v97fccq9.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v97fccq9.ffs@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 11:08:30AM +0200, Thomas Gleixner wrote:
> On Tue, May 18 2021 at 17:51, Thomas Gleixner wrote:
> > Sure. I'll send you a tag to pull ...
> 
> Here you go:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git irq-export-set-affinity

Cheers, I've pulled that in and stuck the driver patches on top.

Will
