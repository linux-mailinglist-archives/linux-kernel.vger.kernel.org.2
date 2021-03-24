Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5A9346FB0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234940AbhCXCtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:49:46 -0400
Received: from regular1.263xmail.com ([211.150.70.195]:55314 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbhCXCt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:49:29 -0400
Received: from localhost (unknown [192.168.167.16])
        by regular1.263xmail.com (Postfix) with ESMTP id 335B91D1D;
        Wed, 24 Mar 2021 10:49:00 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P13111T139928526636800S1616554138557516_;
        Wed, 24 Mar 2021 10:48:59 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <04df23d237b6fbd553a9c872d6560c96>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: finley.xiao@rock-chips.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v2 2/3] dt-bindings: Convert the rockchip power_domain to
 YAML and extend
To:     Enric Balletbo Serra <eballetbo@gmail.com>,
        Johan Jonker <jbx6244@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>, cl@rock-chips.com,
        huangtao@rock-chips.com, kever.yang@rock-chips.com,
        tony.xie@rock-chips.com, finley.xiao@rock-chips.com
References: <20210323082410.22818-1-zhangqing@rock-chips.com>
 <20210323082410.22818-3-zhangqing@rock-chips.com>
 <87e50d5b-604b-508c-f3cb-ee07fcf15241@gmail.com>
 <CAFqH_53kBf++SPfir_5mA9Dv2v=u4s1zpqnztAH8Tt2-9dLVnQ@mail.gmail.com>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <6e906aee-646f-ff7e-deca-fe9bbd435cd8@rock-chips.com>
Date:   Wed, 24 Mar 2021 10:48:58 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAFqH_53kBf++SPfir_5mA9Dv2v=u4s1zpqnztAH8Tt2-9dLVnQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Enric

在 2021/3/24 上午4:58, Enric Balletbo Serra 写道:
> Hi Elaine,
>
> Missatge de Johan Jonker <jbx6244@gmail.com> del dia dt., 23 de març
> 2021 a les 12:06:
>> Hi Elaine,
>>
>> Some comments. Have a look if it's useful or that you disagree
>> with...(part 1)
>>
>> ======
>> There is currently already a patch proposal that does the same.
>> Could you read that review history and port the good things to your own
>> patch serie?
>>
>> Re: [PATCH] dt-bindings: power: rockchip: Convert to json-schema
>> https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/
>>
>> Re: [PATCH v3] dt-bindings: power: rockchip: Convert to json-schema
>> https://lore.kernel.org/linux-rockchip/20201007151159.GA221754@bogus/
>>
> In fact, the latest version is v6 which can be found here:
>
> https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.653095-1-enric.balletbo@collabora.com/
>
> Feel free to integrate and/or improve that version in your series.
Thank you for your submission. I will revise the submission on this basis.
>
>
>


