Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D11F34146F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Mar 2021 05:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233777AbhCSE5z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Mar 2021 00:57:55 -0400
Received: from mga14.intel.com ([192.55.52.115]:51209 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233743AbhCSE5V (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 19 Mar 2021 00:57:21 -0400
IronPort-SDR: wZSnQmT6vr012cPpKEXU8eND0R4ASXHu4ggBbwvoreCtlsA3VRllfxmPEtOfRoehMKL30I/urt
 eY1ffqi661sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9927"; a="189205800"
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="189205800"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 21:57:20 -0700
IronPort-SDR: gqbUnVdsks8bVbgCUK4uiSDeHHRHXd8arwFrRI3rUsmqLHd+yd1ztIrYYGgQcBm9uEfYVVH/jZ
 XHySkAYbQalw==
X-IronPort-AV: E=Sophos;i="5.81,259,1610438400"; 
   d="scan'208";a="406643616"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.6]) ([10.238.4.6])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2021 21:57:18 -0700
Subject: Re: [PATCH v2] perf stat: Align CSV output for summary mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andi Kleen <ak@linux.intel.com>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210317070205.10315-1-yao.jin@linux.intel.com>
 <YFID6MjXSc21YzE2@kernel.org> <20210317215142.GB1369306@tassilo.jf.intel.com>
 <YFNSjP4LKnixkQWq@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <db9fea9b-b84b-595f-d93b-edf15cf37de0@linux.intel.com>
Date:   Fri, 19 Mar 2021 12:57:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFNSjP4LKnixkQWq@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 3/18/2021 9:15 PM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 17, 2021 at 02:51:42PM -0700, Andi Kleen escreveu:
>>> If you care about not breaking existing scripts, then the output they
>>> get with what they use as command line options must continue to produce
>>> the same output.
>>
>> It's not clear there are any useful ones (except for tools that handle
>> both). It's really hard to parse the previous mess. It's simply not
>> valid CSV.
>>
>> That's why I'm arguing that keeping compatibility is not useful here.
>>
>> We would be stuck with the broken mess as default forever.
> 
> Fair enough, lets fix the default then. Jin, can you please consider
> adding a 'perf test' shell entry to parse the CSV mode with/without that
> summary? This way we'll notice when the new normal gets broken.
> 
> - Arnaldo
> 

Thanks Arnaldo! I will post v3 with the perf test script.

Thanks
Jin Yao

