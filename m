Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6193E3EFC44
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 08:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238324AbhHRGX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 02:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237947AbhHRGX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 02:23:56 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B2EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:23:21 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id b15so2670966ejg.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 23:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OtuTHgk1vpqukCNNGvb6/1jnVEMLRfbzK5iP4DPgChc=;
        b=USJwsT0QGrIMRQazK6too1bYjc1/Jr6MZpIJhiprZhMs9JWgurShMOdabEiA68Lp2N
         MPWIHF6t9cOMkm9A/e+p9Xlslq+EJcFSCiO45bK5aX5+E5LcclT1ymONdwm93OMPT3Tc
         0OgV0CLW2VIQ7gvdVdfLPTzXTc2vJAck3jCRHOxbRS7FaekfGd0j2fqAmDqk8lYFP5Xv
         MIsdkA3YtTNVFBkRVsB+zc5NxKEl7TREkRLYk2loK45b2r0dzFv0l1zEBaRvmq+GQgIP
         YkvqkZ7Zi3chTbay3j3YuMaTXZlFPUdci50JXGhg3ZPLFvv4q59boXGSuD8uYg4Ov3tA
         Jndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtuTHgk1vpqukCNNGvb6/1jnVEMLRfbzK5iP4DPgChc=;
        b=fq1aiTN7vsISW+K/xuOJskzuxhpQklE+nvPGkADNsMQe83Z2fIJMmZwOS2VlxodknC
         D/eL79cldlDr6W6UeUU9SEFyPRVN3683VY8yZ5T+UFMPTO/LL4dw28doTGeWkDLx60Kp
         oKGzTbkc/EpE82fKpG6qqbau+k6B4z4ZE4nv4vX+EOW/Sa0M2gxFgcBqudzn42/V1ogj
         Uo9ncjlg6uabFSdNbwypDndQu7uEaQQ8NofUIgpcf82ic9jgQmz2xtK2CyalM1m0/iWp
         lIVxlE6t+7LwqZxWdk6VTYV8+G8/RTSmobO3Q3K4mq+OM/nYMGWpTL1SUOXdRuFXO7OC
         txYQ==
X-Gm-Message-State: AOAM531HQgm5Qm/IVXBk74zuRnykcyyQ0pqMZENMycK3qFYXYdpZWghO
        XaptKQi9HleQ+aL8bE53eIs=
X-Google-Smtp-Source: ABdhPJxjfwat/n+QRrqqUm5kAjo8tQ+A40RJTEcBVq/E0MOXa9s+GDtTlSt9MEmg/WQhabWfhIGTgQ==
X-Received: by 2002:a17:907:2cf1:: with SMTP id hz17mr2892026ejc.438.1629267800444;
        Tue, 17 Aug 2021 23:23:20 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id e22sm2054955eds.45.2021.08.17.23.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 23:23:19 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Joe Perches <joe@perches.com>, Greg KH <gregkh@linuxfoundation.org>
Cc:     Michael Straube <straube.linux@gmail.com>,
        Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: refactor rtw_is_cckrates{only}_included()
Date:   Wed, 18 Aug 2021 08:23:18 +0200
Message-ID: <2509261.CYLKgzzBkz@localhost.localdomain>
In-Reply-To: <YRwEyrSLTPl/KY9t@kroah.com>
References: <20210816193125.15700-1-straube.linux@gmail.com> <11a09af791c5453175a6bdac1c51bd9fcb0685bd.camel@perches.com> <YRwEyrSLTPl/KY9t@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, August 17, 2021 8:49:46 PM CEST Greg KH wrote:
> On Tue, Aug 17, 2021 at 11:36:09AM -0700, Joe Perches wrote:
> > On Tue, 2021-08-17 at 19:57 +0200, Greg KH wrote:
> > > On Mon, Aug 16, 2021 at 09:31:25PM +0200, Michael Straube wrote:
> > > > Refactor functions rtw_is_cckrates_included() and
> > > > rtw_is_cckratesonly_included(). Add new helper function rtw_is_cckrate()
> > > > that allows to make the code more compact. Improves readability and
> > > > slightly reduces object file size. Change the return type to bool to
> > > > reflect that the functions return boolean values.
> > []
> > > > diff --git a/drivers/staging/r8188eu/core/rtw_ieee80211.c b/drivers/staging/r8188eu/core/rtw_ieee80211.c
> > []
> > > > +bool rtw_is_cckratesonly_included(u8 *rate)
> > > >  {
> > > > -	u32 i = 0;
> > > > +	u8 r;
> > > >  
> > > > 
> > > > -	while (rate[i] != 0) {
> > > > -		if  ((((rate[i]) & 0x7f) != 2) && (((rate[i]) & 0x7f) != 4) &&
> > > > -		     (((rate[i]) & 0x7f) != 11)  && (((rate[i]) & 0x7f) != 22))
> > > > +	while ((r = *rate++)) {
> > > 
> > > Ick, no.
> > > 
> > > While it might be fun to play with pointers like this, trying to
> > > determine the precedence issues involved with reading from, and then
> > > incrementing the pointer like this is crazy.
> > > 
> > > The original was obvious as to how it was walking through the array.
> > 
> > It's sad to believe *ptr++ is not obvious to you as it's very commonly
> > used in the kernel sources (over 10,000 instances).
> 
> There's lots of sad things in life :(
> 
Dear Greg,

Please reconsider this issue, I mean it. Let me explain why...

Obviously neither Joe or all the people who knows how much you've given to
Linux during these latest two decades (or is it more?) believes that you have 
any problem with operator precedence :-)

Said that, since operator precedence is one of the first topic that every developer
learn in a course on C and that expressions like *ptr++ are used everywhere in
the kernel you are sending a dangerous message...

It looks like you don't trust people here to be able to do anything more than 
trivial clean-ups. If someone here at linux-staging is not able to understand 
the precedence of operators, please stand up and speak!

We here at linux-staging are not class B developers (compared to A class 
developers of other subsystems). For sure, most of us are newcomers with
less experience than other developers who don't choose to work with
drivers/staging, but you should not prevent us from getting experience and 
using common techniques that are perfectly fine in other areas of Linux.

Thanks for your attention and your precious time,

Fabio
 



