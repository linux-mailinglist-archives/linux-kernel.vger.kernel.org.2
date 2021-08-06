Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D15253E288B
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 12:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbhHFK2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 06:28:25 -0400
Received: from foss.arm.com ([217.140.110.172]:57738 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244970AbhHFK2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 06:28:24 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34B621042;
        Fri,  6 Aug 2021 03:28:08 -0700 (PDT)
Received: from [10.57.36.146] (unknown [10.57.36.146])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E48103F719;
        Fri,  6 Aug 2021 03:28:03 -0700 (PDT)
Subject: Re: [PATCH v3 2/7] soc: rockchip: io-domain: add rk3568 support
To:     "jay.xu@rock-chips.com" <jay.xu@rock-chips.com>,
        =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5p2o5Yev?= <kever.yang@rock-chips.com>
Cc:     robh+dt <robh+dt@kernel.org>, cl <cl@rock-chips.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "xxm@rock-chips.com" <xxm@rock-chips.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        "ulf.hansson" <ulf.hansson@linaro.org>,
        Zhang Changzhong <zhangchangzhong@huawei.com>,
        Tobias Schramm <t.schramm@manjaro.org>,
        Johan Jonker <jbx6244@gmail.com>
References: <20210805120107.27007-1-michael.riesch@wolfvision.net>
 <20210805120107.27007-3-michael.riesch@wolfvision.net>
 <8008800c-c518-30d4-edcf-57566e7a1251@arm.com> <3206032.SvYEEZNnvj@diego>
 <2021080617460178513151@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <41dbf032-c852-fbe4-befd-3dc89b24f4c9@arm.com>
Date:   Fri, 6 Aug 2021 11:27:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <2021080617460178513151@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-06 10:46, jay.xu@rock-chips.com wrote:
> Hi Heiko and Robin
> 
> --------------
> jay.xu@rock-chips.com
>> Hi Robin,
>>
>> Am Donnerstag, 5. August 2021, 18:27:36 CEST schrieb Robin Murphy:
>>> On 2021-08-05 13:01, Michael Riesch wrote:
>>>> From: Jianqun Xu <jay.xu@rock-chips.com>
>>>>
>>>> The io-domain registers on RK3568 SoCs have three separated bits to
>>>> enable/disable the 1.8v/2.5v/3.3v power.
>>>>
>>>> This patch make the write to be a operation, allow rk3568 uses a private
>>>> register set function.
>>>>
>>>> Since the 2.5v is not used on RK3568, so the driver only set
>>>
>>> FWIW, this seems at odds with what the first paragraph says - can anyone
>>> clarify what exactly "not used" means here? Is it that the I/O domain
>>> controller has been redesigned to support more than two logic levels on
>>> the new generation of SoCs, but RK3568's I/O pads still only physically
>>> support 1.8v and 3.3v; or is it that it *can* support 2.5v as well but
>>> no currently-known RK3568-based designs use that?
>>>
>>> In the former case it's just a wording issue in the commit message, but
>>> in the latter it's arguably worth implementing support now for the sake
>>> of future compatibility.
>>
>> I hadn't looked that deeply into the rk356x io-domain config, but at least
>> on a register level in the TRM it seems there are separate bits for
>> "3.3V control", "2.5V control", "1.8V control" [0] for each io-domain.
>>
>> Of course the documentation is otherwise somewhat sparse.
>>
>> Maybe Jay or Kever [added] can explain a bit more about the 3 voltage
>> levels.
>>
>>
>> In general though, I tend to find the approach good enough for now.
>>
>> Especially as the io-domain stuff is always said to "can cause damage
>> to the soc if used incorrectly" and it looks like nobody (including
>> Rockchip) seems to have actual hardware using these 2.5V levels right now.
>>
>> So having code in there that no-one ever tested doesn't feel too good ;-)
>>
> yes
> 
> about the 3bit
> 
> case     V33  V25  V18       result
> 0          0      0       0           IO safe, but cannot work
> 1          0      0       1           IO require 1.8V, should < 1.98V, otherwise IO may damage
> 2          0      1       0           IO require 2.5V, should < 2.75V, otherwise IO may damage
> 3          0      1       1           Invalid state, should avoid
> 4          1      0       0           IO require 3.3V, should < 3.63V, otherwise IO may damage
> 5          1      0       1           IO require 1.8V, should < 1.98V, otherwise IO may damage
> 6          1      1       0           IO require 2.5V, should < 2.75V, otherwise IO may damage
> 7          1      1       1           Invalid state, should avoid

Thanks Jay, that's useful to know.

Fair enough if it's the case that 2.5V mode hasn't been validated with 
the BSP kernel either - I'd have no objection to clarifying the commit 
message that way instead, I'm just a curious reviewer who noticed some 
ambiguity :)

>> Adding this later when needed should be somewhat easy, as it really only
>> needs adding of handling that 3rd control bit per domain.

I'm mostly just thinking ahead a year or two when board designers have 
ventured further away from the reference design and *are* using 2.5V 
external components, then a user puts an older stable mainline kernel on 
their board and starts tearing their hair out trying to figure out why 
things are flaky. For instance I recall from my RK3328 box that if the 
I/O domain setting for the GMAC is too high for the actual supply 
voltage (such that it never detects MDIO responses from the external 
phy) you end up getting an utterly nonsensical DMA error. In that case I 
eventually figured out (by chance) that it was because I didn't have the 
I/O domain driver enabled in my config, but it would be a whole other 
level of frustration if the driver appeared to be working but was 
quietly doing the wrong thing.

Cheers,
Robin.

>>
>>
>> Heiko
>>
>>
>>
>> [0] what happens if none of the 3 is active? ;-)
>>
>>
>>>
>>> Robin.
>>>
>>>> 1.8v [enable] + 3.3v [disable] for 1.8v mode
>>>> 1.8v [disable] + 3.3v [enable] for 3.3v mode
>>>>
>>>> There is not register order requirement which has been cleared by our IC
>>>> team.
>>>>
>>>> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
>>>> ---
>>>>     drivers/soc/rockchip/io-domain.c | 88 +++++++++++++++++++++++++++++---
>>>>     1 file changed, 80 insertions(+), 8 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/rockchip/io-domain.c b/drivers/soc/rockchip/io-domain.c
>>>> index cf8182fc3642..13c446fd33a9 100644
>>>> --- a/drivers/soc/rockchip/io-domain.c
>>>> +++ b/drivers/soc/rockchip/io-domain.c
>>>> @@ -51,13 +51,11 @@
>>>>     #define RK3399_PMUGRF_CON0_VSEL	BIT(8)
>>>>     #define RK3399_PMUGRF_VSEL_SUPPLY_NUM	9
>>>>    
>>>> -struct rockchip_iodomain;
>>>> +#define RK3568_PMU_GRF_IO_VSEL0	(0x0140)
>>>> +#define RK3568_PMU_GRF_IO_VSEL1	(0x0144)
>>>> +#define RK3568_PMU_GRF_IO_VSEL2	(0x0148)
>>>>    
>>>> -struct rockchip_iodomain_soc_data {
>>>> -	int grf_offset;
>>>> -	const char *supply_names[MAX_SUPPLIES];
>>>> -	void (*init)(struct rockchip_iodomain *iod);
>>>> -};
>>>> +struct rockchip_iodomain;
>>>>    
>>>>     struct rockchip_iodomain_supply {
>>>>     struct rockchip_iodomain *iod;
>>>> @@ -66,13 +64,62 @@ struct rockchip_iodomain_supply {
>>>>     int idx;
>>>>     };
>>>>    
>>>> +struct rockchip_iodomain_soc_data {
>>>> +	int grf_offset;
>>>> +	const char *supply_names[MAX_SUPPLIES];
>>>> +	void (*init)(struct rockchip_iodomain *iod);
>>>> +	int (*write)(struct rockchip_iodomain_supply *supply, int uV);
>>>> +};
>>>> +
>>>>     struct rockchip_iodomain {
>>>>     struct device *dev;
>>>>     struct regmap *grf;
>>>>     const struct rockchip_iodomain_soc_data *soc_data;
>>>>     struct rockchip_iodomain_supply supplies[MAX_SUPPLIES];
>>>> +	int (*write)(struct rockchip_iodomain_supply *supply, int uV);
>>>>     };
>>>>    
>>>> +static int rk3568_iodomain_write(struct rockchip_iodomain_supply *supply, int uV)
>>>> +{
>>>> +	struct rockchip_iodomain *iod = supply->iod;
>>>> +	u32 is_3v3 = uV > MAX_VOLTAGE_1_8;
>>>> +	u32 val0, val1;
>>>> +	int b;
>>>> +
>>>> +	switch (supply->idx) {
>>>> +	case 0: /* pmuio1 */
>>>> +	break;
>>>> +	case 1: /* pmuio2 */
>>>> +	b = supply->idx;
>>>> +	val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
>>>> +	b = supply->idx + 4;
>>>> +	val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
>>>> +
>>>> +	regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val0);
>>>> +	regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL2, val1);
>>>> +	break;
>>>> +	case 3: /* vccio2 */
>>>> +	break;
>>>> +	case 2: /* vccio1 */
>>>> +	case 4: /* vccio3 */
>>>> +	case 5: /* vccio4 */
>>>> +	case 6: /* vccio5 */
>>>> +	case 7: /* vccio6 */
>>>> +	case 8: /* vccio7 */
>>>> +	b = supply->idx - 1;
>>>> +	val0 = BIT(16 + b) | (is_3v3 ? 0 : BIT(b));
>>>> +	val1 = BIT(16 + b) | (is_3v3 ? BIT(b) : 0);
>>>> +
>>>> +	regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL0, val0);
>>>> +	regmap_write(iod->grf, RK3568_PMU_GRF_IO_VSEL1, val1);
>>>> +	break;
>>>> +	default:
>>>> +	return -EINVAL;
>>>> +	};
>>>> +
>>>> +	return 0;
>>>> +}
>>>> +
>>>>     static int rockchip_iodomain_write(struct rockchip_iodomain_supply *supply,
>>>>        int uV)
>>>>     {
>>>> @@ -136,7 +183,7 @@ static int rockchip_iodomain_notify(struct notifier_block *nb,
>>>>     return NOTIFY_BAD;
>>>>     }
>>>>    
>>>> -	ret = rockchip_iodomain_write(supply, uV);
>>>> +	ret = supply->iod->write(supply, uV);
>>>>     if (ret && event == REGULATOR_EVENT_PRE_VOLTAGE_CHANGE)
>>>>     return NOTIFY_BAD;
>>>>    
>>>> @@ -398,6 +445,22 @@ static const struct rockchip_iodomain_soc_data soc_data_rk3399_pmu = {
>>>>     .init = rk3399_pmu_iodomain_init,
>>>>     };
>>>>    
>>>> +static const struct rockchip_iodomain_soc_data soc_data_rk3568_pmu = {
>>>> +	.grf_offset = 0x140,
>>>> +	.supply_names = {
>>>> +	"pmuio1",
>>>> +	"pmuio2",
>>>> +	"vccio1",
>>>> +	"vccio2",
>>>> +	"vccio3",
>>>> +	"vccio4",
>>>> +	"vccio5",
>>>> +	"vccio6",
>>>> +	"vccio7",
>>>> +	},
>>>> +	.write = rk3568_iodomain_write,
>>>> +};
>>>> +
>>>>     static const struct rockchip_iodomain_soc_data soc_data_rv1108 = {
>>>>     .grf_offset = 0x404,
>>>>     .supply_names = {
>>>> @@ -469,6 +532,10 @@ static const struct of_device_id rockchip_iodomain_match[] = {
>>>>     .compatible = "rockchip,rk3399-pmu-io-voltage-domain",
>>>>     .data = &soc_data_rk3399_pmu
>>>>     },
>>>> +	{
>>>> +	.compatible = "rockchip,rk3568-pmu-io-voltage-domain",
>>>> +	.data = &soc_data_rk3568_pmu
>>>> +	},
>>>>     {
>>>>     .compatible = "rockchip,rv1108-io-voltage-domain",
>>>>     .data = &soc_data_rv1108
>>>> @@ -502,6 +569,11 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
>>>>     match = of_match_node(rockchip_iodomain_match, np);
>>>>     iod->soc_data = match->data;
>>>>    
>>>> +	if (iod->soc_data->write)
>>>> +	iod->write = iod->soc_data->write;
>>>> +	else
>>>> +	iod->write = rockchip_iodomain_write;
>>>> +
>>>>     parent = pdev->dev.parent;
>>>>     if (parent && parent->of_node) {
>>>>     iod->grf = syscon_node_to_regmap(parent->of_node);
>>>> @@ -562,7 +634,7 @@ static int rockchip_iodomain_probe(struct platform_device *pdev)
>>>>     supply->reg = reg;
>>>>     supply->nb.notifier_call = rockchip_iodomain_notify;
>>>>    
>>>> -	ret = rockchip_iodomain_write(supply, uV);
>>>> +	ret = iod->write(supply, uV);
>>>>     if (ret) {
>>>>     supply->reg = NULL;
>>>>     goto unreg_notify;
>>>>
>>>
>>
>>
>>
>>
>>
>>
>>
> 
