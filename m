Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AD843C84E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241594AbhJ0LMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 07:12:46 -0400
Received: from mga14.intel.com ([192.55.52.115]:51870 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239506AbhJ0LMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 07:12:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10149"; a="230409327"
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="230409327"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2021 04:10:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,186,1631602800"; 
   d="scan'208";a="635683209"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 27 Oct 2021 04:10:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 27 Oct 2021 14:10:15 +0300
Date:   Wed, 27 Oct 2021 14:10:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Jack Pham <jackp@codeaurora.org>
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@google.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Badhri Jagan Sridharan <badhri@google.com>,
        "Gopal, Saranya" <saranya.gopal@intel.com>,
        "Regupathy, Rajaram" <rajaram.regupathy@intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/4] usb: typec: ucsi: Add support for PD cdev
Message-ID: <YXkzl+1mTA2pslN0@kuha.fi.intel.com>
References: <20211026143352.78387-1-heikki.krogerus@linux.intel.com>
 <20211026143352.78387-4-heikki.krogerus@linux.intel.com>
 <20211027010035.GA13345@jackp-linux.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211027010035.GA13345@jackp-linux.qualcomm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 06:00:35PM -0700, Jack Pham wrote:
> On Tue, Oct 26, 2021 at 05:33:51PM +0300, Heikki Krogerus wrote:
> >
> > -static int ucsi_get_src_pdos(struct ucsi_connector *con)
> > +int ucsi_read_pdos(struct ucsi_connector *con, int partner, int source, u32 *pdos)
> >  {
> > +	u32 pdo[PDO_MAX_OBJECTS];
> > +	int num_pdos;
> >  	int ret;
> >  
> >  	/* UCSI max payload means only getting at most 4 PDOs at a time */
> > -	ret = ucsi_get_pdos(con, 1, con->src_pdos, 0, UCSI_MAX_PDOS);
> > +	ret = ucsi_get_pdos(con, partner, source, pdo, 0, UCSI_MAX_PDOS);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	con->num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> > -	if (con->num_pdos < UCSI_MAX_PDOS)
> > -		return 0;
> > +	num_pdos = ret / sizeof(u32); /* number of bytes to 32-bit PDOs */
> > +	if (num_pdos < UCSI_MAX_PDOS)
> > +		goto done;
> >  
> >  	/* get the remaining PDOs, if any */
> > -	ret = ucsi_get_pdos(con, 1, con->src_pdos, UCSI_MAX_PDOS,
> > +	ret = ucsi_get_pdos(con, partner, source, pdo, UCSI_MAX_PDOS,
> >  			    PDO_MAX_OBJECTS - UCSI_MAX_PDOS);
> >  	if (ret < 0)
> >  		return ret;
> >  
> > -	con->num_pdos += ret / sizeof(u32);
> > +	num_pdos += ret / sizeof(u32);
> > +done:
> > +	memcpy(pdos, pdo, num_pdos * sizeof(pdo));
> > +
> > +	return num_pdos;
> > +}
> > +
> > +static int ucsi_get_src_pdos(struct ucsi_connector *con)
> > +{
> > +	int ret;
> > +
> > +	ret = ucsi_read_pdos(con, 0, 1, con->src_pdos);
> 
> Second parameter should be 1 right?  Original intent of get_src_pdos()
> is to retrieve the partner's source capabilities in order to populate
> the power_supply.  Passing 0 as the partner param here changes the
> behavior to retrieve the source PDOs of the port.

Sounds like there is a bug in the existing code. I'm not changing the
behviour in this patch.

> (BTW I'm going to send a quick patch for this to since this assumes that
> port is sink and partner is source; when it's the other way around we
> end up calling GET_PDOS on the sink partner when it might not even be
> source capable).

I'll check it...

thanks,

-- 
heikki
