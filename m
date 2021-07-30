Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BAB3DB2BF
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jul 2021 07:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhG3FXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jul 2021 01:23:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:32970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhG3FXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jul 2021 01:23:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A561760EC0;
        Fri, 30 Jul 2021 05:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627622577;
        bh=zWQoFuvSGRkaWrMDBZYBHS+7L+3+XOedxJZ92sz89LU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KxNa0A1dMdHpzEckFrW9pi9fQW8uTkFDXbvhGo7T6es3r7feLWURFgaLQFxcQmC0e
         FX72qDCbSgSLcsKVX7tFl/OEh4zbUBPRwJAzBxzFsjxrG0bE3ppgD2Ddmqy7myKuI6
         /2/2u7dpwbiYvd+/5DNyUAQmQ/HiQ21ktGotWBII=
Date:   Fri, 30 Jul 2021 07:22:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Barry Song <song.bao.hua@hisilicon.com>,
        andriy.shevchenko@linux.intel.com, yury.norov@gmail.com,
        linux-kernel@vger.kernel.org, dave.hansen@intel.com,
        linux@rasmusvillemoes.dk, rafael@kernel.org, rdunlap@infradead.org,
        agordeev@linux.ibm.com, sbrivio@redhat.com, jianpeng.ma@intel.com,
        valentin.schneider@arm.com, peterz@infradead.org,
        bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v8 0/5] use bin_attribute to break the size limitation of
 cpumap ABI
Message-ID: <YQOMrk2UxvMnjCBR@kroah.com>
References: <20210729054208.1800-1-song.bao.hua@hisilicon.com>
 <20210729105000.857e7225f0a73d6af98db116@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210729105000.857e7225f0a73d6af98db116@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2021 at 10:50:00AM -0700, Andrew Morton wrote:
> On Thu, 29 Jul 2021 17:42:03 +1200 Barry Song <song.bao.hua@hisilicon.com> wrote:
> 
> >  drivers/base/node.c     |  51 +++++++++-----
> >  drivers/base/topology.c | 115 ++++++++++++++++--------------
> >  include/linux/bitmap.h  |   2 +
> >  include/linux/cpumask.h |  63 +++++++++++++++++
> >  lib/bitmap.c            |  96 +++++++++++++++++++++++++
> >  lib/test_bitmap.c       | 150 ++++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 407 insertions(+), 70 deletions(-)
> 
> I'm assuming this is more a gregkh thing than an akpm thing?

Yeah, I can take this, thanks!

greg k-h
