Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911453E9DA8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 06:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbhHLEjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 00:39:39 -0400
Received: from mga02.intel.com ([134.134.136.20]:45052 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233944AbhHLEjg (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 00:39:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="202463615"
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="202463615"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:39:10 -0700
X-IronPort-AV: E=Sophos;i="5.84,314,1620716400"; 
   d="scan'208";a="517294469"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.174.184]) ([10.249.174.184])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 21:39:06 -0700
Subject: Re: [PATCH v4 1/2] perf pmu: Add PMU alias support
To:     Andi Kleen <ak@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210811024827.9483-1-yao.jin@linux.intel.com>
 <20210811024827.9483-2-yao.jin@linux.intel.com>
 <1d9d2f4e-ed7e-e770-066d-ef53ec31b42d@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <a374557e-4347-9d27-84a5-17d22b47650f@linux.intel.com>
Date:   Thu, 12 Aug 2021 12:39:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <1d9d2f4e-ed7e-e770-066d-ef53ec31b42d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/11/2021 9:27 PM, Andi Kleen wrote:
> 
>> +
>> +    dir = opendir(path);
>> +    if (!dir)
>> +        return -1;
> 
> 
> Could we cache/check the opendir result through file_available too?
> 
> 
> The rest looks good
> 
> 
> Reviewed-by: Andi Kleen <ak@linux.intel.com>
> 
> -Andi

Thanks Andi! Let me check how to do it.

Thanks
Jin Yao
