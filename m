Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8294D31D92E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhBQMJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:09:20 -0500
Received: from mail-wr1-f50.google.com ([209.85.221.50]:47098 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbhBQMES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 07:04:18 -0500
Received: by mail-wr1-f50.google.com with SMTP id t15so17067338wrx.13;
        Wed, 17 Feb 2021 04:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QY782VG9a0YOmRFaSg0ui0N8/ANBfNVx3KEek5zA0nc=;
        b=b2nqY1Mb7Jx3eKd5JlNoJ6m75C2exUl74VUWX7Imndq+IWKBXr7OLOZkMouAzQ/OW0
         qVd2nVcvNqTqXBEgyT2xlMZsrCtW3QyjxPwDgnf4TMNJR9SawtkCovNy4OqdMJqPomnN
         52txPSJqvIioY+1bH2qy1VzoMb74HXw7UNvzi4D9t89Jc1sfd43kjxyMRA+p3j1k6Fbf
         LUV2GnIS+RsFO/9b4hCoSyEwdHnnQRyV9s5fV2cU1TawxPKQKAK2yrjiotPYO0BgOoED
         AxUjClykMr7er9i/9GdQL/ce4q7E6PzTuSjecc+8JtT6Zhkfis54Eg7SWBKtLHW805o4
         be3Q==
X-Gm-Message-State: AOAM5320Tx+Let9YQKcwCuoN53L9hf/Gm5jncQV8thJP6NurefCrHFIU
        J9uEmfTXSiKJjNl3IAaMA2E=
X-Google-Smtp-Source: ABdhPJy/Zg6UbPenTEt3GYG3s8LWRQZUhdH/meRT7owSzf36CpOVx/vHtDAN+wKes7LoEF27ysbpXQ==
X-Received: by 2002:adf:e411:: with SMTP id g17mr30261161wrm.250.1613563415150;
        Wed, 17 Feb 2021 04:03:35 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
        by smtp.googlemail.com with ESMTPSA id k16sm2510590wmi.37.2021.02.17.04.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 04:03:34 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:03:32 +0100
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] arm64: dts: imx8mm-nitrogen-r2: add USB support
Message-ID: <20210217120332.m4ieiycnzzbzeljz@kozik-lap>
References: <20210215231943.36910-1-adrien.grassein@gmail.com>
 <20210215231943.36910-3-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210215231943.36910-3-adrien.grassein@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 16, 2021 at 12:19:37AM +0100, Adrien Grassein wrote:
> add description of USB.

s/add/Add/

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
