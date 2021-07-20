Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61863CF631
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbhGTHzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:55:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:59128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234561AbhGTHy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:54:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0A9B611EF;
        Tue, 20 Jul 2021 08:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626770136;
        bh=H9UUqQCl4PT+FM2yIrBMMn8pE51fXDZyIBexJTDkmw0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jW27i5qWAcE2S1OfDzCaQcAPQ2nJlgysjINsqpVeyDgQmY4cOnWLEx0pRar08s5Vy
         mcB7ai7yBslk/xqFPZ9UnMiSgFmYDSJ5CzUjd5zotGoJtLaW5dOdBih0KpPrVqRKCP
         KmT1xO+6WaLjdGYzb3nKHJaMUo0IMS86yVdHpmFShKQAF+5fJp+avBPD0HebBYYMyR
         h15Y7Vwgey0HGnyhTWUAMe+0p6Wy53xgeNzSUQg3wufUlgLgAC4MI5/x5hQD2hgHbB
         VzkpURFMXitzMHI3G6VIGHXI2c9ICAufytvu/QjppMJtHETSzodN9J7wNDSJks20z8
         9UmQmPZZTa0Zw==
Date:   Tue, 20 Jul 2021 09:35:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Claire Chang <tientzu@chromium.org>
Cc:     "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH 5/5] swiotlb: Free tbl memory in swiotlb_exit()
Message-ID: <20210720083530.GA8089@willie-the-truck>
References: <20210719123054.6844-1-will@kernel.org>
 <20210719123054.6844-6-will@kernel.org>
 <CALiNf2_Ubi9cynH1Rjy-o87V3MyvdTazv5rO=sggNai0WJZ81g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALiNf2_Ubi9cynH1Rjy-o87V3MyvdTazv5rO=sggNai0WJZ81g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 11:36:19AM +0800, Claire Chang wrote:
> On Mon, Jul 19, 2021 at 8:31 PM Will Deacon <will@kernel.org> wrote:
> >
> > Although swiotlb_exit() frees the 'slots' metadata array referenced by
> > 'io_tlb_default_mem', it leaves the underlying buffer pages allocated
> > despite no longer being usable.
> >
> > Extend swiotlb_exit() to free the buffer pages as well as the slots
> > array.
> >
> > Cc: Claire Chang <tientzu@chromium.org>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Tested-by: Claire Chang <tientzu@chromium.org>

Thanks, Claire!

Will
