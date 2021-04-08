Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72081358F6C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbhDHVqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 17:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232236AbhDHVqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 17:46:21 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C83C061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 14:46:10 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id m11so2816556pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 14:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zdYrRG+l2GoEvS5VtKq2sFMzwk0/c7v4k7SjxU8/nlI=;
        b=pGvoxtmiv0oLqbjD93870KWrjw47K88SjDBibeVYxxIXuawIzHhxFYP1zA278oET1S
         PODbKJTQCZx3gHNcDk/vOIHnsYSuTreJ2iEZHTo7INLdqHp/H+NBM9qOJrRGxACNDnaC
         kw42jgirCc9Npswcxhyr9BAw9H/tK6cGNxHvrsFD36m6I1HSwnTMx2re17qp+6h9c3BA
         ifknR1qtAehdZd9qhLxbuMVmHK6IjfD00k2jMAdkZp5YP/JDiPdTAKFmyyWuq2X0szKJ
         vlWqFVo2ArCOi71EQUDQfIFeop0BXYivPzrK/MPvFykk/i8/mnUCUA6rxKF5lRlX3OYa
         y0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zdYrRG+l2GoEvS5VtKq2sFMzwk0/c7v4k7SjxU8/nlI=;
        b=WDsoFQy94qQmehuLUeYa4Y2FQ3+BeOfmOW9vVyMb5LqO7KqxyPnc/UU5SnkFpOsde3
         zJAp7nPhHOIHdcgEkRLDbgPNUR7hL2hismWRbMj6R0URTMqEK0BRPKcgF2NpZTAAe2Lr
         v+yyQ/ulNvvMF2L7TuuaJrUBr221KPLwovVQPAl+Q8bnHC8E2WhvmB9d+KVxkpdsVAAm
         RvOeqwNnIbHHe6KJrPxlssG8mtmtamS/egCvjzcHwnRy5VTrOaq6RPd+VxaHGHOQE3+X
         mXva8fwiiG1tH869cWdsq9u8IbSo6FxqfP7QHv2X4z9DIWyJKVPlpplddQishCItPuFR
         MD7w==
X-Gm-Message-State: AOAM530bIG1YRxfsDWOelO78yvbGCkarzNOlAUPqZ2KNfN6ypeX6TSc2
        RCi3BPTNN4VoNKj7/BzvKDDnU9eQR4KvqzaD
X-Google-Smtp-Source: ABdhPJxsxvaEVHM/nKZAefWElpdkYy/pEMZeN8rPJZDReAXKIQ+J5RCpE0/w6ueGlPBN9u6RXku8xg==
X-Received: by 2002:a62:2b03:0:b029:241:d147:2a79 with SMTP id r3-20020a622b030000b0290241d1472a79mr9301490pfr.53.1617918369651;
        Thu, 08 Apr 2021 14:46:09 -0700 (PDT)
Received: from kali ([152.57.243.224])
        by smtp.gmail.com with ESMTPSA id t24sm290089pgi.30.2021.04.08.14.46.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:46:09 -0700 (PDT)
Date:   Fri, 9 Apr 2021 03:15:59 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     clabbe@baylibre.com, mchehab@kernel.org,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com,
        mitali_s@me.iitr.ac.in
Subject: Re: [Outreachy kernel] [PATCH 2/2] media: zoran: replace bit shifts
 by BIT() macro
Message-ID: <YG95l9b++d+RFrDa@kali>
References: <cover.1617912177.git.mitaliborkar810@gmail.com>
 <ac8ec2b70ac2cc7c541c05a1d9a8db1fe79df793.1617912177.git.mitaliborkar810@gmail.com>
 <alpine.DEB.2.22.394.2104082314090.21785@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104082314090.21785@hadrien>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2021 at 11:15:07PM +0200, Julia Lawall wrote:
> 
> 
> On Fri, 9 Apr 2021, Mitali Borkar wrote:
> 
> > Added #include <linux/bitops.h> and replaced bit shifts by BIT() macro.
> > This BIT() macro from linux/bitops.h is used to define ZR36057_VFESPFR_* bitmasks.
> > Use of macro is better and neater. It maintains consistency.
> > Reported by checkpatch.
> >
> > Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
> > ---
> >  drivers/staging/media/zoran/zr36057.h | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/staging/media/zoran/zr36057.h b/drivers/staging/media/zoran/zr36057.h
> > index a2a75fd9f535..93075459f910 100644
> > --- a/drivers/staging/media/zoran/zr36057.h
> > +++ b/drivers/staging/media/zoran/zr36057.h
> > @@ -8,6 +8,8 @@
> >  #ifndef _ZR36057_H_
> >  #define _ZR36057_H_
> >
> > +#include <linux/bitops.h>
> > +
> >  /* Zoran ZR36057 registers */
> >
> >  #define ZR36057_VFEHCR          0x000	/* Video Front End, Horizontal Configuration Register */
> > @@ -31,12 +33,12 @@
> >  #define ZR36057_VFESPFR_VER_DCM          8
> >  #define ZR36057_VFESPFR_DISP_MODE        6
> >  #define ZR36057_VFESPFR_YUV422          (0 << 3)
> > -#define ZR36057_VFESPFR_RGB888          (1 << 3)
> > +#define ZR36057_VFESPFR_RGB888          BIT(3)
> 
> Uniformity is generally considered to be more important than using BIT.
> Having only a few constants defined using BIT is a bit strange.
>
Okay Ma'am. Can you please tell me on how to proceed now? I am not sure
how to proceed.

> julia
> 
> >  #define ZR36057_VFESPFR_RGB565          (2 << 3)
> >  #define ZR36057_VFESPFR_RGB555          (3 << 3)
> > -#define ZR36057_VFESPFR_ERR_DIF          (1 << 2)
> > -#define ZR36057_VFESPFR_PACK24          (1 << 1)
> > -#define ZR36057_VFESPFR_LITTLE_ENDIAN    (1 << 0)
> > +#define ZR36057_VFESPFR_ERR_DIF          BIT(2)
> > +#define ZR36057_VFESPFR_PACK24          BIT(1)
> > +#define ZR36057_VFESPFR_LITTLE_ENDIAN    BIT(0)
> >
> >  #define ZR36057_VDTR            0x00c	/* Video Display "Top" Register */
> >
> > --
> > 2.30.2
> >
> > --
> > You received this message because you are subscribed to the Google Groups "outreachy-kernel" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to outreachy-kernel+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/outreachy-kernel/ac8ec2b70ac2cc7c541c05a1d9a8db1fe79df793.1617912177.git.mitaliborkar810%40gmail.com.
> >
