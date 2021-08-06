Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 427FF3E22B7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 06:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbhHFErP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 00:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:37122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231694AbhHFErN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 00:47:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D55246054E;
        Fri,  6 Aug 2021 04:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628225217;
        bh=mcb7gbQETBywgydTIJ1NoVRpsTUfH8k0bEXnyUNFHGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SRlwkg3s4SyWyWEqIdLJmZcAPnDPkfs/vbQDVTryR0DEYIPTl5kqQf51rvQL+r5/q
         hc7u6ZpDCZJbUlbf4tO+14LLeJ2AX9aS1I65oGTYTVQHs96mR8iS/JKXr5KzxFN59Q
         bxP/MS1ORAguK+tS/Z7G5YzwecRYckDoQp4/kHpE=
Date:   Fri, 6 Aug 2021 06:46:54 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "yury.norov@gmail.com" <yury.norov@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "sbrivio@redhat.com" <sbrivio@redhat.com>,
        "jianpeng.ma@intel.com" <jianpeng.ma@intel.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "guodong.xu@linaro.org" <guodong.xu@linaro.org>,
        tangchengchang <tangchengchang@huawei.com>,
        "Zengtao (B)" <prime.zeng@hisilicon.com>,
        yangyicong <yangyicong@huawei.com>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>,
        "tiantao (H)" <tiantao6@hisilicon.com>,
        Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v8 1/5] cpumask: introduce cpumap_print_to_buf to support
 large bitmask and list
Message-ID: <YQy+voTd/Oknohx9@kroah.com>
References: <20210729054208.1800-1-song.bao.hua@hisilicon.com>
 <20210729054208.1800-2-song.bao.hua@hisilicon.com>
 <YQvfD701nvqbClLd@kroah.com>
 <53c5fec4223f4c398b81362acf7441b5@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53c5fec4223f4c398b81362acf7441b5@hisilicon.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 05, 2021 at 11:05:59PM +0000, Song Bao Hua (Barry Song) wrote:
> > > +int bitmap_print_to_buf(bool list, char *buf, const unsigned long *maskp,
> > > +		int nmaskbits, loff_t off, size_t count)
> > 
> > No need to put the kernel doc for both the .h and .c file, only put it
> > in one place please (where ever it ties into the kernel documentation)
> > 
> 
> Actually they are two different modules. One is cpumap, the other one is
> bitmap. But they do have some duplicated content.
> I'd prefer to remove the duplicated part from cpumap.

Ah, I missed that they were two different functions, sorry.  But yes,
removing duplication is good.

thanks,

greg k-h
