Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B09A3E5029
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 01:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237086AbhHIXzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 19:55:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbhHIXzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 19:55:06 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897A4C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 16:54:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so27273226edt.7
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 16:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0c71jubzq51sR/tbsO22zLWscqflQE3yuwe5XTj0VtU=;
        b=q5pJxTWagHUiTeoBOql2CCoMG7bLrwz++++XShxr38Rr4XAzwVLMlgUcWJT+HsmDyn
         OQvbuNa/G9UKlqVHwNdl3Gy6v784OtWLAFKRBjoNj6+ORbmit0Vq/JefDGxn/o8cNL1f
         ZxO/BbbYt6Jw0J2NyGLWeiBgA4pRbSOgsHs0ospE+5cldpxym35LSbBttiMSRPXdf8jE
         cnujhir5jG9Mlkxg/7+DtC0ABrvFqS2uVRrXbZlweCKktqqZNBzgCNzUVLNdZPV7/jHw
         xycoXsfvIDmYol3nJDi015qRjbnDsU0Zk0gauxw2qxt9tR4FWny4cXgPNm8YZwcPBW3+
         NZ+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0c71jubzq51sR/tbsO22zLWscqflQE3yuwe5XTj0VtU=;
        b=lG7JLG1elVkTlfNVAxddmSyeZ74F+bq+Y/M5/MlJNnFFIUpEh+PlaGT4JYOINpW9/h
         9Y3oI/zsm2MV8yVvbwC1dx9ij56JDyXGPY1xs33bi3xdCKnobrdibN011HffIFHvEYKd
         nNsA7jSbh9Qr0O0Q6JpgN62F+DbZu78O1rb+Glsx67axMdF1zv4JCVpXW+vJg2C1HfKB
         XVMFicIET8SOlkXVOQwzaMkFRn8JJciwlONcEhZ+roZv3QACyLPYmzAPP9CPM8z6+V2K
         2vsiEd9PmxNEYDQix1+s5Rug0IsR6sF5wetwdjo+3P7Q4TWpdKEbo4dvIQ1LG8URX7sL
         u6mw==
X-Gm-Message-State: AOAM5325kUuqr20cNepzYZY1YkEKfDaCHTjza5s+xYRkvi64ZW7xvJrJ
        quVzVAnfzyBr23R47TD0AAgGCcT7DXck/g5lr54=
X-Google-Smtp-Source: ABdhPJwB57bkrlSEXo22CF0qENtwsrtumB4eCpQEwyZnirDx3sQW+VtPmQtvnZhzyY2FMplE3apY6fjx9Ngm9yhorh4=
X-Received: by 2002:a05:6402:1648:: with SMTP id s8mr1158171edx.214.1628553284200;
 Mon, 09 Aug 2021 16:54:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210809143049.3531188-1-mudongliangabcd@gmail.com>
 <20210809143049.3531188-4-mudongliangabcd@gmail.com> <YRFK3HxNGicni9OB@kroah.com>
In-Reply-To: <YRFK3HxNGicni9OB@kroah.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Tue, 10 Aug 2021 07:54:18 +0800
Message-ID: <CAD-N9QWPyE+RKa0L+t0oYqYPwXK5nJp9UKas4pHQ_7p0kUKe-Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] ipack: tpci200: move tpci200_unregister close to tpci200_register
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Lv Yunlong <lyl2019@mail.ustc.edu.cn>,
        Randy Dunlap <rdunlap@infradead.org>,
        Aditya Srivastava <yashsri421@gmail.com>,
        industrypack-devel@lists.sourceforge.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 11:33 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 09, 2021 at 10:30:29PM +0800, Dongliang Mu wrote:
> > Move tpci200_unregister close to tpci200_register, then it is easier to
> > review the code related to the registration and unregistration
> >
> > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > ---
> >  drivers/ipack/carriers/tpci200.c | 28 ++++++++++++++--------------
> >  1 file changed, 14 insertions(+), 14 deletions(-)
>
> Again, independent of the first 2, and for 5.15-rc1, right?

No, those two cleanup PATCH 3/4 and 4/4 depends on first 2.

>
