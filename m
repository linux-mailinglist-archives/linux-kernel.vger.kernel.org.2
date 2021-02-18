Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 931A931E46F
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 04:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbhBRDGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 22:06:47 -0500
Received: from foss.arm.com ([217.140.110.172]:43262 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229874AbhBRDGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 22:06:46 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0BE6D1FB;
        Wed, 17 Feb 2021 19:05:58 -0800 (PST)
Received: from [192.168.0.130] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 881ED3F694;
        Wed, 17 Feb 2021 19:05:55 -0800 (PST)
Subject: Re: [PATCH V3 14/14] coresight: etm-perf: Add support for trace
 buffer format
To:     Al Grant <Al.Grant@arm.com>, Peter Zijlstra <peterz@infradead.org>
Cc:     "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lcherian@marvell.com" <lcherian@marvell.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-15-git-send-email-anshuman.khandual@arm.com>
 <YBFiecTmjA30qRaW@hirez.programming.kicks-ass.net>
 <DB7PR08MB3355B1A444324DBC5AF8003C86BB0@DB7PR08MB3355.eurprd08.prod.outlook.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <abc45998-278c-d358-dac6-b134806777e9@arm.com>
Date:   Thu, 18 Feb 2021 08:35:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DB7PR08MB3355B1A444324DBC5AF8003C86BB0@DB7PR08MB3355.eurprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/27/21 6:30 PM, Al Grant wrote:
>>> +/* CoreSight PMU AUX buffer formats */
>>> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT0x0000 /*
>> Default for backward compatibility */
>>> +#define PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW0x0100 /*
>> Raw format of the source */
>>
>> Would CORESIGHT_FORMAT_ETR / CORESIGHT_FORMAT_TRBE be better
>> names?
> 
> Unformatted (raw) streams could be used any time you had a writer dedicated
> to a single trace source. So in a situation where you had one ETR per CPU,
> it would be appropriate to use an unformatted stream. A TRBE is always
> dedicated to a single CPU, but potentially you (i.e. when designing the system)
> can do this with any type of trace sink. So the raw/formatted distinction is
> really about whether you are combining multiple streams in one buffer or not,
> rather than the type of block that is writing into the buffer.
> 
> Al
> 

Okay, will stick with the proposed format names here

i.e 

PERF_AUX_FLAG_CORESIGHT_FORMAT_CORESIGHT
PERF_AUX_FLAG_CORESIGHT_FORMAT_RAW
