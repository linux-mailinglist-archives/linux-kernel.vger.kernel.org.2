Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 142FF43B7CF
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 19:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237667AbhJZRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 13:05:29 -0400
Received: from mga12.intel.com ([192.55.52.136]:24684 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232003AbhJZRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 13:05:27 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="210047105"
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="210047105"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:03:03 -0700
X-IronPort-AV: E=Sophos;i="5.87,184,1631602800"; 
   d="scan'208";a="497434243"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.135.40]) ([10.212.135.40])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2021 10:03:02 -0700
Message-ID: <a37ede61-c607-4fcf-2be4-12b83cdf0d7e@linux.intel.com>
Date:   Tue, 26 Oct 2021 10:03:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH V2 3/6] perf intel-pt: Support itrace A option to
 approximate IPC
Content-Language: en-US
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20211026090152.357591-1-adrian.hunter@intel.com>
 <20211026090152.357591-4-adrian.hunter@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211026090152.357591-4-adrian.hunter@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/26/2021 2:01 AM, Adrian Hunter wrote:
> Normally, for cycle-acccurate mode, IPC values are an exact number of
> instructions and cycles. Due to the granularity of timestamps, that happens
> only when a CYC packet correlates to the event.
>
> Support the itrace 'A' option, to use instead, the number of cycles
> associated with the current timestamp. This provides IPC information for
> every change of timestamp, but at the expense of accuracy.

Can you expand a bit what exactly the accuracy loss it?

Would be good to describe that in the manpage too.

