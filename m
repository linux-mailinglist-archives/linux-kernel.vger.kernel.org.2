Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7453AB1AB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:55:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhFQK5T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:57:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:48580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhFQK5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:57:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EDF8A613C1;
        Thu, 17 Jun 2021 10:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623927310;
        bh=FwR7iYxyJgKYFQQbS5slV1D0a+aTL+066f4cD3hqYYo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W6FxPYq4ApfHmy7Cra1UpL2wgFDIzupmCoGaymycb73uer9+0h03d3z8PUvq6lIzm
         xBf6QoCAESGTL2po+YbaD96wa9tLIh2l2ZdhCjK0rsUva7zqXzyyiV3bwp1r6cbuxk
         9VqNrBWdrmA2NWG6CqotfqhWqC72TxmJiBLTGvN0=
Date:   Thu, 17 Jun 2021 12:55:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, rafael@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        agordeev@linux.ibm.com, sbrivio@redhat.com, jianpeng.ma@intel.com,
        yury.norov@gmail.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        tiantao6@hisilicon.com, Jonathan.Cameron@huawei.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v4 3/4] drivers/base/node.c: use bin_attribute to avoid
 buff overflow
Message-ID: <YMsqCz3jICoOcKZh@kroah.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <20210617101910.13228-4-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617101910.13228-4-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:19:09PM +1200, Barry Song wrote:
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> Reading sys/devices/system/cpu/cpuX/nodeX/ returns cpumap and cpulist.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute. so we use bin_attribute instead of
> attribute to avoid NR_CPUS too big to cause buff overflow.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> ---
>  drivers/base/node.c | 52 +++++++++++++++++++++++++++++----------------
>  1 file changed, 34 insertions(+), 18 deletions(-)

You are forwarding on a patch from someone else, you HAVE to also sign
off on it as well.

thanks,

greg k-h
