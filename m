Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A982244103F
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Oct 2021 19:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhJaSqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Oct 2021 14:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbhJaSqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Oct 2021 14:46:33 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACE2C061570
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:44:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 205so25851493ljf.9
        for <linux-kernel@vger.kernel.org>; Sun, 31 Oct 2021 11:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8aTAAkMuUs0RdOXiLwf4tJufUX7GuELy7Kv75supmqg=;
        b=NzO9RbuDXUygHVtFmWZvfzoqrqwUuA4ZL4Nhh6EAP9yK8mx8dDS+mC2iRIe1w/Rld8
         cdOw6sMP7+w7Fl5SHcprEiPsPEc7JadQT+mpuAS0FoFJvyJSCfyymR/UpIBJs43AS4Q0
         bH3iombTNg++WzPjXmJVBVaVAqDbHya2Kdy0eLG/H8f+shW4mHfBBnkzkuDtEZBVhFQU
         cYP/WOZIeTAphqymIpXycWHcTqmaYJ3APT7q44dv9gm+mTcVEFixIej95bZ1Yuv8NkG/
         U73UgmH1yMq2TRUV4tTApyuhhsa+SCf8cEPCbrHi8v9DcOg3143q+frsRv1ddznSoJS+
         s1jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8aTAAkMuUs0RdOXiLwf4tJufUX7GuELy7Kv75supmqg=;
        b=FB0K4aCUPdr8XjPu1P/5llQ+nJbJ4nGDsNyZL/nrdaZOfNcDyQN1vGBLo2MFtvgNT6
         Bl2/xUyjsnkMpEkPumcVfzs0Fu+AwS1cutGpJLdjgRyuiFey/WkIpKB42ZnwQErA25TL
         MHOsTkq+kIWQ6pkvXGgukU6YKFGVkGlVIn47q9Ao19R/UBK8XuTTh4QjlEhnDL9vN9UY
         GwYkvdVKWDdzZpt+KEgcFWDLxwee3kT1Aj0LPQGWUmImQDa/ItRT8s/qhkrkad1FJAZ/
         7LSl8nMA2q78o4J8oRdaEztjETVEz5f3dG2uiqm0QOTCxO7QAIek50jwgDbv2ttFrTr/
         iDuA==
X-Gm-Message-State: AOAM531AB1xAZtx9nc3y9bRVzv7JkXwxiEzC0bsLZWXiYlLJByyRqJ78
        V2KRYaAX97k39vWkMBDgG98=
X-Google-Smtp-Source: ABdhPJxb7BEnnQRjcvQ1pw4Ug6ET4I1VThcTZvtnIpt3EgCITH57Nuk9wbPJh8Iqghw9kwW6zFJcPw==
X-Received: by 2002:a05:651c:10a:: with SMTP id a10mr12059502ljb.335.1635705839276;
        Sun, 31 Oct 2021 11:43:59 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.235.8])
        by smtp.gmail.com with ESMTPSA id z12sm1213298lfs.101.2021.10.31.11.43.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 11:43:58 -0700 (PDT)
Message-ID: <f26b4aec-c0a1-8c93-b34e-8b1a36ac81b3@gmail.com>
Date:   Sun, 31 Oct 2021 21:43:57 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] staging: r8188eu: os_dep: remove the goto statement
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        martin@kaiser.cx, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <YX7cCtVss2RWOJ/a@Sauravs-MacBook-Air.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/21 21:10, Saurav Girepunje wrote:
> Remove the goto statement from rtw_init_drv_sw(). In this function goto
> can be replace by return statement. As on goto label exit, function
> only return it is not performing any cleanup. Avoiding goto will
> improve the function readability.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/os_dep/os_intfs.c | 39 +++++++----------------
>   1 file changed, 12 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/os_intfs.c b/drivers/staging/r8188eu/os_dep/os_intfs.c
> index 1418c9c4916c..4b409479108e 100644
> --- a/drivers/staging/r8188eu/os_dep/os_intfs.c
> +++ b/drivers/staging/r8188eu/os_dep/os_intfs.c
> @@ -480,48 +480,34 @@ u8 rtw_init_drv_sw(struct adapter *padapter)
>   {
>   	u8	ret8 = _SUCCESS;
> 


Btw, this variable can be removed completely then. It's used only for:

ret8 = rtw_init_default_value(padapter);

with your patch applied, but rtw_init_default_value() always returns 
_SUCCESS.


> -exit:
>  	return ret8;
>  }


And just `return _SUCCESS;` here.



With regards,
Pavel Skripkin
