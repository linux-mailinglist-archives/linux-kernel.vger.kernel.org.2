Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F4337EB65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 00:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379382AbhELT37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 15:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbhELQwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 12:52:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA55CC08C5E7
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:30:23 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id t18so24275616wry.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 09:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5hXKeS5OhmnmZTHSHZROuYQB/mQTrakWYc6A59BUOp8=;
        b=YX5csET7uK4OTwfsn9+uWVUPv7uQ3h1aN1mAwR6RqT7OaEeAj0LQdHsXsAHWF+DxGG
         0XzKRxKUrkdZcFdqKeyc99RijzscjefdsusUSinzkelNNfq7Js6xP5L/qYMCn2YWqTVR
         2rmjgRkKjLSwYdbuQv5iBx3RHV/LtNTi6yZZyDcBAyF+3OwlNQtejmLbkeGYaC11435n
         sphYKaycHj/cLlMm1A2nwFpZ5RK2DllEMJC9yWADQBoSJs6icvfVHuUchJ/SADT3IAdq
         jpcWCcEF6E4DgU5/RQAx5ztkxUkgZoxs7udoRAfWU2+8tvYutv1ahpnkKGs657+7Dn/Q
         ZxUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5hXKeS5OhmnmZTHSHZROuYQB/mQTrakWYc6A59BUOp8=;
        b=gTgLZta2TGXFDgkP/jMafdYSw6sxhmwHku9e75Aw6hd2+DZIOdchaw6bErTqxXbuoR
         OtG83LfVMuPMFFMLmsQsziq0JP7rhxBxYziQeIrFHVTRvp9oyyAIwWgGwzQpx3ew/kZk
         9Bq/Ufe6h7DMLP1HauNjmugKiiZlYWbB2Cm4trIOuyE00/Db/gumG3EVnuenq/hN38xz
         wvYGq2jpY4bWlxtFqNRBCfiPSfQ6rCEBpES5iTJIcCsSW5Y3rca3sa8e3NL+cV7ggNVY
         jUUCpP7vz105rXNjEbXBF3fAf9fzW+QaRhw0YWeYmLs3rwMaFIbgTRMqcq04TsvfX0rm
         3k3Q==
X-Gm-Message-State: AOAM531brEGuyG3zcdFTdirV5NqR7d1iUKIKNi02zvNcsaC/+cUIa5OF
        bggyLGyiQx/z745fxop4ZlZuVwcAl1ghZA==
X-Google-Smtp-Source: ABdhPJwyZun0CfXDHzD4lchN/yDs0NwNZ7wTZ7T+4EcPqfflRr0OZfSVj2FugRXxzS8evt5EUP+uPA==
X-Received: by 2002:a05:6000:2ae:: with SMTP id l14mr45833334wry.155.1620837022555;
        Wed, 12 May 2021 09:30:22 -0700 (PDT)
Received: from ziggy.stardust ([37.223.140.37])
        by smtp.gmail.com with ESMTPSA id n22sm6257999wmo.12.2021.05.12.09.30.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 May 2021 09:30:22 -0700 (PDT)
Subject: Re: [PATCH -next] soc: mediatek: add missing MODULE_DEVICE_TABLE
To:     Zou Wei <zou_wei@huawei.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1620705350-104687-1-git-send-email-zou_wei@huawei.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <88837f36-e285-a8b4-4e03-ea8c9c1adbf8@gmail.com>
Date:   Wed, 12 May 2021 18:30:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1620705350-104687-1-git-send-email-zou_wei@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/05/2021 05:55, Zou Wei wrote:
> This patch adds missing MODULE_DEVICE_TABLE definition which generates
> correct modalias for automatic loading of this driver when it is built
> as an external module.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>

Applied to v5.13-next/soc

Thanks

> ---
>  drivers/soc/mediatek/mtk-devapc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/soc/mediatek/mtk-devapc.c b/drivers/soc/mediatek/mtk-devapc.c
> index f1cea04..7c65ad3 100644
> --- a/drivers/soc/mediatek/mtk-devapc.c
> +++ b/drivers/soc/mediatek/mtk-devapc.c
> @@ -234,6 +234,7 @@ static const struct of_device_id mtk_devapc_dt_match[] = {
>  	}, {
>  	},
>  };
> +MODULE_DEVICE_TABLE(of, mtk_devapc_dt_match);
>  
>  static int mtk_devapc_probe(struct platform_device *pdev)
>  {
> 
