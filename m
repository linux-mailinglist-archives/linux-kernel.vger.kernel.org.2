Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE74143C35B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240155AbhJ0G6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 02:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbhJ0G6O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 02:58:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E629CC061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 23:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zRi7FJUCOhsdjgbw/serbNCpemaKbs5MpCiaL6eB1dc=; b=NiJCffsKblIi/jSsb6kR+Dje0g
        +lSEESDWarV4avddWq6MXCJUiWAFzi/4/PddNxC0H07Hs+zZTFL7CgiPeZEbWNgI6S37KNUTWWnbY
        qbFuP/JgqYNk3swbZeYAtcJI57i0KreX6gpHh70+TNKSfMi9OANBHVQrmmO3tc67ijnKABZHCb4SO
        P6UN/CVwmRAX49h3/EC6P2xSJ/W9zaYLEfrCqAINi/pGEzwWRUmwFKjU2mklHG63MEmDxggMmhLEO
        05sd8M+/Dc/ZWnfd7sc6DrFC56scjVVMYHtTA6ZE9JpkP7ZDMf9ap5nJCJNbDMTOKPtSOM8rXicAi
        S+H3AkrQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mfcqd-0044Zu-OG; Wed, 27 Oct 2021 06:55:43 +0000
Date:   Tue, 26 Oct 2021 23:55:43 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     agk@redhat.com, snitzer@redhat.com, dm-devel@redhat.com,
        matthias.bgg@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tequila.yuang@mediatek.com,
        yj.chiang@mediatek.com
Subject: Re: [PATCH] dm: add module parameter bdev_wait
Message-ID: <YXj37wXtN0wQqwZx@infradead.org>
References: <20211022064748.30136-1-mark-pk.tsai@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211022064748.30136-1-mark-pk.tsai@mediatek.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 02:47:47PM +0800, Mark-PK Tsai wrote:
> dm_early_create() fail if the target block device not found in
> the late init stage.
> The block device is created in mmc_rescan() which kernel do
> it async by queue it into system_freezable_wq.
> Add module param bdev_wait to support waiting the block device
> ready before dm_early_create() like prepare_namespace() does.

This adds a busy loop.  There is a reason why we usually set up
stacking drivers from userspace, in that we have a working event
system there.  So the answer is not to add further hacks to the
in-kernel DM setup hack, but to stop using it.
