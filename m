Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21FC832F845
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Mar 2021 05:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhCFEy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 23:54:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:53624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229919AbhCFEym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 23:54:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6459165004;
        Sat,  6 Mar 2021 04:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615006481;
        bh=Wa4Bw26HoIcAUd6ZQXNe09EtrI1nCHJH/RzeHCepf9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T+GwdOmNNFxHZ9hWHvqkj5fS11o8kpPGKjXzfrWPMKdxUCl5fyz9O6jlXDlbRU42p
         oSsJ+bIRcJS13KH3iSJdpAYGzZwWRL384hg9lWv5Eh0l8AoGT6P4ABK9n+s9hk9rxf
         r8Ttggw/m+bTeJnEVxlsFuvy3P5e6AJjiqLdMgm8dWaHFCSDBgN79LxcY6sXHcHEXd
         dXLdBSXpMJ+unfzLZg5hadmDYuYPBU7eqYxeIsxjTLcKtC4Oz3jhzeQsI8hVulILUS
         Yf2VWo56OdGrYXoVfy/eSCkrgitFv4dJrOhBMYbyIMb2Q6XHGXoYStcp4v3ADUbu2T
         Pz/tklQL58P2Q==
Date:   Fri, 5 Mar 2021 22:54:39 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] hwmon: (max6621) Fix fall-through warnings
 for Clang
Message-ID: <20210306045439.GA179425@embeddedor>
References: <20210305095258.GA141583@embeddedor>
 <20210306031847.GA192807@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306031847.GA192807@roeck-us.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On Fri, Mar 05, 2021 at 07:18:47PM -0800, Guenter Roeck wrote:
> On Fri, Mar 05, 2021 at 03:52:58AM -0600, Gustavo A. R. Silva wrote:
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> 
> I Acked those, thus assuming that they would be applied through some
> other tree. If that is not the case, you'll need to let me know. The
> resend only means to me that whatever tree was supposed to pick it up
> did not do it, but it doesn't result in any action from my side.

This was not directed at you, in particular. I'm resending this for
the cosideration of whomever is in charge of this code. If this is
not taken or ignored once again, I will consider adding this to
my own tree.

Thanks
--
Gustavo

> >  drivers/hwmon/max6621.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hwmon/max6621.c b/drivers/hwmon/max6621.c
> > index 367855d5edae..7821132e17fa 100644
> > --- a/drivers/hwmon/max6621.c
> > +++ b/drivers/hwmon/max6621.c
> > @@ -156,7 +156,7 @@ max6621_is_visible(const void *data, enum hwmon_sensor_types type, u32 attr,
> >  		default:
> >  			break;
> >  		}
> > -
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > -- 
> > 2.27.0
> > 
