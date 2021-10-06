Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B607A42395F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 10:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237670AbhJFIF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 04:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237592AbhJFIFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 04:05:54 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C71DC06174E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Oct 2021 01:04:03 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so6112544wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dmA4Xp7oPSdSmCvBhmTJxkxsHtdy8x3JCS16XeREP9s=;
        b=F+/HWXciTwySDZoazcuVpR4x/G/GfTe2XEaCNfKVOnU2jkBr/uD/XbDSepip2s+VTK
         6Sba5F/TMfJbi8R3gvzYRy9ZDUIBjnXU8qUHr1pJ5Wh3EvELqm6emY505dNl33c+NQwC
         2r2DbNWRpm4QiQr6Ha5+6XYgNulS8WZZ1odf+w2/HC+v4U1onjgiokaIV+/ZEhOmYe2A
         fFPkBd+cOPeevGlbVMjfDVBcU9V2ywKYlt8BB80tw0G6xWCYMmG9kHG/rw177zQBJ8DK
         SCWcZB/RSSXgMlw73LjOF4GKvhOPRMxahIXjNgHyd7p7tRNE87m0oj/uAKea+Qjy21DC
         +bKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dmA4Xp7oPSdSmCvBhmTJxkxsHtdy8x3JCS16XeREP9s=;
        b=cMNCLwxK335oxVN0jef+fDjsmI3RmTtJ1NORHUbX+99NqCvxWTPmY53bMJTBiZGXO4
         flrmjhXVU4rchkkec6XeQ6z/Dg0JPdCx2sWhx85W7XzG3Sc4jyjQFls5WV6SsupuUIeL
         sePhM3qJzh72N0lDJ8aL3ItkOuDXclETBBz5x69AWCoT079BedO+udJ2lDRP6bhqL51d
         dHJ+MU1FpZLV3QVzp8eVYF0p7USWv4SWbEYbJ+asYI5z5v4AVCVUbmnAZjSLnYQUKmFV
         QwrWpGdZTd4t2rS90IaVx4N6lV3euFyqb1Cn5qJzpVsb2tyn3Xlwy20pQipuFkyPVcBR
         HMeQ==
X-Gm-Message-State: AOAM530Vzl4mqHnDGw5BUgLmTcglbn3osL3LDL/b4hA1LbsTGBHefaZU
        2XKmQzH8e4ozUO2olzh7rdSWUw==
X-Google-Smtp-Source: ABdhPJy4WZ9JASjwJohddraHAfJUrHNLYIjhPoJv/Otb7vX9zH87A7uqwNGZKR5zF2YcZNhxUFGiHg==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr8382075wmb.30.1633507441619;
        Wed, 06 Oct 2021 01:04:01 -0700 (PDT)
Received: from google.com ([95.148.6.175])
        by smtp.gmail.com with ESMTPSA id i6sm9831173wrv.61.2021.10.06.01.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 01:04:01 -0700 (PDT)
Date:   Wed, 6 Oct 2021 09:03:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: exynos-lpass: Describe driver in KConfig
Message-ID: <YV1Yb3W61SOqp2To@google.com>
References: <20210924133332.112092-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210924133332.112092-1-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2021, Krzysztof Kozlowski wrote:

> Describe better which driver applies to which SoC, to make configuring
> kernel for Samsung SoC easier.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  drivers/mfd/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
