Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 561A0426CC7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 16:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242369AbhJHOcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 10:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhJHOcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 10:32:22 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85249C061570
        for <linux-kernel@vger.kernel.org>; Fri,  8 Oct 2021 07:30:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v17so30434306wrv.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=xnJcxNPfIiTHc4TL8sbE9qRaCvaDY0qgDn9s/irtG9I=;
        b=JtczYzq9QTBW7C1xWLfAkfXkIoy8kUof6q2ih5L7NFgB3YICSpC1LwqJgGhSJU2TGL
         PitJ0TNadQFqmb9UCNnkn2EWUrd4+5B4h7cWcG3JegUCdzlcUqHRJ1oSXnzzRm6gcRtG
         H3Q+K8xgbEm/1fkWISueFPGTB6tL73SUqgNMGczQgspiycy+v/TqiigX3EpFKWC7gOAM
         1L/IObpyJlDIU5ZlEXPCFaO9MZz4QX0ZjCRb1RR0ARW/5Ae3qT3Tz+z+J1SJne7iJ2fU
         2hNDwYEgqIRIEzjkYrXJXXG6Wcq6KmWMJVs2jXvnsKe836F36mZgEQ5qQjyNHv9l/+kL
         yyJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xnJcxNPfIiTHc4TL8sbE9qRaCvaDY0qgDn9s/irtG9I=;
        b=ic+DCz8sOz6I7AiaUr3e8w2E9vO2hq9wjTTdvjt5eO/g0flNO7iv4V90/gQ+dNjB2e
         gdbonlsPa30WpJqi+eIxi9Dps/z2wgJnk2bsKYJHhbp5EqvlAztqPe5CfTZxkIAdR9JK
         ddQBxfpVek6uZdo0zFpF6LavUgGxXPeSSPOsK1U1osMMD1+ZfmibdUsTJmSbUvx3v8jJ
         ac2OvftVxn+B/fePw3lV0IVxUIiX645spjS+wFVUFKU6Ro30yg6P1CIvRsU1rkBQ2gmJ
         e9JDm14T1ayjK6q8mjblsfY73z/wjIMBEJ9cczhJJvRbUQrSHKkDwVRlviWfiuVWJfp5
         jmUg==
X-Gm-Message-State: AOAM533eUnEWvZAUuBk+7C07ZmO4khB4im75RKiHHUAeXNYqMVhD8Hqw
        OcdYBIBhlhgK2gYW/AhAFcajcRPr0no=
X-Google-Smtp-Source: ABdhPJzizMEdrHdk4/jj3c9G0AGxpDVdap48hZ5qVfYPnSlKeHdpvGOSQZb1N0mk51VvBBQIr18MMA==
X-Received: by 2002:a7b:cb4f:: with SMTP id v15mr3717901wmj.21.1633703424654;
        Fri, 08 Oct 2021 07:30:24 -0700 (PDT)
Received: from [192.168.2.177] ([206.204.146.29])
        by smtp.gmail.com with ESMTPSA id y23sm12061566wmi.16.2021.10.08.07.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Oct 2021 07:30:23 -0700 (PDT)
Message-ID: <b233115c-704a-df4c-9d75-70cebb80a53c@gmail.com>
Date:   Fri, 8 Oct 2021 16:30:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.2
Subject: Re: [PATCH] soc: mediatek: cmdq: Use mailbox rx_callback instead of
 cmdq_task_cb
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        Bibby Hsieh <bibby.hsieh@mediatek.com>,
        Dennis YC Hsieh <dennis-yc.hsieh@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
References: <20210915232722.10031-1-chunkuang.hu@kernel.org>
 <CAAOTY_8BZ9BgWeQVsD_01ioP8H16c1_QUb_+yniU_4Wp91Nc7A@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAAOTY_8BZ9BgWeQVsD_01ioP8H16c1_QUb_+yniU_4Wp91Nc7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chun-Kuang,

On 08/10/2021 16:15, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Please ignore this patch because this patch depend on [1] which would
> cause numerous warning message. So I would revert that patch in [2].
> 

Thanks for the head-ups. I'll ignore this patch.

Regards,
Matthias

> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/mediatek?h=v5.15-rc4&id=c1ec54b7b5af25c779192253f5a9f05e95cb43d7
> [2] https://patchwork.kernel.org/project/linux-mediatek/patch/20211007235310.14626-6-chunkuang.hu@kernel.org/
> 
> Regards,
> Chun-Kuang.
> 
> Chun-Kuang Hu <chunkuang.hu@kernel.org> 於 2021年9月16日 週四 上午7:27寫道：
>>
>> rx_callback is a standard mailbox callback mechanism and could cover the
>> function of proprietary cmdq_task_cb, so use the standard one instead of
>> the proprietary one. Client has changed to use the standard callback
>> machanism and sync dma buffer in client driver, so remove the proprietary
>> callback in cmdq helper.
>>
>> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>> ---
>>   drivers/soc/mediatek/mtk-cmdq-helper.c | 25 +------------------------
>>   include/linux/soc/mediatek/mtk-cmdq.h  |  5 +----
>>   2 files changed, 2 insertions(+), 28 deletions(-)
>>
>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
>> index 3c8e4212d941..c1837a468267 100644
>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>> @@ -425,34 +425,11 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt)
>>   }
>>   EXPORT_SYMBOL(cmdq_pkt_finalize);
>>
>> -static void cmdq_pkt_flush_async_cb(struct cmdq_cb_data data)
>> -{
>> -       struct cmdq_pkt *pkt = (struct cmdq_pkt *)data.data;
>> -       struct cmdq_task_cb *cb = &pkt->cb;
>> -       struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>> -
>> -       dma_sync_single_for_cpu(client->chan->mbox->dev, pkt->pa_base,
>> -                               pkt->cmd_buf_size, DMA_TO_DEVICE);
>> -       if (cb->cb) {
>> -               data.data = cb->data;
>> -               cb->cb(data);
>> -       }
>> -}
>> -
>> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>> -                        void *data)
>> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt)
>>   {
>>          int err;
>>          struct cmdq_client *client = (struct cmdq_client *)pkt->cl;
>>
>> -       pkt->cb.cb = cb;
>> -       pkt->cb.data = data;
>> -       pkt->async_cb.cb = cmdq_pkt_flush_async_cb;
>> -       pkt->async_cb.data = pkt;
>> -
>> -       dma_sync_single_for_device(client->chan->mbox->dev, pkt->pa_base,
>> -                                  pkt->cmd_buf_size, DMA_TO_DEVICE);
>> -
>>          err = mbox_send_message(client->chan, pkt);
>>          if (err < 0)
>>                  return err;
>> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
>> index ac6b5f3cba95..2b498f4f3946 100644
>> --- a/include/linux/soc/mediatek/mtk-cmdq.h
>> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
>> @@ -268,8 +268,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>>    * cmdq_pkt_flush_async() - trigger CMDQ to asynchronously execute the CMDQ
>>    *                          packet and call back at the end of done packet
>>    * @pkt:       the CMDQ packet
>> - * @cb:                called at the end of done packet
>> - * @data:      this data will pass back to cb
>>    *
>>    * Return: 0 for success; else the error code is returned
>>    *
>> @@ -277,7 +275,6 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>>    * at the end of done packet. Note that this is an ASYNC function. When the
>>    * function returned, it may or may not be finished.
>>    */
>> -int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>> -                        void *data);
>> +int cmdq_pkt_flush_async(struct cmdq_pkt *pkt);
>>
>>   #endif /* __MTK_CMDQ_H__ */
>> --
>> 2.25.1
>>
