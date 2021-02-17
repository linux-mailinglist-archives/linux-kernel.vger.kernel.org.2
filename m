Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7821E31DB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 15:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbhBQO3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 09:29:55 -0500
Received: from mail-wm1-f54.google.com ([209.85.128.54]:52125 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233381AbhBQO3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 09:29:47 -0500
Received: by mail-wm1-f54.google.com with SMTP id o82so2293195wme.1;
        Wed, 17 Feb 2021 06:29:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yM2rqa31pE2vSB899/jqlE3r2uEYnRVyZYaQUTQ4qds=;
        b=TS8ZAGbGw9LDb6F2v6yMi9fA933p2dfoi4ZLk2FR9iG23o6Re2CZ/ut9yYx4/wynhd
         kBa9PQghea76jn7+WLzYhfwLsT4u2bMfRzhvglSUzpADlD1AIPMJKrh4QOroSjo3up9d
         AgYs3qeCvjPvgZjx4gEjzNE3lmMAV/mzz0DLOnZT0XDauwEyQLhZvGK1Yz+3+qYNcp7G
         PW0yF3R9RhGtfHf9XxfYRLtOC42waQpV/x8A0KZ83soevH2Ev0EMReZnb1+XXmJYlUt2
         mauDeAgfJCBiGSB8geKUt79l8gwYbXsn1v65jniAnmhz6IOwiPQxTOf/NH3hCmxSyPBo
         CZww==
X-Gm-Message-State: AOAM530LL+IWuAGJFbJbpx9udos+wMRqdo31eG+2mca4Cd6WtRHMgRWL
        Hr9EKwBVWyUCMiZhHnEre94=
X-Google-Smtp-Source: ABdhPJyepK93+QBagP0ipGRdAOmgCOzt2cjHaLCE+b91sTA14WfUAplhbR7/UPM5NJE8TOMjUOhcmQ==
X-Received: by 2002:a1c:7301:: with SMTP id d1mr7341350wmb.33.1613572145912;
        Wed, 17 Feb 2021 06:29:05 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id r7sm3069313wmh.38.2021.02.17.06.29.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 06:29:04 -0800 (PST)
Date:   Wed, 17 Feb 2021 15:29:03 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/8] arm64: defconfig: Enable wm8960 audio driver.
Message-ID: <20210217142903.ij5u5n4h7ebj4al3@kozik-lap>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-9-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215231943.36910-9-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:19:43AM +0100, Adrien Grassein wrote:
> This driver is used by the Nitrogen8m Mini SBC.
> 
> Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
