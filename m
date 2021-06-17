Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1DE3AA8C8
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 03:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhFQBwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 21:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbhFQBwu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 21:52:50 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDE9C06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:50:41 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id z15so2112655vsn.13
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 18:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T4XUxb4X2jLRPJlgce1PUKbINkwgcyiSSmfRX55y3ro=;
        b=ZDqLAxpdz8/XV2AShxA4hfhKJV6WvaHUe4qsWjZdsv/gMVWoSKok+fdhKeN4I8JL4O
         kX/XUGFzirvnJh5Jq/pCF2iuO+ak1c9xhNX+IkVHJ4wVYp+SyWw5m2FAHLi2/bD+uct8
         MCw64kpOCcECw23Q3M0if1oB10ZCg/meJmwtYYK3qw71+Ax7POPbK87WEZpf+APmcG+W
         M4NtUgY1Bqh51pFcFOIFPzcvlwW/CjO88AGScnXBdSxEGC1dmT6kK1lcJG6AYkxwIkkL
         SK7E0JkeykUc44twXYWmE1HMmyJqNuYeSGnbo/AjmenNeLKQJtjITPLbB/OlpxMqZqvL
         SD/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T4XUxb4X2jLRPJlgce1PUKbINkwgcyiSSmfRX55y3ro=;
        b=Jqvm4eEws/DHT/6UrK+2E3qTzG2szP2OqskLjkmixkYwGTNoQKD00YsUHVKF95z6t6
         2fmFW20Zzppq+KZaFFGkmEho+LTDvx0HWRwJbmYOOi8Lla2QdD0GEFqg6w2F0BX7PHm7
         z2Wpxp/CNoetqi334d4E6cxo/PYTjIA7QnsO8HZVpzswolJnRSGcM1QZJ1V6HygQC2Yk
         m3Yz9M7TGMt2eCtAE+hyTki8FORamvsTtTCOYTneUjmvsLDn9NrkIs0plJdM6YmQpRHu
         9++T5Gumsb5xI1meOjBP+eg8DRzeiCrTrJXbGgc1RUjbMKy8SUr80rXKuK+kK9kbLFUW
         zHiQ==
X-Gm-Message-State: AOAM533DIAwXAQkdQ11eRQUi6AvE29uwQiHTvsBPDX3XDBXRb/+Hwxol
        MfwjRCOLG3W1ArBrfI12LUgi+R0FwHilK/WvKXlymQ==
X-Google-Smtp-Source: ABdhPJyFRSl6kVKplmXtWOV97NYN2Ps8o/fwzP+BshzExEMWH53ArDhx8EO4/LJHWDgjVj0+AWw4k/b/7JY51GZBCaY=
X-Received: by 2002:a05:6102:2378:: with SMTP id o24mr2460396vsa.12.1623894639745;
 Wed, 16 Jun 2021 18:50:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210616090102.1897674-1-kyletso@google.com> <YMn/x631dHngLxFw@kuha.fi.intel.com>
In-Reply-To: <YMn/x631dHngLxFw@kuha.fi.intel.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 16 Jun 2021 18:50:02 -0700
Message-ID: <CAPTae5LK0jM38roMfBz3OQ4SWK0f3h5qvmuoa=nqybjf5gjNmw@mail.gmail.com>
Subject: Re: [PATCH v3] usb: typec: tcpm: Relax disconnect threshold during
 power negotiation
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Kyle Tso <kyletso@google.com>, Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 6:42 AM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Jun 16, 2021 at 05:01:02PM +0800, Kyle Tso wrote:
> > If the voltage is being decreased in power negotiation, the Source will
> > set the power supply to operate at the new voltage level before sending
> > PS_RDY. Relax the threshold before sending Request Message so that it
> > will not race with Source which begins to adjust the voltage right after
> > it sends Accept Message (PPS) or tSrcTransition (25~35ms) after it sends
> > Accept Message (non-PPS).
> >
> > The real threshold will be set after Sink receives PS_RDY Message.
> >
> > Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
> > Cc: Badhri Jagan Sridharan <badhri@google.com>
> > Signed-off-by: Kyle Tso <kyletso@google.com>
>
> Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
>
> > ---
> > Changes in v3:
> > - move the timing of setting threshold for Fixed RDO as I did for PPS in
> >   v2, i.e. move it to tcpm_pd_send_request.
> > - add Cc: tag for Badhri
> > - update the commit message for the above changes
> >
> > Changes in v2:
> > - move the timing of setting threshold up to "before sending Request"
> >   for PPS power negotiation so that it won't race with the Source.
> > - PPS: if it fails to send the Request, fallback to previous threshold
> > - PPS: if the Source doesn't respond Accept, fallback to previous
> >   threshold
> > - update the commit message for above changes
> >
> >  drivers/usb/typec/tcpm/tcpm.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 197556038ba4..b1d310ab84c4 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -2604,6 +2604,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                       } else {
> >                               next_state = SNK_WAIT_CAPABILITIES;
> >                       }
> > +
> > +                     /* Threshold was relaxed before sending Request. Restore it back. */
> > +                     tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> > +                                                            port->pps_data.active,
> > +                                                            port->supply_voltage);
> >                       tcpm_set_state(port, next_state, 0);
> >                       break;
> >               case SNK_NEGOTIATE_PPS_CAPABILITIES:
> > @@ -2617,6 +2622,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                           port->send_discover)
> >                               port->vdm_sm_running = true;
> >
> > +                     /* Threshold was relaxed before sending Request. Restore it back. */
> > +                     tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> > +                                                            port->pps_data.active,
> > +                                                            port->supply_voltage);
> > +
> >                       tcpm_set_state(port, SNK_READY, 0);
> >                       break;
> >               case DR_SWAP_SEND:
> > @@ -3336,6 +3346,12 @@ static int tcpm_pd_send_request(struct tcpm_port *port)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /*
> > +      * Relax the threshold as voltage will be adjusted after Accept Message plus tSrcTransition.
> > +      * It is safer to modify the threshold here.
> > +      */
> > +     tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
> > +
> >       memset(&msg, 0, sizeof(msg));
> >       msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
> >                                 port->pwr_role,
> > @@ -3433,6 +3449,9 @@ static int tcpm_pd_send_pps_request(struct tcpm_port *port)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* Relax the threshold as voltage will be adjusted right after Accept Message. */
> > +     tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
> > +
> >       memset(&msg, 0, sizeof(msg));
> >       msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
> >                                 port->pwr_role,
> > @@ -4196,6 +4215,10 @@ static void run_state_machine(struct tcpm_port *port)
> >               port->hard_reset_count = 0;
> >               ret = tcpm_pd_send_request(port);
> >               if (ret < 0) {
> > +                     /* Restore back to the original state */
> > +                     tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> > +                                                            port->pps_data.active,
> > +                                                            port->supply_voltage);
> >                       /* Let the Source send capabilities again. */
> >                       tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> >               } else {
> > @@ -4206,6 +4229,10 @@ static void run_state_machine(struct tcpm_port *port)
> >       case SNK_NEGOTIATE_PPS_CAPABILITIES:
> >               ret = tcpm_pd_send_pps_request(port);
> >               if (ret < 0) {
> > +                     /* Restore back to the original state */
> > +                     tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> > +                                                            port->pps_data.active,
> > +                                                            port->supply_voltage);
> >                       port->pps_status = ret;
> >                       /*
> >                        * If this was called due to updates to sink
> > --
> > 2.32.0.272.g935e593368-goog
>
> --
> heikki
