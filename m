Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5B53B4577
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231736AbhFYOYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:24:32 -0400
Received: from mga12.intel.com ([192.55.52.136]:32450 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230270AbhFYOYb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:24:31 -0400
IronPort-SDR: Up3nZCynybgOdz0y/5K/MzqSpaBnWIJWPGftGThoAM79or07JmFFmgt9VH0bTcletRWVD/WC38
 Az0dyybJNXWg==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="187366147"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="187366147"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:22:10 -0700
IronPort-SDR: BsNR9vog7CvaxPMKyA/Yr4txTnlH7feyXLogq0BFq1uLiFi2fDbz8jt5lIsKmlv2jajTpyPZjM
 it/9TIObjQOw==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="488201668"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.62.195]) ([10.209.62.195])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:22:09 -0700
Subject: Re: [PATCH 2/7] perf: Create a symlink for a PMU
To:     Greg KH <greg@kroah.com>
Cc:     kan.liang@linux.intel.com, peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, eranian@google.com,
        namhyung@kernel.org, acme@kernel.org, jolsa@redhat.com
References: <1624497729-158864-1-git-send-email-kan.liang@linux.intel.com>
 <1624497729-158864-3-git-send-email-kan.liang@linux.intel.com>
 <YNQckpOuw80uCUa1@kroah.com>
 <d25a0556-325f-9af0-a495-b9f222d63e10@linux.intel.com>
 <YNSWtCSjJy8CytOL@kroah.com>
 <1e536604-cf93-0f09-401e-2073924c5582@linux.intel.com>
 <YNSlVPcjHInk4un6@kroah.com>
 <29d5f315-578f-103c-9523-ae890e29c7e7@linux.intel.com>
 <YNVneO6exCS4ETRt@kroah.com>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <540d8a38-da12-56c8-8306-8d3d61ae1d6b@linux.intel.com>
Date:   Fri, 25 Jun 2021 07:22:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNVneO6exCS4ETRt@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/24/2021 10:19 PM, Greg KH wrote:
> On Thu, Jun 24, 2021 at 10:28:36AM -0700, Andi Kleen wrote:
>>> But a driver does not caer.  And if perf does not care, who cares?
>> The users who write scripts that specify the perf events on the perf command
>> line.
> Great, then as you have deemed the device name part of your documented
> api, then keep it stable as that is what you decided to do a long time
> ago when it was created.

The fully supported driver keeps it stable, but the driver in fallback 
mode (as in running on a yet unknown system) can't because it doesn't 
have enough information. It has to fall back to the numeric identifiers.

Supporting yet unknown systems is a big advantage, missing full kernel 
support is the number one reason people can't use uncore monitoring today.

The symlink keeps some degree of compatibility between the two.

Anyways thinking about it if Greg doesn't want symlinks (even though 
sysfs already has symlinks elsewhere), maybe we could just create two 
devices without symlinks. Kan, do you think that would work?

-Andi

