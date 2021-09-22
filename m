Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCDA414A7C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbhIVNZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231783AbhIVNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:25:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FB8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:23:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t8so6885151wri.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=atfgY+ACKcJEBcWQ1s53Y/PqrC5zShGe6N1GjT6gXec=;
        b=E3m059Gn3tTaWwqlYoyKibddIiXnJaHfLGsAbCdF4cBz18NOSpeVzHdr50vXhhYgjI
         Zquox3ATD5Yj/S+aUKRgxo1C0+exYqReAtLKdEvET41Hhno+75N1cN8wp/Y4nZZKpvEf
         cU9W8kZdPXSNqVTbiD1qT20EhBgLPcos9P1KIL+zn2vBXy58Q7ZF3vY01QOOiU7WW4vc
         pk/CrZksn6M3cyQ1e9bHk25JQdNfgX8sboxD5+z/ReSJjOoFpp2AxnRbd13eWkEzLxDd
         h7fHtoYM2P8TFz5Q4043R6UAYY5hKlu/XqUR3+CPEhaSHypOhY2aeYcQxxTxPqeMYb80
         jqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=atfgY+ACKcJEBcWQ1s53Y/PqrC5zShGe6N1GjT6gXec=;
        b=rENaAe2XFiDdVBnYKQeDEGGp4t3p/L9TTL5JVopZTcTsXfabRZy/+nIs2MFi6ywpzI
         w9nsmOfDzbiVNPYacrhn7QNRPv+1vWthh4hET+2oSbYy2ykYswyh3mHi/OZbKheC1O+h
         iPRiqR8OCb8PnlyPv9g/Eso/ppBIvQnngNSEhkQbKuz9+9Eb2J0NNYvOPy2x85bPUb84
         4+aO+rDba014Zlpp7NQWzZE7M4A35MfwUz/YSguCnOrxrzhoUF66iGZaS3rIaGXqUv4I
         5UCTKnNHXj1+hyeUf4fJra1ct3YtU3qFD0SP8+psTFT/4OTcR+v1g0tDfKFxbiOEcy0F
         IXHQ==
X-Gm-Message-State: AOAM530qyE/kHQ9Vz45JjvcsG+FV5NFuN/ACGYuCruXyDpdekOyXEwzb
        2B+uuXjs/zXBsbx+jj1uOtvTew==
X-Google-Smtp-Source: ABdhPJyNcwMcPxCZumNC2yEBhqeCsbTQSnkaMq6tbf7bO+ZLpBWkHlAUbeyAM3i8LkdiiuzALYwnSA==
X-Received: by 2002:a7b:ce94:: with SMTP id q20mr9927341wmj.83.1632317031778;
        Wed, 22 Sep 2021 06:23:51 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id n186sm5958511wme.31.2021.09.22.06.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:23:51 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:23:49 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YUsuZaMJoEMHkxgG@google.com>
References: <1828cb783b1ebca0b98bf0b3077d8701adb228f7.1630586862.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1828cb783b1ebca0b98bf0b3077d8701adb228f7.1630586862.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Sep 2021, Mauro Carvalho Chehab wrote:

> There are lots of fields at struct hi6421_spmi_pmic that aren't

s/at/in/

> used. In a matter of fact, only regmap is needed.

s/In/As/

> So, drop the struct as a hole, and set just the regmap as

s/hole/whole/

s/set just/just set/

> the drvdata.
> 
> Acked-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/mfd/hi6421-spmi-pmic.c           | 16 +++++----------

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

>  drivers/misc/hi6421v600-irq.c            |  9 ++++-----
>  drivers/regulator/hi6421v600-regulator.c | 10 +++++-----
>  include/linux/mfd/hi6421-spmi-pmic.h     | 25 ------------------------
>  4 files changed, 14 insertions(+), 46 deletions(-)
>  delete mode 100644 include/linux/mfd/hi6421-spmi-pmic.h

Looks as though we're still missing a misc Ack.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
