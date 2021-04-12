Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4442735BA42
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 08:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236590AbhDLGpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 02:45:44 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:15663 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbhDLGpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 02:45:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FJfLK3pNmzpXZM;
        Mon, 12 Apr 2021 14:42:33 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.202) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Mon, 12 Apr 2021
 14:45:19 +0800
Subject: Re: [PATCH v2 2/2] ASoC: dt-bindings: renesas, rsnd: Clear warning
 'ports' does not match any of the regexes
To:     Rob Herring <robh@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
References: <20210331091616.2306-1-thunder.leizhen@huawei.com>
 <20210331091616.2306-3-thunder.leizhen@huawei.com>
 <20210401202056.GA947212@robh.at.kernel.org>
 <a1aed23d-a9d2-5e05-b1f5-3b48ac8d17f1@huawei.com>
 <15a406ba-b288-c98c-46f1-36933c11fb11@huawei.com>
 <20210408204212.GA1924190@robh.at.kernel.org>
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <4afb560b-6696-e4e0-09f7-39a768c4c5b8@huawei.com>
Date:   Mon, 12 Apr 2021 14:45:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20210408204212.GA1924190@robh.at.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.202]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/4/9 4:42, Rob Herring wrote:
> On Thu, Apr 08, 2021 at 08:28:08PM +0800, Leizhen (ThunderTown) wrote:
>>
>>
>> On 2021/4/7 10:04, Leizhen (ThunderTown) wrote:
>>>
>>>
>>> On 2021/4/2 4:20, Rob Herring wrote:
>>>> On Wed, Mar 31, 2021 at 05:16:16PM +0800, Zhen Lei wrote:
>>>>> Currently, if there are more than two ports, or if there is only one port
>>>>> but other properties(such as "#address-cells") is required, these ports
>>>>> are placed under the "ports" node. So add the schema of property "ports".
>>>>
>>>> A given binding should just use 'ports' or 'port' depending on it's 
>>>> need. Supporting both forms is needless complexity.
>>
>> Hi Rob:
>> I don't think of a good way to avoid "port" and "ports" to be used at the same time.
>> Should I disable the use of "port"? Convert the two usages of "port" into "ports".
>> But usually no one will use both of them in one dts file. And even if it's used at
>> the same time, it's not a big mistake. So I decided not to test it.
> 
> I think the Renesas folks need to comment on this.

Hi All:
  I've figured out a way to avoid both. I'll send v3 right away.

> 
> Rob
> 
> .
> 

