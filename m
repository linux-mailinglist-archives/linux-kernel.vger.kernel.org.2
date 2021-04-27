Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E32A936C569
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 13:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238045AbhD0LkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 07:40:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236100AbhD0LkE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 07:40:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B2276100B;
        Tue, 27 Apr 2021 11:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619523560;
        bh=TxdaOEc9CznWEwtVjOxV+KNECrQDBOoFXaJg7zjtSdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BzmxTy6ndGTH6LDFaqWbNZF9+4dFeqwGsI2F2JTKJGFRrfo0AW52gyJJ8oa7QjOIp
         uhbS67JT8WP8ZJfUgcs9wSF5ZjkjgLQx/gmIEFmFfazdPShFsCPnP4L7K8QEdGzK+R
         XqtTYhYmBzyO8sLQKjRjPxKRXhO1ATws16xeML5Y=
Date:   Tue, 27 Apr 2021 13:39:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     rafael@kernel.org, hch@lst.de, m.szyprowski@samsung.com,
        robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: dma-api debugfs directory is not created since debugfs is not
 initialized
Message-ID: <YIf35EzfSY7qavWw@kroah.com>
References: <YIf2w1navFNeYjMS@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIf2w1navFNeYjMS@Red>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 01:34:27PM +0200, Corentin Labbe wrote:
> Hello
> 
> I try to debug some DMA problem on next-20210427, and so I have enabled CONFIG_DMA_API_DEBUG=y.
> But the dma-api directory does show up in debugfs, but lot of other directory exists in it.

Does it show up properly in 5.12?

> After debugging it seems due to commit 56348560d495 ("debugfs: do not attempt to create a new file before the filesystem is initalized")
> Reverting the commit permit to "dma-api" debugfs to be found. (but seems not the right way to fix it).

We have had some odd start-up ordering issues that the above commit has
caused to show.  Given that this commit is now in stable kernels, with
no report of this issue so far, I'm worried that maybe this is a dma
subsystem ordering issue?

thanks,

greg k-h
