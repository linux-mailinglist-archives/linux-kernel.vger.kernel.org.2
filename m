Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD56331134
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 15:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhCHOrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 09:47:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:42136 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229704AbhCHOra (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 09:47:30 -0500
IronPort-SDR: LQlRiZNm+afCDrpxynKPoFUJRWgWnqYXCoKQpSuJ/wXlwmc3i35FcdXA/3wnkrCckquCBDBqvu
 Znafyp+2uLHw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="184677617"
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="184677617"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 06:47:19 -0800
IronPort-SDR: +QofRChoeoCWBfT0mpW0oOhFdpz5lT4nLcWtm5oa+11MAvfdZEg5vQy1kXuREWSqYEN7i4CnHl
 zHHLD8TXB9Sg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,232,1610438400"; 
   d="scan'208";a="602171275"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by fmsmga005.fm.intel.com with ESMTP; 08 Mar 2021 06:47:17 -0800
Date:   Mon, 8 Mar 2021 22:42:33 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v3 0/4] Some improvement for Intel MAX 10 MFD drivers
Message-ID: <20210308144233.GB8110@yilunxu-OptiPlex-7050>
References: <1614578385-26955-1-git-send-email-yilun.xu@intel.com>
 <20210308020454.GA32151@yilunxu-OptiPlex-7050>
 <20210308090124.GA4931@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308090124.GA4931@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2021 at 09:01:24AM +0000, Lee Jones wrote:
> On Mon, 08 Mar 2021, Xu Yilun wrote:
> 
> > Hi Lee:
> > 
> > Could you please help on review this patchset? They are some
> > improvements for intel-m10-bmc MFD driver.
> 
> Please don't send contentless pings 1 week after submitting a set.
> 
> Also please refrain from top-posting.
> 
> This patch is on my TO-REVIEW list.
> 
> Unfortunately, since I work in reverse chronological order, you just
> pushed the set to the back of the list.
> 
> If after a suitable period, usually around 2 weeks, you think your
> submission has been missed, please submit a [RESEND] instead.

Thanks for clarification, I'll follow it.

I thought my submission was missed cause I didn't got your response
since v2 at Jan 26, maybe some misunderstanding, so I'm a little hurry
this time. Sorry.

Yilun

> 
> > On Mon, Mar 01, 2021 at 01:59:41PM +0800, Xu Yilun wrote:
> > > This patchset is some improvements for intel-m10-bmc and its subdevs.
> > > 
> > > Main changes from v1:
> > > - Add a patch (#2) to simplify the definition of the legacy version reg.
> > > - Add a patch (#4), add entry in MAINTAINERS for intel-m10-bmc mfd driver
> > >   and the subdev drivers.
> > > 
> > > Main changes from v2:
> > > - Add Tom Rix as the reviewer for intel-m10-bmc mfd driver and the subdev
> > >   drivers.
> > > - Rebased to 5.12-rc1
> > > 
> > > 
> > > Matthew Gerlach (1):
> > >   mfd: intel-m10-bmc: Add access table configuration to the regmap
> > > 
> > > Xu Yilun (3):
> > >   mfd: intel-m10-bmc: Fix the register access range
> > >   mfd: intel-m10-bmc: Simplify the legacy version reg definition
> > >   MAINTAINERS: Add entry for Intel MAX 10 mfd driver
> > > 
> > >  MAINTAINERS                       | 10 ++++++++++
> > >  drivers/mfd/intel-m10-bmc.c       | 25 ++++++++++++++++++-------
> > >  include/linux/mfd/intel-m10-bmc.h |  7 +++++--
> > >  3 files changed, 33 insertions(+), 9 deletions(-)
> > > 
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
