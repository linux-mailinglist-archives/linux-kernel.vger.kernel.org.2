Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE42B3F8CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 19:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243157AbhHZRUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 13:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbhHZRUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 13:20:48 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 309ADC061757
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:20:01 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id mf2so7857710ejb.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Aug 2021 10:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gKDMhXdQnvrNiUefbL8YYDU0RU2rIxixwkrpgN6Y9og=;
        b=oE1G+X2nBsCr3jel92P+uJhIg6GC6JURdrcpUlOYAanMiifujQEaChfXsR4XBBs2lW
         e0exiqokL3IWOkpp4VqLUfYy7tHIHZc+8xXFwnU9GW3GrVcJ7qAhSTwjvtxpP1iUv/fo
         M04fzyzdvnBKod9BN2cfbNuDVF77rl9GGTlXoERqvCzrATYz9r3hV9IFY+n1a8QAb0pN
         SzUJ3YhXNlDDS57g6P2C5fghN6DWv1/9HytOK2T2RT5q/OWk/btDDrTugYi3yg1ExLrX
         9+IUqyhVjoNqOtOjDzgDOkxdKQO9kXlLKUmyoShoDfSyWqdbznGxdcZlkao4785HB950
         OhoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gKDMhXdQnvrNiUefbL8YYDU0RU2rIxixwkrpgN6Y9og=;
        b=orJPnglifYwv5aIU+YGwOt4gbECnO4g7d/npb0UQPnOYCkIaNDfEraNFh3e3InkhYF
         JT6rfqC0Q3vJBnUAviK/xs4JKaXZHAdak3rlXzCndH0OAMNwVpstv9apf42HKaGasG4q
         SyhMXB6FN6H40hleWsWDSoBKRo5yNtIEf8s0ldtbKwbzZ/NhGeofsYHvRTf4lAadaohK
         GrWEuDN+6hGWyRPOTfhlhnahy7vgJdLuEzv7aLrjB2PbOa0O+wu9gp9WdDvJ8yjxflsO
         4CIPI/gqaelsI/O3ayiyO038A8yEM0h2zSVLCooGaT4fUkOnwVj0Px3n9g3MLg9NaaN5
         N9MA==
X-Gm-Message-State: AOAM531ySYjsUuZU9NH0qweou4y5yQVLty/KP0ZbKh8Y5PsYdi5dYS8n
        3W6gwPq0Zbx3mWvUEaXDja7HF5qTp+4=
X-Google-Smtp-Source: ABdhPJxHJE+7Lidd55kajB/jmfZrqjn2YoeEFEMX8YdUhYVQoZsAIJZJARLqAtKPhPoe9Y40ulN4sQ==
X-Received: by 2002:a17:906:39d5:: with SMTP id i21mr5428615eje.529.1629998399796;
        Thu, 26 Aug 2021 10:19:59 -0700 (PDT)
Received: from agape.jhs ([5.171.80.9])
        by smtp.gmail.com with ESMTPSA id lu4sm1594568ejb.103.2021.08.26.10.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 10:19:59 -0700 (PDT)
Date:   Thu, 26 Aug 2021 19:19:55 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Wenlong Zhang <yixiaonn@gmail.com>
Cc:     gregkh@linuxfoundation.org, ross.schm.dev@gmail.com,
        marcocesati@gmail.com, insafonov@gmail.com, cyruscyliu@gmail.com,
        yajin@vm-kernel.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: rtl8723bs: prevent ->ssid overflow in
 rtw_wx_set_scan()
Message-ID: <20210826171954.GA1423@agape.jhs>
References: <20210826154622.55361-1-yixiaonn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826154622.55361-1-yixiaonn@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Welong,

On Thu, Aug 26, 2021 at 11:46:22PM +0800, Wenlong Zhang wrote:
> Commit 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> fixed up the staging driver rtl8188eu by adding another check 
> to prevent writing beyond the end of the ->ssid[] array.
> 
> Resolve this by properly fixing up the rtl8723bs driver's version of
> rtw_wx_set_scan() 
> 
> Reported-by: Wenlong Zhang(iLifetruth) <yixiaonn@gmail.com>
> Fixes: 74b6b20df8cf ("staging: rtl8188eu: prevent ->ssid overflow in rtw_wx_set_scan()")
> 
> Signed-off-by: Wenlong Zhang <yixiaonn@gmail.com>
> 
> ---
>  drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> index 902ac8169948..6fc1020cea11 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
> @@ -1351,9 +1351,9 @@ static int rtw_wx_set_scan(struct net_device *dev, struct iw_request_info *a,
>  
>  					sec_len = *(pos++); len -= 1;
>  
> -					if (sec_len > 0 && sec_len <= len) {
> +					if (sec_len > 0 && sec_len <= len && sec_len <= 32) {
>  						ssid[ssid_index].SsidLength = sec_len;
> -						memcpy(ssid[ssid_index].Ssid, pos, ssid[ssid_index].SsidLength);
> +						memcpy(ssid[ssid_index].Ssid, pos, sec_len);
>  						/* DBG_871X("%s COMBO_SCAN with specific ssid:%s, %d\n", __func__ */
>  						/* 	, ssid[ssid_index].Ssid, ssid[ssid_index].SsidLength); */
>  						ssid_index++;
> -- 
> 2.15.0
> 

today the patch which removes wext handlers has been accepted
in staging-testing so maybe rtw_wx_set_scan is going to disappear.

thank you,

fabio
