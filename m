Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE87B41DAE9
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351090AbhI3NXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351105AbhI3NXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:23:16 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEF2C06176C
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:21:33 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f78-20020a1c1f51000000b0030cdb3d6079so4316480wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 06:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=0EnoGcQxVcjVLjhlbUWYyjl1NXgdf4STxEMEBfnyuEE=;
        b=RfTVTSp1Jll5QOCFPLIM78aADWMp5XJ+7MXbtAhSEJgHyf5spRRcODCjtBNQ1Zr29M
         3zZ0ofUeQgp4EmzaiUh9syLWblSChCksVV8XwwiVndwfk9CSH9jlVDatSVNRtfSkLV0K
         UUnMG/NHEM8gFVZWGcFMqUgEVGDEhc2uWRGCLnWvDTRkfyXc2jv+7H5qafKQ8fZl3Aum
         1Nnr8yVXQDR+vs8nayhUqdLXMCaj7KCNtU5EJNuhDJL0tkmteDGs407BQjMP6qfWasle
         4POTMeon+KJwy6tnw3miMqaA96nRffXtdAm+Ky0rqO/NNPSR0QKAem7NDkk6Kx3WDKv9
         1VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0EnoGcQxVcjVLjhlbUWYyjl1NXgdf4STxEMEBfnyuEE=;
        b=CM/NhNDx0HS2SQFj3IXCXPNeXp08mxiyw+9oOgzEIE7tubFjAnKRfRuRYJKhFAdS+d
         qLgQjZSGtqlPOBoH0JMuraJyAJAEXiVGxurUJGDjuOF49chJ7cjwRdQ/y5YmmxgpfjIp
         EhGJC5s3BVqOMvsE+GdcmAGdg1pTHbAoiDSCRg8YkeyE12RRpX130AFUpcvtH3FA9zC6
         sQLFopS3k/JipYBg+dAJyLFfe0xhW60yqYAL2u4XOsn/SfNKgUcRuRhKwM7zQiN+4W1/
         fSSTo6fOdYYRx7U+m7VQDEnDa+IezbtZ3Ve8KSNJX4lNvwAlS5/LisjLfeKpBGADdOBg
         k6BA==
X-Gm-Message-State: AOAM533Zduk/xQuDqioSqvwZoLZaI9Xo+muhkjA0th7wZLUbBRn4ZcjG
        8/9V8D3/1b8yUvVnFn3dHUSiRw==
X-Google-Smtp-Source: ABdhPJyyEtgq7rfkTi/7o2F3OJOwqDVQ7uW6EcRjxsPnSK+R3odzh0Zz0IG2MLTOeNWuUz6OYd2YEg==
X-Received: by 2002:a1c:f713:: with SMTP id v19mr5199573wmh.188.1633008092422;
        Thu, 30 Sep 2021 06:21:32 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id s13sm4847931wmc.47.2021.09.30.06.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:21:32 -0700 (PDT)
Date:   Thu, 30 Sep 2021 14:21:30 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>
Subject: Re: [PATCH 10/12] mfd: dt-bindings: samsung,s5m8767: document buck
 and LDO supplies
Message-ID: <YVW52vAdxbA8LqhM@google.com>
References: <20210928084949.27939-1-krzysztof.kozlowski@canonical.com>
 <20210928084949.27939-11-krzysztof.kozlowski@canonical.com>
 <YVWx+08egbGPiYYt@google.com>
 <e5ab2ba9-e4ae-30db-8e54-8af42d7f3bf1@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e5ab2ba9-e4ae-30db-8e54-8af42d7f3bf1@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Sep 2021, Krzysztof Kozlowski wrote:

> On 30/09/2021 14:47, Lee Jones wrote:
> > On Tue, 28 Sep 2021, Krzysztof Kozlowski wrote:
> > 
> >> Document the properties with regulator supplies for bucks and LDOs.  At
> >> least one board uses it (Exynos5250 Arndale).
> >>
> >> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> >> ---
> >>  .../bindings/mfd/samsung,s5m8767.yaml         | 38 +++++++++++++++++++
> >>  1 file changed, 38 insertions(+)
> > 
> > These all need Rob's Ack.
> 
> Correct.
> 
> > 
> > But can you start with reworking the subject line please.
> > 
> > It should be:
> > 
> >   "dt-bindings: mfd: <component>: <Subject starting with an uppercase char>"
> 
> Sure, just have in mind that Mark wants them the other way around for
> regulator. :)

a) I'm suggesting you use the standard formatting
b) This is not a regulator patch :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
