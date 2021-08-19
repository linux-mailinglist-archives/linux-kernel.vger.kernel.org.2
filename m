Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D033F1035
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 04:08:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbhHSCJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 22:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhHSCJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 22:09:01 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEC7C061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:08:25 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b15so9248875ejg.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 19:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykAJKci/Ufpr9vdJPp2MKR5L112cjDKYK64qjGt7RFM=;
        b=QpmgD5+6dl44V7U+a2cgGKaBiufDL2vuOuEZMspqZ2hNP4fc8LPaYjs88srSM8SmRW
         01lAF4RCAf1SWOTf7SFGtUNuRi/lImrIkiyeG8ksexESiy/hmg4vehaJpfQnCM3CxFGc
         fAUQ2KVHSLXTTDXJjJz9whLBHw3ADjV6ZD7myny668cFA1HpAkYplUTlw9ZORYq0T4I/
         w7xKJdXTRI6GbaOjX1+my+UKnq8J1/vJYcIJv4GOxqVr3ILjB3waFtbn+dpYgWLJSnZC
         AZYlOCVVSNJaeuSifMFQIJ2FOlR2rmiiuQ/3y2AeUXazk+nqBXEsGR97eQff3V12ELtX
         1ZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykAJKci/Ufpr9vdJPp2MKR5L112cjDKYK64qjGt7RFM=;
        b=I90IVtxV0m1Lw5iMciDLy8Py1Id4qBNnz64zhJBy1md6pquSK324oDwpP8aQiiPgsy
         6DRE2BUFJW/NzXKPFYFj74xKMJCx+JmbNqonBd++0ETg11nluter1fzHOD9FfprkX1bk
         s/yGmad1d/CtcA0jCxxVsr2Rs2AnFPzs+plWRlaShpepFHc01jnQ+qFyJDbwf0Uj+3C+
         8OTXHbG3jCegDyKWxVXK7RcorE4jXz5Qd3OGc0vaPCpCL5dEGZG2R41vkYF2o9E4hQ2c
         ET9IR5rXI2C/M+2QEp6hbvKS01nN3RYtUfFtkLoErTQeKHulnHfBva1arCuWF1zdi8al
         jxbw==
X-Gm-Message-State: AOAM533bvi6fbR8oowLpPhYQL+UVRfpFrrnfzGMW4X4jzldlreRwNKO7
        Yp0uz7hIMN5FTPZJFJ9EMRQ=
X-Google-Smtp-Source: ABdhPJxxMPQ+Guy8yPOnGxOUTKb+QAbUFpCqFVriswiJC31+367k7CtB1FJ7Hs3s5CgrWYqtFc/9Ow==
X-Received: by 2002:a17:906:5045:: with SMTP id e5mr13212652ejk.239.1629338904218;
        Wed, 18 Aug 2021 19:08:24 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id b5sm584925ejq.56.2021.08.18.19.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 19:08:23 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, Phillip Potter <phil@philpotter.co.uk>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        martin@kaiser.cx, straube.linux@gmail.com,
        Larry.Finger@lwfinger.net
Subject: Re: [PATCH 5/6] staging: r8188eu: remove function rtw_hal_free_xmit_priv
Date:   Thu, 19 Aug 2021 04:08:22 +0200
Message-ID: <3499069.ykxA73u1ES@localhost.localdomain>
In-Reply-To: <20210818234253.208271-6-phil@philpotter.co.uk>
References: <20210818234253.208271-1-phil@philpotter.co.uk> <20210818234253.208271-6-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, August 19, 2021 1:42:52 AM CEST Phillip Potter wrote:
> Remove function rtw_hal_free_xmit_priv in hal/hal_intf.c and its
> declaration in include/hal_intf.h, as well as the single call line in
> core/rtw_xmit.c. This function now essentially checks a function
> pointer which will always be NULL (due to previous patches) and
> therefore will never be called.
> 
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c    | 2 --
>  drivers/staging/r8188eu/hal/hal_intf.c     | 6 ------
>  drivers/staging/r8188eu/include/hal_intf.h | 1 -
>  3 files changed, 9 deletions(-)

It looks good. 

Built with "make C=2 -j8 drivers/staging/r8188eu/ W=1"
on x86-64, it does not introduce errors or new warnings, so...

Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio



