Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 914E93C1559
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbhGHOnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 10:43:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:43220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231917AbhGHOnd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 10:43:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 95C8361622;
        Thu,  8 Jul 2021 14:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1625755251;
        bh=eJ5sP58aL4OwiOaReEZeYkwxfPnkIdoZBObgua4paN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=efM0+HcKT8kpzz4RRbZ+V68zn1/JQc2ICEH+EQwI8mq6il9QywmdatgsF9G3lUHNS
         ObiI+zmjHk5eQcegVrztRRDWCohsrJ3Jdp0rbWdd/rND/lEktXp4yJ7a9Vgh8WM6UI
         4cqTVlYRUdmBvOS+ooSsMVd45kIZouM5ltimtv+c=
Date:   Thu, 8 Jul 2021 16:40:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shaobo Huang <huangshaobo6@huawei.com>
Cc:     chenzefeng2@huawei.com, kepler.chenxin@huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@arm.linux.org.uk, liucheng32@huawei.com, mhiramat@kernel.org,
        nixiaoming@huawei.com, tixy@linaro.org, xiaoqian9@huawei.com,
        young.liuyang@huawei.com, zengweilin@huawei.com
Subject: Re: ping // [PATCH 4.4.y] arm: kprobes: Allow to handle reentered
 kprobe on single-stepping
Message-ID: <YOcOcNBRou5KlbOR@kroah.com>
References: <YOb1xv0a0U+0Wp1z@kroah.com>
 <20210708131240.32836-1-huangshaobo6@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210708131240.32836-1-huangshaobo6@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2021 at 09:12:40PM +0800, Shaobo Huang wrote:
> On Thu, Jul 08, 2021 at 09:56PM +0800, Greg KH wrote:
> > > On Thu, Jul 08, 2021 at 08:42:40PM +0800, Shaobo Huang wrote:
> > > ping
> > 
> > ???
> > 
> > What are you asking about here?  Please be specific, "naked pings" like this are not informative.
> > 
> > thanks,
> > 
> > greg k-h
> 
> This patch was merged in the 4.9.y branch last time, but the 4.4.y branch is still not merged,
> please review the 4.4 branch merge.

What "4.4 branch merge"?  I see no patch here at all.

confused,

greg k-h
