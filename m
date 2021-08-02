Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A53DDC3E
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234584AbhHBPV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:21:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbhHBPV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:21:28 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE07C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:21:17 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id n2so24939770eda.10
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IVqYYLjGOPKQife1ID3vUeLHeieycL8YR2lT+WrDkFI=;
        b=jXk2OP6NdkifNBX3E6RH9oS7ZXLx9+q+2q3xOOoj9K0IbOnbA4gvu+6Ib73oCOE2+4
         co5XXYMkEK19URYAdQhG7BoLRgmfdl3EqO/zsJKs6M93XViQlJEcbzs247qmKig0vpeL
         9p1Y5uwjjUOMWojKQLM4KpjugvMhZ1USBTL5m15wpNWenIj1KnGnpgL+SQZ8mVQI6cJW
         qZPkDIVuBPW7TPbQdVZJxQFoKq+fGtNGpqYJ68yHhheWv2+PGoAmoDIy+OxHlAjz1pZx
         Twf85Orbu8o8ZyYKrOLZ14eV/56wI3RiHhubWy10tO536HWR4hUv2Zri1IsOepYCRDtN
         doug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IVqYYLjGOPKQife1ID3vUeLHeieycL8YR2lT+WrDkFI=;
        b=gcQk0YE8f82le11SFKPaglIf77vrIMgoMNV3gFrfXo+A6GLUSQp6GTziXIZjrjcc7n
         uf4DecQJWV0YP24AZ2u7n82YiYAwwGZQx7BQ9E/vUp/XwxsIVGaTVH4k2ABaI2lLLT7N
         6sUzVs3Be34SFjSGIMM/EUgMQu/kB/dVOEngML6l/I8PKVhAkLBQ7ojUDlMWL6wAUCn7
         hzijVVcpBPxiYRYLWOMf8ezY9/6aQ4VyZuPKQw4uUsrU8bRaI4UjsDLUN7H9BZkCIz3x
         2Ya/OYDCgaI5hd30EPQFl5rLSsRle71It88KQx9xSqrNOzyjfccjQPXKXDfUnNzztBiU
         QZKQ==
X-Gm-Message-State: AOAM533o7pMwyXDZ/6lhl8GYTjP69W9OG6zCopF69qL5rPrVXR2YaX5S
        EIfRBpLWPz2K2MK1qs590Rg=
X-Google-Smtp-Source: ABdhPJyRxHIXCVK8ir4zjMfG4mHt+mmLmFPcDMV7K5upkC7HV6/82qpwTeO8YU8l+t2p3GXXsU/8Ag==
X-Received: by 2002:a05:6402:1778:: with SMTP id da24mr20117959edb.385.1627917675986;
        Mon, 02 Aug 2021 08:21:15 -0700 (PDT)
Received: from localhost.localdomain (host-82-51-42-96.retail.telecomitalia.it. [82.51.42.96])
        by smtp.gmail.com with ESMTPSA id oz27sm4703948ejb.90.2021.08.02.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:21:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Fix different base types in assignments and parameters
Date:   Mon, 02 Aug 2021 17:21:14 +0200
Message-ID: <4462633.k6rmAWbitH@localhost.localdomain>
In-Reply-To: <2081658.ULrIQvW0dQ@localhost.localdomain>
References: <20210730181452.23062-1-fmdefrancesco@gmail.com> <20210802140505.GZ1931@kadam> <2081658.ULrIQvW0dQ@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, August 2, 2021 4:26:33 PM CEST Fabio M. De Francesco wrote:
> On Monday, August 2, 2021 4:05:05 PM CEST Dan Carpenter wrote:
> > On Fri, Jul 30, 2021 at 08:14:52PM +0200, Fabio M. De Francesco wrote:
> > > Fix sparse warnings of different base types in assignments
> > > and in passing function parameters.
> > 
> > [...]
> > > 
> > > +	union {
> > > +                unsigned int f0;
> > > +                unsigned char f1[IPX_NODE_LEN];
> > 
> > What is going on here??  Why is f1 six bytes?
> 
> Please look at the third parameter of the latest memcpy() in this function.
> 

No, I'm wrong here. I must have exchanged in my mind the latest and the 
memcpy() before the latest. So I see a '6' in the wrong memcpy().

I'll fix it ASAP.

Thanks,

Fabio




