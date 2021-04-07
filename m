Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4160A35675F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 10:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349758AbhDGI6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 04:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbhDGI6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 04:58:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480E8C0613D8
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 01:49:29 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r22so7345206edq.9
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 01:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r5UsSxaaK+FDwSAXWjuCQvloPacd0EBmWVUVnUcFHrE=;
        b=JxkqP+cayQVT7C52b1NL4UK3Dd9Urenq8MX3dz7m/xVGY67JK3QMWWSrpDxtZdyzil
         T0X6PZQgAWXUPlSvT6jmhekP4VjYD4WNHWbeaoc2E1nojyAUiluDl0IlHmJ9TnTnUUNW
         9qYzbrOd2C2gw+M/bLXct9YZuOxqqnsBnSkMAROUYVgZU2qE6H6MnIhww1B4y3KsOnXX
         qG10e0oNb7wzfHVx3CkT93yfeqRz7uL/R72HeuGmIZ7xxLAogHESVGleBQLJVZ2VVsqp
         NXvh8y/866Q7keWNasIV9SihRNdlsY1McP/mRUvAECiV/wPe4G6/kL9ACuFleq3bLMgQ
         LU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r5UsSxaaK+FDwSAXWjuCQvloPacd0EBmWVUVnUcFHrE=;
        b=S9kEgrHoKiOpNBlXJQkeBWOUAXhoyKeGYbXbNiSfb4CLKpWhZ32MHGrge04spcVhpT
         9DNHF3kuTOLy5VX3p6FVdefA5plajn3zqT/G76txB2xC99iXsaM/kgby/KZWcrvMu0BE
         hbcYRLzHcHrBEpG0Ys2bSxsZmXGZBEDaj8boS/MqvSRjFn2eQoUxG1JJlIe46K1XgI2Y
         qkBBKEcXYik2kBn5GRU/aJ4zQw07x00SAUVhDCntsS02hdsdQEWGLKPjGO79nuipylgx
         MDxM4wIOit6pUMvgPFZ8UP792d/Cz3nxqwWgnqw6gtQIKpX6Z4KSrrXYLVxo4R+6F0R9
         2/4g==
X-Gm-Message-State: AOAM533uSAXefVh+3ln8Oy2BnPDUPLgbNuxrOlLFNTcFAhAAQt3E9B1I
        mS13ILUscSyk4DcyWIEs1Yo=
X-Google-Smtp-Source: ABdhPJzTlUgNDH8eHapV4xSjZLAyuH4rKl1yH/Ww6aXTVgQyi+HCAPg/jcou5nT3HsozxMT4qZx8wg==
X-Received: by 2002:a05:6402:145:: with SMTP id s5mr3019760edu.221.1617785367839;
        Wed, 07 Apr 2021 01:49:27 -0700 (PDT)
Received: from localhost.localdomain (host-79-42-91-147.retail.telecomitalia.it. [79.42.91.147])
        by smtp.gmail.com with ESMTPSA id s12sm10127014edx.18.2021.04.07.01.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 01:49:27 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH v3] staging: rtl8723bs: hal: Remove camelcase in Hal8723BReg.h
Date:   Wed, 07 Apr 2021 10:49:25 +0200
Message-ID: <3526833.TqPzfDAv2q@localhost.localdomain>
In-Reply-To: <YG1qxdRtNIIVK3fX@kroah.com>
References: <20210406160037.27225-1-fmdefrancesco@gmail.com> <YG1qxdRtNIIVK3fX@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, April 7, 2021 10:18:13 AM CEST Greg KH wrote:
> On Tue, Apr 06, 2021 at 06:00:37PM +0200, Fabio M. De Francesco wrote:
> > Remove camelcase in some symbols defined in Hal8723BReg.h. These symbols
> > are not used anywhere else, therefore this patch does not break the driver.
> > 
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> > 
> > Patch v3 changes nothing with respect to v2 and v1. It exists only to cc some recipients that were missing in the header of the previous email.
> > 
> >  drivers/staging/rtl8723bs/hal/Hal8723BReg.h | 16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> This patch does not apply to my tree right now.  Can you refresh and
> rebase your copy of my branch and rebase it and resend?
>
Sure. I'm about to submit that patch again in a few minutes.

Thanks,

Fabio
> 
> thanks,
> 
> greg k-h
> 




