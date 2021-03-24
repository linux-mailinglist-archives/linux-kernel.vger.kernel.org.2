Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F0E3477B8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 12:51:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232545AbhCXLuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 07:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbhCXLuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 07:50:37 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295F4C061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:50:37 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 12so12720028wmf.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=B8lKNNHcYDzBiG5sX8ZA6ZJAxSWnv5nMDR7ITPtKr5s=;
        b=TrBi/ZdmVZn3yEcPBipfPfikUvJ3W8nDR7rI8rHon07z3pyvKlAUolXMAknbft2ovM
         LqOD8h7JVhzMlb/fgbtRzGG4LTDnPqaZO7bug3u4MVyD2xx+4hZ+zR4Tr95+c182F2XH
         mbaAf3z7g3WMhiKZdBiSc/SbzPz7d2gV5cstwnDyFASVrtViSJpQxZkb1E+uYgrxjBe7
         AHrp7UAdguuzvfY1k5/+/nyfLQ6KQuR3BrTE4eA6axMZSf024G+CtHrM5rc59V/eBWpp
         qBKr1+1S6fAA6nwTwD5KFNwP7dOCbmS6nUPbqlV3uk1thnXASBaIU+5z4Oag3IgBOinb
         6qRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=B8lKNNHcYDzBiG5sX8ZA6ZJAxSWnv5nMDR7ITPtKr5s=;
        b=POswKapRTgJ9Skvj/onndgz2otF0QyfwLfQ4jTnfR2mY0XsmDsb+PMJHapJ/hT/kB+
         7xEJ3XD7vck1909yJYVGqAM5GR9x69H9IfNtS+8eeuGKeO8ts5tWPS5dlgiUN4+B1NMQ
         bdpV8kAJjJf6NI96o5rzRTfUo6idPnBmp4RlNLTF0mr+LinAzrILD2Mhi5HQY6nI+wEv
         oLMwnSwsjbsk+yk/DqdNII6YFJ626lhn/SvSuZkpkVdTy8BfJdvyyJ9MEFo+2UQC9JCo
         v5P0ZokA8EDxKHdhSuS4vhY9EB1j/lDtaFIYJ1whnnItvxekzr/PGxjqZ+T4cos3hoSI
         jnHA==
X-Gm-Message-State: AOAM531bMvQUJSywgcN6xS8679MLrW4gylB8SeoacBeZ20DY0RWZS8cb
        6CKZpqgjhLmFwbvIQ8wfg9b/aYFiFAHUkA==
X-Google-Smtp-Source: ABdhPJxgw9nQcijVntMFFCjU001iERbyPSAhRi/lqZ6m1R/rsIJOo+9EF9Gf2tWQ7/RDQV/t+JSN7w==
X-Received: by 2002:a05:600c:378c:: with SMTP id o12mr2543637wmr.69.1616586635839;
        Wed, 24 Mar 2021 04:50:35 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id u20sm3032212wru.6.2021.03.24.04.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 04:50:35 -0700 (PDT)
Date:   Wed, 24 Mar 2021 11:50:33 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <20210324115033.GM2916463@dell>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
 <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
 <20210324104729.GL2916463@dell>
 <YFsgf9J+hQjfrZCb@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFsgf9J+hQjfrZCb@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Andy Shevchenko wrote:

> On Wed, Mar 24, 2021 at 10:47:29AM +0000, Lee Jones wrote:
> > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > > On Wed, Mar 24, 2021 at 10:29:31AM +0000, Lee Jones wrote:
> > > > On Tue, 23 Mar 2021, Andy Shevchenko wrote:
> 
> ...
> 
> > Also, past acceptance does not guarantee ideal/correct usage.
> 
> In this case it's hardly can be misused. But I heard you.
> 
> ...
> 
> > > The semantic is min-max range and having two defines (*) here for these seems
> > > to me as an utter overkill.
> > > 
> > > Of course, if you insist I may do it.
> > > 
> > > *) since value is the same, we might have one definition, but it will be even
> > >    more confusion to have it as a min and max at the same time.
> > 
> > It's just tricky to decypher for people who do not know the API, which
> > is most people, myself included.  For APIs like usleep_range() et al.,
> > obviously this makes no sense at all.
> 
> Seem like you are insisting. Okay, I will define them. What do you prefer one
> or two definitions?

Actually I'm not.  I'm just trying to get my head around where the
data comes from and what the values actually mean.

> ...
> 
> > What defines a vector?
> 
> The combination is solely of the driver-hardware. Driver explicitly tells that
> how many vectors it may consume (taking into account the range asked) and API
> returns amount given or an error.

So, where does the information actually come from?

Information that comes from a datasheet is usually defined.

Information that comes from the F/W is usually read and popped into a
variable.

It's usual for values (other than things like timings) to be issued
'raw' like this.  Particularly as an argument of a bespoke API.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
