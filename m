Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8A7E319B8C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 09:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbhBLIzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 03:55:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:33396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLIzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 03:55:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 610BB64DEA;
        Fri, 12 Feb 2021 08:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613120102;
        bh=5DdrQt2I6f4i7iwHXUZo7yH9lSLs4JCO3DtBvITNDV8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bgrfFRaTAKOAraq8MRjygYLI5URHjbf/7X9eVH5pyfAyOakFf6zKzEMJgphQIkLWg
         G6mXTN5Gps6vvV9ePXzRzb8UhxMRPavEKi/EntE2U3CkwrGskRZfDxXaPBUY0khHax
         ggamO3W/YuUniWcWYIbn2x0vkSFMHOyB6xbZCMbc=
Date:   Fri, 12 Feb 2021 09:54:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Pritthijit Nath <pritthijit.nath@icloud.com>,
        devel@driverdev.osuosl.org, elder@kernel.org, vireshk@kernel.org,
        linux-kernel@vger.kernel.org, greybus-dev@lists.linaro.org
Subject: Re: [PATCH 2/2] staging: greybus: Fixed a misspelling in hid.c
Message-ID: <YCZCY+UlzdwGU6pw@kroah.com>
References: <20210212081835.9497-1-pritthijit.nath@icloud.com>
 <20210212081835.9497-2-pritthijit.nath@icloud.com>
 <YCY/1LCP404AZxhm@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCY/1LCP404AZxhm@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 12, 2021 at 09:44:04AM +0100, Johan Hovold wrote:
> On Fri, Feb 12, 2021 at 01:48:35PM +0530, Pritthijit Nath wrote:
> > Fixed the spelling of 'transfered' to 'transferred'.
> > 
> > Signed-off-by: Pritthijit Nath <pritthijit.nath@icloud.com>
> > ---
> >  drivers/staging/greybus/hid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/staging/greybus/hid.c b/drivers/staging/greybus/hid.c
> > index a56c3fb5d35a..6b19ff4743a9 100644
> > --- a/drivers/staging/greybus/hid.c
> > +++ b/drivers/staging/greybus/hid.c
> > @@ -254,7 +254,7 @@ static int __gb_hid_output_raw_report(struct hid_device *hid, __u8 *buf,
> > 
> >  	ret = gb_hid_set_report(ghid, report_type, report_id, buf, len);
> >  	if (report_id && ret >= 0)
> > -		ret++; /* add report_id to the number of transfered bytes */
> > +		ret++; /* add report_id to the number of transferrid bytes */
> 
> You now misspelled transferred in a different way.

Oops, will go revert this, I need more coffee...
