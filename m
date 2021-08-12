Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50103E9C25
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 04:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233591AbhHLCLj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 22:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhHLCLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 22:11:38 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B32B8C061765
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 19:11:13 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id o185so7742725oih.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Aug 2021 19:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5GiB0nkmPngUAvbft1awC2hg+CeJsutF1vU1ZSrat0c=;
        b=k/PKk/2vxaxihhhKQQtvFRLYr5FeLF3I2uPzm9uu/wftJFjLqIVV/qmLbDmfygC/Bu
         Nb+j3t469eBaRreksR8CnIqhKHDbJdl5B8KoRwIEQ8di9Daakq24pKniNgky+ZMpOau0
         TbBlXc8GutOpPD6v5D16TGt+YSVi+3KjngLnUw2l8/j+mdMPqCCgaZ7pkQ8oTBQJVcXe
         yedx9TO0fsOX5Y01VAKe/Pw3DKhCduPLRo08Q3aRFbT1k7qOahsrZjNnxNCqbl/1iiUn
         Nm2CfQa8Z6i7C9BCDEyqRB+yI9qnZdJMXcIolTMFY9/ck/QhikbAejI2jJXLXpkG7Ahm
         ZZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5GiB0nkmPngUAvbft1awC2hg+CeJsutF1vU1ZSrat0c=;
        b=b3btxMcxpgLEpB1m+JRME0X/p3VxASK2yCuie6fR6iSE7qm+I2MWes5jG+iRJZWfF9
         6zaM0nWM0qoyLscp5gI/MJLettfNlUJqQ20ecVtawkxxMM39EYcjlkT/08HaeUED6B0/
         CgpjC3ww4xOxgrRHZz1vxIetTZFhVMy6L8lwlqXPoT9+YVpt5lWB3K1jqpIF0q/7A1D3
         LllcS7EH/O71Ob9Zi57PlFU+rDPKArSMreJ+bS7JTng+sMShGG1n1t57gu5/af0b+JTs
         dUX1CictH4BUrV6iRpW39z9FpxbnxpDqqcql6G3Tdl69CVlRFtofk++zvqffk3BZ3gt6
         u38Q==
X-Gm-Message-State: AOAM533PWvSuaQGxbugRBBw48kcJiZk59MAdC4Byh4IPT2B/dEjMro3I
        8zMpEA/J1yTSnmrJGLXZ4qsOEkw6Dws=
X-Google-Smtp-Source: ABdhPJwN+e8mbsQltbZHIQkBcJg/F0pCQsg++hGvNSMb4GHEyzDPfMIr2E4Bf7yEyYyjyRO4Zu52gw==
X-Received: by 2002:a05:6808:2198:: with SMTP id be24mr3981642oib.1.1628734272917;
        Wed, 11 Aug 2021 19:11:12 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id r2sm291598oig.1.2021.08.11.19.11.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Aug 2021 19:11:12 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Subject: Re: [PATCH 2/3] staging: r8188eu: Remove code related to unsupported
 channels
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210812002519.23678-1-fmdefrancesco@gmail.com>
 <20210812002519.23678-3-fmdefrancesco@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
Message-ID: <3994854c-64fc-422d-402d-010f03dde2c0@lwfinger.net>
Date:   Wed, 11 Aug 2021 21:11:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812002519.23678-3-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/21 7:25 PM, Fabio M. De Francesco wrote:
> Remove all code related to unsupported channel
> bandwidths. rtl8188eu* NICs work only on 20 and
> 40 Mhz channels.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>   drivers/staging/r8188eu/include/odm.h    | 3 ---
>   drivers/staging/r8188eu/include/rtw_rf.h | 3 ---
>   2 files changed, 6 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/odm.h b/drivers/staging/r8188eu/include/odm.h
> index a1f8c7fe595c..4dadb22bcc89 100644
> --- a/drivers/staging/r8188eu/include/odm.h
> +++ b/drivers/staging/r8188eu/include/odm.h
> @@ -567,9 +567,6 @@ enum odm_security {
>   enum odm_bw {
>   	ODM_BW20M		= 0,
>   	ODM_BW40M		= 1,
> -	ODM_BW80M		= 2,
> -	ODM_BW160M		= 3,
> -	ODM_BW10M		= 4,
>   };
>   
>   /*  ODM_CMNINFO_BOARD_TYPE */
> diff --git a/drivers/staging/r8188eu/include/rtw_rf.h b/drivers/staging/r8188eu/include/rtw_rf.h
> index 0f790da7e0aa..48129da9c93f 100644
> --- a/drivers/staging/r8188eu/include/rtw_rf.h
> +++ b/drivers/staging/r8188eu/include/rtw_rf.h
> @@ -97,9 +97,6 @@ enum rf90_radio_path {
>   enum ht_channel_width {
>   	HT_CHANNEL_WIDTH_20 = 0,
>   	HT_CHANNEL_WIDTH_40 = 1,
> -	HT_CHANNEL_WIDTH_80 = 2,
> -	HT_CHANNEL_WIDTH_160 = 3,
> -	HT_CHANNEL_WIDTH_10 = 4,
>   };
>   
>   /*  */
> 

Acked-by: Larry Finger <Larry.Finger@lwfinger.net>

