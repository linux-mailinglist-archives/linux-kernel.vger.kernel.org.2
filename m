Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52644AD2E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 13:09:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241544AbhKIMMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 07:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbhKIMMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 07:12:10 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FB8C061764
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 04:09:24 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id 1so35848354ljv.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 04:09:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=inlLdvzpkoaRfvqDwdO6AfqkbuKQgWLvBaKrT5vBfYk=;
        b=EBuzXgtUvQLReUBjLxFxKdPdPYPCcOlvCejKMTin63FG4IH10VVAZnb7nbzj3yUb/u
         AcprCIx829hd3wpJqtFkij64c8cAZqWS4E0jECZnMQAiWXHR7FzsNkew8yiY4ZhHPq2J
         yCnph55c5lZ2NqFTwgDfWOldpaT6GNVLsL77pyZXTEkdjFRl2eGarYFNTDiEgQP7h0wt
         Wm2nHwxnkiEPdGfHsITNQzw4CkoQOGqwPoXkEQzTDc5KjP2sow2XEv4ZEuTn6z9Skyfw
         zpzbxXzIkDYPjVaMVM2mnagFhJI4sL3jP6pCe9Bx0nRVINm/FHlXOraTJgEiQvtvOEyX
         5Ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=inlLdvzpkoaRfvqDwdO6AfqkbuKQgWLvBaKrT5vBfYk=;
        b=OVorVYXtDzTUz7basPJPiEbDgPJxYxmizOiGsX3L47nCvSGqIAp4gCdOJYMehVFY9y
         LbbhrQHX4hXPZPeoxUwp1cebMCzI4i9x/4GieNsxwViXI5aBAHXjh7TX+qPok0gWuJ9n
         JE4t/sP6t5J8B7DWmquQmXw8R5NSyOlGZVrchf2KvQ8D5OjgNePVtBBtBx98ZMJjpg3o
         wlQKHnli5+639jvcqDHQQ6gR26Ncwj2IakHOP2HEwL4p7As4i7svy7k0bnNPqCC4jut+
         XCcjb7pbA5hfZFUFYfWO+T7DhlvO8+Y9brrOhtvrhf/Jbe0gIj6eQ+OHSdl8W60wxEGw
         FHdw==
X-Gm-Message-State: AOAM531JCPDVq4Os4wWYD7bEu3NMXX8+Sdp3Gq/WRryuvjdAlzIzoOAn
        ABrf58zmb1LG7H73guUU2n4=
X-Google-Smtp-Source: ABdhPJzeds/S7/9nXN47o0qtmg1EMzrpqkvsglDR37h1QniEy4BVnJprmaj2aIOD9NojmKrUCzY2UA==
X-Received: by 2002:a05:651c:1548:: with SMTP id y8mr4933721ljp.458.1636459763068;
        Tue, 09 Nov 2021 04:09:23 -0800 (PST)
Received: from [192.168.1.11] ([94.103.224.112])
        by smtp.gmail.com with ESMTPSA id c1sm1809788ljr.111.2021.11.09.04.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 04:09:22 -0800 (PST)
Message-ID: <c2c36a95-be34-bcaf-0224-a513e33a902e@gmail.com>
Date:   Tue, 9 Nov 2021 15:09:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH] staging: r8188eu: remove unneeded variable
Content-Language: en-US
To:     cgel.zte@gmail.com, Larry.Finger@lwfinger.net
Cc:     phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211109115307.133100-1-deng.changcheng@zte.com.cn>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <20211109115307.133100-1-deng.changcheng@zte.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/9/21 14:53, cgel.zte@gmail.com wrote:
> From: Changcheng Deng <deng.changcheng@zte.com.cn>
> 
> Fix the following coccicheck review:
> ./drivers/staging/r8188eu/core/rtw_cmd.c: 66: 5-8: Unneeded variable
> 
> Remove unneeded variable used to store return value.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Changcheng Deng <deng.changcheng@zte.com.cn>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index e17332677daa..1b1c47f4a34e 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -62,8 +62,6 @@ static void c2h_wk_callback(struct work_struct *work);
>   
>   static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
>   {
> -	int res = _SUCCESS;
> -
>   	/* allocate DMA-able/Non-Page memory for cmd_buf and rsp_buf */
>   	atomic_set(&pevtpriv->event_seq, 0);
>   	pevtpriv->evt_done_cnt = 0;
> @@ -72,7 +70,7 @@ static int _rtw_init_evt_priv(struct evt_priv *pevtpriv)
>   	pevtpriv->c2h_wk_alive = false;
>   	pevtpriv->c2h_queue = rtw_cbuf_alloc(C2H_QUEUE_MAX_LEN + 1);
>   
> -	return res;
> +	return _SUCCESS;
>   }
>   

Shouldn't it return just void then?



With regards,
Pavel Skripkin
