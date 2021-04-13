Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3285C35DCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245469AbhDMK4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbhDMKzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:55:50 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3803C061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:55:30 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id ba6so18854756edb.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=va658DcvB9VpnT6zlnFssN11/Tnxxz2cyGv/gA71ftU=;
        b=PiMHislXz8pJmhPvsAadDi9Af9yqHMe9WvfMofA7+gE1OX1pmd8JjyMOKWHD0Joxrg
         PjvCVV/3Wuhu3p/0wtwZwnNwMrvQL/m/4y3yC1sc6huJOjz9IyScytwhU3oNAZ3pxDqZ
         7aNdc6stSrFBgIgGQLraCV9y0fQM6laXBDRCSdDDXABOL4oB9MPJjtLrZgTAhQijRM6J
         elvfq0oYphGCsW9of6JatFhrbdfPLyiNrShfY52tNXE8nizFdivXNOUKskKPJooolXRS
         PiT174veyORmFaD5QrpQyoZaoF/A5aq2PHj0liQvQMh64XIyp8Qrt9bLrYkp2/XvffHy
         GGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=va658DcvB9VpnT6zlnFssN11/Tnxxz2cyGv/gA71ftU=;
        b=FQMIOemAvnwaX7Y62lmlbPGNdGHX6SQJ2OuUShlzrEihhCupgWU3HPtzPEA1abz5fS
         zTPYoEDD9vGxRu/XaTCUYvtFetrY9mNXnabtjh5b1lBARQpN62FNy5kbfs+SldHyO/uy
         e24FnnHuwScrdVE29T7SSMjGVqi2zQ/JJrzc55xEDFJry7zhjUcAbYVJ91+o4ENutA2Q
         3D1/uui5VOYREPEjXqHsOvgPdOapJKePcvyiysfnUEttLQybdgWLBX4lqwn+HjQK8Tig
         Y4c2FUHRGprcqs31buFnmBkaojAaXBG+AZXI81IUKoYLpbEmqeXrbtEnRL5ozPJD9Yo3
         x1aw==
X-Gm-Message-State: AOAM531xiNbCh65sNm8kdS5tOZu8LqWIkon9GJ1X504+xawEvH0Lt3n6
        sBxZ+tPAeD1F20u34ksZkcx0nw==
X-Google-Smtp-Source: ABdhPJxWfmjVMmbjEfL5HaZ4mDwT3aOXbcswowPXw2Y8I4NhukX8Jh/zNINPeg2SYyvtfVwfjBNGfA==
X-Received: by 2002:a50:fb8c:: with SMTP id e12mr35068851edq.295.1618311329613;
        Tue, 13 Apr 2021 03:55:29 -0700 (PDT)
Received: from [10.0.0.62] (xb932c246.cust.hiper.dk. [185.50.194.70])
        by smtp.gmail.com with ESMTPSA id t1sm9087230eds.53.2021.04.13.03.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Apr 2021 03:55:29 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: remove duplicate include in lightnvm.h
To:     menglong8.dong@gmail.com
Cc:     linux-block@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Yunkai <zhang.yunkai@zte.com.cn>
References: <20210313112241.366786-1-zhang.yunkai@zte.com.cn>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <e2bd4734-959c-4505-7e1c-ccc04185e4d3@lightnvm.io>
Date:   Tue, 13 Apr 2021 12:55:28 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210313112241.366786-1-zhang.yunkai@zte.com.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2021 12.22, menglong8.dong@gmail.com wrote:
> From: Zhang Yunkai <zhang.yunkai@zte.com.cn>
>
> 'linux/ioctl.h' included in 'lightnvm.h' is duplicated.
> It is also included in the 33th line.
>
> Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
> ---
>   include/uapi/linux/lightnvm.h | 1 -
>   1 file changed, 1 deletion(-)
>
> diff --git a/include/uapi/linux/lightnvm.h b/include/uapi/linux/lightnvm.h
> index ead2e72e5c88..2745afd9b8fa 100644
> --- a/include/uapi/linux/lightnvm.h
> +++ b/include/uapi/linux/lightnvm.h
> @@ -22,7 +22,6 @@
>   
>   #ifdef __KERNEL__
>   #include <linux/const.h>
> -#include <linux/ioctl.h>
>   #else /* __KERNEL__ */
>   #include <stdio.h>
>   #include <sys/ioctl.h>
Thanks, Yunkai. I've pulled it. Note that I've merged your two patches 
into one.
