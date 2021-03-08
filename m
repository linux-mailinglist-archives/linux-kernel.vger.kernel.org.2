Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B47A3317BD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbhCHTun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:50:43 -0500
Received: from mail-il1-f177.google.com ([209.85.166.177]:38838 "EHLO
        mail-il1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbhCHTuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:50:21 -0500
Received: by mail-il1-f177.google.com with SMTP id f10so9958985ilq.5;
        Mon, 08 Mar 2021 11:50:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DSUyG3mu0/9jdTY7TVQwj3v3J1C7FTS41+rTEskb/9k=;
        b=X8r7B8nsqye3V3K9vPw4wMl5Jm/1CGUaxmTNhsfj175kCnXYNJ5z4Ucnps6KRkwGdG
         5EJN84P/VRdD9nkFzeIONJn+CnliSPOu1FhhH15UdvIkso5Nl2h70yLv3P1UOHjLvqeS
         E247pFXEI+1gzzOtM/5EeHC2sF5CJ9Yfnr8pJX5jORLC5uaCGiY+/bOAY51MFvQjaIw1
         j6KuukLerwT4MtLXhvyolnvo5MDwRzh5ux+/L1veNfD2ErU+/fOdrl8C1SML9+epaSJO
         a/6oZ7l2ZMD9J2cpwdsfzh7U+E2icmsbGh/3G3Q2QhIe2DRlip6gmOWus/2aj9DYsA31
         8Ytw==
X-Gm-Message-State: AOAM533NDtys0L9j6aU4qXuV1w1yqKPBumvJok+CUMxDXRkWL50LUMU5
        TWN/uB28aFB3IUeemsZB0wtl7HoddQ==
X-Google-Smtp-Source: ABdhPJxMFNZcs6lXUDVILq/ibVdC1V2O1oNCmei56AYh5VP3lqbdu8fcx8woUMSADxSUMJboA4LdTQ==
X-Received: by 2002:a05:6e02:1a03:: with SMTP id s3mr22436148ild.178.1615233020999;
        Mon, 08 Mar 2021 11:50:20 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b9sm1966901ioz.49.2021.03.08.11.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:50:20 -0800 (PST)
Received: (nullmailer pid 2854890 invoked by uid 1000);
        Mon, 08 Mar 2021 19:50:17 -0000
Date:   Mon, 8 Mar 2021 12:50:17 -0700
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alexandre.torgue@st.com, linux@armlinux.org.uk,
        vladimir.murzin@arm.com, robh+dt@kernel.org,
        mcoquelin.stm32@gmail.com, afzal.mohd.ma@gmail.com,
        linux-stm32@st-md-mailman.stormreply.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 3/8] dt-bindings: arm: stm32: Add compatible strings for
 ART-PI board
Message-ID: <20210308195017.GA2854839@robh.at.kernel.org>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-4-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614758717-18223-4-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021 16:05:12 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Art-pi based on stm32h750xbh6, with following resources:
> 
> -8MiB QSPI flash
> -16MiB SPI flash
> -32MiB SDRAM
> -AP6212 wifi, bt, fm
> 
> detail information can be found at:
> https://art-pi.gitee.io/website/
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  Documentation/devicetree/bindings/arm/stm32/stm32.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
