Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2713F9AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 16:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhH0OdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 10:33:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhH0OdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 10:33:16 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1042BC061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:32:27 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p38so14945314lfa.0
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 07:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=TpDa8LjJDudMGosGLLFPxyVB3LRE+KOYsc1mXbf0yDc=;
        b=Yci7sAAXI0ojhFMOAYDVEM/XETlGxJ7MeOKi2tNncV7YtSfyITU/b6k5NdPSEMx5eB
         mUkyICoFlH7pOGsXyoCAmupLRG8y1ZM/P4PKqY3SUoXsKSyIebNxp6P+wYDfGXdpBGMX
         mPXFydTGAHupgkiEitD9Z4AZlP3qvHUj/WdisDBDnuLmb+8fxXLr63skODHbFi7nNmmB
         GpWxVtiI9tencKW24DZUPYUiZSbYRvdrZJ5H2HA7+NoSUEW5XZocXKmifVKoctYpUfqC
         ai26DnA7q8LTeit952+GK3paykfLWY4y8rEQFsKkjw+Z//aSG1yvawHhmaAXzs0i+tgI
         nIKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=TpDa8LjJDudMGosGLLFPxyVB3LRE+KOYsc1mXbf0yDc=;
        b=DLMGzOBEt+Jk7roAzZw7UvcVHVMS48x+BsRnjwtrkCqwbRO/wwvJlRhrvrF4aXgxSm
         0stwdqSqylsvHBaUl4ppfctVCNJZqZuYjgbgb5ofOcGOYNm41l9H9FgUM7xG3mk0ZSYv
         4Bppzy8spZHcPmsVChNlDA6YsX4bgVnyr11DrEp4ZD6h4/rsVMAe3x+il+eudhpEyjU8
         cLI/qPsn1AOp7cScOU68n7gFuTRYdmdbN19EvpLpQUeLVWuN86lOemIqxAFdkM/xxS3A
         jbjmObqNYEGjYYH2u+d6uOm7GTfayNavSzw0BphXxPJp+R8KD9pQS/+Y8fcA14jam0OH
         4t/w==
X-Gm-Message-State: AOAM533cV7KYbx3k2xSSeow9+AxUxyji5ccmOYQ0IVY568vMd2iM1uWQ
        DVzPz7rest5BQaJu5iPSsos/ZmjRdXy6UQ==
X-Google-Smtp-Source: ABdhPJyqOdkdoGzA+wSnlK9O6jKpMAls9Q7Sawrti6v8l0k/cz6l7p2mTpuO/iLt9WXpawtQkpkqZA==
X-Received: by 2002:a05:6512:23a2:: with SMTP id c34mr4367852lfv.19.1630074745040;
        Fri, 27 Aug 2021 07:32:25 -0700 (PDT)
Received: from [192.168.1.11] ([46.235.66.127])
        by smtp.gmail.com with ESMTPSA id s4sm610976lfd.53.2021.08.27.07.32.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 07:32:24 -0700 (PDT)
Subject: Re: [PATCH v3] staging: r8188eu: Remove _enter/_exit_critical_mutex()
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Martin Kaiser <martin@kaiser.cx>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20210819221241.31987-1-fmdefrancesco@gmail.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
Message-ID: <03d5fd25-7694-18ee-9e2f-7b4057117197@gmail.com>
Date:   Fri, 27 Aug 2021 17:32:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819221241.31987-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/20/21 1:12 AM, Fabio M. De Francesco wrote:
> Remove _enter_critical_mutex() and _exit_critical_mutex(). They are
> unnecessary wrappers, respectively to mutex_lock_interruptible() and
> to mutex_unlock(). They also have an odd interface that takes an unused
> argument named pirqL of type unsigned long.
> The original code enters the critical section if the mutex API is
> interrupted while waiting to acquire the lock; therefore it could lead
> to a race condition. Use mutex_lock() because it is uninterruptible and
> so avoid that above-mentioned potential race condition.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Tested-by: Pavel Skripkin <paskripkin@gmail.com>
Reviewed-by: Pavel Skripkin <paskripkin@gmail.com>

Thanks!


With regards,
Pavel Skripkin
