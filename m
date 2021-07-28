Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6E63D8F46
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236584AbhG1NlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 09:41:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236419AbhG1NlE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 09:41:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A8DB960232;
        Wed, 28 Jul 2021 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1627479662;
        bh=D4V4u6/tac8vO9Ylpx+xLhcfauCqXTceeTupyBCh6w4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmZ8UlzoGJbfpQ58K4u8RvziwiphOQQ4zJtKZAunDqKHIk0Xtfrz/Dq/BNp0883ba
         uoWEfuExTluLb/6+Wdoas6Kj91szX+hhTnEMEXsnFR5gx52HMQ3Vr+QyqM6c/Pv62q
         h4rsrjvKB9wzgKQ8dmeV1zPoyqA8R/XzCO4hUEKI=
Date:   Wed, 28 Jul 2021 15:41:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, andriy.shevchenko@linux.intel.com,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, linux@rasmusvillemoes.dk, rafael@kernel.org,
        rdunlap@infradead.org, agordeev@linux.ibm.com, sbrivio@redhat.com,
        jianpeng.ma@intel.com, valentin.schneider@arm.com,
        peterz@infradead.org, bristot@redhat.com, guodong.xu@linaro.org,
        tangchengchang@huawei.com, prime.zeng@hisilicon.com,
        yangyicong@huawei.com, tim.c.chen@linux.intel.com,
        linuxarm@huawei.com
Subject: Re: [PATCH v7 0/4] use bin_attribute to break the size limitation of
 cpumap ABI
Message-ID: <YQFebNhDUD4VPN/P@kroah.com>
References: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210715115856.11304-1-song.bao.hua@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 11:58:52PM +1200, Barry Song wrote:
> v7:
>   - update doc in code for new APIs according to the comments of
>     Andy Shevchenko;
>   - other minor cleanup and commit log fix according to the comments
>     of Andy Shevchenko

I'm lost to tell if this is the latest version or if there are more
changes?  Can you send this again with the latest changes so I can
review it?

thanks,

greg k-h
