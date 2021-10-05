Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38D6423329
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 00:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236750AbhJEWGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 18:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbhJEWGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 18:06:33 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB98C061749
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 15:04:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id v17so2284365wrv.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 15:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=wWGT6wyYNrHQcVjKvvDi6depYNBPBPoEJbTYnS4YHRE=;
        b=oMaqA3o9QB94TpF7CppOdrcV4haz930ZF4+Q3iSjOXfqsmWCdei2kltW3OvQJU19kd
         /V59SHINqQjwDzbyAYjjrf4QWS5WUlsx8P3x9EXaatOnSqxvbEoepxQzx2stjYfASETq
         BUVIcAZvX2YPsATGazdGcy2Z3bnQxTYFcv4AMI7z55NhgW9pRgad2/PlOkB1Gw8p3NO0
         gB2f/Fr1QhgZTdCrnC3bIXpAqdllyjpvErazZEXE9l4pePYmnNroUlbFuvKibj+7197V
         HF0WJEU4IfhNkmwDqBhilfR/zAJIaHcHYgWMxYL8Nf4ZKIJKDkRFFGPbcdVXnIKxomtr
         xO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=wWGT6wyYNrHQcVjKvvDi6depYNBPBPoEJbTYnS4YHRE=;
        b=Sd+xGJCv5sbTT6yMl4UFnbhjA3ajiSxSA1N5lvfjiirpOY0BHdBJa0XbHb8Jt5BAOa
         oY0CL7nmgRhggWiPXl48XYO5dNXsBwzvxMHYnNg1li3k2+7lmuenK1hJR1+Etxkp64uM
         JgnpX/gQsZKwwOdQxLkghlXwA7Kw79HtyoHyRIDaDe9TDrvMN9Q3DF4/doQWL7lgaUeU
         0bnFQHr52yuE8m2Wj4XvbizJTC7XxewPtGvvwSarP4QxtUMl5LDBHBh1hzzhom54GQ/y
         ifFwNeZSVX9omHWlNwZUZsTpFmRiC8r9GlAkpOvi6bN//EJe0GnDtojDSAVBv5FSqdse
         1eVA==
X-Gm-Message-State: AOAM532NZ3zhA+bDbXt793k0NOhyLRHLa90HQe0zRWXGmwdqJiqzAN2x
        mf1CWF3kZwMbIw0dpLSpbWQ=
X-Google-Smtp-Source: ABdhPJy9S4jOKQChoQmLTDTvyvbf/rfKtqtNfqEC4t7BRNUobE80G3hGH22bvz5nxHqCc9dzxqYnuw==
X-Received: by 2002:adf:a292:: with SMTP id s18mr5861731wra.42.1633471480523;
        Tue, 05 Oct 2021 15:04:40 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id z79sm3216353wmc.17.2021.10.05.15.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Oct 2021 15:04:40 -0700 (PDT)
Message-ID: <82be310c-6e8f-8ec8-fbb0-a08ee62ae220@gmail.com>
Date:   Wed, 6 Oct 2021 00:04:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH 1/9] staging: r8188eu: remove an obsolete comment
Content-Language: en-US
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20211005200821.19783-1-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20211005200821.19783-1-martin@kaiser.cx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/21 22:08, Martin Kaiser wrote:
> The function that this comment describes is not present in the
> r8188eu driver. The comment can be removed.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/hal/usb_halinit.c | 15 ---------------
>   1 file changed, 15 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/hal/usb_halinit.c b/drivers/staging/r8188eu/hal/usb_halinit.c
> index 83813388de24..ab7b80144403 100644
> --- a/drivers/staging/r8188eu/hal/usb_halinit.c
> +++ b/drivers/staging/r8188eu/hal/usb_halinit.c
> @@ -624,21 +624,6 @@ static void _InitAntenna_Selection(struct adapter *Adapter)
>   	DBG_88E("%s,Cur_ant:(%x)%s\n", __func__, haldata->CurAntenna, (haldata->CurAntenna == Antenna_A) ? "Antenna_A" : "Antenna_B");
>   }
>   
> -/*-----------------------------------------------------------------------------
> - * Function:	HwSuspendModeEnable92Cu()
> - *
> - * Overview:	HW suspend mode switch.
> - *
> - * Input:		NONE
> - *
> - * Output:	NONE
> - *
> - * Return:	NONE
> - *
> - * Revised History:
> - *	When		Who		Remark
> - *	08/23/2010	MHC		HW suspend mode switch test..
> - *---------------------------------------------------------------------------*/
>   enum rt_rf_power_state RfOnOffDetect(struct adapter *adapt)
>   {
>   	u8 val8;
> 

Hi Martin,

patch looks good, just one note. The function RfOnOffDetect() is not
used and could be removed as well.

Regards,
Michael
