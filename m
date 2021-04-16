Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA68B361A29
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 09:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbhDPG6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 02:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbhDPG54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 02:57:56 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50A8C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 23:57:30 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so14092589pjv.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 23:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=N3Oc03Y3DYt6uoUli6Ypl8t/ni03h69oGIKcq/LQC7c=;
        b=H8ZiBgWdAp4139XWvEw0IB3zAbsM+AkX7HEx2Y8BlDcM/z839QeZili9xXfOoksvPA
         po0divY66J+faBefaUAljkQGDlpj955giXYEcfzUZ54nRpBaSQq2C37ztIQ/FV6F1gQI
         LWf+7mmxDLLZb4p0oPauEDNJAYpme4fpL1bQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=N3Oc03Y3DYt6uoUli6Ypl8t/ni03h69oGIKcq/LQC7c=;
        b=KiNyq6RM5+hhz6X4oJStkcJAY15pWmv6tzRWvA2BMvql5hKGurtsWNKh6MniYHWFi5
         uxRnhpccT3fO9tAMWC1ak9B6KSgq7Uh3U+uLZm7V7eTrSq4grdZhMDr2IpaEBvWmJaIa
         C4/xLrK2DHC2XHhDXpDevJr4enbXU1n6nWIUKhv8PJm0kP7K3KjW1MO58LLtqP6oA/Jl
         Y0DTh23zp2G+ZCapy2UO4+mCwEnYrwKuukDGz84Jl0NzTbNo0eKtbo7i4Kpf02slhAeI
         8emHNXDVYunFixStF//P6EJp55OwS6BtDc46lRVMN2Vjfd2LCXi9G+kL+kDNJasPvhp+
         1bag==
X-Gm-Message-State: AOAM533ZH1SmtriOd5JNFovl7v2niQqoiMsnV0+5X17Yw/nkMqLxsPUd
        IEL4HEghmqB23vX/eEnehaLvww==
X-Google-Smtp-Source: ABdhPJyTBWp8Om5xCwqE0gPoM75LEgX1nYrbr4Q+sDn0X0maaa1CY03ksnEhhjR3hHPgcpnCCswaZw==
X-Received: by 2002:a17:903:2285:b029:eb:d7b:7687 with SMTP id b5-20020a1709032285b02900eb0d7b7687mr7895245plh.82.1618556250519;
        Thu, 15 Apr 2021 23:57:30 -0700 (PDT)
Received: from localhost (2001-44b8-111e-5c00-09c3-a49e-2955-78c6.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:9c3:a49e:2955:78c6])
        by smtp.gmail.com with ESMTPSA id i9sm4518671pji.41.2021.04.15.23.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 23:57:30 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, qiang.zhao@nxp.com
Cc:     leoyang.li@nxp.com, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: Re: [PATCH] soc: fsl: qe: remove unused function
In-Reply-To: <1618475663-100748-1-git-send-email-jiapeng.chong@linux.alibaba.com>
References: <1618475663-100748-1-git-send-email-jiapeng.chong@linux.alibaba.com>
Date:   Fri, 16 Apr 2021 16:57:27 +1000
Message-ID: <87blaeg1ig.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiapeng,

> Fix the following clang warning:
>
> drivers/soc/fsl/qe/qe_ic.c:234:29: warning: unused function
> 'qe_ic_from_irq' [-Wunused-function].
>
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/soc/fsl/qe/qe_ic.c | 5 -----
>  1 file changed, 5 deletions(-)
>
> diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
> index 0390af9..b573712 100644
> --- a/drivers/soc/fsl/qe/qe_ic.c
> +++ b/drivers/soc/fsl/qe/qe_ic.c
> @@ -231,11 +231,6 @@ static inline void qe_ic_write(__be32  __iomem *base, unsigned int reg,
>  	qe_iowrite32be(value, base + (reg >> 2));
>  }
>  
> -static inline struct qe_ic *qe_ic_from_irq(unsigned int virq)
> -{
> -	return irq_get_chip_data(virq);
> -}

This seems good to me.

 * We know that this function can't be called directly from outside the
  file, because it is static.

 * The function address isn't used as a function pointer anywhere, so
   that means it can't be called from outside the file that way (also
   it's inline, which would make using a function pointer unwise!)

 * There's no obvious macros in that file that might construct the name
   of the function in a way that is hidden from grep.

All in all, I am fairly confident that the function is indeed not used.

Reviewed-by: Daniel Axtens <dja@axtens.net>

Kind regards,
Daniel

> -
>  static inline struct qe_ic *qe_ic_from_irq_data(struct irq_data *d)
>  {
>  	return irq_data_get_irq_chip_data(d);
> -- 
> 1.8.3.1
