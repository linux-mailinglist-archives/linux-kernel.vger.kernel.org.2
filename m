Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E727332A4AC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 16:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1838468AbhCBKyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 05:54:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380821AbhCBKoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 05:44:54 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8692C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 02:44:13 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id b18so12835068wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 02:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/kO4P2+ED95pXew89bxuwKeVgLFer8weWa98ngvrCJQ=;
        b=x17vQLW8iWrIH+2p11n582WVXm4WYE7KCOmThTtJIbmEZ+K30h23s/u5DSF+3+ZPRv
         A2fUDAfR6X6D2ZEkbQ9ZoFrSHtDkayUr1117ywSAG0H24hvthQSbhL1AfCzyLewrwVDy
         Sy0gOXXS2hjlSvVCswtH1p/RyA8vJGeR8i6+4kuwio9DlxGU8kNGbFfrd6n782FBRH4q
         BoHXtFHY/oXLDtarWvtqYg4z/tL1BD7C/bSCnSuvLpfGLq4s/mn8Nt9Bc1owt1GTC1ic
         tc3pnvWKru+VNED/odgpcMqxi0IlD0XlohOSCYf5cVa0NH0qD0p7EA7TvzpsbDOvwHxi
         ooYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/kO4P2+ED95pXew89bxuwKeVgLFer8weWa98ngvrCJQ=;
        b=P7mSlmOs/5s4ei6bJF8ogkWPoFg2rAu/AeSTDsMJFIrHh+4nX3ZmPLnYja4EAt8zPk
         260XTcNtcIWKieDB2MtDsNvr2nTq5+4sJ5sTMvlq3zSn0asHdAOpptNKpOsLs/8YQTSi
         PLFBmNxj3Hm9ZUOFbGIZ8gk6T8fgHUAfSF+J4ppE75PSW3cars0Km5REO+npfIRkHd6C
         YB+3CSBZ3Agvl5+tVdi/zSEAMlFE6FtHcroRnlCnNGVsv332CjufNc1E+QrnkHUUv7FX
         3Q9cEK6nYK/4iVXmqGgR8U1QAprhk2KwDF11Pefq76TxgaScYsQEWaPXFNcrma+tf6dG
         VhmQ==
X-Gm-Message-State: AOAM531Ox+ofvgh4xZS2r6VdAkzRXA3TDvZx3YiWt0uAfbikZupIlWkO
        /Vd/VJvGyZ/80HfdYHFwmlwcPsJwTz93MA==
X-Google-Smtp-Source: ABdhPJwm472oerTl28x1DKIekPlyigc/9kjIExzzqa2U4O8JMoM2CZNwXcJtYIWqJCkdOlmPTnSr2Q==
X-Received: by 2002:a5d:698d:: with SMTP id g13mr19724893wru.2.1614681852470;
        Tue, 02 Mar 2021 02:44:12 -0800 (PST)
Received: from dell ([91.110.221.155])
        by smtp.gmail.com with ESMTPSA id i3sm30045865wra.66.2021.03.02.02.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 02:44:12 -0800 (PST)
Date:   Tue, 2 Mar 2021 10:44:10 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc 1/2] RDMA/mlx5: Set correct kernel-doc identifier
Message-ID: <20210302104410.GD2690909@dell>
References: <20210302074214.1054299-1-leon@kernel.org>
 <20210302074214.1054299-2-leon@kernel.org>
 <20210302093109.GA2690909@dell>
 <YD4SxWLbPkEoH3GR@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YD4SxWLbPkEoH3GR@unreal>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 02 Mar 2021, Leon Romanovsky wrote:

> On Tue, Mar 02, 2021 at 09:31:09AM +0000, Lee Jones wrote:
> > On Tue, 02 Mar 2021, Leon Romanovsky wrote:
> >
> > > From: Leon Romanovsky <leonro@nvidia.com>
> > >
> > > The W=1 allmodconfig build produces the following warning:
> > > drivers/infiniband/hw/mlx5/odp.c:1086: warning: wrong kernel-doc identifier on line:
> > >   * Parse a series of data segments for page fault handling.
> > >
> > > Fix it by changing /** to be /* as it is written in kernel-doc documentation.
> > >
> > > Fixes: 5e769e444d26 ("RDMA/hw/mlx5/odp: Fix formatting and add missing descriptions in 'pagefault_data_segments()'")
> > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > ---
> > >  drivers/infiniband/hw/mlx5/odp.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> > > index 374698186662..b103555b1f5d 100644
> > > --- a/drivers/infiniband/hw/mlx5/odp.c
> > > +++ b/drivers/infiniband/hw/mlx5/odp.c
> > > @@ -1082,7 +1082,7 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
> > >  	return ret ? ret : npages;
> > >  }
> > >
> > > -/**
> > > +/*
> >
> > This is not the correct fix.
> 
> I don't want kernel-doc comments on static function. It is local to this
> file, so change from /** to /* was to mark that this is not kernel-doc.
> 
> >
> > Kernel-doc is asking for the function name.
> 
> The thing is that I don't want it to be kernel-doc.

In the past, if the authors have made a good effort to document the
function, I have left the kernel-doc formatting in place.  It looks
odd / non-consistent to demote some, but not others.  Especially
considering there are 100's if not 1000's of other static functions
documented in the kernel with kernel-doc formatting.

There are also 1000's of uses that are left referenced by kernel-doc::
tags.  See: scripts/find-unused-docs.sh for more details.

If you're going to go through with this, you should at least say what
you're doing and why in the commit message.  Since demoting an
otherwise full and complete kernel-doc header seems a little harsh to
say the least.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
