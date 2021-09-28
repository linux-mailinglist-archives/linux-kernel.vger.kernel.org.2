Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8DD41B517
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 19:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbhI1R0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 13:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbhI1R0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 13:26:10 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2B7C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:24:30 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id o59-20020a9d2241000000b0054745f28c69so27794612ota.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 10:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tz7rXxaL4F/0f9c2pv27juc+BGdU7ScDq2tqCmIv38Y=;
        b=tR2pRCj/qKxjNExZrPW1JMusgHTkF217aDaxwmJWEm2fFtDA/r7cVLoE6t7EzHMG+j
         4cnF8eefX32CXwbIWS6Fb2aNitjEQgYmhl/kiZWdzTtTEgr5BzM5bDrNr0xGoQcnHfo4
         ukAyh1JNMGUrNsZ4ZRwG+Cz3NZM+zUpCggoPt4Asg9JC7DVN8QeAGxfMPgjNvvfvWI+o
         VTDg52u12ACCsADmcqS7lLTm4+uCVoHSAG1DP1EAuiZkXe6vAFC8vMFuc33DT81Th2U9
         zWszlzIR4HpkbUqmWejkpNV+2ZUU010wD19zv6P/NL6yj08YpU3BBQ76/wRQfklSWNK4
         xWRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tz7rXxaL4F/0f9c2pv27juc+BGdU7ScDq2tqCmIv38Y=;
        b=ObQJRwj1GQS2c51fkOzzpsz7rdFGJBtT0ZS/10MGGRS75Fov6o+JKY+MU1A5gj7sVI
         AX7J+sTkbGQxZAtppaZSbhTkQBCKoX7/xzda/gBes0tfkhjyZV9fRdZloyIr9PKizRM+
         DjlUGRSxgdrWJW4O7TwEjE61VBve8RGvvjq2rR1uZb9k2ZzHvckRNWVeCgtOt0cTP5Ab
         YQ+/5UsvjgyaKZcH9A6zDW6XoFZNNXdwuXethIT6GGn9hlyJYtY7e5qjolmD6czU9tZT
         tVTvKdmcBwD48gMTRLB3x4KlMJhWNi+tLisoMe08+if9KBvidZpolPtUpYhE8UTMp847
         GWhA==
X-Gm-Message-State: AOAM530g+zy2E2376mBF/ALzACFUaUuBzVInAOgNFwkD2avZcVXBG6Ey
        c601K1X3JXVsUKYwkjetjiv9ag==
X-Google-Smtp-Source: ABdhPJwIoTF2vk7NvGDYXmuN/1D5SS3NUp6rSCUQCZ5HX/Jvkr7HMFjXoFn7PWmdaYmAJBezNd8FNg==
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr5968746oth.80.1632849869862;
        Tue, 28 Sep 2021 10:24:29 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z1sm5225337ooj.25.2021.09.28.10.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 10:24:29 -0700 (PDT)
Date:   Tue, 28 Sep 2021 12:24:27 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Manivannan Sadhasivam <mani@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: combine nameservice into main module
Message-ID: <YVNPy+IAtLiKI19Q@builder.lan>
References: <20210928171156.6353-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928171156.6353-1-luca@z3ntu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28 Sep 12:11 CDT 2021, Luca Weiss wrote:

> Previously with CONFIG_QRTR=m a separate ns.ko would be built which
> wasn't done on purpose and should be included in qrtr.ko.
> 
> Rename qrtr.c to af_qrtr.c so we can build a qrtr.ko with both af_qrtr.c
> and ns.c.
> 

Nice, I don't think we ever intended to end up with "ns.ko" on its own.

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  net/qrtr/Makefile              | 3 ++-
>  net/qrtr/{qrtr.c => af_qrtr.c} | 0
>  2 files changed, 2 insertions(+), 1 deletion(-)
>  rename net/qrtr/{qrtr.c => af_qrtr.c} (100%)
> 
> diff --git a/net/qrtr/Makefile b/net/qrtr/Makefile
> index 1b1411d158a7..8e0605f88a73 100644
> --- a/net/qrtr/Makefile
> +++ b/net/qrtr/Makefile
> @@ -1,5 +1,6 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-$(CONFIG_QRTR) := qrtr.o ns.o
> +obj-$(CONFIG_QRTR) += qrtr.o
> +qrtr-y	:= af_qrtr.o ns.o
>  
>  obj-$(CONFIG_QRTR_SMD) += qrtr-smd.o
>  qrtr-smd-y	:= smd.o
> diff --git a/net/qrtr/qrtr.c b/net/qrtr/af_qrtr.c
> similarity index 100%
> rename from net/qrtr/qrtr.c
> rename to net/qrtr/af_qrtr.c
> -- 
> 2.33.0
> 
