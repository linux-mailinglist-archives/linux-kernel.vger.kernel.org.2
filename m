Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D26F3B1140
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Jun 2021 03:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhFWBOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 21:14:41 -0400
Received: from mga09.intel.com ([134.134.136.24]:63454 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229751AbhFWBOj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 21:14:39 -0400
IronPort-SDR: bQWZQOZF+/4bMzFSjNNaQez1fB5OlCuwMQLaAGmF3/uE/7zuGrzzR3Zv4eWHib3mgtaf+yQmJH
 f5G+FvbHWxqA==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="207110997"
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="207110997"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 18:12:21 -0700
IronPort-SDR: vtYkuSiAThcHiNIx9s9RAHtCiVp8T1TspE+VJeUrPcouWD6lcj/N9whvLroNmcT3YTz+CAgB9b
 IlYrUC+cQ6CA==
X-IronPort-AV: E=Sophos;i="5.83,293,1616482800"; 
   d="scan'208";a="487115207"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.159.119])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 18:12:17 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        yang.shi@linux.alibaba.com, rientjes@google.com,
        dan.j.williams@intel.com, david@redhat.com, weixugc@google.com,
        Michal Hocko <mhocko@suse.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [PATCH -V8 00/10] Migrate Pages in lieu of discard
References: <20210618061537.434999-1-ying.huang@intel.com>
        <20210622090033.GA11045@linux>
Date:   Wed, 23 Jun 2021 09:12:14 +0800
In-Reply-To: <20210622090033.GA11045@linux> (Oscar Salvador's message of "Tue,
        22 Jun 2021 11:00:38 +0200")
Message-ID: <87sg19jsep.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Oscar Salvador <osalvador@suse.de> writes:

> On Fri, Jun 18, 2021 at 02:15:27PM +0800, Huang Ying wrote:
>> The full series is also available here:
>> 
>> 	https://github.com/hying-caritas/linux/tree/automigrate-20210618
>> 
>> The changes since the last post are as follows,
>> 
>>  * Change the page allocation flags per Michal's comments.
>>  * Change the user interface to enable the feature.
>
> Hi Huang Ying,
>
> I would suggest going back to [1] and revisit the feedback provided in v7,
> as it seemed you ignored (probably not intentionally) some of the provided
> comments.

Hi, Oscar,

I am really sorry about that.  It's my fault forgetting reviewing all
comments for v7.  All your comments are valuable for me, it's not my
intention to ignore them.  I will be more careful in the future.  Thanks
a lot for your reminding.

Best Regards,
Huang, Ying
