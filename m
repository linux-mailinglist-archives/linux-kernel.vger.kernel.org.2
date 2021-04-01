Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6173351238
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhDAJ2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbhDAJ2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:28:35 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76771C0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:28:35 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so2497780wml.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2rkOw5Dx1TINvXjRB+SiB7YZDBdwJ+e4cTjDJv7XxLk=;
        b=Kkl/wVVY/CWcsAXD8YzUvZ68ov4zSNmqyjBFYGm67pyuuH9d4pT0MdHIOSQXv0pHOO
         ZRjZSOfiv73ln2HcUdwL39tBVytU/0N5KciME3fJJM3bC5ltdbjVPA8F+Bem8c01jOvd
         u94DIHU4ghDz9rEibwoTCPdGJYGxmNwjGkN2LJPeh+u8+wjhUO33ZQKhtqAkpINDJu6r
         uPdMbRj4AEjNaRTMpGWT1eCrnHaV94TiAJK2NORYOg7LoFgLNY5VBvMbsKyP0g7JFYAB
         LmgfQEFlHVEJNw7aYhyQndV9U4KCa7B8PZCspL7QKmjyYCTfggiJ4+vHv9pY5/rBdCMJ
         ADHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2rkOw5Dx1TINvXjRB+SiB7YZDBdwJ+e4cTjDJv7XxLk=;
        b=gFxjREePl2D+VRCG+SJIZhDa1boULXjszhnD1SPZKUb6IuMwDU/N1GcPiGR1MDU25q
         xJNwdyWJH88aVT+M+0omNwB8kvhJhtbconQ+sPudB0MKk5PnD6WxA9b3wdJmlkvSBPJi
         4WerJeP0h17GJJnV1mtKbM1O1BKP3HKKzGWiziJQAk62ihTPrF1FmwW2ptwOTXiB1FV0
         XynHGPNoIydVlueHpJ0zWlrXI6dIm52aRCgvG1uy2G1LRRfXwDFYeeLCZQS5awgd1M0D
         LJU0dY0OmREEC7j2vi+vbxQzA84+ok7+naZEHIEeFkSKhOUeHOs6G7dNRXJiYbL4/ofF
         mI7g==
X-Gm-Message-State: AOAM530gu8noLR3YaZPmSJq4hvvKYYNKoCQJYy8Gg3qs/jr1dmjrp2QM
        JQ9lRcmR5rR7wCzMH8dwxwL70T+gEXVk+A==
X-Google-Smtp-Source: ABdhPJzPCsFAwf7ujt/gAxK0yWMBleixfbHx3YsvhYfgFARTDwByt+1NnYOjdpBffXveTask0jwj9w==
X-Received: by 2002:a7b:c2fa:: with SMTP id e26mr7003419wmk.102.1617269314149;
        Thu, 01 Apr 2021 02:28:34 -0700 (PDT)
Received: from ziggy.stardust ([213.195.126.134])
        by smtp.gmail.com with ESMTPSA id p6sm8831324wru.2.2021.04.01.02.28.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Apr 2021 02:28:33 -0700 (PDT)
Subject: Re: [PATCH -next] soc: mediatek: Make symbol 'mtk_mutex_driver'
 static
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>, CK Hu <ck.hu@mediatek.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20210210075656.1096251-1-weiyongjun1@huawei.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c22c6ae9-9bfc-570b-7b02-ec9c24963b89@gmail.com>
Date:   Thu, 1 Apr 2021 11:28:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210210075656.1096251-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/02/2021 08:56, Wei Yongjun wrote:
> The sparse tool complains as follows:
> 
> drivers/soc/mediatek/mtk-mutex.c:464:24: warning:
>  symbol 'mtk_mutex_driver' was not declared. Should it be static?
> 
> This symbol is not used outside of mtk-mutex.c, so this
> commit marks it static.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

Applied to v5.12-next/soc

Thanks!

> ---
>  drivers/soc/mediatek/mtk-mutex.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-mutex.c b/drivers/soc/mediatek/mtk-mutex.c
> index f531b119da7a..3a315a62e783 100644
> --- a/drivers/soc/mediatek/mtk-mutex.c
> +++ b/drivers/soc/mediatek/mtk-mutex.c
> @@ -461,7 +461,7 @@ static const struct of_device_id mutex_driver_dt_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, mutex_driver_dt_match);
>  
> -struct platform_driver mtk_mutex_driver = {
> +static struct platform_driver mtk_mutex_driver = {
>  	.probe		= mtk_mutex_probe,
>  	.remove		= mtk_mutex_remove,
>  	.driver		= {
> 
