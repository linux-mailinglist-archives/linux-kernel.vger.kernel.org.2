Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8DD73FDE47
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 17:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245608AbhIAPNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 11:13:52 -0400
Received: from mga01.intel.com ([192.55.52.88]:50231 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231807AbhIAPNv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 11:13:51 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10094"; a="241048314"
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="241048314"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2021 08:12:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,369,1620716400"; 
   d="scan'208";a="541844834"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.54.74.11])
  by fmsmga002.fm.intel.com with ESMTP; 01 Sep 2021 08:12:25 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 091F8301C52; Wed,  1 Sep 2021 08:12:25 -0700 (PDT)
From:   Andi Kleen <ak@linux.intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Michal Koutn?? <mkoutny@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andi.kleen@intel.com, kernel test robot <oliver.sang@intel.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@suse.com>,
        Shakeel Butt <shakeelb@google.com>,
        Balbir Singh <bsingharora@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang\, Ying" <ying.huang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Subject: Re: [mm] 2d146aa3aa: vm-scalability.throughput -36.4% regression
References: <CAHk-=wiSHHSuSQsCCLOxQA+cbcvjmEeMsTCMWPT1sFVngd9-ig@mail.gmail.com>
        <20210812031910.GA63920@shbuild999.sh.intel.com>
        <20210816032855.GB72770@shbuild999.sh.intel.com>
        <YRrbpRsvdDoom9iG@cmpxchg.org>
        <20210817024500.GC72770@shbuild999.sh.intel.com>
        <20210817164737.GA23342@blackbody.suse.cz>
        <20210818023004.GA17956@shbuild999.sh.intel.com>
        <YSzwWIeapkzNElwV@blackbook>
        <20210831063036.GA46357@shbuild999.sh.intel.com>
        <20210831092304.GA17119@blackbody.suse.cz>
        <20210901045032.GA21937@shbuild999.sh.intel.com>
Date:   Wed, 01 Sep 2021 08:12:24 -0700
In-Reply-To: <20210901045032.GA21937@shbuild999.sh.intel.com> (Feng Tang's
        message of "Wed, 1 Sep 2021 12:50:32 +0800")
Message-ID: <877dg0wcrr.fsf@linux.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:
>
> Yes, the tests I did is no matter where the 128B padding is added, the
> performance can be restored and even improved.

I wonder if we can find some cold, rarely accessed, data to put into the
padding to not waste it. Perhaps some name strings? Or the destroy
support, which doesn't sound like its commonly used.

-Andi
