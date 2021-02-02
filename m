Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EED830C22E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 15:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhBBOml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 09:42:41 -0500
Received: from foss.arm.com ([217.140.110.172]:51166 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234479AbhBBOhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 09:37:06 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B98811B3;
        Tue,  2 Feb 2021 06:36:20 -0800 (PST)
Received: from [10.57.35.108] (unknown [10.57.35.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 687433F718;
        Tue,  2 Feb 2021 06:36:18 -0800 (PST)
Subject: Re: [PATCH V3 02/14] coresight: Do not scan for graph if none is
 present
To:     Mike Leach <mike.leach@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Linu Cherian <lcherian@marvell.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1611737738-1493-1-git-send-email-anshuman.khandual@arm.com>
 <1611737738-1493-3-git-send-email-anshuman.khandual@arm.com>
 <CAJ9a7VjB8-h_0DBuMHvv4A+mHpz1GUczbGB6Tx1cBocRghm7mQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <81648285-a321-173f-a0da-6ba0bc077abf@arm.com>
Date:   Tue, 2 Feb 2021 14:36:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAJ9a7VjB8-h_0DBuMHvv4A+mHpz1GUczbGB6Tx1cBocRghm7mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike

On 2/2/21 11:10 AM, Mike Leach wrote:
> Hi Ansuman,
> 
> On Wed, 27 Jan 2021 at 08:55, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> From: Suzuki K Poulose <suzuki.poulose@arm.com>
>>
>> If a graph node is not found for a given node, of_get_next_endpoint()
>> will emit the following error message :
>>
>>   OF: graph: no port node found in /<node_name>
>>
>> If the given component doesn't have any explicit connections (e.g,
>> ETE) we could simply ignore the graph parsing.
>>
>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>> Cc: Mike Leach <mike.leach@linaro.org>
>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   drivers/hwtracing/coresight/coresight-platform.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 3629b78..c594f45 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -90,6 +90,12 @@ static void of_coresight_get_ports_legacy(const struct device_node *node,
>>          struct of_endpoint endpoint;
>>          int in = 0, out = 0;
>>
>> +       /*
>> +        * Avoid warnings in of_graph_get_next_endpoint()
>> +        * if the device doesn't have any graph connections
>> +        */
>> +       if (!of_graph_is_present(node))
>> +         return;
> 
> The problem here is that you are masking genuine errors.

If the graph is not described for a component, where it is
mandatory, it won't be usable by the driver and as such using
the devices will fail.

e.g, if an ETM misses the bindings, tracing will fail. (in either
mode).

> The solution is to either call this only if the device type is one
> that ports are not required - i.e. ETE, or upgrade the .dts bindings

The proposed change is too invasive and is not worth the benefit
that it brings.

The side effect of this patch is, if someone makes a mistake in the
bindings they don't see the "warning" in the dmesg. But will definitely
hit the issue when trying to use the system.

i.e, Functionally there is no change.

On the other hand issuing a warning message for ETE is confusing for
a well behaved user.

> for the rest of the ETM devices to yaml so that the ports requirement
> is checked and validated there.

This is a step that we must take, but in a separate series. And I
don't think this will solve handling non-compliant DTs *immediately*,
as there could be :
  a) DTS that are not upstream (Quite common for CoreSight)
  b) People are getting used to the schema and running schema checks.

So, personally I vote for :

1) Merge this patch in as is
2) Convert the bindings to Yaml in a separate series.

Suzuki

