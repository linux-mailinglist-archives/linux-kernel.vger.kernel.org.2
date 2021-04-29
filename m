Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F1836EA05
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 14:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhD2MIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 08:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233337AbhD2MIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 08:08:22 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8123DC06138D
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:07:34 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id q6so18970385edr.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Apr 2021 05:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=E/qBmN3w5ra6vzERr1tAnJ+lRCifYP6wOJclMHfbmgA=;
        b=lga51PiHQT8AXJaHF9E+Rcm2L7rBLdrZM+LDIobxpUfFnTW7kT866PFjvaeamdIvSy
         oBD2mFz5kUbvDDg4P1Cg8yPYTBWvdZXO8RsJJc4oXIOxDg45gU7vEzM++OrTbHtzNBQe
         rC2SSb7iC4kcW17d3a11uA/rozz2QvFI0F4cEh0FnZAyP5OZleb0yDhj4BCF+ftMk3Z2
         byiuS7kh6koeNRV86e+Fxnw26SAom3jTRnzAe7a1jiU//Uxf7d/j2wCkKENOuPXiF9NE
         sQo2naXTvrxYe3K2YjKBJZmVXEjw0DZOLtjyFBFtm43mMQaypu7hcZmaQQTtedC9OPKp
         4onw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=E/qBmN3w5ra6vzERr1tAnJ+lRCifYP6wOJclMHfbmgA=;
        b=eCntQ8uGcwHTUXXkg7gDMSpBXK08o6uk1T2Q1O268A/pKpNKb1RsQUkyqGjfQ0U2jR
         EgrUZ+Gh5KWeQBpFGjsDFrherPNFGk3+ufakPS7HA8we3l7JIUbtr4i3xF4Hx7qITBBh
         ODUPTlhvDEvlE3cTniwyOLDL04JwoggkP4z1LGWLSW2wz5EKKKd0rWP3SBnKOmqL7pva
         nsxhI5TbX3P+hIJW5cp8uMKA/hdADnfCZVMM5UnqLKmoHYY/nmoC92448MIVGCOXZfNc
         1bFLHJDKvbiKzDUMqUj1IDAEiOw3GWXkrmthrNL/i4qW7cInW2IOGiRhdIxH9jR8o+vb
         LI+A==
X-Gm-Message-State: AOAM530vFtItzOzSpj09mVxW7F46OT6cpuSA+o6ZWWVh+s1QzdvLZH2u
        SgYW9y73RqTbAS+28Gl0DOo=
X-Google-Smtp-Source: ABdhPJw4JTYkFThXioPmy2z8+WuiLOKSdz69LpPJsZTBZxAQhtylaDEIj8mQzdkT/FBSuMgnjrWcJA==
X-Received: by 2002:a05:6402:78b:: with SMTP id d11mr10066481edy.257.1619698053629;
        Thu, 29 Apr 2021 05:07:33 -0700 (PDT)
Received: from agape.jhs ([5.171.72.170])
        by smtp.gmail.com with ESMTPSA id c25sm2184909edt.43.2021.04.29.05.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Apr 2021 05:07:33 -0700 (PDT)
Date:   Thu, 29 Apr 2021 14:07:30 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy-kernel@googlegroups.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] [PATCH 1/2] staging: rtl8723bs: hal: Remove
 set but unused variables
Message-ID: <20210429120729.GA1393@agape.jhs>
References: <20210428113346.28305-1-fmdefrancesco@gmail.com>
 <YIqECQk/1Zb4JRjb@kroah.com>
 <20210429102201.GF1409@agape.jhs>
 <1870536.WTzYeaBcXf@linux.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1870536.WTzYeaBcXf@linux.local>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Yes, but many types of hardware _REQUIRE_ reads to do something.  So
> > > "read that does nothing" is a requirement for some operations.
> > > 
> > > As an example, a write is only guaranteed to have been finished if you
> > > do a read of the same location back from it on some hardware busses.
> > > The bus can reorder things, but a write/read of the same location can
> > > not be reordered.
> > > 
> > > Sometimes you have to do reads multiple times to get things to "stick".
> > > 
> > > Other times reading from a location changes a state in the hardware
> > > (horrid but HW designers aren't the brightest at times...)
> > > 
> > > So you can NOT just remove reads without knowing that the hardware does
> > > not require this.  This is an issue where GCC "warnings" mean nothing as
> > > gcc does not actually know what hardware does, or does not, do for many
> > > things.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > thank you for explanation, my hardware knowledge is poor:(
> > Sorry for noise.
> > 
> > fabio
> >
> I suspected that removing those variables could have been a source of troubles 
> (but I was thinking of possible side effects on internal kernel's data, not of 
> hardware related idiosyncrasies), however I think that you did well to point 
> it out because:
> 
> 1) We learned something new from Greg;

yes that's been very good for me

> 2) I learned that, for the purpose of finding definitions, vim's ctrl-] is not 
> the right way to work out the problem.

3) I learned that with ctrl-] in vim one could (in some misterious conditions)
   see a function definition :-D

It seems that you know more than me about vim, I make intensive use of grep
for finding function defs and usages in code.

> 
> If you have time, I'd appreciate some comments on the topic of line (2).
> 
> Thanks,
> 
> Fabio
> 
> 
> 

thank you,

fabio
