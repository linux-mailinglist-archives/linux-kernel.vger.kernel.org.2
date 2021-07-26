Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63A73D58C8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 13:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233546AbhGZLGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233463AbhGZLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 07:06:48 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6C7C061757
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 04:47:17 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id BFCC52B0; Mon, 26 Jul 2021 13:47:15 +0200 (CEST)
Date:   Mon, 26 Jul 2021 13:47:14 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>
Cc:     Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yuanxzhang@fudan.edu.cn, Xin Tan <tanxin.ctf@gmail.com>
Subject: Re: [PATCH] iommu/amd: Convert from atomic_t to refcount_t on
 pasid_state->count
Message-ID: <YP6gwslBnkrH8uqt@8bytes.org>
References: <1626683578-64214-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626683578-64214-1-git-send-email-xiyuyang19@fudan.edu.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 19, 2021 at 04:32:58PM +0800, Xiyu Yang wrote:
>  drivers/iommu/amd/iommu_v2.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)

Applied, thanks.
