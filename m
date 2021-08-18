Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75A0F3F039F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 14:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235641AbhHRMSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 08:18:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:47640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234896AbhHRMSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 08:18:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B800D60EBC;
        Wed, 18 Aug 2021 12:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629289053;
        bh=CZPSQOPLHFuQ1gMyYK8CP6eURya3PWKd1E/lhAdfdUc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imjXuahxGZGSd/+xlu3297dl/h+/JuqnCVridoGkm/iUxNBwTpRv2By2C9Scpc+w8
         ockFFJmNp0ZTbhEWZSIl6zTF9HksMcYuPJT3UJz6A3fshm/2C31JIGi/rdSMkwaGjn
         NaLzTmSTaV/YHludpmGM17IE6tslvMIthjKcINmJx9CQEk8yjGMGPDE7LstQ0zAHIi
         v8zP3HYKbdKM2XP8cPphkYiFiL5UKsswWuNL1iNBLbfGo7M7iSQZWqVa7joch9IqG/
         2GBKKr4HZTa85iaiRChC45KQpU+cy1UtMz3mYlkVKzzXq2XzEkn7IFyII7NghVQG2z
         RfWkInsOvQV9w==
Date:   Wed, 18 Aug 2021 13:17:29 +0100
From:   Will Deacon <will@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.15
Message-ID: <20210818121728.GB14107@willie-the-truck>
References: <20210813164735.GA8765@willie-the-truck>
 <YRz4OemrkIcDxCC5@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YRz4OemrkIcDxCC5@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 02:08:25PM +0200, Joerg Roedel wrote:
> On Fri, Aug 13, 2021 at 05:47:35PM +0100, Will Deacon wrote:
> > This applies cleanly against iommu/next, but I suspect it will conflict
> > with Robin's series on the list. Please shout if you need anything from
> > me to help with that (e.g. rebase, checking a merge conflict).
> 
> For now there were at least no conflicts which git couldn't resolve
> automatically, but the compile tests are still running :)

Ok, I won't hold my breath!

> > The following changes since commit ff1176468d368232b684f75e82563369208bc371:
> > 
> >   Linux 5.14-rc3 (2021-07-25 15:35:14 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git tags/arm-smmu-updates
> 
> So this is pulled now, thanks.

Cheers,

Will
