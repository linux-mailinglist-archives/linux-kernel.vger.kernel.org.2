Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85EA36DBA2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbhD1P2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:28:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:2893 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229890AbhD1P2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:28:43 -0400
IronPort-SDR: lBaNVByv1EdhK4rWg/WoN5iS2JUjTREr9FrY+g1EUP6A7yQ48/8q0xg9Jt1XpHib+xhIi/3vPs
 7W1A8YHISBeA==
X-IronPort-AV: E=McAfee;i="6200,9189,9968"; a="176246352"
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="176246352"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 08:27:51 -0700
IronPort-SDR: S9Sico2+xdjLqJbZr8Rrxja1peIv+AHCGNigg/J9F/+P7epHYuQ2uWp+UVdqVxCv2pHJBUw1Tf
 VO7oj+gq6UzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,258,1613462400"; 
   d="scan'208";a="430353047"
Received: from pl-dbox.sh.intel.com (HELO pl-dbox) ([10.239.159.39])
  by orsmga008.jf.intel.com with ESMTP; 28 Apr 2021 08:27:48 -0700
Date:   Wed, 28 Apr 2021 23:23:39 +0800
From:   Philip Li <philip.li@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Feng Tang <feng.tang@intel.com>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>,
        "zhengjun.xing@intel.com" <zhengjun.xing@intel.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [LKP] Re: [genirq]  cbe16f35be:  will-it-scale.per_thread_ops
 -5.2% regression
Message-ID: <20210428152339.GA2282261@pl-dbox>
References: <20210427090013.GG32408@xsang-OptiPlex-9020>
 <87fszcnecr.ffs@nanos.tec.linutronix.de>
 <20210428050758.GB52098@shbuild999.sh.intel.com>
 <d392cc91241641df865217d82368eba8@hisilicon.com>
 <20210428080819.GB53821@shbuild999.sh.intel.com>
 <87o8dyn5xr.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8dyn5xr.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 28, 2021 at 10:56:16AM +0200, Thomas Gleixner wrote:
> On Wed, Apr 28 2021 at 16:08, Feng Tang wrote:
> > On Wed, Apr 28, 2021 at 07:01:35AM +0000, Song Bao Hua (Barry Song) wrote:
> >
> >> But it is still an irrelevant problem.
> > Yes, the commit itself has no problem. And my personal thought
> > is no further action is needed. 
> 
> The commit does not need any further action, but this testing stuff
Sorry Thomas for confusion and trouble caused by this. We will take it
seriously to refine the report process for this category (alignment or
cache behavior) of performance change, to avoid meaningless ones.

Thanks

> really needs further action because we can't differentiate between real
> regressions and these bogus reports anymore.
> 
> Thanks,
> 
>         tglx
> _______________________________________________
> LKP mailing list -- lkp@lists.01.org
> To unsubscribe send an email to lkp-leave@lists.01.org
