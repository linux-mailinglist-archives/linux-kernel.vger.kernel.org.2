Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E33033FFA03
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 07:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhICF3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 01:29:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:44624 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232553AbhICF32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 01:29:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="241615429"
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="241615429"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 22:28:28 -0700
X-IronPort-AV: E=Sophos;i="5.85,264,1624345200"; 
   d="scan'208";a="533716572"
Received: from xingzhen-mobl.ccr.corp.intel.com (HELO [10.238.4.90]) ([10.238.4.90])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 22:28:27 -0700
Subject: Re: [LKP] [ext4] 05c2c00f37: aim7.jobs-per-min -11.8% regression
To:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     kernel test robot <oliver.sang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        lkp@intel.com
References: <20210227120804.GB22871@xsang-OptiPlex-9020>
 <a8947cee-11f5-8d59-a3ff-1c516276592e@linux.intel.com>
 <20210520095119.GA18952@quack2.suse.cz>
 <e9f776c4-1ade-42a6-54c4-7fe3442e2392@linux.intel.com>
 <20210521092730.GE18952@quack2.suse.cz> <YKfi6Pv+qwduKxuT@mit.edu>
 <20210525092205.GA4112@quack2.suse.cz> <20210531165746.GA2610@quack2.suse.cz>
 <20210603161004.GL23647@quack2.suse.cz>
From:   Xing Zhengjun <zhengjun.xing@linux.intel.com>
Message-ID: <8ac28fce-0cfb-cc4d-1a3d-2f104ff46767@linux.intel.com>
Date:   Fri, 3 Sep 2021 13:28:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210603161004.GL23647@quack2.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

      Do you have time to look at this? I re-test it in v5.13 and v5.14, 
the regression still existed. Thanks.


On 6/4/2021 12:10 AM, Jan Kara wrote:
> Similarly to previous test, 'Orig' is the original state before 05c2c00f37,
> 'Patched' is a state after commit 05c2c00f37, 'Hack1' is 05c2c00f37 but with
> lock_buffer() calls removed from orphan handling, 'Hack2' is 05c2c00f37 with
> lock_buffer() calls removed and checksumming moved from under orphan_lock,
> 'BH orphan lock' is 05c2c00f37 with orphan_lock replaced with sb buffer
> lock.
> 
> As we can see with fixed filesystem size, the regression isn't actually
> that big anymore but it about matches what 0-day reported. Replacing orphan
> lock with superblock buffer_head lock makes things even much worse - not
> really surprising given we are replacing optimized mutex implementation
> with a bitlock. Just removing buffer lock (Hack1 test) doesn't seem to
> improve the results noticeably so that is not a problem. Moving
> checksumming out from under the orphan_lock would probably help noticeably
> (Hack2 test) but there's the problem when to compute checksums for
> nojournal mode and also we'd need to be very careful with all the other
> places updating superblock so that they serialize against orphan operations
> so that they cannot invalidate the checksum - IMO not very compelling.
> 
> So as we chatted on today's call probably the best option is to leave the
> code as is for now and instead work on moving away from orphan list
> altogether. I'll revive my patches to do that.

-- 
Zhengjun Xing
