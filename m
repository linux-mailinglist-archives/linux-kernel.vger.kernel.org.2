Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC9834E495
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:42:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhC3JlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbhC3Jky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:40:54 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7960C061762
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:40:53 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id x7so15553497wrw.10
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vK5my0ZUvnE3yQT07Yr3t5BPkTNQ757UrFP2HmpMEqU=;
        b=pwtQ7vS28Ij9NgnEFG64k7UmHatpMbdEB0xrQflhhME6T4PtpnXmTDA/i5wUNFi2fY
         aXG1cbu5+qdmGnEs3AvxIq9cl1OQslFuenEI5PGpl7ElvTw49eJtrWBFEQBJzMT93YQr
         OQFg+q8bROKeKicJDTz6+Arw8C/l0MepWiRYwZ//G7kHUwLg9repVy1V4vq+aNSODuMj
         0iTQYvdvK/rolJXfoRi2Z4cEpBxfipi+rMLulwuUzyAmtVk+DQ8PtPP4d/wwmpazt7f9
         TuMsNVPFJDJrOBHLGEjTd5YlSPGQWlMeugi9vLieSzW9/kocP83EmZ2rFMbzO0bS1tPU
         1EEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vK5my0ZUvnE3yQT07Yr3t5BPkTNQ757UrFP2HmpMEqU=;
        b=Hew1gXse7HXx1IazgeHQVPbGdiOwG2ksa6WFxRmIp++/BukfQ7XV/ykQKoZIIoXQEP
         j/CFpK9yd6R/WJASklQaOMXggwzpM4MuP7Rjc0PHkKIP2xZK2Hoz8Z3aOuRnWJRgkIXw
         rJb9Ifj7hNYU9YgFH4/Cue5YLzpXmRwbxqWxbA6lQbvHZNPYV0OJ6CebZZeIxsZ8yKXr
         szTwAC0yuhIN4NOcUP5MpFFqRwX/7eOysq4C5seaiSBw7DCpRwD0F6P9GCKXYPcXs9ZX
         UifWIL/WfdzqWR6/JiWgj1L3aAiqvsXNSqGpsHlSmYiTO9RBF+wmQh1eegNTW5gLbWkj
         cqbA==
X-Gm-Message-State: AOAM533Wam12AAf8Wzm/KqHAhH6YqgM/Iciq6Qa8LC6r5oFR66wjXlQY
        ujDxFCrtOw5eo9iw2Kewhm19jw==
X-Google-Smtp-Source: ABdhPJzjX+biq2E+xCutS2PKnY7h38J6qdbfaKGuEAvWAxWabNS6zityVFVvJcqRRVIeOPoi+FULlA==
X-Received: by 2002:adf:f3cf:: with SMTP id g15mr33299889wrp.57.1617097252428;
        Tue, 30 Mar 2021 02:40:52 -0700 (PDT)
Received: from dell ([91.110.221.217])
        by smtp.gmail.com with ESMTPSA id u4sm35108670wrm.24.2021.03.30.02.40.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 02:40:52 -0700 (PDT)
Date:   Tue, 30 Mar 2021 10:40:50 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Moriis Ku <saumah@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/7] Add Driver for SUNIX PCI(e) I/O expansion board
Message-ID: <20210330094050.GI2916463@dell>
References: <20210330082350.6890-1-saumah@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210330082350.6890-1-saumah@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021, Moriis Ku wrote:

> From: Morris <saumah@gmail.com>

A well worded, forthcoming commit message is required.

> Signed-off-by: Morris <saumah@gmail.com>
> ---
>  spi_pack.c | 1506 ++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 1506 insertions(+)
>  create mode 100644 spi_pack.c

Please re-submit the whole set to all the maintainers.

Just change [PATCH] to [RESEND] and resubmit.

You can do this using `git send-email`' --subject-prefix arg.

> diff --git a/spi_pack.c b/spi_pack.c
> new file mode 100644
> index 0000000..ff49e0a
> --- /dev/null
> +++ b/spi_pack.c
> @@ -0,0 +1,1506 @@

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
