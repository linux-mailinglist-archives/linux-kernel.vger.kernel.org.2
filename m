Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610CD3B65B5
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 17:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238125AbhF1PeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 11:34:10 -0400
Received: from mga12.intel.com ([192.55.52.136]:24075 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236583AbhF1PLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:11:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="187657388"
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="187657388"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 08:00:05 -0700
X-IronPort-AV: E=Sophos;i="5.83,306,1616482800"; 
   d="scan'208";a="643361063"
Received: from ngminuti-mobl.amr.corp.intel.com (HELO [10.212.174.12]) ([10.212.174.12])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2021 08:00:05 -0700
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     Greg KH <greg@kroah.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
 <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
 <YNXqXwq1+o09eHox@kroah.com>
 <e670abe2-67b9-a602-410a-0c4170796ec7@linux.intel.com>
 <YNhauAgaUxMfTa+c@kroah.com>
 <bdeb80ea-99dd-d9ea-d508-9cb8d2c6fbf4@linux.intel.com>
 <YNlyYJIl5yki0Q+3@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <ac22e112-7748-e47b-c08d-948ffde130bc@linux.intel.com>
Date:   Mon, 28 Jun 2021 08:00:05 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNlyYJIl5yki0Q+3@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/27/2021 11:55 PM, Greg KH wrote:
> On Sun, Jun 27, 2021 at 09:30:53AM -0700, Andi Kleen wrote:
>>> Then do not break things by renaming the device name, as you all have
>>> now stated that this name is part of the user/kernel api.
>> The renaming comes from the fallback mode on future systems. In the fallback
>> mode the driver doesn't know the true name, so it has to use  the numeric
>> name. If you don't use the fallback mode and have the full driver then yes
>> you'll get the same names as always (or at least as they make sense for the
>> hardware).
>>
>> But we would like to have the fallback mode too to allow more people use
>> uncore monitoring, and that's where the need to for the second name comes
>> in.
> So then just always use the "fallback" name if that is going to be the
> name you have for this hardware device.  Why would you want it to be
> renamed later on to a "fancier" name if there is only going to be
> one-per-chipset-type anyway?

It's an ugly numeric name, difficult to use

perf stat -e uncore_0_2//

instead of

perf stat -e uncore_cha//

It wouldn't exactly be an improvement for the full driver.

-Andi

