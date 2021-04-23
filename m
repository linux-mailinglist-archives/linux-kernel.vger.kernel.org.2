Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1A89368F26
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 11:04:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241623AbhDWJEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 05:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhDWJE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 05:04:29 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CE1DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:03:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id y22-20020a17090a8b16b0290150ae1a6d2bso930674pjn.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 02:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=40p26RO3sNQmdn0J0NB6j1RdcEey3rgEyjuaX+BeV0w=;
        b=gqn48ojh2pw8TesyhDIluZniRfO5vu6LyakBIWoJToFkOfTaEr8Dl8j+/YhBRRVbM8
         RrXPjK41nR+rxozo3OkQWeh5snbWkJtyVg0YSHVJ5FbW5tMWYW8K2xJGsKYJSSAtU7xA
         xc9Pmvr/DWy/To9uAuDBVoyrn0tq5xxXBGCLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=40p26RO3sNQmdn0J0NB6j1RdcEey3rgEyjuaX+BeV0w=;
        b=p30mgxeBSozKfG2JDPwevX2zDG2U4YYzIlYjTNHQOBR1B5+J1smLraCdfUQaNqwBFV
         1NYH9mvtRIZVbMsYu62rkFDYBO2RK0XFCjjzafdRUhxdUayta3OKeA0lyBq3sttDJApt
         kfPB2W+mmNLAtY1/EZOxnJNa1T3RCK4aFwF5VMeDc0TSQPvP/PBCpSc8v9Cc9vWGhpDj
         yUEn3/6a/t2toPflLA9r9RwwlkCexK0AF2Y4MlwUD3V/UXtAy2CLVp+Lq1oRCkd+qvnG
         jNHjBmWDqdidCw38INshDnSlSzORMvFFrSYHASfvITLBmRBXynYsR9IYrRjcBqvgS/ZR
         bcvQ==
X-Gm-Message-State: AOAM532nwGtXg5VNzseBq/OTDggVS91AnbSF2AuD7PduMQwdbPBGQdgC
        e21JZ+5obpBB/vdtHiPlmVvVhQ==
X-Google-Smtp-Source: ABdhPJzWBDwEB2i9Y7lWEvaZImQGIaPDnbYqbYxYZfI97xZ+0+NQCQT+NHMMAk6GiVK5kUVB5BXGrA==
X-Received: by 2002:a17:90a:9503:: with SMTP id t3mr3263633pjo.220.1619168631772;
        Fri, 23 Apr 2021 02:03:51 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p126sm4144367pfb.32.2021.04.23.02.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 02:03:51 -0700 (PDT)
Date:   Fri, 23 Apr 2021 02:03:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, Aditya Pakki <pakki001@umn.edu>,
        kjlu@umn.edu, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Joe Perches <joe@perches.com>,
        Nicolai Stange <nstange@suse.de>,
        Roland Dreier <roland@purestorage.com>
Subject: Re: [PATCH 113/190] Revert "x86/hpet: Prevent potential NULL pointer
 dereference"
Message-ID: <202104230201.EEB997CD8@keescook>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-114-gregkh@linuxfoundation.org>
 <202104211245.F5FEC8D15D@keescook>
 <87im4dx5cc.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87im4dx5cc.ffs@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 23, 2021 at 01:33:07AM +0200, Thomas Gleixner wrote:
> On Wed, Apr 21 2021 at 12:49, Kees Cook wrote:
> > On Wed, Apr 21, 2021 at 02:59:48PM +0200, Greg Kroah-Hartman wrote:
> >> diff --git a/arch/x86/kernel/hpet.c b/arch/x86/kernel/hpet.c
> >> index 08651a4e6aa0..0515a97bf6f5 100644
> >> --- a/arch/x86/kernel/hpet.c
> >> +++ b/arch/x86/kernel/hpet.c
> >> @@ -930,8 +930,6 @@ int __init hpet_enable(void)
> >>  		return 0;
> >>  
> >>  	hpet_set_mapping();
> >> -	if (!hpet_virt_address)
> >> -		return 0;
> >>  
> >>  	/* Validate that the config register is working */
> >>  	if (!hpet_cfg_working())
> >
> > FWIW, this patch looks harmless. It is checking for a failure in
> > hpet_set_mapping(), and avoids the following code from performing
> > 0-offset reads. hpet_set_mapping() is likely to never fail in real-world
> > situations. *shrug*
> 
> 'likely never to fail' is clearly a receipe for disaster and you should
> know that.

Of course -- I prefer to keep the sanity check. It just wasn't as good
as it could have been: it's not clear just by looking at the patch how
hpet_virt_address and hpet_set_mapping() are related.

> 
> > I think it would make more sense for the check to live in
> > hpet_cfg_working(), though.
> 
> No. That does not make any sense at all.
> 
> The proper change would have been to make hpet_set_mapping() return
> an error/success code and act on that.
> 
> But that does _NOT_ make the patch invalid.
> 
> I'm pretty sure that I looked at it and thought about the proper
> solution (see above) and then shrugged it off because of overload...

Right, no, I was saying the original patch should stay. It shouldn't be
reverted.

Greg, please drop this patch from the revert list.

-- 
Kees Cook
