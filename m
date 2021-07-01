Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46E33B95B7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 19:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhGAR51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 13:57:27 -0400
Received: from mga04.intel.com ([192.55.52.120]:41366 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229844AbhGAR5Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 13:57:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10032"; a="206763213"
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="206763213"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 10:54:54 -0700
X-IronPort-AV: E=Sophos;i="5.83,315,1616482800"; 
   d="scan'208";a="558736562"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.122.16]) ([10.209.122.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2021 10:54:54 -0700
Subject: Re: [PATCH] perf intel-pt: Add a config for max loops without
 consuming a packet
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
References: <20210701175132.3977-1-adrian.hunter@intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <aaf79640-4882-310a-e1e1-67f7818e82a0@linux.intel.com>
Date:   Thu, 1 Jul 2021 10:54:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701175132.3977-1-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/1/2021 10:51 AM, Adrian Hunter wrote:
> The Intel PT decoder limits the number of unconditional branches (e.g.
> jmps) decoded without consuming any trace packets. Generally, a loop
> needs a conditional branch which generates a TNT packet, whereas a
> "ret" instruction will generate a TIP or TNT packet. So exceeding
> the limit is assumed to be a never-ending loop, which can happen if
> there has been a decoding error putting the decoder at the wrong place in
> the code.
>
> Up until now, the limit of 10000 has been enough but some analytic
> purposes have been reported to exceed that.
>
> Increase the limit to 100000, and make it configurable via perf config
> intel-pt.max-loops. Also amend the "Never-ending loop" message to
> mention the configuration entry.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>


Thanks. That is useful.


Reviewed-by: Andi Kleen <ak@linux.intel.com>


-Andi


