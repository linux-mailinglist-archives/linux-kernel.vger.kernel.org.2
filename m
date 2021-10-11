Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D616428935
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 10:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbhJKI40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 04:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhJKI4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 04:56:20 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C5FC061570
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:54:20 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id d9so40987512edh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Oct 2021 01:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bm3wXMJ4rfAFeHpv39wPQyGuIwFIJmid7Nqz8YDvf6o=;
        b=TVRxYTOg9IKOYxMjmO5BVUckr++KoEUEpL954fJ9Q7NgyJXNDkssAFnXWfqVFzgKYf
         DjxjEd7Ec6/4L395nQagHYjuFowEXREwc9rLmjwqvqgdMpPzuKUKu+cl+yRujtVoMXhb
         T3Jhz4g71lBjVk5PNpSzj4t7kvkZOjoajD2YHimdniVsBaqlm0rKqBOsRg1+pFFCM3mu
         IsrfY1bibm86Y8/XiDfxJnZXmwMl6iJnkvUlueUJZ8TOoxFnyqEevUDz9IPfscJ6gZi4
         WgUnDVxnCrU4bI3id8zPxLFn4GUiUDTIDwyLrzhIP7ncYTJQuXkarYbidsKGVdBx/Fqv
         LliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bm3wXMJ4rfAFeHpv39wPQyGuIwFIJmid7Nqz8YDvf6o=;
        b=3Ix4QOHYYVcihETgbEFCTFzS8ItuORoDX3LUSuTywBcW3SBKPbUmQt7KcFuz5qqiC3
         LPRpjqJKDkmIRG4JQFa9MJ53ZxYECL6tfWACuUJI4srrhdOvIbypikogQE3QWk6HIyHf
         OIWWzg5ChcgLmADT6x+cZB0HWZpNR0+nQWzyAbvqP8CRWbhRLF0LY5APE7ZqnG3j1w6t
         ZJ63KyH8kAtN9/OyM6l3eDCeL9R4VH86ICB0YfD6eBFludZ/4G5ZfuRhbJCU+446Nc/M
         hKiImgR3EMciZN809hK2iXcJ+ECxuNdYZpbbUPei6QTtdZ1dwUhDQUtNY4VZLKJKVybj
         C89w==
X-Gm-Message-State: AOAM533W9VlrCCZE/a+VNYx9BOpeopniBWq1T5uW04cRydquWVGWU8AR
        /m3nHizX40WvFiClexecjR0=
X-Google-Smtp-Source: ABdhPJwoKQm0lAofAm+QORUkmLZV/tOjW5jc9AD61qOM7PvkhRw+HXESI56q0RrVqNH9qI8svNtOTg==
X-Received: by 2002:a17:907:7752:: with SMTP id kx18mr25119293ejc.276.1633942458632;
        Mon, 11 Oct 2021 01:54:18 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-109-12.retail.telecomitalia.it. [79.43.109.12])
        by smtp.gmail.com with ESMTPSA id h11sm3130942eji.96.2021.10.11.01.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 01:54:18 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, fabioaiuto83@gmail.com,
        ross.schm.dev@gmail.com, marcocesati@gmail.com,
        saurav.girepunje@gmail.com, insafonov@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Saurav Girepunje <saurav.girepunje@gmail.com>
Cc:     saurav.girepunje@hotmail.com
Subject: Re: [PATCH v2] staging: rtl8723bs: os_dep: simplify the return statement.
Date:   Mon, 11 Oct 2021 10:54:11 +0200
Message-ID: <2482197.HNbSr4JpUv@localhost.localdomain>
In-Reply-To: <YWJ0vSrgsiKK7suE@user>
References: <YWJ0vSrgsiKK7suE@user>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, October 10, 2021 7:06:05 AM CEST Saurav Girepunje wrote:
> Remove the unneeded and redundant check of variable on goto out.
> Simplify the return using multiple goto label to avoid
> unneeded check.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 
> ChangeLog V2:
> 	-Add goto out after the memcpy for no error case return with
> 	 ret only. Free is not required on no error case.

Please write versions logs that reflect clearly and unequivocally what you 
changed between revisions and why. Subjects, Commit messages (Changelogs), 
and Versions logs are the "specifics" of your work. There must be no 
inconsistencies between these and the code or the history of the changes of 
the code.

You may think that I'm pedantic, but since I acked your patch, I don't want 
to be misunderstood to be a promoter of approximate or clearly incorrect 
messages.

"Free is not required on no error case" conveys the message that you have 
changed something that is not required but that is still potentially allowed.

This is not the case because the problem that you fix with v2 is _not_ 
something that is merely not required and unnecessary. You have fixed a bug 
that is introduced in v1. Introducing bugs is not allowed. If you do 
something that is not allowed you cannot simply say that it is not required. 

> 
> ChangeLog V1:
> 	-Remove the unneeded and redundant check of variable on
> 	 goto out.
> 	-Simplify the return using multiple goto label to avoid
> 	 unneeded check.
> 
>  .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c | 22 +++++++++----------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c b/drivers/
staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> index 0868f56e2979..ae9579dc0848 100644
> --- a/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> +++ b/drivers/staging/rtl8723bs/os_dep/ioctl_cfg80211.c
> @@ -2312,7 +2312,7 @@ static int rtw_cfg80211_add_monitor_if(struct adapter 
*padapter, char *name, str
>  	mon_wdev = rtw_zmalloc(sizeof(struct wireless_dev));
>  	if (!mon_wdev) {
>  		ret = -ENOMEM;
> -		goto out;
> +		goto err_zmalloc;
>  	}
> 
>  	mon_wdev->wiphy = padapter->rtw_wdev->wiphy;
> @@ -2322,23 +2322,21 @@ static int rtw_cfg80211_add_monitor_if(struct 
adapter *padapter, char *name, str
> 
>  	ret = cfg80211_register_netdevice(mon_ndev);
>  	if (ret) {
> -		goto out;
> +		goto err_register;
>  	}
> 
>  	*ndev = pwdev_priv->pmon_ndev = mon_ndev;
>  	memcpy(pwdev_priv->ifname_mon, name, IFNAMSIZ+1);
> +	goto out;
> 
> -out:
> -	if (ret && mon_wdev) {
> -		kfree(mon_wdev);
> -		mon_wdev = NULL;
> -	}
> -
> -	if (ret && mon_ndev) {
> -		free_netdev(mon_ndev);
> -		*ndev = mon_ndev = NULL;
> -	}
> +err_register:
> +	kfree(mon_wdev);
> +	mon_wdev = NULL;

Probably you have already read a message by Greg Kroah-Hartman that confirms 
what I wrote in another message: "There is no need to set a local variable 
like this to NULL.".

So please submit a v3. With the two changes requested above, my "acked-by" 
tag is confirmed again.

Thanks,

Fabio

> 
> +err_zmalloc:
> +	free_netdev(mon_ndev);
> +	*ndev = mon_ndev = NULL;
> +out:
>  	return ret;
>  }
> 
> --
> 2.32.0
> 
> 
> 




