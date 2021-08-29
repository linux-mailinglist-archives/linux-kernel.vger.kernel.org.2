Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911403FAB37
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Aug 2021 13:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235251AbhH2LzO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Aug 2021 07:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbhH2LzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Aug 2021 07:55:12 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F5EC061575
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:54:20 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id c12so20482543ljr.5
        for <linux-kernel@vger.kernel.org>; Sun, 29 Aug 2021 04:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lbEorOrlI2mGQ5Txn1C6kpyLTzBDadvxKQZO/l6oGks=;
        b=WJnVFBhcbEam2tp0eu46inq8/Jm8q8EDNJjlGMmhnMZHfbSweG42uvA+Hqub6p+8Tb
         T3UVtU63LV2NH4gl06mHefZvK0g16JimcI6dzwj3IVMTXQZe9DpXnUJqdcVaRHO5tM8Q
         ERubTN9FnkGSOq7dJjMqRrmk0VNT2ibUnZ9P5NTSBd8t8WIRIO2DOdRcCh3X/TNrWD2W
         3AHoZFKvhuSCBrLXNljVnqOFy5Qk1HMk9joPq7ItyI9MBHc40UXI+txNrICgn5UQHQsh
         sYn63bVvHkE/QjM4KtBkejdWKyNou7fGXVItWJbMOykqYToQfuOzYntjvJYk1hH20hcv
         r7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lbEorOrlI2mGQ5Txn1C6kpyLTzBDadvxKQZO/l6oGks=;
        b=DPy1qnZ41gOCq0KIfA+5QTojr3ldxx5wNMvHS5WKf4wLPUZxqiwtxqwDMobVQnNTEZ
         qfjEEF0LICJIFX3pPau4+NNzQnj+2ou97gF+Z6rSPy660Q4KxDayx52YaTdGLAu1Sp9e
         +MM/1SijA8Ldv/BI2PXjycTkbWRNAHiiafnzpP1/wbNg58rJ1ke3BMpCVe4ag5+Kkine
         rBIUAKyDiAFIne8om8O0IkNg0ZO0xo9kWJdaNggt5VN/3ApkLFdib++4tNFDkdRnUAdN
         rmYaHMXDtcxT7UTEvom6iC2/twYt5Y33qu9n0ilUX+niN86Sv/igQh77T1DTg+MGYief
         XA0A==
X-Gm-Message-State: AOAM5327w1gX9gZsVCx6KoHNZKZbdOYsx97ZoX85WnChOjCPWQ2zTcab
        EwILlih5JAxgeajumVbl8yI10/ZZzp0=
X-Google-Smtp-Source: ABdhPJz+GIQgV9miNaW2+mKtQ01UIVUiFbYgZsJORmheKN+Asq2SDcUOkMGe9j7KyXLkwD/djwnJkA==
X-Received: by 2002:a2e:a4d1:: with SMTP id p17mr16089800ljm.82.1630238058094;
        Sun, 29 Aug 2021 04:54:18 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.213])
        by smtp.gmail.com with ESMTPSA id k8sm34028lja.57.2021.08.29.04.54.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Aug 2021 04:54:17 -0700 (PDT)
Subject: Re: [PATCH 2/3] staging: r8188eu: simplify c2h_evt_hdl function
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210828212453.898-1-phil@philpotter.co.uk>
 <20210828212453.898-3-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <19b08be7-964e-fdbc-93c8-825ad41e1ade@gmail.com>
Date:   Sun, 29 Aug 2021 14:54:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210828212453.898-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/21 12:24 AM, Phillip Potter wrote:
> Simplify c2h_evt_hdl function by removing majority of its code. The
> function always returns _FAIL anyway, due to the wrapper function it
> calls always returning _FAIL. For this reason, it is better to just
> return _FAIL directly.
> 
> Leave the call to c2h_evt_read in place, as without it, event handling
> semantics of the driver would be changed, despite nothing actually being
> done with the event.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 21 +++------------------
>   1 file changed, 3 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index ce73ac7cf973..b520c6b43c03 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1854,27 +1854,12 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
>   
>   static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
>   {
> -	s32 ret = _FAIL;
>   	u8 buf[16];
>   
> -	if (!c2h_evt) {
> -		/* No c2h event in cmd_obj, read c2h event before handling*/
> -		if (c2h_evt_read(adapter, buf) == _SUCCESS) {
> -			c2h_evt = (struct c2h_evt_hdr *)buf;
> +	if (!c2h_evt)
> +		c2h_evt_read(adapter, buf);
>   
> -			if (filter && !filter(c2h_evt->id))
> -				goto exit;
> -
> -			ret = rtw_hal_c2h_handler(adapter, c2h_evt);
> -		}
> -	} else {
> -		if (filter && !filter(c2h_evt->id))
> -			goto exit;
> -
> -		ret = rtw_hal_c2h_handler(adapter, c2h_evt);
> -	}
> -exit:
> -	return ret;
> +	return _FAIL;


Hi, Phillip!


Do we really need to return _FAIL every time? The only one caller of 
c2h_evt_hdl() does not rely on it's return value. Shouldn't we make this 
function return void to simplify the code?


BTW, this function does nothing now, as I understand. It reads to local 
buffer and returns. I think, it can be removed



>   }
>   
>   static void c2h_wk_callback(struct work_struct *work)
> 




With regards,
Pavel Skripkin
