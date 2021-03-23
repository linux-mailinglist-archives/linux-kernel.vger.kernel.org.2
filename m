Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27005345AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 10:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhCWJXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 05:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCWJXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 05:23:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F005C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:23:03 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y6so22626898eds.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=N2y3/9koPOfghEarVunJ7EPE1bMs9fXXCHbB0GMTS9Y=;
        b=G4lfetq/cA+cqK5C3FFJ+B770gxrZjHZNw6eE2R6bb5HKKPVK5qEhPo6aVjYIjTQus
         lLVDhw0Py7zKgs/JMbWvH+wzcHLROx2xiuSPGLTSuQ0my4X3Sr9pKKTPDI7XiQE96rS6
         m/HuGT36530Xlwto+U+CyXTEOlnoJPpL2i1OTJfzuOJyC9H8tdm1B4nnRZOKBOEFMI+I
         gzGEQ9QPiZgeF1jsQ3BimC67wCMrk81HE0RTWy0rI2dz427qwT9sdoVZld7uxO6UUfcr
         2xjcBprmrabPSAihDWhxEtLFdIkW7cQ3lwHefplvK1/e+FKwBELPSODa0tloltasDzwh
         ZQzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N2y3/9koPOfghEarVunJ7EPE1bMs9fXXCHbB0GMTS9Y=;
        b=FuFAYHOcTC2q2Toz3DUU2CPcKd9ecnjsT03IW+RwrJ0agSkgnqzNgdcAxIQ1Fr7CZj
         2/vO6VvENpY26CKqTQRACD/qVibQIoobJbVYnO2mYv4AozPghKqlws699uqR+FM81lGt
         B0nRx5bx31V2MKlfzWvx+MUB0r+BS4CQK+44gLjjl5MTOGxEktIiRWZL3g2/tYchloo1
         S26q3mZn9gk/iVR8A3jqGrE2c4t93lBe8WhyCuy4COAPiUpU0Ajnwi8h747V3nTIxt5z
         G1FCrP3r/5SX48+T2mL3nJrFpPZSnTaVbiMSJDuxEoiB7RmbV4djxdcw9VeTrtN+5cbe
         G+7A==
X-Gm-Message-State: AOAM530had6IB3Zsf/dBMfz6rOoOeEaKvAIQXo8qm6RYHGG2YP2sJz01
        719lgtADdIBHIsMbQhXPBAyYipoJyGBULg==
X-Google-Smtp-Source: ABdhPJw5gsgRpYbBTbp0VEgC/zV+2tnw8wqvCx39KJDcdO1kMCYGsLxNNUP50JOOshzTx2pn2F7mBQ==
X-Received: by 2002:a05:6402:13ca:: with SMTP id a10mr3637472edx.320.1616491381922;
        Tue, 23 Mar 2021 02:23:01 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id u24sm12393029edt.85.2021.03.23.02.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 02:23:01 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:22:59 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] mfd: =?iso-8859-1?Q?int?=
 =?iso-8859-1?Q?el=5Fquark=5Fi2c=5Fgpio=3A_Replace_I=B2?= =?iso-8859-1?Q?C?=
 speeds with descriptive definitions
Message-ID: <20210323092259.GP2916463@dell>
References: <20210302135620.89958-1-andriy.shevchenko@linux.intel.com>
 <20210302135620.89958-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302135620.89958-4-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Andy Shevchenko wrote:

> I²C header provides a descriptive definitions for standard bus speeds.
> Use them instead of plain numbers.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/mfd/intel_quark_i2c_gpio.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
