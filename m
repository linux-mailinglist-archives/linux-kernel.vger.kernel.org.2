Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C6ED42E24C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 21:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhJNT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 15:57:50 -0400
Received: from mail-ot1-f51.google.com ([209.85.210.51]:35512 "EHLO
        mail-ot1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhJNT5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 15:57:49 -0400
Received: by mail-ot1-f51.google.com with SMTP id w12-20020a056830410c00b0054e7ceecd88so9814068ott.2;
        Thu, 14 Oct 2021 12:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BjjoPLVYxR4QFVNznLd61Ox7Uf915aKEYcxu0RJXuGo=;
        b=uo4X8e53G6OBINVA/G4hA0vfw4AUEqBbzUSxB0nrDrJyZ62xkfZwccq6Ohigwt6Dli
         aUZqFY0Ec4iY58swhT4XKYQVJXCnSvCWNceYFuepTseIgQapio9EV3FtQaOKjm/j9Dqm
         HC3czeH6F4l2OpL/jrdV/Xo3xVsLVM168Ts6eSKqwJ760WajG1vlqJOTQPTDfHhwxkgx
         O7ZJDKq8MokydYXBDY+7ZvLoM+x/fYae05BbtwM7SNxCHER3dD2t3CMuNk+9SdDhtHwA
         kn35SqruMu9uorLkYaMn0civzjZijtN8sovUaeqfwjOYamik+P9J620dwc/EMwh7BME1
         lLMw==
X-Gm-Message-State: AOAM532lQ1465wzk4sjwLLnT3IB9Wq3SNZpzsICcNH5NwsxBqqLU3+ix
        zduepITiSua3vYkb0jM7oA==
X-Google-Smtp-Source: ABdhPJxieHKZwkh11rxWgfIjHKAh+JkladUHT9gNSD6ImJZyffoXO1q3f12GPCsxFoihlitP6y7qGQ==
X-Received: by 2002:a05:6830:2f3:: with SMTP id r19mr4311154ote.226.1634241343954;
        Thu, 14 Oct 2021 12:55:43 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x10sm618924ooa.16.2021.10.14.12.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 12:55:43 -0700 (PDT)
Received: (nullmailer pid 3815835 invoked by uid 1000);
        Thu, 14 Oct 2021 19:55:42 -0000
Date:   Thu, 14 Oct 2021 14:55:42 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Will Deacon <will@kernel.org>, Fabio Estevam <festevam@gmail.com>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        linux-kernel@vger.kernel.org,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 4/7] dt-bindings: arm: fsl: add TQMa8MxNL boards
Message-ID: <YWiLPhUxjtft5lYh@robh.at.kernel.org>
References: <20211006132309.1239708-1-alexander.stein@ew.tq-group.com>
 <20211006132309.1239708-5-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211006132309.1239708-5-alexander.stein@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2021 15:23:06 +0200, Alexander Stein wrote:
> TQMa8MxNL is a SOM family using NXP i.MX8MN[Q,QL,DL,S,SL] CPU
> MBa8Mx is an evaluation mainbord for this SOM
> 
> The SOM needs a mainboard, therefore we provide two compatibles here:
> 
> "tq,imx8mn-<SOM>" for the module and
> "tq,imx8mn-<SOM>-<SBC>" for mainboards
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
