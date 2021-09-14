Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E31140ABCA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 12:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbhINKfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 06:35:38 -0400
Received: from foss.arm.com ([217.140.110.172]:43246 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231352AbhINKff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 06:35:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BFC4F1435;
        Tue, 14 Sep 2021 03:34:17 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.21.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71C053F59C;
        Tue, 14 Sep 2021 03:34:16 -0700 (PDT)
Date:   Tue, 14 Sep 2021 11:34:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     "Chen, Rong A" <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [kbuild-all] Re:
 include/linux/atomic/atomic-arch-fallback.h:60:32: error: implicit
 declaration of function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'?
Message-ID: <20210914103413.GB29127@C02TD0UTHF1T.local>
References: <202109120418.8mal64Sj-lkp@intel.com>
 <20210913085724.GA7415@C02TD0UTHF1T.local>
 <be9ed2be-c338-cd59-7a5a-804ffa5d3064@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be9ed2be-c338-cd59-7a5a-804ffa5d3064@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 08:39:36AM +0800, Chen, Rong A wrote:
> 
> 
> On 9/13/2021 4:57 PM, Mark Rutland wrote:
> > On Sun, Sep 12, 2021 at 04:24:21AM +0800, kernel test robot wrote:
> > > Hi Mark,
> > > 
> > > FYI, the error/warning still remains.
> > 
> > As pointed out previously [1,2], this is an existing bug (in that arc
> > does not have an implementation of cmpxchg64(), but it's possible to
> > select code which uses it in test configurations). My changes to the
> > core atomic headers only change the way in which the error manifests,
> > and have nothing to do with the underlying problem.
> > 
> > I thought we were going to stop reporting this [3]?
> 
> Hi Mark,
> 
> Thanks for the feedback, we only ignored the below one:
> 
>   include/linux/atomic-arch-fallback.h:60:32: error: implicit declaration of
> function 'arch_cmpxchg64'; did you mean 'arch_cmpxchg'?
> [-Werror=implicit-function-declaration]
> 
> we'll update the pattern to ignore all.

Thanks; much appreciated! :)

Mark.
