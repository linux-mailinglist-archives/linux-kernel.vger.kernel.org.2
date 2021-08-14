Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCA23EC352
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 16:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhHNOfX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 10:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbhHNOeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 10:34:01 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464D6C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:33:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g138so8676938wmg.4
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 07:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FSjz7PXc05ey7CBf7a8rTRIFP4h4FppivnOYdTa5VtY=;
        b=i5Ed3hYlNk/+GujFI71UkUAzqTz54pZ/vHZmMp0aRWxSgUG4dZKm+Gt+fCSx2ZhsFU
         LRh8uRXSbDb/hLnlUwU6IdpFwTOOibyZwpAql3yKWEBkbvzDAaYuAL3gJoPGbOLrtT78
         HK9otytVEF7FL4CjMZ69L9NOTMWZKIE/n8fBU7q+HZK6ATyvJEXSIZ9PqPNTj5VAMkBZ
         53Dl5TmNZrXmv9G9jwhJRozeb+2KWoLY0jSOwtL6MGe3x5kA+jNJ8O7bNXnulVAZ4FA0
         95JlO+GZkr2Uin805EpvLYIZC6bKXaWRdHHsiyj8zR6242serWpUTrkWqqUKKq4DwVz+
         e8gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FSjz7PXc05ey7CBf7a8rTRIFP4h4FppivnOYdTa5VtY=;
        b=Vv54UrNAMeiPlNZIm9EcM6aqbdwdVDthmo1yBV0HC3Z/rVL2LAUKQu1FUdbLO8Es+Y
         8oOpACTlR0tWJHUUQ74zSXOVPgu/mYdtpSSftiFzu4k9goCrFbk5LepxE2tuUwnq/5ev
         RKSUCstkUjItSzAXtqos3n2Ttj2RCjiqVgiYyVDdWXF+V2ptAFuRYuEkf9s82OddBkOm
         qC4FKMbYomOceUokQM9EMdLwaMLKyCr1lidZ1nhNVchLOe63Ng2FTvGbhIRnFZoK/zoD
         Ropm4wFb5lgL9kJpOsWgWNKHzfXqN9WyUQkh8ojc9XsI3jFx6AR+qd5kUqU7D3MSoKi5
         0yFA==
X-Gm-Message-State: AOAM531nL7FaMLI132S2Qoofo5AzfYLvm1i4eZEAHsBZeZwKDju4YXgY
        9mbOH223euYke8PNQw0E2LibDA==
X-Google-Smtp-Source: ABdhPJz51O7d7fb/U7TEzxrxHI3trr8GTQjUhp28OTPkLrwuM6u3lRPJtQ/dsvecjzMa/MjYtoNo6A==
X-Received: by 2002:a1c:3b09:: with SMTP id i9mr7405159wma.62.1628951611659;
        Sat, 14 Aug 2021 07:33:31 -0700 (PDT)
Received: from ?IPv6:2a01:e34:ed2f:f020:ab33:6dea:825:98d? ([2a01:e34:ed2f:f020:ab33:6dea:825:98d])
        by smtp.googlemail.com with ESMTPSA id r12sm4498671wrv.96.2021.08.14.07.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 Aug 2021 07:33:31 -0700 (PDT)
Subject: Re: [RFD] DTPM hierarchy description via DT
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <847aca40-2ded-8e37-72bf-c38ccbdc28e5@linaro.org>
 <CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com>
 <2b08615b-aaac-c14a-8d99-6cf181602689@linaro.org>
Message-ID: <b859c7b0-c341-ad0a-38ef-5487cb2dea0e@linaro.org>
Date:   Sat, 14 Aug 2021 16:33:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <2b08615b-aaac-c14a-8d99-6cf181602689@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rob,

just a heads up about the discussion.

Do you have a suggestion about the bindings as proposed below?

Is it valid to have a phandle to point to an empty node ?




On 04/07/2021 11:58, Daniel Lezcano wrote:
> 
> Hi Rob,
> 
> thank you for your answer.
> 
> On 02/07/2021 18:51, Rob Herring wrote:
>> On Fri, Jul 2, 2021 at 7:51 AM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>>
>>> Hi,
>>>
>>> recently a new framework based on top of the powercap framework was
>>> introduced to limit the power of some devices when they are capable of
>>> that. Based on the approximate power numbers from the energy model, it
>>> allows to have a rough estimation of the power consumption and set the
>>> power limit [1].
>>>
>>> This framework describes via a hierarchy the constraints relationship
>>> between all those devices and it is SoC specific.
>>>
>>> The problem is how to describe this hierarchy.
>>>
>>> The hierarchy could be like:
>>>
>>> soc
>>>    |
>>>    |-- package
>>>    |      |
>>>    |      |-- cluster0
>>>    |      |      |
>>>    |      |      |-- cpu0
>>>    |      |      |
>>>    |      |      |-- cpu1
>>>    |      |      |
>>>    |      |      |-- cpu2
>>>    |      |      |
>>>    |      |      `-- cpu3
>>>    |      |
>>>    |      |-- cluster1
>>>    |      |      |
>>>    |      |      |-- cpu4
>>>    |      |      |
>>>    |      |      `-- cpu5
>>
>> We already have all this with cpu topology binding which feeds cpu
>> topology functionality in the kernel. Is there a case for the
>> powerzone hierarchy to be different? 
> 
> Yes, the performance domain and the topology may differ. For instance
> the hi6220 has two clusters but one performance domain, so the powerzone
> is all the cpus under the same group.
> 
> I realize I should have not put the clusterx name but 'big' and
> 'little'. Also we may want to add only one CPU in the powerzone for
> example, or make a device belonging to multiple powerzones.
> 
> 
>> For CPUs, I don't see why we'd
>> need anything else or perhaps just a new property in cpu nodes for
>> something?
> 
> Yes, a property should be fine.
> 
>> For other devices, is there a need for a hierarchy or just grouping?
> 
> [ ... ]
> 
> We need to create a parent powerzone which is not a device but a node to
> group different devices and/or another powerzone. So I guess the answer
> is both grouping the devices but also a hierarchy.
> 
> 
>>> We are far from this description yet but it is for illustration purpose.
>>>
>>> All the nodes of the tree do not necessarily reflect real devices, for
>>> example, 'package' or 'multimedia' are not described in the DT.
>>>
>>> What we want is to build this hierarchy which is SoC dependent.
>>>
>>> A first proposal was made to create those nodes in configfs but because
>>> it results in creating a node in sysfs also the approach is not valid [2]
>>>
>>> It was suggested to use the devicetree to describe such hierarchy. There
>>> are several possibilities but the nodes not describing real hardware
>>> above is difficult to describe. Also, the hierarchy should not be over
>>> complexified.
>>
>> I'm very leary of yet another CPU PM related binding. We already have
>> topology, idle states, OPP, ...
>>
>> There's less on the device side, but it's more fragmented with each
>> vendor doing their own thing.
> 
> Ok fair enough, I guess that implies the solution 1 below is not adequate.
> 
> The main difference with the 2 other possibilities below is one will
> always need SoC specific code to create the hierarchy while the other
> can work with generic code.
> 
> However, I'm uncomfortable with the idea of "powerzone-parent' property
> with a phandle pointing to an empty node. Is is valid ?
> 




>>> On the other hand most of the devices are already described, so it is a
>>> question of tightening them together.
>>>
>>> There are different possibilities to describe this hierarchy:
>>>
>>> 1. Create the hierarchy in the DT:
>>>
>>>         power-zones {
>>>
>>>                 package {
>>>
>>>                         big {
>>>                                 powerzone = <&cpu_b0 POWERZONE_DVFS>,
>>>                                         <&cpu_b1 POWERZONE_DVFS>;
>>>                         };
>>>
>>>                         little {
>>>                                 powerzone = <&cpu_l0 POWERZONE_DVFS>,
>>>                                         <&cpu_l1 POWERZONE_DVFS>,
>>>                                         <&cpu_l2 POWERZONE_DVFS>,
>>>                                         <&cpu_l3 POWERZONE_DVFS>;
>>>                         };
>>>
>>>                         gpu {
>>>                                 powerzone = <&gpu POWERZONE_DVFS>;
>>>                         };
>>>                 };
>>>         };
>>>
>>> 2. Let the kernel build the hierarchy but add a property in the
>>> different nodes:
>>>
>>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=05943f5a1cf33df36dbe423fd4b549a9aa244da1
>>>
>>> And from there the kernel does for_each_node_with_property(). The kernel
>>> has to know "cpu-pd0" and "cpu-pd1". That implies a per soc
>>> initialization code:
>>>
>>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=7525abb234695d07a0094b2f511d5fe8bea0a979
>>>
>>> https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=powercap/dtpm-dts-1.0&id=70e1deb642a939d14dd9b0391d8219cf21a03253
>>>
>>>
>>> 3. An intermediate description between 1. and 2.
>>>
>>> The nodes have a property which is a phandle to the parent node. But if
>>> the parent node does not exists, create an empty and point to it.
>>>
>>> package {
>>>         powerzone;
>>>         powerzone-parent = <&soc>;
>>> };
>>>
>>> cluster0 {
>>>         powerzone-parent = <&package>;
>>> };
>>>
>>>         ...
>>>
>>>                 cpu_l0: cpu@0 {
>>>                         device_type = "cpu";
>>>                         compatible = "arm,cortex-a53";
>>>                         reg = <0x0 0x0>;
>>>                         enable-method = "psci";
>>>                         capacity-dmips-mhz = <485>;
>>>                         clocks = <&cru ARMCLKL>;
>>>                         #cooling-cells = <2>; /* min followed by max */
>>>                         dynamic-power-coefficient = <100>;
>>>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
>>>                         powerzone-parent = <&cluster0>;
>>>                 };
>>>
>>>         ...
>>>
>>> I implemented 1. and 2. but before going forward and writing the yaml
>>> bindings which are time consuming, it would be preferable we agree on
>>> something instead of having to drop the code again and again.
>>>
>>> Thanks for your comments
>>>
>>>
>>> [1] https://lwn.net/Articles/839318/
>>> [2] https://www.spinics.net/lists/kernel/msg3891770.html
>>>
>>> --
>>> <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>>
>>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>>> <http://twitter.com/#!/linaroorg> Twitter |
>>> <http://www.linaro.org/linaro-blog/> Blog
> 
> 


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
