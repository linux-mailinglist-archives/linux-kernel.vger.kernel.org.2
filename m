Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAB213D91CF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 17:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbhG1PZW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 11:25:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:42760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235457AbhG1PZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 11:25:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2300660C41;
        Wed, 28 Jul 2021 15:25:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627485919;
        bh=ZdvP9MIhBK78vDltTaXSLA6p6GQjqljzC2b/EPA3l0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s3LUZAO14QabAtUsWl/wpMdN5rg08Ew4uaBcvweb43sZ0IFsIUVjw1hjU11JBnv36
         wpq9GyB4O6dO9wodpysVGw77ybZMJG6JHsR37Ks3beq+kL52hZjXcuuGkzxAcHXM4Y
         ArQJEETnd0tkj/wJVXNDWfBqQ5eBKcTAobElC1rg=
Date:   Wed, 28 Jul 2021 17:25:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Barry Song <song.bao.hua@hisilicon.com>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v7 0/4] use bin_attribute to break the size limitation of
 cpumap ABI
Message-ID: <YQF23RBlDgO/zu1F@kroah.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
 <YQFebNhDUD4VPN/P@kroah.com>
 <YQFvhyAggX1fUm2t@yury-ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YQFvhyAggX1fUm2t@yury-ThinkPad>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 28, 2021 at 07:53:59AM -0700, Yury Norov wrote:
> On Wed, Jul 28, 2021 at 03:41:00PM +0200, Greg KH wrote:
> > On Thu, Jul 15, 2021 at 11:58:52PM +1200, Barry Song wrote:
> > > v7:
> > >   - update doc in code for new APIs according to the comments of
> > >     Andy Shevchenko;
> > >   - other minor cleanup and commit log fix according to the comments
> > >     of Andy Shevchenko
> > 
> > I'm lost to tell if this is the latest version or if there are more
> > changes?  Can you send this again with the latest changes so I can
> > review it?
> 
> Barry, Greg,
> 
> If you decide to keep bitmap_print_to_buf in lib/bitmap.c, could you
> please add the following patch to the series.

Feel free to submit this as an add-on patch in the proper way so that it
could be applied.

thanks,

greg k-h
