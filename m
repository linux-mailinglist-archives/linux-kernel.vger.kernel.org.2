Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A063C333B3D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 12:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbhCJLSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 06:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCJLR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 06:17:59 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361A7C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 03:17:59 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e10so22844884wro.12
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 03:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8/BvaC/nK4OARL6liXjkIyGeKizu5NW5s37p+jzN3rQ=;
        b=Psywx4DhVt3ugx3PIxZeB43//KWnVK4bTpb2dRxGAtIDzQ9t/VwoqLeTXFxEuYSBpX
         CMpuokQ6B+5jaKqmQP0KA4n9ha86S9L55WvCW3bmITc56n2AmeOV+/Z4rhSMpwRBwSEt
         BTspTOBFMnm6ftya42im4dgEPRLD9KzI83DFx5A0y7gJC6VBeGZgfvBJjBy27oDVk4mz
         PfKzL72xoDzNzYkkqn55uMjaFBw+jJbIZ8NlM59TxZBQjq18is1nRhjXUGCfFuonFcp7
         UYCmvR4PeEIxdVeS7RyasXbzymv+eRKk5KAaI4fNR0iEYuzU+tPZih/J5b9KKUJQx+Qo
         Gipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8/BvaC/nK4OARL6liXjkIyGeKizu5NW5s37p+jzN3rQ=;
        b=sQbauFsqX7mo1DuPHjiBLE8LMBFfWQRWN/K1YYRlWMMBCDedqWV2ASUr6ShsiwyP/v
         fGUAn5jSDh6fmpkz1s20chq+PwUmIyGbot6XAXbtAo/Lg+ntmJhDQLkpPDVc2/g4ejWb
         qpe0UdOiVWVpZsXAS5RIAPqnRtRZp++FD3rR3a3AX/H1rKB2aANuD3IsPFk+zGuvJmIC
         84wsfIRPeBKcFH5FyxdZu57mJHVCzEBOkLqZVt1ZHhWOSN0RlJdMuQHOQVi1PHNajWbg
         718h17MqU2C6CEuQWA6N4Osu4MHpXH/HNPIg4RmX0lw8apy60WXzx2x5vgyI1P6v/xbb
         rpBw==
X-Gm-Message-State: AOAM533kKIn5LUyeJyNQTKXE4/HWEz0lRPY7xDYGDmUfbLcXqSkoTMzu
        u5wdrceM9ope0+Ga8Cj9B5rqyw==
X-Google-Smtp-Source: ABdhPJx3IYKM3QBCdZT4QUUshLK1DxO4Zo6U2/nM97niWViFKQGFICLI7dFD9eafmhr+BAl2HPBtEA==
X-Received: by 2002:adf:ed12:: with SMTP id a18mr3016460wro.249.1615375077845;
        Wed, 10 Mar 2021 03:17:57 -0800 (PST)
Received: from dell ([91.110.221.204])
        by smtp.gmail.com with ESMTPSA id h25sm3711077wml.32.2021.03.10.03.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 03:17:57 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:17:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     linux-power <linux-power@fi.rohmeurope.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>
Subject: Re: [PATCH v3 06/15] mfd: Add ROHM BD71815 ID
Message-ID: <20210310111755.GN701493@dell>
References: <cover.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
 <be0e8cd06ed75e799c942e5076ee7b56ad658467.1615198094.git.matti.vaittinen@fi.rohmeurope.com>
 <20210310103639.GG701493@dell>
 <a631bbc3dd3bd0f02693d1c35f9a14dbaec67cc3.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a631bbc3dd3bd0f02693d1c35f9a14dbaec67cc3.camel@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Mar 2021, Vaittinen, Matti wrote:

> Hello Lee,
> 
> On Wed, 2021-03-10 at 10:36 +0000, Lee Jones wrote:
> > On Mon, 08 Mar 2021, Matti Vaittinen wrote:
> > 
> > > Add chip ID for ROHM BD71815 and PMIC so that drivers can identify
> > > this IC.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  include/linux/mfd/rohm-generic.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/mfd/rohm-generic.h
> > > b/include/linux/mfd/rohm-generic.h
> > > index 66f673c35303..e5392bcbc098 100644
> > > --- a/include/linux/mfd/rohm-generic.h
> > > +++ b/include/linux/mfd/rohm-generic.h
> > > @@ -14,6 +14,7 @@ enum rohm_chip_type {
> > >  	ROHM_CHIP_TYPE_BD71828,
> > >  	ROHM_CHIP_TYPE_BD9571,
> > >  	ROHM_CHIP_TYPE_BD9574,
> > > +	ROHM_CHIP_TYPE_BD71815,
> > 
> > Is there a technical reason why these can't be re-ordered?
> 
> No, I don't think so.
> 
> BTW. there will probably be a (trivial) conflict here as both this
> series and the BD9576/BD9573 series add an ID here. Let me guess, you'd

That's fine.  I will resolve that manually.

> like to see them sorted?

Wouldn't that be nice? :)

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
