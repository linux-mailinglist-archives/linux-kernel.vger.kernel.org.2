Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81A5C393ACC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 02:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhE1BAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 21:00:30 -0400
Received: from mga03.intel.com ([134.134.136.65]:39044 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229843AbhE1BA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 21:00:29 -0400
IronPort-SDR: rNCe4A8iK7RZ4oT2apTMCInuEXrE1rUi1dVa//cTZgNZziny9yQTCkztPrb+1gRHkhk/JwiNef
 H3EosxDRd7Gw==
X-IronPort-AV: E=McAfee;i="6200,9189,9997"; a="202904457"
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="202904457"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:58:55 -0700
IronPort-SDR: izcikGdFV1LtOs5sI0F18rj7l/4fqxxuLlLpDvbMi4KFrDxpo7zWFQa6qg/K8Vw5qIW8Q7abjz
 sX7BWllJUXpA==
X-IronPort-AV: E=Sophos;i="5.83,228,1616482800"; 
   d="scan'208";a="548379223"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.252.135.183]) ([10.252.135.183])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2021 17:58:53 -0700
Subject: Re: [clocksource] 8901ecc231: stress-ng.lockbus.ops_per_sec -9.5%
 regression
To:     paulmck@kernel.org, Matthew Wilcox <willy@infradead.org>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <oliver.sang@intel.com>,
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
 <138f81df-08e1-f96e-1915-c58b44f96a41@linux.intel.com>
 <20210527191923.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <YK/zHMPSZSKrmXC6@casper.infradead.org>
 <20210527210524.GE4397@paulmck-ThinkPad-P17-Gen-1>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <7bda8e6a-2179-b431-973b-d074cd8d93db@linux.intel.com>
Date:   Thu, 27 May 2021 17:58:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210527210524.GE4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Only those cloud provides making heavy use of the aforementioned "poorly
> designed" hardware, correct?

If any such hardware is deployed in non homeopathic quantities, we 
probably need to support it out of the box. So far I'm not seeing any 
evidence that it does not.

That would argue for including the patch in the patch series.

Especially since stress-ng is somewhat popular for system testing.



