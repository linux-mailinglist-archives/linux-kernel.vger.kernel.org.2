Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18118436106
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbhJUMGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbhJUMGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:06:40 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF16C061749
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:04:24 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id k7so628938wrd.13
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 05:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ALaF5bcRuLL8d8keCANGTQfz6z7fdsJXQrN1DNjYf74=;
        b=a0WzIsBTTCoMPZrFWgDMsvwuRE2bVLyaswCIdbcszH9T/7FFZeeEXemVYZy/bl6g2i
         rPskyWTQebZ1HVLFYS5K0KsnXweIFiYHFgOsMBrYJYGG6H+/LbEmKh6JAt3mY18OwlCj
         TDOsU9A/oYMUGxx3+LEMwPkMg4tYmd0GoxPfhnmTI/0BkRI7XmyKvPAfcJ88AkRJACSe
         ZfK4Sq4chU6g5I3RArx8dY6TNcnIBpbcU8uNu+CQ1NT9p7V634xDwQNOo9pR0IpGtIwq
         oyRcYbKl35GR0dhZ1ALA3+n3qob0lkWOXf43tWfNoqx4BP/C1o+YXa9pHJfpk9zqtnp0
         B1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ALaF5bcRuLL8d8keCANGTQfz6z7fdsJXQrN1DNjYf74=;
        b=q1S55E3QOMH/VrzvfztjGA4m5D4rCbA0MyJ18BnElIFD5Q8Ky5mIJWYNj4lcmZ3GyX
         cPaR5wUctUGedQkj5OiT4iyO3sfStlizbxceBZ52f7D5wbPT6E/Hl+gFSrvwAV35+TyZ
         GFp/Bd4NJF0Pww2fiCq9YdABoC6v18iZbYreHAfalkT5lQXPpnC1oHY++84LJ0Vz2QyL
         /7Pis/mw1340zipUA/ou5KdnnT1Bc8iVO5GHKJ6WCgvTl5TIH9phTQ9mungI94u4tYdT
         LH+1E4FvpgMdJG2TBsd6wThIvWLsTQO6WBu9XOzcjceka5cJK1oco+W8PQLb3kGO8cPY
         ftOQ==
X-Gm-Message-State: AOAM530NJnC6BURCTYkLPScOpCodUnlcKLdptWQnbcUTQBUJJb/xVX61
        HaMx9LgFW6rw5Ldocyw0iFZQLQ==
X-Google-Smtp-Source: ABdhPJyBZahsnpxwYvLV/qR3VP4yIiJian3RTLdz5eQQ0EYiT9CXl2QlXtPceZtwyk65zpgvnq9kng==
X-Received: by 2002:adf:e292:: with SMTP id v18mr6487110wri.369.1634817862441;
        Thu, 21 Oct 2021 05:04:22 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id p18sm5370734wmq.4.2021.10.21.05.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 05:04:22 -0700 (PDT)
Date:   Thu, 21 Oct 2021 13:04:20 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>
Cc:     linux-kernel@vger.kernel.org, Jack Andersen <jackoalan@gmail.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH] mfd: dln2: Add cell for initializing DLN2 ADC
Message-ID: <YXFXRE1Pwl7U1a7g@google.com>
References: <20211018112541.25466-1-noralf@tronnes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211018112541.25466-1-noralf@tronnes.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2021, Noralf Trønnes wrote:

> From: Jack Andersen <jackoalan@gmail.com>
> 
> This patch extends the DLN2 driver; adding cell for adc_dln2 module.
> 
> The original patch[1] fell through the cracks when the driver was added
> so ADC has never actually been usable. That patch did not have ACPI
> support which was added in v5.9, so the oldest supported version this
> current patch can be backported to is 5.10.
> 
> [1] https://www.spinics.net/lists/linux-iio/msg33975.html
> 
> Cc: <stable@vger.kernel.org> # 5.10+
> Signed-off-by: Jack Andersen <jackoalan@gmail.com>
> Signed-off-by: Noralf Trønnes <noralf@tronnes.org>
> ---
>  drivers/mfd/dln2.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
