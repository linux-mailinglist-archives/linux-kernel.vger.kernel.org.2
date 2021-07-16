Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669033CB3B4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 10:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237062AbhGPIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbhGPIEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 04:04:39 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8A53C06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:01:43 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id f9so10989823wrq.11
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 01:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=LUaz+GS+zWVJuYW5ehQ4jb5HK9aKHSWwbmew2idPbho=;
        b=BdKqQCvS1OZI1vnkUrwlg4+sNF0QtP/eBkkTMJNrbUlOeR1AMZ/1jtPieURz1HdQgY
         MT6t23A4KqEcoQa5KfWeUftq62YBempq2JLzGwTZ3BtQPm8kLBLi9PCSM+T8bxmMhkPs
         6nb27IPNkgSmOIkt+fE551YPX+wb1LUVxtaS7JVNApwDsps+phm7aOa6ao2k/P+Ioxwg
         W5ollUOsIqxevwZdbCZ6C/cIVy61dUXDgYzp5DepRBVVMj5agXuUHz3DV6Pc5UkUIUEq
         E+Wp8mVRbk1FlvNxfgslrQrINbm6tGGOCLz9cMRKS0LNYQJ8bD/wcA2n5NuOg8izzuCW
         H+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LUaz+GS+zWVJuYW5ehQ4jb5HK9aKHSWwbmew2idPbho=;
        b=A8EwXM5h2WklbJlwXPenWmyQytNdqJrgsU1LGb01zySIKABzgdx5IhZJJgO6pl9/rH
         gsp5JyIcv9YEECY1s0xCXUa9ZgO7CZxxDp/xmHwlVxeaLvQ68JC5URDPNGL9GP0McGG6
         cj5cOD6NydaCPioPx/8j8W3j/LbCg0VccX2VYykenPPlJxErIQSVrJY4Y7gCr1M90hyK
         BKFH6qICM8dQTzthX0UrlyZLi+VjJuN/ql7DvhBxUd+ARNgGGyboz5N+SbcagcMM/wdJ
         kL93VNx/HH5VS34v+hZDTL2KS95g2PPwjo2t51XKSrRJ22LDa1P9AkSGpLqyugtQW+b4
         AK+Q==
X-Gm-Message-State: AOAM531TTpLf8Xs4BiMfjc1zT4Q8MVdYl9cymZkviOQZJVUNLVFudRaz
        izWYqLdtCFZsE75rAxsCF9ND2w==
X-Google-Smtp-Source: ABdhPJxgSztBl+UjqzA//sgn6rC1JoTWkDQJvQSko/gR9NvTImxNOZC5SsC4kGfenn2tEITuemeOLA==
X-Received: by 2002:adf:a2c3:: with SMTP id t3mr10448145wra.223.1626422502459;
        Fri, 16 Jul 2021 01:01:42 -0700 (PDT)
Received: from google.com ([31.124.24.141])
        by smtp.gmail.com with ESMTPSA id a207sm12292962wme.27.2021.07.16.01.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 01:01:41 -0700 (PDT)
Date:   Fri, 16 Jul 2021 09:01:40 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Fei Shao <fshao@chromium.org>
Cc:     Gene Chen <gene_chen@richtek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 1/2] mfd: mt6360: Sort regulator resources
Message-ID: <YPE85IQ72QOhf3DK@google.com>
References: <20210629094339.874120-1-fshao@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210629094339.874120-1-fshao@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jun 2021, Fei Shao wrote:

> Reorder the regulator resources.
> 
> Fixes: 4ee06e10dd26 ("mfd: mt6360: Combine mt6360 pmic/ldo resources
> into mt6360 regulator resources")

I removed the Fixes tag, as it doesn't fix any bugs.

> Signed-off-by: Fei Shao <fshao@chromium.org>
> ---
> 
>  drivers/mfd/mt6360-core.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
