Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0BC93E0159
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 14:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238204AbhHDMoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 08:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238184AbhHDMoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 08:44:09 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3683C061798
        for <linux-kernel@vger.kernel.org>; Wed,  4 Aug 2021 05:43:56 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id k4so1129186wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 Aug 2021 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6BWC3c/3rtkcV7WXMXe6RZt5i0F5nTHF+1FQsvoNiWc=;
        b=DVq+BkOnipOsYifSFqEfB33PAboXxf4yC1DlXMX8OZjgBcWoDb/PvjiTQAM+pldWiF
         WKx5n4lmIqxmpC/5uEwU0rnS3tgnX3U2RZn8iHSU9dVOfvxkTwajLHtnUDx24qUPwtBr
         MfxPsHz4MOlIJ/6pPk6hj9vZiGX2SkkELFaMoiUCUrXZJecz7hTXTb8xf0X2C30F/XwL
         oB0Xm03ETuwWIGXdfyZwXAvwck+hb70VSL6hFlS8a16kqAtvjY4YI3zZz9PPE4FVf22n
         3+petT6681yrUhP0G0OKMgCS7WCDYPQk/KBJSJu7m0PHAdbTaimG6kublfgWXqIl3LWQ
         eivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6BWC3c/3rtkcV7WXMXe6RZt5i0F5nTHF+1FQsvoNiWc=;
        b=ZK8jGybv7tHKjU4+1tI20SG1ExIfNPJbeX4oskSvkimjxKMEIal+s1K/HB2TAZpZI4
         royNZ43SgNSbC5LHK5YwUpGyd862z9PouN7GvRpoFZTNIysXIvs1ebvToVECoSIEkeyp
         gsW7OKsSJYQy7xZ+aVgM9AT/ynVJ/l+jTdCf/rq97QcdqVsMACgHJNix/hFc9VfVm+Ht
         0fCSgFuiS/i6LDYjpld7y5DrnShajVbNRkwxRN7cnkd6f62KLotHaM2iRB7xnsQhkwMp
         J3aWDcv8l3O/L6g/0ELiEv+yT6WA957AgsbalBU+dga242cUaGFwUf4aorAUc1JHVm04
         nlkA==
X-Gm-Message-State: AOAM533gNpIWfPiuGtP6hl4wTwOW4TJCogspZGb7TRbYMeJ19wOn3BHW
        BSDznYmwbeo6wt6DoOtJQioi4A==
X-Google-Smtp-Source: ABdhPJwqlMcWUuT1k4rp9W71z1LZAiPVMqbRmaxo+YUt5J7u0104g6hRhluIpipBDZiacPGaHfD02A==
X-Received: by 2002:a1c:7f50:: with SMTP id a77mr27174231wmd.163.1628081035533;
        Wed, 04 Aug 2021 05:43:55 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id r129sm2215438wmr.7.2021.08.04.05.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:43:54 -0700 (PDT)
Date:   Wed, 4 Aug 2021 13:43:52 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Alistair Francis <alistair@alistair23.me>
Cc:     robh+dt@kernel.org, lgirdwood@gmail.com, broonie@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alistair23@gmail.com
Subject: Re: [PATCH v8 09/11] ARM: dts: imx7d: remarkable2: Enable
 silergy,sy7636a
Message-ID: <YQqLiAtAtREWTvD7@google.com>
References: <20210803084456.198-1-alistair@alistair23.me>
 <20210803084456.198-9-alistair@alistair23.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210803084456.198-9-alistair@alistair23.me>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 03 Aug 2021, Alistair Francis wrote:

> Enable the silergy,sy7636a and silergy,sy7636a-regulator on the
> reMarkable2.
> 
> Signed-off-by: Alistair Francis <alistair@alistair23.me>
> ---
>  arch/arm/boot/dts/imx7d-remarkable2.dts | 42 +++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

I don't see the DT documentation for this device.

Has it been accepted/merged already?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
