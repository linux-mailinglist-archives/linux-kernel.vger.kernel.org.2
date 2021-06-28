Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC4B3B5C9B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 12:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhF1Kpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 06:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232486AbhF1Kpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 06:45:35 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E594C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:43:10 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b3so20638678wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 03:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pNb+vUKWy59SB8eJVDEKMOkXhObwhOeVoLQvmeacdY8=;
        b=eOGFkO3VQOSSW3VGHkzSGDCOLueIbkAUb8wZGIaiTv3wvhR35wBdHw8WXvKF9o3JgD
         owDfZRS/DSf4IP+hkBXny+EPYead+ViKZ498lAGQ2begDBqIaMjTaPjtubbPHazUw56+
         1Gg3y4jcgls4xE1TQMpelkJxcXsdT0PMzpBiz6g7fG9PQZZ2KS1joYQt+vneNvIlLcWG
         mwvz9LFIye02MbySQfKzyJmD2ycS3XDrYG/XOSv6bgZYWn6KCgzFtjYCWrXv3+0RhmD2
         LmBru9cnBCWfln5/BTO/vuY1fkXyGgplDOgc52+5kV1naVcPm8LcnqBBKfbbBgiU7y1b
         2/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pNb+vUKWy59SB8eJVDEKMOkXhObwhOeVoLQvmeacdY8=;
        b=C9+QYKzbHwWVo9Nt5EZzq5PdU4j3DA6T8IlM96/mzH+aYAS1RgRXfBL8uK9Gro1Sej
         ZqZtlCCe6x8RHct00XzQo+lwF8A6nXxf238kbxB/57+npje/rz6NTRFzyfF+uSuMbq24
         HnHt11IoS+EvgsVcaVWOBtW7s17l4fUJzJeee/cWg91GLxzG1eentb27qIbGuaHrOtWd
         2iQ5NPGq2VUfR4KLxQ7ti+Z9kPR4jURrNty+niqQuisuztEVQNshL8ki6VvVB3Ydvw4o
         +FR6P1QcKn5CH5YLeVOQPQK3xoONJ0yQXJQe/r+p0Kf97diB52avQ0IthXePI4Mm0MLA
         YoSg==
X-Gm-Message-State: AOAM53142U8TQhjgpBmmErmhbXXxrOQsomvUe6yHQB6o2HOCnou/mXEM
        1jlA09Nhyv4X56pTI8L15JsY8g==
X-Google-Smtp-Source: ABdhPJwBy4eD+dYimaiLRaibtlNAee135TlRNIAdEm0JndB8DbWYM106r0wQSw+7I2RhM2YrqLz/lg==
X-Received: by 2002:a5d:4e52:: with SMTP id r18mr26571129wrt.372.1624876989198;
        Mon, 28 Jun 2021 03:43:09 -0700 (PDT)
Received: from dell ([95.144.13.187])
        by smtp.gmail.com with ESMTPSA id t128sm20419831wma.41.2021.06.28.03.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 03:43:08 -0700 (PDT)
Date:   Mon, 28 Jun 2021 11:43:06 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH RESEND v6 6/8] mfd: hi6421-spmi-pmic: move driver from
 staging
Message-ID: <YNmnulvokEuREmj9@dell>
References: <cover.1624525118.git.mchehab+huawei@kernel.org>
 <1ad2cbbd182d18ba2cae716fb5f1497b1cabbdbe.1624525118.git.mchehab+huawei@kernel.org>
 <YNRrISOGujxcJAGR@dell>
 <20210624143605.153e1e34@coco.lan>
 <YNSRwIMr8+m9Sxk3@dell>
 <YNSV+N0h7NoRpo/w@hovoldconsulting.com>
 <20210625133858.3bf1835f@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210625133858.3bf1835f@coco.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Jun 2021, Mauro Carvalho Chehab wrote:

> Em Thu, 24 Jun 2021 16:26:00 +0200
> Johan Hovold <johan@kernel.org> escreveu:
> 
> > On Thu, Jun 24, 2021 at 03:08:00PM +0100, Lee Jones wrote:
> > > On Thu, 24 Jun 2021, Mauro Carvalho Chehab wrote:
> > >   
> > > > Em Thu, 24 Jun 2021 12:33:28 +0100
> > > > Lee Jones <lee.jones@linaro.org> escreveu:  
> > 
> > > > > > --- /dev/null
> > > > > > +++ b/drivers/mfd/hi6421-spmi-pmic.c
> > > > > > @@ -0,0 +1,316 @@
> > > > > > +// SPDX-License-Identifier: GPL-2.0
> > > > > > +/*
> > > > > > + * Device driver for regulators in HISI PMIC IC
> > > > > > + *
> > > > > > + * Copyright (c) 2013 Linaro Ltd.
> > > > > > + * Copyright (c) 2011 Hisilicon.
> > > > > > + * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd    
> > > > > 
> > > > > Can this be updated?  
> > > > 
> > > > Do you mean updating the copyrights to cover this year? E.g.
> > > > something like this:
> > > > 
> > > > 	 * Copyright (c) 2013-2021 Linaro Ltd.
> > > > 	 * Copyright (c) 2011-2021 Hisilicon.
> > > > 	 * Copyright (c) 2020-2021 Huawei Technologies Co., Ltd  
> > > > 
> > > > Right? Or are you meaning something else?  
> > > 
> > > Yes, that's it.  I know this is just a move, but to MFD, it's new.  
> > 
> > That's not how copyright works. Unless Linaro and Hisilicon made
> > nontrivial changes every year from 2011/2013 to 2021 you should not
> > change those lines like this.
> 
> Only Linaro can answer what happened up to 2018, as this driver 
> originally came from a Linaro tree, which has exactly one commit
> for this driver:
> 
> 	https://github.com/96boards-hikey/linux/commit/08464419fba2417aa849fce976fac9c5f51b3ada#diff-604ef8563dcd9ace6e3e58aac38337c72924b0889f6972d7ee9e15e2335ba964
> 
> After merged upstream at staging, all changes are covered by the
> Huawei's copyright (2020-2021).
> 
> So, I'll just drop this patch. If the information is not accurate,
> someone from the original copyright holders can send followup
> patches.

After taking the time to read up on Copyright rules and expectations,
I think we can pretty much safely say that all of the Copyright
entries above are incorrect.

Copyright dates should only be listed if significant works were
undertaken in each of the years listed.  So unless large adaptions
happened every year since 2011, which I doubt very much, they're
wrong.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
