Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE177351194
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233715AbhDAJLB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhDAJKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:10:36 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68A3BC0613E6
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:10:36 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id l18so1107330edc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Yz2uAKOVLdpCA/W96Sc6EEUFc6Wo0dIgN6QEihppNbU=;
        b=oP2NBqVlju7vp7m3LOckHhHUNKDd8Gs1hyGYYuC8qp8KKvkqPNRZr2919RIaAqwHmE
         pyhI2njrQ0Qrng16SoNECX+nTQ1LVjQKlIFL4zqeYjwZ8PLi+8rvl5Cmv2gFg5NFWzbq
         1mjeFTV6McE5oq1kBCbtAu24I2j/6Obrl5+XTY4vDvSsZtXnoMQfm7gqOPH3H72S6Iwl
         64BsE/H81Tj05PAj4wNn/vA9SZAaeGlrpCNYAGki7qaPz8rM6DExTxIXsZazi89svYvI
         hsDmrTNdaOdXOM9/Y6/kagIqTIKWwQi1PrL3nnkNzafFruoZ/+Y8laUbQJpzubxVq8Fe
         VNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yz2uAKOVLdpCA/W96Sc6EEUFc6Wo0dIgN6QEihppNbU=;
        b=myeQKAq1KxFbu21HtbxnFfqii13XzkIPYafIM59EWp5MyMXwUyYG5SJjjB2JZ9eiZh
         DZWYp4USme/al/cvDBRWqku7yrW9SBG7Ne0oJUcNMazdZ36TwwCc78MVllboRLLp3xHj
         6CnPqOp4ne6ylhoO+Kh8yo3DndRQL/OJdWHa76kI79qHMHmvpJa9jEfi5xhJfaD/nZyA
         W4shiqpASq1rT1znM+MVgsn5ADiZ7gg+8o6Cj/ylU6y6QfFy4y5zuq2TevtUPVzQDCyy
         sWo4Sperksco/N+ETN5/hrJpC67efakPb9emZ9b3zGkdJ52X0xs76fNSkIMJsy6IYAyA
         Y1MA==
X-Gm-Message-State: AOAM532QyQwiWP+etCd4vdSRJRkR29MYsbNy6iGTniA8GRwix+oQ8VLI
        Oygzjj2jJUMaTTVUdrBH3qE=
X-Google-Smtp-Source: ABdhPJw1S3zpHxMQiBjiNx+pagbqT+Wfo4r87kEY2b1AnuTXs9AiCq0fD44o1oKRvPoHwfkWkP5L9A==
X-Received: by 2002:a50:f747:: with SMTP id j7mr8490344edn.338.1617268235222;
        Thu, 01 Apr 2021 02:10:35 -0700 (PDT)
Received: from agape.jhs ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id d1sm2491932eje.26.2021.04.01.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:10:34 -0700 (PDT)
Date:   Thu, 1 Apr 2021 11:10:32 +0200
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/40] staging: rtl8723bs: replace RT_TRACE with public
 printk wrappers in core/rtw_eeprom.c
Message-ID: <20210401091031.GB1442@agape.jhs>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
 <39c2cd878bc914a00e71ea988c3cacb651670822.1617183374.git.fabioaiuto83@gmail.com>
 <YGROiD19tgF8XnK6@kroah.com>
 <20210331105551.GB1450@agape.jhs>
 <YGRZilreNqCdsLCE@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGRZilreNqCdsLCE@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2021 at 01:14:18PM +0200, Greg KH wrote:
> On Wed, Mar 31, 2021 at 12:55:51PM +0200, Fabio Aiuto wrote:
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
> > > > +		pr_err("%s padapter->bSurpriseRemoved==true", DRIVER_PREFIX);
> > > 
> > > As Dan said, this is not the same thing.  You are now always printing
> > > out this mess, when before you were not unless you explicitly enabled
> > > "tracing".
> > 
> > RT_TRACE is enabled if is defined the symbol DEBUG_RTL871X. It doesn't seem to be related 
> > to tracing. DEBUG_RTL871X is never declared, is commented out in rtl8723bs/include/autoconf.h
> 
> That's a good sign this is never used and should just all be removed.
> 
> > that's why RT_TRACE is never printed. If we try to uncomment the symbol definition we have some
> > comiling errors..
> 
> What errors do you get?
> 
> > > And you are sending it to the error log?
> > > 
> > > And finally, drivers should never be using pr_*() for messages, they
> > > should be using dev_*() instead as they are a driver and have access to
> > > a device pointer.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > I still wonder what's best...
> 
> Just delete them all please, they are obviously not used as no one
> rebuilds the source just for this type of thing.
> 
> thanks,
> 
> greg k-h

Hi Greg,

I will send a brand new patchset, not a v2, for the pourpose is changed.

Thank you,

fabio
