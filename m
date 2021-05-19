Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DBE6388DFB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhESM1W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbhESM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:27:20 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6583C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:25:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so3340204wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=xLrYWL3G0yLTjLat+7q2Hd3GDDWtBuIS0NmnLafhHYU=;
        b=M+H82Kh+oXdkQoTtxNiRUTXDJVu7UvoL0s1lNxr/+mj4wI9o3798Kfje3T7ITTebTS
         Delp6ZcQlQgdBeKecQIrVfu6sNt6s9bKSY1JgqslFlXvhZ6jxZ3AWTHfIoW75GcuKzXJ
         g7tM0s+YS6YpJy1z9FKF9o8RscJqt97Jkzn00n7uxjAbTJxq6srRG52eqSF/hh0a4839
         n2mfu046pf421l8eXRzeZ1ySHTP6hDM8DFEkRYaBla02t5yUvnNwfjOC9udcZe19wYbn
         jIobdU10Vcz0BF36X2dcNnC+HuXNHyVSaNeXe6ypp0Rrhua3VqU3m+5GyWhqIl8fORUT
         hyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xLrYWL3G0yLTjLat+7q2Hd3GDDWtBuIS0NmnLafhHYU=;
        b=L24iQU7257jGw0o03StdEzy4d8Z+etGH+CgytO51IgI3bZZMrCmqOcJjik6MP3XnjX
         JpZzqgM1yIuNOG7XWIN2HsJRj83QGudJlW3Kx3rSAidWTzbgMp5faGiPiEyQrLQ5vPNH
         uTIznxaVPN0aM598G891DbRoGtD5Ih1BYtQjJn3br6YzjhCRfNyvkMCVLFPYyCmU1PAh
         ZQgnnyi+Kn+VQxAEO9gRMRu6pijMAunXG9OWf7Fk1M5YpxLl7ztjdGYNEutrBayQbzIL
         YD8yAJM0VXBfR1sJmP/QEa9nFIdZv8hdzgJ0tqneOJBr1qkA2Y0C/9nMiQXQdh142xox
         FrOA==
X-Gm-Message-State: AOAM531iy8QklcgGs8F1UJhuuCPyR49NwOLhNl6/egrOAGIfTXFqt/Zm
        1G1Zu9RGck5RaMhf88Cd0b01dw==
X-Google-Smtp-Source: ABdhPJwH5U+g3jgVW/9AUcDf/PS58Vd6j9YmQgA84ajaHByLY/1KPS4wN1q569g8eds+7T4LjC4kzg==
X-Received: by 2002:a05:600c:379a:: with SMTP id o26mr11196266wmr.86.1621427157275;
        Wed, 19 May 2021 05:25:57 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id p6sm9293120wma.4.2021.05.19.05.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:25:56 -0700 (PDT)
Date:   Wed, 19 May 2021 13:25:54 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Luca Ceresoli <luca@lucaceresoli.net>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Keerthy <j-keerthy@ti.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mfd: lp87565: handle optional reset pin
Message-ID: <20210519122554.GB2415519@dell>
References: <20210226142852.19632-1-luca@lucaceresoli.net>
 <20210226142852.19632-2-luca@lucaceresoli.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226142852.19632-2-luca@lucaceresoli.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Feb 2021, Luca Ceresoli wrote:

> Optionally handle the NRST pin (active low reset) in order to start from a
> known state during boot and to shut down the chip when rebooting.
> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> ---
>  drivers/mfd/lp87565.c       | 27 +++++++++++++++++++++++++++
>  include/linux/mfd/lp87565.h |  1 +
>  2 files changed, 28 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
