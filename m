Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F422346F47
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 03:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhCXCNi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 22:13:38 -0400
Received: from regular1.263xmail.com ([211.150.70.205]:43726 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231781AbhCXCNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 22:13:35 -0400
Received: from localhost (unknown [192.168.167.69])
        by regular1.263xmail.com (Postfix) with ESMTP id A01AE990;
        Wed, 24 Mar 2021 10:12:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-SKE-CHECKED: 1
X-ABS-CHECKED: 1
Received: from [172.16.12.236] (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P1826T139670268532480S1616551969111653_;
        Wed, 24 Mar 2021 10:12:49 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c9bb3d9b648f989d6fa9861f5ae7ad8f>
X-RL-SENDER: zhangqing@rock-chips.com
X-SENDER: zhangqing@rock-chips.com
X-LOGIN-NAME: zhangqing@rock-chips.com
X-FST-TO: linux-arm-kernel@lists.infradead.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_2/3=5d_dt-bindings=3a_Convert_the_rockc?=
 =?UTF-8?B?aGlwIHBvd2VyX2RvbWFpbiB0byBZQU1MIGFuZCBleHRlbmTjgJDor7fms6jmhI8=?=
 =?UTF-8?B?77yM6YKu5Lu255Sxcm9iaGVycmluZzJAZ21haWwuY29t5Luj5Y+R44CR?=
To:     Rob Herring <robh@kernel.org>
Cc:     tony.xie@rock-chips.com, huangtao@rock-chips.com, heiko@sntech.de,
        linux-kernel@vger.kernel.org, finley.xiao@rock-chips.com,
        kever.yang@rock-chips.com, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org, cl@rock-chips.com,
        linux-arm-kernel@lists.infradead.org
References: <20210323082410.22818-1-zhangqing@rock-chips.com>
 <20210323082410.22818-3-zhangqing@rock-chips.com>
 <1616530607.412616.1244766.nullmailer@robh.at.kernel.org>
From:   "elaine.zhang" <zhangqing@rock-chips.com>
Organization: rockchip
Message-ID: <f1c36d81-9896-dec1-b6a8-f859d388ae7f@rock-chips.com>
Date:   Wed, 24 Mar 2021 10:12:49 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1616530607.412616.1244766.nullmailer@robh.at.kernel.org>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Rob Herring

ÔÚ 2021/3/24 ÉÏÎç4:16, Rob Herring Ð´µÀ:
> On Tue, 23 Mar 2021 16:24:09 +0800, Elaine Zhang wrote:
>> This converts the rockchip power domain family bindings to YAML schema,
>> and add binding documentation for the power domains found on Rockchip
>> RK3568 SoCs.
>>
>> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
>> ---
>>   .../bindings/soc/rockchip/power_domain.txt    | 136 ---------
>>   .../rockchip/rockchip,power-controller.yaml   | 259 ++++++++++++++++++
>>   2 files changed, 259 insertions(+), 136 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/soc/rockchip/power_domain.txt
>>   create mode 100644 Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.yaml
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.example.dts:19:18: fatal error: dt-bindings/clock/rk3568-cru.h: No such file or directory
>     19 |         #include <dt-bindings/clock/rk3568-cru.h>
>        |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> make[1]: *** [scripts/Makefile.lib:349: Documentation/devicetree/bindings/soc/rockchip/rockchip,power-controller.example.dt.yaml] Error 1
> make: *** [Makefile:1380: dt_binding_check] Error 2

#include <dt-bindings/clock/rk3568-cru.h>
This file has been merged, can be seen on the Master branch of Linux-Next.
I will rearrange the submission based on this:
https://patchwork.kernel.org/project/linux-rockchip/patch/20210225102643.653095-1-enric.balletbo@collabora.com/

>
> See https://patchwork.ozlabs.org/patch/1457096
>
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit.
>
>
>


