Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C3F5350014
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 14:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbhCaMUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 08:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbhCaMUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 08:20:04 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDAFC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 05:20:03 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id bx7so22041213edb.12
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 05:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4C0Nob3kCxAymCSBdPGfWK0bfiuslhH1Vyz8Q3gjxRo=;
        b=WV7syPXn9LH9fJYZqbs1RyWSEpti9lGZmZaUv5egUu2dWg4eyM2Jtm7jTPgNiXftpS
         e1Nsy8Znn/M0En+K+NV/WdwW5T9MuHhcGjJiRB5RPLEzDs0Cu+wqP8uYWl9r6dlcPEnN
         1rWMKD2Dm3LqAiL3f2QrWGL44stLW1Ld2G0TL1ofamr3UyJbTJYHDS9OtmHTzmUmsKPg
         5BAM9QqqsKCgxx2O1gwh8nphdwdZbmS2SYu2h8XVSoCEY5CKcuMtuBZcte9iQf2WZrY/
         7wLW1oa1pwS7+YpKpNgE8P7115ILpXVbfamuYVvmNu9ecxIWWEZvhNLPPjHasCPKe7Te
         lvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4C0Nob3kCxAymCSBdPGfWK0bfiuslhH1Vyz8Q3gjxRo=;
        b=ZFyEFizlmSEHIF3ybdmbqFUUXRvnwBE9fHTsUGDfqTibxUvtrGsFVcwh/AsJrqVdVp
         wABWBVNskJ1FEvWWrQZkijGZhLPNAADBJdZAT2GZ8sesDuha2Y43s3SnlJEDTaJlLvhV
         KkXAZNqyr0uOnwTwXgCjW+L/GCpGPmHa/NK8bLOXvfjTo4TmN34wk1uecEp/KW3YdM6P
         VueWnc0rwgePXPn3KEzhvhZ1ra8KUi88QN/qBwVqaB9HxYgxaQ8q7qlFDjz8NCzRHC0r
         5ziEb2QlqiqLEwL0bIhVbThw62aW0ad8ZyZ5cMgWu4ypdLd0IM5o66fhj1/TvLVsEBdF
         jm+Q==
X-Gm-Message-State: AOAM532uI3OthewKgzCBZIzIPzex/GWkIEybEO/6jDxI8uWeovN5BR0Q
        93oGOJl3TaLYFOcOP271rE4=
X-Google-Smtp-Source: ABdhPJxNdqsV8z7jkT0KwLw67EgrL5lKP2qhXWZ5KRKp7FYjWebkHBniCAIBJvyMuPSzC97k35fKWA==
X-Received: by 2002:a50:ec07:: with SMTP id g7mr3347331edr.72.1617193202749;
        Wed, 31 Mar 2021 05:20:02 -0700 (PDT)
Received: from agape.jhs ([5.171.81.9])
        by smtp.gmail.com with ESMTPSA id dg26sm1432386edb.88.2021.03.31.05.20.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 05:20:02 -0700 (PDT)
Date:   Wed, 31 Mar 2021 14:19:59 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/40] staging: rtl8723bs: replace RT_TRACE with public
 printk wrappers in core/rtw_eeprom.c
Message-ID: <20210331121958.GB1599@agape.jhs>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
 <39c2cd878bc914a00e71ea988c3cacb651670822.1617183374.git.fabioaiuto83@gmail.com>
 <YGROiD19tgF8XnK6@kroah.com>
 <20210331103630.GA1450@agape.jhs>
 <YGRTdBWseZw72rae@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGRTdBWseZw72rae@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 12:48:20PM +0200, Greg KH wrote:
> On Wed, Mar 31, 2021 at 12:36:31PM +0200, Fabio Aiuto wrote:
> > On Wed, Mar 31, 2021 at 12:27:20PM +0200, Greg KH wrote:
> > > On Wed, Mar 31, 2021 at 11:39:31AM +0200, Fabio Aiuto wrote:
> > > > replace private macro RT_TRACE for tracing with in-kernel
> > > > pr_* printk wrappers
> > > > 
> > > > Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
> > > > ---
> > > >  drivers/staging/rtl8723bs/core/rtw_eeprom.c | 26 ++++++++++-----------
> > > >  1 file changed, 13 insertions(+), 13 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/rtl8723bs/core/rtw_eeprom.c b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > > index 3cbd65dee741..6176d741d60e 100644
> > > > --- a/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > > +++ b/drivers/staging/rtl8723bs/core/rtw_eeprom.c
> > > > @@ -36,7 +36,7 @@ void shift_out_bits(_adapter *padapter, u16 data, u16 count)
> > > >  _func_enter_;
> > > >  
> > > >  	if (padapter->bSurpriseRemoved == true) {
> > > > -		RT_TRACE(_module_rtl871x_eeprom_c_, _drv_err_, ("padapter->bSurpriseRemoved==true"));
> > 
> > I looked at this ---------------------------------------^
> > and so I thought that pr_err was good...
> 
> But you missed the fact that RT_TRACE() does not always spit this stuff
> out.
> 
> And I don't know what _drv_err_ is, but tracing messages should never go
> to an error log :)

ok, got it 

> 
> > my aim was remove private macros replicating component tracing and log levels...
> 
> That's a great goal!
> 
> > so what's best? Keep a simplyfied RT_TRACE encapsulating a dev_* call?
> 
> replace them with dev_dbg() is one way, if they really are even needed
> at all.  At this point in time, I would strongly just recommend removing
> them all as no one is using them for anything.
> 
> thanks,
> 
> greg k-h

I will remove then,

thank you,

fabio
