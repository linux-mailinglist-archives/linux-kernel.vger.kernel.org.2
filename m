Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9CC3BC4C0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 04:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhGFCbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 22:31:18 -0400
Received: from mga11.intel.com ([192.55.52.93]:12947 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229774AbhGFCbQ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 22:31:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10036"; a="206035224"
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; 
   d="scan'208";a="206035224"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 19:27:58 -0700
X-IronPort-AV: E=Sophos;i="5.83,327,1616482800"; 
   d="scan'208";a="456898986"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.147]) ([10.238.4.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 19:27:55 -0700
Subject: Re: [PATCH] perf list: Skip the invalid hybrid pmu
To:     Andi Kleen <ak@linux.intel.com>, acme@kernel.org, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20210610051646.4003-1-yao.jin@linux.intel.com>
 <77380298-b3d5-d165-c8d4-a24b22d15b0c@linux.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f96534e5-4a5c-f6da-4574-16f64f291834@linux.intel.com>
Date:   Tue, 6 Jul 2021 10:27:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <77380298-b3d5-d165-c8d4-a24b22d15b0c@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo, hi Jiri,

On 6/17/2021 12:37 AM, Andi Kleen wrote:
> 
> On 6/9/2021 10:16 PM, Jin Yao wrote:
>> On hybrid platform, such as Alderlake, if atom CPUs are offlined,
>> the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
>> 'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
>> which indicates this is an invalid pmu.
> 
> 
> The patch looks good, but it would probably make sense to fix the kernel to avoid this too.
> 
> Of course the tools patch would still be needed for older kernels.
> 
> -Andi
> 
> 

Any comments for this patch?

Thanks
Jin Yao
