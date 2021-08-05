Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036173E15D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 15:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241161AbhHENix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 09:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbhHENiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 09:38:52 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2EC4C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 06:38:37 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j2so6577195wrx.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 06:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=28Fc+tiebK20f07l73mzXr4mJV/RBZE3cuZaLE2iCIo=;
        b=O60QdmWm8KUkD88SfntVrPL0nOjsjUSDj4WJSCkRZeTXIy2TLHgqgv0INdsINDePiV
         3Q63aGB3gMnneA3wfOZ61JLUGs38vFuFBa11RPKCNmwbbUCXQRH1b64Ac49bgrkHtpcF
         oJbmH2r5JhwrrwHp3+arTwPeORXdpQnPIwfw6fYNyBAQx4hC6RDMcvwY3dZHDEQqnZ75
         tnIWoImn7XxQsJfUukJ8+ntZq6gt1cvzCBXWJxRQYt5t2YWmd8NSOvPRzTYFIx5TdwyL
         r/I0Qx/8ak81ONEyom1ZYCgFznhodCs8h8pD40aMlPmmuLHPc2LHGy676bE8IY2sqDmn
         WRvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=28Fc+tiebK20f07l73mzXr4mJV/RBZE3cuZaLE2iCIo=;
        b=m9HIgvcqW4JwYgJetmXdSEtc28q1HnyoAaExNgmngwqY999LPTnODOzJ7fG6Okp9im
         18TGTK7vWCJ8mkTtfbI49gkhrAmR4rqXf/xStLU9Zp7dKRMGArJ4yQzPnyhnv4TWzqDc
         BhxJLmHblG1lDkCBNRVylUx6+c6Wt7iMiJXZfmc5dolgeei9G8188Mkcz0+r0CWRb7mb
         /JVALtU4fcEoSaNuwFo8q3AOhGbFdJGzLatAmTiFbfLNBC4cJ24K3gFKCeHRS1troF81
         5LN6PYYl8tMrvlYkpfFm1wTrcwjDV+FyuDEy5u1M6OHi+hyiV1XtjwakmaiznbckXGsZ
         KTsQ==
X-Gm-Message-State: AOAM533+VNq9X3u6Gl0LfDrkI7aP265PhH5OQOxdgSseLSmGXwPryJmb
        JhWrxVn38VSnY9gg7FhQF4Ysrw==
X-Google-Smtp-Source: ABdhPJxSzYYYNinzFDsb/3zZQ9t8NxDNBeUR3nJ4nXaUjskEtPLU40LDzwsB8cTjj+o+R63FU61AGg==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr5479766wrq.204.1628170716515;
        Thu, 05 Aug 2021 06:38:36 -0700 (PDT)
Received: from google.com ([109.180.115.228])
        by smtp.gmail.com with ESMTPSA id x18sm5550356wmc.17.2021.08.05.06.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 06:38:36 -0700 (PDT)
Date:   Thu, 5 Aug 2021 14:38:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/7] mfd: tqmx86: fix typo in "platform"
Message-ID: <YQvp2rmUlLpAdv9a@google.com>
References: <cover.1626429286.git.matthias.schiffer@ew.tq-group.com>
 <9f816abe843b0ccac1cef2be7e78359a22b22073.1626429286.git.matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f816abe843b0ccac1cef2be7e78359a22b22073.1626429286.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021, Matthias Schiffer wrote:

> Rename variable from "ocores_platfom_data" to "ocores_platform_data".
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> ---
> 
> v2: new patch
> v3: new patch

Heh?

>  drivers/mfd/tqmx86.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
