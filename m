Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3045F30B9DB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhBBI1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:27:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:32311 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232592AbhBBI07 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:26:59 -0500
IronPort-SDR: LXc+73g490csAUslmTaZ8WdeIir4ywLmdZY6Xg7z3XZb00ZIhPSuUk97YMJcO7m745hewhx4zf
 E3BEjP3ZDhcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="160583550"
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="160583550"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2021 00:25:13 -0800
IronPort-SDR: 9G5TpLdVoAZ64S15wl7c3zTe2XvX6oKeCc4Knq1Nx2aJ3d9E2FnGgtpvTP8nvxzHCktptUvW01
 FqdFW9FLU0ZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,394,1602572400"; 
   d="scan'208";a="479482501"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 02 Feb 2021 00:25:10 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 02 Feb 2021 10:25:09 +0200
Date:   Tue, 2 Feb 2021 10:25:09 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyle Tso <kyletso@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: Set in_ams flag when Source caps
 have been received
Message-ID: <20210202082509.GD1433721@kuha.fi.intel.com>
References: <20210202033859.258491-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202033859.258491-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 01, 2021 at 07:38:59PM -0800, Badhri Jagan Sridharan wrote:
> Receiving the first packet in an AMS sequence signals the
> beginning of AMS. Set in_ams flag to true when SRC_CAPS are
> received during POWER_NEGOTIATION AMS.
> This fixes the failure flagged while running TD.PD.SNK.E9
> compliance test.
> 
> >From Deterministic PD compliance MOI spec:
> TD.PD.SNK.E9. GetSinkCap in Place of Accept
> Description:
> As Provider, the Tester intentionally sends a GetSinkCap message in place
> of Accept message and verifies the UUT will send a SoftReset and recover
> from the error.
> Steps:
> a) Run PROC.PD.E1 Bring-up according to the UUT role.
> b) The Tester cycles VBus.
> c) The Tester sends a Source Capabilities message to the UUT.
> d) Upon receipt of a Request message from the UUT, the Tester replies with
>    a GoodCRC message.
> e) The Tester sends a GetSinkCap message to the UUT.
> f) If a SoftReset is not received within 15 ms after the GetSinkCap EOP was
>    sent, the test fails.
> g) If a SoftReset is received timely, the Tester replies with an Accept
>    message.
> h) The Tester sends Source Capabilities message to the UUT repeatedly until
>    nCapsCount reached or a GoodCRC is received. If nCapsCount reached, the
>    test fails.
> i) If a Request is not received timely within 30 ms after the GoodCRC EOP
>    corresponding to Source Capabilities message was received, the test
>    fails.
> 
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0afd8ef692e8..b3e07d9b7597 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2243,6 +2243,7 @@ static void tcpm_pd_data_request(struct tcpm_port *port,
>  		 * handled.
>  		 */
>  			port->ams = POWER_NEGOTIATION;
> +			port->in_ams = true;
>  			tcpm_set_state(port, SNK_NEGOTIATE_CAPABILITIES, 0);
>  		} else {
>  			if (port->ams == GET_SOURCE_CAPABILITIES)
> -- 
> 2.30.0.365.g02bc693789-goog

thanks,

-- 
heikki
