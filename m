Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0883C998B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 09:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240325AbhGOHXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 03:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240308AbhGOHXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 03:23:03 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A11C06175F
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 00:20:10 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5CE2B2C7; Thu, 15 Jul 2021 09:20:08 +0200 (CEST)
Date:   Thu, 15 Jul 2021 09:20:04 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     iommu@lists.linux-foundation.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        yong.wu@mediatek.com
Subject: Re: [PATCH] iommu: check if group is NULL before remove device
Message-ID: <YO/hpPpu6Z526+Ia@8bytes.org>
References: <20210715071150.82157-1-linux@fw-web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715071150.82157-1-linux@fw-web.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 09:11:50AM +0200, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> if probe is failing, iommu_group may be not initialized,

Sentences start with capital letters.

IOMMU patch subjects too, after the 'iommu:' prefix.

> so freeing it will result in NULL pointer access

Please describe in more detail how this NULL-ptr dereference is
triggered.

Regards,

	Joerg
