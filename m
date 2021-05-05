Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC009374706
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234900AbhEERlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbhEERhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:37:13 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AFB0C04BE5B
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:08:07 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p17so1163762pjz.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 10:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=KqluyOf0v1Nfvw8tjGqNoVG2n8oF6SCT4knHdkJWdw8=;
        b=rQOS41TIPlQG5WalvX2KW0aggD6QWtRn7Cac+JrNjjU4tOtHDmXvDCAB0Uszi15xOL
         OyIGY6jSIFuE7lw/R4QjotkHvMtJa/lRy+fy/sW7aTLpQZC452jbHoGgoiUm113X5eqR
         6QECMGmgs4AvDVwaLGUx3mxZ+EPhUbtYDadW7Fh7l5R7k0uLz2Cf1V87BQqK6MEvNBIa
         KcJGcMdGu16C6PnOLBHKcqfXDhwS7IYP4ZwyOhjDsXGpX7bRnwyBugcYbQT0NOmvmIN8
         TKFW9gtVDiRaUS5t1ys7S7FxUQhFqTnHljceapXECDwpQ7UnK8hlSzJmhm1UqHMwuJOs
         P6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=KqluyOf0v1Nfvw8tjGqNoVG2n8oF6SCT4knHdkJWdw8=;
        b=SSVvATnHARQkPUAao8VOUIyPxA16AM4C5GbhQjOwGsSqtI9dytZo0AEDTRiFh7Wn0Z
         tA8aSgTgfAWNuQ8h9IYxTDrU/XvYRRyjHlEgsGaE3BaD09WB4jkUTGpQoj+/koaLha5/
         IbabnxO2fu00DAgXpHNQNVUPXXGl4KH3pqzAWmMlSzfhD6QE2Dp3OlgHf8/bVXnd92WY
         /q0fYTwBKS2saa+vnViKYedPJ4fVWlcu9XUhPJBV/mFawfYVrYLaQCBjZWXyDBefi0X1
         Xss2nH4//YugGeopJrxK78PLZGYdC4Z3BBtOmzq+0qPqHYiIia7Ig3Gu9QhnFxEUTCsR
         jyIw==
X-Gm-Message-State: AOAM532wiY3e4z+0KLCTWFL67WkMJOBWVYlZzwAQAJREGBmxL9chuFJ6
        CSXNMxRnGBNGEJFi5IHKbcbY9Q==
X-Google-Smtp-Source: ABdhPJx312lbW6tgvqqvI1A8dmQe2ssQyXiW13Spas4G8E74K6JFnYAzdraGylncRKHxnbDhDfRmJA==
X-Received: by 2002:a17:90a:fa0e:: with SMTP id cm14mr12548463pjb.59.1620234486823;
        Wed, 05 May 2021 10:08:06 -0700 (PDT)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id f14sm9039081pjq.50.2021.05.05.10.08.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 10:08:06 -0700 (PDT)
Date:   Wed, 5 May 2021 11:08:04 -0600
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Arnaud POULIQUEN <arnaud.pouliquen@foss.st.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] rpmsg: char: Remove useless includes
Message-ID: <20210505170804.GC1766375@xps15>
References: <20210429080639.6379-1-arnaud.pouliquen@foss.st.com>
 <20210503174238.GD1699665@xps15>
 <b2f6b9ca-9dc2-920b-941d-175779bc1034@foss.st.com>
 <20210504170530.GD1734971@xps15>
 <7170fdd0-00cd-1486-7b4c-41040ecfff6f@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7170fdd0-00cd-1486-7b4c-41040ecfff6f@foss.st.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 08:20:25PM +0200, Arnaud POULIQUEN wrote:
> 
> 
> On 5/4/21 7:05 PM, Mathieu Poirier wrote:
> > Hi Arnaud,
> > 
> > [...]
> > 
> >>
> >> I started by this one and then I got carried away tested the other include...
> >> You are right, I just don't follow her the first rule of the "submit checklist"
> >>
> >> "If you use a facility then #include the file that defines/declares that
> >> facility. Don’t depend on other header files pulling in ones that you use."
> >>
> >> That said I just have a doubt for uapi/linux/rpmsg.h that will be include
> >> by rpmsg.h[2], as these includes are part of the rpmsg framework API, should we
> >> keep both, considering the rule as strict?
> > 
> > I red the last paragraph several times I can't understand what you are
> > trying to convey.  Please rephrase, provide more context or detail exactly where
> > you think we have a problem.
> 
> There is no problem, just a question before sending an update.
> 
> As you mention the #include "rpmsg_internal.h" line can be removed, I plan to
> send a patch V2 for this.
> 
> That's said before sending a new version I would like to propose to also remove
> the #include  <uapi/linux/rpmsg.h> line.
> 
> The rational to remove it is that include/rpmsg.h would already include
> <uapi/linux/rpmsg.h> in 5.13 [2]. And looking at some frameworks (e.g I2C, TTY)
> the drivers seem to include only the include/xxx.h and not the uapi/linux/xxx.h
> in such case.
> 
> So my question is should I remove  #include  <uapi/linux/rpmsg.h> line? Or do
> you prefer that i keep it?

Thanks for the clarifications, this is much much better.

Less changes is always preferred, so unless there is a clear guideline or a good
reason to make a change I would prefer to keep things the way they are.

> 
> Hope it is more clear... else please just forget my proposal, I wouldn't want
> you to waste too much time for a point of detail.
> 
> Thanks,
> Arnaud
> 
> > 
> > Thanks,
> > Mathieu
> > 
> > 
> >>
> >> [1] https://www.kernel.org/doc/html/latest/process/submit-checklist.html
> >> [2]
> >> https://patchwork.kernel.org/project/linux-remoteproc/patch/20210311140413.31725-3-arnaud.pouliquen@foss.st.com/
> >>
> >> Thanks,
> >> Arnaud
> >>
> >>>
> >>> Thanks,
> >>> Mathieu
> >>>
> >>>>  
> >>>>  #define RPMSG_DEV_MAX	(MINORMASK + 1)
> >>>>  
> >>>> -- 
> >>>> 2.17.1
> >>>>
