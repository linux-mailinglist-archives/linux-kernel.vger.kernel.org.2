Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9D63E92A1
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 15:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhHKN2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 09:28:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:47024 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231546AbhHKN2O (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 09:28:14 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10072"; a="213268141"
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="213268141"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:27:48 -0700
X-IronPort-AV: E=Sophos;i="5.84,313,1620716400"; 
   d="scan'208";a="469402094"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.58.25]) ([10.209.58.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2021 06:27:37 -0700
Subject: Re: [PATCH v4 1/2] perf pmu: Add PMU alias support
To:     Jin Yao <yao.jin@linux.intel.com>, acme@kernel.org,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com
Cc:     Linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com, rickyman7@gmail.com,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210811024827.9483-1-yao.jin@linux.intel.com>
 <20210811024827.9483-2-yao.jin@linux.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <1d9d2f4e-ed7e-e770-066d-ef53ec31b42d@linux.intel.com>
Date:   Wed, 11 Aug 2021 06:27:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811024827.9483-2-yao.jin@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> +
> +	dir = opendir(path);
> +	if (!dir)
> +		return -1;


Could we cache/check the opendir result through file_available too?


The rest looks good


Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi

