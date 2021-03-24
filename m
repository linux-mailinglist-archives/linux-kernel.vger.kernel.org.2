Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 353E8348277
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 21:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbhCXUBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 16:01:06 -0400
Received: from mail-il1-f173.google.com ([209.85.166.173]:45779 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238105AbhCXUA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 16:00:59 -0400
Received: by mail-il1-f173.google.com with SMTP id v3so110538ilj.12;
        Wed, 24 Mar 2021 13:00:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o9BolycY1dk1oCMqG/ECsDRoRL4IdcIFZl4NfEXb4YM=;
        b=q8DbnM28oA4FQk/lBQR6VijXEs/v8KNwwh7qh6HRy/DqGMrBvxO/bKLTQZGWznOUF0
         4o1ajg3KIEwVg80mnEkDX7YEpOZIDHM/T5FwIm2GC7ksX5Re1VzGIsVPuysTbjXjQcxW
         NZldicLOyen7Rhu5ruu4W4vZulkhIeauZnZPBZlUv0gDDXYyDQbmsne3fxo8E7uwgNwm
         jfCykQzqQqFP1Be4DP2hDsJ3GYa1wvGYK7x28HRBsCU7BvYM7QmNBNRw933+FFgeFGKn
         4uneuJw2iw2dLU/UjSjeNGrdvb4VXVSfIyQNFbcD10lWUupYdYAMtG2eWPttb3frc3El
         7tBA==
X-Gm-Message-State: AOAM531CUUmNLaiceSJ2DLzSbpKXoIGkCj+Y45dFWwXJo/VrbTzwirLo
        b+11fmCthNYoGfqcADSu3w==
X-Google-Smtp-Source: ABdhPJxezF3J929dadMtRF7dZwAzTNxltAgx4npaqaJ7XUZo+rKBIOxckvfxo6x2n9ViPDQllfgmjA==
X-Received: by 2002:a92:d6c8:: with SMTP id z8mr3903944ilp.162.1616616058476;
        Wed, 24 Mar 2021 13:00:58 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id 74sm1504924iob.43.2021.03.24.13.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 13:00:57 -0700 (PDT)
Received: (nullmailer pid 3527925 invoked by uid 1000);
        Wed, 24 Mar 2021 19:59:51 -0000
Date:   Wed, 24 Mar 2021 13:59:51 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     devicetree@vger.kernel.org,
        Aditya Srivastava <yashsri421@gmail.com>,
        Wei Xu <xuwei5@hisilicon.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] devicetree: replace invalid kernel-doc comment headers
Message-ID: <20210324195951.GA3526633@robh.at.kernel.org>
References: <20210322072343.19993-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210322072343.19993-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 22, 2021 at 08:23:43AM +0100, Lukas Bulwahn wrote:
> The opening comment mark '/**' is used for indicating the beginning of
> kernel-doc comments.
> 
> Replace uses of '/**' for invalid cases in dt-binding headers and dts.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Rob, please pick this quick kernel-doc cleanup patch.

dts files don't go thru my tree. Please split this into 2 patches.

> 
>  arch/arm64/boot/dts/hisilicon/hip05-d02.dts    | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip05.dtsi       | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06-d03.dts    | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip06.dtsi       | 4 ++--
>  arch/arm64/boot/dts/hisilicon/hip07-d05.dts    | 2 +-
>  arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 2 +-
>  include/dt-bindings/reset/hisi,hi6220-resets.h | 2 +-
>  include/dt-bindings/reset/snps,hsdk-reset.h    | 2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
