Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA184400ED4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Sep 2021 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236933AbhIEJhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 05:37:39 -0400
Received: from mga12.intel.com ([192.55.52.136]:54823 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231977AbhIEJhi (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 05:37:38 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10097"; a="199295143"
X-IronPort-AV: E=Sophos;i="5.85,269,1624345200"; 
   d="scan'208";a="199295143"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2021 02:36:35 -0700
X-IronPort-AV: E=Sophos;i="5.85,269,1624345200"; 
   d="scan'208";a="535871124"
Received: from yjin15-mobl1.ccr.corp.intel.com (HELO [10.249.168.84]) ([10.249.168.84])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2021 02:36:31 -0700
Subject: Re: [PATCH v7 1/2] perf pmu: Add PMU alias support
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, ak@linux.intel.com,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        john.garry@huawei.com, Kan Liang <kan.liang@linux.intel.com>
References: <20210902065955.1299-1-yao.jin@linux.intel.com>
 <20210902065955.1299-2-yao.jin@linux.intel.com> <YTIJLyL4Ba7wuZqs@kernel.org>
 <YTIMYlsUD0cqAYUA@kernel.org>
From:   "Jin, Yao" <yao.jin@linux.intel.com>
Message-ID: <f1eae329-8561-7340-0464-e9a73aba89b1@linux.intel.com>
Date:   Sun, 5 Sep 2021 17:36:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YTIMYlsUD0cqAYUA@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

On 9/3/2021 7:52 PM, Arnaldo Carvalho de Melo wrote:
> Please take a look at my tmp.perf/core branch, it has the patch below
> and the test one plus what I'm about to push to Linus.
> 
> - Arnaldo

I've pulled tmp.perf/core branch and checked the patch. It looks good to me.

Thanks
Jin Yao
