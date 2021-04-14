Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F0635EEE1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 10:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349295AbhDNH4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:56:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:19253 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349264AbhDNHz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:55:59 -0400
IronPort-SDR: KMtODFqoEYvpfITMQL7G+VY8wJ8DLUeICuifuVZyrI85cKwz0ocnnqk7cudtZR96wT++HF0Umc
 A677HM4eD9QQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="174695705"
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="174695705"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2021 00:55:32 -0700
IronPort-SDR: ZWdC0ZEJtqy5sq9ILc91wOLjQ8sy2dmwBjcy9ifAvNuazvxlO962Nmhy3oENw0kZ3/ja1ov47q
 /+R7jn0YTzXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,221,1613462400"; 
   d="scan'208";a="521905472"
Received: from kuha.fi.intel.com ([10.237.72.162])
  by fmsmga001.fm.intel.com with SMTP; 14 Apr 2021 00:55:27 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 14 Apr 2021 10:55:26 +0300
Date:   Wed, 14 Apr 2021 10:55:26 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
Subject: Re: [PATCH v3 1/3] usb: typec: tcpm: Honour pSnkStdby requirement
 during negotiation
Message-ID: <YHaf7napPf02d21j@kuha.fi.intel.com>
References: <20210414024000.4175263-1-badhri@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210414024000.4175263-1-badhri@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2021 at 07:39:58PM -0700, Badhri Jagan Sridharan wrote:
> >From PD Spec:
> The Sink Shall transition to Sink Standby before a positive or
> negative voltage transition of VBUS. During Sink Standby
> the Sink Shall reduce its power draw to pSnkStdby. This allows
> the Source to manage the voltage transition as well as
> supply sufficient operating current to the Sink to maintain PD
> operation during the transition. The Sink Shall
> complete this transition to Sink Standby within tSnkStdby
> after evaluating the Accept Message from the Source. The
> transition when returning to Sink operation from Sink Standby
> Shall be completed within tSnkNewPower. The
> pSnkStdby requirement Shall only apply if the Sink power draw
> is higher than this level.
> 
> The above requirement needs to be met to prevent hard resets
> from port partner.
> 
> Without the patch: (5V/3A during SNK_DISCOVERY all the way through
> explicit contract)
> [   95.711984] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> [   95.712007] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [   95.712017] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> [   95.837190] VBUS on
> [   95.882075] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
> [   95.882082] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AMS]
> [   95.882086] polarity 1
> [   95.883151] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:5000 ret:0
> [   95.883441] enable vbus discharge ret:0
> [   95.883445] Requesting mux state 1, usb-role 2, orientation 2
> [   95.883776] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [   95.883879] pending state change SNK_STARTUP -> SNK_DISCOVERY @ 500 ms [rev3 NONE_AMS]
> [   96.038960] VBUS on
> [   96.383939] state change SNK_STARTUP -> SNK_DISCOVERY [delayed 500 ms]
> [   96.383946] Setting voltage/current limit 5000 mV 3000 mA
> [   96.383961] vbus=0 charge:=1
> [   96.386044] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES [rev3 NONE_AMS]
> [   96.386309] pending state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND @ 450 ms [rev3 NONE_AMS]
> [   96.394404] PD RX, header: 0x2161 [1]
> [   96.394408]  PDO 0: type 0, 5000 mV, 3000 mA [E]
> [   96.394410]  PDO 1: type 0, 9000 mV, 2000 mA []
> [   96.394412] state change SNK_WAIT_CAPABILITIES -> SNK_NEGOTIATE_CAPABILITIES [rev2 POWER_NEGOTIATION]
> [   96.394416] Setting usb_comm capable false
> [   96.395083] cc=0 cc1=0 cc2=5 vbus=0 vconn=sink polarity=1
> [   96.395089] Requesting PDO 1: 9000 mV, 2000 mA
> [   96.395093] PD TX, header: 0x1042
> [   96.397404] PD TX complete, status: 0
> [   96.397424] pending state change SNK_NEGOTIATE_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev2 POWER_NEGOTIATION]
> [   96.400826] PD RX, header: 0x363 [1]
> [   96.400829] state change SNK_NEGOTIATE_CAPABILITIES -> SNK_TRANSITION_SINK [rev2 POWER_NEGOTIATION]
> [   96.400832] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 500 ms [rev2 POWER_NEGOTIATION]
> [   96.577315] PD RX, header: 0x566 [1]
> [   96.577321] Setting voltage/current limit 9000 mV 2000 mA
> [   96.578363] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9000 ret:0
> [   96.578370] state change SNK_TRANSITION_SINK -> SNK_READY [rev2 POWER_NEGOTIATION]
> 
> With the patch:
> [  168.398573] CC1: 0 -> 0, CC2: 0 -> 5 [state TOGGLING, polarity 0, connected]
> [  168.398605] state change TOGGLING -> SNK_ATTACH_WAIT [rev3 NONE_AMS]
> [  168.398619] pending state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED @ 170 ms [rev3 NONE_AMS]
> [  168.522348] VBUS on
> [  168.568676] state change SNK_ATTACH_WAIT -> SNK_DEBOUNCED [delayed 170 ms]
> [  168.568684] state change SNK_DEBOUNCED -> SNK_ATTACHED [rev3 NONE_AMS]
> [  168.568688] polarity 1
> [  168.569867] set_auto_vbus_discharge_threshold mode:0 pps_active:n vbus:5000 ret:0
> [  168.570158] enable vbus discharge ret:0
> [  168.570161] Requesting mux state 1, usb-role 2, orientation 2
> [  168.570504] state change SNK_ATTACHED -> SNK_STARTUP [rev3 NONE_AMS]
> [  168.570634] pending state change SNK_STARTUP -> SNK_DISCOVERY @ 500 ms [rev3 NONE_AMS]
> [  169.070689] state change SNK_STARTUP -> SNK_DISCOVERY [delayed 500 ms]
> [  169.070695] Setting voltage/current limit 5000 mV 3000 mA
> [  169.070702] vbus=0 charge:=1
> [  169.072719] state change SNK_DISCOVERY -> SNK_WAIT_CAPABILITIES [rev3 NONE_AMS]
> [  169.073145] pending state change SNK_WAIT_CAPABILITIES -> HARD_RESET_SEND @ 450 ms [rev3 NONE_AMS]
> [  169.077162] PD RX, header: 0x2161 [1]
> [  169.077172]  PDO 0: type 0, 5000 mV, 3000 mA [E]
> [  169.077178]  PDO 1: type 0, 9000 mV, 2000 mA []
> [  169.077183] state change SNK_WAIT_CAPABILITIES -> SNK_NEGOTIATE_CAPABILITIES [rev2 POWER_NEGOTIATION]
> [  169.077191] Setting usb_comm capable false
> [  169.077753] cc=0 cc1=0 cc2=5 vbus=0 vconn=sink polarity=1
> [  169.077759] Requesting PDO 1: 9000 mV, 2000 mA
> [  169.077762] PD TX, header: 0x1042
> [  169.079990] PD TX complete, status: 0
> [  169.080013] pending state change SNK_NEGOTIATE_CAPABILITIES -> HARD_RESET_SEND @ 60 ms [rev2 POWER_NEGOTIATION]
> [  169.083183] VBUS on
> [  169.084195] PD RX, header: 0x363 [1]
> [  169.084200] state change SNK_NEGOTIATE_CAPABILITIES -> SNK_TRANSITION_SINK [rev2 POWER_NEGOTIATION]
> [  169.084206] Setting standby current 5000 mV @ 500 mA
> [  169.084209] Setting voltage/current limit 5000 mV 500 mA
> [  169.084220] pending state change SNK_TRANSITION_SINK -> HARD_RESET_SEND @ 500 ms [rev2 POWER_NEGOTIATION]
> [  169.260222] PD RX, header: 0x566 [1]
> [  169.260227] Setting voltage/current limit 9000 mV 2000 mA
> [  169.261315] set_auto_vbus_discharge_threshold mode:3 pps_active:n vbus:9000 ret:0
> [  169.261321] state change SNK_TRANSITION_SINK -> SNK_READY [rev2 POWER_NEGOTIATION]
> [  169.261570] AMS POWER_NEGOTIATION finished
> 
> Fixes: f0690a25a140b ("staging: typec: USB Type-C Port Manager (tcpm)")
> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes since V2:
> * Refactored code based on Heikki's suggestion
> * Added reviewed-by tag from Guenter
> ---
>  drivers/usb/typec/tcpm/tcpm.c | 17 +++++++++++++++++
>  include/linux/usb/pd.h        |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 1c32bdf62852..aedc8bb9532a 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -4131,6 +4131,23 @@ static void run_state_machine(struct tcpm_port *port)
>  		}
>  		break;
>  	case SNK_TRANSITION_SINK:
> +		/* From the USB PD spec:
> +		 * "The Sink Shall transition to Sink Standby before a positive or
> +		 * negative voltage transition of VBUS. During Sink Standby
> +		 * the Sink Shall reduce its power draw to pSnkStdby."
> +		 *
> +		 * This is not applicable to PPS though as the port can continue
> +		 * to draw negotiated power without switching to standby.
> +		 */
> +		if (port->supply_voltage != port->req_supply_voltage && !port->pps_data.active &&
> +		    port->current_limit * port->supply_voltage / 1000 > PD_P_SNK_STDBY_MW) {
> +			u32 stdby_ma = PD_P_SNK_STDBY_MW * 1000 / port->supply_voltage;
> +
> +			tcpm_log(port, "Setting standby current %u mV @ %u mA",
> +				 port->supply_voltage, stdby_ma);
> +			tcpm_set_current_limit(port, stdby_ma, port->supply_voltage);
> +		}
> +		fallthrough;
>  	case SNK_TRANSITION_SINK_VBUS:
>  		tcpm_set_state(port, hard_reset_state(port),
>  			       PD_T_PS_TRANSITION);
> diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> index 70d681918d01..bf00259493e0 100644
> --- a/include/linux/usb/pd.h
> +++ b/include/linux/usb/pd.h
> @@ -493,4 +493,6 @@ static inline unsigned int rdo_max_power(u32 rdo)
>  #define PD_N_CAPS_COUNT		(PD_T_NO_RESPONSE / PD_T_SEND_SOURCE_CAP)
>  #define PD_N_HARD_RESET_COUNT	2
>  
> +#define PD_P_SNK_STDBY_MW	2500	/* 2500 mW */
> +
>  #endif /* __LINUX_USB_PD_H */
> -- 
> 2.31.1.295.g9ea45b61b8-goog

thanks,

-- 
heikki
