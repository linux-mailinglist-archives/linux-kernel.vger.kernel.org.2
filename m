Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0567E340264
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 10:48:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbhCRJr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 05:47:29 -0400
Received: from 8bytes.org ([81.169.241.247]:59566 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229962AbhCRJrU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 05:47:20 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E9BA92D8; Thu, 18 Mar 2021 10:47:18 +0100 (CET)
Date:   Thu, 18 Mar 2021 10:47:17 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Huang Rui <ray.huang@amd.com>
Cc:     "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Du, Xiaojian" <Xiaojian.Du@amd.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 0/3] iommu/amd: Fix booting with amd_iommu=off
Message-ID: <YFMhpWTgKP0pd/r1@8bytes.org>
References: <20210317091037.31374-1-joro@8bytes.org>
 <20210317104850.GB2508995@hr-amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317104850.GB2508995@hr-amd>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 06:48:50PM +0800, Huang Rui wrote:
> Series are Acked-by: Huang Rui <ray.huang@amd.com>

Thanks, series is applied for v5.12
