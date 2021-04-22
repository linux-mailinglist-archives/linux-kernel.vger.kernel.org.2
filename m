Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 112E336881E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 22:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237073AbhDVUjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Apr 2021 16:39:19 -0400
Received: from mga06.intel.com ([134.134.136.31]:60485 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239430AbhDVUjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Apr 2021 16:39:16 -0400
IronPort-SDR: kG0OrMPbrKvduCHh/7NIuc9R07dMvuNcYAmia+r8AM5NiMzXI0bNRlaD4ziglyyEIg1bz1rzCn
 y1bamFpLXl3A==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="257277128"
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="257277128"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 13:38:40 -0700
IronPort-SDR: Isf7drjwXoRts/RJMskUjhCmW/kIFvXPPhbbUOynSgNam43cx/J09Bo2tu/28VKcm4WJXgykZ1
 q1lfJTtGTQZA==
X-IronPort-AV: E=Sophos;i="5.82,243,1613462400"; 
   d="scan'208";a="421515120"
Received: from schen9-mobl.amr.corp.intel.com ([10.254.72.4])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2021 13:38:39 -0700
Subject: Re: [RFC] mm/vmscan.c: avoid possible long latency caused by
 too_many_isolated()
To:     Yu Zhao <yuzhao@google.com>
Cc:     Xing Zhengjun <zhengjun.xing@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Huang Ying <ying.huang@intel.com>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>, wfg@mail.ustc.edu.cn
References: <20210416023536.168632-1-zhengjun.xing@linux.intel.com>
 <7b7a1c09-3d16-e199-15d2-ccea906d4a66@linux.intel.com>
 <YIGuvh70JbE1Cx4U@google.com>
 <a085478d-5118-cdff-c611-1649fce7a650@linux.intel.com>
 <CAOUHufbVmsvWQ-_PSn8CCanuJqRR6Tmj01s17WvKsc3pRa87xw@mail.gmail.com>
From:   Tim Chen <tim.c.chen@linux.intel.com>
Message-ID: <2ea3318a-b17c-ec4c-5425-cb93e079a994@linux.intel.com>
Date:   Thu, 22 Apr 2021 13:38:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAOUHufbVmsvWQ-_PSn8CCanuJqRR6Tmj01s17WvKsc3pRa87xw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/21 1:30 PM, Yu Zhao wrote:
> 
> HZ/10 is purely arbitrary but that's ok because we assume normally
> nobody hits it. If you do often, we need to figure out why and how not
> to hit it so often.
> 

Perhaps Zhengjun can test the proposed fix in his test case to see if the timeout value
makes any difference.

Tim
