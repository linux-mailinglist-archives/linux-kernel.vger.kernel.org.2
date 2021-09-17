Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA94341007B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 23:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243817AbhIQVEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 17:04:53 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:46762 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235643AbhIQVEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 17:04:52 -0400
Received: by mail-ot1-f47.google.com with SMTP id c8-20020a9d6c88000000b00517cd06302dso14563361otr.13;
        Fri, 17 Sep 2021 14:03:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bSRL/HAt3gwwiTvd49CidfkDbJhDEQUk/H1eOxq58lw=;
        b=MaT0eS7993DozhC+TsLR780om+hQVHyfJ2Fit7cbBNulKjkvaa1Hox2rKqzb7RgJQl
         lcMbIZdPfeDBH79S/tccBvgUFkzTFjjM3rK4g4D76me7fCUk0xZv1alj6owBJ1lNoA1T
         IdomnIUk6O+rBVGzf63HVKwPOOsiz9KeG4U24OcWwFYWXoGk9tJ0by9KEqT2STuyPD1n
         Bnzm5DJUEJeS6ncnms4uC9A2AZsaYG4xK+SzjbqF82fD0tNWXXTwhgqpVG7GLRKQGJ8m
         6Sm36WWpbFiK0jBupBDZNJ/JDz/omKARa6eDazwIdNDAXMABAD2PMEEveS7fywgvDAXv
         14Qg==
X-Gm-Message-State: AOAM5313TALfXV7Kl4TTs+kiThNAFfC5dsAimOGl+58EVCNRQxI7nLk4
        oYcyDB5lhsU4hr2JEipJVTcdp9FUlA==
X-Google-Smtp-Source: ABdhPJyHEghgsCONkiA8TV/Uz/eGEB9pKxLPy0qAHmlMAmYXUJtC22LiPuviROkj6Xo/ikbU3cn/3A==
X-Received: by 2002:a05:6830:1b78:: with SMTP id d24mr11253229ote.197.1631912609355;
        Fri, 17 Sep 2021 14:03:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a11sm1714818oiw.36.2021.09.17.14.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 14:03:27 -0700 (PDT)
Received: (nullmailer pid 2156706 invoked by uid 1000);
        Fri, 17 Sep 2021 21:03:26 -0000
Date:   Fri, 17 Sep 2021 16:03:26 -0500
From:   Rob Herring <robh@kernel.org>
To:     David Heidelberg <david@ixit.cz>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>
Subject: Re: [PATCH] dt-bindings: arm: Fix Toradex compatible typo
Message-ID: <YUUCnosxz7uK4jaJ@robh.at.kernel.org>
References: <20210912165120.188490-1-david@ixit.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912165120.188490-1-david@ixit.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2021 18:51:20 +0200, David Heidelberg wrote:
> Fixes: f4d1577e9bc6 ("dt-bindings: arm: Convert Tegra board/soc bindings to json-schema")
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  Documentation/devicetree/bindings/arm/tegra.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Added Dmitry's commit msg suggestion and applied, thanks!
