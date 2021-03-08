Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E9A2331017
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 14:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhCHNzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 08:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhCHNww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 08:52:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91653C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 05:52:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y124-20020a1c32820000b029010c93864955so3852068wmy.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 05:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mAbW74EMUf5j7pN3HSEP9JBqZuh9lykiHoIS2j3ZlgI=;
        b=Si3n2lgNxGMINJRyTI09ux/FEkCMdC7JTyUEVuR8ZVQwsDAix6lGj8GagwFP63H4SM
         lhKYvCnAXejkhyOBSiwvLUoJY7Q4lrXvDmyr6ExnEbjtGVy0ihp6SPpfnAnh2o6+sL18
         kM7gH/p6UJOvShEdnA8g/kvLFCO4ltEF40vEZgV+lJRFdhnWttUK7S7719t7a+DO5srh
         /reRQFBAmVJ3HNnzJIxakG1AVaLWAucuJpEZXDdr1HH1qcnRlg3RwnrcEX8QhsdQ2BKK
         HrNxRa8N9aL7vSMoq0Ptm8QtXlD5Cdcwx6Ip6/85kiWrXrp9BlL4E8PHdWluXE3bblIZ
         kV/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mAbW74EMUf5j7pN3HSEP9JBqZuh9lykiHoIS2j3ZlgI=;
        b=lmTiporWC74SQe/IZg7esXfjo4L0K3LvLXLobbRaeu0NW6Bdy4QsosM1h+5A5Os5Fn
         31spc07pArTTEMLhqpKofzLqPxYism+v4k3UhkPOe8HI5wMEazXYK+rd9IQc6NYDmghx
         +zliWloMhv4h9dMZeTcLpHB/7kD9i7alKrzy5pq2cp/hgWhVbeLHNN2zn9CTJxOTTvFz
         LAtEND6FYrBBfqyK8f2FfSob3l7wkIEYEEYN+wMZBlbUdSAYsnrRLtUVmgSYRnctlFnS
         mu+cDBjjk2Z7fTcCzywJJR9gH/p6RdaFGZkrA+aF7DS3S7/bjPjG5q6HTvQYVVoNqs5r
         ojmQ==
X-Gm-Message-State: AOAM530dvHDujHHogxoUeZEfHdYFfNwv955VpsMIeXip7In6tB503QfP
        1Ur6EFgU+JcuMNhJvQ9hm7Vv3w==
X-Google-Smtp-Source: ABdhPJziCqyIo3Fj4IEaQq8j3EcFiOAamlbg5Tya8yc2OA08bcxejAjBLqEYbsgF7kGxCIg2UcjTXw==
X-Received: by 2002:a1c:c906:: with SMTP id f6mr21824541wmb.128.1615211570330;
        Mon, 08 Mar 2021 05:52:50 -0800 (PST)
Received: from dell ([91.110.221.130])
        by smtp.gmail.com with ESMTPSA id z2sm22515850wrm.0.2021.03.08.05.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 05:52:49 -0800 (PST)
Date:   Mon, 8 Mar 2021 13:52:47 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Wei Yongjun <weiyongjun1@huawei.com>
Cc:     Hulk Robot <hulkci@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mfd: arizona: Make some symbols static
Message-ID: <20210308135247.GG4931@dell>
References: <20210210075626.1096193-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210075626.1096193-1-weiyongjun1@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021, Wei Yongjun wrote:

> The sparse tool complains as follows:
> 
> drivers/mfd/arizona-spi.c:28:31: warning:
>  symbol 'reset_gpios' was not declared. Should it be static?
> drivers/mfd/arizona-spi.c:29:31: warning:
>  symbol 'ldoena_gpios' was not declared. Should it be static?
> 
> Those symbols are not used outside of arizona-spi.c, so this
> commit marks them static.
> 
> Fixes: e933836744a2 ("mfd: arizona: Add support for ACPI enumeration of WM5102 connected over SPI")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/mfd/arizona-spi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
