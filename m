Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6406E37B9DB
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbhELKBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhELKB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:01:29 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86814C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:00:19 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id a4so22994929wrr.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=O63fhjrh635Pm4YVs66HU6aLxfZXACRn4svm/z9Akc0=;
        b=AwlDOATUMJLF/cjHvvkLHE32YnqlEmop2gVO7w2+Boj9NfQ0B5poZcQ27AyTjaBQv0
         aPjLDhTfDYqJEBSkkY2l7Hcfr711OCj+nf9+heiq+ongkyqGDSFej4UPy9W8XntrTWZm
         yiXoOPDaiiT9gzEFPIerWZg+Kt/ELczCdYKg1X81ChQ0qZaWF4erYam3MRXdo7SFy0T9
         jlXWweVXgLZTLpizHQfu/o4qeJ9LgM6mSI6Z3QQipdJoXD5ZenCSBFSk2OxGJi9BbqdY
         PHUdddfOV9/oZ6fQ3kx/ejwNGGwPpChEK+2C3o76WDoAytVbmtOWr5jRtuil+rnKr+Gr
         wMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=O63fhjrh635Pm4YVs66HU6aLxfZXACRn4svm/z9Akc0=;
        b=pdvQmEgcve0Ra6FKTZq0oL/pW4KT1tLSqSNmD2xXup5fpB+JZXTvAK89ihOG6xx+Rz
         7GErZ7oA0Gi+BmqHLjbJHUPLdqyGJl8acZ8zwp+lFoP2BTbWxj5PlqUz6O7Eafc8wd48
         JouHgtXxjb6TTwgeB7o1YILhB5Vpy3wnyW9JQKzNK/H2wpTI+FJcU+KTdZrdqJEMq83g
         qDGRcqVVXOLKsxrtn7SZbDXaowsFPnRgfH1ZPJjCiZ2/4iBGKDxetGd+b5BR82RhUkmt
         kmGtzkta2Yd5Spi8xNfHI4n73ERZSfCScC8yzOLCl1PUg2bzD0Djj4jt/tn4jM3A0UNu
         0bvQ==
X-Gm-Message-State: AOAM531aO7rqGm8XRoazN3dW5xe+tm8Aw86RU5hqVxBwyClIVxkULKCU
        n8vwCcF7wbNvaiM0mTlOp7fYTg==
X-Google-Smtp-Source: ABdhPJxCU30glz7EhHtvH40nBEvzUf7yYhMtRMhf2CiZC73YENs1F565EBPiLyagOcLCyWmrH/m33w==
X-Received: by 2002:adf:a35a:: with SMTP id d26mr1999921wrb.147.1620813618275;
        Wed, 12 May 2021 03:00:18 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a15sm33423895wrx.9.2021.05.12.03.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 03:00:17 -0700 (PDT)
Date:   Wed, 12 May 2021 11:00:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Luca Ceresoli <luca@lucaceresoli.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] mfd: lp87565: fix typo in define names
Message-ID: <20210512100016.GD805368@dell>
References: <20210219223910.1831-1-luca@lucaceresoli.net>
 <CAMpxmJVzShDO7b1i_KiTdu9DGexNmgR2oA241H9=mht0iYMBqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMpxmJVzShDO7b1i_KiTdu9DGexNmgR2oA241H9=mht0iYMBqg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2021, Bartosz Golaszewski wrote:

> On Fri, Feb 19, 2021 at 11:39 PM Luca Ceresoli <luca@lucaceresoli.net> wrote:
> >
> > "GOIO" should be "GPIO" here.
> >
> > Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> > ---
> 
> For GPIO part:
> 
> Acked-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Do you require a pull-request from an immutable branch?

Or can I just take these as-is?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
