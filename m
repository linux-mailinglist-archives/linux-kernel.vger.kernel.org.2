Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBF5F33192E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 22:16:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhCHVQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 16:16:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229901AbhCHVPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 16:15:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 490CD64FA9;
        Mon,  8 Mar 2021 21:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615238134;
        bh=wgi4ixB+/HuhHipnwGcBia2Ldp0HKcclvEzilpijVm4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vp5XNZZWupcAon7ycuZxhO7fdD2GjZ8HsVG6KAu7YXzNE6CSumTw86o0jjNTElkGD
         rQYw5+VvLDkJDdLCYHkjpMowycO6SFULV4NTRwVwYYkc1IkQoybBhprFpFD/XMuorc
         i+fQGkTvzlJ1ITGbAGJ52+3bS7n9mpe40E9TBPWo9Wv++IadsEJi5UvyL8WviVu575
         vwoE2yz0fVotco38m9DDWDpUIl2b8j0iJlcWw63XuStiKo+fnEmw+zss+NXLvz+IIu
         WsMe3eIfnTZNF9a0VB2m6juQNa4Qp99U3XR0wCrJinT6YRzgNsIL+r/Y5Y3rbvni/c
         5JSH7Tp28mFWA==
Date:   Mon, 8 Mar 2021 15:15:32 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH RESEND][next] hwmon: (corsair-cpro) Fix fall-through
 warnings for Clang
Message-ID: <20210308211532.GB214076@embeddedor>
References: <20210305095359.GA141682@embeddedor>
 <107682713.BXpLqza3Di@marius>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <107682713.BXpLqza3Di@marius>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2021 at 11:39:35AM +0100, Marius Zachmann wrote:
> On 06.03.21 at 10:53:59 CET, Gustavo A. R. Silva wrote
> > In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> > by explicitly adding a break statement instead of letting the code fall
> > through to the next case.
> > 
> > Link: https://github.com/KSPP/linux/issues/115
> > Acked-by: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Acked-by: Marius Zachmann <mail@mariuszachmann.de>

Thanks, Marius.

--
Gustavo

> 
> > ---
> >  drivers/hwmon/corsair-cpro.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> > index 591929ec217a..fa6aa4fc8b52 100644
> > --- a/drivers/hwmon/corsair-cpro.c
> > +++ b/drivers/hwmon/corsair-cpro.c
> > @@ -310,6 +310,7 @@ static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
> >  		default:
> >  			break;
> >  		}
> > +		break;
> >  	default:
> >  		break;
> >  	}
> > 
> 
> 
> 
> 
