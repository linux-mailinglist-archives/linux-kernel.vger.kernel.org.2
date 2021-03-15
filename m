Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C133ADB6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 09:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbhCOIiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 04:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhCOIiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 04:38:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C6C061574;
        Mon, 15 Mar 2021 01:38:14 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id r20so15189251ljk.4;
        Mon, 15 Mar 2021 01:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:organization:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZqtyTSijaj7c70zMRsWX48OWS1YfHjmFQK2yaN4yX4A=;
        b=Lu+fGuzz0T0n4+w6C0NNeqEWrcWz2zbqf5h6hMXMIscGDDAxUIL5J56TDsDOh1jjau
         ooYOdY/gPNTEm7GgPK3WIOlKqigCzT2yUrWN3bj11JIYtRMdKYIpdrWqyMZMwN0MGIxi
         uUa1tqi14kYLlnUy9QNnpvXKpn+M9HhaqNCl5KykMQp/EKL8RMzlS4D9I6sEjU9MoLiB
         UYf2pfPp9An9F6esdOOVb4416ysEiNyR4mySpe3DXMRzk/MHlwLMnReguYslvSTq10AC
         XNDiIEFzJvuccQYauyvT8UzjEsdCOIrXz0tryAReGn8dE4tjuh1SvS7rt0r3j1y8SsLi
         jNxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZqtyTSijaj7c70zMRsWX48OWS1YfHjmFQK2yaN4yX4A=;
        b=gi1PsJpy3sgzC0gZ1Emkr51FpDUbGCunoSlTzJPGr93xfMktX7SYrNXOOe5s/BkUkh
         bBKe9LfqH2SsfVFFbgYKowKRkuSrR6VQn8NT4BCnZs8Y9dbbTNcHPMtuZbTzIeQ0MW/3
         GeF2RQEtJzt4BEseJGsVSd+9jxU+72waiFj+2VjfRRbx3bseg1P39wv+euHj4/pFKPET
         aJyqgZIFr9giVGnVGUMSmvexpH791pDxnkDisxmQHZJcFGf+1mrcPtlt2tz3xHO7VxWH
         jQlHPu1RsyhlZyMWHFH4dXvJsWs/XGe8GWhRiQEt8RqtNv95kbkM8rupBqIQP9K6p5nw
         D5JQ==
X-Gm-Message-State: AOAM532x4j9WlkT1mh7XKgTuNoF43Cdz7bWUxTVa9QvV001GSbbT67rZ
        0KCRLwnNHWNCDRk0xVdOngeQ8n9D/yg=
X-Google-Smtp-Source: ABdhPJw7a7MV/j2URRULWte16VgWVc5lhlMe8l7gWEUXQ9c96REVtNxJoALX1N9sUB5CMaLNp0ZLzQ==
X-Received: by 2002:a2e:864e:: with SMTP id i14mr10136238ljj.15.1615797492461;
        Mon, 15 Mar 2021 01:38:12 -0700 (PDT)
Received: from [192.168.1.100] ([178.176.75.241])
        by smtp.gmail.com with ESMTPSA id b1sm2589193lfe.282.2021.03.15.01.38.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 01:38:12 -0700 (PDT)
Subject: Re: [PATCH V3] ata: sata_highbank: delete redundant print and fix
 return value
To:     Wang Qing <wangqing@vivo.com>, Jens Axboe <axboe@kernel.dk>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615775955-4400-1-git-send-email-wangqing@vivo.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <c03f9a60-779c-6cdf-a16d-0309823ebc08@gmail.com>
Date:   Mon, 15 Mar 2021 11:38:10 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <1615775955-4400-1-git-send-email-wangqing@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15.03.2021 5:39, Wang Qing wrote:

> platform_get_irq() has already checked and printed the return value,
> the printing here is nothing special, and should corrected to < 0.
> 
> Also, thhe return value should return a real error.

    The.
    It's a bad idea to mix the fix and cleanup in one patch (and to do two 
things in one patch as well); also describing a bug fix as an "appendage"
to the clean up. Anyway, I had already posted the fix here:

https://marc.info/?l=linux-ide&m=161575450917827

> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>   drivers/ata/sata_highbank.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/sata_highbank.c b/drivers/ata/sata_highbank.c
> index 64b2ef1..4438ee6
> --- a/drivers/ata/sata_highbank.c
> +++ b/drivers/ata/sata_highbank.c
> @@ -469,10 +469,8 @@ static int ahci_highbank_probe(struct platform_device *pdev)
>   	}
>   
>   	irq = platform_get_irq(pdev, 0);
> -	if (irq <= 0) {
> -		dev_err(dev, "no irq\n");
> -		return -EINVAL;
> -	}
> +	if (irq < 0)
> +		return irq;

    What about irq == 0?
   [...]

MBR, Sergei
