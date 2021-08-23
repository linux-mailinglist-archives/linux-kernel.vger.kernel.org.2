Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075703F5151
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbhHWTfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhHWTfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:35:40 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1A6C061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:34:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g13so40114329lfj.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YTiAFWRRVrfUWa+NPdwyRjcdp95XfTThrmru59rQRP4=;
        b=OtUskdn+tupVIKM8ffV12tMdPZ4qCFGKcesGm+494ZH84W0vP4aFHONpxc95eQ83J1
         qDttJJM/5uaCUj58Auw3gYKkujLiH/i/iAxsQbZES/0K+BmwLod1u6DEF7pw3XK8k/K9
         I3nn71XQ0y4qGDHVTBWlEW4ZbymhvVHLwTnG3Jixu4PO7zTSkEBGEcvnPc0BeFHkuhDp
         491B4FZ8AfRfl7UjNOE8w1bSV7XiVfYpmBp5ML0LFS2hT17LypYOPckVv4x+SK9h7Kly
         iokVcRx9xLDEbp12GfUwTYB/BofdVLbdLXk+TjyYZ0A5ZbjdIHuCBYqXKPayP4lyViOk
         Gj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YTiAFWRRVrfUWa+NPdwyRjcdp95XfTThrmru59rQRP4=;
        b=VNmh4+DUypjG8vvm1vROsZ7KJjirRMNGjhfZID3qX36fmJNhFyBlxpJNB6oq0bf2El
         HR09mvY6G6T+A8C06/83wFf6pm0mATJxofhSHqgSMCPbGHlnAoc9VmtbLaeIQDWVBCqX
         7UKC209NR1GLcsltpAPtLOApNv5z03gUdl6WrCDuECgDtLcBSCNtQdiUTRdDn8J9ZfqO
         8oCt6lDTlEiLNEh6wC2xJP8bnFlLIPdEb89zTnyODUWoreShPhreo0/KAsnP95tmV+8G
         hWaivPpnZZGeCcVkv9hxmoD7hMjx7aku3Z0aSK4qOPIZlEGOFN5F74oFeDaAwz51rXUV
         SOJg==
X-Gm-Message-State: AOAM533OJWnwwQA6rsOpu6JIMuroqve6bl2OG3rP3vbYSzhiy4Bb4uEk
        YjWj9yyLe9D8RQ2K7cs5BKw=
X-Google-Smtp-Source: ABdhPJy58LdbAQzX7ZYi8R+IasnRGGxVInDUndIPI6tG/hZ581MPO1qy2qP0RYkvz6JN/lX3kG8KwQ==
X-Received: by 2002:ac2:5dd7:: with SMTP id x23mr25117026lfq.142.1629747296067;
        Mon, 23 Aug 2021 12:34:56 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id m17sm1554768ljp.80.2021.08.23.12.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:34:55 -0700 (PDT)
Subject: Re: [PATCH Linux-next] ioctl_linux: fix a potential NULL pointer
 dereference bug
To:     cgel.zte@gmail.com, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>, Zeal Robot <zealci@zte.com.cn>
References: <20210823030631.45517-1-xu.xin16@zte.com.cn>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <23609ad3-68bb-6df6-609d-5630597c7e0f@gmail.com>
Date:   Mon, 23 Aug 2021 22:34:54 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823030631.45517-1-xu.xin16@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 6:06 AM, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> The pointer might be NULL, but it is dereferenced.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> ---
>   drivers/staging/r8188eu/os_dep/ioctl_linux.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> index a3e6d761e748..ce4ce9190f5f 100644
> --- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> +++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
> @@ -4389,7 +4389,8 @@ static int rtw_dbg_port(struct net_device *dev,
>   				pregpriv->rx_stbc = extra_arg;
>   				DBG_88E("set rx_stbc =%d\n", pregpriv->rx_stbc);
>   			} else {
> -				DBG_88E("get rx_stbc =%d\n", pregpriv->rx_stbc);
> +				if (pregpriv)
> +					DBG_88E("get rx_stbc =%d\n", pregpriv->rx_stbc);
>   			}
>   		}
>   			break;
> @@ -4401,7 +4402,8 @@ static int rtw_dbg_port(struct net_device *dev,
>   				pregpriv->ampdu_enable = extra_arg;
>   				DBG_88E("set ampdu_enable =%d\n", pregpriv->ampdu_enable);
>   			} else {
> -				DBG_88E("get ampdu_enable =%d\n", pregpriv->ampdu_enable);
> +				if (pregpriv)
> +					DBG_88E("get ampdu_enable =%d\n", pregpriv->ampdu_enable);
>   			}
>   		}
>   			break;
> 


Hi, Xu!

I can't see how pregpriv can be NULL:

	struct registry_priv *pregpriv = &padapter->registrypriv;

It can be NULL in case of completely wrong padapter pointer, but I can't 
see how it's possible. Do you have a calltrace?

I guess, your robot reported this, because there is useless check in 
same code block:

	if (pregpriv &&
		(extra_arg == 0 ||
		 extra_arg == 1 ||
		 extra_arg == 2 ||
		 extra_arg == 3))


So, I think, "pregpriv &&" part should be removed, instead of adding 2 
branches.


Also, subject line should be "staging: r8118eu: <subject>". Thank you!



With regards,
Pavel Skripkin
