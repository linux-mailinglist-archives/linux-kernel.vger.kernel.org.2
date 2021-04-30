Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA636F542
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 07:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbhD3FCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 01:02:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:10142 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229482AbhD3FCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 01:02:40 -0400
IronPort-SDR: A+siUOGVQpbMjKglJ/t4NVdS5/Si9in+hmBCwLo7PSROHmXF/TzbCg5Is85L7rG+4eglrb4l9u
 FiCWQTEIadTA==
X-IronPort-AV: E=McAfee;i="6200,9189,9969"; a="217934702"
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="217934702"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2021 22:01:52 -0700
IronPort-SDR: wUIRniA64jIADyg/rCjhKBZNXOM9hjBMqSwKkbQa6qoj0/E19wn6V0fgjmHAQtweLmaNMtvg44
 TgWTXR1cRBxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,260,1613462400"; 
   d="scan'208";a="448779234"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.174]) ([10.237.72.174])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2021 22:01:51 -0700
Subject: Re: [PATCH 11/12] perf intel-pt: Add VM Time Correlation to decoder
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210429125854.13905-1-adrian.hunter@intel.com>
 <20210429125854.13905-12-adrian.hunter@intel.com>
 <20210429212140.GE4032392@tassilo.jf.intel.com>
From:   Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4f9b20f7-566b-9e32-e9b9-bf6d11ef5d9f@intel.com>
Date:   Fri, 30 Apr 2021 08:02:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210429212140.GE4032392@tassilo.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/21 12:21 am, Andi Kleen wrote:
>> unchanging (during perf record) VMX TSC Offset and no VMX TSC scaling.
> 
> For TSC scaling we would need to add side band to KVM, correct?
> 
> I suppose it shouldn't be that hard to do that.
> 

Probably we just need to know a single TSC scaling value per VM i.e. it could just be exported via sysfs or something.

There is a reasonable reason that TSC Offset might be changing i.e. to match Guest time, although that seems to be done by paravirtualization instead at the moment.
At the moment TSC Offset does change if Host time changes e.g. Guest has state saved before a Host reboot, and is resumed after the Host reboot

However, I can't think of a reason for changing the TSC Scaling value, except maybe if the VM is taken to a Host with a different TSC frequency.
