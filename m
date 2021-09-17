Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D558C40FC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 17:32:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241014AbhIQPdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 11:33:52 -0400
Received: from mga12.intel.com ([192.55.52.136]:14255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240348AbhIQPdu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 11:33:50 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10110"; a="202315945"
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="202315945"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2021 08:32:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="434145356"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 17 Sep 2021 08:32:27 -0700
Received: from [10.213.15.224] (mtkaczyk-MOBL1.ger.corp.intel.com [10.213.15.224])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id CAF19580A85;
        Fri, 17 Sep 2021 08:32:26 -0700 (PDT)
Subject: Re: [PATCH 0/2] Use MD_BROKEN for redundant arrays
From:   "Tkaczyk, Mariusz" <mariusz.tkaczyk@linux.intel.com>
To:     song@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20210917151831.3000-1-mariusz.tkaczyk@linux.intel.com>
Message-ID: <4f710209-005d-eaf0-e878-3be94427bab8@linux.intel.com>
Date:   Fri, 17 Sep 2021 17:32:24 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210917151831.3000-1-mariusz.tkaczyk@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.09.2021 17:18, Mariusz Tkaczyk wrote:
> Hi Song,
> This patchset adds usage of MD_BROKEN for each redundant level.
> This should simplify IO failure stack when md device is failed and
> fixes raid456 bug.
> 
> Mariusz Tkaczyk (2):
>    md: Set MD_BROKEN for RAID1 and RAID10
>    raid5: introduce MD_BROKEN
> 
>   drivers/md/md.c     | 16 ++++++++++------
>   drivers/md/md.h     |  4 ++--
>   drivers/md/raid1.c  |  1 +
>   drivers/md/raid10.c |  1 +
>   drivers/md/raid5.c  | 34 ++++++++++++++++------------------
>   5 files changed, 30 insertions(+), 26 deletions(-)
> 

Hi,
Please ignore it. I added wrong list.
Sorry for noise.

Thanks,
Mariusz
