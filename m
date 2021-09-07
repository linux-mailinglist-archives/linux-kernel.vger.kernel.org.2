Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7384023CE
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 09:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236292AbhIGHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 03:06:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:11727 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233576AbhIGHGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 03:06:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="242401926"
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="242401926"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2021 00:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,274,1624345200"; 
   d="scan'208";a="692327309"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga006.fm.intel.com with ESMTP; 07 Sep 2021 00:05:35 -0700
Subject: Re: [PATCH] perf dlfilter: Add dlfilter-show-cycles
To:     Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210906160850.22716-1-adrian.hunter@intel.com>
 <7bee95a7-fa31-a801-8068-80c63ba6ccfe@linux.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b8b1d870-9db2-4b0f-7138-c139e1ef878b@intel.com>
Date:   Tue, 7 Sep 2021 10:06:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <7bee95a7-fa31-a801-8068-80c63ba6ccfe@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/09/21 5:54 am, Andi Kleen wrote:
> 
> On 9/6/2021 9:08 AM, Adrian Hunter wrote:
>> Add a new dlfilter to show cycles.
>>
>> Cycle counts are accumulated per CPU (or per thread if CPU is not recorded)
>> from IPC information, and printed together with the change since the last
>> print, at the start of each line.
> 
> 
> Thanks! An example how to use it would be nice 

I started looking at making an example and noticed that this approach
does not work very well because the IPC cycle count only increases when
the IPC is output which (for CYC accurate mode) is only happens when a
CYC packet is output that corresponds to the current sample.  Seems like
this needs a re-think, sorry.
