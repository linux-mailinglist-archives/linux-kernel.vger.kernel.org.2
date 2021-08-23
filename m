Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 221493F5153
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 21:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhHWTgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 15:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbhHWTgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 15:36:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434BEC061575
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:35:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id k29so27795965wrd.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 12:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5aJIU45FbDH+4PMzPrOxxvTKWlGFVwAzGeiDLaD41k0=;
        b=lAGhEoYZIl2Ie7hO48KDMvxIjOcn0/C4lr2t2yRDHqDKSjRqf37nU02YJ0kA3DLv7t
         kLFybcA9GC6SMWIDTYWbqMCY0hbm89mU0uJyj5h9RMmnuqHT8kykedxirxLXqyeZQESZ
         LbyClQcJU6ZGelz9gQtQy5X9iVanwKMzn4W+6pc3UqjafmyTEPdck69eRI4pcPjqLwVK
         tTGJwaZV0PnK/v0OLNWyLkKW4t+3D/vwTJYJLyp3dG+HNlmbfvKdKXfn9NuXMV2k3VFX
         o4tlHhu6KTKKB5eQ8Yl8Rg1FjMzZoffoLJGrqkOusYL/G/uvrBM6dGlu2vPS6CrTQCog
         HM1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5aJIU45FbDH+4PMzPrOxxvTKWlGFVwAzGeiDLaD41k0=;
        b=PafnVRoue9a7UA3vpfXSoNaX99JR536BYFTP3pscdnzvDZyC9P9VcLm6Zq5WmrsLyO
         BGU6BuLwvVkfwn5Qna19wvxFHDWKz2L1kytsdRfeaqrXswZtmYdJPVXQ4VaoBz0NZF+F
         69OAnkjqCo6p8B+a7iUQrOHoynyuFIR4BHuLJAVsDMfxx7gx8uo2oFVldQfD/FGZk8jx
         PCgxRyz80hnvuOKd08BdXEXxyYgGY3wlXFf96aO23r10oeUI+exyTEAr8ITpUllAxooR
         pup93P/GgwDHqm+koFyTYmYAEotiiSWEAv3uUJoPEpVnp7ivtN1NC+LOaQnXhHXqvDn3
         OnNQ==
X-Gm-Message-State: AOAM530kUZKxtpQft0g4h4n7VB1Sr0aVOOsr2QnFBE6LoLssi36MTMqn
        ADo85AP9jtzHzJKVzogWMnuqfkblQx8=
X-Google-Smtp-Source: ABdhPJywIJYbxkHiK7gragRF97lVPMSpwj9XblpvzAikHbFSFGDRdVqiCQqu4idcJvzdNYrGC1m7uA==
X-Received: by 2002:a05:6000:120d:: with SMTP id e13mr15488253wrx.6.1629747324915;
        Mon, 23 Aug 2021 12:35:24 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::3c39? ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id n14sm5615292wrx.10.2021.08.23.12.35.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Aug 2021 12:35:24 -0700 (PDT)
Subject: Re: [PATCH] staging: r8188eu: make rtw_deinit_intf_priv return void
To:     Pavel Skripkin <paskripkin@gmail.com>, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210823184059.19742-1-paskripkin@gmail.com>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <e01ea557-b006-a5b9-884a-81670376fe6c@gmail.com>
Date:   Mon, 23 Aug 2021 21:34:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823184059.19742-1-paskripkin@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/23/21 8:40 PM, Pavel Skripkin wrote:
> rtw_deinit_intf_priv() always return success, so there is no need in
> return value
> 
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
>   drivers/staging/r8188eu/os_dep/usb_intf.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
> index e002070f7fba..37694aa96d13 100644
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -129,13 +129,10 @@ static u8 rtw_init_intf_priv(struct dvobj_priv *dvobj)
>   	return rst;
>   }
>   
> -static u8 rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
> +static void rtw_deinit_intf_priv(struct dvobj_priv *dvobj)
>   {
> -	u8 rst = _SUCCESS;
> -
>   	kfree(dvobj->usb_alloc_vendor_req_buf);
>   	_rtw_mutex_free(&dvobj->usb_vendor_req_mutex);
> -	return rst;
>   }
>   
>   static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
> 

Looks good to me, thanks.

Acked-by: Michael Straube <straube.linux@gmail.com>
