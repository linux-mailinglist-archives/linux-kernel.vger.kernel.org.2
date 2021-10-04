Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F7D420687
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 09:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhJDHTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 03:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbhJDHTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 03:19:34 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62A0C061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 00:17:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id o20so10994734wro.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 00:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=VQVGfR51LJFO93JjwwwpHyJplGQTEAXbh0LuEHTWtNI=;
        b=UfH66zOW1N0DWNAcsGt3O280LZ6MWxx48G8Ve5wOiOMGlICuv6/y7yw9tTCJwdZR46
         hn54JhMeUZh2FiD+3T1Hg58TdrmDW8eDj9CQq6pQ8TFsyBRNENc/zwNiCxhm5DE3gu+5
         k8uBZlzHA7r1yourTsuBqxPb6PRJydfGYXaR4sVcGBnPE30iISGKlTdUOAIQ1GOItxrm
         DEJcvDJF6xUpyY9GtkvbJewdWJKNmlPEFL1Us3tocfGv+HBtOSfkrvz5iQWIXp0P+/ZA
         lmPQfNTUCu8Qx5BENoWpVtvIPu3Iu7Okah/5MrdCXuoEW0VZS2bVcT2O85FH9hjh/7FI
         nCTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=VQVGfR51LJFO93JjwwwpHyJplGQTEAXbh0LuEHTWtNI=;
        b=k5Iqi9cPH8Q2kCQiRrbpvYIqxoVrKaF24yVniQuV5GnjhQtxgxEXHgF2ZbRz9PWDal
         mkSEnpq2Ib931hAViDvlVZbXHSAQA459BiM1fWhrxcypDsuJT4EA5TZYej5uTnmNNmxZ
         C84ARebXVD7MY+e4Xvo0wvGnHSTX/CK298AkMiZGeRERzIJQvOxZtDwxWp1ect+JBbOO
         UuFf4isCcUBiUtfjE86OuBlLx2Z/U/ZCS4Ek2M34jS4LyNl9NChGHhXpN9DdXLSc+xeo
         zoJvyO7KPLVpoWLUnR7CtF7KbSPU0M44FKlKbJEVOd3Nsv8ammy4+11RTI1uSYUfNb73
         jM8g==
X-Gm-Message-State: AOAM530JMCNEG92r3z1rliSlvlr+a96XnuQZY4iMIcOh4mIk0tP7jgCG
        PQIMCr5Ofwdr2ypR39azUymHoaWho+2biQ==
X-Google-Smtp-Source: ABdhPJz3sL0Quw6VWlijAu+IirB11LA3rNUOAYXhuRVSYP8L+mddNpIvLfp67/8zYYOt8jD0PbzbBA==
X-Received: by 2002:adf:fbd1:: with SMTP id d17mr12232569wrs.146.1633331864553;
        Mon, 04 Oct 2021 00:17:44 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id i27sm15796982wmb.40.2021.10.04.00.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 00:17:44 -0700 (PDT)
Date:   Mon, 4 Oct 2021 08:17:42 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Orlando Chamberlain <redecorating@protonmail.com>
Cc:     andriy.shevchenko@linux.intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] mfd: intel-lpss: Add support for MacBookPro16,2 ICL-N
 UART
Message-ID: <YVqqllKyNF4A424K@google.com>
References: <20211001084905.4133-1-redecorating@protonmail.com>
 <20211002111449.12674-1-redecorating@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211002111449.12674-1-redecorating@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 02 Oct 2021, Orlando Chamberlain wrote:

> Added 8086:38a8 to the intel_lpss_pci driver. It is an Intel Ice Lake
> PCH-N UART controler present on the MacBookPro16,2.
> 
> Signed-off-by: Orlando Chamberlain <redecorating@protonmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v3->v4: reviewed-by line
>  drivers/mfd/intel-lpss-pci.c | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
