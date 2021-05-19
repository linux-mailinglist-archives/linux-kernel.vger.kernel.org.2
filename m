Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6AA2388C1F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 12:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237342AbhESKzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 06:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhESKzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 06:55:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A2CC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:53:59 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z85-20020a1c7e580000b029017a76f3afbaso536293wmc.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 03:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=iyF4znB+NAGNxEUQPDaSTCldhTG9jFD5gCynx1rwurI=;
        b=JeorSU0JhtvTZKYvz3B2KPhFNwWxY0rcn2Vz/IXn5dYs6RASxj6XkY3e+WhahRcj5/
         ZRYIAj3k3j55FMzuuuWCiTtLiEW25JNtplBBAAsL/A0vZhlzNygIeGM4R1YaCpE/YqPW
         XEozO7+pWGBM/EcWvyanpk/IbBnReLPouQebCzyKe9zdFVQxQvztwbwHMFQzqtJVN2OG
         sZJnaBFVO3GCCNl5wgNNQ2XfryQsA9apX64ftB//ickaOTMq9qSLnv3RpjrVLp4wUmRS
         su/bbrhQk1MtXoQ/d6gGAOvnIHvVvACSMcxaXVxJv0DGDmPCY0HGmvlUzdt63X3xe2mI
         CVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=iyF4znB+NAGNxEUQPDaSTCldhTG9jFD5gCynx1rwurI=;
        b=B5Y/dsq3L3VpFCFecwV3mrEPq3PfXsKSLfAvlLjQLBO9UsjJraSa6l/7XCkmauBiZB
         QMLz0HU42kNecqdPQeQNuTuyEzIQLKI1OuWvZBtNPYdA93tZkoITfnzZwMgRJFrTMPsY
         Ysoj3/0yPnki0tupZ4iDlTs0FosmK6SohWzlTAlsblmCQU697akLaMK37JGx4YzmQZpe
         8kiEzib6Bav7blnctAxGWFTyKb23i6Tc6LzhptIduoJwUFvVY6M5KVK5eIiMqaR4kmky
         46e9OboZBJsfY3DJ04nfdDmDHCII4ivldUYlQu3LcjnSVvwNa2e+IZ1zgRL8lpDSnI0Z
         pD7Q==
X-Gm-Message-State: AOAM532W01WTqrp8E0nOmpFea5gVQN0DohHNFC9FfY/mCvRt3uODVcl8
        SNBg/veZoyHbAzsw4DJHAibx/Q==
X-Google-Smtp-Source: ABdhPJyhFF19KAh1rD2dS+lhyx35F9ujaYw6i7jutv5u+cgqL3po1ZR25U0g++6X2/gwdMAFeEgJSA==
X-Received: by 2002:a1c:a949:: with SMTP id s70mr10611020wme.30.1621421637620;
        Wed, 19 May 2021 03:53:57 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id u126sm6585249wmb.9.2021.05.19.03.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 03:53:57 -0700 (PDT)
Date:   Wed, 19 May 2021 11:53:55 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] mfd: mt6397: add mt6358 register definitions for
 power key
Message-ID: <20210519105355.GA2403908@dell>
References: <20210506094116.638527-1-mkorpershoek@baylibre.com>
 <20210506094116.638527-2-mkorpershoek@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210506094116.638527-2-mkorpershoek@baylibre.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 May 2021, Mattijs Korpershoek wrote:

> To support power/home key detection, add definitions for
> two more MT6358 PMIC registers:
> 
> - TOPSTATUS: homekey and powerkey debounce status
> - TOP_RST_MISC: controls homekey,powerkey long press reset time
> 
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> ---
>  include/linux/mfd/mt6358/registers.h | 2 ++
>  1 file changed, 2 insertions(+)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
