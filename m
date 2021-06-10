Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04EF3A21BD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 03:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhFJBHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Jun 2021 21:07:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:17980 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229557AbhFJBHP (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 9 Jun 2021 21:07:15 -0400
IronPort-SDR: 4g45bOFFpf2ukfila0IlkaaM5hWYyJhGEfsDq9y4q9SaX8AJw4CzOc0JCzby0jKBHK2fUP7RBZ
 lHL/cO2SdyiA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="269056843"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="269056843"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:05:11 -0700
IronPort-SDR: FuCH7fvRVZblQBb315e+9uLrgPuoXS33u99nMBJkUVpAdhQotEkj2u4gMBhAahgYBsU/eW123G
 FuVx4HhttYYw==
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="450144864"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.238.4.82]) ([10.238.4.82])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 18:05:00 -0700
Subject: Re: [PATCH v2] perf stat: Disable NMI watchdog message on hybrid
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com
References: <20210609050600.7308-1-yao.jin@linux.intel.com>
 <YMEj6vuPcEnCz6tr@krava>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <8faa16cf-561e-cd31-7fb2-bfad3ae27782@linux.intel.com>
Date:   Thu, 10 Jun 2021 09:04:57 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YMEj6vuPcEnCz6tr@krava>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On 6/10/2021 4:26 AM, Jiri Olsa wrote:
>> +static bool is_mixed_hybrid_group(struct evsel *counter)
>> +{
>> +	struct evlist *evlist = counter->evlist;
>> +	struct evsel *pos;
>> +
>> +	evlist__for_each_entry(evlist, pos) {
>> +		if (perf_pmu__is_hybrid(pos->pmu_name))
>> +			return true;
>> +	}
> so we care if there's at least one hybrid event in the list right?
> it can be all full with just hybrid events, but the function name
> suggests it's mixed with normal events
> 
> jirka
> 

Yes, that's right. We only care there is at least one hybrid event in the evlist.

So do we change the function name to evlist__has_hybrid_event?

Thanks
Jin Yao
