Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEF83F0455
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 15:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236084AbhHRNKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236615AbhHRNKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 09:10:19 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D802C061292
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 06:09:42 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id CBAAC260; Wed, 18 Aug 2021 15:09:39 +0200 (CEST)
Date:   Wed, 18 Aug 2021 15:09:28 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Will Deacon <will@kernel.org>
Cc:     iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, kernel-team@android.com
Subject: Re: [GIT PULL] iommu/arm-smmu: Updates for 5.15
Message-ID: <YR0GiO+miNkxXp76@8bytes.org>
References: <20210813164735.GA8765@willie-the-truck>
 <YRz4OemrkIcDxCC5@8bytes.org>
 <20210818121728.GB14107@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818121728.GB14107@willie-the-truck>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 01:17:29PM +0100, Will Deacon wrote:
> Ok, I won't hold my breath!

Compile tests went fine and the kernel booted fine on my workstation, so
I pushed things out. Let's see whether testing in linux-next breaks
anything.

Regards,

	Joerg
