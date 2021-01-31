Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647DC309C62
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 14:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhAaNkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 08:40:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbhAaLjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 06:39:42 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B020FC061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 03:38:28 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c127so10726026wmf.5
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 03:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=agJUYTjcmgJDioolIIz4vd3FIPAvY+IwHgv8CbHcDPg=;
        b=Ew68ocghZkbijdxpyi2AnnqasQRwbahVq+sx9OZObwqfurNRThBgv1PyoQueJdJDIL
         dGyMlRZgivvbI8iW8ebfQlBuvsgpI/AIb3XEYkeYhNc+avLaPDhCVr0PGQ46+n8X4Uxw
         xdBrnqjaYtxh2pZypadEig7DCkhUWWbOcnwYQyoBwsmKo2p5zDCN2Cn8Ou0rtFz7f/vM
         rHwgtW415AwcchQyZ0qDvvvwVroVQzq9F+2NErKIF9IJwK/TWEN4LangbCnR34cr4PmB
         7PHtAqgkpNvaCUO41SFqWwLcC9z4dexZDYXTbVlS4vTLzyWwohsdQ2z2CEyJFHOKOOhF
         gdqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=agJUYTjcmgJDioolIIz4vd3FIPAvY+IwHgv8CbHcDPg=;
        b=bIcgnaFn1vcGW6ZCZ5/Gb+xOJT002rD8W8x4sLEmxfm37KAyJchhM/nzVLChoLGNjm
         RhlGAzzmQXbqS7dLMEkExBtnpR3Qcq9L+n31pJu9YDW/9w2IPJDDYdYrMYk6SU5VAMo/
         5HOD4XzE69pY2EBU7+279RZu9o3qm7Rn1hFHxsmhf+dh51+tlP6nHtpPL4weKc7xUbQa
         4awBXq5u3hSnyA3wodcEdClXazwzlbRW+pVQiuuRLu0iTDQE9YoR5rIvMeuLCPTyLQKb
         Mbzxmx4jMwjwuQ7VrTDqj1EGEZNf8aIrL0rNWcWH7SCKwNaUfwtSQLWjn27kH7cIA9xb
         sHVg==
X-Gm-Message-State: AOAM532K4hN1ueucTAJsMBviyD/sMXWwTTSfE0w0+rQm2km+1ljArgAh
        2vdOkPaZw5g2Qbgl7RQz1Nk=
X-Google-Smtp-Source: ABdhPJwlNaZKxEVHWWA1xfZSIl6heekF9PrvP8nEBGHYtJ0bSJDQpnG8bVJuBrvK6qXtoPQZ/pje+Q==
X-Received: by 2002:a7b:cb81:: with SMTP id m1mr10909110wmi.117.1612093107345;
        Sun, 31 Jan 2021 03:38:27 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id d17sm13281728wma.2.2021.01.31.03.38.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 03:38:26 -0800 (PST)
Subject: Re: [PATCH] soc: mediatek: cmdq: Remove cmdq_pkt_flush()
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
References: <20201202235856.7652-1-chunkuang.hu@kernel.org>
 <CAAOTY__p4C0ctXuOFu42-9HaTrGnOef-Sg47pyC0Uk7yN5406w@mail.gmail.com>
 <CAAOTY_9Qk8Bun9km1DRoCPMAwOJdJ2omsnMipS1jGzUrrrv=sg@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <11fac093-d40a-3e2e-169d-cf91645eb45f@gmail.com>
Date:   Sun, 31 Jan 2021 12:38:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <CAAOTY_9Qk8Bun9km1DRoCPMAwOJdJ2omsnMipS1jGzUrrrv=sg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/01/2021 10:45, Chun-Kuang Hu wrote:
> Hi, Matthias:
> 
> Chun-Kuang Hu <chunkuang.hu@kernel.org> 於 2021年1月10日 週日 上午6:59寫道：
>>
>> Hi, Matthias:
>>
>> Chun-Kuang Hu <chunkuang.hu@kernel.org> 於 2020年12月3日 週四 上午7:59寫道：
>>>
>>> rx_callback is a standard mailbox callback mechanism and could
>>> cover the function of proprietary cmdq_task_cb, so it is better
>>> to use the standard one instead of the proprietary one. But
>>> register rx_callback should before mbox_request_channel(),
>>> so remove cmdq_pkt_flush() and let client driver implement
>>> its own synchronous flush.
>>
>> How do you think about this patch? This patch is derived from [1]
>> according to Jassi's suggestion [2].
>>
>> [1] https://patchwork.kernel.org/project/linux-mediatek/patch/20200927230422.11610-3-chunkuang.hu@kernel.org/
>> [2] https://patchwork.kernel.org/project/linux-mediatek/cover/20200927230422.11610-1-chunkuang.hu@kernel.org/
> 
> Just a ping.
> 

Applied now to v5.11-next/soc

Sorry for the delay.
Matthias

> Regards,
> Chun-Kuang.
> 
>>
>> Regards,
>> Chun-Kuang.
>>
>>>
>>> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>>> ---
>>>  drivers/soc/mediatek/mtk-cmdq-helper.c | 32 --------------------------
>>>  include/linux/soc/mediatek/mtk-cmdq.h  | 12 ----------
>>>  2 files changed, 44 deletions(-)
>>>
>>> diff --git a/drivers/soc/mediatek/mtk-cmdq-helper.c b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> index 505651b0d715..fd3bc39538a1 100644
>>> --- a/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> +++ b/drivers/soc/mediatek/mtk-cmdq-helper.c
>>> @@ -502,36 +502,4 @@ int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>>>  }
>>>  EXPORT_SYMBOL(cmdq_pkt_flush_async);
>>>
>>> -struct cmdq_flush_completion {
>>> -       struct completion cmplt;
>>> -       bool err;
>>> -};
>>> -
>>> -static void cmdq_pkt_flush_cb(struct cmdq_cb_data data)
>>> -{
>>> -       struct cmdq_flush_completion *cmplt;
>>> -
>>> -       cmplt = (struct cmdq_flush_completion *)data.data;
>>> -       if (data.sta != CMDQ_CB_NORMAL)
>>> -               cmplt->err = true;
>>> -       else
>>> -               cmplt->err = false;
>>> -       complete(&cmplt->cmplt);
>>> -}
>>> -
>>> -int cmdq_pkt_flush(struct cmdq_pkt *pkt)
>>> -{
>>> -       struct cmdq_flush_completion cmplt;
>>> -       int err;
>>> -
>>> -       init_completion(&cmplt.cmplt);
>>> -       err = cmdq_pkt_flush_async(pkt, cmdq_pkt_flush_cb, &cmplt);
>>> -       if (err < 0)
>>> -               return err;
>>> -       wait_for_completion(&cmplt.cmplt);
>>> -
>>> -       return cmplt.err ? -EFAULT : 0;
>>> -}
>>> -EXPORT_SYMBOL(cmdq_pkt_flush);
>>> -
>>>  MODULE_LICENSE("GPL v2");
>>> diff --git a/include/linux/soc/mediatek/mtk-cmdq.h b/include/linux/soc/mediatek/mtk-cmdq.h
>>> index 960704d75994..2c6aa84c0e80 100644
>>> --- a/include/linux/soc/mediatek/mtk-cmdq.h
>>> +++ b/include/linux/soc/mediatek/mtk-cmdq.h
>>> @@ -288,16 +288,4 @@ int cmdq_pkt_finalize(struct cmdq_pkt *pkt);
>>>  int cmdq_pkt_flush_async(struct cmdq_pkt *pkt, cmdq_async_flush_cb cb,
>>>                          void *data);
>>>
>>> -/**
>>> - * cmdq_pkt_flush() - trigger CMDQ to execute the CMDQ packet
>>> - * @pkt:       the CMDQ packet
>>> - *
>>> - * Return: 0 for success; else the error code is returned
>>> - *
>>> - * Trigger CMDQ to execute the CMDQ packet. Note that this is a
>>> - * synchronous flush function. When the function returned, the recorded
>>> - * commands have been done.
>>> - */
>>> -int cmdq_pkt_flush(struct cmdq_pkt *pkt);
>>> -
>>>  #endif /* __MTK_CMDQ_H__ */
>>> --
>>> 2.17.1
>>>
