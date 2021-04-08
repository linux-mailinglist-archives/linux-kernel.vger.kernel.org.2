Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777EF35903E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 01:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhDHXPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 19:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232404AbhDHXPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:15:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B3AC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 16:15:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t20so1799704plr.13
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7F1NrpzVcU5GSSnL4Q5tRkk/0OTLWPdILVCrXDKlrcU=;
        b=KmY6O8cmvy4x6bVD2N6lN+Kq4m6736F9Xq4qXpte+Gh/F0Zggdei+qWR0z2LjuxUg6
         LzVjq1FJi87en+NkdZj6veNyK4V/ej67b83CBB1qxaap8BFYlzzuhW7bCdY3RGo5vGvX
         Yo5FWT4cnE9EbwLQZaIVWRGVZCufZWkJfOps1z4Q9b71qj3w4zeliCJf84QGQabNYsIl
         EfDF4wUeaCBjp0X18K4e48TBgASYE3Pv484VS3YJOZdoOxMd5ZQz/M/N57MxmS5h5XQZ
         WqQuQ7iyWRPLlbFOiCuy91eCMxSQhyC3LZy+CPlBdKMDL5buTv/khV5lbaTVVpZJqVg0
         hULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7F1NrpzVcU5GSSnL4Q5tRkk/0OTLWPdILVCrXDKlrcU=;
        b=pqMQSgJ6/tLHGK9Bh3SH3g8aMgsuQ/vM0iglv/6g5iYAOzu7urYbWzsFl7ngXrPPHk
         wYh5Y+RcOvbnQr/G5nMDmDjyayM6nAz4LqHEaF+R+SDgyH/b9+QSwPUAAU/qubZ3ySl6
         h4b2ukoPnSIIzj01FCy8FjzFFgXlt3kDaN4Fh8PJXNia1tB6zlfY0xHx7LfBZdZkpomy
         e/KbWVVeNrHF4z8GjuwQOup0hdeRhsyEXSFHmGvIl5Yc6lBq7/fR7pTkXcQvc73dqqsU
         QL1BF7GYuo/wO6Ek1t8F3fRlr8lXEMaTUUbXERqfQcSemLDFvBdH27/a1cZslvohDvod
         /Dgw==
X-Gm-Message-State: AOAM53236bMABBNclCOioPovqxfov9Dy35KQC77NIAoQUFSioGU3sBYo
        zA9+JQWOOW6AsIHntUCSdIo=
X-Google-Smtp-Source: ABdhPJxJAlfUz4AdpoXyHlnOgRgCXg8ScvuKf2dCSwd3EOxOlgD+eLag9Cw1HhYS06ZQGkMfdGaagg==
X-Received: by 2002:a17:90b:3704:: with SMTP id mg4mr10706833pjb.156.1617923731545;
        Thu, 08 Apr 2021 16:15:31 -0700 (PDT)
Received: from kali ([152.57.243.224])
        by smtp.gmail.com with ESMTPSA id i9sm425178pjh.9.2021.04.08.16.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 16:15:31 -0700 (PDT)
Date:   Fri, 9 Apr 2021 04:45:21 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     clabbe@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH 2/2] media: zoran: replace bit shifts
 by BIT() macro
Message-ID: <YG+OibRNRmILe8nQ@kali>
References: <cover.1617912177.git.mitaliborkar810@gmail.com>
 <ac8ec2b70ac2cc7c541c05a1d9a8db1fe79df793.1617912177.git.mitaliborkar810@gmail.com>
 <alpine.DEB.2.22.394.2104082314090.21785@hadrien>
 <YG95l9b++d+RFrDa@kali>
 <alpine.DEB.2.22.394.2104090009220.21785@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104090009220.21785@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 09, 2021 at 12:10:06AM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 9 Apr 2021, Mitali Borkar wrote:
> 
> > On Thu, Apr 08, 2021 at 11:15:07PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Fri, 9 Apr 2021, Mitali Borkar wrote:
> > >
> > > > Added #include <linux/bitops.h> and replaced bit shifts by BIT() macro.
> > > > This BIT() macro from linux/bitops.h is used to define ZR36057_VFESPFR_* bitmasks.
> > > > Use of macro is better and neater. It maintains consistency.
> > > > Reported by checkpatch.
> > > >
> > > > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > > > ---
> > > >  drivers/staging/media/zoran/zr36057.h | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/media/zoran/zr36057.h b/drivers/staging/media/zoran/zr36057.h
> > > > index a2a75fd9f535..93075459f910 100644
> > > > --- a/drivers/staging/media/zoran/zr36057.h
> > > > +++ b/drivers/staging/media/zoran/zr36057.h
> > > > @@ -8,6 +8,8 @@
> > > >  #ifndef _ZR36057_H_
> > > >  #define _ZR36057_H_
> > > >
> > > > +#include <linux/bitops.h>
> > > > +
> > > >  /* Zoran ZR36057 registers */
> > > >
> > > >  #define ZR36057_VFEHCR          0x000	/* Video Front End, Horizontal Configuration Register */
> > > > @@ -31,12 +33,12 @@
> > > >  #define ZR36057_VFESPFR_VER_DCM          8
> > > >  #define ZR36057_VFESPFR_DISP_MODE        6
> > > >  #define ZR36057_VFESPFR_YUV422          (0 << 3)
> > > > -#define ZR36057_VFESPFR_RGB888          (1 << 3)
> > > > +#define ZR36057_VFESPFR_RGB888          BIT(3)
> > >
> > > Uniformity is generally considered to be more important than using BIT.
> > > Having only a few constants defined using BIT is a bit strange.
> > >
> > Okay Ma'am. Can you please tell me on how to proceed now? I am not sure
> > how to proceed.
> 
> I think that this code should just be left as is.
> 
> Checkpatch makes suggestions.  Its suggestions are not always appropriate
> for the context.
>
Okay Ma'am. This means I should not do any changes now. Do I need to do
something in this patch now? Or move onto next one?

> julia
> 
> >
> > > julia
> > >
> > > >  #define ZR36057_VFESPFR_RGB565          (2 << 3)
> > > >  #define ZR36057_VFESPFR_RGB555          (3 << 3)
> > > > -#define ZR36057_VFESPFR_ERR_DIF          (1 << 2)
> > > > -#define ZR36057_VFESPFR_PACK24          (1 << 1)
> > > > -#define ZR36057_VFESPFR_LITTLE_ENDIAN    (1 << 0)
> > > > +#define ZR36057_VFESPFR_ERR_DIF          BIT(2)
> > > > +#define ZR36057_VFESPFR_PACK24          BIT(1)
> > > > +#define ZR36057_VFESPFR_LITTLE_ENDIAN    BIT(0)
> > > >
> > > >  #define ZR36057_VDTR            0x00c	/* Video Display "Top" Register */
> > > >
> > > > --
> > > > 2.30.2
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/ac8ec2b70ac2cc7c541c05a1d9a8db1fe79df793.1617912177.git.mitaliborkar810%40gmail.com.
> > > >
> >
