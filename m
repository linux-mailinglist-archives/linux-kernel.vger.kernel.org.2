Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31B93BACA3
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jul 2021 11:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhGDKBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jul 2021 06:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhGDKBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jul 2021 06:01:36 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC19DC061762
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jul 2021 02:59:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id o33-20020a05600c5121b02901e360c98c08so11975827wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jul 2021 02:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7F/Uf+V+Kfjntm55GFiJzulgURVD0tcaq576XZWOGsE=;
        b=ySbyz7S4oBg9rxjL3vAFGSVbRy6GabP5z5E12yXLvqrYADS+T/No4E0lHmWT6YlU1q
         oRPpuKWru5ddlul2aXSh9ozvLtiBv+XlROmpFuLEzkSxtbIOznm7HsgJsARF+Nmwss1J
         qN1A8muaWbh4VG8KhPzcJFTDyCDlZwnO8rWELdsjGv6/F7rAudhOVrHatx8rA0jWRV3o
         bS1LbfHbaJl6Pa4MxX3ZDEEYo5C+tONPoDcIbU5B5CZYV6NxWjJx5P7blwbI7Odd55lR
         QWnMIkr0L5ZVzGZFWGvU+sy66u6EfQQNNeq0nBTUqYBgVe6rxbeSKkGQcDCEzT02eDhV
         +ROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7F/Uf+V+Kfjntm55GFiJzulgURVD0tcaq576XZWOGsE=;
        b=QBHYrVDD+5dHZ5dcF7jNzkKjgBvcmRS+haei85LKc5jfcBcEmoIIzd+T5gRPIQqk7o
         4c3We5M0VJMmzaKl3Jg0Uqd2GOLse72+yshnr7wB/GbPm6zV0mHm6I27ToxR6G8PXrYh
         aYn/9Vv8faPoTIvluaaDMlaJlw3KZq3sA6/oLu/GyrO5nfVhfrEKBDIkMl1dTp1kyj1z
         scOLcjQXYSrVjMvf6Qb15I3t0rbses4B37VVse8vdmhM8+F9NV0fnXJuBoHqZtgzQD5W
         UJQQS1EpKyZMYsYS3zx6EcW9sxw/YKz+QX3H08zKG5GQ5Bz4VeBy0gC3imzizpWxhacE
         oNTg==
X-Gm-Message-State: AOAM531U/83AvgOVlMoxjB1NG51nqS5Uj8v3Xz5uY6YRHxqvPDwSpNhf
        NVJaKrSfusElejx8zMRx3+JaEg==
X-Google-Smtp-Source: ABdhPJzaqd91O+k/SvKjPqVE9lOwWW2Wr3vSIY4SsncIkwJ0zDYGGcIMA+QoD8uPiq3TMscMHXCexg==
X-Received: by 2002:a1c:9d0b:: with SMTP id g11mr9068151wme.132.1625392739213;
        Sun, 04 Jul 2021 02:58:59 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:11d:6696:65bb:ef7f? ([2a01:e34:ed2f:f020:11d:6696:65bb:ef7f])
        by smtp.googlemail.com with ESMTPSA id f2sm9338760wrq.69.2021.07.04.02.58.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 02:58:58 -0700 (PDT)
Subject: Re: [RFD] DTPM hierarchy description via DT
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <847aca40-2ded-8e37-72bf-c38ccbdc28e5@linaro.org>
 <CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
Message-ID: <2b08615b-aaac-c14a-8d99-6cf181602689@linaro.org>
Date:   Sun, 4 Jul 2021 11:58:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

thank you for your answer.

On 02/07/2021 18:51, Rob Herring wrote:
> On Fri, Jul 2, 2021 at 7:51 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>>
>> Hi,
>>
>> recently a new framework based on top of the powercap framework was
>> introduced to limit the power of some devices when they are capable of
>> that. Based on the approximate power numbers from the energy model, it
>> allows to have a rough estimation of the power consumption and set the
>> power limit [1].
>>
>> This framework describes via a hierarchy the constraints relationship
>> between all those devices and it is SoC specific.
>>
>> The problem is how to describe this hierarchy.
>>
>> The hierarchy could be like:
>>
>> soc
>>    |
>>    |-- package
>>    |      |
>>    |      |-- cluster0
>>    |      |      |
>>    |      |      |-- cpu0
>>    |      |      |
>>    |      |      |-- cpu1
>>    |      |      |
>>    |      |      |-- cpu2
>>    |      |      |
>>    |      |      `-- cpu3
>>    |      |
>>    |      |-- cluster1
>>    |      |      |
>>    |      |      |-- cpu4
>>    |      |      |
>>    |      |      `-- cpu5
> 
> We already have all this with cpu topology binding which feeds cpu
> topology functionality in the kernel. Is there a case for the
> powerzone hierarchy to be different? 

Yes, the performance domain and the topology may differ. For instance
the hi6220 has two clusters but one performance domain, so the powerzone
is all the cpus under the same group.

I realize I should have not put the clusterx name but 'big' and
'little'. Also we may want to add only one CPU in the powerzone for
example, or make a device belonging to multiple powerzones.


> For CPUs, I don't see why we'd
> need anything else or perhaps just a new property in cpu nodes for
> something?

Yes, a property should be fine.

> For other devices, is there a need for a hierarchy or just grouping?

[ ... ]

We need to create a parent powerzone which is not a device but a node to
group different devices and/or another powerzone. So I guess the answer
is both grouping the devices but also a hierarchy.


>> We are far from this description yet but it is for illustration purpose.
>>
>> All the nodes of the tree do not necessarily reflect real devices, for
>> example, 'package' or 'multimedia' are not described in the DT.
>>
>> What we want is to build this hierarchy which is SoC dependent.
>>
>> A first proposal was made to create those nodes in configfs but because
>> it results in creating a node in sysfs also the approach is not valid [2]
>>
>> It was suggested to use the devicetree to describe such hierarchy. There
>> are several possibilities but the nodes not describing real hardware
>> above is difficult to describe. Also, the hierarchy should not be over
>> complexified.
> 
> I'm very leary of yet another CPU PM related binding. We already have
> topology, idle states, OPP, ...
> 
> There's less on the device side, but it's more fragmented with each
> vendor doing their own thing.

Ok fair enough, I guess that implies the solution 1 below is not adequate.

The main difference with the 2 other possibilities below is one will
always need SoC specific code to create the hierarchy while the other
can work with generic code.

However, I'm uncomfortable with the idea of "powerzone-parent' property
with a phandle pointing to an empty node. Is is valid ?


>> On the other hand most of the devices are already described, so it is a
>> question of tightening them together.
>>
>> There are different possibilities to describe this hierarchy:
>>
>> 1. Create the hierarchy in the DT:
>>
>>         power-zones {
>>
>>                 package {
>>
>>                         big {
>>                                 powerzone = <&cpu_b0 POWERZONE_DVFS>,
>>                                         <&cpu_b1 POWERZONE_DVFS>;
>>                         };
>>
>>                         little {
>>                                 powerzone = <&cpu_l0 POWERZONE_DVFS>,
>>                                         <&cpu_l1 POWERZONE_DVFS>,
>>                                         <&cpu_l2 POWERZONE_DVFS>,
>>                                         <&cpu_l3 POWERZONE_DVFS>;
>>                         };
>>
>>                         gpu {
>>                                 powerzone = <&gpu POWERZONE_DVFS>;
>>                         };
>>                 };
>>         };
>>
>> 2. Let the kernel build the hierarchy but add a property in the
>> different nodes:
>>
>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=05943f5a1cf33df36dbe423fd4b549a9aa244da1
>>
>> And from there the kernel does for_each_node_with_property(). The kernel
>> has to know "cpu-pd0" and "cpu-pd1". That implies a per soc
>> initialization code:
>>
>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=7525abb234695d07a0094b2f511d5fe8bea0a979
>>
>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=70e1deb642a939d14dd9b0391d8219cf21a03253
>>
>>
>> 3. An intermediate description between 1. and 2.
>>
>> The nodes have a property which is a phandle to the parent node. But if
>> the parent node does not exists, create an empty and point to it.
>>
>> package {
>>         powerzone;
>>         powerzone-parent = <&soc>;
>> };
>>
>> cluster0 {
>>         powerzone-parent = <&package>;
>> };
>>
>>         ...
>>
>>                 cpu_l0: cpu@0 {
>>                         device_type = "cpu";
>>                         compatible = "arm,cortex-a53";
>>                         reg = <0x0 0x0>;
>>                         enable-method = "psci";
>>                         capacity-dmips-mhz = <485>;
>>                         clocks = <&cru ARMCLKL>;
>>                         #cooling-cells = <2>; /* min followed by max */
>>                         dynamic-power-coefficient = <100>;
>>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>>                         powerzone-parent = <&cluster0>;
>>                 };
>>
>>         ...
>>
>> I implemented 1. and 2. but before going forward and writing the yaml
>> bindings which are time consuming, it would be preferable we agree on
>> something instead of having to drop the code again and again.
>>
>> Thanks for your comments
>>
>>
>> [1] https://lwn.net/Articles/839318/
>> [2] https://www.spinics.net/lists/kernel/msg3891770.html
>>
>> --
>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
