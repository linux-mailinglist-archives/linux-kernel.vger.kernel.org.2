Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9A5319BF6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 10:39:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbhBLJho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 04:37:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:42628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230159AbhBLJhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 04:37:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFFF564E35;
        Fri, 12 Feb 2021 09:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613122620;
        bh=k+sD9g+C9OoEZjpy98wT9p5d57Ljl1iCOjkEB7l8r5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VS1dHBF7Y0JLEvlrqgySoazU9r/jeE/VIBjABUsx2juDNgoJdgAKKibxqPsizzToo
         HcU/juhsbiGN9DIVSZJL2DdVrIWLUJBwQRqakSO9mlmUqZ0Ice0NrCnzaWR9rZgc9w
         vOTrhY0+CJI3qbB4EuC/d1U/ddj7rFgo08Px340I=
Date:   Fri, 12 Feb 2021 10:36:57 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     devel@driverdev.osuosl.org, elder@kernel.org, vireshk@kernel.org,
        johan@kernel.org, linux-kernel@vger.kernel.org,
        greybus-dev@lists.linaro.org,
        Pritthijit Nath <pritthijit.nath@icloud.com>
Subject: Re: [PATCH 1/2] staging: greybus: Fixed alignment issue in hid.c
Message-ID: <YCZMOQdVDk7mStBy@kroah.com>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
 <20210212090926.ox763j3btrqfzzzj@vireshk-i7>
 <YCZHsMPgyqtRMTII@kroah.com>
 <20210212092130.cxo6tuess6msf4kb@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210212092130.cxo6tuess6msf4kb@vireshk-i7>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 02:51:30PM +0530, Viresh Kumar wrote:
> On 12-02-21, 10:17, Greg KH wrote:
> > On Fri, Feb 12, 2021 at 02:39:26PM +0530, Viresh Kumar wrote:
> > > On 12-02-21, 13:48, Pritthijit Nath wrote:
> > > > This change fixes a checkpatch CHECK style issue for "Alignment should match
> > > > open parenthesis".
> > > > 
> > > > Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> > > > ---
> > > >  drivers/staging/greybus/hid.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
> > > > index ed706f39e87a..a56c3fb5d35a 100644
> > > > --- a/drivers/staging/greybus/hid.c
> > > > +++ b/drivers/staging/greybus/hid.c
> > > > @@ -221,8 +221,8 @@ static void gb_hid_init_reports(struct gb_hid *ghid)
> > > >  }
> > > > 
> > > >  static int __gb_hid_get_raw_report(struct hid_device *hid,
> > > > -		unsigned char report_number, __u8 *buf, size_t count,
> > > > -		unsigned char report_type)
> > > > +				   unsigned char report_number, __u8 *buf, size_t count,
> > > > +				   unsigned char report_type)
> > > >  {
> > > >  	struct gb_hid *ghid = hid->driver_data;
> > > >  	int ret;
> > > 
> > > I can't even count the number of attempts we have seen in previous
> > > years to make checkpatch --strict happy for greybus.
> > > 
> > > I say we make this change once and for all across greybus, so we don't
> > > have to review or NAK someone afterwards.
> > > 
> > > Should I send a patch for this ?
> > 
> > Sure, but note that over time, checkpatch adds new things so there will
> > always be something to change in here, until we move it out of the
> > drivers/staging/ area :)
> 
> Right, though I wasn't worried about other checkpatch warning but
> specially the "alignment - parenthesis" one. Everyone (specially
> newbies) want to fix that everywhere :)

Sure, fix it up "right" if you want to, I'll take coding style fixes
from anyone :)
