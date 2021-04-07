Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE1C33575A6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 22:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355983AbhDGUOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 16:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbhDGUOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 16:14:10 -0400
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6740BC061760
        for <linux-kernel@vger.kernel.org>; Wed,  7 Apr 2021 13:14:00 -0700 (PDT)
Received: by mail-ua1-x936.google.com with SMTP id m16so1381195uaq.4
        for <linux-kernel@vger.kernel.org>; Wed, 07 Apr 2021 13:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CuwA5DDBiBdqXrtVYclMzCLGSzTpOYNq7dYaDVgktOY=;
        b=Ovf8IDenzsH3TXNKitshzLy21hxzs3a2Zha0LJwXz6auHaFVk7uEae/EsR18I6d7u+
         fQM13up6BoxFE8xgL0IT71FWVGvEKy6MWvtuZyNLaIE73VUL0tNvkS2vDhK0/yj6Myyf
         cHnh95EPFy1vlws5mLRItvq5Ri/uxn+YiPk+yBj5D3cH0hGJ11IlF2FfM/+2YVshMQV8
         EOsFIl8gBLBmP0m9LDo6NcE/PfXyijlXEK21nonnSX1uBt7KDnrZ2sq4Taqigc1R7cvS
         EQXe8KTn4TwZ367zReSield7a2JddCxNi2WCt2hWp9EzNpFUw6tUDp4o9RSD+knUZAne
         1I2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CuwA5DDBiBdqXrtVYclMzCLGSzTpOYNq7dYaDVgktOY=;
        b=UBtRVkTEfMlhZOTFU6iEtAoZdDvVZvGA9ZADd+gb2+Jl4YHRkMghadOCXq1nUIovrJ
         wfZiyxJnmOku1AjTRnuW2HpLq2zBTsTQTp6jMhXYCrTwS0+hBloWwpqxliN+/pKoGkI4
         AKsiZtjlAPqmRs4UtFIQQwAYHGR8cov4bH5+4OXZQ/XB2qbF4bV/PQxYLyNkO2iJdRr1
         2UqHkEUQj22KNbr+vCIWfGMnqBCb8jhkeA8sSe5CTD9H7thI96sVxQre1YKPtiC/jvZ2
         qqiWwRYcT/+N6553oWiat6FFWS4V7iGFFa8jfuzVmRYlHcD6vUhly+g+lQblEwS3dycG
         mzUw==
X-Gm-Message-State: AOAM533qHtTNJTHi+k8P6dysv9G6w1o7yEDT3Di3byEqtFmX6gux8E8y
        IOh9Z5ZpP3qFKJ2KqeDVfTPtD/qA4qyUUFhtAFcmCQ==
X-Google-Smtp-Source: ABdhPJzV9R8oH0zGK0LMgHPtRJnREvu/AIeNHuCjWCH7XFr1auCUB5yuIVIPuGtmscQjKB8XJhtSBvXIWlyR/aBUyJU=
X-Received: by 2002:ab0:2555:: with SMTP id l21mr3574800uan.65.1617826439264;
 Wed, 07 Apr 2021 13:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210406013643.3280369-1-badhri@google.com> <20210406013643.3280369-2-badhri@google.com>
 <AM9PR10MB4134A5A4A0D34EC3F2C572BD80759@AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <AM9PR10MB4134A5A4A0D34EC3F2C572BD80759@AM9PR10MB4134.EURPRD10.PROD.OUTLOOK.COM>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 7 Apr 2021 13:13:24 -0700
Message-ID: <CAPTae5Lqv4E_w31gEWjqPB_-H9A=ed3NNhc=18psih_Vs1U4ug@mail.gmail.com>
Subject: Re: [PATCH v1 1/6] usb: typec: tcpm: Address incorrect values of tcpm
 psy for fixed supply
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

Hi Guenter and Adam,

Thanks for the reviews !
Fixed up the typo in V2.

Thanks,
Badhri

On Wed, Apr 7, 2021 at 9:04 AM Adam Thomson
<Adam.Thomson.Opensource@diasemi.com> wrote:
>
> On 06 April 2021 02:37, Badhri Jagan Sridharan wrote:
>
> > tcpm_pd_build_request overwrites current_limit and supply_voltage
> > even before port partner accepts the requests. This leaves stale
> > values in current_limit and supply_voltage that get exported by
> > "tcpm-source-psy-". Solving this problem by caching the request
> > values of current limit/supply voltage in req_current_limit
> > and req_supply_voltage. current_limit/supply_voltage gets updated
> > once the port partner accepts the request.
> >
> > Fixes: f2a8aa053c176 ("typec: tcpm: Represent source supply through
> > power_supply")
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
>
> Looks sensible, typo aside:
>
> Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>
> >  drivers/usb/typec/tcpm/tcpm.c | 17 ++++++++++-------
> >  1 file changed, 10 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index ca1fc77697fc..03eca5061132 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -389,7 +389,10 @@ struct tcpm_port {
> >       unsigned int operating_snk_mw;
> >       bool update_sink_caps;
> >
> > -     /* Requested current / voltage */
> > +     /* Requested current / voltage to the port partner */
> > +     u32 req_current_limit;
> > +     u32 req_supply_voltage;
> > +     /* Acutal current / voltage limit of the local port */
> >       u32 current_limit;
> >       u32 supply_voltage;
> >
> > @@ -2435,8 +2438,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port
> > *port,
> >               case SNK_TRANSITION_SINK:
> >                       if (port->vbus_present) {
> >                               tcpm_set_current_limit(port,
> > -                                                    port->current_limit,
> > -                                                    port->supply_voltage);
> > +                                                    port->req_current_limit,
> > +                                                    port->req_supply_voltage);
> >                               port->explicit_contract = true;
> >                               tcpm_set_auto_vbus_discharge_threshold(port,
> >
> > TYPEC_PWR_MODE_PD,
> > @@ -2545,8 +2548,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port
> > *port,
> >                       break;
> >               case SNK_NEGOTIATE_PPS_CAPABILITIES:
> >                       port->pps_data.active = true;
> > -                     port->supply_voltage = port->pps_data.out_volt;
> > -                     port->current_limit = port->pps_data.op_curr;
> > +                     port->req_supply_voltage = port->pps_data.out_volt;
> > +                     port->req_current_limit = port->pps_data.op_curr;
> >                       tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
> >                       break;
> >               case SOFT_RESET_SEND:
> > @@ -3195,8 +3198,8 @@ static int tcpm_pd_build_request(struct tcpm_port
> > *port, u32 *rdo)
> >                        flags & RDO_CAP_MISMATCH ? " [mismatch]" : "");
> >       }
> >
> > -     port->current_limit = ma;
> > -     port->supply_voltage = mv;
> > +     port->req_current_limit = ma;
> > +     port->req_supply_voltage = mv;
> >
> >       return 0;
> >  }
> > --
> > 2.31.0.208.g409f899ff0-goog
>
