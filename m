Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6BD3D56C1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233084AbhGZJCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 05:02:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233059AbhGZJCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:02:40 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2623EC061760
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:43:09 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t18so6561103qta.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jul 2021 02:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gm9MDCWEw7e+PC/EhPk/ZV70togbgzlK6hrCsaJi22s=;
        b=h1XmHLqZbNwNEydkXWgn0qhBXlVhsR9CKUO0shZ8lv7tvJfIvJMK+nLbUDlTeHR8Cx
         FFr2l+9seGXnsclZB4ieRlZE2nqciS7Q6VAYc7cWelyDTPTkbLHP3mQ3ar0SRofsHVDa
         NrlKetgQ1iCWoQ08PGgjeRYPZy0XUKt2d0UIHZBbQBB+Wpua0qTgT/2ELWr+wyx3GyNY
         GXcbjrAeyU8UXiN4HmRTq9UtS7ezJUCDwBTvtZtmcglStcU6FtD+7qb8E/2MtF6vsF0l
         W2u95W7SisAKJv9bcNU+tCIMqhNxvewtYtzgIa85Oza6QNQSw04UwZqgjEjtzd7WtNOg
         a6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gm9MDCWEw7e+PC/EhPk/ZV70togbgzlK6hrCsaJi22s=;
        b=pOZl7Fu/YdVVZA9njrDWUlXFthWRX/V/y9E5svDsceEvs+G0Dli+z4MzTGcC6M+7cu
         TnWcn6ctY6B0gk9XJpjVYDvdNrNYHrtGX8MKAbe21SnAd7c/QERqvO7VKuRnhUGKbBxY
         hEyS8RDvGFDgDzr42W3+Ab4UwbC3RLJYZEa917Ftu4I1FnTQRlVFgSq86MMaONFHNL5C
         K1HM1OR8aWj/iwh5ia+kfLJJOED7uWjD80O1XtijxQVhdWc+EGOxBZPW7UBV/XANpx7d
         O2nBms2HRV2TaN/MEhnZ1td7E2G65x3Wr8at9LWV5rhEKTnXGNvgouX+2fdloLivJ5+f
         BrEw==
X-Gm-Message-State: AOAM530JGJxjwb9xJrZc0eK7+usSqK1dA76PuoIRriz9DTgkFiXrO6t2
        8RT3oENSWiwD304VafmwlZkBEXAycrz5t8fdEvt/3w==
X-Google-Smtp-Source: ABdhPJyA8AOWI8DgXw5VqqzKx8xWc82FmYAOuhPdr9T01Sh9nG+7bPuMaG71HU1AddJ9uy2TfESUYKhs6BfFqSOIcWs=
X-Received: by 2002:ac8:5553:: with SMTP id o19mr14475678qtr.22.1627292587768;
 Mon, 26 Jul 2021 02:43:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210716093916.1516845-1-kyletso@google.com> <CAGZ6i=3PJ+aRzM7=c6f9oCaCjvdQ7GqtCn+dv7H0yC8WMoe+KA@mail.gmail.com>
 <66b76646-3c40-fb12-6678-6542c10caaa9@roeck-us.net>
In-Reply-To: <66b76646-3c40-fb12-6678-6542c10caaa9@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Mon, 26 Jul 2021 17:42:51 +0800
Message-ID: <CAGZ6i=1uqWZYKj0TEDpLQ1_6GMV5pJYC1LeKqB7w+K_3Xv1ZVg@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Support non-PD mode
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 24, 2021 at 3:07 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/23/21 10:18 AM, Kyle Tso wrote:
> > On Fri, Jul 16, 2021 at 5:39 PM Kyle Tso <kyletso@google.com> wrote:
> >>
> >> tcpm.c could work well without PD capabilities. Do not block the probe
>
> "could" is a bit vague. What is the use case ?
>

Just to enable the "capability" of a type-c port without PD support. I
will rephrase the message to be more specific.

> >> if capabilities are not defined in fwnode and skip the PD power
> >> negotiation in the state machine.
> >>
> >> Signed-off-by: Kyle Tso <kyletso@google.com>
> >> ---
> >
> > Hi, any comments about this patch?
> >
>
> First question would be if this is documented/standardized. More comments below.
>
> > thanks,
> > Kyle
> >
> >>   drivers/usb/typec/tcpm/tcpm.c | 50 ++++++++++++++++++++---------------
> >>   1 file changed, 29 insertions(+), 21 deletions(-)
> >>
> >> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> >> index 5b22a1c931a9..a42de5e17d24 100644
> >> --- a/drivers/usb/typec/tcpm/tcpm.c
> >> +++ b/drivers/usb/typec/tcpm/tcpm.c
> >> @@ -3914,6 +3914,8 @@ static void run_state_machine(struct tcpm_port *port)
> >>                  if (port->ams == POWER_ROLE_SWAP ||
> >>                      port->ams == FAST_ROLE_SWAP)
> >>                          tcpm_ams_finish(port);
> >> +               if (!port->nr_src_pdo)
> >> +                       tcpm_set_state(port, SRC_READY, 0);
> >>                  port->upcoming_state = SRC_SEND_CAPABILITIES;
> >>                  tcpm_ams_start(port, POWER_NEGOTIATION);
> >>                  break;
> >> @@ -4161,7 +4163,10 @@ static void run_state_machine(struct tcpm_port *port)
> >>                                  current_lim = PD_P_SNK_STDBY_MW / 5;
> >>                          tcpm_set_current_limit(port, current_lim, 5000);
> >>                          tcpm_set_charge(port, true);
> >> -                       tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> >> +                       if (!port->nr_snk_pdo)
> >> +                               tcpm_set_state(port, SNK_READY, 0);
> >> +                       else
> >> +                               tcpm_set_state(port, SNK_WAIT_CAPABILITIES, 0);
> >>                          break;
> >>                  }
> >>                  /*
> >> @@ -5939,15 +5944,17 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
> >>
> >>          /* Get source pdos */
> >>          ret = fwnode_property_count_u32(fwnode, "source-pdos");
> >> -       if (ret <= 0)
> >> -               return -EINVAL;
> >> +       if (ret < 0)
> >> +               ret = 0;
> >>
>
> This makes the capability properties optional. I think that would have
> to be documented.
>

Do you mean the documentation in dt-bindings? I think they have
already been optional?

> >>          port->nr_src_pdo = min(ret, PDO_MAX_OBJECTS);
> >> -       ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> >> -                                            port->src_pdo, port->nr_src_pdo);
> >> -       if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
> >> -                                           port->nr_src_pdo))
> >> -               return -EINVAL;
> >> +       if (port->nr_src_pdo) {
> >> +               ret = fwnode_property_read_u32_array(fwnode, "source-pdos",
> >> +                                                    port->src_pdo, port->nr_src_pdo);
> >> +               if ((ret < 0) || tcpm_validate_caps(port, port->src_pdo,
> >> +                                                   port->nr_src_pdo))
> >> +                       return -EINVAL;
> >> +       }
> >>
> >>          if (port->port_type == TYPEC_PORT_SRC)
> >>                  return 0;
> >> @@ -5963,19 +5970,21 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
> >>   sink:
> >>          /* Get sink pdos */
> >>          ret = fwnode_property_count_u32(fwnode, "sink-pdos");
> >> -       if (ret <= 0)
> >> -               return -EINVAL;
> >> +       if (ret < 0)
> >> +               ret = 0;
> >>
> >>          port->nr_snk_pdo = min(ret, PDO_MAX_OBJECTS);
> >> -       ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
> >> -                                            port->snk_pdo, port->nr_snk_pdo);
> >> -       if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
> >> -                                           port->nr_snk_pdo))
> >> -               return -EINVAL;
> >> +       if (port->nr_snk_pdo) {
> >> +               ret = fwnode_property_read_u32_array(fwnode, "sink-pdos",
> >> +                                                    port->snk_pdo, port->nr_snk_pdo);
> >> +               if ((ret < 0) || tcpm_validate_caps(port, port->snk_pdo,
> >> +                                                   port->nr_snk_pdo))
> >> +                       return -EINVAL;
> >>
> >> -       if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
> >> -               return -EINVAL;
> >> -       port->operating_snk_mw = mw / 1000;
> >> +               if (fwnode_property_read_u32(fwnode, "op-sink-microwatt", &mw) < 0)
> >> +                       return -EINVAL;
> >> +               port->operating_snk_mw = mw / 1000;
> >> +       }
> >>
> >>          port->self_powered = fwnode_property_read_bool(fwnode, "self-powered");
> >>
> >> @@ -6283,9 +6292,8 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
> >>          int err;
> >>
> >>          if (!dev || !tcpc ||
> >> -           !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc ||
> >> -           !tcpc->set_polarity || !tcpc->set_vconn || !tcpc->set_vbus ||
> >> -           !tcpc->set_pd_rx || !tcpc->set_roles || !tcpc->pd_transmit)
> >> +           !tcpc->get_vbus || !tcpc->set_cc || !tcpc->get_cc || !tcpc->set_polarity ||
> >> +           !tcpc->set_vconn || !tcpc->set_vbus || !tcpc->set_roles)
>
> With this change, if a driver does not define the necessary pd callbacks
> (set_pd_rx, pd_transmit), but its devicetree data does provide pdo properties,
> we'll get a nice crash.
>
> On top of that, I am quite sure that the set_pd_rx() callback is still called
> from various places even if neither sink-pdos nor source-pdos properties
> are defined.
>
> I think this really tries to handle two conditions: A low level driver that
> doesn't support PD, and a system where the low level driver does support PD
> but the system itself doesn't. And then there is the odd case where the system
> only supports either source or sink PD while claiming to support the other.
> Maybe it would make sense to separate both conditions, for example by introducing
> a new flag such as pd_supported to indicate that the system doesn't support the
> PD protocol.
>
> Guenter
>

Yes, your concern is correct and reasonable. I will send v2 to fix these.

thanks,
Kyle

> >>                  return ERR_PTR(-EINVAL);
> >>
> >>          port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
> >> --
> >> 2.32.0.402.g57bb445576-goog
> >>
>
