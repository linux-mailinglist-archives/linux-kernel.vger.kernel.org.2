Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79D0B3EB2AD
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 10:32:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239006AbhHMIdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 04:33:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:54600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238157AbhHMIdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 04:33:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA7F46104F;
        Fri, 13 Aug 2021 08:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628843559;
        bh=NOS1YByhYU8Q8BGlUFYZ502PcNq7rmSYOZRJrGjHag0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cNK98SCecV5MmtiGjuX8Vnn7/Opd0ffQh5FwBvn4SSKkezf0K+86RggdHWcelOsfz
         GTmM2j9K48PIaHBzR2BT6v5hnpm1XKfc7BTBqOBIqVugG3v6nZMJAWUwRLRzk43iQP
         BTAMvpHWLIXuc2sTliOlHobfbZlxNBHKJNQkB19M=
Date:   Fri, 13 Aug 2021 10:32:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <21cnbao@gmail.com>
Cc:     song.bao.hua@hisilicon.com, agordeev@linux.ibm.com,
        akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        bristot@redhat.com, dave.hansen@intel.com, guodong.xu@linaro.org,
        jianpeng.ma@intel.com, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, linuxarm@huawei.com,
        peterz@infradead.org, prime.zeng@hisilicon.com, rafael@kernel.org,
        rdunlap@infradead.org, sbrivio@redhat.com,
        tangchengchang@huawei.com, tim.c.chen@linux.intel.com,
        valentin.schneider@arm.com, yangyicong@huawei.com,
        yury.norov@gmail.com
Subject: Re: [PATCH v9 0/5] use bin_attribute to break the size limitation of
 cpumap ABI
Message-ID: <YRYuHW8q5Zd+hvH5@kroah.com>
References: <20210806110251.560-1-song.bao.hua@hisilicon.com>
 <20210812044426.29876-1-21cnbao@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210812044426.29876-1-21cnbao@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 12, 2021 at 04:44:26PM +1200, Barry Song wrote:
> > V9:
> >   - Split bitmask and list APIs and removed bool parameter with respect to
> >     Greg's comment
> >   - Removed duplication in code doc
> >
> ...
> >
> > Background:
> >
> > the whole story began from this thread when Jonatah and me tried to add a
> > new topology level-cluster which exists on kunpeng920 and X86 Jacobsville:
> > https://lore.kernel.org/lkml/YFRGIedW1fUlnmi+@kroah.com/
> > https://lore.kernel.org/lkml/YFR2kwakbcGiI37w@kroah.com/
> >
> 
> Hi Greg,
> Will you take this series so that I can rebase the cluster-scheduler series[1] on top of
> this? that cluster series is where this ABI series really get started. I am looking forward
> to sending a normal patchset for cluster series after this ABI series settles down.
> 
> [1] scheduler: expose the topology of clusters and add cluster scheduler
> https://lore.kernel.org/lkml/20210420001844.9116-1-song.bao.hua@hisilicon.com/

Now applied to my testing tree.

thanks,

greg k-h
