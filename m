Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC7C375A40
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 20:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236383AbhEFSlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 14:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbhEFSlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 14:41:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAB8C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 11:40:43 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id d29so5348402pgd.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 11:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sk8YWc4MhNNQXS00yudUUlip0bfEt3mvxXQ97iHChH4=;
        b=izrdChUaTy6hf5O54+SVKAFV7PZhuXCVuxAYT0lJzkNAhm5EdqMwcePvig6Q5c8bUY
         krefJakTCav+7WZlez4BnjqkUP+D8QO5blfJsbBchBpWjYRCUI57NEqOHiAm+UGyPzTZ
         Bh5GBulRUdT/ao5dzFjpvo4//UhfB7GsCovm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sk8YWc4MhNNQXS00yudUUlip0bfEt3mvxXQ97iHChH4=;
        b=gYEXhfTcKxCp62pg8ML1DVfCFLB6RsUOOkAfs+LWVmpUmC8efX7nMTSjUsBsNGkf4o
         UN6zWJK4pgx5ab/opGa3Q5wrK3M8LCPgEYj35cqlaXFioFA8n78UDB2lLE1JyGgtzi3r
         qu4JxaH7R3JKTXZEMSGHkjKVXLg/R+tRsJoLkTIh6Jj8UBqY4Y0i6URThMnxnFq/AlH/
         yoiPPuxdg19W67c7NS5/AQ2gbWq8R12JViHdWEagNhY+mnQWfafguk4S94d+QBCTn67Y
         D1iuyp+U1V0GHAMSkBOUyVJXJLd4KWHXxUkGeqJiKtKByWnI2fkLUIaeLbruSr7A+eOX
         yJEg==
X-Gm-Message-State: AOAM532DVu1den9sRY+38pDUY/MFTa4/RQV1NWYJvzPN2TOjK/SPjsgw
        Etr8+2zq7d3umj9OhmoULtNdDuVs+mq2Eg==
X-Google-Smtp-Source: ABdhPJwf0TFRxFH37GdRjLgGsPv76ULLqBv+GV8R6/wMEfINxxWw8cJIlak7V1374ls1+nVMS1TaDw==
X-Received: by 2002:a62:e915:0:b029:27a:93d3:f4f9 with SMTP id j21-20020a62e9150000b029027a93d3f4f9mr6156854pfh.50.1620326442814;
        Thu, 06 May 2021 11:40:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w124sm2606806pfb.73.2021.05.06.11.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 11:40:42 -0700 (PDT)
Date:   Thu, 6 May 2021 11:40:41 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        tech-board@lists.linux-foundation.org
Subject: Re: Report on University of Minnesota Breach-of-Trust Incident
Message-ID: <202105061042.E99B414F0A@keescook>
References: <202105051005.49BFABCE@keescook>
 <20210506082616.GA20224@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210506082616.GA20224@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2021 at 10:26:16AM +0200, Pavel Machek wrote:
> Hi!
> 
> > Report on University of Minnesota Breach-of-Trust Incident
> > 
> > 	or
> > 
> > "An emergency re-review of kernel commits authored by members of the
> >  University of Minnesota, due to the Hypocrite Commits research paper."
> > 
> > May 5, 2021
> 
> Thanks for doing this. I believe short summary is that there was some
> deception from UMN researches in 2020:
> 
> > 2020 August:
> >   - "Hypocrite Commits" patches from UMN researchers sent to kernel developers
> >     under false identities:
> >     - Aug 4 13:36-0500
> > 	https://lore.kernel.org/lkml/20200804183650.4024-1-jameslouisebond@gmail.com
> >     - Aug 9 17:14-0500
> > 	https://lore.kernel.org/lkml/20200809221453.10235-1-jameslouisebond@gmail.com
> >     - Aug 20 22:12-0500
> > 	https://lore.kernel.org/lkml/20200821031209.21279-1-acostag.ubuntu@gmail.com
> >     - Aug 20 22:44-0500
> > 	https://lore.kernel.org/lkml/20200821034458.22472-1-acostag.ubuntu@gmail.com
> >     - Aug 21 02:05-0500
> > 	https://lore.kernel.org/lkml/20200821070537.30317-1-jameslouisebond@gmail.com
> 
> But there was no deception from UMN in 2021. Yet, we were
> spreading... let's say inaccurate information as late as this:
> 
> > 2021 April 29:
> >   - Greg posts an update on the re-review along with some more reverts.
> > 	https://lore.kernel.org/lkml/20210429130811.3353369-1-gregkh@linuxfoundation.org
> 
> # Commits from @umn.edu addresses have been found to be submitted in "bad
> # faith" to try to test the kernel community's ability to review "known
> # malicious" changes.

I would agree that the phrasing here is sub-optimal in that it could
more clearly separate a few related things (e.g. "malicious change" vs
"valid fix"). If I were writing this, I would have said something along
the lines of:

  Commits from UMN authors have been found to be submitted with intentional
  flaws to try to test the kernel community's ability to review "known
  malicious" changes. ...
  During review of all submissions, some patches were found to be
  unintentionally flawed. ...
  Out of an abundance of caution all submissions from this group must be
  reverted from the tree and will need to be re-review again. ...

I would also note that in that thread Greg reviewed all the mentioned
patches, clearing all but two of them (which were duplicates to earlier
review).

> UMN apologized. Our reaction to their apology was:
> 
> https://lore.kernel.org/lkml/YIV+pLR0nt94q0xQ@kroah.com/#t
> 
> Do we owe them apology, too?

I will defer to Greg on what he thinks his duties are there, but in
trying to figure out who "we" is, I'll just point out that I attempted
to clarify the incorrect assumptions about the intent of historical UMN
patches, and spoke for the entire TAB (Greg included) here:
https://lore.kernel.org/lkml/202104221451.292A6ED4@keescook/
The report repeated this in several places, and we explained our need
for due diligence.

-Kees

-- 
Kees Cook
