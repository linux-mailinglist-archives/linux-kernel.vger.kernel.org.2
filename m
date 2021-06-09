Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2A43A0ACE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Jun 2021 05:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236580AbhFIDmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 23:42:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233525AbhFIDmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 23:42:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2BC9B60FEA;
        Wed,  9 Jun 2021 03:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623210024;
        bh=fdOo0G9HqTmmCdUZnDYUhHxotnAlzLnVWKn6YGTdoHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PmhqOBXNRY4Ol3uvSvnzaCjl1+WkQwU6F2151aMloOuak61/VdpQekkVYSlu0mn1r
         5xqJIoWgTuEBGvENZRG9uVLrlxgEIj5jE8IyY8v0nOOcZImo0YJAX7FVnScWZIQahT
         NmxNbnRklm9ZZWHdmu8b4EShYmFBTsZfNQe9Wijm7dtz/V7sx6nsQ4tCX9a8PAEoOM
         +t5tKIswtBa79qctZVVe4QhRK+JnnjDCocEjkfH736ssSSxzU331ht5lBEjka1ExoG
         9JXNy0bISu1Ia/lkZCksMSj7/NXdWTapNNTvP8O7wVxa/CHstIFV+VYtu9QakJLZDh
         Raec8zEwyrldA==
Date:   Wed, 9 Jun 2021 09:10:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     rashmi.a@intel.com, Kishon <kishon@ti.com>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-phy@lists.infradead.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: =?utf-8?B?W+KAnFBBVENI4oCdIDIvMl0gcGh5?= =?utf-8?Q?=3A_intel?=
 =?utf-8?Q?=3A?= Fix for warnings due to EMMC clock 175Mhz change in FIP
Message-ID: <YMA4JBN8m1Unj6ph@vkoul-mobl>
References: <20210603182242.25733-1-rashmi.a@intel.com>
 <20210603182242.25733-3-rashmi.a@intel.com>
 <CAPDyKFr-vuP_bdG-iFjJyS3ZeVDiVq+3aVERHjBo-8BHf38m9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFr-vuP_bdG-iFjJyS3ZeVDiVq+3aVERHjBo-8BHf38m9g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-06-21, 14:52, Ulf Hansson wrote:
> On Thu, 3 Jun 2021 at 20:22, <rashmi.a@intel.com> wrote:
> >
> > From: Rashmi A <rashmi.a@intel.com>
> >
> > Since the EMMC clock was changed from 200Mhz to 175Mhz in FIP,
> > there were some warnings introduced, as the frequency values
> > being checked was still wrt 200Mhz in code. Hence, the frequency
> > checks are now updated based on the current 175Mhz EMMC clock changed
> > in FIP.
> >
> > Spamming kernel log msg:
> > "phy phy-20290000.mmc_phy.2: Unsupported rate: 43750000"
> >
> > Signed-off-by: Rashmi A <rashmi.a@intel.com>
> > Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
> 
> I guess $subject patch should be queued together with patch1/2 (via
> the mmc tree?), no?
> 
> Vinod, Kishion, if that's okay I need an ack from you to pick it up.

Sure:

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
