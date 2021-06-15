Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483083A883E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 20:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbhFOSIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230395AbhFOSId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 14:08:33 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E007CC061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:06:27 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id e7so2943596uaj.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aOg3E7jLmBz73M6FBFxAYrSApy90TU4R7zapm0VeCMA=;
        b=cohEqd+mZ+OCO2EzJTSqNTHjYwbN8G6Owa8YsT8hfMW0TRu52jNEW6Z+ZT1LmCIi+Z
         d233e1a80EvfQZx2F2kaUpxcZPBa0TAjCB6eyM9v160Bo+OMcMSjoukO+rsK6T4bm2ck
         nlzjkuPXXzVvcaGKXtf+XGgqXn8nZx3K7khI1SB4H8TMjLhauMHN2+6xTMGI4OWlqu4g
         8USxVAr6/abxtJZx2J8UFXfCHEY/jSiwH4uWcoem2RJ/qm7WJ88cSzcR+0GYvfhTzm/A
         rFF3Z1JRhY/tZ78rLciLKT9XDxKrEGxkfnAPe3ts4lcYuykJYwKoP5PomhJY6V4uHIqi
         SCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aOg3E7jLmBz73M6FBFxAYrSApy90TU4R7zapm0VeCMA=;
        b=fPJF1+MzQswjj1AajpRTio4WB/3RjT9+ogVbv7O1BKMYNRQyMstd8QC0RZ4oTLl3mp
         k3rLS3Amjc+t22lbkFrf9lrhVuOsHzwpuz1quBL8KIrEQhGid7b4nEV06h5RwpzEOiZB
         g3To9S9KBw4zL1U1gBsVRONcqZqjjz2mfEtHLIuzR4U2samCOvotOPWPp3id+GISv52Y
         Sy0x7iCnk9PV/ES1hd0EDbVQH/CW4G3yvVr59xVIGzheM4GjA13o4xkltlUHNmOmAcEG
         EnS3ooTDqRNrgZ5p31fLr2YWZ+kStI8W7WAa9RUe8WGVf3OCmGbv7aPnkI4WqMhFKNTC
         ZQDw==
X-Gm-Message-State: AOAM5330TEzs+YPxXDHwvweH3OOhGTYPuPAGmCS4pTUXlTIjm/C7bdwJ
        rt1oTEwXCYkriOwjA4URt+3iDns4Of7Ip725V5TvYg==
X-Google-Smtp-Source: ABdhPJx4ghWrsqelGftYAX3bznSQyz2Y8fSYFpMua0AM+kRd8/3mJtPvbWDwKA0nk1CdvAvMjNYEHigj3nIY3JJRncE=
X-Received: by 2002:ab0:6998:: with SMTP id t24mr530338uaq.72.1623780386878;
 Tue, 15 Jun 2021 11:06:26 -0700 (PDT)
MIME-Version: 1.0
References: <20210615080817.1417169-1-kyletso@google.com>
In-Reply-To: <20210615080817.1417169-1-kyletso@google.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 15 Jun 2021 11:05:50 -0700
Message-ID: <CAPTae5JfhDdCjNh8jxE6XMsvV0cC3McH6Hx4MGoOgrcRrT94Vg@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Relax disconnect threshold during
 power negotiation
To:     Kyle Tso <kyletso@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 15, 2021 at 1:08 AM Kyle Tso <kyletso@google.com> wrote:
>
> If the voltage is being decreased in power negotiation, the Source will
> set the power supply to operate at the new voltage level before sending
> PS_RDY. For non-PPS negotiation, relax the disconnect threshold on Sink
> after receiving Accept Message to ensure the relaxed setting is enabled
> before the voltage collapse. For PPS, relax the threshold before
> sending Request Message so that it will not race with Source which
> begins to adjust the voltage right after it sends Accept Message.
>
> The real threshold will be set after Sink receives PS_RDY Message.
>
> Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
> Cc: Badhri Jagan Sridharan <badhri@google.com>
> Signed-off-by: Kyle Tso <kyletso@google.com>
> ---
> Changes since v1:
> - move the timing of setting threshold up to "before sending Request"
>   for PPS power negotiation so that it won't race with the Source.
> - PPS: if it fails to send the Request, fallback to previous threshold
> - PPS: if the Source doesn't respond Accept, fallback to previous
>   threshold
> - update the commit message for above changes
>
>  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> index 0db685d5d9c0..00f3fd7c05d6 100644
> --- a/drivers/usb/typec/tcpm/tcpm.c
> +++ b/drivers/usb/typec/tcpm/tcpm.c
> @@ -2599,6 +2599,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>                             port->send_discover)
>                                 port->vdm_sm_running = true;
>
> +                       /* Threshold was relaxed before sending Request. Restore it back. */
> +                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> +                                                              port->pps_data.active,
> +                                                              port->supply_voltage);
> +
>                         tcpm_set_state(port, SNK_READY, 0);
>                         break;
>                 case DR_SWAP_SEND:
> @@ -2646,6 +2651,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
>                 switch (port->state) {
>                 case SNK_NEGOTIATE_CAPABILITIES:
>                         port->pps_data.active = false;
> +                       /* Voltage is going to be at new level. Relax the threshold here. */
> +                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
>                         tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
>                         break;
>                 case SNK_NEGOTIATE_PPS_CAPABILITIES:
> @@ -3423,6 +3430,9 @@ static int tcpm_pd_send_pps_request(struct tcpm_port *port)
>         if (ret < 0)
>                 return ret;
>
> +       /* Relax the threshold as voltage will be adjusted right after Accept Message. */
This makes sense. Shouldn't we have the same approach for
tcpm_pd_send_request as it's equally applicable for fixed RDO as well
?

> +       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
> +
>         memset(&msg, 0, sizeof(msg));
>         msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
>                                   port->pwr_role,
> @@ -4196,6 +4206,10 @@ static void run_state_machine(struct tcpm_port *port)
>         case SNK_NEGOTIATE_PPS_CAPABILITIES:
>                 ret = tcpm_pd_send_pps_request(port);
>                 if (ret < 0) {
> +                       /* Restore back to the original state */
> +                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> +                                                              port->pps_data.active,
> +                                                              port->supply_voltage);
>                         port->pps_status = ret;
>                         /*
>                          * If this was called due to updates to sink
> --
> 2.32.0.272.g935e593368-goog
>
