Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEBE230DD44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 15:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbhBCOwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 09:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233026AbhBCOw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 09:52:27 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C859EC061573;
        Wed,  3 Feb 2021 06:51:46 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id i20so86164otl.7;
        Wed, 03 Feb 2021 06:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=BRejbMppl3GOr40VHRSG/ViReSyva6umu7DgyW7KvL8=;
        b=I62tbZ/KgBL57yQJJ96NvX5FIBOPy3iM6O9E5607p8fJaxmkSqbIOh2HK4M+Ch0eo2
         LxEIK76+/MTj4qlPjpX90Za/6ztCnGAN7NQB8xJqiZjE7r/c/dNYMy4nWY1SMyr5qC4O
         I1fLUe9JuoEET3Ng0wvsnodZB2+TQhQZ/a4Kz8mmtTly82LhYoP3PKWCbtscf6wD1bAv
         5ihpkm0wF2Je6N6xnkjDlgAOM36N8Ehghi0VArTvhKMPqqellXCw2t0Ugo7dw5Xlzybs
         5RIY1Araa9+qB3ygG6T/fYqrBndy9BzMNNiPAlsYtRe54Dv/d/Fx4yoY5pdcPG8x4FJH
         wG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=BRejbMppl3GOr40VHRSG/ViReSyva6umu7DgyW7KvL8=;
        b=TNeUP1JQ4Go8meTHw+J33CoJGmvQdWzOojEOMYDxeB17u3aZTDXNpEB3+dcSKJ13Zj
         +mvJLodDTJpdAe9eeY5voxv6/stRn6Lh2j952q2jaxrTGvwfswoY+ygZDkvW6jEZvjp0
         QZDURCdGukQNJzxC2mWQtbj59j1Yx8g3Hfp8aH117KYnzrVzuhisU02N/vSmuE+tlvxs
         zzYV/PUdeODuuHgiMOcQtOQogVXXPY8hnZ6v+em2duSUeoK5R4Oe0EpkdIZ5Fx0fdURg
         yiuvH4yJnXCrW92QtfTGSPLtYIiTd9lpbVQ1Qaq19NPDvhwEcMrI9phnEwocUxLw4hj4
         wZUQ==
X-Gm-Message-State: AOAM533zeSvHUC74b1ou7MVks8h3o1skRyxeFvjHslCBw03YS/GV6WxI
        hNZ8J3VIZLbAo98flhn5sp0=
X-Google-Smtp-Source: ABdhPJybpn87WDF/YX1SjCKImWLRZK8nGsvxetJ3HkHDT55b1TINbO5FihfC7//g0Ih5lZ/NrXjscg==
X-Received: by 2002:a9d:51ca:: with SMTP id d10mr1129574oth.327.1612363906270;
        Wed, 03 Feb 2021 06:51:46 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id z20sm448531oth.55.2021.02.03.06.51.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 03 Feb 2021 06:51:45 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 3 Feb 2021 06:51:43 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Kyle Tso <kyletso@google.com>, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, robh+dt@kernel.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v5 1/8] usb: typec: Manage SVDM version
Message-ID: <20210203145143.GA58095@roeck-us.net>
References: <20210202161733.932215-1-kyletso@google.com>
 <20210202161733.932215-2-kyletso@google.com>
 <20210203124724.GD1687065@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203124724.GD1687065@kuha.fi.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 03, 2021 at 02:47:24PM +0200, Heikki Krogerus wrote:
> Hi Kyle,
> 
> On Wed, Feb 03, 2021 at 12:17:26AM +0800, Kyle Tso wrote:
> > PD Spec Revision 3.0 Version 2.0 + ECNs 2020-12-10
> >   6.4.4.2.3 Structured VDM Version
> >   "The Structured VDM Version field of the Discover Identity Command
> >   sent and received during VDM discovery Shall be used to determine the
> >   lowest common Structured VDM Version supported by the Port Partners or
> >   Cable Plug and Shall continue to operate using this Specification
> >   Revision until they are Detached."
> > 
> > Add a variable in typec_capability to specify the highest SVDM version
> > supported by the port and another variable in typec_port to cache the
> > negotiated SVDM version between the port partners.
> > 
> > Also add setter/getter functions for the negotiated SVDM version.
> > 
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  drivers/usb/typec/class.c | 13 +++++++++++++
> >  include/linux/usb/typec.h | 10 ++++++++++
> >  2 files changed, 23 insertions(+)
> > 
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index b6ceab3dc16b..42d1be1eece9 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -51,6 +51,7 @@ struct typec_port {
> >  	enum typec_role			vconn_role;
> >  	enum typec_pwr_opmode		pwr_opmode;
> >  	enum typec_port_type		port_type;
> > +	enum usb_pd_svdm_ver		svdm_version;
> >  	struct mutex			port_type_lock;
> 
> I just realized that you are storing that in the port object. I guess
> we don't have to change this right now, but it would have been more
> clear to store that in the partner object IMO.
> 
> >  	enum typec_orientation		orientation;
> > @@ -1841,6 +1842,18 @@ int typec_find_port_data_role(const char *name)
> >  }
> >  EXPORT_SYMBOL_GPL(typec_find_port_data_role);
> >  
> > +void typec_set_svdm_version(struct typec_port *port, enum usb_pd_svdm_ver ver)
> > +{
> > +	port->svdm_version = ver;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_set_svdm_version);
> > +
> > +enum usb_pd_svdm_ver typec_get_svdm_version(struct typec_port *port)
> > +{
> > +	return port->svdm_version;
> > +}
> > +EXPORT_SYMBOL_GPL(typec_get_svdm_version);
> 
> You need to document those exported functions! You need to do that in
> any case, but in this case it's very important, because the purpose of
> these functions is not clear from the ctx.

Thinking about it, would it make make sense to define the functions as
static inline ?

Thanks,
Guenter

> 
> I'm sorry for noticing that so late. Since you do need to fix that,
> please see if you can also store that detail in the partner device
> object instead of the port object.
> 
> thanks,
> 
> -- 
> heikki
