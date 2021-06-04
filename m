Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1BC39C09B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 21:45:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbhFDTrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 15:47:36 -0400
Received: from mail-oi1-f179.google.com ([209.85.167.179]:45831 "EHLO
        mail-oi1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbhFDTrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 15:47:35 -0400
Received: by mail-oi1-f179.google.com with SMTP id w127so10817492oig.12;
        Fri, 04 Jun 2021 12:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xdRzbwRH3dlUEstiOB++NqKplFoQ2H4dQYDfLQ5lqYE=;
        b=rSo0Hy3lzWeG4/eo+40J/MI3HsJef6KuydJWYTmG7UjV7lTI03c6wCE7rWtBcqCJRK
         aE5pZDsgbY/WZYo/c5bAhmnxogoygUijGTskbmj5+qLnefsmcphoqkeMN1+QWY7qwRzP
         ufxTZ/NP8tQjIdcO7/23osTmMwDo6FJrN/CJWIAcqXS6q8uVCAnxrECelyxDEw+eVbYF
         K2dkyyxpenVAy3x4dd2ISpNy7DR78OGChNHw3O3gah7uMwoMDzkZvMR0CDA40lMaXfN1
         YPJ5JKdVi/vLEUzPS2nS529x45HhTFW/W79aqlFY6MYJco/bjL9UMwBrN++pYhGX8Bwa
         dvcg==
X-Gm-Message-State: AOAM533zt5IKzkhu50YFSf+uY6e6/ghdhFjP2sVS6vgEWzcBnxdN503s
        1rKjfO2L0Y+PLb8PLF75dw==
X-Google-Smtp-Source: ABdhPJxrzl1Hpzkvrfp7qAySSOFBfbeyDnZ6NE2KtBu6Cus5orErNkD3RgssxpadE+s2QvC+CHdahw==
X-Received: by 2002:aca:4a4f:: with SMTP id x76mr4026559oia.157.1622835934912;
        Fri, 04 Jun 2021 12:45:34 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 129sm630423ooq.34.2021.06.04.12.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 12:45:34 -0700 (PDT)
Received: (nullmailer pid 3792007 invoked by uid 1000);
        Fri, 04 Jun 2021 19:45:33 -0000
Date:   Fri, 4 Jun 2021 14:45:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hao Fang <fanghao11@huawei.com>
Cc:     prime.zeng@hisilicon.com, robh+dt@kernel.org, xuwei5@hisilicon.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: hisilicon: use the correct HiSilicon
 copyright
Message-ID: <20210604194533.GA3791978@robh.at.kernel.org>
References: <1621678832-14924-1-git-send-email-fanghao11@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621678832-14924-1-git-send-email-fanghao11@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 May 2021 18:20:32 +0800, Hao Fang wrote:
> s/Hisilicon/HiSilicon/.
> It should use capital S, according to the official website
> https://www.hisilicon.com/en.
> 
> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> ---
>  arch/arm64/boot/dts/hisilicon/hi3660-coresight.dtsi | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts   | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi           | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3670-hikey970.dts   | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi3670.dtsi           | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts      | 2 +-
>  arch/arm64/boot/dts/hisilicon/hi6220.dtsi           | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts         | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi            | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts         | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi            | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip07-d05.dts         | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi            | 2 +-
>  include/dt-bindings/pinctrl/hisi.h                  | 2 +-
>  15 files changed, 15 insertions(+), 15 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
