Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C57B8369E67
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 03:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236561AbhDXBkn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 21:40:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:5413 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231386AbhDXBkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 21:40:40 -0400
IronPort-SDR: ie9AAaIFAxKpebDrztceUrjk0xm1lkFbkvg7dxGsUlEPKwp77MtmFj1M3b84IoumbOgyqvTmpm
 7mkJ9iFeRAfA==
X-IronPort-AV: E=McAfee;i="6200,9189,9963"; a="183639387"
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="183639387"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 18:40:02 -0700
IronPort-SDR: tGELKd+UU/Bfi7HiQx14vadwxKYsBbbKJYGetBnQbCfyGTR/+cu7A3B0qRIsx4GmxsrTvHVr6x
 f/WbX4L3Y2Tg==
X-IronPort-AV: E=Sophos;i="5.82,246,1613462400"; 
   d="scan'208";a="421950590"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.173])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2021 18:39:56 -0700
Date:   Sat, 24 Apr 2021 09:43:43 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Doug Smythies <dsmythies@telus.net>, bas@basnieuwenhuizen.nl,
        Bingsong Si <owen.si@ucloud.cn>,
        youling257 <youling257@gmail.com>
Cc:     erwanaliasr1@gmail.com, lenb@kernel.org, rjw@rjwysocki.net,
        linux-kernel@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [3/3,v3] tools/power turbostat: Enable accumulate RAPL display
Message-ID: <20210424014343.GA432544@chenyu-desktop>
References: <1f6d32e14f121a8ccf8807b8343597c3ae88c7d2.1587196252.git.yu.c.chen@intel.com>
 <20210308134957.23852-1-youling257@gmail.com>
 <CAAYoRsXec2eq=t-pSn5TOqNt0G6kfZCKkDuEhCnX5SgL0zgkBg@mail.gmail.com>
 <20210308161548.GA37664@chenyu-desktop>
 <CAAYoRsVkrHberSgM42dqYjdVwz8vumURJ1_DGeV1R5-=LMdjVA@mail.gmail.com>
 <20210312134114.GA21436@chenyu-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210312134114.GA21436@chenyu-desktop>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bas Nieuwenhuizen,
On Fri, Mar 12, 2021 at 09:41:14PM +0800, Chen Yu wrote:
> Hi Youling, Bas, and Bingsong,
> On Wed, Mar 10, 2021 at 04:03:31PM -0800, Doug Smythies wrote:
> > Hi Yu,
> > 
> > I am just resending your e-mail, adjusting the "To:" list to
> > include the 3 others that have submitted similar patches.
> > 
> > ... Doug
> > 
> Could you please help check if the following combined patch works?
> 
> Thanks,
> Chenyu
> 
> 
> From 00e0622b1b693a5c7dc343aeb3aa51614a9e125e Mon Sep 17 00:00:00 2001
> From: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Date: Fri, 12 Mar 2021 21:27:40 +0800
> Subject: [PATCH] tools/power/turbostat: Fix turbostat for AMD Zen CPUs
> 
> It was reported that on Zen+ system turbostat started exiting,
> which was tracked down to the MSR_PKG_ENERGY_STAT read failing because
> offset_to_idx wasn't returning a non-negative index.
> 
> This patch combined the modification from Bingsong Si and
> Bas Nieuwenhuizen and addd the MSR to the index system as alternative for
> MSR_PKG_ENERGY_STATUS.
> 
> Fixes: 9972d5d84d76 ("tools/power turbostat: Enable accumulate RAPL display")
> Reported-by: youling257 <youling257@gmail.com>
> Co-developed-by: Bingsong Si <owen.si@ucloud.cn>
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>
Can I add your SOB here if you are not object to it?

thanks,
Chenyu
