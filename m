Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAB9936EE0E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237212AbhD2QXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 12:23:21 -0400
Received: from mga01.intel.com ([192.55.52.88]:47179 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233622AbhD2QXU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 12:23:20 -0400
IronPort-SDR: hX07j0mMjyj3BpL+05bfImCqawop9hHudgluc6H2BPhWkEX5HHWBA8FpBLdnnh612CLv6khFNH
 dIhyON+ad7Ag==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="217777438"
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="217777438"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 09:22:33 -0700
IronPort-SDR: D7BFJIf6n3VEatCpvvMZ/mRomPmaiNQWbwIB1f7qkOoLMXg4I7v0NBfmNoVAKqVVV8s+KcQEON
 qjpg2g4d7pKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,259,1613462400"; 
   d="scan'208";a="430920493"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by orsmga008.jf.intel.com with ESMTP; 29 Apr 2021 09:22:31 -0700
Subject: Re: [PATCH 04/12] perf inject: Add facility to do in place update
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210429125854.13905-1-adrian.hunter@intel.com>
 <20210429125854.13905-5-adrian.hunter@intel.com>
 <20210429160003.GC4032392@tassilo.jf.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <25d110ca-7fe4-c8be-f3f3-fdfeaa04cbed@intel.com>
Date:   Thu, 29 Apr 2021 19:22:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429160003.GC4032392@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/21 7:00 pm, Andi Kleen wrote:
>> +		if (!data.force && !inject.in_place_update_dry_run) {
>> +			char reply[10];
>> +
>> +			printf("The input file will be updated in place. OK? (y/n) ");
>> +			if (!fgets(reply, sizeof(reply), stdin) || strcmp(reply, "y\n")) {
> 
> Interactive questions could break lots of scripting.
> 
> Just error out in this case and require the option.
> 

If it is used with --force (or -f) then there is no prompt.
