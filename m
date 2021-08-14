Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 583163EBF64
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 03:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236408AbhHNBph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 21:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236284AbhHNBpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 21:45:36 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EC3C061756;
        Fri, 13 Aug 2021 18:45:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id fa24-20020a17090af0d8b0290178bfa69d97so18610876pjb.0;
        Fri, 13 Aug 2021 18:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=07FaLwcmmX6AOmFfgsqh6GrkV1dN1p5dJytNMnSho7U=;
        b=YlbngJoJ3f8Vv11tmVmRDAe/WJz03jxqYRsj4VIzgBv/GSyKCJ89pqGU7imCYjqdX1
         rK+MQVg4YM6okfXTtPjYEH5mzwHgA3vpygUR2LKTUX1lkNAwOdsfCWtf3K0zQxPLOW7p
         8Jc6TY3ib3/PEB2Cef6wlVzKPFRR3Y2rz5pfBRpLrLail0dbtMQB21AnyNxbw4Fm5DnT
         gDL1wTnJnArvUrXGYsbu0bQH/PFkxrx7nCQF5ps2x6zvzLlAnuFi8hCHdjostQQ943G7
         LMr21rZOdKSkvc/s7SyYOQDS9+XlyUQe/Kcahzxqjv1Vq44VVnAvjabKLIeVnjv4BXqR
         AnkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=07FaLwcmmX6AOmFfgsqh6GrkV1dN1p5dJytNMnSho7U=;
        b=lCquCkrbg+X65lKh8xCgAQT5+JENgQMJ5bpvcssI4LKFKKuLowUYEj/Wtud6YTRqVm
         c4BHj7p4yrp81ru8ex21Gc8mfF3oRghfGnvUXBdc+sgspjAxaPAL0e+UNjrQwaHGDWl/
         7vzlsXM6ZgrL7akExwpzPwgPbpkt6O/Xh1iUHBbfrTM7wbnB+H21SeZW/H0I+AsIS0oB
         aZRnx5aiJ1ESlKTFbecQiu1yUjDZuTet1dd1CJ/KRnV2zGLTzLNQKJ1U5J0Dx4mksPtL
         gNdbjwKBdck+/6nxeKwJEyHWCfXMlyt3Mb8sMncqagGuJjN7A5QDwkuYuAAm3hK6Uh7j
         axBA==
X-Gm-Message-State: AOAM530nkU7DcIbuLNf/l6UylDtPuwXrRFzKRrG1+xzg62DJA/DeK0w1
        VeE4goqLVwNCdGcepuDnTVo=
X-Google-Smtp-Source: ABdhPJwvkHis4sOBiqm/ITKlGQRBIYW3ndn3dGo/AJ/jO3TNHJK7n5l4YvlKXA2L3qMWsvqac+Zi7w==
X-Received: by 2002:a63:1e4e:: with SMTP id p14mr4804871pgm.261.1628905508159;
        Fri, 13 Aug 2021 18:45:08 -0700 (PDT)
Received: from mail.google.com ([141.164.41.4])
        by smtp.gmail.com with ESMTPSA id u20sm4298718pgm.4.2021.08.13.18.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 18:45:07 -0700 (PDT)
Date:   Sat, 14 Aug 2021 09:44:55 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: in_irq() cleanup
Message-ID: <20210814014455.wffdzvtgz54y6mgn@mail.google.com>
References: <20210813144713.85598-1-changbin.du@gmail.com>
 <87o8a1xsbn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8a1xsbn.fsf@meer.lwn.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 13, 2021 at 09:44:28AM -0600, Jonathan Corbet wrote:
> Changbin Du <changbin.du@gmail.com> writes:
> 
> > Replace the obsolete and ambiguos macro in_irq() with new
> > macro in_hardirq().
> >
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  Documentation/kernel-hacking/hacking.rst                    | 2 +-
> >  Documentation/kernel-hacking/locking.rst                    | 4 ++--
> >  Documentation/translations/it_IT/kernel-hacking/hacking.rst | 2 +-
> >  Documentation/translations/it_IT/kernel-hacking/locking.rst | 4 ++--
> >  Documentation/translations/zh_CN/kernel-hacking/hacking.rst | 2 +-
> >  5 files changed, 7 insertions(+), 7 deletions(-)
> >
> > diff --git a/Documentation/kernel-hacking/hacking.rst b/Documentation/kernel-hacking/hacking.rst
> > index df65c19aa7df..f514cec8e16b 100644
> > --- a/Documentation/kernel-hacking/hacking.rst
> > +++ b/Documentation/kernel-hacking/hacking.rst
> > @@ -77,7 +77,7 @@ fast: frequently it simply acknowledges the interrupt, marks a 'software
> >  interrupt' for execution and exits.
> >  
> >  You can tell you are in a hardware interrupt, because
> > -:c:func:`in_irq()` returns true.
> > +:c:func:`in_hardirq()` returns true.
> 
> While you're in the neighborhood, can you please get rid of the :c:func:
> markup?  We've not needed that for some time now; simply saying
> in_hardirq() is sufficient.
>
No problem, will updaate it soon.

> Thanks,
> 
> jon

-- 
Cheers,
Changbin Du
