Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0AED3DDC25
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhHBPQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:16:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:35558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234972AbhHBPQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:16:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B1ECE60F51;
        Mon,  2 Aug 2021 15:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627917371;
        bh=acb2BeSUbe3rYtpwUGbc3ak3uXaBswP9iQL7oYaIehM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NIci1ZbRX6xJt6APvjh2SXYw+990LwdsEvp9Sur3D4C/Kv0dP6TdW6xc1oW8BMysR
         Fpzs6et64t1kV8YX17JjUGqbbrz2OwDP/aT80nH0EbPfeTRdGr6MFoTXvzMIIJuURH
         54fm68Csl08B/r8lGWZlrrKEo0XF/ycsxRvVgj/mY58JcrEfnWkCqtvfAJx5rJZzQi
         y7M1LPEXE2BTTDSGgyAatntwENL9rZIX6aXtSzKH5zNR3Pv3+eynHS+ywE57GM4dme
         OC223XFa1jmVCzaHsMQUD16ugQYux1BKIDGfHNwbOgjtq4k9FAO2CsVQCIdomVmLaK
         tO/B6M6stp4Ug==
Date:   Mon, 2 Aug 2021 16:16:07 +0100
From:   Will Deacon <will@kernel.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     robin.murphy@arm.com, vdumpa@nvidia.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [Patch V2 0/2] iommu/arm-smmu: Fix races in iommu domain/group
 creation
Message-ID: <20210802151607.GF28735@willie-the-truck>
References: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1623961837-12540-1-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2021 at 02:00:35AM +0530, Ashish Mhetre wrote:
> Multiple iommu domains and iommu groups are getting created for the devices
> sharing same SID. It is expected for devices sharing same SID to be in same
> iommu group and same iommu domain.
> This is leading to context faults when one device is accessing IOVA from
> other device which shouldn't be the case for devices sharing same SID.
> Fix this by protecting iommu domain and iommu group creation with mutexes.

Robin -- any chance you could take a look at these, please? You had some
comments on the first version which convinced me that they are needed,
but I couldn't tell whether you wanted to solve this a different way or not.

Cheers,

Will
