Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 391B9368E73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 10:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241455AbhDWIFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 04:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241441AbhDWIFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 04:05:40 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD527C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:05:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id f195-20020a1c1fcc0000b029012eb88126d7so710207wmf.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 01:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=twVEtT7rIy9dXnyqbzyr3HvLucxiC494zCrjV35XuTk=;
        b=kdF2v5JMqKyFh4njwyLD+HdcXar+lDajjhxK3L6j/3po8Lywj52ggiE5vdKkcxBtTw
         8AO4dafvoTYi6fJg03nYm5bbX9dzmvTvFS82xm0HKhFz4cedDkh9vZbtN+PeaM6zKJMv
         T/lb2hgPFmbFEEmXRuBdy2jx18xpcbI4/NSSaUpjOAizRwEMofxpW3RJppf5eNrXI+oC
         9SDWd48tAvvGExDNrKizS9T/B6i2pfLcXgdhWa6+xkDu6jmZM7OU6atjNB2xU6Vl7jxj
         M0KVO2VKxfPu96xdNrlqDxHz/xuHDRR4UVuF6w0mFsU3V8ISMup6jyyHAT/t7XCo1Qj1
         tQ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=twVEtT7rIy9dXnyqbzyr3HvLucxiC494zCrjV35XuTk=;
        b=lU3vSEBKbhr8YeGbT/F6u6fSgoUwhYQ1UNvjONNpvOxHXAMeTpftqGH5SnLUfflQTQ
         k0CH+kSWSvkzyhKMa/9WZaNpvamkdA2tnZVQUVHPp4VBm0GtRRvh0QMKZEvI8L6JpkZs
         Zm9l75/84ggfyV1WNnZcoM8gFpyvfQXDsaymdraH5BDFEKMlX0T9eidupqY9fqRiNiGt
         ABAzu4L5aGIsfdr23zG1x8A3U0vAJBy5LhwxeU/QaSsnfCi4JVHcBE+QK/qf6T9twYc4
         SxHCVphVCSSjlZmE0N7Kh1Myi/Yxq22pao11NOnY6MZLh3rBqUDWb8px3I+VnUU2C3yC
         X8bA==
X-Gm-Message-State: AOAM531IsCg6BJo3TlD8wU7LiIGVyHEQylWySz+cptbaIolXN7WxLIOY
        jP96qYuZO/TufOUZ2Zf/coN4IQ==
X-Google-Smtp-Source: ABdhPJysFnNM8NGGuop8aU7TQC/qnuYf721AsKiJ6AFYBgfM2W9bePEFM2DYWAxASwL2LRTrh8qOrA==
X-Received: by 2002:a1c:4b19:: with SMTP id y25mr2831948wma.91.1619165102540;
        Fri, 23 Apr 2021 01:05:02 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id a72sm6795317wme.29.2021.04.23.01.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 01:05:02 -0700 (PDT)
Date:   Fri, 23 Apr 2021 09:05:00 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Support Opensource <support.opensource@diasemi.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org,
        patches@opensource.cirrus.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [PATCH v2 6/7] mfd: wm831x: Correct kerneldoc
Message-ID: <20210423080500.GB6446@dell>
References: <20210420113929.278082-1-krzysztof.kozlowski@canonical.com>
 <20210420113929.278082-6-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210420113929.278082-6-krzysztof.kozlowski@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2021, Krzysztof Kozlowski wrote:

> Correct kerneldoc function name to fix W=1 warning:
> 
>   drivers/mfd/wm831x-core.c:121: warning:
>     expecting prototype for wm831x_reg_unlock(). Prototype was for wm831x_reg_lock() instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> 
> ---
> 
> Changes since v1:
> 1. Add Ack
> ---
>  drivers/mfd/wm831x-core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

FYI, a patch already exists for fixing this.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
