Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E03A3067B9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 00:23:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbhA0XUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 18:20:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235017AbhA0XSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 18:18:37 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCDCDC061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:17:55 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id t25so2773322pga.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lQxkoXZQ0A7KdqinkFmDZDXTt+/dBHGH784ZRhAEeps=;
        b=MpZEu3NQYwpQXwQBUZfWXRH1hhHtwAezoZLhH110QumHvyS9Lb+1xegwLGlmy8vooE
         w+GEO6X60PXU7riugn7tcoFoV+GG1Q4ZxnzCKR9bqL1sL/jnfEMRohp7+wFqoOVHsHPm
         7IIm577RVXGaWyJGd8LwtfkSPWf2GBjWcbDrAonFP/+tHusy5KL09xu28swqq+bUts/u
         CcdOuL6YKR36ZX9OMxGMW4wsJW/OZUxKJckfSzmf2TMbcYuD6st1HgpyKzKKtuv4xjN7
         iAhggLRmKq1uMe82saSadf2KF/q81FFKCV6d8bLN9YPxIH5Ql+uhO9StjkawlGoRokZU
         ttrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lQxkoXZQ0A7KdqinkFmDZDXTt+/dBHGH784ZRhAEeps=;
        b=nGZbCvKfndUBxXQu9hdil/Fu4cz0EI89t+kFfCVmUOjKz6iAmQkk2vmdRQJPS9oMMm
         m6gm/T9bdQZAEYgGmFQK5m2ZlNwT7VRtg2Ts97JqAzld/bTx4ZOj5ooFiYN4CPQi+nAW
         jo80wD7ix4IBssvrMjW5YzRQ+XN7Haf2xfVa4w+rFg14AYV1QFQ5gpOSGFcf+pd2EmY3
         HzqEXS5ru+Ni6lyEMTVz/7o7PQjT9pyvgQJLdN1gwoLwiTI4WKoi/go2kynmGvs23VGf
         fbGmzuwU16u8UsGHt+kvGj8jcnXsBix7pH95si4cLmRY9mxhqSWFsmZvvYkXAlW8Cq7Z
         jo1g==
X-Gm-Message-State: AOAM5301EnfGydFc6CWLijVyL1xMnqCv9sD0US4UyGS6gEuLJ9r4ALIK
        EUeHWA1V1CPU1K57GnSvm9A=
X-Google-Smtp-Source: ABdhPJx/K6gyKea2qmHabezjui5lc/9MRStyAx9iz5UW2MiQ3Tn2E6OKCnkLX04c2aIgK8Uz2beW4A==
X-Received: by 2002:a62:1794:0:b029:1be:c822:52c3 with SMTP id 142-20020a6217940000b02901bec82252c3mr12903362pfx.66.1611789475315;
        Wed, 27 Jan 2021 15:17:55 -0800 (PST)
Received: from localhost (g54.222-224-210.ppp.wakwak.ne.jp. [222.224.210.54])
        by smtp.gmail.com with ESMTPSA id f71sm3447640pfa.138.2021.01.27.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 15:17:54 -0800 (PST)
Date:   Thu, 28 Jan 2021 08:17:52 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Pawel Czarnecki <pczarnecki@internships.antmicro.com>,
        Mateusz Holenko <mholenko@antmicro.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: litex: Properly depend on HAS_IOMEM
Message-ID: <20210127231752.GX2002709@lianli.shorne-pla.net>
References: <20210127033603.1519127-1-davidgow@google.com>
 <20210127122712.GU2002709@lianli.shorne-pla.net>
 <CABVgOSkkRt5eZRrb8ia-0++0W8A4radZBWWry1P16=ZcAKLAuQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSkkRt5eZRrb8ia-0++0W8A4radZBWWry1P16=ZcAKLAuQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 12:49:56AM +0800, David Gow wrote:
> On Wed, Jan 27, 2021 at 8:27 PM Stafford Horne <shorne@gmail.com> wrote:
> >
> > On Tue, Jan 26, 2021 at 07:36:04PM -0800, David Gow wrote:
> > > The LiteX SOC controller driver makes use of IOMEM functions like
> > > devm_platform_ioremap_resource(), which are only available if
> > > CONFIG_HAS_IOMEM is defined.
> > >
> > > This causes the driver not to be enable under make ARCH=um allyesconfig,
> > > even though it won't build.
> >
> > Is this wording correct?  I suspect it causes to driver TO BE enabled.
> >
> 
> Whoops! Yes: that should be "causes the driver to be enabled" -- sorry
> about that.
> 
> Let me know if you want me to re-send it with the fixed wording, or if
> you just want to fix that yourself.

OK, I'll fix it.

> > >
> > > By adding a dependency on HAS_IOMEM, the driver will not be enabled on
> > > architectures which don't support it.
> > >
> > > Fixes: 22447a99c97e ("drivers/soc/litex: add LiteX SoC Controller driver")
> > > Signed-off-by: David Gow <davidgow@google.com>a
> >
> > This looks ok to me.  I can queue it for 5.11 fixes, if you can help with the
> > wording above.
> 
> Thanks: that'd be great!

No problem.

-Stafford

