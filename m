Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EBB42013D
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Oct 2021 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhJCKtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Oct 2021 06:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJCKtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Oct 2021 06:49:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23673C0613EC
        for <linux-kernel@vger.kernel.org>; Sun,  3 Oct 2021 03:47:16 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id g193-20020a1c20ca000000b0030d55f1d984so5078091wmg.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Oct 2021 03:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=vMMwa7IT7oG2iCb/XqivgT4lMgOipj0gblXHu4x8S0o=;
        b=HJmNX0T8RS4yKFMLsT1tR4IeTwBVq3AumWfS8MmVkYjUXjc1ATVjYFA4yY72iMhV7G
         b9JUEiwY7Znsiv49rdpMFDy3GwAK5g/361dokXdul/mW6oe4Wwpm6ei3IaR/XyuEGscR
         0lLnh9LwE8HNIvf4W8iR+4vbymjnFulXlJK58EmXgEF0R/K3Nhumvx45wVr/yd7KJJrw
         mDV41hgI5cWxMHmBVoU7kUkD40roTT61ISxveR2eAs4oteJCbf9yf13pb8js+6hecYKc
         wg7yqhd6SxJ12gvvh7JOjoOgOr3mou+V59OuXFWQDsA8Bm9jobicWkYDG4T4rcvZiIl4
         weiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vMMwa7IT7oG2iCb/XqivgT4lMgOipj0gblXHu4x8S0o=;
        b=ucZwBT1XDOCRJTttHUrZvp+SvOrKuRrMQ5WEjxdJGe1MRkMtzMmzeB5h0+8FONHE0S
         4l8jLAzyvJ/0osHisEkJYkA2NPw5WSpVu+QPB0EFG+qB9WgQVuzldcdTD7HnwzhSV+R7
         /25UZygNcmQARXQ847zqGvM4eOSeVYmMUlzq0KUGeVMJMSeSKKtllKzOQqXv6u8X29nw
         ujxbZ4dmkLw1/QI1ETZiWCwWmUSX2hj4UrZeqxu6gnxS9Su+PBbuSOraZp8wzCxrMDyg
         VebQQYiew56aJ32kzB5uSctgts+siWyQ6GZtlYn3WDAQjMffYM30iXrKgMN2Lh7N0hQX
         yB5w==
X-Gm-Message-State: AOAM532hQQ3a232zkgEx6xG8VRcNOpLFufdc5sRGb1w16yfCMUuSwVQG
        A9PqJnYTE02euOp8Ffmdolo=
X-Google-Smtp-Source: ABdhPJwqJzCvFH5QzdMir//AFtuNEuWDYX6hToiSOLLJMgdSeRO8JZQFjtj/Myl4NQ+iUo8ExOHhbw==
X-Received: by 2002:a1c:411:: with SMTP id 17mr394294wme.158.1633258034811;
        Sun, 03 Oct 2021 03:47:14 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::f816? ([2a02:8108:96c0:3b88::f816])
        by smtp.gmail.com with ESMTPSA id m5sm13078178wms.41.2021.10.03.03.47.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Oct 2021 03:47:14 -0700 (PDT)
Message-ID: <6b5c6c02-7c66-1315-fc60-d11804d40adb@gmail.com>
Date:   Sun, 3 Oct 2021 12:47:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Subject: Re: [PATCH v2] staging: r8188eu: core: remove unused variable
 pAdapter
Content-Language: en-US
To:     Saurav Girepunje <saurav.girepunje@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
References: <YViKDzqX5isFX+gv@user>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <YViKDzqX5isFX+gv@user>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/2/21 18:34, Saurav Girepunje wrote:
> Remove unused variable pAdapter in Efuse_Read1ByteFromFakeContent.
> 
> Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
> ---
> 
> ChangeLog V2:
> 	-Remove unneeded line break on Efuse_Read1ByteFromFakeContenit().
> 
> ChangeLog V1:
> 	-Remove unused variable pAdapter in Efuse_Read1ByteFromFakeContent.
> 
>   drivers/staging/r8188eu/core/rtw_efuse.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 

Looks good to me now.

Acked-by: Michael Straube <straube.linux@gmail.com>

Thanks,
Michael
