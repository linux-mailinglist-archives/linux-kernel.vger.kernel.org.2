Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6343186A1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Feb 2021 10:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbhBKI4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Feb 2021 03:56:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbhBKIzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Feb 2021 03:55:51 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1407DC061574
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:41:00 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id n10so2843363wmq.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Feb 2021 00:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IdP+qyRSFybI1/gnZTWLtvslIUuKOdoDM3GLkBcoXRI=;
        b=kWQF1mopki4JCJLZ0q88KjoCNZGWx9kCDvs/srjKZESDvNeL1lJ0cJQk6yKZV0+St9
         hAfy8w1RX94b0SpG3RL2cs26QEzBxnBskmQ6l6m2bUM4sQd6OdPb/JVM5q8dbcG7CYrz
         Vn53yJ3gbLqwl0fjAkPN23h2YgCHTDWJD13NdbBBBvb5UnDzdkW2BFMOlaNzmj6IULlP
         LtGXBWKgWUM90oKKD1LfUj95lVFpHPgd+unGOrUkAf8t1VuOHHhai/4/KtRoBILvb7Nw
         fOF0z4RJIlNP/hmFckZmpuc3v0zSAfP6wyslDhQEYiBjPqLuj33f6xf922/txrVo9uUQ
         VOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IdP+qyRSFybI1/gnZTWLtvslIUuKOdoDM3GLkBcoXRI=;
        b=BnITuZ+DB3Q9ePx1NK214fmgtF4LerFH5r8yGjhdmfNu1ejS9RZTbL/1KqfLws61Mt
         zr/YgOMB85fyRj0DGPrbJwin8vZ/BFqLjyJhMcdbXK6D54sk6RCbq0lj07TAHH5qTSdM
         vE4xe10D2PjGGuA+vuIwFUXJ8XAufISx8HlrkCfUiDed6WkRGpY3DdF831KSiCHzX/hK
         kRo0jfMFgc+AEte69g+2D6fvFWqicNkNthp0hNWeKaYolzxmwfsjgbludpVqkKjrUcNp
         aYX1xfqxBPGW2tuULaCqeQkfAb9hmjl3kz/EjL/wiBLztBASgbVBsesA0jR6SUKmDXkk
         D5Wg==
X-Gm-Message-State: AOAM533P7kSi3uAsg2t+QORIO1lcMMZ4bzFzIceKgYckrSC6lrEXg2h8
        cByHXlGr/urEgVkz8zP5XNj1Vg==
X-Google-Smtp-Source: ABdhPJxqlintMbTctXKkk2dBHU/1iC2hNdGDbuAnHCrU5zv2rKdmvfxPBiegzVWMHdRp3seLp2WNww==
X-Received: by 2002:a7b:ca57:: with SMTP id m23mr3885442wml.116.1613032858007;
        Thu, 11 Feb 2021 00:40:58 -0800 (PST)
Received: from dell ([91.110.221.159])
        by smtp.gmail.com with ESMTPSA id g62sm8632458wmf.46.2021.02.11.00.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 00:40:57 -0800 (PST)
Date:   Thu, 11 Feb 2021 08:40:55 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        alsa-devel@alsa-project.org
Subject: Re: [PATCH v4 resend 00/13] MFD/extcon/ASoC: Rework arizona codec
 jack-detect support
Message-ID: <20210211084055.GA4572@dell>
References: <20210204112502.88362-1-hdegoede@redhat.com>
 <ba9c1add-8ac0-766b-4577-1c2769c0e5e6@redhat.com>
 <20210209141420.GE4766@dell>
 <c0b4c612-7f60-5126-4c4d-b7085bd356d0@redhat.com>
 <20210209154511.GC220368@dell>
 <20210210195700.GG4748@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210210195700.GG4748@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Feb 2021, Mark Brown wrote:

> On Tue, Feb 09, 2021 at 03:45:11PM +0000, Lee Jones wrote:
> > On Tue, 09 Feb 2021, Hans de Goede wrote:
> 
> > > The alternative is Mark doing a PR from ASoC to MFD to get 5/5 from the previous set
> > > in MFD first, which seems less then ideal.
> 
> > Well this set isn't likely to go in this cycle anyway, so actually the
> > problem should just go away.  Best to let the first set get sucked
> > into v5.12, then send this one up subsequently for v5.13.
> 
> Yeah, that's probably easiest at this point.  the only other option that
> looks viable would be to add the MFD and extcon parts to the branch you
> already have, me to pull that in and then apply the ASoC bits in ASoC.

I'm not taking any more patches for this cycle anyway.  Best wait.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
