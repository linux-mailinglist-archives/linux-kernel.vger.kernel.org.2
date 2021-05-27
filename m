Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7CD3935E4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 21:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236942AbhE0TEC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 15:04:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:52731 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236934AbhE0TD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 15:03:27 -0400
IronPort-SDR: cVTjymvlmxZiFNZYIT6oaInAMzy3iohtx1p6wg2cfoVR8bcBLoxylOmsfEx2XWVX0cu8mBtlAo
 DvEvf3DnQbhg==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="190183293"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="190183293"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 12:01:24 -0700
IronPort-SDR: hIC7PXPO7MWKRMWUsJ4NNFkVDWx77kRMBHUjw5SdKspD43X+bDu5wBWg39NQQtWPtHJoAfykch
 UB+OX7CUvC6g==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="415021225"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.135.183]) ([10.252.135.183])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 12:01:23 -0700
Subject: Re: [clocksource] 8901ecc231: stress-ng.lockbus.ops_per_sec -9.5%
 regression
To:     paulmck@kernel.org, Feng Tang <feng.tang@intel.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        John Stultz <john.stultz@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Chris Mason <clm@fb.com>, LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        lkp@lists.01.org, lkp@intel.com, ying.huang@intel.com,
        zhengjun.xing@intel.com
References: <20210521083322.GG25531@xsang-OptiPlex-9020>
 <20210521135617.GT4441@paulmck-ThinkPad-P17-Gen-1>
 <20210522160827.GA2625834@paulmck-ThinkPad-P17-Gen-1>
 <20210526064922.GD5262@shbuild999.sh.intel.com>
 <20210526134911.GB4441@paulmck-ThinkPad-P17-Gen-1>
 <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <138f81df-08e1-f96e-1915-c58b44f96a41@linux.intel.com>
Date:   Thu, 27 May 2021 12:01:23 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527182959.GA437082@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>      
>      Nevertheless, it is quite possible that real-world use will result in
>      some situation requiring that high-stress workloads run on hardware
>      not designed to accommodate them, and also requiring that the kernel
>      refrain from marking clocksources unstable.
>      
>      Therefore, provide an out-of-tree patch that reacts to this situation


out-of-tree means it will not be submitted?


I think it would make sense upstream, but perhaps guarded with some option.

