Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CCC3AA17F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 18:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbhFPQkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 12:40:12 -0400
Received: from mga07.intel.com ([134.134.136.100]:60374 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229693AbhFPQkF (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 12:40:05 -0400
IronPort-SDR: 0LJkyUWwsIUyDnZqm8XLzTrWNSaYU4o1bhWbTdLjlF0fJExSFZzLv85EgzDxqG2fV3V/4/PaMe
 Oim7RIHiFtSg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="270062752"
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="270062752"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 09:37:52 -0700
IronPort-SDR: 3tuiW0suDf8PSG0katMJfGxBKUH/unKXo7FzyA5EIBu+tXv9TwSXN87cNLN1Wp35EQZnrydkaL
 t4q1rq2rzigQ==
X-IronPort-AV: E=Sophos;i="5.83,278,1616482800"; 
   d="scan'208";a="450686398"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.90.123]) ([10.209.90.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2021 09:37:52 -0700
Subject: Re: [PATCH] perf list: Skip the invalid hybrid pmu
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, kan.liang@intel.com,
        yao.jin@intel.com
References: <20210610051646.4003-1-yao.jin@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <77380298-b3d5-d165-c8d4-a24b22d15b0c@linux.intel.com>
Date:   Wed, 16 Jun 2021 09:37:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610051646.4003-1-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/2021 10:16 PM, Jin Yao wrote:
> On hybrid platform, such as Alderlake, if atom CPUs are offlined,
> the kernel still exports the sysfs path '/sys/devices/cpu_atom/' for
> 'cpu_atom' pmu but the file '/sys/devices/cpu_atom/cpus' is empty,
> which indicates this is an invalid pmu.


The patch looks good, but it would probably make sense to fix the kernel 
to avoid this too.

Of course the tools patch would still be needed for older kernels.

-Andi


