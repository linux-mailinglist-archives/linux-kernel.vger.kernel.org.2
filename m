Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8B35FD31
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 23:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbhDNVUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 17:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbhDNVTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 17:19:42 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E50C06138D
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:19:20 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id r9so33574818ejj.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 14:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Lpc6RYLWLDEpwLOi/hV46x6VxBnwTNow/+x2BqXaIi0=;
        b=KCkADvu+U/VtADJMTHsn6p3YX696ldK3wIux/PsGDVNiLSvvNK+GVr4kVrLyuDr4E6
         /Tlbu6T2xilWNUHwgDmNeiBY4SiCKt3vz2pL6P7KF+/zBqDBXyOrLD2XgVu+XFQXsBsZ
         +Vq00aXLVJ79n1rpyTlcjoUZVUm+0qBwWL8ruvPfQ9LdnsU5hGSoiA7yBOs3UwV1Fn2a
         Pm9zo+nS8j0xDE8nY3sbdTC1YGOVew4gJO9td/YpF2uLO8orawhLI1kFHhk90umnerht
         uz1/zVBTXCLw5A04psJKetRSR2terRyQSR4PD9+qN+bEFpmAvG5CMvTnbZNPp0m3Fzil
         KvYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Lpc6RYLWLDEpwLOi/hV46x6VxBnwTNow/+x2BqXaIi0=;
        b=DPAx+k22tr0OdqAlnjxkkJSQK8GKKG9/URlK1kbroyAAyL1ZIaxYFiuD/wgaKwwe4C
         kF7vYFGl4SZ0aVGKZoUW9tBBYebmH0mE65xLofIB5Df0JdZe/GKnM6/5iBu+FwEzIY+b
         WyVckDMrzAgmCyC2k0V/OHmUtiblZ82VAtyJ3zUdGT1rF1M3Zg2GlMHNZS0WdaFcIg4Y
         r1y92WuG2NadnpOciw1+A5QH8CQzGxKHCWB+TxI+zIJiL0Wz2syRAYelyo3Ttx0myvYD
         uxzjrdhwN/ACkSrYVlaBbj5vw3faMdJH2Z8HPQtlBGPQZNpdtKoPY1mNzFnGlFm/iT/k
         jVrw==
X-Gm-Message-State: AOAM5311XnTyCm+tpczlKGM4lrChtdBZWEpDUQl3SL2m9LDOYooBY4bR
        oazUv4xtyw+pNORBGmvVQ6b0Pb3u0HlUuQ==
X-Google-Smtp-Source: ABdhPJwIg0OtmR6Xln9tsg2C1Q81TAVOcGw3LZ40p0AmzGLangViKlrU1nTARl6n/KzDOA+/UgW5lw==
X-Received: by 2002:a17:906:fb90:: with SMTP id lr16mr66148ejb.173.1618435158908;
        Wed, 14 Apr 2021 14:19:18 -0700 (PDT)
Received: from dell ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id e20sm412752ejy.66.2021.04.14.14.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 14:19:18 -0700 (PDT)
Date:   Wed, 14 Apr 2021 22:19:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 1/1] mfd: intel_quark_i2c_gpio: Don't play dirty trick
 with const
Message-ID: <20210414211916.GS4869@dell>
References: <20210326124842.2437-1-andriy.shevchenko@linux.intel.com>
 <20210326145129.GB2916463@dell>
 <20210414171319.GQ4869@dell>
 <YHcr144krHDay72g@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YHcr144krHDay72g@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Apr 2021, Andy Shevchenko wrote:

> On Wed, Apr 14, 2021 at 06:13:19PM +0100, Lee Jones wrote:
> > On Fri, 26 Mar 2021, Lee Jones wrote:
> > 
> > > On Fri, 26 Mar 2021, Andy Shevchenko wrote:
> > > 
> > > > As Linus rightfully noticed, the driver plays dirty trick with const,
> > > > i.e. it assigns a place holder data structure to the const field
> > > > in the MFD cell and then drops the const by explicit casting. This is
> > > > not how it should be.
> > > > 
> > > > Assign local pointers of the cell and resource to the respective
> > > > non-const place holders in the intel_quark_i2c_setup() and
> > > > intel_quark_gpio_setup().
> > > > 
> > > > Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > > v2: eliminated bar parameter (Lee)
> > > >  drivers/mfd/intel_quark_i2c_gpio.c | 26 ++++++++++++--------------
> > > >  1 file changed, 12 insertions(+), 14 deletions(-)
> > > 
> > > Neat.
> > > 
> > > Applied, thanks.
> > 
> > Am I still missing patches from you Andy?
> 
> Patches for fixes should be applied to for-next as well. I don't know why with
> my patches it diverged.
> 
> I have already commented on this when kbuild bot complained.
> 
> So,
> 
> 	git checkout for-mfd-next
> 	git merge for-mfd-fixes
> 
> or equivalent (cherry-pick) will fix that.

Ah, it's in -rc5.  Very good.  Thanks for the explanation.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
