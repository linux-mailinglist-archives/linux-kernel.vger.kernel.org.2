Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90962347943
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 14:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbhCXNHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 09:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234072AbhCXNH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 09:07:28 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F82EC061763
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:07:26 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id e14so14537166ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Mar 2021 06:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=mV7IF4Zf53y3TdQylW1wrk3T3Y+1mcruUAtedXNvuTI=;
        b=Z7qLIADCJ3buoLJiKDQpTX9oXPKCCJqZCjOn1TDuz5YfpiI+4DDOZHOGE5Y5KNpG3r
         hZQsQZwIDf4BhYNItTSEcjX6BXZgYbGk8BiAlAgwiN5nH/ST3LTyxpfxFcJVoH/HFwu/
         cn7QkEGd7kjUhkomL3QDNnbxnzp28+xpekbj48IuLFKXliZPD+nLiGtRad6KK+nfltiu
         6Nrjb18I3HsS1hyVtGSXvp9EJuhvwKVOH7+YSVz6F+TJWpl2OEvBdyn3r4GQEIkdaNzL
         sxlWgH+wnk/tR+8NuwOXaDHy2nCrOaEjBeN1NqMAvbtCL0fQysHBulq2yJWFKlIkxv7R
         keMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=mV7IF4Zf53y3TdQylW1wrk3T3Y+1mcruUAtedXNvuTI=;
        b=DqnmGf3fKz1lxCbzOJUlmcmRjSJpZUN13/ZHioGCVhWFf535owmyfV4FvSzdaBHOod
         oYR7HP5nOy8LOUIgG/LCSslYvs8YlMzSRtFWi6AcWU/fIoc9xltddTi5rgqRlrDarNZE
         ktfbyGvpXLvkX2VttRRsRmhAVwS9lsFnnS0ehv3kalwdY5UFQkoG4QLad73IftWOGaxg
         u713Xf7g26r/Min/uWbn8mqRcA1No1nMuxQF9JkmPVmI1r1AYF5BmdkZcQkF5Fxtl1Mf
         JjypL5adCtiQjLQ0iHKYueldveKIbX46i42/o2JYD7OsY+HOh+xeuNOS2FwYXlSIx4GR
         Gbhw==
X-Gm-Message-State: AOAM533T+1Powx9Q602cotphyNdLB9wANdLvke/wGKaqUnL6dqyfz4so
        iBo5PWzspi2k2j4jDznFl+GT+pQtr/0EWQ==
X-Google-Smtp-Source: ABdhPJzrW9cXQCieJ9MyQWQ7DZcrzdK+g6LtX0IsZ3L48tXT1h32dboZmoAC5necVFGWa7VYA8NJug==
X-Received: by 2002:a17:906:cb18:: with SMTP id lk24mr3485521ejb.70.1616591245249;
        Wed, 24 Mar 2021 06:07:25 -0700 (PDT)
Received: from dell ([91.110.221.180])
        by smtp.gmail.com with ESMTPSA id c20sm913675eja.22.2021.03.24.06.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Mar 2021 06:07:24 -0700 (PDT)
Date:   Wed, 24 Mar 2021 13:07:23 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: intel_quark_i2c_gpio: enable MSI interrupt
Message-ID: <20210324130723.GN2916463@dell>
References: <20210323123433.45371-1-andriy.shevchenko@linux.intel.com>
 <20210323123433.45371-2-andriy.shevchenko@linux.intel.com>
 <20210324102931.GH2916463@dell>
 <YFsW26BH1LZM9ZBs@smile.fi.intel.com>
 <20210324104729.GL2916463@dell>
 <YFsgf9J+hQjfrZCb@smile.fi.intel.com>
 <20210324115033.GM2916463@dell>
 <YFsv6DijMMiv3D10@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YFsv6DijMMiv3D10@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Mar 2021, Andy Shevchenko wrote:

> On Wed, Mar 24, 2021 at 11:50:33AM +0000, Lee Jones wrote:
> > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > 
> > > On Wed, Mar 24, 2021 at 10:47:29AM +0000, Lee Jones wrote:
> > > > On Wed, 24 Mar 2021, Andy Shevchenko wrote:
> > > > > On Wed, Mar 24, 2021 at 10:29:31AM +0000, Lee Jones wrote:
> > > > > > On Tue, 23 Mar 2021, Andy Shevchenko wrote:
> > > 
> > > ...
> > > 
> > > > Also, past acceptance does not guarantee ideal/correct usage.
> > > 
> > > In this case it's hardly can be misused. But I heard you.
> > > 
> > > ...
> > > 
> > > > > The semantic is min-max range and having two defines (*) here for these seems
> > > > > to me as an utter overkill.
> > > > > 
> > > > > Of course, if you insist I may do it.
> > > > > 
> > > > > *) since value is the same, we might have one definition, but it will be even
> > > > >    more confusion to have it as a min and max at the same time.
> > > > 
> > > > It's just tricky to decypher for people who do not know the API, which
> > > > is most people, myself included.  For APIs like usleep_range() et al.,
> > > > obviously this makes no sense at all.
> > > 
> > > Seem like you are insisting. Okay, I will define them. What do you prefer one
> > > or two definitions?
> > 
> > Actually I'm not.  I'm just trying to get my head around where the
> > data comes from and what the values actually mean.
> > 
> > > ...
> > > 
> > > > What defines a vector?
> > > 
> > > The combination is solely of the driver-hardware. Driver explicitly tells that
> > > how many vectors it may consume (taking into account the range asked) and API
> > > returns amount given or an error.
> > 
> > So, where does the information actually come from?
> > 
> > Information that comes from a datasheet is usually defined.
> > 
> > Information that comes from the F/W is usually read and popped into a
> > variable.
> 
> It's a two way road:
> a) driver states that it needs only 1 vector and it's enough to it
> b) hardware must provide at least 1 vector to be served by this driver.
> 
> Look again into grepped output. Most of drivers that define it as an variable
> may dynamically adapt to the different amount of IRQ vectors. When it's static,
> usually drivers just hard code those values.
> 
> I'm really don't see a point to define them _in this driver_.

That's fine.  I just felt like I had to ask.

Would you consider a comment that lets people unfamiliar with the API
what the values mean?

Something to the tune of:

  "This driver requests 1 (and only 1) IRQ vector"

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
