Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA5A42FAC5
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 20:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242541AbhJOSJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 14:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242377AbhJOSJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:09:29 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73163C061570
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:07:22 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id i12so27826398wrb.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 11:07:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nxtq8epWJL/jhmwohXGzfNuEJ0aADKyx5lNAaZVeTp0=;
        b=yWeEwuasIkiPhkjbn81eCjsbVr2dUyMx0cw0/wClB0RJZWbVFaoJCqOVezrI+EEN57
         jhu8bq2tYBQmyCZzX6qAXJzgR9b23fwmRd8316N0aSjduPo2isBHBKL24NIGqMP5OB3h
         YjjgJuQiNRln696MnY/HGV0T4MCAB0d+VLhMkEDUgAWu90N4cBoWYPI9jJvr+gGdtZCx
         YPgUvo19Xu9dc2nFKfd6ZGfq0Hdy4OKhSWkOtga/hHnkMIodF6CD5KkP6YIDS7JzWeRN
         +R/eCiui1zoFF8hRwPt4bJ+qSyy+9jLabNiFp+7tm2cA5m8PMGA+zInmWnX0GAc/Y4qh
         Ikyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nxtq8epWJL/jhmwohXGzfNuEJ0aADKyx5lNAaZVeTp0=;
        b=inqEcTaShY8S37LLNNWDR+4ICVrd07JrsrHAsogzOE4HmgcRjv1uAlNNxQgzVVhNcX
         6QXQneUIv4IxbaEAGJusRUFmqL83Ay71PyUo9yo5pxWxvDs3m4jA/hqVTe6mJXFm4Xm7
         mxg9i1+eRYtflkEJi564AWclRjPJZMSq1UFseTR1fd24YU5D2y20yXVF446xWCAaejQJ
         ldSaqnzbfdMoYxTH3n+Le86LaZtlRP73rI8nwfHhvRGmvyXGbiwnOc6dncUKpb4hElEh
         t+vsncfV+X7iODySUeBA3STGj/qHH85FBybnAPM6OgC2ShZgJpazp7XvDpWpjxFINQ7X
         LIoA==
X-Gm-Message-State: AOAM531dDJLDVeWsb0oS+OTjTJVNE0dGG1QiGGEoj7qQc09v2CLc6Ju/
        iPzhMzxCCsU34iGx8+UJj48hMg==
X-Google-Smtp-Source: ABdhPJzHBqFfgVKb3EVdigfjWR1r041E4GoKwVYBmqQkOwKwzI8aovWBo+6Z7TSYzTDTWw6gC/6pLw==
X-Received: by 2002:a05:6000:18a3:: with SMTP id b3mr16312728wri.178.1634321241050;
        Fri, 15 Oct 2021 11:07:21 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id j1sm6536340wrb.56.2021.10.15.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 11:07:20 -0700 (PDT)
Date:   Fri, 15 Oct 2021 19:07:18 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH 0/7] staging: r8188eu: odm cleanups
Message-ID: <YWnDVkwcnVEEoxm4@equinox>
References: <20211015163507.9091-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211015163507.9091-1-straube.linux@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 06:35:00PM +0200, Michael Straube wrote:
> This series removes:
> - empty / unused functions from odm.c
> - two never set / unused fields from odm_dm_struct
> - the function ODM_CmnInfoPtrArrayHook()
> 
> Tested on x86_64 with Inter-Tech DMG-02.
> 
> Michael Straube (7):
>   staging: r8188eu: remove empty functions from odm.c
>   staging: r8188eu: remove ODM_SingleDualAntennaDefaultSetting()
>   staging: r8188eu: remove GetPSDData()
>   staging: r8188eu: remove ODM_AntselStatistics_88C()
>   staging: r8188eu: pBandType is never set
>   staging: r8188eu: pMacPhyMode is not used
>   staging: r8188eu: remove ODM_CmnInfoPtrArrayHook()
> 
>  drivers/staging/r8188eu/hal/HalPhyRf_8188e.c  |   2 +-
>  drivers/staging/r8188eu/hal/odm.c             | 144 ------------------
>  drivers/staging/r8188eu/hal/odm_HWConfig.c    |   7 +-
>  drivers/staging/r8188eu/hal/odm_interface.c   |   5 -
>  drivers/staging/r8188eu/hal/rtl8188e_dm.c     |   2 +-
>  .../staging/r8188eu/hal/rtl8188e_hal_init.c   |   5 +-
>  drivers/staging/r8188eu/include/odm.h         |  38 -----
>  .../staging/r8188eu/include/odm_interface.h   |   2 -
>  drivers/staging/r8188eu/include/odm_precomp.h |   2 -
>  9 files changed, 6 insertions(+), 201 deletions(-)
> 
> -- 
> 2.33.0
> 

Dear Michael,

Looks good to me. Built and tested on my USB-N10 Nano, works well. Many
thanks.

For whole series:
Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil
