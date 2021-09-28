Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3D641AC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 11:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbhI1JrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 05:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239844AbhI1Jq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 05:46:59 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA2FC061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 02:45:20 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 01515310; Tue, 28 Sep 2021 11:45:17 +0200 (CEST)
Date:   Tue, 28 Sep 2021 11:45:15 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Cc:     Will Deacon <will@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/ipmmu-vmsa: Hook up r8a77980 DT matching code
Message-ID: <YVLkK9mAe1lwMOAv@8bytes.org>
References: <20210923191115.22864-1-nikita.yoush@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210923191115.22864-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 23, 2021 at 10:11:16PM +0300, Nikita Yushchenko wrote:
>  drivers/iommu/ipmmu-vmsa.c | 3 +++
>  1 file changed, 3 insertions(+)

Applied, thanks.
