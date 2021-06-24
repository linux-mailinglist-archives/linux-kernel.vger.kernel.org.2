Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7923B369D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 21:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232708AbhFXTJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 15:09:37 -0400
Received: from mail-io1-f49.google.com ([209.85.166.49]:43897 "EHLO
        mail-io1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232029AbhFXTJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 15:09:36 -0400
Received: by mail-io1-f49.google.com with SMTP id k16so9535403ios.10;
        Thu, 24 Jun 2021 12:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xeM6BF+kmfhSHu1ypq6fM0NbpYMNvzRJ0qbkk31usLE=;
        b=YFqjpMUvxTliEPULm+gXjuQ6xeM9EiQE29ySDhSiJb4NRxFXMha6sYopIXRriD65MN
         /U147g50xAPYyQs3UMmeYB81wV2VgcS7uKKyBTnu+MG1A/tCKanDiIgfVjynkxhzDucT
         stb0ZtddOmOs6e/42qexjY27pSeKkieUka+oCUQscwSS3AZDYM9iPj0XjX7ue0jkQjY+
         i9JOxqXcSIMBNcxvtD3qgn4PW8iaR4Axbjg/gD98jWaoX0s83ruWQyjcFJvFykcslnx2
         dh/FX4sbZDze4gFB6WpNob0Rcq5Cn6UEW0P8W/5Pgg/VVQaq3Zt6FNLzq+kjffMrBgLr
         j+nQ==
X-Gm-Message-State: AOAM5313Yc5PN+6cetDFGJXH5KFisZClxufXmTcp6jzvcESKO2AMaKFF
        FqdXnxyPaz+asHBVredhPg==
X-Google-Smtp-Source: ABdhPJynUegQswgABTawywZBs8oFR7DNJUPy2c6rkvU/vbFfFl2W/mhG9gTV+7gSjT1cO8dFw31q4w==
X-Received: by 2002:a02:9f8a:: with SMTP id a10mr6092348jam.136.1624561636036;
        Thu, 24 Jun 2021 12:07:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id j25sm1818105iog.47.2021.06.24.12.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:07:14 -0700 (PDT)
Received: (nullmailer pid 1821869 invoked by uid 1000);
        Thu, 24 Jun 2021 19:07:12 -0000
Date:   Thu, 24 Jun 2021 13:07:12 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dong Aisheng <aisheng.dong@nxp.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, dongas86@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] of: of_reserved_mem: mark nomap memory instead of
 removing
Message-ID: <20210624190712.GA1821687@robh.at.kernel.org>
References: <20210611131153.3731147-1-aisheng.dong@nxp.com>
 <20210611131153.3731147-2-aisheng.dong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611131153.3731147-2-aisheng.dong@nxp.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 11 Jun 2021 21:11:53 +0800, Dong Aisheng wrote:
> Since commit 86588296acbf ("fdt: Properly handle "no-map" field in the memory region"),
> nomap memory is changed to call memblock_mark_nomap() instead of
> memblock_remove(). But it only changed the reserved memory with fixed
> addr and size case in early_init_dt_reserve_memory_arch(), not
> including the dynamical allocation by size case in
> early_init_dt_alloc_reserved_memory_arch().
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> ---
>  drivers/of/of_reserved_mem.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Applied, thanks!
