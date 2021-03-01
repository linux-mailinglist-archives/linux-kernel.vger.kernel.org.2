Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DEC3327C02
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 11:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234164AbhCAKZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 05:25:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbhCAKXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 05:23:08 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129EFC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 02:22:00 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id a18so7295209wrc.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 02:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fO30ApwIwTZ6ViBN1Ge+IoLrpzbpt+XR3EbBXQz0Ao4=;
        b=OCOdfFrla8ehIgwoRPFmxKWVA5obG0UC2lRwXNbMWzvuKfpxOkp5Bro5tWT0cE/w9w
         x+bA+Czlt57JU6a42SkfptvC3JuGPA6StIHjWCY+RTvYQTW026gTUD5O4rbJHxolcIvX
         6oZ09xRd0HxZxSSov7dwBlVVhAQExMpyZNo1z/MlMXkzP1CodP7I6cY+mJeBwcH/Aw89
         6BG7KC7nt66322RaxL+SjLPIeBY8BWEPKjxGKwxkSugDprrUBSDKLLls5QlL9n84JSga
         6PvlPLDGTxOh21g88Zkz772Y4umW317CuFDEnDR9obAYTK2Mcgbf9/9ACljkOOJc9MRf
         iXMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fO30ApwIwTZ6ViBN1Ge+IoLrpzbpt+XR3EbBXQz0Ao4=;
        b=nuEDTAv5vEjDQiIOt8oo8pCvnqwZt/fXpXwuSZZQCXmSLsJ1jJdy6gf+1hgGpvqujq
         1J9tk3TUzpaqrZRmKiZP5A93mYeEmjUuH/A1blZfwQOaXAXR3ZOVE5jxQ730Ai+3rui6
         HVg+vB+1RJrp7ClDXXnO79SNx+O1aTw+LA+EojadaRLG/g/uhKN98q9/QR6iLbs/fyAn
         xJRbepgOyrVspLLktD2ANA8PqCnEtuq6smLBrN20bt9I9YW94S6bNHudKYr+FOKfhFU0
         n9UBq0/7UeT9qxpxYGzajjn0qRcgganyU3ACYidfotVxTSbPkxDNoAakQnNPLmA/Qq4R
         a14w==
X-Gm-Message-State: AOAM530rSI4GINhrXIs24jZAdCwnYMhazLlY01mXhBzd7colUa8CfdaL
        N9Y2c9zckE0DUpqTIsxphva1SA==
X-Google-Smtp-Source: ABdhPJxAXiZUsHcR0Rc2xEpcKrMkbJ4gJn1n7JbYEm1p5PO/WxOTQnHJpHjB0WesA4oRThRvN58PLw==
X-Received: by 2002:adf:d217:: with SMTP id j23mr2045527wrh.113.1614594118833;
        Mon, 01 Mar 2021 02:21:58 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id m3sm7999205wmc.48.2021.03.01.02.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 02:21:58 -0800 (PST)
Date:   Mon, 1 Mar 2021 10:21:56 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Fei Shao <fshao@chromium.org>,
        Eddie Huang <eddie.huang@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Yuchen Huang <yuchen.huang@mediatek.com>,
        Ran Bi <ran.bi@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, srv_heupstream@mediatek.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH RESEND v5 7/8] regulator: mt6359: Add support for MT6359P
 regulator
Message-ID: <20210301102156.GJ641347@dell>
References: <1611913781-23460-1-git-send-email-hsin-hsiung.wang@mediatek.com>
 <1611913781-23460-8-git-send-email-hsin-hsiung.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1611913781-23460-8-git-send-email-hsin-hsiung.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Jan 2021, Hsin-Hsiung Wang wrote:

> The MT6359P is a eco version for MT6359 regulator.
> We add support based on MT6359 regulator driver.
> 
> Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
> ---
> changes since v4:
> - add the regulators_node support.
> ---
>  drivers/regulator/mt6359-regulator.c       | 379 ++++++++++++++++++++-

>  include/linux/mfd/mt6359p/registers.h      | 249 ++++++++++++++

Although the code is fine, just be aware that Linus can get grumpy
having 100s and 100s of unused register defines in the kernel.

>  include/linux/regulator/mt6359-regulator.h |   1 +
>  3 files changed, 623 insertions(+), 6 deletions(-)
>  create mode 100644 include/linux/mfd/mt6359p/registers.h

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
