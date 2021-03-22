Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370AE345291
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 23:50:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbhCVWtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 18:49:50 -0400
Received: from foss.arm.com ([217.140.110.172]:38720 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229995AbhCVWth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 18:49:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 401841042;
        Mon, 22 Mar 2021 15:49:37 -0700 (PDT)
Received: from [10.57.55.187] (unknown [10.57.55.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 034DD3F792;
        Mon, 22 Mar 2021 15:49:35 -0700 (PDT)
Subject: Re: [PATCH v4 15/19] dts: bindings: Document device tree bindings for
 ETE
To:     Rob Herring <robh@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Leo Yan <leo.yan@linaro.org>, devicetree@vger.kernel.org
References: <20210225193543.2920532-1-suzuki.poulose@arm.com>
 <20210225193543.2920532-16-suzuki.poulose@arm.com>
 <20210306210627.GA1207387@robh.at.kernel.org>
 <f69ad530-baec-2e73-827a-b5a5a6df3d23@arm.com>
 <CAL_JsqL6ZQPFqc_Q4A6cB+8d7eGidoFhvJwa_YrZm-Xz7oC6mQ@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <e971dde9-5eec-368e-b351-61e7172bbce7@arm.com>
Date:   Mon, 22 Mar 2021 22:49:34 +0000
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqL6ZQPFqc_Q4A6cB+8d7eGidoFhvJwa_YrZm-Xz7oC6mQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2021 17:28, Rob Herring wrote:
> On Mon, Mar 22, 2021 at 10:53 AM Suzuki K Poulose
> <suzuki.poulose@arm.com> wrote:
>>
>> Hi Rob
>>
>> On 06/03/2021 21:06, Rob Herring wrote:
>>> On Thu, Feb 25, 2021 at 07:35:39PM +0000, Suzuki K Poulose wrote:
>>>> Document the device tree bindings for Embedded Trace Extensions.
>>>> ETE can be connected to legacy coresight components and thus
>>>> could optionally contain a connection graph as described by
>>>> the CoreSight bindings.
>>>>
>>>> Cc: devicetree@vger.kernel.org
>>>> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>> Cc: Mike Leach <mike.leach@linaro.org>
>>>> Cc: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>>>> ---

>>>> +  out-ports:
>>>> +    description: |
>>>> +      Output connections from the ETE to legacy CoreSight trace bus.
>>>> +    $ref: /schemas/graph.yaml#/properties/port
>>>
>>> s/port/ports/
>>
>> Ok.
>>
>>>
>>> And then you need:
>>>
>>>          properties:
>>>            port:
>>>              description: what this port is
>>>              $ref: /schemas/graph.yaml#/properties/port
>>
>> Isn't this already covered by the definition of ports ? There are no
>> fixed connections for ETE. It is optional and could be connected to
>> any legacy CoreSight component. i.e, a "ports" object can have port
>> objects inside.
> 
> 'properties/ports' only defines that you have 'port' nodes within it.
> 
>> Given we have defined out-ports as an object "confirming to the ports"
>> do we need to describe the individual port nodes ?
> 
> Yes, you have to define what the 'port' nodes are. A port is a data
> stream and you should know what your hardware has. What the data
> stream is connected to is outside the scope of the binding.

Ok, I have included the above changes for the next version.

Thanks
Suzuki
