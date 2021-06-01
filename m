Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643E33976AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 17:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbhFAPcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 11:32:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAPcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 11:32:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D3B9C061574
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 08:30:31 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 3-20020a05600c0243b029019f2f9b2b8aso1092116wmj.2
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 08:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=76wpUGHYFm3YaMJqur5wJZu3Y9FviRWLrs078eFj8DY=;
        b=s9BFm/8n+cVZP1SofD384n0aP8sSMBO4/4Ae+Se87GbastmZfNabAKa41CdtTMY7ro
         pnZXxpQxvnThP/nbgZv78w4IfgEMrfwdfuPqp/5MqacxoqIcNBleRbKdXH65VTFqGNPq
         JaVsrIijfTSFYPknzeIUIbTyq+lxNmwVHwHPEkj3BZeHSCaV6EVuEO8pvtgKfGiolN25
         XHz1Ll7FL2ZqmL5ZhCgvPUV/zgt60a9t7Vf/EJUQvCVs3cvC6XQsgevi1hLoYxIHxMar
         CHA6hbFIoX0ZrjJSVYYmNfbvtM+R5yllIAeT+W8WroK51PM+C6xX7Hogdh1MNu0YXemy
         MlRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=76wpUGHYFm3YaMJqur5wJZu3Y9FviRWLrs078eFj8DY=;
        b=p6I8OfUyhGSvrUMib1WVNt6oiLKECildroBrON3DH2i/ZyAK5Wn19Dk83VeiorI/6t
         xG4MpHwBioohQXjwpIqfM88oBsk9TFfo2S6l4narStED9eKCvnl0uTVX0LM2rb9Xmcz0
         1bDVFQT8YAOas73iRnll/1VHmVkEwmhrYHt20h72ORlwTG2l/pndXHv8/HsIgYte8zVl
         flprkawritQV8hev7c+KkAMTWIf/Eq01+dCLKCTa0bOrOxuLwGx03xxB2PfmRu8835G6
         ElFDNsCaD+Qgi1ZtxP3J3fluQCiahrgMBCxLZHhk7z1aNu5Cex35cfcc917/XXVJDKOd
         7Rbw==
X-Gm-Message-State: AOAM532b0EllzIfGjjIr7QPLgG5Bidnb1tT1dgADenLJcA/fNLLV+9Fo
        tyLDJigY/f0jZw04hXT0oDNEDg==
X-Google-Smtp-Source: ABdhPJwH5uEnBfUj7Nrxl1uy+34/ojEOuZwkzE4DcydGfa+x0aZFuw+pauofoW2UbUel3WHJEKC8HQ==
X-Received: by 2002:a1c:bdd6:: with SMTP id n205mr19507671wmf.74.1622561430236;
        Tue, 01 Jun 2021 08:30:30 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id t12sm4805992wre.9.2021.06.01.08.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:30:29 -0700 (PDT)
Date:   Tue, 1 Jun 2021 16:30:28 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, swboyd@chromium.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: cros_ec_dev: Load lightbar module only present
Message-ID: <20210601153028.GC2159518@dell>
References: <20210526034500.954219-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210526034500.954219-1-gwendal@chromium.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2021, Gwendal Grignou wrote:

> The pixel lightbar is only present on chromebook pixel (link), pixel 2
> and pixel C. For the latter two, the EC reports its presence.
> Instead of always loading the lightbar driver on all chromebook, only
> load it when reported by the EC or Link device.
> 
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> ---
>  drivers/mfd/cros_ec_dev.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
