Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A122B316083
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 09:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbhBJIDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 03:03:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:44234 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233199AbhBJIDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 03:03:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3A31264DB1;
        Wed, 10 Feb 2021 08:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612944174;
        bh=rJTwMxtUchbfljFXXQ20HhURw7jNmDgqSh0tX3xFgyQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uHPzU4nH4CVXjZjNaaFHh7CKJu7CSPWtcixotPk7afewt3prO3HH1T7xXLwHZ+6ED
         OajiYj0SYa7uXajhClCUOme+3BDwr246uhTeJgcdiamUOUKy7Pz/a48V85Abd5zVb3
         3FcBZslL9wGK57QyPEYWvBINKRb0BaPgbhDTtXsE=
Date:   Wed, 10 Feb 2021 09:02:51 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jhubbard@nvidia.com,
        willy@infradead.org, surenb@google.com, joaodias@google.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Subject: Re: [PATCH v3] mm: cma: support sysfs
Message-ID: <YCOTK7ojKCxFmqcI@kroah.com>
References: <20210210075509.3788729-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210210075509.3788729-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 09, 2021 at 11:55:09PM -0800, Minchan Kim wrote:
> Since CMA is getting used more widely, it's more important to
> keep monitoring CMA statistics for system health since it's
> directly related to user experience.
> 
> This patch introduces sysfs statistics for CMA, in order to provide
> some basic monitoring of the CMA allocator.
> 
>  * the number of CMA page allocation attempts
>  * the number of CMA page allocation failures
> 
> These two values allow the user to calcuate the allocation
> failure rate for each CMA area.
> 
> e.g.)
>   /sys/kernel/mm/cma/WIFI/cma_alloc_pages_[attempts|fails]
>   /sys/kernel/mm/cma/SENSOR/cma_alloc_pages_[attempts|fails]
>   /sys/kernel/mm/cma/BLUETOOTH/cma_alloc_pages_[attempts|fails]
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

For the sysfs stuff:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
