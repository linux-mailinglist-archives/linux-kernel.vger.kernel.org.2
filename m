Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 342C039502C
	for <lists+linux-kernel@lfdr.de>; Sun, 30 May 2021 11:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhE3I7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 May 2021 04:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhE3I7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 May 2021 04:59:43 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF2DC061574
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:58:05 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id o127so4464008wmo.4
        for <linux-kernel@vger.kernel.org>; Sun, 30 May 2021 01:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yKEi1zA6SJzK2vVefRdodwsA/ycK3zpNYbHpAPn85pY=;
        b=ZOEeFI3HzXnz2FtZGwnqYOmbwVCRf5vu2GrQSM0qjOQilVSoiVrIEYupwdwkCD3YSV
         f/2E2HLE66XRyBHQuXuYiM+78KeZYPMC02nxnKshkVVbIZjnWh/vlWezXxl2k1Xb3lp2
         +gBiTEixAFiMIrGtRK7YYfXbTtsl727wH1dwaNCZcukhZCir7lHZxMxCPk66RfUKEw/s
         aA4qLr+iVP8aKeX3vuopiIkAf0VannNUxzJcHovPLoVBh3bc8S8cEcybFw1IYYjxgJrH
         6y52z8qOsVTtfU3YbX6QAGx0i/NXNnNwnpPkrMAx8kbDuv0FB7c0xmyKUMyq8MpDdczF
         jZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yKEi1zA6SJzK2vVefRdodwsA/ycK3zpNYbHpAPn85pY=;
        b=RIYFeq/umCZx9gz/olgZpUbQn/0O5IuxzdKPOqHCvndUMPe7/xwl3CtN6UlzTmJSd4
         XdtxL3KoR0878/hHtapWbbtoi5sObSIX1DPpcpDm8ngxgfURqhldtKTzD6k6wpJafMmf
         CHIIrnomK9s4cmCrlz0X19cWDKnJDWOYZC2CT5BvHCyLUpai/lRWd/kflI56BRJycrU1
         SdbqUiZi1s1CoCo0xcvYT411A4Rx7Jsf+Z2ujgqVspJuHS4OT46xnyhfUg3OKGiEGvKH
         1J7HKpWTsfNN9To8IAJa+6w7wS/l/B03q186qGvaqUGZgy34JZOHBxysue6RJCbDwQza
         GwkA==
X-Gm-Message-State: AOAM531exoxTmNHTFFOP1+VowczjmiFKytdd7llJCkj5M5XVycmNVsTf
        rEHa3GkSRxLq6HMdGu1VJ9JAhg==
X-Google-Smtp-Source: ABdhPJyEuSYEMKnhN1Smbc8JCbYNkl6Msw6xGpiZRsL0YU3bqaBRLzwYea0764nWbJBrUdtvsq9EOw==
X-Received: by 2002:a1c:cc12:: with SMTP id h18mr15909381wmb.141.1622365083660;
        Sun, 30 May 2021 01:58:03 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id e17sm1236255wre.79.2021.05.30.01.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 May 2021 01:58:03 -0700 (PDT)
Date:   Sun, 30 May 2021 09:58:01 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 55/69] ASoC: rt5645: add error checking to rt5645_probe
 function
Message-ID: <YLNTmRvIoJWv6lgG@equinox>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-56-gregkh@linuxfoundation.org>
 <YK1uZdtgffiCnUVQ@sirena.org.uk>
 <YK1z6AlOAMxYCh75@equinox>
 <YK/JfeMt9j9z+40Q@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK/JfeMt9j9z+40Q@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2021 at 05:31:57PM +0100, Mark Brown wrote:
> On Tue, May 25, 2021 at 11:02:16PM +0100, Phillip Potter wrote:
> > On Tue, May 25, 2021 at 10:38:45PM +0100, Mark Brown wrote:
> 
> > > Phillip, please follow the standard patch submission process,
> > > this is documented in submitting-paches.rst in the kernel tree.
> > > In particular please make sure that you copy the relevant
> 
> > This patch was submitted to a closed mentoring group as part of the
> > University of Minnesota reversion/checking process. I was not
> > responsible for the final send out to the public mailing lists etc. as
> > the patches were collated first and sent out together en masse.
> 
> OK, this is really unfortunate.
> 
> > > This comment is not accurate, rt5645_remove() just resets the
> > > hardware - it's not going to clean up anything to do with any of
> > > the branches to error you've got above.  The core *will* clean up
> 
> > My comment was adjusted after submission for brevity's sake. This was
> > what I originally wrote:
> >  /*
> >   * All of the above is cleaned up when we return an error here, as
> >   * the caller will notice the error and invoke rt5645_remove and
> >   * other cleanup routines, as it does for the snd_soc_dapm_* calls
> >   * above as well.
> >   */
> > Happy to resubmit/rewrite as needed? Based on what you've written
> > though it may be better to drop the patch?
> 
> That is a lot better yes, it accurately reflects what was going
> on - the review definitely wasn't helping here.
> 
> > > Also I'm guessing this was done purely through inspection rather
> > > than the code having been tested?  If there was a problem seen at
> > > runtime this isn't fixing it, TBH I'm more than a little dubious
> 
> > Yes, that's correct - I did not test this directly other than making
> > sure it builds, as I don't have this hardware to test with. 
> 
> OK, in that case it's going to be safer to just drop the change,
> it's probably not going to cause any actual problems but it's
> certainly not something that should go in as a hurried fix.

Dear Mark,

Thank you, I will not resubmit with the new comment in that case. Have a
great weekend.

Regards,
Phil
