Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0635C36D576
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 12:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239124AbhD1KKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 06:10:11 -0400
Received: from foss.arm.com ([217.140.110.172]:38870 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239013AbhD1KKH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 06:10:07 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 119281FB;
        Wed, 28 Apr 2021 03:09:23 -0700 (PDT)
Received: from [10.57.67.189] (unknown [10.57.67.189])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1EF143F70D;
        Wed, 28 Apr 2021 03:09:20 -0700 (PDT)
Subject: Re: [PATCH v1] coresight: add node to reset all coresight devices
To:     taozha@codeaurora.org
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        Yuanfang Zhang <zhangyuanfang@codeaurora.org>
References: <1619166578-28690-1-git-send-email-taozha@codeaurora.org>
 <e753898c-0334-cf84-620e-d9b9f18d87e7@arm.com>
 <4036d63a8759ac67a26fd8798b9adf6b@codeaurora.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <38865567-8557-e48d-779b-ca257e318c19@arm.com>
Date:   Wed, 28 Apr 2021 11:09:19 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <4036d63a8759ac67a26fd8798b9adf6b@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2021 10:57, taozha@codeaurora.org wrote:
> On 2021-04-23 21:20, Suzuki K Poulose wrote:
>> On 23/04/2021 09:29, Tao Zhang wrote:
>>> Add new reset_source_sink node to be able to disable all active
>>> coresight devices.
>>> In this way, we no longer need to manually disable all active
>>> coresight devices one by one. After enabling multiple coresight
>>> paths, users can reset their status more conveniently by this
>>> node.
>>>
>>
>> What is the use case here ? Why would you trigger a reset for all the
>> sources/sink without gracefully completing any on-going sessions
>> (including the perf ones, which are driven by the kernel perf layer)
>>
> We have a tool needs a command that could reset all active devices.
> Since the tool cannot what dvices are activated, we add this new node
> to sysFS for our tool could reset all active device by one command.
> We hope that this patch can also provide a more convenient option
> for the other users with the same needs.

There is sysfs handles to do this already. See the testcase under perf, 
e.g, that can walk the sysfs and figure out the source devices and the 
"sinks" that can be reached from the given device.

If some information is missing, to achieve this. we could provide that. 
But simply because a tool wants to do something without bothering to use 
the provided ABI, is not a justification to add something to the kernel.

Suzuki

