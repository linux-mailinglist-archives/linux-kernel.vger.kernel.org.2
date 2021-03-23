Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61929345FB8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 14:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhCWNcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 09:32:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231484AbhCWNcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 09:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A08D461934;
        Tue, 23 Mar 2021 13:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616506342;
        bh=W0tIxwsotien8iin7AWdN0XUIhP3YiP+OBSWyGyUIPQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HOABxc/6xUlMWP+sNnK6mvSUvWnA+V+tVoKF0Ph/6Bsi3Lcuqibn37ordn3DpRauj
         zTJlpy2gDkuLmH2/V2CpmVW55M+a3ptLj4vaNwLfuFm0DmZ0MzvoiAzwZnWo+0nH/j
         mrT6ATUAndAmfalBbnfdKLPtOOBfHMGO+7W2aflUoE3TTFgGXVLVap4+NO3TADIL52
         YNU7xXY1LQgfItyW3VilJv409kOWTe7ThSN76qFDc77ClH/YaXOkwQnZ3mLzCEQiie
         nn7lu7TbfMNxMR+NtU60Mpj/dfc4FRCJdWKCkoORFXUhDTXpI3zsKQ/Cs3/5RvHJ5s
         LVcbPIUVxcL7g==
Date:   Tue, 23 Mar 2021 13:32:18 +0000
From:   Will Deacon <will@kernel.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, guohanjun@huawei.com
Subject: Re: [PATCH 2/3] arm64: lib: improve copy performance when size is ge
 128 bytes
Message-ID: <20210323133217.GA11802@willie-the-truck>
References: <20210323073432.3422227-1-yangyingliang@huawei.com>
 <20210323073432.3422227-3-yangyingliang@huawei.com>
 <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03ac41af-c433-cd66-8195-afbf9c49554c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:08:56PM +0000, Robin Murphy wrote:
> On 2021-03-23 07:34, Yang Yingliang wrote:
> > When copy over 128 bytes, src/dst is added after
> > each ldp/stp instruction, it will cost more time.
> > To improve this, we only add src/dst after load
> > or store 64 bytes.
> 
> This breaks the required behaviour for copy_*_user(), since the fault
> handler expects the base address to be up-to-date at all times. Say you're
> copying 128 bytes and fault on the 4th store, it should return 80 bytes not
> copied; the code below would return 128 bytes not copied, even though 48
> bytes have actually been written to the destination.
> 
> We've had a couple of tries at updating this code (because the whole
> template is frankly a bit terrible, and a long way from the well-optimised
> code it was derived from), but getting the fault-handling behaviour right
> without making the handler itself ludicrously complex has proven tricky. And
> then it got bumped down the priority list while the uaccess behaviour in
> general was in flux - now that the dust has largely settled on that I should
> probably try to find time to pick this up again...

I think the v5 from Oli was pretty close, but it didn't get any review:

https://lore.kernel.org/r/20200914151800.2270-1-oli.swede@arm.com

he also included tests:

https://lore.kernel.org/r/20200916104636.19172-1-oli.swede@arm.com

It would be great if you or somebody else has time to revive those!

Will
