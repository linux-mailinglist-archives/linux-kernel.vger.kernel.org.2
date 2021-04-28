Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D23E236D395
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 10:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhD1ICH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 04:02:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:2994 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229643AbhD1ICC (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 04:02:02 -0400
IronPort-SDR: 1h0MR11JJnojNPVkEJ1xtRs6pjlmdtGD0x/jHKNpVKGmwiPois0unXiKJantjtes6CtSB9gzfp
 4yH3uL0yiU4w==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="184168194"
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="184168194"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:01:17 -0700
IronPort-SDR: n7Eo182/TnShLjZxtDnjjrG9AgDCpk4aDAD1g280RxjFVf/HDeNmEI2zjaGAe+1LLtEPPwnduG
 EFnV9fhGMhlg==
X-IronPort-AV: E=Sophos;i="5.82,257,1613462400"; 
   d="scan'208";a="430184758"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2021 01:01:13 -0700
Subject: Re: [PATCH v6 00/26] perf tool: AlderLake hybrid support series 1
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210427070139.25256-1-yao.jin@linux.intel.com>
 <YIgIiZVxOWdYTwef@krava>
 <d5309468-d6d6-ab8d-2f06-22b4f6e98917@linux.intel.com>
 <YIkOn9ZaTv87Kmjw@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <d5d346c7-3a1e-bbb9-3aa4-e2e57c3c648b@linux.intel.com>
Date:   Wed, 28 Apr 2021 16:01:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YIkOn9ZaTv87Kmjw@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 4/28/2021 3:28 PM, Jiri Olsa wrote:
> I can't test the functionality, but apart from that all seems fine
> and non-hybrid stuff keeps working;-)
> 
> Reviewed-by: Jiri Olsa<jolsa@kernel.org>
> 
> thanks,
> jirka

Thanks so much for your review! It's really very helpful for improving the patchset quality, thanks!

I'm now preparing follow-up patchsets, which are to support the hybrid PMU topology 
header/perf-c2c/perf-mem/topdown/metrics.

For simplicity and easy to review, I will post them one by one.

Thanks
Jin Yao

