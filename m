Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF15390BE3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 00:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231622AbhEYWDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 18:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbhEYWDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 18:03:51 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95E75C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:02:20 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id y14so31675293wrm.13
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=/0ItfAMtkVpU9nBcbKoe9t7bf7Srx4FJQesKUZK3OuU=;
        b=Eag5tZkHiIuZWvleiEbEB7gObqHQVUkDu42pDkcxOJV2l3f6H6Hh62VD3HIgEOaOsX
         hyCl2WGaHpyt1gplu794yP8n+OUoT/7NqIp8plP+BIuFKMdfmiKpF3zLjx6DepbbCdlz
         Dr210IGMAtSPBIj6tbVNk+7oS0SoouY1Q/WeKBcpjOsxaouyzPXYhN3mHjoQAE6pdH2B
         AR+XPpwMPNu3cHIa5pveszDWZP1N8xjt0tiFmv0NtUUa1oAM8k7LKkGVdYZXTywE0NgY
         zmwynOl3dcz5Y4d0wh3woDqvlpdbqSuotJvYaHjEC0XJllDw0/3tlqusfHjjTeaG2k0W
         /4FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=/0ItfAMtkVpU9nBcbKoe9t7bf7Srx4FJQesKUZK3OuU=;
        b=n6SqbEXecj3mRsZ21x9aDKv466a0mSMH4cd/Zp+cuuxEWb76wzXx9QPkl53yI2GkV7
         G9j+f/xXr24UofKznWGmh1jSzSV1HOkd3HP7BgIZKM5hMyF5vsB7gIFXyyUguqwGLdFs
         HGoKbAQOkL5qRiUjoIA1PJoCfxxq8bL8O2vRuMJI7CVl77UKx4P82jOh8xKKcZwZilAA
         pG835V5YjkzM1q5EJrvqDiY+k4kp04KVy8SZjT/wBvnsGEF2V+kZUgYtJI1Fizlz5kuV
         Gyr5Gu29G66v+drf5qqzTOIUlTTiGtUcmShLuULar1RKHO5R3g/+ekw2oHQslrnI0dA/
         +bXg==
X-Gm-Message-State: AOAM531Dnhst+9yZWWWhJf+Re8M7GdtQMaeLMkzlohqKb+/wuZKnXq4b
        PE8SNJ7QvpSpozc8wCGEeSS2gg==
X-Google-Smtp-Source: ABdhPJxFu/iwbc1Btt6wNV3mn0jIW8PeoEA4loiX7laqazTOVmcGDBZ4mZu4ZL9UK1uZuOrDim0ltw==
X-Received: by 2002:adf:e5c8:: with SMTP id a8mr27715496wrn.155.1621980139194;
        Tue, 25 May 2021 15:02:19 -0700 (PDT)
Received: from equinox (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id k6sm4054319wmi.42.2021.05.25.15.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 15:02:18 -0700 (PDT)
Date:   Tue, 25 May 2021 23:02:16 +0100
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Mark Brown <broonie@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 55/69] ASoC: rt5645: add error checking to rt5645_probe
 function
Message-ID: <YK1z6AlOAMxYCh75@equinox>
References: <20210503115736.2104747-1-gregkh@linuxfoundation.org>
 <20210503115736.2104747-56-gregkh@linuxfoundation.org>
 <YK1uZdtgffiCnUVQ@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YK1uZdtgffiCnUVQ@sirena.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2021 at 10:38:45PM +0100, Mark Brown wrote:
> On Mon, May 03, 2021 at 01:57:22PM +0200, Greg Kroah-Hartman wrote:
> > From: Phillip Potter <phil@philpotter.co.uk>
> > 
> > Check for return value from various snd_soc_dapm_* calls, as many of
> > them can return errors and this should be handled. Also, reintroduce
> > the allocation failure check for rt5645->eq_param as well. Make all
> 
> Phillip, please follow the standard patch submission process,
> this is documented in submitting-paches.rst in the kernel tree.
> In particular please make sure that you copy the relevant
> maintainers and mailing lists for the subsystem and any driver
> specific maintainers on any patches that you are submitting to
> the kernel so that they can be reviewed.
> 

Dear Mark,

This patch was submitted to a closed mentoring group as part of the
University of Minnesota reversion/checking process. I was not
responsible for the final send out to the public mailing lists etc. as
the patches were collated first and sent out together en masse.

> > +exit:
> > +	/*
> > +	 * If there was an error above, everything will be cleaned up by the
> > +	 * caller if we return an error here.  This will be done with a later
> > +	 * call to rt5645_remove().
> > +	 */
> > +	return ret;
> 
> This comment is not accurate, rt5645_remove() just resets the
> hardware - it's not going to clean up anything to do with any of
> the branches to error you've got above.  The core *will* clean up
> any routes and widgets that are added, but it doesn't do it by
> calling remove() and people shouldn't add code in their remove
> functions which does so.

My comment was adjusted after submission for brevity's sake. This was
what I originally wrote:
 /*
  * All of the above is cleaned up when we return an error here, as
  * the caller will notice the error and invoke rt5645_remove and
  * other cleanup routines, as it does for the snd_soc_dapm_* calls
  * above as well.
  */
Happy to resubmit/rewrite as needed? Based on what you've written
though it may be better to drop the patch?

> 
> Also I'm guessing this was done purely through inspection rather
> than the code having been tested?  If there was a problem seen at
> runtime this isn't fixing it, TBH I'm more than a little dubious
> about applying this untested - it's really random if things check
> these errors since they're basically static checks that we're not
> smart enough to do at compile time and the core is pretty loud
> when they hit.  I occasionally wonder about just removing the
> return codes, I think more callers don't have the checks than do
> (certainly in the case of _force_enable() where I was surprised
> to find any callers that do), but never got round to it.

Yes, that's correct - I did not test this directly other than making
sure it builds, as I don't have this hardware to test with. 

Regards,
Phil
