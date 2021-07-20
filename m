Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B093CFFEC
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhGTQbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 12:31:02 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57284 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhGTQ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 12:26:55 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id E657D1F43318
Subject: Re: [PATCH v2 6/7] soc: mediatek: mmsys: Add reset controller support
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     chunkuang.hu@kernel.org, hsinyi@chromium.org, kernel@collabora.com,
        drinkcat@chromium.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        jitao.shi@mediatek.com, linux-arm-kernel@lists.infradead.org
References: <20210714101141.2089082-1-enric.balletbo@collabora.com>
 <20210714121116.v2.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
 <039151e1f17676a101fb9c0682f5ee9fb8ad502d.camel@pengutronix.de>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <a3227633-626d-10f5-c190-86dbf36a469c@collabora.com>
Date:   Tue, 20 Jul 2021 19:07:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <039151e1f17676a101fb9c0682f5ee9fb8ad502d.camel@pengutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

Thank you to take a look

On 20/7/21 12:52, Philipp Zabel wrote:
> Hi Enric,
> 
> On Wed, 2021-07-14 at 12:11 +0200, Enric Balletbo i Serra wrote:
>> Among other features the mmsys driver should implement a reset
>> controller to be able to reset different bits from their space.
>>
>> Cc: Jitao Shi <jitao.shi@mediatek.com>
>> Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> The reset controller driver looks fine, just two questions below.
> 
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
>>  drivers/soc/mediatek/mtk-mmsys.h |  2 +
>>  2 files changed, 71 insertions(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-mmsys.c b/drivers/soc/mediatek/mtk-mmsys.c
>> index e681029fe804..6ac4deff0164 100644
>> --- a/drivers/soc/mediatek/mtk-mmsys.c
>> +++ b/drivers/soc/mediatek/mtk-mmsys.c
> [...]
>> @@ -91,6 +95,59 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
> [...]
>> +static int mtk_mmsys_reset(struct reset_controller_dev *rcdev, unsigned long id)
>> +{
>> +	int ret;
>> +
>> +	ret = mtk_mmsys_reset_assert(rcdev, id);
>> +	if (ret)
>> +		return ret;
>> +
>> +	usleep_range(1000, 1100);
> 
> Is this known to be enough for all IP cores that can be reset by this
> controller?
> 

This time is copied from the downstream kernel, so, tbh, I am not totally sure
is enough or needed. Let me try to reach the Mediatek people for if they can
answer this.


>> +	return mtk_mmsys_reset_deassert(rcdev, id);
>> +}
>> +
>> +static const struct reset_control_ops mtk_mmsys_reset_ops = {
>> +	.assert = mtk_mmsys_reset_assert,
>> +	.deassert = mtk_mmsys_reset_deassert,
>> +	.reset = mtk_mmsys_reset,
>> +};
>> +
>>  static int mtk_mmsys_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> @@ -111,6 +168,18 @@ static int mtk_mmsys_probe(struct platform_device *pdev)
>>  		return ret;
>>  	}
>>  
>> +	spin_lock_init(&mmsys->lock);
>> +
>> +	mmsys->rcdev.owner = THIS_MODULE;
>> +	mmsys->rcdev.nr_resets = 32;
> 
> Are all bits in the MMSYS_SW0_RST_B register individual reset controls?

Yes, all are individual reset controls, mostly related to display but not all
(i.e dsi, dpi ...)

Thanks,
  Enric

> 
> regards
> Philipp
> 
