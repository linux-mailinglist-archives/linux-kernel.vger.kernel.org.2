Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 428313B7D9E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 08:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbhF3GwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 02:52:19 -0400
Received: from regular1.263xmail.com ([211.150.70.206]:38378 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbhF3GwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 02:52:17 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id 259FE1B8E;
        Wed, 30 Jun 2021 14:49:42 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED2: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 1
Received: from [168.168.4.18] (unknown [183.57.25.242])
        by smtp.263.net (postfix) whith ESMTP id P12349T139824115734272S1625035780273543_;
        Wed, 30 Jun 2021 14:49:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <abb208db348bf36d1b7ccc7eb5e4bee0>
X-RL-SENDER: djw@t-chip.com.cn
X-SENDER: djw@t-chip.com.cn
X-LOGIN-NAME: djw@t-chip.com.cn
X-FST-TO: linux-kernel@vger.kernel.org
X-RCPT-COUNT: 15
X-SENDER-IP: 183.57.25.242
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: Re: [PATCH v0 2/2] arm64: dts: rockchip: add support for Firefly
 ROC-RK3399-PC-PLUS
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org
Cc:     Wayne Chou <zxf@t-chip.com.cn>, Kongxin Deng <dkx@t-chip.com.cn>,
        Chen-Yu Tsai <wens@csie.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Jensen Huang <jensenhuang@friendlyarm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Liang Chen <cl@rock-chips.com>,
        Marty Jones <mj8263788@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <uwe@kleine-koenig.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20210628035402.16812-1-djw@t-chip.com.cn>
 <149c2171-471e-343e-8126-38394746b044@t-chip.com.cn>
 <3771996.aKNjEaI27c@diego> <4501122.2vfOZ694Ok@diego>
From:   Levin <djw@t-chip.com.cn>
Message-ID: <eb8acfdf-4bc9-7181-89bb-77995b9d2531@t-chip.com.cn>
Date:   Wed, 30 Jun 2021 14:49:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4501122.2vfOZ694Ok@diego>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,


Thanks for your reply.


On 2021-06-29 5:32 PM, Heiko Stübner wrote:
> Am Dienstag, 29. Juni 2021, 11:30:10 CEST schrieb Heiko Stübner:
>> Hi Levin,
>>
>> Am Dienstag, 29. Juni 2021, 11:15:59 CEST schrieb Levin:
>>> Hi all, is it possible to turn on some codec mixer switch in the device
>>> tree?
>> I don't think that is appropriate and/or/ possible in the devicetree.
>>
>> Instead I think you want an Alsa UCM profile for it, see:
>> https://github.com/alsa-project/alsa-ucm-conf/tree/master/ucm2/Rockchip
>>

Alsa UCM profile is a complete solution, yet it requires more labor work 
of adding a complex profile with all the controls.


The problem is, music/video player knows nothing of the mixers. And with 
currently codec driver setting, user cannot

hear any sound until he turns on two mixer switch.


I hope to have a "simple-audio-card,switch" property here.


>>>
>>> Currently, to hear to sound, we need to run the following commands from
>>> the user space:
>>>
>>>     # turn on mixer switch
>>>
>>>     amixer -c 1 sset 'Left Mixer' on
>>>     amixer -c 1 sset 'Right Mixer' on
>>>
>>>     # raise volume
>>>
>>>     amixer -c 1 sset 'Output 2' 36
>>>
>>>
>>> If these settings can be embedded into device tree, and set by kernel as
>>> initial ALSA path settings,
>>>
>>> user can hear the sound with zero ALSA config. That'll be great.
>>>
>>>
>>> On 2021-06-28 11:54 AM, djw@t-chip.com.cn wrote:
>>>> +
>>>> +	es8388-sound {
>>>> +		compatible = "simple-audio-card";
>>>> +		pinctrl-names = "default";
>>>> +		pinctrl-0 = <&hp_det_pin>;
>>>> +		simple-audio-card,name = "rockchip,es8388-codec";
> and I guess you'd want a more specific name as that config likely is board-specific
> not for all boards using the es8388-codec?
>
>
> Heiko
>

I got what you mean now. It should be renamed to a board-specific card 
name if using Alsa UCM profile, right ?

-- 

Best Regards!

Levin Du



