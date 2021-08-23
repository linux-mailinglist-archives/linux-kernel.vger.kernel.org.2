Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1483F50C3
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 20:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhHWSv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 14:51:56 -0400
Received: from mail-ot1-f52.google.com ([209.85.210.52]:37813 "EHLO
        mail-ot1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbhHWSvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 14:51:53 -0400
Received: by mail-ot1-f52.google.com with SMTP id i3-20020a056830210300b0051af5666070so29238660otc.4;
        Mon, 23 Aug 2021 11:51:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k5v5vOt7pd9OAOevFDKTkCcmTJtamWAMDOMUI5zyp8c=;
        b=Y1N4e7tgGyuzNujm7mU0IEPY43bzgjilQqJyI+rQKlf9L2Vumm5romRliaGX4ykijZ
         oJUqq5fa9h01LJufKL8zQfYXUGSNcyWKWnNzVfuTqFsDerPIKFwLb2VRy+vVtIpPrQ1t
         eyMZoM4x3Dl7WjR2lU/1U6OzffVjuUV5OOHLOtAMXygB0+IPtqxlhmVB1qYbgPzxzaCZ
         sDyNw6tqBm/7Rf1vlZ+OQPtnPZL5C6lKYyG5wXpXZmWpohcwQJ9VSZxfvA2e+w1kH4O9
         nEQFgXVsr7uaeY9AUd+u/C7ZkXUQ7andQyrV6OFn/rJJfo513R4Av4ELY3tL1u+UXVhG
         E8mg==
X-Gm-Message-State: AOAM532liE5TRj6R6pObXUIsqcm7e/amdPpe+xSPeQmsjxYQjjiLVee4
        e00fWHukcle+gN76E+8V9g==
X-Google-Smtp-Source: ABdhPJxnD1i+5uWhPJnJ7Ydj4Ez8U9rX4Fv35m7/kC3Wa/1RL0F1s7Kh0hYl4rhD7KgEn2rLxNRhNg==
X-Received: by 2002:a9d:4e03:: with SMTP id p3mr28211517otf.214.1629744670747;
        Mon, 23 Aug 2021 11:51:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id o26sm4038305otk.77.2021.08.23.11.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 11:51:07 -0700 (PDT)
Received: (nullmailer pid 2511193 invoked by uid 1000);
        Mon, 23 Aug 2021 18:51:06 -0000
Date:   Mon, 23 Aug 2021 13:51:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        wanghaibin.wang@huawei.com, Jun Nie <jun.nie@linaro.org>,
        robh+dt@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: soc: remove obsolete zte zx header
Message-ID: <YSPuGoBkifX+zsYN@robh.at.kernel.org>
References: <20210821030924.192-1-yuzenghui@huawei.com>
 <20210821030924.192-2-yuzenghui@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210821030924.192-2-yuzenghui@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2021 11:09:24 +0800, Zenghui Yu wrote:
> The zte zx platform had been removed in commit 89d4f98ae90d ("ARM: remove
> zte zx platform"), so this header is no longer needed.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Jun Nie <jun.nie@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  include/dt-bindings/soc/zte,pm_domains.h | 24 ------------------------
>  1 file changed, 24 deletions(-)
>  delete mode 100644 include/dt-bindings/soc/zte,pm_domains.h
> 

Applied, thanks!
