Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFE13B29EA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 10:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbhFXIJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 04:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhFXIJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 04:09:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA82C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:07:17 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m3so3297862wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 01:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=bQUxqYvEQbwrTWwOlp2uFZwQKid1HyK+PsBGEywKHpY=;
        b=g6764K3VIcCw92DYKTdMZuBHRgJ72tPzvbRx1mXxynnKxSX0ZOL/65BNZDSUJpTh5B
         ahvO8Kn2ie7YcNnKfdK9B1fUVZIOgcTVuaiJunJarY4AG+iP3fIDjzHBNfw0AeE8lA3h
         w9aLIh8v24GhWDVOVJUkgPG9WnJHKyueyTvMjZg3Ra9WfkhEwmTsaJxPsBCGm3mdN7QK
         lLCEh+1ihXvlpbmVaeVmLethjuHjqrAd0kEaIDE76t1BQH+yLORTShklKl3DHbOa9H1v
         5TEe3mH/tWOaNJgxcauZXQY9lAexoWY6HcNRmtBY2IsSmsdGqjWLVkDM20T8qGkccUfr
         PEjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bQUxqYvEQbwrTWwOlp2uFZwQKid1HyK+PsBGEywKHpY=;
        b=E9YbISgs4aAW1UYVte66XgChP4wjNyLqfxIEOcAq4XuLxgcArhLA8ebn/xgBqvJCyq
         aYr98uMwZwSo520jmGQNuBFaf7yaoL7EPxB95jrp5h3TV4asAMQoKfBxsVWHpTqY9kIg
         37+QnUIf6iIss9x4aSPpXXOqq7qQZHC1iMSqUHPKCnqebzJLPeE1cDeRSBswZZZ7W2FS
         4VR752pr8aYiPf6U1Auuu8ZkEAz4jQYhYLRFXg9YOc4Sw3t+YAviJP1Z/KNBdj1+gNG8
         r6efW2r0gcVn0TteuMm2fCU8fsG+SnhV0i1hDM2eqjyQU9JkgceUGYknXyyddfcO/Cuc
         YcpA==
X-Gm-Message-State: AOAM532aIp1ezijqkw71FNhfAQ5xyiZflESmP2ZJ1Xh4KahXv6FkD4kJ
        i9mq31Q3cHm7QuVq4M/b7XnYvg==
X-Google-Smtp-Source: ABdhPJwsOTnSwpzVm8hMKH9H6prTnCOoRYe7RmNEfVUVOEm1yvJUlMngkwEynAChqq727y+Stp+d5Q==
X-Received: by 2002:a1c:2601:: with SMTP id m1mr2810880wmm.185.1624522035835;
        Thu, 24 Jun 2021 01:07:15 -0700 (PDT)
Received: from dell (92.40.180.82.threembb.co.uk. [92.40.180.82])
        by smtp.gmail.com with ESMTPSA id g15sm2309146wri.75.2021.06.24.01.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 01:07:15 -0700 (PDT)
Date:   Thu, 24 Jun 2021 09:07:12 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v6 6/8] mfd: hi6421-spmi-pmic: move driver from staging
Message-ID: <YNQ9MPXTamQL46uT@dell>
References: <cover.1624442566.git.mchehab+huawei@kernel.org>
 <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624442566.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624442566.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Jun 2021, Mauro Carvalho Chehab wrote:

> This driver is ready for mainstream. So, move it out of staging.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  .../mfd}/hisilicon,hi6421-spmi-pmic.yaml      |  0
>  MAINTAINERS                                   |  7 +++++++
>  drivers/mfd/Kconfig                           | 16 ++++++++++++++++
>  drivers/mfd/Makefile                          |  1 +
>  .../hikey9xx => mfd}/hi6421-spmi-pmic.c       |  0

I can't review a hidden patch.

Please re-submit without '-M'.

TIA

>  drivers/staging/Kconfig                       |  2 --
>  drivers/staging/Makefile                      |  1 -
>  drivers/staging/hikey9xx/Kconfig              | 19 -------------------
>  drivers/staging/hikey9xx/Makefile             |  3 ---
>  drivers/staging/hikey9xx/TODO                 |  5 -----
>  10 files changed, 24 insertions(+), 30 deletions(-)
>  rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (100%)
>  rename drivers/{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c (100%)
>  delete mode 100644 drivers/staging/hikey9xx/Kconfig
>  delete mode 100644 drivers/staging/hikey9xx/Makefile
>  delete mode 100644 drivers/staging/hikey9xx/TODO

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
