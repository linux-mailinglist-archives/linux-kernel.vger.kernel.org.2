Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71243F3F3A
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhHVMTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbhHVMTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:19:54 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA0C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:19:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k8so21699850wrn.3
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/RvlM2yV0+zHQb0MiiJsHhug171R8oA19Pt/Nz/J0/I=;
        b=pwRtctcy9Bb8AwAPI7xjGTiBlK1cN51vqneq6OuyG8CnKL8nVt6Ev3AAjhGemC9v8s
         OF65nPxtwZ4RJWcIWTrAKnyiWGX1vGFCCaVNvkZpUk7d6MIK2V7Oq8cPK/zEc5cbcqN1
         fvbuaBxNP5Q/rm77YieSFyUodLiU5LW215RelPDHTUHD/QcPaIndDHDQNQ37yiyDD0gc
         v131EHMXN29LdOKiWdoqVCzfkAFK6/RCp01L4n+cffELTyO/1miRcyoOYljEV9s8m6F5
         nT78fk+bB9Ks5V5FXv7xuO4zW78OYNi0oC1COqUkvZfQV1NwQ2k6C/SMEFNKXfaCE+Z1
         EhCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/RvlM2yV0+zHQb0MiiJsHhug171R8oA19Pt/Nz/J0/I=;
        b=PiLJFQTqglCog9balHJtVrOQEa8j/sKebo0fYnb1JAxGFGZxAOny2v/Fx/Dg2n/Uhv
         O0qQu7uEmYoa/1XE2HBLxo7qoQPSy2Hjmm9Xu0kloe83WXqmQyG0r4nU6ZNs+c8N+1SC
         XDarzUaEClxKajlZhVDk3hCMEc/91sHddVeadHGStLWe6hM7LxXXj0o1Z2OPWGFn6r0l
         VpUp3wrkHp2H+wEraUVs/Yrd3FjNn9t3qyyKiwmS25CW3+FZRhkex4mWqOuA2NTQGhEY
         k6ttDMmln/IvXc20KOoDh8xHvHtAKZtl54Y3uk4Hk0CYcyGbyPbI7UUJJs899+vklB2Z
         j14A==
X-Gm-Message-State: AOAM532z5HpCB7ybvIe47QLWfL2eFWh+Hz8zkZQCmgLblF4M79HSpRI7
        chdTmWzzqaGQLJqw1JmrsVjk1tZekXo=
X-Google-Smtp-Source: ABdhPJw7vW9kUyYuqohQKvz/q7fHYbaPf06InlFb5pzbqu5eo0TK+8cJEvfuQoapt///zvjhy77hhQ==
X-Received: by 2002:adf:dd11:: with SMTP id a17mr8452442wrm.132.1629634752000;
        Sun, 22 Aug 2021 05:19:12 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id w1sm7271600wrl.64.2021.08.22.05.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:19:11 -0700 (PDT)
Subject: Re: [PATCH 04/10] staging: r8188eu: rewrite usb vendor request
 defines
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-4-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <27a8d716-f7ec-cbcf-6806-e012a9aae651@gmail.com>
Date:   Sun, 22 Aug 2021 14:18:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-4-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> Replace the numeric values with USB constants to make their
> meaning clearer.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/usb_ops.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
> index 5d290199e37c..b6a1cd536adf 100644
> --- a/drivers/staging/r8188eu/include/usb_ops.h
> +++ b/drivers/staging/r8188eu/include/usb_ops.h
> @@ -8,8 +8,8 @@
>   #include "drv_types.h"
>   #include "osdep_intf.h"
>   
> -#define REALTEK_USB_VENQT_READ		0xC0
> -#define REALTEK_USB_VENQT_WRITE		0x40
> +#define REALTEK_USB_VENQT_READ		(USB_DIR_IN | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
> +#define REALTEK_USB_VENQT_WRITE		(USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE)
>   #define REALTEK_USB_VENQT_CMD_REQ	0x05
>   #define REALTEK_USB_VENQT_CMD_IDX	0x00
>   
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
