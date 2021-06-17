Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFFD3AB1A9
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 12:54:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbhFQK4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 06:56:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbhFQK4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 06:56:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A741613CA;
        Thu, 17 Jun 2021 10:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1623927281;
        bh=VjFcs8Nc0hTPZ1GjDyuQBswwhLne0QqnkXv+Wza6R2Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T3IUKzj4YYP1MJpbL/3Wbpjj8VKIeVm7+63DMbN1nwGDSoMF4qxlbUiQaklcwcQbx
         G3DAfjviw7WbJNC8Ke7ASoZoCiHpzCXoRZn8Q17tf6O9CYHcFO+qQtp3ZzUJyNPlF5
         Vky9+wqWigqIkoRWCPc5jrC3MeKofwlxQ8i7Apfg=
Date:   Thu, 17 Jun 2021 12:54:39 +0200
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
Subject: Re: [PATCH v4 2/4] topology: use bin_attribute to avoid buff overflow
Message-ID: <YMsp704yqr/JW3cF@kroah.com>
References: <20210617101910.13228-1-song.bao.hua@hisilicon.com>
 <20210617101910.13228-3-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617101910.13228-3-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 10:19:08PM +1200, Barry Song wrote:
> From: Tian Tao <tiantao6@hisilicon.com>
> 
> Reading sys/devices/system/cpu/cpuX/topology/ returns cpu topology.
> However, the size of this file is limited to PAGE_SIZE because of the
> limitation for sysfs attribute. so we use bin_attribute instead of
> attribute to avoid NR_CPUS too big to cause buff overflow.
> 
> Link: https://lore.kernel.org/lkml/20210319041618.14316-2-song.bao.hua@hisilicon.com/
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>

Is this whole series supposed to go through my tree?

If so I'll wait on it based on my comments so far, otherwise I would
give an ack for this one...

thanks,

greg k-h
