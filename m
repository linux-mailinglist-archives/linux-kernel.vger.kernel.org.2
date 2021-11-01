Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A056B441B04
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 13:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232392AbhKAMQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 08:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbhKAMQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 08:16:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9823BC061714
        for <linux-kernel@vger.kernel.org>; Mon,  1 Nov 2021 05:13:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d3so27828540wrh.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Nov 2021 05:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pz3A5N3I8y1fwIAFwuqkVwsnZQS1wS7neAtkz1GBL4A=;
        b=Gl6KBHBzdzXWw/gNX0hXmokxv66bIEbaEsr0k7CyVEJUBhcxkc47cDhG5xwRwwddPV
         k+hk3CpNAdRqJJSGTw25TQzVH2aVa1TDFQbJUUB78FQ0tZrX4rCQFtqBb5ZFF8MKjDaz
         ZlI4NkWVSal7xfE0K8kGeON9SuIHEzOVCvkwUyA+60y2EGBQJVxamnYOMPYeR+cvcdXd
         SnKL0AWgrQ1nBrRA1b2cjookP6XwqQd3FPKaNvnxcFP20RD2yCLz4fiRgC3bRjLXPo3J
         JhltuGUpEcbsZSpAkrgsxO6a16htSLraYTJ/ndRWFzqlQ8YFJ25U3Ek10Ph2/qTwhB2H
         DgVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pz3A5N3I8y1fwIAFwuqkVwsnZQS1wS7neAtkz1GBL4A=;
        b=cTpMfLclqesXoX4jTd3quwTTTM3Kazeb/HKp7UJGnvBx/oRzFcnFu5l8UGdNrUE1XY
         VXKjJGOUTeRwRKq7yM8RW0upMPlxElq5FYI5OX0BCDwA8rxx5zKX1no0jw9eNP8MT++X
         o/Yxieu/ML6cuHJp0MPHhdEpyXKsaT/u0sirmY1b/PXNWxnp7IkIHOAv6USRUGguOb2o
         JhL1w9f/wF3W6DCVs3EnSO83NPrvb+JiWrpfR5wRUMphyQcMb/ojZLlgJA7UseDknOVM
         wZpfQbJYF0PYuMfgOFAr0V79QRZjTNCcPrU2w4DBco2hStqFiappV8pFRTN0To2THmGM
         BmaQ==
X-Gm-Message-State: AOAM532ZLgzsFErePupEUA4fwfeKVPeV9NSnrWtj7JyJ+TuiNOGsNWb2
        ZGFAzp5ruQii7AdBcNJ12sa43w==
X-Google-Smtp-Source: ABdhPJxVmUs0wVK3uKMWzroM9WV0UXXMqlPS6Ijhq9FGK/6yInjHF9WXv94m0AplS0MrrDsfnC0Dhg==
X-Received: by 2002:a5d:5504:: with SMTP id b4mr27927061wrv.307.1635768806159;
        Mon, 01 Nov 2021 05:13:26 -0700 (PDT)
Received: from google.com ([95.148.6.174])
        by smtp.gmail.com with ESMTPSA id s13sm16282744wmc.47.2021.11.01.05.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 05:13:25 -0700 (PDT)
Date:   Mon, 1 Nov 2021 12:13:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        marcel.ziswiler@toradex.com,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Oleksandr Suvorov <oleksandr.suvorov@foundries.io>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: stmpe: Support disabling sub-functions
Message-ID: <YX/Z47ztw8d4uMuQ@google.com>
References: <20211027082155.206449-1-francesco.dolcini@toradex.com>
 <20211101094844.GA4549@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211101094844.GA4549@francesco-nb.int.toradex.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 01 Nov 2021, Francesco Dolcini wrote:

> On Wed, Oct 27, 2021 at 10:21:55AM +0200, Francesco Dolcini wrote:
> > From: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > 
> > Add support of sub-functions disabling. It allows one to define
> > an stmpe sub-function device in devicetree, but keep it disabled.
> > 
> > Signed-off-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
> > Cc: Oleksandr Suvorov <oleksandr.suvorov@foundries.io>
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Hello Lee,
> any chance you could take this one line patch for this merge window?

For a patch sent 0.5 weeks before the merge-window?  Nope. :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
