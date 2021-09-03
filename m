Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9FF0400110
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 16:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349339AbhICOLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 10:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348889AbhICOLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 10:11:33 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7AF1C061757
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 07:10:33 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 70D2F1F44ED9
Subject: Re: [PATCH v3 6/7] soc: mediatek: mmsys: Add reset controller support
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Eizan Miyamoto <eizan@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20210825102632.601614-1-enric.balletbo@collabora.com>
 <20210825122613.v3.6.I15e2419141a69b2e5c7e700c34d92a69df47e04d@changeid>
 <ebbe37cb0188a7ea23608569ab083e65e0f95df6.camel@pengutronix.de>
 <CAAOTY__wg+dWi-4v4evyuWp1EVfj2bap3xtsHZdGET4Jf-MgEw@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fbca20f5-9e16-c302-0111-1d57f2a496b9@collabora.com>
Date:   Fri, 3 Sep 2021 16:10:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAAOTY__wg+dWi-4v4evyuWp1EVfj2bap3xtsHZdGET4Jf-MgEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nancy,

(again in plain text, sorry for the noise)

On 26/8/21 2:33, Chun-Kuang Hu wrote:
> Philipp Zabel <p.zabel@pengutronix.de> 於 2021年8月25日 週三 下午6:46寫道：
>>
>> On Wed, 2021-08-25 at 12:26 +0200, Enric Balletbo i Serra wrote:
>>> Among other features the mmsys driver should implement a reset
>>> controller to be able to reset different bits from their space.
>>>
>>> Cc: Jitao Shi <jitao.shi@mediatek.com>
>>> Suggested-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>  drivers/soc/mediatek/mtk-mmsys.c | 69 ++++++++++++++++++++++++++++++++
>>>  drivers/soc/mediatek/mtk-mmsys.h |  2 +
>>
>> Cc: Nancy - this patch clashes with [1], please coordinate.
>>
>> [1] https://lore.kernel.org/linux-arm-kernel/20210825100531.5653-11-nancy.lin@mediatek.com/
> 
> Enric's series is all reviewed or acked, so I think Nancy's series
> should base on Enric's series.
> 

Is it fine with you to base you patches on top of this patchset?

Thanks,
  Enric


> Regards,
> Chun-Kuang.
> 
>>
>> regards
>> Philipp
> 
