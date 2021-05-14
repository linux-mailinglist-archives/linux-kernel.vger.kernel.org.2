Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3968C380B24
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 16:09:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbhENOKq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbhENOK2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 10:10:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F79C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:08:58 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id t206so509078wmf.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 07:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YCtLPYC3jE9JxKzR7HTD5CMt6z/SoxgcGj6iyP901Hk=;
        b=T82Qu8ueN4ZzYWOruhuTWGvTlUCSXtQuxqG8xYwC1Hb6QO1ZjI09XeMp/moh23HUlR
         em7QjoZFkHWrQ3SopCTRRZWt8jcybBHM6HkG75DBsOeHTDynDizM+vwk0SHc3RrPkhHE
         AuW6arBxQdIiotLnhBMhdRnQDjzhbz/8P8IfCHibVyRwLDTvfq/0zT/mW+RMT3ekFMi0
         JOPbx+PIq10EuV0CwJrhDKM0JW8gFQSLlI9Gdf+r9c/huu9hj+Rt8aoFy6n5hRJJ6LBu
         +vRISYntG8w0mTG9Zk0kpTMY0l1H9U0A0LUVHRB3FQw1+iP8i6xw75UqnS/Nofz2G+bw
         eYVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YCtLPYC3jE9JxKzR7HTD5CMt6z/SoxgcGj6iyP901Hk=;
        b=ltRJqucnRU0VBxsBGRpdAWPO9aMHPpd1hd+kC/x4AsiSVzRxK7A4YHoh5qlNqY+C73
         1TDbWhd4RGuiw6ms2vwp9EEIDvM9Ygbk4WrQ9tEhI4aPfLf34bwkdjL0akTc4cwLrCFe
         dUlF93Bz5xCyizzoReFRp7DmLlv5nLB1fA8hHoNTkPNpPpF20Vbu4P2fZu6c9Zr89bUg
         MmhytOcpOKy7w2XV0VD033SAoGWhPYp9Owxb21x1M4FTuPkmdZlL1hXyr8aZaFYRLiDO
         uofE9oAtKAVn9un9Avq0i2inEMCgWlUFtaJS3jPZ+VsH7jwhHAYPwp2w8QtyyA/k3FgP
         dAdA==
X-Gm-Message-State: AOAM533LJMJfm6uiGAfedMQtdkepw3RRFQt03AOUAObaJUOmJVsYcnHG
        zWezGpwu/GZQq1o/EqK7OCBYvQ==
X-Google-Smtp-Source: ABdhPJyuwi5my9uWsoXY3DDz2c7mxkx+kVBhblTy7fUUyo740yrE4L+6cmUb65iu5eddmsLJjobkRg==
X-Received: by 2002:a1c:e484:: with SMTP id b126mr9553416wmh.35.1621001337419;
        Fri, 14 May 2021 07:08:57 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id r5sm6177903wmh.23.2021.05.14.07.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 07:08:57 -0700 (PDT)
Date:   Fri, 14 May 2021 15:08:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add SUNIX SDC series mfd driver
Message-ID: <20210514140855.GG805368@dell>
References: <20210514112743.4813-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210514112743.4813-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 May 2021, Moriis Ku wrote:

> From: Morris Ku <saumah@gmail.com>
> 
> Signed-off-by: Morris Ku <saumah@gmail.com>
> ---
>  sdc_mfd.c | 691 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sdc_mfd.h |  58 +++++
>  sdc_pci.c | 100 ++++++++
>  3 files changed, 849 insertions(+)
>  create mode 100644 sdc_mfd.c
>  create mode 100644 sdc_mfd.h
>  create mode 100644 sdc_pci.c

Please read and adhere to the upstreaming documentation [0] before
submitting any more patches.  There are lots of basic issues with this
patch.

If after reading, you still don't know what I'm referring to, let me
know and I'll do a very quick review just to point you in the right
direction.

Must better if you can use and digest the docs though, it will serve
you well in the future.

[0] Start here: Documentation/process/

> diff --git a/sdc_mfd.c b/sdc_mfd.c
> new file mode 100644
> index 0000000..dc30f3b
> --- /dev/null
> +++ b/sdc_mfd.c
> @@ -0,0 +1,691 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * SUNIX SDC mfd driver.
> + *
> + * Copyright (C) 2021, SUNIX Co., Ltd.
> + *
> + * Authors: Jason Lee <jason_lee@sunix.com>
> + */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
