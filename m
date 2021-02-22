Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61E5C322035
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 20:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbhBVTdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 14:33:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:53420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233223AbhBVTar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 14:30:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D31764E12;
        Mon, 22 Feb 2021 19:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614022205;
        bh=KJ9uctTGhxr8OX1F4YPK/lOw2Xb+NiXz66tV6gvfsu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HrEvdlPO9suuRnimdiSzk5aQYEsi2dnXwsbnQqkd8GNgoyNBwA5AzRmmAkfojnYkd
         xbuLgW97yM6F1kYGFjZpMdkKnJNsPGh20/7SWg5ak/rsB8Pi8D6gXvXMo9+D60vkaX
         BuyZ4yIfZ6WHPAMpV1Cixv/LAUN3MYCqGp+fjIt7hyPGbF/Rf6qhfIpkC8HKY03msG
         Z/fBCyBtGOj03PqMZnthKT3KhTHlDLZjKc4hcmPmB/ccWtm9lYu2kr4W9mlwWjPcUg
         aADYy8l8dHUbszRp9DXX5UB+WLp8KINdzrEPm+4G9sigTlwz+5773B+gEbBfbM0Hun
         GfQZX3qfsSfUQ==
Date:   Tue, 23 Feb 2021 04:29:59 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-core: Switch to using the new API kobj_to_dev()
Message-ID: <20210222192959.GA16253@redsun51.ssa.fujisawa.hgst.com>
References: <1613812218-17601-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613812218-17601-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 05:10:18PM +0800, Yang Li wrote:
> fixed the following coccicheck:
> ./drivers/nvme/host/core.c:3440:60-61: WARNING opportunity for
> kobj_to_dev()
> ./drivers/nvme/host/core.c:3679:60-61: WARNING opportunity for
> kobj_to_dev()
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

This was rejected the last time it posted 6 months ago:

http://lists.infradead.org/pipermail/linux-nvme/2020-September/019463.html
