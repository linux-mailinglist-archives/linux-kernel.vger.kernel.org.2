Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6C434F699
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 04:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233181AbhCaC0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 22:26:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15110 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232805AbhCaC0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 22:26:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F999P4n6Hz1BFdn;
        Wed, 31 Mar 2021 10:23:53 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Wed, 31 Mar 2021
 10:25:52 +0800
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'dais' is a required property
To:     Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20210330030631.2253-1-thunder.leizhen@huawei.com>
 <20210330030631.2253-2-thunder.leizhen@huawei.com>
 <20210330224551.GA842101@robh.at.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2460067e-5358-3e00-0a06-010b2a3736fb@huawei.com>
Date:   Wed, 31 Mar 2021 10:25:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210330224551.GA842101@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/3/31 6:45, Rob Herring wrote:
> On Tue, Mar 30, 2021 at 11:06:30AM +0800, Zhen Lei wrote:
>> When I do dt_binding_check, below warning is reported:
>> Documentation/devicetree/bindings/sound/renesas,rsnd.example.dt.yaml: \
>> sound@ec500000: 'dais' is a required property
>>
>> I looked at all the dts files in the "arch/arm64/boot/dts/renesas/"
>> directory, I found that all nodes that contain the "dais" property have
>> compatible string: "audio-graph-card". So I can be sure that the
>> "$ref: audio-graph.yaml#" should be corrected to
>> "$ref: audio-graph-card.yaml#".
>>
>> In addition, not all nodes have compatible string "audio-graph-card", so
>> the "$ref: audio-graph-card.yaml#" should be described as "anyOf". To
>> ensure the validation of "anyOf" always passes, group it with the "if"
>> statement, because the result of the "if" statement is always not empty.
> 
> 'anyOf' is probably not right here.

Oh, yes, I think I should use "if" statement to enumerate cases where
"audio-graph-card.yaml" is required.

> 
> In any case, the is going to conflict with my series[1].

OK, I'll rework my patch based on your series.

> 
> Rob
> 
> [1] https://lore.kernel.org/r/20210323163634.877511-1-robh@kernel.org/
> 
> .
> 

