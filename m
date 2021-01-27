Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA63056DB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 10:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235264AbhA0J0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 04:26:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235165AbhA0JYi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 04:24:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 212C420757;
        Wed, 27 Jan 2021 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611739437;
        bh=bTJkY6o3gofoKbQ/JBPmgqJaeBCAHt8xrjpL7auhkvE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gE4XDtgBKYBGau3hX4YAe2kzDJSGrGdhPJ2JLrvrHekSuKwMzCmohHGdywaU8lZAJ
         kF3sK9p9AhsStR9TuHHQnZqzQWQolyg/rZW9Om6iotLqDPJYUsPGHasV2M3KyWV6DC
         nedlhGKqB7ggYrlcqQgpHtmPhqu2iXk0I1toi3NYtk672+IwSxLPJNEfSee2wSu8uD
         XKZKK7g7VTOXlI2oZctkLMTtggT3jcfnbQ5GVgssSWhmpKBzBchmWzYiV4nAVpxP+w
         KELYkUyfop2el2lVaE+PrRM1fAXb26APSyBoyeGcpraF8pPNaEacrthol+vRodO4Li
         voCiLtYqvNUdg==
Date:   Wed, 27 Jan 2021 09:23:52 +0000
From:   Will Deacon <will@kernel.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        iommu <iommu@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify
 code
Message-ID: <20210127092352.GA31790@willie-the-truck>
References: <20210122131448.1167-1-thunder.leizhen@huawei.com>
 <7f0b488d-f9b2-92b8-5914-2cef76b4d398@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f0b488d-f9b2-92b8-5914-2cef76b4d398@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 10:05:50AM +0800, Leizhen (ThunderTown) wrote:
> I've sent another set of patches. https://lkml.org/lkml/2021/1/26/1065
> If those patches are acceptable, then this one should be ignored.

I've already queued this one, so if you want me to drop it then you need to
send me a revert.

Will
