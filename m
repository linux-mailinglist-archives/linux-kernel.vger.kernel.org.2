Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2DDC319BCC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhBLJW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbhBLJWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:22:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 900DDC061756
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:21:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id nm1so108957pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 01:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4tMVbE5K32vyYAtUimwkTyAdAdVkkPvAdbHtWim/w/k=;
        b=Iozwp0/6ZNc+/VISnNCcgc6ZdqeDG7RzBah7eI4qNMID3EOieGhxwRt1sxcsdoJfyI
         rcwNJbsdvKPj/I6sM1G7awPdW7ywACJ+aLJcwYjRxOnD4q3a/s0789ljaf/fTZLqYee5
         fDFSqdrCUPKMuvArhVAGyRhdBQm3wMYZPKoifaLQOw3mf4AK4yUFajrQC/GwFwcuOCh7
         zdRZQDoVuuOi2qzLsyrBmA9nq2g7072zzVgYZ3Ch8Co3qO5NFh/yFIwBZKaARHAyLjPG
         ayesp19JfkKYFWV5cDVXV0+G34Y3FpL8YEG0yWmAvJsKLGgycQvpWb+kyo+7pGB2O1di
         d9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4tMVbE5K32vyYAtUimwkTyAdAdVkkPvAdbHtWim/w/k=;
        b=X/GWG5xxpE5+jGpP0iYf6N/LLGQAedNJfEkCuvk0cFn2ls5O/Yeyzj0JpZ9b+HLWer
         klbGJJyYU0Ye8z2vK6d6tV0ropTn2r0PuOQ0jBsTnsxBPtMQZLNjqXJQrTtR+lECAIZx
         5kgNdX6bLsZxSkdXksjO1ut1qc+uT5VYL5hAt5ymveSGZIWVJTGomhaUFZudqKpxks1T
         QIMBDEB0s6sgy7fwdHaotPqBpgbnsE4M+kiz5c1jhDdxBGb0QoZuzdkPT7MwwURdROjJ
         O6QW1moZmBZPZNHLUELhpVijpHsxmj8Fua0SiAJB4oSaWM0kQE+6prBEG9RuDJuG6SoD
         0AYw==
X-Gm-Message-State: AOAM531KYNu7ijyakMbNcG1/2nutMunA+pJLJjf99eHalCRDAoitDg0o
        96sea9bd0jDB5zn7n3wfRGplVA==
X-Google-Smtp-Source: ABdhPJzlYWbq3Uoc6euuEolsbl12AyqS4Jx+55EBCJa72JOp90zwNkhOgGEvVR5RRh9gMZ69VuxDyQ==
X-Received: by 2002:a17:902:6b01:b029:da:d295:2582 with SMTP id o1-20020a1709026b01b02900dad2952582mr2029260plk.14.1613121693146;
        Fri, 12 Feb 2021 01:21:33 -0800 (PST)
Received: from localhost ([122.172.59.240])
        by smtp.gmail.com with ESMTPSA id t17sm9493836pgk.25.2021.02.12.01.21.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Feb 2021 01:21:32 -0800 (PST)
Date:   Fri, 12 Feb 2021 14:51:30 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Pritthijit Nath <pritthijit.nath@icloud.com>,
        devel@driverdev.osuosl.org, elder@kernel.org, vireshk@kernel.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 1/2] staging: greybus: Fixed alignment issue in hid.c
Message-ID: <20210212092130.cxo6tuess6msf4kb@vireshk-i7>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
 <20210212090926.ox763j3btrqfzzzj@vireshk-i7>
 <YCZHsMPgyqtRMTII@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCZHsMPgyqtRMTII@kroah.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-02-21, 10:17, Greg KH wrote:
> On Fri, Feb 12, 2021 at 02:39:26PM +0530, Viresh Kumar wrote:
> > On 12-02-21, 13:48, Pritthijit Nath wrote:
> > > This change fixes a checkpatch CHECK style issue for "Alignment should match
> > > open parenthesis".
> > > 
> > > Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> > > ---
> > >  drivers/staging/greybus/hid.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
> > > index ed706f39e87a..a56c3fb5d35a 100644
> > > --- a/drivers/staging/greybus/hid.c
> > > +++ b/drivers/staging/greybus/hid.c
> > > @@ -221,8 +221,8 @@ static void gb_hid_init_reports(struct gb_hid *ghid)
> > >  }
> > > 
> > >  static int __gb_hid_get_raw_report(struct hid_device *hid,
> > > -		unsigned char report_number, __u8 *buf, size_t count,
> > > -		unsigned char report_type)
> > > +				   unsigned char report_number, __u8 *buf, size_t count,
> > > +				   unsigned char report_type)
> > >  {
> > >  	struct gb_hid *ghid = hid->driver_data;
> > >  	int ret;
> > 
> > I can't even count the number of attempts we have seen in previous
> > years to make checkpatch --strict happy for greybus.
> > 
> > I say we make this change once and for all across greybus, so we don't
> > have to review or NAK someone afterwards.
> > 
> > Should I send a patch for this ?
> 
> Sure, but note that over time, checkpatch adds new things so there will
> always be something to change in here, until we move it out of the
> drivers/staging/ area :)

Right, though I wasn't worried about other checkpatch warning but
specially the "alignment - parenthesis" one. Everyone (specially
newbies) want to fix that everywhere :)

-- 
viresh
