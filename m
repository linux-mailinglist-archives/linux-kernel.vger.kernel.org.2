Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 582EA321F56
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 19:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhBVSpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 13:45:09 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46479 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhBVSnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 13:43:00 -0500
Received: by mail-wr1-f48.google.com with SMTP id t15so20086387wrx.13;
        Mon, 22 Feb 2021 10:42:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BL77vM0HRpNmiBSiLpt5KYYRW16ZS0UDo7tk1GSutJ4=;
        b=r0TuVrRdY+G++OyscIM6pZYZu/Yahr97LemJhuBN+rOWILzD3lk3EFafL8/3zOBFTj
         XP3vySiO77VVfLCtPs9XjL47mD7NDA6424l9QI4eX80S11GqDMFkPKVjWmGbVpFsQuNW
         8CPZgpibBreYeiaF0bIKwDgosjOp29RJ3lPZctzsq4JTzuQTAD+wp6Fz6oQqxaYBpmE5
         eaDuOf4Ml3kKvahYvnxw98nQ8TRhiEQ4gu2Pt1HPoQmvwR/YEupmREuThMAj9hNw5gVB
         3F9usYQfFPNsfKRU1NN3uyjtYR9RcVLTTEk/wCo0Ru2jioHkmRG9yUNHBU+XljlTINrh
         2hVg==
X-Gm-Message-State: AOAM533Hv6VFVm5N2nssv1LKjIxpQ5g4U6lnXPrRZoOwqqiP3Z8kucm4
        Qv3jmpJUo909g7rJb/i4a5Q=
X-Google-Smtp-Source: ABdhPJx2sRzIShTstWTJCCXXuKbdCUBysn8I6z7sTPvk7DtFY3RD05/lZtZwEDKTN/VB0ApdWoWW4A==
X-Received: by 2002:adf:a31e:: with SMTP id c30mr17131667wrb.291.1614019338571;
        Mon, 22 Feb 2021 10:42:18 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id 19sm207043wmg.2.2021.02.22.10.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 10:42:17 -0800 (PST)
Date:   Mon, 22 Feb 2021 19:42:16 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, Michael Walle <michael@walle.cc>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: fsl: add Kontron pITX-imx8m
 board
Message-ID: <20210222184216.vjj4qidb3zrei62r@kozik-lap>
References: <20210222140756.713-1-heiko.thiery@gmail.com>
 <20210222140756.713-2-heiko.thiery@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210222140756.713-2-heiko.thiery@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 22, 2021 at 03:07:55PM +0100, Heiko Thiery wrote:
> Add the Kontron pITX-imx8m board.
> 
> Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
> ---
> v2:
>  - bring in correct alphabetical order
> 
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
