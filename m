Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE4041AA0F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 09:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbhI1Huz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 03:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239369AbhI1Hux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 03:50:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77166C061575
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:49:14 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d21so56221532wra.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 00:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=812SXE0bU8yH/I6TeFdZqyzVxfCyJF52vd0F5kH9oyQ=;
        b=vsJDfYEtSVGQiLEMAK0x1QOR7YBgk7K5wtYVYeEoGvlL48WpsPJsre9aihHkPmgEIB
         QUvvM0QU9eWh3O/nfHs5lrGQjulXGANJsPNt4vLq1KEjLg2xx60n0RPUrlBlxPkABV/U
         McPsa0jjLZ+DgUe1T1kkeluGVajwqqsWDT/eW7XvapTtvpyivBG2UqaAflf0bJrGPRD4
         yuisVfqTqcH7VT1BiEMzUDB4A5BOkP/PHN7J5MxWUmVWy3VKSyAgu0Upi0Yxq0AjpcMJ
         K1w/rWjGOmRw6FJWOoIW5IZEEzxEiFy3aLLkNjQToqQKhm2RY8IjkkqoP8M8ll5GiMcN
         A+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=812SXE0bU8yH/I6TeFdZqyzVxfCyJF52vd0F5kH9oyQ=;
        b=4R4DIIp4o5BNLOetkEKXxtJ2n6I3O8HIFMpUv+z/K7puHfdKG3h2gyarTs2AMa1rMa
         pANvm5kxPoFgsniyuB4I7pK01qDq6ctS5iMpaR/CykjLxZyPAzbsucdmJtYbYN7pgYaE
         el4sIRQ9o17rQybOUyXMMqnwpGyI1EuCPh594YNi+96iIJaJzVOljEkwYDUhT8EtfCOi
         y6/wbJbjRCXcK0P+vsB0+HvYRg+H2unQ0zKrqM2vWy/S7NJNxYYQTLm3C7D1xaBRkn/1
         UR7GqCGVxZTGlYHhwjTXpitqLbT0fifCno5L4+J1xxQDtEzQ08MWDwDBw+XV8KPDy/mR
         2QyQ==
X-Gm-Message-State: AOAM530vQl/d3IugCgVdLaStlKUqGvMK1KmMsipEo1rzEpdqZvZnTRrF
        ZsXxBEmSdwxAb6ksimi2towJTQ==
X-Google-Smtp-Source: ABdhPJxRuU2okZ6l/x1lFP3OHWe4I2bO4UBvKsAq25LIECsB7gzN8AXN20QzSVGo9selp0ks/nO0qA==
X-Received: by 2002:a05:6000:14d:: with SMTP id r13mr4897023wrx.420.1632815353071;
        Tue, 28 Sep 2021 00:49:13 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id w1sm1852734wmc.19.2021.09.28.00.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 00:49:12 -0700 (PDT)
Date:   Tue, 28 Sep 2021 08:49:10 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Arnd Bergmann <arnd@arndb.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: hi6421-spmi-pmic: cleanup drvdata
Message-ID: <YVLI9sXN2R/IHSzq@google.com>
References: <YUsuZaMJoEMHkxgG@google.com>
 <0cc63f19506ea78d3a1c111774c97bbbc1a9a292.1632812219.git.mchehab+huawei@kernel.org>
 <YVLA14jbwqXjNM2f@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YVLA14jbwqXjNM2f@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2021, Greg Kroah-Hartman wrote:

> On Tue, Sep 28, 2021 at 08:58:19AM +0200, Mauro Carvalho Chehab wrote:
> > There are lots of fields in struct hi6421_spmi_pmic that aren't
> > used. As a matter of fact, only regmap is needed.
> > 
> > So, drop the struct as a whole, and just set the regmap as
> > the drvdata.
> > 
> > Acked-by: Mark Brown <broonie@kernel.org>
> > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> 
> As everyone else acked this, any objection for me to just take this in
> my char-misc tree?
> 
> Otherwise, whoever else want to take it:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If you do end up taking it, you'll have to convert my Ack.

Although, I'm probably in a better position to take it TBH.

Happy with either.  You decide.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
