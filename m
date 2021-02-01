Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F053830A01C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 02:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhBAB5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jan 2021 20:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbhBAB5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jan 2021 20:57:45 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5843C061573
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 17:57:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gx20so800032pjb.1
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jan 2021 17:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9M0l27bqKEGBmwJbeFwH8NYxzXyLtRrLK5whmzNy510=;
        b=OgP06fwgJsihQgFY3HqVdKK90aPhnnBLTibdexhcN229QUen3MEppE8Cfcu+pcdDIT
         zGIS/XmOk/MuGc6Lx8Hy3A9L38+Gb04PZ1DTQcrhjlNnp9tI1SUa0sOXwo4bmnN5pcI2
         d4TBMLwLEfx39CyBSfnCTpfMfQO5kI/MLhdGWg8PkVbiqRCvgMvez5hasnZg65FxLyai
         adnzuFrjN0g3wU6fTM6qXZ9Pj+TDIG64FexMHh/p2HyIRP8RiZuTkWNa0EMADsqgmHxF
         ewTWrNzKBLnDYjANmYuuD2/EGUljJr7ZItOEt2zmMTXHYjpest1QMO2CyQ9vEx9M9Cx4
         hpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9M0l27bqKEGBmwJbeFwH8NYxzXyLtRrLK5whmzNy510=;
        b=Y9CzN9nl1DeJsFzYWilWFE9XQ+Vq5YfdkrIHe5KaI1dvcft09wgOTvDIJ4gwxe8eep
         JtesJhoWj3LIe4wv6lX1js6e0MlJQjm+9MZsVnUqAKAPRMvd5kdN0QKz5D860jxTyBHz
         EsvjYlP86KGmQh9UofJIEfTPRBXwxJOMQ5CDoUx3HJV3swRhF/8FM9OVS4vEbkYfXPH0
         mUDawGXykAgoJwNx3l6kZd3IHSw+5E9DWCXrjT5GmfeEn4CQ8ulJxRnu6J++FwrHb1YP
         4yTHWh6YaoK/SlTSaLxEwKrWii3ZbtsmGCZPybk39iOPHRDHkOdzLnfvYAt7HuEWKFzo
         G7tA==
X-Gm-Message-State: AOAM533ErMZjeKkNkwgr9xnfQ4ki/sjgnJO+DQXaFnZ5c3W3swtXriy1
        7rwQbVUeJVDsx0lw2oYAAdoVF2OLiTGFIBIy
X-Google-Smtp-Source: ABdhPJwPlMfB8+CIqLowW0qm4AwMuRiGZaDHIdTVqhbhU93b2pRVgqYDDQf5YMaRklR4NBQARz/IUg==
X-Received: by 2002:a17:90a:7f8f:: with SMTP id m15mr15495352pjl.214.1612144621653;
        Sun, 31 Jan 2021 17:57:01 -0800 (PST)
Received: from [10.2.218.189] ([61.120.150.75])
        by smtp.gmail.com with ESMTPSA id w7sm15318519pfb.62.2021.01.31.17.56.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 31 Jan 2021 17:57:01 -0800 (PST)
Subject: Re: [External] [PATCH] misc: pvpanic: sysfs_emit uses should have a
 newline
To:     Joe Perches <joe@perches.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <13b1c892d52c27d4caeccc89506aadda74f61365.camel@perches.com>
From:   zhenwei pi <pizhenwei@bytedance.com>
Message-ID: <3369537d-27a9-2a48-9a46-f241a5077dc2@bytedance.com>
Date:   Mon, 1 Feb 2021 09:56:57 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <13b1c892d52c27d4caeccc89506aadda74f61365.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/21 3:08 AM, Joe Perches wrote:
> Add newline terminations to the sysfs_emit uses added by -next
> commit 8d6da6575ffe ("misc: pvpanic: introduce events device attribue")
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>   drivers/misc/pvpanic.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
> index b1e4922a7fda..9f350e05ef68 100644
> --- a/drivers/misc/pvpanic.c
> +++ b/drivers/misc/pvpanic.c
> @@ -25,13 +25,13 @@ static unsigned int events;
>   static ssize_t capability_show(struct device *dev,
>   			       struct device_attribute *attr, char *buf)
>   {
> -	return sysfs_emit(buf, "%x", capability);
> +	return sysfs_emit(buf, "%x\n", capability);
>   }
>   static DEVICE_ATTR_RO(capability);
>   
>   static ssize_t events_show(struct device *dev,  struct device_attribute *attr, char *buf)
>   {
> -	return sysfs_emit(buf, "%x", events);
> +	return sysfs_emit(buf, "%x\n", events);
>   }
>   
>   static ssize_t events_store(struct device *dev,  struct device_attribute *attr,
> 
> 

Hi, Greg is the maintainer of this driver.

-- 
zhenwei pi
