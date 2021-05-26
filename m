Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEC5B391A95
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 16:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235035AbhEZOq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 10:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhEZOq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 10:46:27 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA57EC061756
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:44:54 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n17-20020a7bc5d10000b0290169edfadac9so681093wmk.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 May 2021 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CW0B9Jgp/MsN7PVAeGLodFQbYGud7akQoc9NCQOfV68=;
        b=uR8wVSVPV3aXKNIHs3wNstNCg3GxmXFVrBBsfemAOriTAkWfkQs/JEJ61WHK/xpnpi
         MtDaoNWSjYa9pX0VO7QtXm5ypGQYs1eIbVBsGBADjbGV/J0v9qwKib91/Xoea4+wEqhy
         wC8rDROczq8GlwDveYPsv5lDYXfTK3kituSMvubAeGfkvHipXfBvrmAXCYBR3lttMHgv
         R98zQYvhpCLiCO6JvwGVa2+w2L8OVw8uoWFVFoQ26D2RCBCPHgeRsv911MJdwhQ89OWW
         weAPlNk6mg/SLX7E5xQSESLWi9u4uZcBwIRIUf88mg3wWyRRPT041sLpCDJbH741Q52b
         TlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CW0B9Jgp/MsN7PVAeGLodFQbYGud7akQoc9NCQOfV68=;
        b=XzPYwAfSGyPBMEqowJ2R+kQjj6fjgVN46uY79QAt3+tJZgZwKaN6IMlzI9PGEteNC2
         ucJ2x5tpGcMg7fGURjAwAEwWvBaLMFzxIftcjFVvd5RO2+ZwcqrYFt+uLFAh/QJWfxrx
         J5nW5PsB8RD+mse5VRc3BiCQsaHl/fIoMvRl1cro6rpa9ujWTArvcgu2/UAbf8HZFapu
         5z/RhkgGIwZIqNCWFimOIm0xlLzTqC7y8Jm3+8IWhfsqNKMwaIMocmTvHzMc5j9oNPyY
         jQp/R6sLWHY27+5OffC5LVWJhmNQEae142C3jHSBZKB0L3eCUFhHwEwNVmSjf4ur55/r
         3p1g==
X-Gm-Message-State: AOAM5307cfaYE4i5+04Z9SgtV4RJ2fuVphDqh1EKvhZBSHpscWKqMrUn
        f6GS5DCyEi4cZuBelKcl2JU1yR0hNEd14A==
X-Google-Smtp-Source: ABdhPJwHiIlAHiAjmfazgtvsg7NFO5OEXxGpPjuqVeW3RVAwlsWCkW4EpUmlap0WFnXDUpQgxctibg==
X-Received: by 2002:a1c:7c03:: with SMTP id x3mr29232477wmc.122.1622040293392;
        Wed, 26 May 2021 07:44:53 -0700 (PDT)
Received: from dell ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id t14sm6299415wmq.16.2021.05.26.07.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 May 2021 07:44:52 -0700 (PDT)
Date:   Wed, 26 May 2021 15:44:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Sergei Shtylyov <sergei.shtylyov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 21/24] usb: host: xhci: Move array of structs from the
 stack onto the heap
Message-ID: <20210526144451.GB543307@dell>
References: <20210526130037.856068-1-lee.jones@linaro.org>
 <20210526130037.856068-22-lee.jones@linaro.org>
 <8551978f-27b0-767e-f92b-e96ab3064b33@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8551978f-27b0-767e-f92b-e96ab3064b33@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 May 2021, Sergei Shtylyov wrote:

> On 5/26/21 4:00 PM, Lee Jones wrote:
> 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/usb/host/xhci.c: In function ‘xhci_reserve_bandwidth’:
> >  drivers/usb/host/xhci.c:2859:1: warning: the frame size of 1032 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> > 
> > Cc: Mathias Nyman <mathias.nyman@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-usb@vger.kernel.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/usb/host/xhci.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
> > index ac2a7d4288883..40ce4b4eb12ad 100644
> > --- a/drivers/usb/host/xhci.c
> > +++ b/drivers/usb/host/xhci.c
> [...]
> > @@ -2788,6 +2788,10 @@ static int xhci_reserve_bandwidth(struct xhci_hcd *xhci,
> >  		return -ENOMEM;
> >  	}
> >  
> > +	ep_bw_info = kzalloc(sizeof(*ep_bw_info) * 31, GFP_KERNEL);
> 
>    Why not kcalloc()?

No particular reason.  Muscle memory I guess.

Happy either way.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
