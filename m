Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133774164CE
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhIWSIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 14:08:55 -0400
Received: from foss.arm.com ([217.140.110.172]:38092 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242611AbhIWSIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 14:08:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B6F9106F;
        Thu, 23 Sep 2021 11:07:22 -0700 (PDT)
Received: from [10.57.95.68] (unknown [10.57.95.68])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61B753F59C;
        Thu, 23 Sep 2021 11:07:21 -0700 (PDT)
Subject: Re: [PATCH v4 0/5] coresight: TRBE and Self-Hosted trace fixes
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, anshuman.khandual@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
References: <20210923143919.2944311-1-suzuki.poulose@arm.com>
 <20210923165503.GB2189675@p14s>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <8ec6620f-d799-228e-8cf2-69964c4c1798@arm.com>
Date:   Thu, 23 Sep 2021 19:07:19 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210923165503.GB2189675@p14s>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/09/2021 17:55, Mathieu Poirier wrote:
> On Thu, Sep 23, 2021 at 03:39:14PM +0100, Suzuki K Poulose wrote:
>> Here is the updated patches from the v3 of the series [0], parts of which
>> have been queued to coresight/next. This series now applies on the
>> coresight/next branch.
>>
>> Changes since v3:
>>   - Split the spurious IRQ handling patch to :
>>     a) coresight: trbe: irq handler: Do not disable TRBE if no action is needed
>>     b) coresight: trbe: Fix handling of spurious interrupts
>>
>>   - Added a helper to mark the ring buffer when there is WRAP event
>>     and added a comment to explain.
>>
>> [0] https://lkml.kernel.org/r/20210914102641.1852544-1-suzuki.poulose@arm.com
>>
>> Suzuki K Poulose (5):
>>    coresight: trbe: irq handler: Do not disable TRBE if no action is needed
>>    coresight: trbe: Fix handling of spurious interrupts
>>    coresight: trbe: Do not truncate buffer on IRQ
>>    coresight: trbe: End the AUX handle on truncation
>>    coresight: trbe: Prohibit trace before disabling TRBE
>>
>>   .../coresight/coresight-self-hosted-trace.h   |  4 +-
>>   drivers/hwtracing/coresight/coresight-trbe.c  | 96 ++++++++++++-------
>>   2 files changed, 64 insertions(+), 36 deletions(-)
> 
> Applied and pushed - thanks for the modifications.

Thank you for the review and support !

Suzuki
