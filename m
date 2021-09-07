Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F70402258
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 05:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhIGCzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 22:55:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:22295 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229454AbhIGCzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 22:55:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="220137717"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="220137717"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 19:54:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="469019702"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.106.5]) ([10.209.106.5])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 19:54:09 -0700
Subject: Re: [PATCH] perf dlfilter: Add dlfilter-show-cycles
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210906160850.22716-1-adrian.hunter@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <7bee95a7-fa31-a801-8068-80c63ba6ccfe@linux.intel.com>
Date:   Mon, 6 Sep 2021 19:54:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210906160850.22716-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/6/2021 9:08 AM, Adrian Hunter wrote:
> Add a new dlfilter to show cycles.
>
> Cycle counts are accumulated per CPU (or per thread if CPU is not recorded)
> from IPC information, and printed together with the change since the last
> print, at the start of each line.


Thanks! An example how to use it would be nice (but maybe Arnaldo will 
just add that with his usual testing comment). And I guess the linear 
search could be a problem at some point, but I guess it's good enough 
for now.

Reviewed-by: Andi Kleen <ak@linux.intel.com>


