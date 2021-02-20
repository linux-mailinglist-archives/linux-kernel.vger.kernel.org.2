Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F083206FB
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 20:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbhBTTzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 14:55:11 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:44034 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTTzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 14:55:09 -0500
Received: by mail-wr1-f50.google.com with SMTP id h98so9818551wrh.11;
        Sat, 20 Feb 2021 11:54:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5tf6MIS7wx3FMoHjWKkT2R+DAMHUBALHJlKkyjPuFIs=;
        b=FPENme9U7CVQ6Seq8L7dYsr6A8IwJK8ogUTooGkHBLD09Nm3/Nszsy58fMw37D1Tqz
         TAPjcNEuX/G0JuhodfB/mMdsEWsFl0LjieVwCHb2LiF9Qx5Lu+3IcR3K9w5wUnBmAqvo
         qahAxtW12T74u4iG9lfEmftW5AQnuwhavgYb0ZfghuTVcJ/ywxMZUrhMtNL4K1gPkY/X
         VZ5stHaGJf7cvkyHn/XuSFi5B3dYbtE4pNjKnYDdJadOCWKxOUomxYQDRVP1U3Rw3O2n
         OuW4rSL8iXhckXApeixzL29mCDwMl7W5yDW4gg/vEvCb+FoD1zRVBmsEgd0xwU1Wt8iD
         SvAA==
X-Gm-Message-State: AOAM531KZ6uygofcVObeZRfmCugv8nL26RcnsJSudwCJbr1mRMIsYr4A
        xZ8zYV5SHz6MeBc4IG9V/XA=
X-Google-Smtp-Source: ABdhPJzD4elNj8PnjK7DAhpcE/VqesGebCcEXMTJbD1P+fiwCItjY+PXRsYKlIh5IB76db8f7ckeug==
X-Received: by 2002:adf:80c3:: with SMTP id 61mr14832696wrl.100.1613850867435;
        Sat, 20 Feb 2021 11:54:27 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id x66sm18332190wmg.6.2021.02.20.11.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 11:54:26 -0800 (PST)
Date:   Sat, 20 Feb 2021 20:54:24 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/9] arm64: dts: imx8mm-nitrogen-r2: rework UART 2
Message-ID: <20210220195424.s7hgakedudvivr64@kozik-lap>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
 <20210219143028.207975-6-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210219143028.207975-6-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 19, 2021 at 03:30:24PM +0100, Adrien Grassein wrote:
> Remove useless clocks in UART 2
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts | 2 --
>  1 file changed, 2 deletions(-)

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
