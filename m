Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD001355076
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Apr 2021 12:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241357AbhDFKFT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Apr 2021 06:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbhDFKFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Apr 2021 06:05:16 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B224C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  6 Apr 2021 03:05:09 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g8so21744695lfv.12
        for <linux-kernel@vger.kernel.org>; Tue, 06 Apr 2021 03:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LCL0Idnlb7guUbYyS2ZyKusS1ukOTUVL+jvswqtN1Wg=;
        b=aaikD3f927e+oV/TE/U42Sxn70A9IdaWcEDOH2UrA76DQZoQPFvEjH/LG9So/U+dQt
         2ExzQjhEsYqE99acWYGpQTUTXkxigCQijGv5D77HF6DCAd/sfsEt2Kt9fyISL2HKBToX
         NkYpj8lUJY9SUvWEyEe3QGIHukNJCUGbRnri3YgwzwQlcCXZEIgoG96wv5/c6HCkL4KD
         GdFlHUFHZCIbC/vPzRJsGD+k3cB0eXTs/xyruP5cZ2GsZWxS/RtpFWlsda4jtkim4+Wv
         PIC0Z/9TjX1dZDqfbb6MLwk1TVEbVMlwoGCffKWQfMAF23k+cPEaET1dUSFMcejOouvz
         fXzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LCL0Idnlb7guUbYyS2ZyKusS1ukOTUVL+jvswqtN1Wg=;
        b=FKusJ/1gCWK/b7aeAoDIAXaQIOXESu6rMIQ2UsM8SvYoAd7A6au1K8K13IHZXBitwy
         x/1MBghzr5PAT7Uk/gKCmYNZoSVMITWSmN1KKHLAdSb01Ri1dHx8enX9azwkBNplaNrm
         zC4nZhDW3dcCK6E6Z70xKQs0igVZp2/hn+LpbVzM8be2EUWbfsVnTYCurNkT70vtTeU/
         lMcsi2E8Os7P/ItMbAPFG25i5CX9pWXuNHLVqUWEz9LY2FdXUwCIKDUVfpaDEnLjDkdj
         zXZ50CFex/IZNsqc38T404SETI0XO8uMIcfEYYp6lw5BqVWIa9/dHeBaoHWyKTSMtzeI
         CiAQ==
X-Gm-Message-State: AOAM533iy5suA6fV9fpluZNRHziuqhLxKDwODpBtKzkwQM7vGcHunHZa
        Y1IQk+v1TLJAqwm7Ca1PhjY=
X-Google-Smtp-Source: ABdhPJxPPdZcMkC3i2xXr1wTU6pvbxIQa35/4FyLUpTTXusaeWJI5o5fphhP99qp8jsXBkRALamK4A==
X-Received: by 2002:a05:6512:3087:: with SMTP id z7mr134699lfd.224.1617703507565;
        Tue, 06 Apr 2021 03:05:07 -0700 (PDT)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id y11sm2211287ljc.18.2021.04.06.03.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 03:05:06 -0700 (PDT)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Tue, 6 Apr 2021 12:05:05 +0200
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Uladzislau Rezki <urezki@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Hillf Danton <hdanton@sina.com>,
        Michal Hocko <mhocko@suse.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH-next 2/5] lib/test_vmalloc.c: add a new 'nr_threads'
 parameter
Message-ID: <20210406100505.GA1880@pc638.lan>
References: <20210402202237.20334-1-urezki@gmail.com>
 <20210402202237.20334-2-urezki@gmail.com>
 <20210402145934.719192be298eadbeecb321d2@linux-foundation.org>
 <20210403123143.GA38147@pc638.lan>
 <20210405193920.46d3792200ad05f4a7c66829@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210405193920.46d3792200ad05f4a7c66829@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2021 at 07:39:20PM -0700, Andrew Morton wrote:
> On Sat, 3 Apr 2021 14:31:43 +0200 Uladzislau Rezki <urezki@gmail.com> wrote:
> 
> > > 
> > > We may need to replaced that kcalloc() with kmvalloc() though...
> > >
> > Yep. If we limit to USHRT_MAX, the maximum amount of memory for
> > internal data would be ~12MB. Something like below:
> > 
> > diff --git a/lib/test_vmalloc.c b/lib/test_vmalloc.c
> > index d337985e4c5e..a5103e3461bf 100644
> > --- a/lib/test_vmalloc.c
> > +++ b/lib/test_vmalloc.c
> > @@ -24,7 +24,7 @@
> >         MODULE_PARM_DESC(name, msg)                             \
> > 
> >  __param(int, nr_threads, 0,
> > -       "Number of workers to perform tests(min: 1 max: 1024)");
> > +       "Number of workers to perform tests(min: 1 max: 65536)");
> > 
> >  __param(bool, sequential_test_order, false,
> >         "Use sequential stress tests order");
> > @@ -469,13 +469,13 @@ init_test_configurtion(void)
> >  {
> >         /*
> >          * A maximum number of workers is defined as hard-coded
> > -        * value and set to 1024. We add such gap just in case
> > +        * value and set to 65536. We add such gap just in case
> >          * and for potential heavy stressing.
> >          */
> > -       nr_threads = clamp(nr_threads, 1, 1024);
> > +       nr_threads = clamp(nr_threads, 1, 65536);
> > 
> >         /* Allocate the space for test instances. */
> > -       tdriver = kcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
> > +       tdriver = kvcalloc(nr_threads, sizeof(*tdriver), GFP_KERNEL);
> >         if (tdriver == NULL)
> >                 return -1;
> > 
> > @@ -555,7 +555,7 @@ static void do_concurrent_test(void)
> >                         i, t->stop - t->start);
> >         }
> > 
> > -       kfree(tdriver);
> > +       kvfree(tdriver);
> >  }
> > 
> >  static int vmalloc_test_init(void)
> > 
> > Does it sound reasonable for you?
> 
> I think so.  It's a test thing so let's give testers more flexibility,
> remembering that they don't need as much protection from their own
> mistakes.
> 
OK. I will send one more extra patch then.

--
Vlad Rezki
