Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 422EE39BD1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 18:29:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFDQau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 12:30:50 -0400
Received: from mga05.intel.com ([192.55.52.43]:60029 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhFDQ3L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 12:29:11 -0400
IronPort-SDR: HQPSdYY6ielJUybZDujJC1d+lA7A2yAYLuEFDv6YIjsdm+u7VIEbqMY/byWu8hJTAoY2yDPXwI
 zM0u6b+uQHew==
X-IronPort-AV: E=McAfee;i="6200,9189,10005"; a="289953185"
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="289953185"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:27:23 -0700
IronPort-SDR: BW2+P8Wo6ULA0iVGdfvzfBsKWrNyo40KZEIBt1Zlns/dvFFGU6O4SnQia6UMshnbKn/UBGOoQ4
 4qAXgg+VZgSw==
X-IronPort-AV: E=Sophos;i="5.83,248,1616482800"; 
   d="scan'208";a="480698369"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.251.138.169]) ([10.251.138.169])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2021 09:27:22 -0700
Subject: Re: [patch 0/8] x86/fpu: Mop up XSAVES and related damage
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20210602095543.149814064@linutronix.de>
 <9c5c90bf-fbf6-7e45-4668-2f40f11e8b36@intel.com>
 <87h7idzpwh.ffs@nanos.tec.linutronix.de>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <149a2760-48f5-25ef-30f4-d5d1135b531e@intel.com>
Date:   Fri, 4 Jun 2021 09:27:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <87h7idzpwh.ffs@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/4/2021 7:05 AM, Thomas Gleixner wrote:
> On Wed, Jun 02 2021 at 14:28, Yu-cheng Yu wrote:
>> On 6/2/2021 2:55 AM, Thomas Gleixner wrote:
>>
>> With the series applied, glibc pkey test fails sometimes.  I will try to
>> find out the cause.
> 
> That fails not sometimes. It fails always due to patch 7/8. The reason
> is that before that patch fpu__clear_all() reinitialized the hardware
> which includes writing the initial PKRU value.
> 
> But fpu__initialize() does not store the initial PKRU value in the
> task's xstate which breaks PKRU. As that patch is not urgent we can
> postpone it for not.
> 
> But looking at the above, it's not clear to me why that PKRU stuff works
> at all (upstream), but I'll figure it out eventually. I'm quite sure
> that it does work by pure chance not by design.
>

Thanks for the update.  I will continue looking at it.

Yu-cheng
