Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4F8414A28
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 15:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhIVNJv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 09:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbhIVNJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 09:09:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C25C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:08:13 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u15so6616181wru.6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 06:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0UlTC9YFRqhBz3QTWqR2IP9DXZP0uSK5Ik2W6Mi702o=;
        b=iY5FkQ83JiWEn7ZtalV2AdxKAHSpeStASXOooXqgh2fBvVUrGgrAzYiRawV1gblsS1
         vpMPnRsrNNp2Vqbv4YqRkHdh2XzuU976ttsDKIZmVnz5jLhaoeN+V/XF/CBLN5oaYYj3
         u7+1STl9zau7b3Hvut9qfabbSOnOPUA8koT8NRIAdqJWgTN1i6EtbpcdavE9catF4jQo
         iV8W0Om0LQMr8TsThQ+4uTemmXs7CVUQtwWGalq6BIX9t/mLwXx5drhZ+5Lc8y0Rzx+0
         wwfxW3MQf1NWTNesdmSedyeMEGAat6xvRMzCOmPHKJWtNCERCtucw3KOJ/9CZhmUFCyb
         0/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0UlTC9YFRqhBz3QTWqR2IP9DXZP0uSK5Ik2W6Mi702o=;
        b=6o2utH6UQv6vnnICow77dD96cYil0dWL5VivH765xGLqBJ2iVeE4ta1XCNbmLHvkcJ
         TnwEZqlMtFT3rG0cEVd/QMlLYeTxjCYwkefkupBNkeJANNgyO1a9cxUKI50er9N6ft83
         gzJfCUrnPtRyUUV6/pep+9zfA0QYEiK7uJk3J+rKyWfugyfGN3+ah8qNu5Lfrc8MBIUe
         2f0sHlXUgR11QqNqBEAOIcmZgQQexPw7b9ZTpuq7YJTQl0P0WYoQtZmbS29LYZAweEKz
         Kb8tOaPJgKqrlT/kmkkKoUIzYmm9j8BVnpR0kZbN5guXOv+Yt186j+MnB/XCOHvOPcGH
         7Xzw==
X-Gm-Message-State: AOAM530tIFNUdzJqAevi2OGdkMqIIYGmvrLLAeF1v3RX9qlR1o3Ebou6
        vrrAVv5diMru4XS96TVc8jN59nbhP1e4sQ==
X-Google-Smtp-Source: ABdhPJwmWxc0wOStqFZjl2cYkhQNxYlTz10C2QH2qK15mXFrjPuEdcaBlbJBzGBlTdSs3i/x1AlQ7A==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr41787591wrs.155.1632316091596;
        Wed, 22 Sep 2021 06:08:11 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id c14sm2149261wrd.50.2021.09.22.06.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 06:08:11 -0700 (PDT)
Date:   Wed, 22 Sep 2021 14:08:09 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Samuel Ortiz <sameo@linux.intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] mfd: Add missing of_node_put for loop iteration
Message-ID: <YUsquTRvuf0UdtkN@google.com>
References: <20210528115126.18370-1-krzysztof.kozlowski@canonical.com>
 <57a78707-e01c-29a3-b899-8715aab6c6c4@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57a78707-e01c-29a3-b899-8715aab6c6c4@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Sep 2021, Krzysztof Kozlowski wrote:

> On 28/05/2021 13:51, Krzysztof Kozlowski wrote:
> > Early exits from for_each_child_of_node() should decrement the
> > node reference counter.  Reported by Coccinelle:
> > 
> >   drivers/mfd/mfd-core.c:197:2-24: WARNING:
> >     Function "for_each_child_of_node" should have of_node_put() before goto around lines 209.
> > 
> > Fixes: c94bb233a9fe ("mfd: Make MFD core code Device Tree and IRQ domain aware")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> > ---
> >  drivers/mfd/mfd-core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/mfd-core.c b/drivers/mfd/mfd-core.c
> > index 79f5c6a18815..684a011a6396 100644
> > --- a/drivers/mfd/mfd-core.c
> > +++ b/drivers/mfd/mfd-core.c
> > @@ -198,6 +198,7 @@ static int mfd_add_device(struct device *parent, int id,
> >  			if (of_device_is_compatible(np, cell->of_compatible)) {
> >  				/* Ignore 'disabled' devices error free */
> >  				if (!of_device_is_available(np)) {
> > +					of_node_put(np);
> >  					ret = 0;
> >  					goto fail_alias;
> >  				}
> > @@ -205,6 +206,7 @@ static int mfd_add_device(struct device *parent, int id,
> >  				ret = mfd_match_of_node_to_dev(pdev, np, cell);
> >  				if (ret == -EAGAIN)
> >  					continue;
> > +				of_node_put(np);
> >  				if (ret)
> >  					goto fail_alias;
> >  
> > 
> 
> Dear Lee,
> 
> This was already a resend. Any comments from your side?

Looks like the last batch was RFC.

These all slipped through the net.

Back on my review pile, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
