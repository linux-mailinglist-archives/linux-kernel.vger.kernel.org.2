Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38CE319BB7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230014AbhBLJSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:18:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229906AbhBLJST (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:18:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 89D4664DE3;
        Fri, 12 Feb 2021 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613121458;
        bh=nx2t2Rhxo+mIa8vXQ7tFMumzY+Z/RjMflfQJ9Of/Y10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zqgm3NCRGXK9oa/oeBU8VAQQf6f1NpX7j4U7xuM9kgllYOAv2QoSWBuSmSCz3drPW
         PAtHg2WKZawEk7Ik+/18sZ05WJ1QobAZw9HQMTd4ScbOBPY549XikHdV/khDDOHpQw
         N+hqolVWEuMj2yeHfukPnkElB+3zwDUAjlGSyLGM=
Date:   Fri, 12 Feb 2021 10:17:36 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Pritthijit Nath <pritthijit.nath@icloud.com>,
        devel@driverdev.osuosl.org, elder@kernel.org, vireshk@kernel.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org
Subject: Re: [PATCH 1/2] staging: greybus: Fixed alignment issue in hid.c
Message-ID: <YCZHsMPgyqtRMTII@kroah.com>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
 <20210212090926.ox763j3btrqfzzzj@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212090926.ox763j3btrqfzzzj@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:39:26PM +0530, Viresh Kumar wrote:
> On 12-02-21, 13:48, Pritthijit Nath wrote:
> > This change fixes a checkpatch CHECK style issue for "Alignment should match
> > open parenthesis".
> > 
> > Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> > ---
> >  drivers/staging/greybus/hid.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
> > index ed706f39e87a..a56c3fb5d35a 100644
> > --- a/drivers/staging/greybus/hid.c
> > +++ b/drivers/staging/greybus/hid.c
> > @@ -221,8 +221,8 @@ static void gb_hid_init_reports(struct gb_hid *ghid)
> >  }
> > 
> >  static int __gb_hid_get_raw_report(struct hid_device *hid,
> > -		unsigned char report_number, __u8 *buf, size_t count,
> > -		unsigned char report_type)
> > +				   unsigned char report_number, __u8 *buf, size_t count,
> > +				   unsigned char report_type)
> >  {
> >  	struct gb_hid *ghid = hid->driver_data;
> >  	int ret;
> 
> I can't even count the number of attempts we have seen in previous
> years to make checkpatch --strict happy for greybus.
> 
> I say we make this change once and for all across greybus, so we don't
> have to review or NAK someone afterwards.
> 
> Should I send a patch for this ?

Sure, but note that over time, checkpatch adds new things so there will
always be something to change in here, until we move it out of the
drivers/staging/ area :)

I need to go fix up the greybus vibrator patch which was my first
attempt at getting back into that effort...

thanks,

greg k-h
