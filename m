Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6246417937
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 19:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245661AbhIXRHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 13:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244626AbhIXRHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 13:07:31 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB87C061571
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:05:57 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so29522951wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 10:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=PY4KsopAnhFuuxcCGlkV29I1qc5kit5PQGjKdrKsIBI=;
        b=PZXQUf5V1LcDI72rtn5I4icEufwVsEW7f3qY0d6NJEyiuv0En6/eUQFnfi7kJapB47
         uVYnaynBcHNYSa99wRNhcKVn1vZzZFo7bKgGc9IBywCBznCF63y2W3f9RGjUgukI3H6G
         YGPnVXQrYUWob+uNPzfDwrPXbubpGM7bdzl8yOuFDjIVIKn1S6A3GQV7LfmkcNPFHLit
         HlYLvOJszVVYXOFxxauLesUxAdq55Vd1AJuhix8LFa2P4rKD0g3vQS/J3uKzH6ab/Kif
         2Xpc/9U0/iimSrPTNMpXF6kM0hAFwQJKZD76QhfNbrFJioIA9iSd2MjcmhtJ0guoFACX
         8x8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=PY4KsopAnhFuuxcCGlkV29I1qc5kit5PQGjKdrKsIBI=;
        b=CU089cnnmX7cuvptnxDeBRATKmI3wWSSwhuOSdNpomiVMCcD7OzyWkE6/L2x8AKpuR
         OyLYaNrF5yp6U2Snhn61QOuO7jfqP/MBt1LRnDXEL/cf8zxud0EHEFA9WxHiRrylXGJN
         tYqxMCrzyjdmky1YUWOEKS6zom5yjfkA0D6AVy5+kIHMaOh0eF1U0/IEm158azsi7oUa
         3ncmZ+sPlSDANXF6Pn1flU+cmbmXEd95/O6DH8xXVLLV4gbkweCYygSFm8Mtawm+KHXy
         cwlZliq4gh50BeiYZgm/ruajE4ljJg2OSA0i9Ug4Taj50uEtO1aVNIYoe6P8AHQuUnbf
         BrSw==
X-Gm-Message-State: AOAM532n9RwtG6fZCyV93ErGdMuGK4mvY6ox3dMg26A85zdYsn5Ue3jE
        tMOpa54zwnRtj/JUN+yaSSfNYZGwhq/Mfg==
X-Google-Smtp-Source: ABdhPJzg2xGoR/EOMzF98e/e3XNtLAJyiGcJrpcpxL1Itovxb7ER/nfMoDcS9i4dXQcnAjdKw6zfnw==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr3318450wmi.114.1632503156361;
        Fri, 24 Sep 2021 10:05:56 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::cde? ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id r27sm7767173wrr.70.2021.09.24.10.05.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Sep 2021 10:05:55 -0700 (PDT)
Message-ID: <29184a95-c676-79d6-bb9a-88d37d44a80c@gmail.com>
Date:   Fri, 24 Sep 2021 19:05:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH] Remove blank lines and whitespaces
Content-Language: en-US
To:     Michael Estner <michaelestner@web.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210924144750.6020-1-michaelestner@web.de>
From:   Michael Straube <straube.linux@gmail.com>
In-Reply-To: <20210924144750.6020-1-michaelestner@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/21 16:47, Michael Estner wrote:
> Removed blank lines and whitespaces to clean up code.
> 
> Signed-off-by: Michael Estner <michaelestner@web.de>
> ---
>   drivers/staging/r8188eu/core/rtw_io.c | 65 ++++++++++-----------------
>   1 file changed, 24 insertions(+), 41 deletions(-)
> 

Hi Michael,

the file rtw_io.c was removed entirely with commit
06c38fef11bc ("staging: r8188eu: remove core/rtw_io.c").

You should work against the latest staging-next tree.

Best regards,
Michael
