Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C5E2326EF8
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Feb 2021 21:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230086AbhB0Uw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Feb 2021 15:52:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhB0Uwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Feb 2021 15:52:54 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424B7C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 12:52:14 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id o38so8461792pgm.9
        for <linux-kernel@vger.kernel.org>; Sat, 27 Feb 2021 12:52:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iCzhTX7/J8HDQ1NmWTMdWfXjqfGCQtFahBty74znwas=;
        b=bhR2WP0pAVjerTSc3Rgc0a6ag6fD1FIwlK5OasyrGOmEs5qUpPYQHB2tOjhkS6+fc2
         859p06Z6DP1gtVh6ncx1lDLCHFguWhixSY8MaYQ84AzHci6WffISq2cKUg/5pkw9Yhyt
         ZfSmHTVP36H8PoLttcRMKsITjjZ+ldS55n1gqqvTSfwBP5UIcoadqmtvT7N8MuWb7aUB
         FErkDr7cMDHUDvQebKhHbGCpYuinji9Pf+dLIM1Y1/t9/OCV6VRAd49iY1yhQE12boGg
         opXZ+4SMwMnt58d0NLxBfgNSa1pEiaNuCINUqgM2yXoO3z6BfdlUoCzo3BlOow2Hxq+9
         Y2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iCzhTX7/J8HDQ1NmWTMdWfXjqfGCQtFahBty74znwas=;
        b=g0+sYshjmsWSD3lfWCdkNovozbarkv5huBMEIjYP8Fo3P1r0UUo7ZQM71XGgMBJ6Q1
         dVk5UghOm/1HokQD2tgwrGywCo3WJrusvIC4QXwWgsf6ivp067n+gJXisumWiaonFH+B
         0b4+Lp0SVGsmvbQwZNVvuYFQVvd+4hLUDD4+Hs+qfYfctnsmSwLfbZMpYDayOTD4+hpi
         kwyWX5to+7dRHS1Uiete8AhwQBUdESO9cFitmEFtUgdXG5M4ALzr+ZCFS+IPjl5tZZCY
         QHvk42d4QNsYIdZRyLMIQPnitNayg1PCm8CIzpQ712VrBWyw60ZtaiqR84OdVh74NPd0
         7YlQ==
X-Gm-Message-State: AOAM530rUlSdkpSE9RtXC6zqzelAXcpCmhHYAdZ5ADd4NCTtldFg8Wtr
        HnfnlNHvR08oOLcUfQGZbDQNoA==
X-Google-Smtp-Source: ABdhPJwIUTl7xvSqFvF7pALtDLpFq8SMPiddit6YCRp3lTejTLgNoH4UqOhZFykBAvPKRzFw3aE6bQ==
X-Received: by 2002:a63:2110:: with SMTP id h16mr8015755pgh.441.1614459133593;
        Sat, 27 Feb 2021 12:52:13 -0800 (PST)
Received: from xps15 (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id 192sm10432202pfx.193.2021.02.27.12.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Feb 2021 12:52:12 -0800 (PST)
Date:   Sat, 27 Feb 2021 13:52:09 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Mike Leach <mike.leach@linaro.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Coresight ML <coresight@lists.linaro.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        "Suzuki K. Poulose" <suzuki.poulose@arm.com>,
        Yabin Cui <yabinc@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 02/10] coresight: syscfg: Add registration and feature
 loading for cs devices
Message-ID: <20210227205209.GA3631443@xps15>
References: <20210128170936.9222-1-mike.leach@linaro.org>
 <20210128170936.9222-3-mike.leach@linaro.org>
 <20210219184313.GA3065106@xps15>
 <CAJ9a7Vhh5xdbmMgcTLjU3qJEg2nbZoZ5j2HqvenwNGoqo+54Rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7Vhh5xdbmMgcTLjU3qJEg2nbZoZ5j2HqvenwNGoqo+54Rw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 26, 2021 at 07:14:32PM +0000, Mike Leach wrote:
> Hi Mathieu,
> 
> On Fri, 19 Feb 2021 at 18:43, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
> >
> > [...]
> >
> > > +/**
> > > + * List entry for Coresight devices that are registered as supporting complex
> > > + * config operations.
> > > + *
> > > + * @csdev:   The registered device.
> > > + * @match_info: The matching type information.
> > > + * @ops:     Operations supported by the registered device.
> > > + * @item:    list entry.
> > > + */
> > > +struct cscfg_csdev_register {
> > > +     struct coresight_device *csdev;
> > > +     struct cscfg_match_desc match_info;
> > > +     struct cscfg_csdev_feat_ops ops;
> > > +     struct list_head item;
> > > +};
> >
> > I would call this structure cscfg_registered_csdev and move it to
> > coresight-config.h.  That way it is consistent with cscfg_config_csdev and
> > cscfg_feature_csdev and located all in the same file.
> >
> 
> I was trying to separate structures that are used to define
> configurations and features, with those that are used to manage the
> same. Hence, most things in coresight_config.h define configurations,
> or their device loaded instance equivalents, and things in
> coresight_syscfg.h are management items. I am happy to change the name
> but would prefer is stay in coresight_syscfg.h

Ok

> 
> Thanks
> 
> Mike
> 
