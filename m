Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDFA394B80
	for <lists+linux-kernel@lfdr.de>; Sat, 29 May 2021 12:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbhE2KDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 May 2021 06:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhE2KDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 May 2021 06:03:19 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6F8C061574
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 03:01:42 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h3so3393013wmq.3
        for <linux-kernel@vger.kernel.org>; Sat, 29 May 2021 03:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3x8KD9tiZBovAACWYlPdJwi9QZYQFi+hgtkneaG2VEY=;
        b=aYSYjg5w1ecI5eyL+x11ihUXzitD0LYtRFFYf1s4ZBJIFxeHnD311zSKjYaQdUEwsd
         LDiWAC86B9rG0L/H7oHseEslqlzJa6Z/ci0YOlLRzU5XAZCDsn77OuIBLq4GZJskt67n
         wYT+s7qtVylQa4jDQE1dTAMcWd9gYydKP+SRHJGW8qOXCY0AsJFQvsseUOITUZIEfnVH
         nIGGVTeq1gfxlmC9d/ePjF9XgV9zMPC7e9r8ieVKl+Ccs1XfVolZzgutUx9WVSI2Lpct
         ieUv9ICNVHrU2TQWfv27Z8+lhjXCIuGq1nYft5BELPxsNMKSbKABOEnEGHOIuBpTxEC5
         Aryw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3x8KD9tiZBovAACWYlPdJwi9QZYQFi+hgtkneaG2VEY=;
        b=NlU/qfEBTCFOw3jak4nsicm0BY+pw4K/vu4vCFHs0SGzRx+KS6saShJ4a3G8HdSDbN
         JUS6I+o4PqcxDh0ZCo0VolaFzSXmSykElfKzHES5AKI5XbfhPemFMe1WTyN/kBlt2uOd
         H9AEOAw1PFT7LtndU1b/TDojSMnc3RUhdkVG1ZrEB4zOpWPnUauqFlMqmvHxo1arDOKt
         0LmkUv4i7UETMEZZwcxQJ2lgkD9AkbI2MK7obgng1Ifo6R9+JvUDggvVTJOJhQ0UJ8w3
         moWe/5NBaJFxOz44dmII2jPcXchWEFY8skvkczDBv1iVcrGz6ncf6fDAL6EC9p75CX3/
         RDQQ==
X-Gm-Message-State: AOAM532TMZyTVK0LzxMuZ0LrYU0Jb0IPINB9NnWZuWPCMu+ELYcQgxsf
        Hc0mCb/N6qOskaAVoZh7ZhQ=
X-Google-Smtp-Source: ABdhPJwXPNNG9pNKDznnlhxNfRpU7nSxIgO22yTeMud4uMo12pMM8cdVgTiDhULaSyBaPJ7Qq0mogw==
X-Received: by 2002:a1c:6004:: with SMTP id u4mr9382148wmb.110.1622282501441;
        Sat, 29 May 2021 03:01:41 -0700 (PDT)
Received: from agape.jhs ([5.171.80.148])
        by smtp.gmail.com with ESMTPSA id p6sm9207035wma.4.2021.05.29.03.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 May 2021 03:01:41 -0700 (PDT)
Date:   Sat, 29 May 2021 12:01:38 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH] staging: rtl8723bs: core: rtw_mlme_ext.c: move the
 declaration and initialization of 'evt_seq' inside ifdef macro
Message-ID: <20210529100137.GA1416@agape.jhs>
References: <20210529092948.3134775-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210529092948.3134775-1-yukuai3@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu,

On Sat, May 29, 2021 at 05:29:48PM +0800, Yu Kuai wrote:
> 'evt_seq' is only used if 'CHECK_ENENT_SEQ' is defined, however,
> it's declared and initialized even if 'CHECK_ENENT_SEQ' is not
> defined. Thus gcc will report following warning if
> 'CHECK_ENENT_SEQ' is not defined:

the macro is mispelled in the commit description

> 
> drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:6009:15: warning:
>  variable ‘evt_seq’ set but not used [-Wunused-but-set-variable]
>  6009 |  u8 evt_code, evt_seq;
> 
> Thus move the declaration and initialization of 'evt_seq' inside
> ifdef macro to fix it.
> 
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>  drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> index 97b3c2965770..e883371cc96d 100644
> --- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> +++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
> @@ -6006,7 +6006,10 @@ static struct fwevent wlanevents[] = {
>  
>  u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  {
> -	u8 evt_code, evt_seq;
> +#ifdef CHECK_EVENT_SEQ
> +	u8 evt_seq;
> +#endif
> +	u8 evt_code;
>  	u16 evt_sz;
>  	uint	*peventbuf;
>  	void (*event_callback)(struct adapter *dev, u8 *pbuf);
> @@ -6017,18 +6020,17 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
>  
>  	peventbuf = (uint *)pbuf;
>  	evt_sz = (u16)(*peventbuf&0xffff);
> -	evt_seq = (u8)((*peventbuf>>24)&0x7f);
>  	evt_code = (u8)((*peventbuf>>16)&0xff);
>  
> -
> -	#ifdef CHECK_EVENT_SEQ
> +#ifdef CHECK_EVENT_SEQ
>  	/*  checking event sequence... */
> +	evt_seq = (u8)((*peventbuf>>24)&0x7f);
>  	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
>  		pevt_priv->event_seq = (evt_seq+1)&0x7f;
>  
>  		goto _abort_event_;
>  	}
> -	#endif
> +#endif
>  
>  	/*  checking if event code is valid */
>  	if (evt_code >= MAX_C2HEVT)
> -- 
> 2.25.4
> 
> 

this conditional block seems to be dead code, for
the symbolic constant CHECK_EVENT_SEQ is defined nowhere in
the code.

/staging$ grep -r CHECK_EVENT_SEQ .
./staging/rtl8723bs/core/rtw_mlme_ext.c:	#ifdef CHECK_EVENT_SEQ

so the variable can be safely removed together with
the dead code block.

thank you,

fabio
