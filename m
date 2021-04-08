Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFC20357DFB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhDHIW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:22:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:61098 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhDHIW6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:22:58 -0400
IronPort-SDR: t682/d3xdaMAImFzw2DgTKBdYw0vSXTJiYRdoxVg1smzs1/JLClNx8IWHOOeCGomNlPxGaMUog
 k+zoKpN4tfvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="181028767"
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="181028767"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2021 01:22:46 -0700
IronPort-SDR: z1/1PwhVcmfxJEbrVgjWsE8eSNzW+CTsJBrNvarhwgRIKhK/XLZleD8F9MXZcW6mYVxq88hJ66
 XJlCTD45AGbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,205,1613462400"; 
   d="scan'208";a="519764987"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2021 01:22:40 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Apr 2021 11:22:40 +0300
Date:   Thu, 8 Apr 2021 11:22:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v2 5/6] usb: typec: tcpm: Allow slow charging loops to
 comply to pSnkStby
Message-ID: <YG69UKTSgyHQHeFd@kuha.fi.intel.com>
References: <20210407200723.1914388-1-badhri@google.com>
 <20210407200723.1914388-5-badhri@google.com>
 <YG67d/YOuoBwK+bF@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG67d/YOuoBwK+bF@kuha.fi.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -4047,9 +4053,12 @@ static void run_state_machine(struct tcpm_port *port)
> >  		break;
> >  	case SNK_DISCOVERY:
> >  		if (port->vbus_present) {
> > -			tcpm_set_current_limit(port,
> > -					       tcpm_get_current_limit(port),
> > -					       5000);
> > +			u32 current_lim = (!port->slow_charger_loop ||
> > +					   (tcpm_get_current_limit(port) <=
> > +					    PD_P_SNK_STDBY_MW / 5)) ?
> > +				tcpm_get_current_limit(port) :
> > +				PD_P_SNK_STDBY_MW / 5;
> 
> Here the use of the ternary operator is not appropriate. Please try to
> clean that up somehow. Maybe something like this would be better?
> 
>                         u32 current_lim = tcpm_get_current_limit(port);
> 
> 			if (port->slow_charger_loop || (current_lim < PD_P_SNK_STDBY_MW / 5))
> 				current_lim = PD_P_SNK_STDBY_MW / 5;

Sorry, I mean:

			if (port->slow_charger_loop || (current_lim > PD_P_SNK_STDBY_MW / 5))
				current_lim = PD_P_SNK_STDBY_MW / 5;

thanks,

-- 
heikki
