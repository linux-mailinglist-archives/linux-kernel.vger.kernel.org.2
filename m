Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C237375FAF
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 07:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhEGFZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 01:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbhEGFZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 01:25:35 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8202DC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 22:24:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r9so11673654ejj.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 22:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mTswA7TxkLz2ZKoHO2mvsg5Jh3THgEZWbkZV/ryZGDM=;
        b=JJkXQOvsqTer4/VMMjtYLKifk1xeYb/rsb2GOLGIgvpQeTPLESWqRlA2nvvxzXFL4Q
         JczCOUKcO80JXZV1fX76oHO+bAcRMW4K8aNIDCZZMOTFk8N4SuyW1wC/QzFiU4H2QeXL
         LprAQaRVtrulZdxek33wejDhlq3nWYbyD7c81P3XoFKdrztsdIsNKxXmCTj4InFi68vd
         CMExoMhaBFehXCrhO6X8i+B68SlQ9fF1d1MCmlrr48PKsIxOUdwFb5wj/fTp5qmkqJF6
         UQ3xrdXUsypdIZKQW4C9HGWtOpbMlCSVftONxLD8BJB2UNJYaiYZSKapiNxsZjZGMS2D
         g+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mTswA7TxkLz2ZKoHO2mvsg5Jh3THgEZWbkZV/ryZGDM=;
        b=Q6O/aMM+CcvP1kF6/ZTM5jVsTyNr+jPtiprOBGe8nLaPYwqWfR+8YxBpoaVfxVlyG6
         gnJyNX8Uh+6nqcvOo+LVTdsrWihJAgCrTMtgi8P8h8MRUf2Qiy6Xsn6+bzm+KUElxQKS
         ToBs1QGTyPY8fH5yP4+QuZNaSgJ+eRHjsCdzoZfZNto0Ed/NjgR77sGTnEDMHepezsPQ
         1XCYqVnrkePJaiFY93GDLoU89UYaCsS9BsntDRoBUX91zHpmhWe0iC1wwkzAhomFToa4
         DD1JYLG484b52Ji5pnWVq0PYUcf0gKvoGFe/BsFXBSwKnGoTtGDP40gs4CwUwiT6UTsg
         xagQ==
X-Gm-Message-State: AOAM5303GF/wwXhVczZlKbpUHdKusMcMIghcgRYT25wzrfiDOzvlKvw/
        sLZoA7fQlkD8bRJrjqtqjw==
X-Google-Smtp-Source: ABdhPJw35KJ/nHSPJcYiy3n8WSrCWRM6VRCjNkmWuj1AhbixVsC4oHhr4Q26qfX8eiNzRejupTP4Sg==
X-Received: by 2002:a17:906:6ad0:: with SMTP id q16mr8278349ejs.286.1620365075291;
        Thu, 06 May 2021 22:24:35 -0700 (PDT)
Received: from localhost.localdomain ([46.53.252.104])
        by smtp.gmail.com with ESMTPSA id o8sm2674530ejm.18.2021.05.06.22.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 22:24:34 -0700 (PDT)
Date:   Fri, 7 May 2021 08:24:33 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch 04/91] proc: save LOC in __xlate_proc_name()
Message-ID: <YJTPEXsvTs7QXIBx@localhost.localdomain>
References: <20210506180126.03e1baee7ca52bedb6cc6003@linux-foundation.org>
 <20210507010213.V8MhqooKS%akpm@linux-foundation.org>
 <CAHk-=wjKQZczi-J0rEUoPS+=Q6gCSpr3UmWzh-L8Qs9WGGUHuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjKQZczi-J0rEUoPS+=Q6gCSpr3UmWzh-L8Qs9WGGUHuA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 07:24:36PM -0700, Linus Torvalds wrote:
> On Thu, May 6, 2021 at 6:02 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > From: Alexey Dobriyan <adobriyan@gmail.com>
> > Subject: proc: save LOC in __xlate_proc_name()
> ..
> > +       while ((next = strchr(cp, '/'))) {
> 
> Please don't do this.

It is actually how it should be done.

Kernel has such code in other places

	#define hlist_for_each(pos, head) \
	        for (pos = (head)->first; pos ; pos = pos->next)

And we do check pointers for validness like this

	if (ptr) {
	}

"while" loop is no different.

> Yes, gcc suggests that double parentheses syntax around an assignment
> to avoid warnings.

I never saw this warning. I just wrote double parenth knowing the
warning will be emitted. It's an old warning.

> gcc is wrong, and is being completely stupid.

> The proper way to avoid the "assignment in conditional" warning is to
> (surprise, surprise) USE A CONDITIONAL.
> 
> So that
> 
>           while ((next = strchr(cp, '/'))) {
> 
> is the crazy rantings of a misguided compiler. No sane human should
> ever care about some odd double parenthesis syntax. We're not writing
> LISP, for chrissake.
> 
> The proper way to write this is
> 
>           while ((next = strchr(cp, '/')) != NULL) {

This NULL is redundant in the same way "if (ptr != NULL)" is redundant.
Even more so in C where comparison can't be overloaded.
You don't even save the parenth.

> which makes sense to not just a machine, but to a human, and avoids
> the whole "assignment used as a conditional" warning very naturally.
> 
> See? Now it uses a conditional as a conditional. Doesn't that make a
> whole lot more sense than the crazy ramblings of a broken machine
> mind?
> 
> I fixed it up manually, I just wanted to rant against this kind of
> "mindlessly take advice from the compiler without thinking about it".

Whatever-by: Alexey Dobriyan <adobriyan@gmail.com>
