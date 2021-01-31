Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43070309D35
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jan 2021 15:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbhAaOui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 09:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231784AbhAaOmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 09:42:01 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1716C061573;
        Sun, 31 Jan 2021 06:41:16 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f16so10456805wmq.5;
        Sun, 31 Jan 2021 06:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=uB1B85GVXF4hm57kJsML6NgUscm6tKCDkB6BQ+xO/Pg=;
        b=Gqo20ysB9Zki3cvJZoSV5RBT1g253IMdRYeuPUNejxtSpCsPa3Qpke59jxVc/U55nF
         ZqWeHTMmxZC6qnPrw+f4G7JLo/x7GYsJNrk2MqZwr7+1fWBTMZ29lzvTx5CnDFq63Eyx
         X1RseJJkUsdU6SvpZ5Oe5p6uYNB5AMF9HybdWxf4UjM84HAOn23On3XtH0L66KRj2djV
         G0+f7ibydEm2OFXufKz7HE0DnqgssBckxhYmyonwauRE6ZeLuagnss1StvI1RlWCcXE0
         dMQUuuJw7T1CHKSQ12V9JHx4V4gh2SlUcwV9sLxuBLO6ugGTZgJS24vjGfIhprhSTAO/
         PWAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uB1B85GVXF4hm57kJsML6NgUscm6tKCDkB6BQ+xO/Pg=;
        b=G/WB+9ECwWs0zLatNkcxoMDV9/KxtfE3tvLIRk2RrzXsNMRB3T8DOoO76SLZIYHOip
         kuQIiu/iTMVI5WCOcFzW+G9RLaPOUcYvNZUxqVxk43J5kkym2x+y7zmkKAbRVY0sfuaa
         xZ3ou5PdxwnWgOeoYaUvqaShEkJ/V8WF2A3MmI8KlfIou7zivGVU6k8JUi2fLV3uCtQY
         QKpkLUiNHsDdHUlqaYTbfZCLDFHe9PbFALD4MQtFZ/tETqqAEO+BBcoYt0Tk6vWlxL9I
         Ak501w62OdgGA9QsOE6ZZ7PdEo2JiugZl89sU3u4x902kS2U2L0tzpbqtgWsG7xF1jUV
         y0mg==
X-Gm-Message-State: AOAM531MH7f2bCXzaTOb+5YVlogRSC9cWThLXd5xuGqwA2MeGC5aO0AA
        wj7nEH2RkKY3+WS2KWI5cOA=
X-Google-Smtp-Source: ABdhPJyYfZp1SsKgSvo0+XE6ZvuyYfrwa9+hf5ijoRltuEV4edorWnJtXeZSTmgporFpKAL9FrOCNQ==
X-Received: by 2002:a1c:5608:: with SMTP id k8mr11126765wmb.91.1612104075759;
        Sun, 31 Jan 2021 06:41:15 -0800 (PST)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id 17sm17539884wmk.48.2021.01.31.06.41.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Jan 2021 06:41:15 -0800 (PST)
Subject: Re: [PATCH v2] soc: mediatek: cmdq: add address shift in jump
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        damon.chu@mediatek.com, dennis-yc.hsieh@mediatek.com
References: <1608712499-24956-1-git-send-email-yongqiang.niu@mediatek.com>
 <1608712499-24956-2-git-send-email-yongqiang.niu@mediatek.com>
 <1610070485.1574.10.camel@mhfsdcap03>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <1fa82248-9a7d-2808-0ad2-4f1ed1347192@gmail.com>
Date:   Sun, 31 Jan 2021 15:41:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <1610070485.1574.10.camel@mhfsdcap03>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/01/2021 02:48, Yongqiang Niu wrote:
> On Wed, 2020-12-23 at 16:34 +0800, Yongqiang Niu wrote:
>> Add address shift when compose jump instruction
>> to compatible with 35bit format.
>>
>> Fixes: 0858fde496f8 ("mailbox: cmdq: variablize address shift in platform")
>>
>> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
>> Reviewed-by: Nicolas Boichat <drinkcat@chromium.org>
>> ---
>>  drivers/mailbox/mtk-cmdq-mailbox.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mailbox/mtk-cmdq-mailbox.c b/drivers/mailbox/mtk-cmdq-mailbox.c
>> index 5665b6e..75378e3 100644
>> --- a/drivers/mailbox/mtk-cmdq-mailbox.c
>> +++ b/drivers/mailbox/mtk-cmdq-mailbox.c
>> @@ -168,7 +168,8 @@ static void cmdq_task_insert_into_thread(struct cmdq_task *task)
>>  	dma_sync_single_for_cpu(dev, prev_task->pa_base,
>>  				prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
>>  	prev_task_base[CMDQ_NUM_CMD(prev_task->pkt) - 1] =
>> -		(u64)CMDQ_JUMP_BY_PA << 32 | task->pa_base;
>> +		(u64)CMDQ_JUMP_BY_PA << 32 |
>> +		(task->pa_base >> task->cmdq->shift_pa);
>>  	dma_sync_single_for_device(dev, prev_task->pa_base,
>>  				   prev_task->pkt->cmd_buf_size, DMA_TO_DEVICE);
>>  
> 
> hi jassi
> 
> please confirm is there any question about this patch.
> if not, please apply this into next version, tks
> 

Please fix the subject line of your patch. It does not apply to
drivers/soc/mediatek and should be something like
mailbox: mediatek: cmdq: add address shift in jump

Thanks,
Matthias
