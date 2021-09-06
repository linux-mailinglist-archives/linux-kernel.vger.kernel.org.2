Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC654019E1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 12:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242066AbhIFKci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 06:32:38 -0400
Received: from foss.arm.com ([217.140.110.172]:54656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232527AbhIFKcb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 06:32:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CFD276D;
        Mon,  6 Sep 2021 03:31:26 -0700 (PDT)
Received: from [10.57.92.222] (unknown [10.57.92.222])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9310B3F73D;
        Mon,  6 Sep 2021 03:31:25 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] coresight: Update comments for removing
 cs_etm_find_snapshot()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210905131237.1035322-1-leo.yan@linaro.org>
 <20210905131237.1035322-3-leo.yan@linaro.org>
 <4db83b64-445d-2a04-a130-fd95f9157702@arm.com>
 <20210906102849.GA1164772@leoy-ThinkPad-X240s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b5e78a4e-e92b-cbf8-be8c-611b2f1be81b@arm.com>
Date:   Mon, 6 Sep 2021 11:31:24 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210906102849.GA1164772@leoy-ThinkPad-X240s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2021 11:28, Leo Yan wrote:
> Hi Suzuki,
> 
> On Mon, Sep 06, 2021 at 10:51:02AM +0100, Suzuki Kuruppassery Poulose wrote:
>> Hi Leo
>>
>>
>> On 05/09/2021 14:12, Leo Yan wrote:
>>> Commit 2f01c200d440 ("perf cs-etm: Remove callback cs_etm_find_snapshot()")
>>> has removed the function cs_etm_find_snapshot() from the perf tool in the
>>> user space, now CoreSight trace directly uses the perf common function
>>> __auxtrace_mmap__read() to calcualte the head and size for AUX trace data
>>> in snapshot mode.
>>>
>>> Updates the comments in drivers to reflect the changes.
>>
>> As such I would avoid referencing "userspace" function names in the
>> kernel driver. Please could we remove it or make it generic ?
> 
> Okay, I'd like to remove the specific function name from the comment so
> can make the comment generic as:
> 
> "User space will figure out how many bytes to get from the AUX buffer
> based on the position of the head."

Yes please, that sounds perfect.

Cheers
Suzuki
