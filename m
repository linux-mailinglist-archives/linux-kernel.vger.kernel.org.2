Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCBE737F936
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbhEMN51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 May 2021 09:57:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:50753 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234247AbhEMN5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 May 2021 09:57:10 -0400
IronPort-SDR: eCyfkbWqkK/J+JTmoUOg29SvaEtZO/NgZEvzZpB8BxfSPDZv3Mrhzen4Vq/K+43+nygKXnSole
 Z7v6+1JWJ16g==
X-IronPort-AV: E=McAfee;i="6200,9189,9982"; a="261192489"
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="261192489"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 06:55:40 -0700
IronPort-SDR: E7MsCeLURvjkO8scuNIcUFItxDAsnvhqWBHYpktm7lmYLXo6ysWw8GHdgIjK/e3A1ZeSRxH17p
 1xxoRRCsMNSQ==
X-IronPort-AV: E=Sophos;i="5.82,296,1613462400"; 
   d="scan'208";a="400995872"
Received: from bchunch-mobl.amr.corp.intel.com (HELO [10.209.17.244]) ([10.209.17.244])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2021 06:55:38 -0700
Subject: Re: [RFC PATCH 2/2] mempolicy: kill MPOL_F_LOCAL bit
To:     Feng Tang <feng.tang@intel.com>, Michal Hocko <mhocko@suse.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Widawsky, Ben" <ben.widawsky@intel.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Williams, Dan J" <dan.j.williams@intel.com>, ying.huang@intel.com
References: <1615952410-36895-1-git-send-email-feng.tang@intel.com>
 <1615952410-36895-4-git-send-email-feng.tang@intel.com>
 <YHblLevoUZ6+AvVZ@dhcp22.suse.cz>
 <20210420071625.GB48282@shbuild999.sh.intel.com>
 <20210513072545.GC44993@shbuild999.sh.intel.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <8e1cf4dd-1bb2-fbcb-4960-65db8704ec38@linux.intel.com>
Date:   Thu, 13 May 2021 06:55:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210513072545.GC44993@shbuild999.sh.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/13/2021 12:25 AM, Feng Tang wrote:
> mempolicy: kill MPOL_F_LOCAL bit
>
> Now the only remaining case of actual 'local' policy faked by
> 'prefer' policy plus MPOL_F_LOCAL bit is:
>
> A valid 'prefer' policy with a valid 'preferred' node is 'rebind'
> to a nodemask which doesn't contains the 'preferred' node, then it
> will handle allocation with 'local' policy.
>
> Add a new 'MPOL_F_LOCAL_TEMP' bit for this case, and kill the
> MPOL_F_LOCAL bit, which could simplify the code much.

Reviewed-by: Andi Kleen <ak@linux.intel.com>


-Andi

