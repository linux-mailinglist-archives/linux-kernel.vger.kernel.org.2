Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E995375C86
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 23:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhEFVEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 17:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhEFVEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 17:04:12 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2C0C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 May 2021 14:03:14 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id q6so3855249qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 14:03:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metztli-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=SJEMPPPvUXgNtuCo5YPMGXk+vuxsoQVcXBSqyWI9084=;
        b=SytE2+Xzv9B03rkXMz6EGbmOeaJQVTLrpH1JJyEf0GN/a76yhxaFzOJsMdpBmDU6Mn
         aljCuulzPq+fNSp3lXX2ZnN/R3H/ysNZT/nXkROPPLh1GOnBaXdFKbhWg+SF+7J12dl5
         DM/5ZwUNzXkTmocOxNhEm5XIqXGeVb2ShlUFJSvrKf+PWKlxnuuBZwfNuCH9rJP1WmVS
         9lec9kRhlmkWCqli8fFTwnS+3Fuwxca/wfGzRSuJ1yYf0vLIoJ18HOG4U03HTuTIVT31
         Ymrn1lj9vqiivTWDJzedh0W111YZpvF6IgxS8OR8V2Xu/46aBUnt8hBonmpM46TW49zg
         X3fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=SJEMPPPvUXgNtuCo5YPMGXk+vuxsoQVcXBSqyWI9084=;
        b=eCTfs4TeF/J8IbVoF1ZGmMTlWkgXMN1WEWyrUTnX/sBxLOtJ/GfUKU3aN0FX3ORWN3
         KqPMOG4igdgi8tnq8p0CqHXGnO5ouUUGTWLxzhRwhqq7NBN3Vxl9rXus/929ZeWKK2do
         5USnzoKbNMvk0CtKrH7aq7NZ2pX9vRZ4AxN60wT+J5xgKGpx+umq01GX4OLhkBk0mkh4
         Jl77EJMA3XoX22jDf0HBKmOP344g1o4M9pYAQO5Ag2Bv5FpPBVyr4/T3ATNXwuMUsE6w
         lBk4pJm6Vn5PFJ2oUX4IBUu5dpWYRXaG2AKgBfCFS3gCjyNw+NatGf71/Ia9D6heDCbH
         zoQA==
X-Gm-Message-State: AOAM533rIBdwONXGMmE0gPnTwO5fDiGX+uGBNGLIqAFAw1zOgsg+44Xr
        WUUQp8FfcNT1Cy/nsOu9Z83Blw==
X-Google-Smtp-Source: ABdhPJwgKTH30CdBhbRAxqkKyJebgS46U4yDlDJz71JD/aIrskOadQyDKWvRrgy82/hnIsV2OzyyNg==
X-Received: by 2002:a0c:fd62:: with SMTP id k2mr6507129qvs.51.1620334993332;
        Thu, 06 May 2021 14:03:13 -0700 (PDT)
Received: from ?IPv6:2600:1700:6470:27a0:4e80:93ff:fe00:3ff7? ([2600:1700:6470:27a0:4e80:93ff:fe00:3ff7])
        by smtp.gmail.com with ESMTPSA id r8sm2981110qtc.24.2021.05.06.14.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 14:03:01 -0700 (PDT)
Message-ID: <4eb59c7815d86d85e42b50c45f10e47273c5e0e0.camel@metztli.com>
Subject: Re: Report on University of Minnesota Breach-of-Trust Incident
From:   Metztli Information Technology <jose.r.r@metztli.com>
To:     Kees Cook <keescook@chromium.org>, Pavel Machek <pavel@ucw.cz>
Cc:     linux-kernel@vger.kernel.org, Kangjie Lu <kjlu@umn.edu>,
        tech-board@lists.linux-foundation.org,
        Edward Shishkin <edward.shishkin@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>
Date:   Thu, 06 May 2021 14:02:47 -0700
In-Reply-To: <202105061042.E99B414F0A@keescook>
References: <202105051005.49BFABCE@keescook>
         <20210506082616.GA20224@duo.ucw.cz> <202105061042.E99B414F0A@keescook>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-05-06 at 11:40 -0700, Kees Cook wrote:
> On Thu, May 06, 2021 at 10:26:16AM +0200, Pavel Machek wrote:
> > Hi!
> > 
> > > Report on University of Minnesota Breach-of-Trust Incident
> > > 
> > >         or
> > > 
> > > "An emergency re-review of kernel commits authored by members of
> > > the
> > >  University of Minnesota, due to the Hypocrite Commits research
> > > paper."
> > > 
> > > May 5, 2021
> > 
> > Thanks for doing this. I believe short summary is that there was
> > some
> > deception from UMN researches in 2020:
> > 
> > > 2020 August:
> > >   - "Hypocrite Commits" patches from UMN researchers sent to
> > > kernel developers
> > >     under false identities:
> > >     - Aug 4 13:36-0500
> > >         https://lore.kernel.org/lkml/20200804183650.4024-1-jameslouisebond@gmail.com
> > >     - Aug 9 17:14-0500
> > >         https://lore.kernel.org/lkml/20200809221453.10235-1-jameslouisebond@gmail.com
> > >     - Aug 20 22:12-0500
> > >         https://lore.kernel.org/lkml/20200821031209.21279-1-acostag.ubuntu@gmail.com
> > >     - Aug 20 22:44-0500
> > >         https://lore.kernel.org/lkml/20200821034458.22472-1-acostag.ubuntu@gmail.com
> > >     - Aug 21 02:05-0500
> > >         https://lore.kernel.org/lkml/20200821070537.30317-1-jameslouisebond@gmail.com
> > 
> > But there was no deception from UMN in 2021. Yet, we were
> > spreading... let's say inaccurate information as late as this:
> > 
> > > 2021 April 29:
> > >   - Greg posts an update on the re-review along with some more
> > > reverts.
> > >         https://lore.kernel.org/lkml/20210429130811.3353369-1-gregkh@linuxfoundation.org
> > 
> > # Commits from @umn.edu addresses have been found to be submitted
> > in "bad
> > # faith" to try to test the kernel community's ability to review
> > "known
> > # malicious" changes.
> 
> I would agree that the phrasing here is sub-optimal in that it could
> more clearly separate a few related things (e.g. "malicious change"
> vs
> "valid fix"). If I were writing this, I would have said something
> along
> the lines of:
> 
>   Commits from UMN authors have been found to be submitted with
> intentional
>   flaws to try to test the kernel community's ability to review
> "known
>   malicious" changes. ...
>   During review of all submissions, some patches were found to be
>   unintentionally flawed. ...
>   Out of an abundance of caution all submissions from this group must
> be
>   reverted from the tree and will need to be re-review again. ...
> 
> I would also note that in that thread Greg reviewed all the mentioned
> patches, clearing all but two of them (which were duplicates to
> earlier
> review).
> 
> > UMN apologized. Our reaction to their apology was:
> > 
> > https://lore.kernel.org/lkml/YIV+pLR0nt94q0xQ@kroah.com/#t
> > 
> > Do we owe them apology, too?
> 
> I will defer to Greg on what he thinks his duties are there, but in
> trying to figure out who "we" is, I'll just point out that I
> attempted
> to clarify the incorrect assumptions about the intent of historical
> UMN
> patches, and spoke for the entire TAB (Greg included) here:
> https://lore.kernel.org/lkml/202104221451.292A6ED4@keescook/
> The report repeated this in several places, and we explained our need
> for due diligence.
> 
> -Kees
> 

This has aged well:

"Linux has a problem, which is that with success it is attracting
people with more skill than what it started with, and it is not doing a
very good job of handling that. In fact, it downright stinks at it,
behaving in the worst way it could choose for handling that. [Linux]
have lost quite a number of FS developers who just don't want to deal
with people who know less than they do but are obnoxious and
disrespectful to submissions because they enjoy powertripping...
*[Linux] should develop a culture in which acceptance is more based on
whose code measurably performs well [,i.e, meritocracy, rather] than on
who is friends with whom.*~

< https://lkml.org/lkml/2006/7/21/109 >

Yet when self-believing 'badass' Linux developers engage in what is
essentially masturbation by 'fixing' obsolete security issues[1]
< https://lkml.org/lkml/2020/8/17/174 >
rather than reviewing how 'friend' contributors' patches fit within the
overall kernel development structure, it is to be expected to end up
with a *sabotaged* kernel.

[1] https://www.theregister.com/2020/10/25/linux_5_10_rc1/


Best Professional Regards.

-- 
-- 
Jose R R
http://metztli.it
-----------------------------------------------------------------------
----------------------
Download Metztli Reiser4: Debian Buster w/ Linux 5.10.26 AMD64
-----------------------------------------------------------------------
----------------------
feats ZSTD compression https://sf.net/projects/metztli-reiser4/
-----------------------------------------------------------------------
----------------------
or SFRN 5.1.3, Metztli Reiser5 https://sf.net/projects/debian-reiser4/
-----------------------------------------------------------------------
--------------------
Official current Reiser4 resources: https://reiser4.wiki.kernel.org/


