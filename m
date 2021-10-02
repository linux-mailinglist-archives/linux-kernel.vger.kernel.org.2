Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6582541FC9A
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 16:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233434AbhJBOti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 10:49:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbhJBOth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 10:49:37 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC90C0613EC
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 07:47:51 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m22so15023463wrb.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 07:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=EXaz91VynQUtGRPsCHnZ8KgaZZE30+maPa6ti159Xw8=;
        b=A0EEtQdfGdKXkSiA2YmVM3lrxZ8WjonbEkDaEM0noojVbtFezcwyjm/giS/x5jFHzA
         r9atcdK29SbUlmclYatqMn2taZuMdHobES0ILw+nteSgfPyYG8MTW683sT2HPxpYFy5+
         IBIz/mPBHkDS9cWXM7xj0iTXigmw5xEl0MtZlAKRdVAyM/o7u6E0L3/cRx89TGN2Qegs
         x+aWMXvvf/hot9PKClbO4qnnp+O8aIUSCwGxLSw9ENQln701wqHiYiLxYpAQ4YJHHdjV
         Rp9Cx9OqTX+dmdW3kicUHCnQPcfbQrTyKJR+xeAVhiMmW7KoCgEAugQFmkFeypE17YSb
         Hz+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=EXaz91VynQUtGRPsCHnZ8KgaZZE30+maPa6ti159Xw8=;
        b=KFal9mMu5kVXWQ/0hz9X1xqf67MQODX8qkpOQou/Yaild0UtpCbF8V0Z+ZZxO88VCZ
         /Me3W78wTjpFG0TXYMyTVltwgpH9xQaZymAmPUbOk7LxOG7nNv4i/swJhMaE2mAQcxKc
         dndT2q6GLHeL8/5UTsGERzOG9gQ2iIqaxsZ4+JgQaWkJMIfU4xTrlk9C6Io5JYgSFq/9
         40bdQ5tiDDsgzQHtDZ6m5ESd5jKIF57ndEyW/PWH4l1uWBmkISl1fySGmoNDV9AD/Qf0
         PhQXA6MD0cxV7y81OJx892O3wfPlbruwRoI1oAmYPiB4UgtJ7lfvSScfGM3TkmUc4QFb
         N5WQ==
X-Gm-Message-State: AOAM533Jf0FDSw2dstgXyUPvpkCD2QrQhy1gUdBtfyJAWS7c5XZyB8eF
        7kXArybXpR3bIuorThwc9Y8=
X-Google-Smtp-Source: ABdhPJw4+S3FgiR5OaMace3M/NZUE2SYcqkJFX/bGqMSRW/U3F0mRH/sF3C/Nt5JfBNGIvPFuIZvSA==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr3650589wru.436.1633186070068;
        Sat, 02 Oct 2021 07:47:50 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id y15sm2058296wrp.44.2021.10.02.07.47.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Oct 2021 07:47:49 -0700 (PDT)
Message-ID: <fb64de38-50e1-e0e7-0b13-42e2c2e43f3d@gmail.com>
Date:   Sat, 2 Oct 2021 16:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH] staging: r8188eu: core: remove power_saving_wk_hdl
 function
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YVhv5JiHovfdpNGg@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YVhv5JiHovfdpNGg@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/21 16:42, Saurav Girepunje wrote:
> Remove function power_saving_wk_hdl is it just calling rtw_ps_processor.
> Instead of power_saving_wk_hdl() call  rtw_ps_processor().
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
>   drivers/staging/r8188eu/core/rtw_cmd.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_cmd.c b/drivers/staging/r8188eu/core/rtw_cmd.c
> index 3a70776f3304..44a1df4f51d1 100644
> --- a/drivers/staging/r8188eu/core/rtw_cmd.c
> +++ b/drivers/staging/r8188eu/core/rtw_cmd.c
> @@ -1649,11 +1649,6 @@ u8 rtw_antenna_select_cmd(struct adapter *padapter, u8 antenna, u8 enqueue)
>   	return res;
>   }
> 
> -static void power_saving_wk_hdl(struct adapter *padapter, u8 *pbuf, int sz)
> -{
> -	 rtw_ps_processor(padapter);
> -}
> -
>   u8 p2p_protocol_wk_cmd(struct adapter *padapter, int intCmdType)
>   {
>   	struct cmd_obj	*ph2c;
> @@ -1890,7 +1885,7 @@ u8 rtw_drvextra_cmd_hdl(struct adapter *padapter, unsigned char *pbuf)
>   		dynamic_chk_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
>   		break;
>   	case POWER_SAVING_CTRL_WK_CID:
> -		power_saving_wk_hdl(padapter, pdrvextra_cmd->pbuf, pdrvextra_cmd->type_size);
> +		rtw_ps_processor(padapter);
>   		break;
>   	case LPS_CTRL_WK_CID:
>   		lps_ctrl_wk_hdl(padapter, (u8)pdrvextra_cmd->type_size);
> --
> 2.32.0
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
