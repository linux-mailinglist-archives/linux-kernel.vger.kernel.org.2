Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56193975CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Jun 2021 16:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234283AbhFAOwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Jun 2021 10:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234043AbhFAOwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jun 2021 10:52:18 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45A4EC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  1 Jun 2021 07:50:35 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c5so3470509wrq.9
        for <linux-kernel@vger.kernel.org>; Tue, 01 Jun 2021 07:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=fiX9yiBNX+zZ1kE/XRKiD14Uy6lLFGjkKYDmuZqizOM=;
        b=n+OPwKb1kAJTjuQvvGIw9YDsHRKdYbDS5xSlDwqoYoirPYSA1nWXwyUauKcJflxAQg
         tKZvQw3CrIcjXjb8Cm/kTvQzCvpq6RPm3JZq2UU3p1CgfrtpvMAmlLk0hSRfPf00+u9C
         CP4Fs1I7n//dlZ5/0Oz8Le1vKn1Tkd/H6zocfxHTKGUYYRv1I2ujSJV66WbDX0mgVOkH
         bBNTJdcjcv2it4bdNRzn/v2ksxuT3XEnmOMxQ1gLrU0oEvy/KoSqtyDjx96GrizGKIb6
         WBVHkkinzAd9/3iMFTBtJbh401blDjk066yo6oc40eE3b2nCE1Z+amWfiXbiDLCa6Oel
         Snvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=fiX9yiBNX+zZ1kE/XRKiD14Uy6lLFGjkKYDmuZqizOM=;
        b=NUaCYEBNWV4CBnIfSEs9rIQ01EtoS/Mas9vs1WCVefXN3IgpPQE2KGy6GanDhI1ZDM
         9mKHbV8Bsu+umffM2aPiLVfQGlvXZsksR0jFVYky+UwEuEYyOgCwivTXhWCRsW63WxB4
         kKo+rqo6GA6hS/ifP5+CMBmpvxVcslQYWg3jYvJMeAG2I6uKVd0KSoutSZSE872Iuis8
         NFmzJgQ89iWBHZwqr6+Sh8HT41NqMzxBKNoWFWru/oLf8rpKoFII21+wTrBl0OtpNsG3
         fuDkINyTT9xLnE6muleY+m6w77sRThpUPqVOHJIyCriCT69r89hImBJz14LtywPpnBKx
         CQEA==
X-Gm-Message-State: AOAM533ski5tIkQpXzdSw9d7BaUKCnKpI1JcKQtr2BMWeQcTghM4zZHr
        CAG0jymDUdfjxOuzF2i4sC9r+g==
X-Google-Smtp-Source: ABdhPJzfsLg/GOaS5q9dH68xf309SiGEIiSBWSqUJbsFz867TbDfwV361wLM3kGNCHrf73lHDtfYyQ==
X-Received: by 2002:a5d:4dd1:: with SMTP id f17mr27680158wru.160.1622559033925;
        Tue, 01 Jun 2021 07:50:33 -0700 (PDT)
Received: from dell ([91.110.221.249])
        by smtp.gmail.com with ESMTPSA id f6sm4125726wru.72.2021.06.01.07.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 07:50:33 -0700 (PDT)
Date:   Tue, 1 Jun 2021 15:50:31 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: [RESEND 1/1] clk: versatile: remove dependency on ARCH_*
Message-ID: <20210601145031.GK543307@dell>
References: <20210520161702.3746174-1-lee.jones@linaro.org>
 <CACRpkdZgpFL4ALGr16hua-uSnM-5SrOZ1KGMkzTEDrZmwh_1=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkdZgpFL4ALGr16hua-uSnM-5SrOZ1KGMkzTEDrZmwh_1=w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2021, Linus Walleij wrote:

> On Thu, May 20, 2021 at 6:17 PM Lee Jones <lee.jones@linaro.org> wrote:
> 
> > From: Peter Collingbourne <pcc@google.com>
> >
> > It is now possible to build a modular kernel for vexpress by
> > not setting CONFIG_ARCH_VEXPRESS=y and instead setting =m on the
> > drivers that it normally implies. This is with the exception of
> > CLK_VEXPRESS_OSC which is currently hidden behind a dependency on
> > one of several ARCH_* variables. Remove that dependency so that
> > CLK_VEXPRESS_OSC may be enabled without it.
> >
> > Signed-off-by: Peter Collingbourne <pcc@google.com>
> > Link: https://linux-review.googlesource.com/id/I435a21e2e5f6187db54f4ef2079b60028ab2ea69
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Still not in -next.

Who will take this please?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
