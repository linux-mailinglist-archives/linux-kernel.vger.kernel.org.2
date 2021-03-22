Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430B1344831
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 15:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhCVOxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 10:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhCVOwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 10:52:30 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B697BC061756
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:52:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id e14so3550262ejz.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 07:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=t3gPxllU5mvJHQrjHbauoFIiAOe+NDL6oN+LzAey6V8=;
        b=sjH9p+UuSallMkR4SpRTUbjft+fsLuUDwA1MjkXbCf5CN9AqHlCh6caKVntYKdIWkk
         1JRFp8EjExBnVR4TKkEBU0eY+LPWQd5YIDQ7/5WmEd0/dm4DgPrqaDckcinVxBgx3F/T
         jOdEYRBf6scpxx/kSha1gWNtwYewyMmhWOeVLllmI5ypBi3wpVv1RSxFfrht8rNCakVa
         ZNwM4gmVL+iVl5XT2QAGChnt87ciDMZOkNVou4V0ZepvUJIv+l6tZsnfqp7H2/9uyl32
         MGtpPMME6cvvZlXQSgvQGrlu7RpdWfoqBxPIUKTFmdNqrSsyL/evmANbntb5rnTH6SfA
         HDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=t3gPxllU5mvJHQrjHbauoFIiAOe+NDL6oN+LzAey6V8=;
        b=qfyhEUK3d7vtfr5m/qrVciXlaldEW957mSnE1mzxAa4qsi5QTy4DO4plP39tlJ2Y4P
         TIfW0jxjnOZbrhtcv3htD7QEgOViJ5XtBBWq3J8iwA1kLymIPOtBEZTcads2Ky90JpZE
         og/ifGzc20UDcj8BZq2fHALkX4kzNV4GkqP4ve2iBwmLxEBJMdB0mMBzt1ak59WU7Ydl
         ZWh6dhnbvijMNVDHFNQgT8cMp50SEX08w9W8GQWexRcQ9gJD7jkKnd7+fTgmnxXKfCQ/
         6ngUavu+visGBmXs7OdtsK6uJ+bUuF07OM0NUtvDoJpL2zELBI8SKjRGXTT36ukvZMdB
         XlPQ==
X-Gm-Message-State: AOAM530zuPB4pkb6eZO8VvQWkfiCHJZMnCdxtxkEJn/nvILAYYQD8FPO
        vIMnGJeG/GCB1Y2Rv+jnkvQh2g==
X-Google-Smtp-Source: ABdhPJwKLjll+CJ3xCqUU+yWGptTPOZKXWCKcZgONpfprHFHNe+nB5P+Yyi5QKdRXZPlJj0vOu/JGg==
X-Received: by 2002:a17:906:9509:: with SMTP id u9mr108444ejx.225.1616424748490;
        Mon, 22 Mar 2021 07:52:28 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id v15sm11450545edw.28.2021.03.22.07.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 07:52:28 -0700 (PDT)
Date:   Mon, 22 Mar 2021 14:52:26 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     'Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH -next] mfd: Make symbol 'atc260x_i2c_of_match' static
Message-ID: <20210322145226.GX2916463@dell>
References: <20210311131507.1902008-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210311131507.1902008-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2021, 'Wei Yongjun wrote:

> From: Wei Yongjun <weiyongjun1@huawei.com>
> 
> The sparse tool complains as follows:
> 
> drivers/mfd/atc260x-i2c.c:45:27: warning:
>  symbol 'atc260x_i2c_of_match' was not declared. Should it be static?
> 
> This symbol is not used outside of atc260x-i2c.c, so this
> commit marks it static.
> 
> Fixes: f7cb7fe34db9 ("mfd: Add MFD driver for ATC260x PMICs")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/mfd/atc260x-i2c.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
