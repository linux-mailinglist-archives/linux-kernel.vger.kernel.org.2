Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 637DC398AEF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Jun 2021 15:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFBNpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Jun 2021 09:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhFBNpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jun 2021 09:45:12 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD880C061574
        for <linux-kernel@vger.kernel.org>; Wed,  2 Jun 2021 06:43:14 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id a8so2533568ioa.12
        for <linux-kernel@vger.kernel.org>; Wed, 02 Jun 2021 06:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bQwWMdNiop3KR5deOzjW/qoaepwqcvp7jJfbHI3zXtY=;
        b=JPtMWY4kgGga8R41zy7szTr3zo7j99f+OfcMYf3jZwLVSe7eCz6+i5RKPqO9EFb/6f
         Ett0SsYxZ1oWEBSe4AY+D5FyHsE63ePBYY2wG2/WeUQ0OvKdU54hH9KzaMXgrumXCtrx
         OvCC+X92lFHRNMwzTd1/AE0BhtspPGgsL+eqE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bQwWMdNiop3KR5deOzjW/qoaepwqcvp7jJfbHI3zXtY=;
        b=UZ+WM2LI+V6Fd0jyWoPGmopqWr5Q7U+0rv+x9vM9+FinKY2YX0vkT3J+lH6kYIAOLr
         H+3JFBkmY5uLLBudQipPq6Xh6pmV/vgq/lEvpwXLhjQHFeGr0HDXpmMGGjvWSyIYtNcc
         rfkN9Dqmo+PEkVeUoYj8H1SUj7tamGZG8NCJCIZLGPwJuICrC05yS7E13P502TLBqyE9
         kDwtHCpm627dezHsNjrvLGmwdlSMatlqN/ogo30IujBsTKiXophmPRrApxmkxylStLd6
         aqw4dJS9qkEWfd55SYiR5GA6d17Icj6lq23eoozeyFqGUyMsh5zQg/InPDQxonXIFcbd
         hOYA==
X-Gm-Message-State: AOAM531PZdpNtsqt7me/717TPcXYCoPcHaPXr6s/0SKgIRVBQr5y3KEF
        wkGLHXENK65EGjlgejla2SAiDb7METNOjw==
X-Google-Smtp-Source: ABdhPJzI132qPNGQXEIRmSa3fSS7UK52IeTZVxH49vKtqdaD+xrMOSB2COZPmz0sKUk9M9cC2VPEtA==
X-Received: by 2002:a05:6638:343:: with SMTP id x3mr9697267jap.101.1622641393970;
        Wed, 02 Jun 2021 06:43:13 -0700 (PDT)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id i12sm51270ilk.22.2021.06.02.06.43.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jun 2021 06:43:13 -0700 (PDT)
Subject: Re: [PATCH] staging: greybus: fixed the coding style, labels should
 not be indented.
To:     sh4nnu <manikishanghantasala@gmail.com>
Cc:     Rui Miguel Silva <rmfrfs@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210602133659.46158-1-manikishanghantasala@gmail.com>
From:   Alex Elder <elder@ieee.org>
Message-ID: <9a3878fd-3b59-76f5-ddc7-625c66f9fee8@ieee.org>
Date:   Wed, 2 Jun 2021 08:43:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210602133659.46158-1-manikishanghantasala@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/21 8:36 AM, sh4nnu wrote:
> From: Manikishan Ghantasala <manikishanghantasala@gmail.com>
> 
> staging: greybus: gpio.c: Clear coding-style problem
> "labels should not be indented" by removing indentation.

These are not labels.

I don't really understand what you're doing here.

Can you please explain why you think this needs changing?

					-Alex

> Signed-off-by: Manikishan Ghantasala <manikishanghantasala@gmail.com>
> ---
>   drivers/staging/greybus/gpio.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/greybus/gpio.c b/drivers/staging/greybus/gpio.c
> index 7e6347fe93f9..4661f4a251bd 100644
> --- a/drivers/staging/greybus/gpio.c
> +++ b/drivers/staging/greybus/gpio.c
> @@ -20,9 +20,9 @@
>   struct gb_gpio_line {
>   	/* The following has to be an array of line_max entries */
>   	/* --> make them just a flags field */
> -	u8			active:    1,
> -				direction: 1,	/* 0 = output, 1 = input */
> -				value:     1;	/* 0 = low, 1 = high */
> +	u8			active:1,
> +				direction:1,	/* 0 = output, 1 = input */
> +				value:1;	/* 0 = low, 1 = high */
>   	u16			debounce_usec;
>   
>   	u8			irq_type;
> 

