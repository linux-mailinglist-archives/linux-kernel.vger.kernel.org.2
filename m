Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D1BF33E655
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 02:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhCQBkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 21:40:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:41077 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229708AbhCQBkE (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 21:40:04 -0400
IronPort-SDR: J0Fwl6I6MACF0ypZmmOx5t/58kyBJ9IdSOp/0BSbDWuDqV6SQuHbYWHBBd0roN+Utf/jz0oNTY
 PatkTTkAgyuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="186007936"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="186007936"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 18:40:04 -0700
IronPort-SDR: GkWkWCIONHSCdtAuLY+8mHQ14PCFEDSwCkg+Em9obOvLwfZf62nLWYl73hz9G0nPVphp9GGSVJ
 3OpXTyUQo7yQ==
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="412450753"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 18:40:01 -0700
Subject: Re: [PATCH] perf stat: Align CSV output for summary mode
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210316072900.1739-1-yao.jin@linux.intel.com>
 <YFCtfXlaKbIeEMwk@krava> <20210316163421.GQ203350@tassilo.jf.intel.com>
 <YFEBaVNDokSVW/34@kernel.org> <20210316200220.GS203350@tassilo.jf.intel.com>
 <YFEpQs4TnnxPPznF@krava>
 <ea1afc3b-0617-5b21-d0b1-9fd77bbcf0d1@linux.intel.com>
 <20210317013028.GT203350@tassilo.jf.intel.com>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <6117aa2a-293a-e7e9-a821-2d759697c551@linux.intel.com>
Date:   Wed, 17 Mar 2021 09:39:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210317013028.GT203350@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/2021 9:30 AM, Andi Kleen wrote:
>> Is it serious or just a joke? :)
> 
> I would prefer to not be compatible (at least not until someone complains),
> but if compatibility is required then yes opting in to the broken
> format would be better. Perhaps not with that name.
> 
> And the option could be hidden in the perf config file instead
> of being on the command line.
> 
> -Andi
> 

That makes sense, thanks Andi!

Thanks
Jin Yao
