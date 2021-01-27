Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 504A7305A11
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 12:42:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237039AbhA0Llg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 06:41:36 -0500
Received: from 8bytes.org ([81.169.241.247]:53096 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237024AbhA0Lii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 06:38:38 -0500
X-Greylist: delayed 506 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 06:38:37 EST
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id E2F91303; Wed, 27 Jan 2021 12:37:55 +0100 (CET)
Date:   Wed, 27 Jan 2021 12:37:54 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] iommu/amd/init: convert comma to semicolon
Message-ID: <20210127113754.GC32671@8bytes.org>
References: <20201214134438.4776-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201214134438.4776-1-zhengyongjun3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 14, 2020 at 09:44:38PM +0800, Zheng Yongjun wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/iommu/amd/init.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

What tree is this against? This code does not exist in v5.11-rc5.
