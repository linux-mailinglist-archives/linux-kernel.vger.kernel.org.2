Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DD60331548
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhCHRxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:53:05 -0500
Received: from foss.arm.com ([217.140.110.172]:41628 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhCHRwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:52:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 784CBD6E;
        Mon,  8 Mar 2021 09:52:41 -0800 (PST)
Received: from C02TD0UTHF1T.local (unknown [10.57.51.12])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A97F3F71B;
        Mon,  8 Mar 2021 09:52:39 -0800 (PST)
Date:   Mon, 8 Mar 2021 17:52:32 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Hector Martin <marcan@marcan.st>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, james.morse@arm.com, maz@kernel.org,
        tglx@linutronix.de, will@kernel.org
Subject: Re: [PATCHv2 0/8] arm64: Support FIQ controller registration
Message-ID: <20210308175232.GA17002@C02TD0UTHF1T.local>
References: <20210302101211.2328-1-mark.rutland@arm.com>
 <04ab9271-db3c-e6b5-2464-12cb8662bb33@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04ab9271-db3c-e6b5-2464-12cb8662bb33@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 05, 2021 at 07:08:50PM +0900, Hector Martin wrote:
> On 02/03/2021 19.12, Mark Rutland wrote:
> > I'm hoping that we can get the first 2 patches in as a preparatory cleanup for
> > the next rc or so, and then the rest of the series can be rebased atop that.
> > I've pushed the series out to my arm64/fiq branch [4] on kernel.org, also
> > tagged as arm64-fiq-20210302, atop v5.12-rc1.
> 
> Just a reminder to everyone that filesystems under v5.12-rc1 go explodey if
> you use a swap file [1].
> 
> I don't care for the M1 bring-up series (we don't *have* storage), but it's
> worth pointing out for other people who might test this.
> 
> Modulo that,
> 
> Tested-by: Hector Martin <marcan@marcan.st>
> 
> [1] https://lore.kernel.org/lkml/CAHk-=wjnzdLSP3oDxhf9eMTYo7GF-QjaNLBUH1Zk3c4A7X75YA@mail.gmail.com/

Thanks!

I've folded that in, with the series rebased to v5.12-rc2, tagged as
arm64-fiq-20210308. I'm expecting that Marc will get the first couple of
patches queued by rc4, so there's at least one rebase ahead.

Mark.
