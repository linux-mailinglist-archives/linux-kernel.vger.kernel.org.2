Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C04417D34
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 23:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244770AbhIXVrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 17:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbhIXVrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 17:47:49 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEFEC061613
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:46:16 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id r7so7334488pjo.3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 14:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pj9R2irEWaO0s1+n+LsLmweXYY63Hpa6KiQfqiA0N2E=;
        b=blNaN+UKBFauXCPwp7waJ+lVReCH+8D1Vxvu6ZpDLEYwbmXskSTlyi7u2crkunxzrv
         z60arbLXR5+C2OqJZxp9PgeOC+Ad1F+woM2GVGRzUeSXWM08Ev0qwLafjJSk2szllV1S
         ZAXAwx332SBfogEuG6yPs92Yj665v9+S27ifg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pj9R2irEWaO0s1+n+LsLmweXYY63Hpa6KiQfqiA0N2E=;
        b=nbgP0iP/qsvGAvKp4yZPMITW6ERXpT/tt4E7DBCCxzRGM2FGZxPGF9uWXxsL3+UBQ7
         U2qSap5BL8jPhAQflcA6HYIV9nP03sRPEZUUYE1fas7I3Ch43JtAomezQa/xZfG3UaA9
         d2iqG/tSmg0nC2ve9kS19DlrvllGbWQl3LxaIYycSsMkk3t9lt5UiIdvJ5ZpVdT2KQaP
         TpP2aPCA9PY9KtzgYHypqd6OXKKJJxIu3qFYMYXXsoQGZAV0sbRPiqg/oZunhZHe9sH3
         Oqn9J2ZTunfrsPqNbl13bWFafgW9L9nMv1pMQ63qUl8liA7qFGpPIFyJL7xao2zQbj8H
         QutQ==
X-Gm-Message-State: AOAM530caYfcDfpqR6oykRduc4bIZZ2Z8n3esPkcxOvLkmE0icdVAR3o
        U1IpU1lTRnDfF02HwxaJckHrZAIGb7/Ssg==
X-Google-Smtp-Source: ABdhPJyTj6m731cSp4Hd3lineRhJPbqmoPR3Z1ORTW1YqObWYHJWp28Pw5w+g61tc1vDtrl4YN13rQ==
X-Received: by 2002:a17:90a:ee82:: with SMTP id i2mr4752094pjz.166.1632519975624;
        Fri, 24 Sep 2021 14:46:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o15sm10414469pfg.14.2021.09.24.14.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 14:46:15 -0700 (PDT)
Date:   Fri, 24 Sep 2021 14:46:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joe Perches <joe@perches.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] docs: Explain the desired position of function attributes
Message-ID: <202109241441.20B7EE4B@keescook>
References: <20210924202302.2335542-1-keescook@chromium.org>
 <053717cf-e1b3-15a4-97e6-e72848f6d7bd@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <053717cf-e1b3-15a4-97e6-e72848f6d7bd@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 24, 2021 at 01:27:20PM -0700, Randy Dunlap wrote:
> On 9/24/21 1:23 PM, Kees Cook wrote:
> > +The preferred order of elements for a function prototype is:
> > +
> > +- attributes on the preceding lines
> > +
> 
> I thought that idea was already nacked: (it's more of a BSD thing AFAIK)
> (and I would NAK it if I could :)
> 
> """
> > Attributes should be on their own line, they can be quite lengthy.
> 
> No, no no. They really shouldn't.
> ""
> 
> from: https://lore.kernel.org/mm-commits/CAHk-=wjS-Jg7sGMwUPpDsjv392nDOOs0CtUtVkp=S6Q7JzFJRw@mail.gmail.com/

Right -- and then Joe and Rasmus had some convincing counter-arguments,
IMO. So, given the outlined Docs patch, I'd like to see what folks can
propose in the form of alternative patches for this topic.

I genuinely don't care. I just want to have something I can follow for the
refactoring of the allocator attributes. :) The trouble I had with Linus's
suggestion is that some attributes don't work[1] at the end for function
definitions, so I'm left unable to follow his recommendations too.

-Kees

[1] https://lore.kernel.org/mm-commits/202109211630.2D00627@keescook/

-- 
Kees Cook
