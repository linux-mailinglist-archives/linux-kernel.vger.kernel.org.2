Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1EF35702F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353507AbhDGPZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243029AbhDGPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:25:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCEAC061756
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 08:25:39 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i18so14965816wrm.5
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 08:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JUwBXCTGmPDS35FUGhOGZPUnfRPqWKMKWqMQh69PbYY=;
        b=ni8a/QUvQsQXYEF5YryW7qdVsKKI1+UVPsVhm34u54TJ/om9o0h7lk2I4d23Bvr/OM
         vkCQfDu6P8ylGUSODT8iWRjmcnsgH9HwHdmZ/N/fj0W46yqYK2isBvHoiAWkxjP6ARZ3
         fT+TBI2NFWv4Rq0XzN3P9mPMlMwqI4T8t7Ib8yiD9smY3OubNobX3IFqfbjY4+911ufN
         0vON3rSHDGNM2uRECvqIWHNepBKcgT7PCpWBVPDisCnnnFyZD8vNRilbeaFWyP1TsPy2
         fz2ikL8dyzWgkm+6BTtYG82U21cufYYwSbTl2c8KMwBl5qmCtmDFXbJGcgwl2v2hsWt6
         DPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JUwBXCTGmPDS35FUGhOGZPUnfRPqWKMKWqMQh69PbYY=;
        b=cUKM/x/GSe9sRY6BtoM+dcSTcDWc3sgUQreG50HyHBXu8IH94AHVdRIrBLSZ9Sa0fY
         OhXrniAxc8xzdnQbY8mgROT8nk+JL4R0iEFyJMskmRdxf7B2ZNybzJxXGjypcZuRFcse
         d7Ae+PXPIQzYl2xBe6tdvui9iRBl2uH25hNfz27exUrS68ELCWu5KyzNEDyshsB1Clzx
         NhMA5WCDhae5JH+SWdwAPskujdWhN+OkVk9yCk5UrdTu9OL595yM1tNRABVlN8O+FrRg
         SSiiH8Uyxn4espRFrnjR4qj6cv5DVb/OJWGgQF0DBr3qBVDxZI0k+gEcJWyFnDUDBZYD
         bcVg==
X-Gm-Message-State: AOAM5327VtUAv5VgsgUp3QbCQQEEFC6dCnFZk24tFMk1ag4kMrs0+j13
        5kMTlF0JO2ji31mlcd8xQa1k4EtEN+o=
X-Google-Smtp-Source: ABdhPJx+Z99oYdhRrRh6e+qoS2DXuyI+FVmkkIsf66K53VKb8Cz/SBlZJ/GTkORUwlnqM5USPBrLbw==
X-Received: by 2002:adf:e843:: with SMTP id d3mr5123664wrn.56.1617809137992;
        Wed, 07 Apr 2021 08:25:37 -0700 (PDT)
Received: from agape.jhs ([5.171.72.217])
        by smtp.gmail.com with ESMTPSA id d20sm9118092wmd.48.2021.04.07.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 08:25:37 -0700 (PDT)
Date:   Wed, 7 Apr 2021 17:25:34 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/19] drivers: rtl8723bs: rewrite comparison to null
Message-ID: <20210407152533.GA1590@agape.jhs>
References: <cover.1617802415.git.fabioaiuto83@gmail.com>
 <0c6d53c851d1b07eb0183108e0bad7b4f273f04b.1617802415.git.fabioaiuto83@gmail.com>
 <YG3MOCQHu3o/qHTg@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG3MOCQHu3o/qHTg@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2021 at 05:14:00PM +0200, Greg KH wrote:
> On Wed, Apr 07, 2021 at 03:49:31PM +0200, Fabio Aiuto wrote:
> > fix following post-commit hook checkpatch warnings:
> > 
> > CHECK: Comparison to NULL could be written "!psta"
> > 97: FILE: drivers/staging/rtl8723bs/core/rtw_ap.c:2115:
> > +		if (psta == NULL)
> > 
> > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > ---
> >  drivers/staging/rtl8723bs/core/rtw_ap.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Nit, your subject line has "drivers:" not "staging:" here.  Be a bit
> more careful next time please.
> 
> thanks,
> 
> greg k-h

sorry, you can drop them off the staging-testing branch and I will resend you all if you want,

fabio
