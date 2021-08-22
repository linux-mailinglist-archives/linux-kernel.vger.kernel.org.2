Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2C823F3F3C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Aug 2021 14:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhHVMUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Aug 2021 08:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbhHVMUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Aug 2021 08:20:41 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1071C061575
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:20:00 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id k29so21685682wrd.7
        for <linux-kernel@vger.kernel.org>; Sun, 22 Aug 2021 05:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXyUw+WOrtg1/HVyiUZhztfPCLmF+rc/B9S0+PjHvOM=;
        b=MGDnNxtGPTbUOioghyBnvZfQtKheEArFE04VR1eyseFybLT3+owwgscYb4e2MK6Ghx
         GUxMpBJIGEnNGn7UIMsKbAF/n60AYy5ezy0zmgcRvqg6Mkg3UQRAfg8xMmPQkr5p1Epr
         7zBJYjc6uJDhh8mCf34Qf45847NfeoQ5mN0shw4huwJC/n4t0xVXzCbIBhJ2R203jFdM
         EaO5rWbI5/0T9N+lMmsH7VFXCpHDnb9wfcn/POKs6e9hSTcxlUqkamZOMZb0/loFg22J
         ThnmnS4XS7mf/QSNy9MsE4cHHn27dwkWzr3qcAOjbdamY6N9Zj0ASOcYkMUvlCVP+3ZJ
         xP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXyUw+WOrtg1/HVyiUZhztfPCLmF+rc/B9S0+PjHvOM=;
        b=gqk4rQ8/3gC0vsV2LY2aqkD0fTX024SGNgaACzqZcPi7uPci0IBi9tmeGOHWSECeS1
         fAyCn3DkQVLIALaRT4RjLh6D4O7RBslDokfKDKRUgPZ2G4dBA5d2OCHmfo5XlVo6PTif
         sCar0eusp5UTq0HI22M61lGv0C58YGOIh0Lhel+SFPM/w97vB2B0cAiKwUNZWUXM2cfv
         6KYH1jbimV0m7xQ3LQBOIqVIYXf1jftEeIVZiU1e8kwXmDYZsIiwQRGr6U6uggCvCNnJ
         YkH4n+T+TfYaE3G6UoYYj1X4U5NX5g8EcKMWeYV5hYUpx6xcy1kUZKxV7y55vhQsWyqI
         zUVQ==
X-Gm-Message-State: AOAM532oU1c8ohFeRJCSr1HzSoZIiqp4iwAzA/qMV4LS6rbWPuwIwzo0
        +hYtsSGj+JACRkfSvHQInyv7RJswUJI=
X-Google-Smtp-Source: ABdhPJzE4skZOJTJsDklZ0zu/iEVifRzIqMJvLxrPbjmLFqu8L0IqtVoEg7jWYMcE/1Z4dM+CePDEw==
X-Received: by 2002:adf:e509:: with SMTP id j9mr2008857wrm.320.1629634799455;
        Sun, 22 Aug 2021 05:19:59 -0700 (PDT)
Received: from ?IPv6:2a02:8108:96c0:3b88::687e? ([2a02:8108:96c0:3b88::687e])
        by smtp.gmail.com with ESMTPSA id i8sm11626722wrv.70.2021.08.22.05.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Aug 2021 05:19:59 -0700 (PDT)
Subject: Re: [PATCH 05/10] staging: r8188eu: remove an unused enum
To:     Martin Kaiser <martin@kaiser.cx>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210821164859.4351-1-martin@kaiser.cx>
 <20210821164859.4351-5-martin@kaiser.cx>
From:   Michael Straube <straube.linux@gmail.com>
Message-ID: <38b14452-fa19-a550-e4a9-387ceb8ea64b@gmail.com>
Date:   Sun, 22 Aug 2021 14:19:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210821164859.4351-5-martin@kaiser.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/21 6:48 PM, Martin Kaiser wrote:
> The VENDOR_READ and VENDOR_WRITE defines are not used.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>   drivers/staging/r8188eu/include/usb_ops.h | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
> index b6a1cd536adf..c53cc54b6b87 100644
> --- a/drivers/staging/r8188eu/include/usb_ops.h
> +++ b/drivers/staging/r8188eu/include/usb_ops.h
> @@ -13,10 +13,6 @@
>   #define REALTEK_USB_VENQT_CMD_REQ	0x05
>   #define REALTEK_USB_VENQT_CMD_IDX	0x00
>   
> -enum {
> -	VENDOR_WRITE = 0x00,
> -	VENDOR_READ = 0x01,
> -};
>   #define ALIGNMENT_UNIT			16
>   #define MAX_VENDOR_REQ_CMD_SIZE	254	/* 8188cu SIE Support */
>   #define MAX_USB_IO_CTL_SIZE	(MAX_VENDOR_REQ_CMD_SIZE + ALIGNMENT_UNIT)
> 

Looks good to me.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
