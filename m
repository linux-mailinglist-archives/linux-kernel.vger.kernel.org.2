Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C779F3B7E12
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Jun 2021 09:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbhF3HdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Jun 2021 03:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbhF3Hc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jun 2021 03:32:56 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1404C061766
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:30:26 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id v5so2342592wrt.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jun 2021 00:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uoZ1WUDVsO5j3L2A6UWVibKKbNiZxvu5yviY4+gTGYE=;
        b=mFuTu8cYCRpK3WTmN3U8cUjLxF/qqH88tWNgT3OW99U+AP6Xrl5GcbQLBPRuI02ghQ
         +fKyCwn6cCcIg8JgusBRsQIlEfmRDD32UpKPr773y+SkvNwJEbxkrp8In/rjkbzoKPTN
         tSLZ53Y3dlSxpENFVCn5ry61XSWCMmMXaZBfnJdS6xBbSAbA1Wrab+QjsfjphzBYE2X1
         TYrsOdzSGE6p4OZKKwzNw3xdBglqqW3QttcTanSTWim8oOIGBaSi0XlXv4j917xaV8zg
         Zo3JTHDthJp5ttmbtZZwkhnKWCAiUUsp9XjsBNlRUnh0zIwQtmXD+B7nPK0tKR/mtcbl
         eprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uoZ1WUDVsO5j3L2A6UWVibKKbNiZxvu5yviY4+gTGYE=;
        b=OlpTJhzWq5LbSvyJq/H99CKepVpJ22oDZnoTbyNQzResT68s90ioCQuUKJFGh0RJQK
         /V8CAx5sRGU9T9G9eEnNDv1xG5rV2hR7FtkEFWyKeD802lAnnrIjf9Oxdduf4E1bxoeU
         MvxF7LbaOukZe/ughxoJUOk/4yRbSkalfHR6wsmPJ6HPwHRpEriz9s4GLsuEFDhxVaos
         3t10LdHTzNmDMruDlCPrExdmfE/U6FAcc5Osixy/U1ONp3eD61tye9r06wMUYjJDEKzW
         sau1OYIEeONyU3V18MT6Tfq2HxZVnGvrAPPitpWl0DxYtFody6TwIAYx56zEzCD46oyr
         aBGQ==
X-Gm-Message-State: AOAM532VnZWDUwYxjsCARfSGcjCVc/fMuvpZETvuWMdIDkdk/mom1oHH
        GAvFp7JJmIO+dRq4ogSV+C4=
X-Google-Smtp-Source: ABdhPJyb2cGN1cO7izSl2X+8WDXgoRdmSnJOHMtU5fYrIdSIakCFTb4UVZ4YbAWEIt1l/VFjXEwrCg==
X-Received: by 2002:a5d:5307:: with SMTP id e7mr15355083wrv.353.1625038225339;
        Wed, 30 Jun 2021 00:30:25 -0700 (PDT)
Received: from ziggy.stardust (static-55-132-6-89.ipcom.comunitel.net. [89.6.132.55])
        by smtp.gmail.com with ESMTPSA id 204sm20918177wma.30.2021.06.30.00.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jun 2021 00:30:24 -0700 (PDT)
Subject: Re: [PATCH] soc: mediatek: mmsys: Fix missing UFOE component in
 mt8173 table routing
To:     Eizan Miyamoto <eizan@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, eizan@chromium.org,
        linux-mediatek@lists.infradead.org, drinkcat@chromium.org,
        hsinyi@chromium.org, Collabora Kernel ML <kernel@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        linux-arm-kernel@lists.infradead.org
References: <20210625062448.3462177-1-enric.balletbo@collabora.com>
 <CAOak1e_z2Mr-OR3+ECvA_6VToMVptGczoMwsWpfJLVvkvJsDow@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <57fcd8ca-68de-9fc1-35c6-1ed0da42ad09@gmail.com>
Date:   Wed, 30 Jun 2021 09:30:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAOak1e_z2Mr-OR3+ECvA_6VToMVptGczoMwsWpfJLVvkvJsDow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/06/2021 02:16, Eizan Miyamoto wrote:
> Dear Enric,
> 
> Thanks so much for your hard work bisecting and crafting this patch.
> 
> I have verified that it fixes the DRM issues we were seeing on MT8173 with
> Linux 5.12.
> 
> Tested: Eizan Miyamoto <eizan@chromium.org>
> 

Applied to v5.13-next/fixes

Thanks!

> On Fri, Jun 25, 2021 at 4:24 PM Enric Balletbo i Serra <
> enric.balletbo@collabora.com> wrote:
> 
>> The UFOE (data compression engine) component needs to be enabled to have
>> the imgtec gpu driver working. If we don't enable it we see a black screen.
>> Looks like when we switched to use and array for setting the routing
>> registers in commit 440147639ac7 ("soc: mediatek: mmsys: Use an array for
>> setting the routing registers") we missed to add this component in the new
>> routing table, it was present before taht commit, so fix it by adding
>> this component in the mt8173 routing table.
>>
>> Fixes: 440147639ac7 ("soc: mediatek: mmsys: Use an array for setting the
>> routing registers")
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>> ---
>>
>>  drivers/soc/mediatek/mtk-mmsys.h | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/soc/mediatek/mtk-mmsys.h
>> b/drivers/soc/mediatek/mtk-mmsys.h
>> index a760a34e6eca..11388961dded 100644
>> --- a/drivers/soc/mediatek/mtk-mmsys.h
>> +++ b/drivers/soc/mediatek/mtk-mmsys.h
>> @@ -209,6 +209,9 @@ static const struct mtk_mmsys_routes
>> mmsys_default_routing_table[] = {
>>         }, {
>>                 DDP_COMPONENT_RDMA2, DDP_COMPONENT_DSI3,
>>                 DISP_REG_CONFIG_DSIO_SEL_IN, DSI3_SEL_IN_RDMA2
>> +       }, {
>> +               DDP_COMPONENT_UFOE, DDP_COMPONENT_DSI0,
>> +               DISP_REG_CONFIG_DISP_UFOE_MOUT_EN, UFOE_MOUT_EN_DSI0,
>>         }
>>  };
>>
>> --
>> 2.30.2
>>
>>
> 
