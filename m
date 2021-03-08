Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E6D3309D7
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 10:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbhCHI76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 03:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbhCHI7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 03:59:52 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494D2C06174A;
        Mon,  8 Mar 2021 00:59:52 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id q14so15097196ljp.4;
        Mon, 08 Mar 2021 00:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dgyrcw/8dyMayFCPFJVLLcZhdVekLb7dMhsjcprcSec=;
        b=ao9aCzKSRVE3lehtYAAEJN1xg9IRGEmRWsmnuJ9GZ7DA6RtdR6i0OfQZA3zyq3KY1K
         1jyyCIsf8/NA9N9kXFWSL8O7mVPqyDwaDMgc2hpVUgLF46I+/QJRgdKQJsNSYAeDYFEM
         LsWwCSMlNIq16SQg+ZK1KlMhpy9hczAM7P+pA+PB0m04VxZov1m97sciYHMJf2fGED2c
         gV8PoaVz5EuavxU08+94dNymrzYj68KCPN2ZMo1JawcMQLZcT4GeHN+dtx+ubEs6i2RV
         iugCy0Ex71jBYg4eTY5gBFuH2eNhQdTfOhv47i/AAfAhUmlV+2WFbsqF8+pzy4VNJY4N
         CyrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Dgyrcw/8dyMayFCPFJVLLcZhdVekLb7dMhsjcprcSec=;
        b=ZuIHv4N90Wzx+Mc7kdHGsXl+Cdsm7ByOhELKoh9EmqVAV65juHliAmKx2u1T03OeOW
         bp9LSxirWCFcEzpf7lo9MkiE94ZNoTQiEkipe4Y4SdCOvBIFtwmy8ZfxoUb1074GaNaQ
         NjeCWHjJ2r35Pohj+wEUBmPrATMtVumTfUnIR7Zoh9IdRgyQMPAWqEqwvDPykGwfxazB
         bbTPmsFoPY9r3aMBLyV59HQulLL7L+ECgoNsjhEoIapghESTihtUwZj3wzKnWY5jGEt5
         ShZPnBAUBA0DW2TrZvJLb128Ko1aELqDBK/RHkQZdvDbsUzcXWP+bd2/DVrjUVk0u0mT
         a4vQ==
X-Gm-Message-State: AOAM532wnUD0qmTUTWUWfjlELwqaLX3ezJPdDL01Eq9kFUuXjjeaPRsV
        gHx0/NTbpC0v955C/iGFS7IHhy6ffss=
X-Google-Smtp-Source: ABdhPJzSPAtgnX514PvrGmlruGtmFh0ng/yM3Bk+k4gt0bTOQewgPsKG8nE2P2MCyRi7u7KtV8GfXw==
X-Received: by 2002:a2e:87c6:: with SMTP id v6mr13297799ljj.490.1615193990398;
        Mon, 08 Mar 2021 00:59:50 -0800 (PST)
Received: from [192.168.1.100] ([31.173.86.76])
        by smtp.gmail.com with ESMTPSA id y23sm1412493ljm.53.2021.03.08.00.59.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 00:59:50 -0800 (PST)
Subject: Re: [PATCH] usb: typec: tcpm: turn tcpm_ams_finish into void function
To:     Yang Li <yang.lee@linux.alibaba.com>, linux@roeck-us.net
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1615184481-102148-1-git-send-email-yang.lee@linux.alibaba.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Organization: Brain-dead Software
Message-ID: <0a15af59-2c28-e278-0127-ba76dd3cc2e6@gmail.com>
Date:   Mon, 8 Mar 2021 11:59:43 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <1615184481-102148-1-git-send-email-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 08.03.2021 9:21, Yang Li wrote:

> This function always return '0' and no callers use the return value.

    Returns.

> So make it a void function.
> 
> This eliminates the following coccicheck warning:
> ./drivers/usb/typec/tcpm/tcpm.c:778:5-8: Unneeded variable: "ret".
> Return "0" on line 794
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>   drivers/usb/typec/tcpm/tcpm.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index be0b646..6ee984e 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -773,10 +773,8 @@ static enum typec_cc_status tcpm_rp_cc(struct tcpm_port *port)
>   	return TYPEC_CC_RP_DEF;
>   }
>   
> -static int tcpm_ams_finish(struct tcpm_port *port)
> +static void tcpm_ams_finish(struct tcpm_port *port)
>   {
> -	int ret = 0;
> -
>   	tcpm_log(port, "AMS %s finished", tcpm_ams_str[port->ams]);
>   
>   	if (port->pd_capable && port->pwr_role == TYPEC_SOURCE) {
> @@ -791,7 +789,7 @@ static int tcpm_ams_finish(struct tcpm_port *port)
>   	port->in_ams = false;
>   	port->ams = NONE_AMS;
>   
> -	return ret;
> +	return;

    Just remove that *return*.

>   }
[...]

MBR, Sergei
