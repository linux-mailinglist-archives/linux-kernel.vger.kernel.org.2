Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3D435AA3E
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Apr 2021 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234037AbhDJCLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 22:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhDJCLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 22:11:31 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E509BC061762;
        Fri,  9 Apr 2021 19:11:17 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id n140so7698345oig.9;
        Fri, 09 Apr 2021 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4Jsn3qF2+UaMiSK7HH/x+Y3Qp/7bu36LXZbU020P8zQ=;
        b=JOD7gH2XUE6GSDOTXBhRFMtf32uWYQ519orbOOfeBzOTro3tvd8w0qe7szH0gLLz5C
         wcGjF4nTxqvk85F8jbqRwCBTJrTDuK707GR65mirL8wl4L5cM+0K6BsSp3M5fFZ2j3AH
         4JJCcCxsrTaE2IB8aV2T42BX4R5jB6R6BBRaEu2IH9KojuWh6Qr+5fu6j3yPglpLKKut
         k+Czv33Q7dxiAv6+SbB96JzmPsVHaG+fgldUj7D52vV7sn21hMvaTzviSr2PGNKzYFKe
         n8pL8k4ntbiIH0AdgAvi0AlPcpuezmWsW6b1MXDsjw2P3wZMRqpbdo3OSMi+FzagB034
         H67w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=4Jsn3qF2+UaMiSK7HH/x+Y3Qp/7bu36LXZbU020P8zQ=;
        b=aOGvCSlanI3X/tReHqA06AqlHvCGbobYPoUgo0IeCVME8l8COR1bMuf1uaJBSp/SXt
         T8i4B5bDWUfQ1JXWlSDIm4uB3v6wLOfy/pdllOetmPUdZLnfnZDgGpAlu1cWoCL+bPmj
         S8+pWqmBCjm0lFpCL1pnWvbMz4NOHWdKz6bif4rSENl0YoDIjjPZ81IXkZgTONDVVzD4
         d5iaoT4dAQ28FlsnqSG6nPmh8x+5T5fxu7lK7fjupd62F2q/gINSY7A0C1NJrW34xtoa
         f/WbihVsOILe9hmgYtH3LlZT5qtuJk2sWlNS+VF4Y24OSlNGlrWI8IntEoONL0BzKShD
         vQDg==
X-Gm-Message-State: AOAM532CgEA4Uf2SfAV7Tegc6Ja8KngYIzR5/gsLjFUPR9G8nrOIVyBq
        elwbj2ZxHxF9NMul3jt7Gts=
X-Google-Smtp-Source: ABdhPJywTxvUZreZp2kuCgxByHayrkxcoxzX3vM8KZ5vJP8oD6Bp1/XPJ7gG4CTkRPYT2nO4y1vo7w==
X-Received: by 2002:aca:d941:: with SMTP id q62mr12120921oig.119.1618020677343;
        Fri, 09 Apr 2021 19:11:17 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x20sm858816oiv.35.2021.04.09.19.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Apr 2021 19:11:16 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH v2 4/6] usb: typec: tcpm: Honour pSnkStdby requirement
 during negotiation
To:     Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Kyle Tso <kyletso@google.com>
References: <20210407200723.1914388-1-badhri@google.com>
 <20210407200723.1914388-4-badhri@google.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <dbcd7316-24ad-af8a-4273-85609a1942ec@roeck-us.net>
Date:   Fri, 9 Apr 2021 19:11:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210407200723.1914388-4-badhri@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/21 1:07 PM, Badhri Jagan Sridharan wrote:
>>From PD Spec:
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

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/usb/typec/tcpm/tcpm.c | 17 +++++++++++++++++
>  include/linux/usb/pd.h        |  2 ++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index d1d03ee90d8f..770b2edd9a04 100644
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
> +			u32 stdby_ma = port->supply_voltage ? PD_P_SNK_STDBY_MW * 1000 /
> +				port->supply_voltage : 0;
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
> 

