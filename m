Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 989A73AC5CB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 10:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhFRIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 04:17:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:42471 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232163AbhFRIRn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 04:17:43 -0400
IronPort-SDR: wxHc2b2PbL2Z3eIn58pDmNasBlryz180HKPk0P5aBvqDZE8mpi3xENinUQ/Yl64w0Gz4pJ7ESd
 Xd5qEo+F+WVQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10018"; a="228041669"
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="228041669"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 01:15:20 -0700
IronPort-SDR: GhhtatfQ/voVXHKGuquDYJLyX5JoHfQQrL+zgp2nFsMIwuz0GWe1zyAUngtEuR/E2o8Vvl/Pzj
 yoY4Gispk+Nw==
X-IronPort-AV: E=Sophos;i="5.83,283,1616482800"; 
   d="scan'208";a="485604188"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2021 01:15:18 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Wei Xu <weixugc@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH -V8 04/10] mm/migrate: make migrate_pages() return
 nr_succeeded
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210618061537.434999-5-ying.huang@intel.com>
        <20210618075328.GA23470@linux>
Date:   Fri, 18 Jun 2021 16:15:15 +0800
In-Reply-To: <20210618075328.GA23470@linux> (Oscar Salvador's message of "Fri,
        18 Jun 2021 09:53:33 +0200")
Message-ID: <87pmwjpp0s.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Fri, Jun 18, 2021 at 02:15:31PM +0800, Huang Ying wrote:
>> From: Yang Shi <yang.shi@linux.alibaba.com>
>> 
>> The migrate_pages() returns the number of pages that were not migrated,
>> or an error code.  When returning an error code, there is no way to know
>> how many pages were migrated or not migrated.
>> 
>> In the following patch, migrate_pages() is used to demote pages to PMEM
>> node, we need account how many pages are reclaimed (demoted) since page
>> reclaim behavior depends on this.  Add *nr_succeeded parameter to make
>> migrate_pages() return how many pages are demoted successfully for all
>> cases.
>> 
>> Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
>> Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>> Reviewed-by: Yang Shi <shy828301@gmail.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Cc: Wei Xu <weixugc@google.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: osalvador <osalvador@suse.de>
>
> I thought we all agreed on making nr_succeed an optional argument [1].
> It reduced the churn quite a lot.
>
> [1] https://patchwork.kernel.org/comment/24104453/

Sorry.  Forget changing this.  Will change it in the next version.

Best Regards,
Huang, Ying
