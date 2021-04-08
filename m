Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572023584AA
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 15:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhDHN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 09:28:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229803AbhDHN2V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 09:28:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3BB561107;
        Thu,  8 Apr 2021 13:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617888490;
        bh=wkH0Q0JKhFFGHpi0excDmQI/Xn0hOyg48Ia2aLs0W14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L//1DccqA0sW9OR7Y58lptQc2UwfX8WREzKYBQMgr8+D/Ivol4Li85zKayJbxODCg
         snvD1dZp53fnbSPnZ8aoM1Ed5K4dC9wm5IxrxRUbUREdEmcQrYVj8PwwUNXZnjb13u
         HJfSr3K9ne7+PMcJqReG/i8TjxFmsDGW2CIh2yudJhejWPX+8BXyGkgnUvskVyU08s
         rf7Nh8FgKYN6YkjLYkgokniWI94zGY5EtEGIC7HcHmm07H9NQW/eaEOdqmX6gwpFo2
         g+lFtTPSOwkWk6Ze/32Y4WzJ9NYYOyeuyk+yYqXMQrCoaRhGzlnSq3xcHCiEWTnZyB
         yT0G3xPSZLZUw==
Date:   Thu, 8 Apr 2021 14:28:05 +0100
From:   Will Deacon <will@kernel.org>
To:     John Garry <john.garry@huawei.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "liuqi (BA)" <liuqi115@huawei.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Zhangshaokun <zhangshaokun@hisilicon.com>,
        Linuxarm <linuxarm@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] drivers/perf: hisi: Add driver for HiSilicon PCIe PMU
Message-ID: <20210408132805.GA17873@willie-the-truck>
References: <1617788943-52722-1-git-send-email-liuqi115@huawei.com>
 <1617788943-52722-2-git-send-email-liuqi115@huawei.com>
 <20210407204004.GB16011@willie-the-truck>
 <20210408100157.000062f0@Huawei.com>
 <16a7a3f8-82b5-a113-57c0-a9d575c649bd@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16a7a3f8-82b5-a113-57c0-a9d575c649bd@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On Thu, Apr 08, 2021 at 01:55:02PM +0100, John Garry wrote:
> On 08/04/2021 10:01, Jonathan Cameron wrote:
> > On Wed, 7 Apr 2021 21:40:05 +0100
> > Will Deacon <will@kernel.org> wrote:
> > 
> > > On Wed, Apr 07, 2021 at 05:49:02PM +0800, Qi Liu wrote:
> > > > PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported
> > > > to sample bandwidth, latency, buffer occupation etc.
> > > > 
> > > > Each PMU RCiEP device monitors multiple root ports, and each RCiEP is
> > > > registered as a pmu in /sys/bus/event_source/devices, so users can
> > > > select target PMU, and use filter to do further sets.
> > > > 
> > > > Filtering options contains:
> > > > event        - select the event.
> > > > subevent     - select the subevent.
> > > > port         - select target root ports. Information of root ports
> > > >                 are shown under sysfs.
> > > > bdf           - select requester_id of target EP device.
> > > > trig_len     - set trigger condition for starting event statistics.
> > > > trigger_mode - set trigger mode. 0 means starting to statistic when
> > > >                 bigger than trigger condition, and 1 means smaller.
> > > > thr_len      - set threshold for statistics.
> > > > thr_mode     - set threshold mode. 0 means count when bigger than
> > > >                 threshold, and 1 means smaller.
> > > > 
> > > > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > 
> > > Do you have a link to this review, please?
> > 
> > Internal review, so drop the tag.
> > 
> > Jonathan
> 
> Hi Will,
> 
> Are you implying that you would rather that any review for these drivers is
> done in public on the lists?

Absolutely! If I can see that you and/or Jonathan have given the thing a
good going through, then it's a lot easier to merge the patches. But just
having the tag doesn't help much, as I don't know whether it was a concerted
review effort or a "yeah, this function is about what I thought, cheers"
type of review.

That's not to say internal patch review isn't a useful tool in some
circumstances (e.g. somebody new to the kernel, confidential stuff,
prototyping), but the vast majority of the time I'd say having the review
on the public lists is the best bet.

Will
