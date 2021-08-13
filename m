Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 711193EAE4C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 03:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbhHMBwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 21:52:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbhHMBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 21:52:23 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED69C061756
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 18:51:57 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z11so12909521edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Aug 2021 18:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=64W0Rzrur5DnbHP4hOalW0KQb9n7hi068OYFKUZ/rMA=;
        b=a3OBnfSG1E1v3eOiKJUDUlDQVAufOTaVtSAqXF2WxNLIZgUGWGwtwDKFokVO87OwJ/
         woUexZdBe0fxBlnuK/XRDIyR0CTGYuR2Q526MR6km3Hpxm2Bwg3GQeT5Pgugfr/9d0jQ
         EN0+y7PgXlCQ1gDuGQcrf6Js5GvxB/ENCuj/Kjix48zoWrTxL59JGJGjWzKrFgR1M9dw
         K/CFzcHetyeZmGWdVcVYa0vmnYBoLfH2xgH2oHAaw1hrP1eJbDJvqUlyCiEBDtlRon15
         URuluZX1xSh6Yfb95+zBXJMj9wlzdhDDC7pQZwE9NgREMViLgV/U4aMMpUoKeQHTOHAp
         Dz2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=64W0Rzrur5DnbHP4hOalW0KQb9n7hi068OYFKUZ/rMA=;
        b=cXVsYSx6QtQC/L0FLA+XN+WKJed08aFm2dGVxEj+bzF7rS4cMe7Zu9I5vVfOVFprrl
         dae7ILd/yT9mLfOipd5maAgTyXcCGgiWz8aCFqO9auZbLQTUF4ewhpmMZbrkyPnJ6Gww
         oBjr4SsLPYuLvUqT6ZvNw98rCVgzYgRa3v6/LNIvmAi70oO//HGEA1jXZpS3S27k+AAO
         P4IFR0Te9xERnMPt7N390mfKfWgl7e3eVdIBPdCxJigjsU/WXgsmDFSsVFI0wHXinqba
         6oMN7cYsXyWK0q8PtRuo8u50YaXG96rTpRHwnkQXBkoygbrn76tffA6R7ajG4/npCfXP
         qHVw==
X-Gm-Message-State: AOAM530LLK7f5lYKJ1e2EWhP+tmPQv/lPgeoXX+nBQZjqnZEzF+VzGoV
        nAGvvK6u+PUYkDIQorIJ1DKEO674Ej4=
X-Google-Smtp-Source: ABdhPJywOR3hB+4JheUjP0fa23pwj8BOxVC08FZvIhMDVBGCMWQxtuMXNIs4Dy8makWnc5tJ2wssdQ==
X-Received: by 2002:aa7:d3cc:: with SMTP id o12mr8971391edr.335.1628819516107;
        Thu, 12 Aug 2021 18:51:56 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id j27sm1402843ejk.18.2021.08.12.18.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 18:51:55 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH 3/3] staging: r8188eu: Reorganize error handling in rtw_drv_init()
Date:   Fri, 13 Aug 2021 03:51:54 +0200
Message-ID: <2890624.vKDRqAKio7@localhost.localdomain>
In-Reply-To: <24e15d45-40b8-b8a7-b633-9e538324a29b@kernel.org>
References: <20210812204027.338872-1-nathan@kernel.org> <1651213.ETx7SW4KbR@localhost.localdomain> <24e15d45-40b8-b8a7-b633-9e538324a29b@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 13, 2021 1:14:01 AM CEST Nathan Chancellor wrote:
> On 8/12/2021 4:11 PM, Fabio M. De Francesco wrote:
> > On Thursday, August 12, 2021 10:40:27 PM CEST Nathan Chancellor wrote:
> > [...]
> > Therefore, apart that minor misuse of the "global" class in your commit
> > message, it's a nice work and so...
> 
> I am happy to redo the commit message if you and others so desire.
> 
> > Acked-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> 
> Thank you for the review and ack!
> 
> Cheers,
> Nathan
>
Maybe that for that minor misuse of the definition of "global variable" it 
isn't worth to redo three patches. If I were you, I'd wait for feedback from 
Greg K-H and then I'd act accordingly. 

But, at my first read of your patch, I didn't notice that when you return the 
error from within the block starting at the "err:" label, "ret" is always set 
as "-ENODEV".

So, why not simply "return -ENODEV;" and get rid of the "ret" variable?

Thanks,

Fabio 



