Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB7E357598
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349223AbhDGUND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbhDGUNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:13:02 -0400
Received: from mail-vk1-xa36.google.com (mail-vk1-xa36.google.com [IPv6:2607:f8b0:4864:20::a36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63C7C061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:12:52 -0700 (PDT)
Received: by mail-vk1-xa36.google.com with SMTP id h69so16676vke.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KJfsWVKW3ZQ9+VO3yuES/2F3xtsvRFu1g+bTYItuJHU=;
        b=pIzz2WPVo69d7w1ewQatkgIdh6gjmGOtKt0O6O0Gs9Z3o5CurypxTrRTj5a/XJcU4b
         04OKA2SuuNzivEwPV8ApTaqE6Vf6ZsJ406PMNGus2NsFOX27YolBuh17eXvIggEuLaQ6
         LizaLXluYgTyrfUyqw9fcShTliBDuf0XAEygG7FmgUtgun3mQc9VzsXVQZbtCxqqFqzK
         fS9yLaN2XtPWBhkttBLPKBnUxCFoAZlKWLMX8hkk+GjSamrNtkSS5bRPC0ja+I9xmGaR
         0IP5G/v9cjNtxnY0beaD9q14q1M0byE4FUUO2utcwap5RNCKXRWx/CCWky8bhPz0xLBX
         7a5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KJfsWVKW3ZQ9+VO3yuES/2F3xtsvRFu1g+bTYItuJHU=;
        b=GnzP2Kbstp1KiPbXa/lMHJiEWPZKF5MgkUnvI0Dx+BkGQFL6ZNpWjT0LQRxDLg8KEp
         /x9CTvu0EkfYLFrGTsHJg+J5oZs4nTDmevbinxcApbnBhwA+HGrP0g3iQe2EyI2R0fbm
         FXUaoukgIklNQh2aP0lw38h16LQCyQZfAo+4Ei+Ar/NWCQXuxupQZdC0Ec5oL6hQVnTg
         pxqwDMI5kb5il5vWYqdvnLQR5XWdaZCG6D1EPRpvdsgFUcy08b+1vsJvFohkz3drPsQo
         sVJ92u1emNQV02uW1qiFKqy4WW/kDQ0dvJ79DfIK1fE7KxFIYPmDwtyE+TwQ9VM4ze1E
         K9iw==
X-Gm-Message-State: AOAM532subtNoyWZwdIs7fEDLNdkahJs6nAN+0H3CQH1eyLMHLN9PvV0
        ZMU3i9kqDo9MrS/apOLXB55YcfWvLUtcNg5X5DIqzA==
X-Google-Smtp-Source: ABdhPJz8R0XAuI6qhmJ3r+Kb2nnC91gONhf1dMYmAvHfW8+3rdNo1k8WwE4R1rafHq/iJjKxHyZZ6KQ3V8mI8qbmJ/8=
X-Received: by 2002:a1f:ad58:: with SMTP id w85mr3448935vke.22.1617826371876;
 Wed, 07 Apr 2021 13:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210406013643.3280369-1-badhri@google.com> <20210406013643.3280369-3-badhri@google.com>
 <AM9PR10MB41340A8F754CB05B0DABB78880759@AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM9PR10MB41340A8F754CB05B0DABB78880759@AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 7 Apr 2021 13:12:16 -0700
Message-ID: <CAPTae5K1oW0AE1mn4j_+rdyoqHgrppajMd-74FCDgzZ-D0f8ag@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] usb: typec: tcpm: Address incorrect values of tcpm
 psy for pps supply
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Kyle Tso <kyletso@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Moved to kerneldoc header in V2.

Thanks,
Badhri

On Wed, Apr 7, 2021 at 9:07 AM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 06 April 2021 02:37, Badhri Jagan Sridharan wrote:
>
> > tcpm_pd_select_pps_apdo overwrites port->pps_data.min_volt,
> > port->pps_data.max_volt, port->pps_data.max_curr even before
> > port partner accepts the requests. This leaves incorrect values
> > in current_limit and supply_voltage that get exported by
> > "tcpm-source-psy-". Solving this problem by caching the request
> > values in req_min_volt, req_max_volt, req_max_curr, req_out_volt,
> > req_op_curr. min_volt, max_volt, max_curr gets updated once the
> > partner accepts the request. current_limit, supply_voltage gets updated
> > once local port's tcpm enters SNK_TRANSITION_SINK when the accepted
> > current_limit and supply_voltage is enforced.
> >
> > Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through
> > power_supply")
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>
> >  drivers/usb/typec/tcpm/tcpm.c | 84 ++++++++++++++++++++---------------
> >  1 file changed, 49 insertions(+), 35 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 03eca5061132..d43774cc2ccf 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -269,11 +269,22 @@ struct pd_mode_data {
> >  };
> >
> >  struct pd_pps_data {
> > +     /* Actual min voltage at the local port */
> >       u32 min_volt;
> > +     /* Requested min voltage to the port partner */
> > +     u32 req_min_volt;
> > +     /* Actual max voltage at the local port */
> >       u32 max_volt;
> > +     /* Requested max voltage to the port partner */
> > +     u32 req_max_volt;
> > +     /* Actual max current at the local port */
> >       u32 max_curr;
> > -     u32 out_volt;
> > -     u32 op_curr;
> > +     /* Requested max current of the port partner */
> > +     u32 req_max_curr;
> > +     /* Requested output voltage to the port partner */
> > +     u32 req_out_volt;
> > +     /* Requested operating current to the port partner */
> > +     u32 req_op_curr;
> >       bool supported;
> >       bool active;
> >  };
> > @@ -2498,8 +2509,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port
> > *port,
> >                       break;
> >               case SNK_NEGOTIATE_PPS_CAPABILITIES:
> >                       /* Revert data back from any requested PPS updates */
> > -                     port->pps_data.out_volt = port->supply_voltage;
> > -                     port->pps_data.op_curr = port->current_limit;
> > +                     port->pps_data.req_out_volt = port->supply_voltage;
> > +                     port->pps_data.req_op_curr = port->current_limit;
> >                       port->pps_status = (type == PD_CTRL_WAIT ?
> >                                           -EAGAIN : -EOPNOTSUPP);
> >
> > @@ -2548,8 +2559,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port
> > *port,
> >                       break;
> >               case SNK_NEGOTIATE_PPS_CAPABILITIES:
> >                       port->pps_data.active = true;
> > -                     port->req_supply_voltage = port->pps_data.out_volt;
> > -                     port->req_current_limit = port->pps_data.op_curr;
> > +                     port->pps_data.min_volt = port-
> > >pps_data.req_min_volt;
> > +                     port->pps_data.max_volt = port-
> > >pps_data.req_max_volt;
> > +                     port->pps_data.max_curr = port-
> > >pps_data.req_max_curr;
> > +                     port->req_supply_voltage = port-
> > >pps_data.req_out_volt;
> > +                     port->req_current_limit = port->pps_data.req_op_curr;
> >                       tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
> >                       break;
> >               case SOFT_RESET_SEND:
> > @@ -3108,16 +3122,16 @@ static unsigned int tcpm_pd_select_pps_apdo(struct
> > tcpm_port *port)
> >               src = port->source_caps[src_pdo];
> >               snk = port->snk_pdo[snk_pdo];
> >
> > -             port->pps_data.min_volt =
> > max(pdo_pps_apdo_min_voltage(src),
> > -                                           pdo_pps_apdo_min_voltage(snk));
> > -             port->pps_data.max_volt =
> > min(pdo_pps_apdo_max_voltage(src),
> > -                                           pdo_pps_apdo_max_voltage(snk));
> > -             port->pps_data.max_curr = min_pps_apdo_current(src, snk);
> > -             port->pps_data.out_volt = min(port->pps_data.max_volt,
> > -                                           max(port->pps_data.min_volt,
> > -                                               port->pps_data.out_volt));
> > -             port->pps_data.op_curr = min(port->pps_data.max_curr,
> > -                                          port->pps_data.op_curr);
> > +             port->pps_data.req_min_volt =
> > max(pdo_pps_apdo_min_voltage(src),
> > +
> > pdo_pps_apdo_min_voltage(snk));
> > +             port->pps_data.req_max_volt =
> > min(pdo_pps_apdo_max_voltage(src),
> > +
> > pdo_pps_apdo_max_voltage(snk));
> > +             port->pps_data.req_max_curr = min_pps_apdo_current(src,
> > snk);
> > +             port->pps_data.req_out_volt = min(port->pps_data.max_volt,
> > +                                               max(port->pps_data.min_volt,
> > +                                                   port-
> > >pps_data.req_out_volt));
> > +             port->pps_data.req_op_curr = min(port->pps_data.max_curr,
> > +                                              port->pps_data.req_op_curr);
> >               power_supply_changed(port->psy);
> >       }
> >
> > @@ -3245,10 +3259,10 @@ static int tcpm_pd_build_pps_request(struct
> > tcpm_port *port, u32 *rdo)
> >                       tcpm_log(port, "Invalid APDO selected!");
> >                       return -EINVAL;
> >               }
> > -             max_mv = port->pps_data.max_volt;
> > -             max_ma = port->pps_data.max_curr;
> > -             out_mv = port->pps_data.out_volt;
> > -             op_ma = port->pps_data.op_curr;
> > +             max_mv = port->pps_data.req_max_volt;
> > +             max_ma = port->pps_data.req_max_curr;
> > +             out_mv = port->pps_data.req_out_volt;
> > +             op_ma = port->pps_data.req_op_curr;
> >               break;
> >       default:
> >               tcpm_log(port, "Invalid PDO selected!");
> > @@ -3295,8 +3309,8 @@ static int tcpm_pd_build_pps_request(struct tcpm_port
> > *port, u32 *rdo)
> >       tcpm_log(port, "Requesting APDO %d: %u mV, %u mA",
> >                src_pdo_index, out_mv, op_ma);
> >
> > -     port->pps_data.op_curr = op_ma;
> > -     port->pps_data.out_volt = out_mv;
> > +     port->pps_data.req_op_curr = op_ma;
> > +     port->pps_data.req_out_volt = out_mv;
> >
> >       return 0;
> >  }
> > @@ -5429,7 +5443,7 @@ static int tcpm_try_role(struct typec_port *p, int role)
> >       return ret;
> >  }
> >
> > -static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 op_curr)
> > +static int tcpm_pps_set_op_curr(struct tcpm_port *port, u16 req_op_curr)
> >  {
> >       unsigned int target_mw;
> >       int ret;
> > @@ -5447,12 +5461,12 @@ static int tcpm_pps_set_op_curr(struct tcpm_port
> > *port, u16 op_curr)
> >               goto port_unlock;
> >       }
> >
> > -     if (op_curr > port->pps_data.max_curr) {
> > +     if (req_op_curr > port->pps_data.max_curr) {
> >               ret = -EINVAL;
> >               goto port_unlock;
> >       }
> >
> > -     target_mw = (op_curr * port->pps_data.out_volt) / 1000;
> > +     target_mw = (req_op_curr * port->supply_voltage) / 1000;
> >       if (target_mw < port->operating_snk_mw) {
> >               ret = -EINVAL;
> >               goto port_unlock;
> > @@ -5466,10 +5480,10 @@ static int tcpm_pps_set_op_curr(struct tcpm_port
> > *port, u16 op_curr)
> >       }
> >
> >       /* Round down operating current to align with PPS valid steps */
> > -     op_curr = op_curr - (op_curr % RDO_PROG_CURR_MA_STEP);
> > +     req_op_curr = req_op_curr - (req_op_curr %
> > RDO_PROG_CURR_MA_STEP);
> >
> >       reinit_completion(&port->pps_complete);
> > -     port->pps_data.op_curr = op_curr;
> > +     port->pps_data.req_op_curr = req_op_curr;
> >       port->pps_status = 0;
> >       port->pps_pending = true;
> >       mutex_unlock(&port->lock);
> > @@ -5490,7 +5504,7 @@ static int tcpm_pps_set_op_curr(struct tcpm_port
> > *port, u16 op_curr)
> >       return ret;
> >  }
> >
> > -static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 out_volt)
> > +static int tcpm_pps_set_out_volt(struct tcpm_port *port, u16 req_out_volt)
> >  {
> >       unsigned int target_mw;
> >       int ret;
> > @@ -5508,13 +5522,13 @@ static int tcpm_pps_set_out_volt(struct tcpm_port
> > *port, u16 out_volt)
> >               goto port_unlock;
> >       }
> >
> > -     if (out_volt < port->pps_data.min_volt ||
> > -         out_volt > port->pps_data.max_volt) {
> > +     if (req_out_volt < port->pps_data.min_volt ||
> > +         req_out_volt > port->pps_data.max_volt) {
> >               ret = -EINVAL;
> >               goto port_unlock;
> >       }
> >
> > -     target_mw = (port->pps_data.op_curr * out_volt) / 1000;
> > +     target_mw = (port->current_limit * req_out_volt) / 1000;
> >       if (target_mw < port->operating_snk_mw) {
> >               ret = -EINVAL;
> >               goto port_unlock;
> > @@ -5528,10 +5542,10 @@ static int tcpm_pps_set_out_volt(struct tcpm_port
> > *port, u16 out_volt)
> >       }
> >
> >       /* Round down output voltage to align with PPS valid steps */
> > -     out_volt = out_volt - (out_volt % RDO_PROG_VOLT_MV_STEP);
> > +     req_out_volt = req_out_volt - (req_out_volt %
> > RDO_PROG_VOLT_MV_STEP);
> >
> >       reinit_completion(&port->pps_complete);
> > -     port->pps_data.out_volt = out_volt;
> > +     port->pps_data.req_out_volt = req_out_volt;
> >       port->pps_status = 0;
> >       port->pps_pending = true;
> >       mutex_unlock(&port->lock);
> > @@ -5589,8 +5603,8 @@ static int tcpm_pps_activate(struct tcpm_port *port,
> > bool activate)
> >
> >       /* Trigger PPS request or move back to standard PDO contract */
> >       if (activate) {
> > -             port->pps_data.out_volt = port->supply_voltage;
> > -             port->pps_data.op_curr = port->current_limit;
> > +             port->pps_data.req_out_volt = port->supply_voltage;
> > +             port->pps_data.req_op_curr = port->current_limit;
> >       }
> >       mutex_unlock(&port->lock);
> >
> > --
> > 2.31.0.208.g409f899ff0-goog
>
