Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEB0635DC2A
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 12:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243668AbhDMKIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 06:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240752AbhDMKHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 06:07:52 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BE8CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:07:30 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id g18-20020a7bc4d20000b0290116042cfdd8so10323336wmk.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 03:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bsZsq5YfwrnQLUZc0VDsOOICMjGBzW9IErtRWmW7VlI=;
        b=X8t0d4vOS3dFvsZvYFC0bFdfGc4Rm2x0mBOnGu0YvNXGmzsGn5q9WgnaBcGJUY7zYr
         IDYOg6jpVllDN3JCdQWqgkejPd5dBg2j8y+03CIAvb9a+CC5+2wvx58A/aP4wN/u5O3C
         6dkrW4bI/RghaF3q9OLGsRd9V4/Skkg1ZJ1VA+GAaWLYiW92gt2AfbrktYsUtUvoKjf1
         v3SmqzuivKFQLt9T53j4F/jM47e0dhw6J3Gp/wNClND3f5H1m+U6a/VbG3AcVPaB9i5S
         Rv6m9fRC9MtwW31fjKW1LP0VA8wOH8RCpKQfBrUWQ/E787yjuJrIvhEXqEfdq00FrhZ8
         0xIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bsZsq5YfwrnQLUZc0VDsOOICMjGBzW9IErtRWmW7VlI=;
        b=bOCUi1iij3laOm7AF77lkZZYS2DgUo9UsyVjmEqCyz2TphY12W8nT5BsBPLcZXsiZB
         lZ0JHt/cpVxE7zV2ruiD/d0HGp4qPIix6K8focjKffJ0PCsN6mh+y7dHUwQBkmqt26H0
         i41z20Dx/zrFNDZLQKg2iO48f9FC1eTFY8yt+ZI62jJ/K8f/hktFeE91Rl9XFCaLx/YO
         mCVJZyUvxxvtyfREe3dSjVUs8pd6s2Az4iPZZkkvqOYuJk8S6Lv7Ci3zuihcS8iZhz5B
         iL4WLsfKaP7Ll6S8nENU4bbqGuBzh154CjWzOtCdEknJbBTFLdDm/6P101/VoyVB2Snx
         t+KA==
X-Gm-Message-State: AOAM5327Zcn1hughb7plY7S8YXtG/bzZetKATXUFgtGoiKOGnBz+srT0
        ds21iLZ3EBIKFanoGLFo1Pb/HaTTXjtWwg==
X-Google-Smtp-Source: ABdhPJw5brg58l/WXx/7PqhFNrKZQAqpLm27+qQUqXZjQ4IYSYrkq6ADt6Nn14YDZY3zlCMKrFgj3w==
X-Received: by 2002:a05:600c:2dc8:: with SMTP id e8mr769839wmh.10.1618308449352;
        Tue, 13 Apr 2021 03:07:29 -0700 (PDT)
Received: from agape.jhs ([5.171.81.143])
        by smtp.gmail.com with ESMTPSA id a2sm3304132wrt.82.2021.04.13.03.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 03:07:29 -0700 (PDT)
Date:   Tue, 13 Apr 2021 12:07:26 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     gregkh@linuxfoundation.org, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: cocci script hints request
Message-ID: <20210413100725.GC5477@agape.jhs>
References: <20210413090400.GA5477@agape.jhs>
 <alpine.DEB.2.22.394.2104131154100.2872@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2104131154100.2872@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 11:56:20AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 13 Apr 2021, Fabio Aiuto wrote:
> 
> > Hi,
> >
> > I would like to improve the following coccinelle script:
> >
> > @@
> > expression a, fmt;
> > expression list var_args;
> > @@
> >
> > -       DBG_871X_LEVEL(a, fmt, var_args);
> > +       printk(fmt, var_args);
> >
> > I would  replace the DBG_871X_LEVEL macro with printk, but
> > I can't find a way to add KERN_* constant prefix to the fmt
> > argument in the + code line. If i try this
> >
> > @@
> > expression a, fmt;
> > expression list var_args;
> > @@
> >
> > -       DBG_871X_LEVEL(a, fmt, var_args);
> > +       printk(KERN_DEBUG fmt, var_args);
> >
> > plus: parse error:
> >   File "../test.cocci", line 94, column 20, charpos = 1171
> >   around = 'fmt',
> >   whole content = +	printk(KERN_DEBUG fmt, var_args);
> >
> > how could I do this?
> 
> Although I certainly agree with Greg, I'll answer the question from a
> technical point of view.
> 
> I'm not sure that that kind of compound string is supported for a
> metavariable.  It is possible to get around this problem using a python
> script.  If you ever need to do this for a better reason, you can take a
> look at demos/pythontococci.cocci in the Coccinelle source code
> distribution.
> 
> julia

thank you, this helps a lot!

fabio
