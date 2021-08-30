Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D852C3FB239
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 10:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234344AbhH3II1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 04:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbhH3II0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 04:08:26 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069F3C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:07:33 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id s12so24524879ljg.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 01:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+vcL9tYKe1ZIo7N6pQctcyl9Hmcff8TPIE29kJ24gKw=;
        b=nFXrAMQahPhUTPM4hAWzgct/nem5mq4iaUX3j6VqLoBBIM30vQ9zvYbRXfxg9aw3uj
         DX0AS9rJAzT4xOhn0uiIaSukoV6CVGIy+GqQqVfrJXml8UIFNgzDvmTjvR4WWtH6f+rR
         IenfKnlgzJyKrn3y6iRVZpW9muHEghp08q0svRbnlxSQwYNDG7kTbspv14KB2U6lkgth
         ZeVxHNa61iQFfns7ECuBiPAzWglxRx4v/Adi1vPj73p1TuFN15PUyIcKHTZEz1hiAAcB
         T8Oy8UVnz099EGevxXsIeBtRYVgY5RpH7h+mh4yU1QNS09b/shDHZpoQe8o64FeNWk75
         3InA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+vcL9tYKe1ZIo7N6pQctcyl9Hmcff8TPIE29kJ24gKw=;
        b=LkLABBQBgPGNr0r0NK8cfkibRnM4mESwIX09eAt8KCj4AiQgZm7U0RnpVbniNcQyjZ
         W+YLpNx2D0ks4Ysn4drheyngTSJnVW2Oixcex6XD02CEWr5Ctn43kZxoEpq+D3w+/rS3
         ZVaTH1h00vrVOOnuwAksI+dwa34QkRj0dhxuJoV5eK62VvjU4+sMQzqylDP/HqtJKakj
         HRt/KVUCp4V3JTHgye0qi2Wac89KUszJ4Cu5Lst9RVsu+Yn3lx28arhBZ7yG02qFhUBR
         pWTG9dmG2RIsFlHtGJWORze3zq9CGkxj2YdFaZKwBPaNIZMW9WhCbBW9ac2O3dzXahgt
         bAwg==
X-Gm-Message-State: AOAM531Mjd3jWI2SourUJUsYxawYI5Xbbvw8qeNz2Qausi/8HY6wNAvo
        ZCG21uo8c3tMrjBukgsPxZtgTuuSnyo=
X-Google-Smtp-Source: ABdhPJwcWiS+9BPT4g9vdnFCXiF5T1BVum0H3cs5hpPiw2I3EyldQCjKvxkBVU8RwIkeUMPF1UBNRw==
X-Received: by 2002:a2e:91d0:: with SMTP id u16mr19763610ljg.324.1630310851151;
        Mon, 30 Aug 2021 01:07:31 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.213])
        by smtp.gmail.com with ESMTPSA id c5sm1701108lji.67.2021.08.30.01.07.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Aug 2021 01:07:30 -0700 (PDT)
Subject: Re: [PATCH v2 2/3] staging: r8188eu: simplify c2h_evt_hdl function
To:     Phillip Potter <phil@philpotter.co.uk>, gregkh@linuxfoundation.org
Cc:     straube.linux@gmail.com, fmdefrancesco@gmail.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20210829234541.946-1-phil@philpotter.co.uk>
 <20210829234541.946-3-phil@philpotter.co.uk>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <c6050183-5659-ceea-06a0-c652635dec85@gmail.com>
Date:   Mon, 30 Aug 2021 11:07:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829234541.946-3-phil@philpotter.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/21 2:45 AM, Phillip Potter wrote:
> Simplify c2h_evt_hdl function by removing majority of its code. The
> function always returned _FAIL anyway, due to the wrapper function it
> calls always returning _FAIL, and its one caller doesn't use the return
> value, so this function should just have a return type of void.
> 
> Leave the call to c2h_evt_read in place, as without it, event handling
> semantics of the driver would be changed, despite nothing actually being
> done with the event.
> 
> Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Acked-by: Michael Straube <straube.linux@gmail.com>
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
> 
> V2: Changed return type to void, based on comment by Pavel Skripkin.
> 
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 23 +++--------------------
>   1 file changed, 3 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index ce73ac7cf973..14b74f92cd0f 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1852,29 +1852,12 @@ u8 rtw_c2h_wk_cmd(struct adapter *padapter, u8 *c2h_evt)
>   	return res;
>   }
>   
> -static s32 c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)
> +static void c2h_evt_hdl(struct adapter *adapter, struct c2h_evt_hdr *c2h_evt, c2h_id_filter filter)

filter is now unused and can be removed (anyway c2h_evt_hdl is called 
with filter == NULL)

Otherwise looks good

>   {
> -	s32 ret = _FAIL;
>   	u8 buf[16];
>   
> -	if (!c2h_evt) {
> -		/* No c2h event in cmd_obj, read c2h event before handling*/
> -		if (c2h_evt_read(adapter, buf) == _SUCCESS) {
> -			c2h_evt = (struct c2h_evt_hdr *)buf;
> -
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
> +	if (!c2h_evt)
> +		c2h_evt_read(adapter, buf);
>   }
>   
>   static void c2h_wk_callback(struct work_struct *work)
> 


With regards,
Pavel Skripkin
