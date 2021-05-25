Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C22E38FB89
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhEYHVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 03:21:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbhEYHVC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 03:21:02 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160E9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:19:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id v12so30995290wrq.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZIF5qbJq5dDbTJkMUZQx+e6A8wnJOGmQFFouRAB4vUQ=;
        b=fPjSmZYrxa3jhg9v7KNIkfBuVzdPafEjR4yuhdo77RlnRctzYGJt5CBXzx5hYkcHO9
         +CMaIU7LIfmqH14An0A6RaAiVtioTQmJbT7EyffFC4UxLJHd8XS8GjTN/u3nMXdjxgil
         0lZzznUMlpP62/bLpTGiqzgZQl3XuPkaV0y9raIQlp/TQGBLD4NHmPYLOa8BM8EY7nX0
         LM9a5w2sMcacBLh1494DbEnDpiQFcqj0PXgNSe2dPRNSLW76fijemgaFSRNVCDq5Tfhz
         esPfTKmkzyjZByxmueQFFKj2Jdrom6jAVECHL2y9ivpgV7SbPZ3JqV1ZdTZpWq1Vez//
         yRjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=ZIF5qbJq5dDbTJkMUZQx+e6A8wnJOGmQFFouRAB4vUQ=;
        b=cviD6hvMNsDZmNPAV40P4h8QFAysKnFhqRQGAAfB8vP8gjbCGtJADV7jwojO84A8F4
         KOzGpSMPjZNBaViYxoPq5LNjboRSgJhrK/hO2yxemrvxfbpX/ORi2eeVwtSG2ORnJJ2e
         fvkTiD477B71DKtHVN3ISELod7Klb8Aukpx74BBqnipRt/cYQxa16XeRt7F6jSuJRZaK
         b+tu6xplGgAJwGLUIfMCSGwzx+056FBdoQcKiYk9wMfOoxatSW3ANaFAudnUPQyIxFgc
         BtITVUc4BSLKg+s3epoCcMEW7Xm/+X7mkEZ1JePB9pjMNsiI0oBWgoT+2gx7MrboxF13
         1yDA==
X-Gm-Message-State: AOAM531vdkZVxM7giuB1bJCpuntmxx+bJZONpjk0TuXGU9I1kQrJp1gK
        MWnSwSARL4d0atza4n5u/iTPkA==
X-Google-Smtp-Source: ABdhPJxrlnvAxMSl+3epwoB8HYZGMfsPWkE8KGVioeRDms8mbTXy66Ka0tFnT+1HbxZ+RQTVeY4fMg==
X-Received: by 2002:adf:db42:: with SMTP id f2mr25788089wrj.5.1621927171421;
        Tue, 25 May 2021 00:19:31 -0700 (PDT)
Received: from ?IPv6:2a01:e0a:90c:e290:1062:9531:8150:c5f3? ([2a01:e0a:90c:e290:1062:9531:8150:c5f3])
        by smtp.gmail.com with ESMTPSA id u18sm2620660wmj.15.2021.05.25.00.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 May 2021 00:19:30 -0700 (PDT)
Subject: Re: [PATCH] drm/meson: fix shutdown crash when component not probed
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
References: <20210430082744.3638743-1-narmstrong@baylibre.com>
 <CAFBinCC0aaMUbBkJ4bjhFa0A+sZH1muyW6kqAQYfjjXOkrNPGg@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <6a350607-3ccf-1af0-be17-8a31cc937e57@baylibre.com>
Date:   Tue, 25 May 2021 09:19:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAFBinCC0aaMUbBkJ4bjhFa0A+sZH1muyW6kqAQYfjjXOkrNPGg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Martin,

On 20/05/2021 22:25, Martin Blumenstingl wrote:
> Hi Neil,
> 
> since this has not received any Reviewed-by yet I tried my best to
> review it myself
> 
> On Fri, Apr 30, 2021 at 10:28 AM Neil Armstrong <narmstrong@baylibre.com> wrote:
> [...]
>> --- a/drivers/gpu/drm/meson/meson_drv.c
>> +++ b/drivers/gpu/drm/meson/meson_drv.c
>> @@ -485,11 +485,12 @@ static int meson_probe_remote(struct platform_device *pdev,
>>  static void meson_drv_shutdown(struct platform_device *pdev)
>>  {
>>         struct meson_drm *priv = dev_get_drvdata(&pdev->dev);
> this part made it hard for me because I was wondering where the
> matching dev_set_drvdata call is
> it turns out platform_set_drvdata is used instead, meaning for me it
> would have been easier to understand if platform_get_drvdata was used
> here
> that's however nothing which has changed with this patch

OK sure, indeed, but since it's the same... but yeah it may be an issue if platform_set_drvdata changes.

> 
>> -       struct drm_device *drm = priv->drm;
>>
>> -       DRM_DEBUG_DRIVER("\n");
>> -       drm_kms_helper_poll_fini(drm);
>> -       drm_atomic_helper_shutdown(drm);
>> +       if (!priv)
>> +               return;
>> +
>> +       drm_kms_helper_poll_fini(priv->drm);
>> +       drm_atomic_helper_shutdown(priv->drm);
>>  }
> then this part finally made sense to me (as non-drm person), as
> platform_set_drvdata comes near the end of meson_drv_bind_master (so
> any errors would cause the drvdata to be NULL).
> 
> with this I can also give me:
> Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> in addition to my:
> Tested-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thanks !

> 
> Can you please queue this up for -fixes or do we need to ask someone to do it?

Yes, the drm-misc-next & drm-misc-fixes are aleays opened and merged each week in the corresponding drm-next and drm-fixes
branches, so we can push patches at anytime without thinking about the merge window (except drm-misc-fixes merged back with -rc1).

Neil

> 
> 
> Best regards,
> Martin
> 

