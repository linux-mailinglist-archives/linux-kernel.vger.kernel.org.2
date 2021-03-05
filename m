Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0E32E0CB
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 05:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbhCEEcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 23:32:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:21080 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229674AbhCEEcL (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 23:32:11 -0500
IronPort-SDR: KZ9Cm7ZnrNgR/jBf6452FdOznIbbtAYMbjk7cI56qsRnnJIHwfEYaY/pl9RQ7nRymrx/kfx6bb
 Py6NWiGR0jKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9913"; a="207292171"
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="207292171"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 20:32:09 -0800
IronPort-SDR: DuBrP28HNVxjDYeWpoaOhrIDCiu20EKNB5NEzNuDrY78R7IMWmS5dgr7nmFKt3zUZQ3WD9EhzL
 aibMi+4DBWCA==
X-IronPort-AV: E=Sophos;i="5.81,224,1610438400"; 
   d="scan'208";a="408132738"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2021 20:32:06 -0800
Subject: Re: [PATCH] perf pmu: Validate raw event with sysfs exported format
 bits
To:     Andi Kleen <ak@linux.intel.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20210303051736.26974-1-yao.jin@linux.intel.com>
 <20210305011018.GL472138@tassilo.jf.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <65062a3c-91ae-7527-e980-83ea58a6bfe1@linux.intel.com>
Date:   Fri, 5 Mar 2021 12:32:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210305011018.GL472138@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andi,

On 3/5/2021 9:10 AM, Andi Kleen wrote:
>> Single event:
>>
>>    # ./perf stat -e cpu/r031234/ -a -- sleep 1
>>    WARNING: event config '31234' not valid (bits 16 17 not supported by kernel)!
> 
> Just noticed that again. Can you please print the original event as
> string in the message? While it's obvious with rXXX which one it is,
> it may not be obvious with offsetted fields (like umask=0x121212),
> and hard to find in a long command line.
> 
> -Andi
> 

Sometime the event name is NULL. In v2, if the event name is not NULL, I will print the event name.

Thanks
Jin Yao

