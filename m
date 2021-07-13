Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77BC3C6B2B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jul 2021 09:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbhGMHZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jul 2021 03:25:29 -0400
Received: from foss.arm.com ([217.140.110.172]:37610 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234153AbhGMHZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jul 2021 03:25:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 43F7231B;
        Tue, 13 Jul 2021 00:22:38 -0700 (PDT)
Received: from [10.163.65.186] (unknown [10.163.65.186])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 51AA23F694;
        Tue, 13 Jul 2021 00:22:35 -0700 (PDT)
Subject: Re: [PATCH 0/5] coresight: TRBE and Self-Hosted trace fixes
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, al.grant@arm.com, leo.yan@linaro.org,
        mike.leach@linaro.org, peterz@infradead.org, Tamas.Zsoldos@arm.com,
        will@kernel.org
References: <20210712113830.2803257-1-suzuki.poulose@arm.com>
 <20210712170246.GB1777012@p14s>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <0c9ef7f3-a62f-cdae-68f2-dd6e443422c3@arm.com>
Date:   Tue, 13 Jul 2021 12:53:23 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210712170246.GB1777012@p14s>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/12/21 10:32 PM, Mathieu Poirier wrote:
> On Mon, Jul 12, 2021 at 12:38:25PM +0100, Suzuki K Poulose wrote:
>> This is a series of fixes addressing the issues in the way we handle
>>   - Self-Hosted trace filter control register for ETM/ETE
>>   - AUX buffer and event handling of TRBE at overflow.
>>
>> The use of TRUNCATED flag on an IRQ for the TRBE driver is
>> something that needs to be rexamined. Please see Patch 3 for
>> more details.
>>
>> Suzuki K Poulose (5):
>>   coresight: etm4x: Save restore TRFCR_EL1
>>   coresight: etm4x: Use Trace Filtering controls dynamically
>>   coresight: trbe: Keep TRBE disabled on overflow irq
>>   coresight: trbe: Move irq_work queue processing
>>   coresight: trbe: Prohibit tracing while handling an IRQ
>>
>>  .../coresight/coresight-etm4x-core.c          | 109 ++++++++++++++----
>>  drivers/hwtracing/coresight/coresight-etm4x.h |   7 +-
>>  drivers/hwtracing/coresight/coresight-trbe.c  |  91 ++++++++++-----
>>  3 files changed, 149 insertions(+), 58 deletions(-)
> 
> Anshuman - please have a look when you have a minutes.

Sure, will do.
