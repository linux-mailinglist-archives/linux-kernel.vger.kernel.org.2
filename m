Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8175242D3C9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 09:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbhJNHh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 03:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229910AbhJNHh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 03:37:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7532460FDC;
        Thu, 14 Oct 2021 07:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634196951;
        bh=6uDUVmn+lPgae2Av9Y+lntZQNsMV/gFXI/gYxOwCBV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XgpzG/u3e/hTVO+wbHSLmwfDQl3NUCabsXI4+bB3xA/OzBLT2F8Vnw5i1+CD/G1kP
         42UcHgZj+kypZJ6gacDQ5xwJFyN/03DwSfIdGD7E392XlJvYO7wzbaTdRvoEXICTyO
         ZhhXZ655jsYaoNRBKANDEKv+zE+mxVvBk4Kc1A1EEQDKCBysG+YMXyZcmYEPAGyRSR
         IRI5E9AHlxitx/upLlZx3f8eutCePXi0ro5BawBfTyLK1ahwxyVwAhgSXyrQiSlCxb
         Z88syAJtompnHJ/dqba8dAWl+w+xmji8Vn4ZyNMjJNCIjx35Ikizi9qNpgcacnlj4J
         094u1VQUxylMQ==
Date:   Thu, 14 Oct 2021 08:35:45 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Yong Wu <yong.wu@mediatek.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        Alex Elder <elder@linaro.org>,
        "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iommu/arm: fix ARM_SMMU_QCOM compilation
Message-ID: <20211014073545.GA7857@willie-the-truck>
References: <20211012151841.2639732-1-arnd@kernel.org>
 <20211013075803.GB6701@willie-the-truck>
 <CAK8P3a1GaQ1kjkjOP09eTUu6MR+RjhSDU9s-49MPQ1FSOMUDEg@mail.gmail.com>
 <20211013162024.GA7134@willie-the-truck>
 <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0aLKv76AjuLO4kMa3hDj8LwsGxGhGToX935pdfsr15KQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 09:31:40PM +0200, Arnd Bergmann wrote:
> On Wed, Oct 13, 2021 at 6:20 PM Will Deacon <will@kernel.org> wrote:
> > On Wed, Oct 13, 2021 at 10:33:55AM +0200, Arnd Bergmann wrote:
> > > On Wed, Oct 13, 2021 at 9:58 AM Will Deacon <will@kernel.org> wrote:
> > > > On Tue, Oct 12, 2021 at 05:18:00PM +0200, Arnd Bergmann wrote:
> 
> > > I was hoping you and Joerg could just pick your preferred patch
> > > into the iommu fixes tree for v5.15.
> > >
> > > I currently have nothing else pending for my asm-generic tree that
> > > introduced the regression, but I can take it through there if that helps
> > > you.
> >
> > I also don't have any fixes pending, and I don't see any in Joerg's tree so
> > it's probably quickest if you send it on yourself. Is that ok?
> 
> Sure, no problem. I ended up adding it to the arm/fixes branch of the
> soc tree, as I just merged some other fixes there, and it seems as good
> as any of the other trees.

Thanks, Arnd!

Will
