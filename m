Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1F543FEC8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 16:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhJ2O65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 10:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbhJ2O64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 10:58:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C2C061570
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:56:28 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id oa4so7387412pjb.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 07:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Psdok0lolc/DRk6gfEZkpmxNT4+m/VOYNLeCH1dS5Kw=;
        b=c88mFZGRY94DlJQosTNHHqjAM1zsfGZjFnJpNLRb9jvir3ir+OsuQ93qUFRiVZ5w+9
         CD796z/24q/IZg+sWZjvP4DpkNAuePSXi3T9a0Sqcjo0kzOuxXXvFt0KFZSSf1EvAkRy
         xl1LASVrzVLZReVmf2Few2Z3u2t9igt7q+sflgo734CGMnuuNiWhnyz3ZbSm0pkHTExl
         PILHvtrgyzvMYLr2EYCecdnNjLN946sFlahG/KODZOKlMh5KIDggHVSW1ogSlR7RFO8I
         AKbQjROVoBiBgYrt70Sy6gxsWGjho2R44tMNw44vA1OzBOeEE0wiPIzXALmPNfWUkWfr
         VL4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Psdok0lolc/DRk6gfEZkpmxNT4+m/VOYNLeCH1dS5Kw=;
        b=l0ijKtAbSvupwK0fohgRjmXaivU5vI37XVRUpux3k9EA0bBxYKoYTYNtGYwK3CNyl6
         1P7pWqr04zW68DVPhdZqzD7Z3VRDw+6i0aAv/JLGcxr62LMdg1kuHYNMt//ZlhoKhvZW
         fL4JLSbKtfS73LxalPYotM17WsI14VH3H/txA/a2wLqWYwA6xBZ3Wr5wuGxPVyFAqIoV
         kmQJGbwP/dY9vANVUJF6NYSORU3aYBvGfPZwL0Gg02qHl9heFxa/eICDkkBbP8JLFfSg
         MAB+tXjRcdjPRcv0h4NB1+nF99a6yYVsuJwqUIYBMbGw6OCJXyrVYhXbyaAI+LyP2GPD
         NWNg==
X-Gm-Message-State: AOAM531eSvd02G+IK3+eXLHGqoXO/CjSyesnW/c8MXb8lvxheBWa2+co
        VKPa1WdM2JLGBGmGTbpsBVI=
X-Google-Smtp-Source: ABdhPJxH7iZHXSjXfXBNmzCTRFr8GmtBzCMxOSDuAAWI62URFuLO40iVem+2gcbB01YfzS9M88bwOw==
X-Received: by 2002:a17:902:e806:b0:141:5df8:c535 with SMTP id u6-20020a170902e80600b001415df8c535mr10263327plg.9.1635519387911;
        Fri, 29 Oct 2021 07:56:27 -0700 (PDT)
Received: from ?IPV6:2405:201:d007:e827:3d78:7315:8c23:fdaf? ([2405:201:d007:e827:3d78:7315:8c23:fdaf])
        by smtp.gmail.com with ESMTPSA id v8sm6462465pjd.7.2021.10.29.07.56.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 07:56:27 -0700 (PDT)
Message-ID: <3dfc45e5-12bc-72da-a260-5551a483fe6e@gmail.com>
Date:   Fri, 29 Oct 2021 20:26:25 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [Outreachy kernel] [PATCH 2/7] staging: vt6655: Use
 incrementation in `idx`
Content-Language: en-US
To:     Karolina Drobnik <karolinadrobnik@gmail.com>,
        outreachy-kernel@googlegroups.com
Cc:     gregkh@linuxfoundation.org, forest@alittletooquiet.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1635415820.git.karolinadrobnik@gmail.com>
 <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635415820.git.karolinadrobnik@gmail.com>
From:   Praveen Kumar <kpraveen.lkml@gmail.com>
In-Reply-To: <c569952d92ba51f32679c2fd87fd48ad8e49e3fc.1635415820.git.karolinadrobnik@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-10-2021 16:05, Karolina Drobnik wrote:
> Increment `idx` in a loop instead of adding the loop counter
> `i` to do so. Thanks to this change, the cast to unsigned short
> can be removed.

> 
> Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
> ---
>  drivers/staging/vt6655/rf.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/rf.c b/drivers/staging/vt6655/rf.c
> index f195dafb6e63..c07653566d17 100644
> --- a/drivers/staging/vt6655/rf.c
> +++ b/drivers/staging/vt6655/rf.c
> @@ -700,11 +700,11 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
>  			return false;
>  
>  		for (i = 0; i < CB_AL2230_INIT_SEQ; i++)
> -			MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_init_table[i]);
> +			MACvSetMISCFifo(priv, idx++, al2230_init_table[i]);
>  
> -		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_channel_table0[channel - 1]);
> +		MACvSetMISCFifo(priv, idx++, al2230_channel_table0[channel - 1]);
>  		i++;
> -		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al2230_channel_table1[channel - 1]);
> +		MACvSetMISCFifo(priv, idx++, al2230_channel_table1[channel - 1]);
>  		break;
>  
>  		/* Need to check, PLLON need to be low for channel setting */
> @@ -717,17 +717,17 @@ bool RFvWriteWakeProgSyn(struct vnt_private *priv, unsigned char rf_type,
>  
>  		if (channel <= CB_MAX_CHANNEL_24G) {
>  			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> -				MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_init_table[i]);
> +				MACvSetMISCFifo(priv, idx++, al7230_init_table[i]);

If I'm not wrong, there is a problem here, we are using the modified idx value here, instead of original which is *MISCFIFO_SYNDATA_IDX*.
I don't see idx value being reset either. Am I missing something ?

Further, this bring a question, how are you validating or planning to validate these changes ?

>  		} else {
>  			for (i = 0; i < CB_AL7230_INIT_SEQ; i++)
> -				MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_init_table_a_mode[i]);
> +				MACvSetMISCFifo(priv, idx++, al7230_init_table_a_mode[i]);
>  		}
>  
> -		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table0[channel - 1]);
> +		MACvSetMISCFifo(priv, idx++, al7230_channel_table0[channel - 1]);
>  		i++;
> -		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table1[channel - 1]);
> +		MACvSetMISCFifo(priv, idx++, al7230_channel_table1[channel - 1]);
>  		i++;
> -		MACvSetMISCFifo(priv, (unsigned short)(idx + i), al7230_channel_table2[channel - 1]);
> +		MACvSetMISCFifo(priv, idx++, al7230_channel_table2[channel - 1]);
>  		break;
>  
>  	case RF_NOTHING:
> 

Regards,

~Praveen.
