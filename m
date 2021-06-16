Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7443F3A8EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 04:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhFPCM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 22:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhFPCM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 22:12:27 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E10C06175F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 19:10:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id c9so1138447qkm.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 19:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y/w/qb9Mmcto0feWg3hHcwChOztbEZEtyAyt33Ggpnw=;
        b=AhtG9GZyWbc/q1PGc9HjGVcAmV+41TtxHzj5t+3Ph52sRD/pGlCYW+sjvjtIBRcyaR
         wCew2MSr8r5xNYIaXdlWx9oxLahHZfapzWQiKYjBQ6fSBMSGM9h0/tvS8BHEsxZJUuIj
         UAT6KoFnPo7F6PD2Dj+qoxZHx44h01bdZB2msVwL65+hpE0vYPGKqBfV3OL6O/YuILgy
         RNTIGiIAEuTxVgwaM4vx6JfMuiXce0ZZficds5jppGNvxEhodMDwct9zId2GkUc2pKeB
         GqfqxE6g+d/e6kf1t+mtbbL70NgGCj+f8WdjOjloY4lnXkt1Xj8TwN4hvoE3LSSU0d8+
         mXZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y/w/qb9Mmcto0feWg3hHcwChOztbEZEtyAyt33Ggpnw=;
        b=c+vmYKfSzI10bwYqGx8hoVvkyNaftOVWFrFxOxQdVqc1PeLwZMNinn37hsK+t5IoyU
         G/yTr/TsuTRLr1y0c7YdoCdV+UPEgSTaqi4CtBEPYT8T/QiYWc+BIPanrOIPRyfcMskH
         nctjVfiDK9j4o/Ij5agPpQNzrzpQ9wQYwK8OhQVSdy6kbYd9N87Xhrxj5dGno4VnPKd5
         Ib/mswwWczs0OMPy10ahvT4zOS1eozlmRd/z89qbpom9DVZ0Rn+y8noyahP7o+hNFhCf
         gWoe7MmYtjAu/MhrQBMFQ9n7KWzf64fzZPwCf8DPSttlg34ZpQWTLZlRL5hdT4CL0YM0
         B/5w==
X-Gm-Message-State: AOAM5304n/+kAp1eHuIBbz6wMkwmxKSgFGcSGfhjb3P6zD6Z0VksDFDa
        Knc48CxWIjhILXVIrX+UsocvQ2AAQQ3KgfyhPWHkE643Qro=
X-Google-Smtp-Source: ABdhPJxn624+hqSsEqOdkotivlmpGN8MMuJI77+OdkHcgF9NV7hbyT64+pYo5Z8wx6Z91PrcR7GBZSL8tF6Jzru2TJw=
X-Received: by 2002:a37:8d82:: with SMTP id p124mr2779115qkd.212.1623809421219;
 Tue, 15 Jun 2021 19:10:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210615080817.1417169-1-kyletso@google.com> <CAPTae5JfhDdCjNh8jxE6XMsvV0cC3McH6Hx4MGoOgrcRrT94Vg@mail.gmail.com>
 <CAGZ6i=0RgyYJBvw7g+tGyFwBvBE-nV_WjpyZQ3HGToRgC-JhAQ@mail.gmail.com>
In-Reply-To: <CAGZ6i=0RgyYJBvw7g+tGyFwBvBE-nV_WjpyZQ3HGToRgC-JhAQ@mail.gmail.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Wed, 16 Jun 2021 10:10:04 +0800
Message-ID: <CAGZ6i=19ShZr36rgUVv6m=CogpqbQB_mB37ae4j8_B47ORcvag@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Relax disconnect threshold during
 power negotiation
To:     Badhri Jagan Sridharan <badhri@google.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2021 at 9:16 AM Kyle Tso <kyletso@google.com> wrote:
>
> On Wed, Jun 16, 2021 at 2:06 AM Badhri Jagan Sridharan
> <badhri@google.com> wrote:
> >
> > On Tue, Jun 15, 2021 at 1:08 AM Kyle Tso <kyletso@google.com> wrote:
> > >
> > > If the voltage is being decreased in power negotiation, the Source will
> > > set the power supply to operate at the new voltage level before sending
> > > PS_RDY. For non-PPS negotiation, relax the disconnect threshold on Sink
> > > after receiving Accept Message to ensure the relaxed setting is enabled
> > > before the voltage collapse. For PPS, relax the threshold before
> > > sending Request Message so that it will not race with Source which
> > > begins to adjust the voltage right after it sends Accept Message.
> > >
> > > The real threshold will be set after Sink receives PS_RDY Message.
> > >
> > > Fixes: f321a02caebd ("usb: typec: tcpm: Implement enabling Auto Discharge disconnect support")
> > > Cc: Badhri Jagan Sridharan <badhri@google.com>
> > > Signed-off-by: Kyle Tso <kyletso@google.com>
> > > ---
> > > Changes since v1:
> > > - move the timing of setting threshold up to "before sending Request"
> > >   for PPS power negotiation so that it won't race with the Source.
> > > - PPS: if it fails to send the Request, fallback to previous threshold
> > > - PPS: if the Source doesn't respond Accept, fallback to previous
> > >   threshold
> > > - update the commit message for above changes
> > >
> > >  drivers/usb/typec/tcpm/tcpm.c | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > >
> > > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > > index 0db685d5d9c0..00f3fd7c05d6 100644
> > > --- a/drivers/usb/typec/tcpm/tcpm.c
> > > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > > @@ -2599,6 +2599,11 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> > >                             port->send_discover)
> > >                                 port->vdm_sm_running = true;
> > >
> > > +                       /* Threshold was relaxed before sending Request. Restore it back. */
> > > +                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> > > +                                                              port->pps_data.active,
> > > +                                                              port->supply_voltage);
> > > +
> > >                         tcpm_set_state(port, SNK_READY, 0);
> > >                         break;
> > >                 case DR_SWAP_SEND:
> > > @@ -2646,6 +2651,8 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> > >                 switch (port->state) {
> > >                 case SNK_NEGOTIATE_CAPABILITIES:
> > >                         port->pps_data.active = false;
> > > +                       /* Voltage is going to be at new level. Relax the threshold here. */
> > > +                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
> > >                         tcpm_set_state(port, SNK_TRANSITION_SINK, 0);
> > >                         break;
> > >                 case SNK_NEGOTIATE_PPS_CAPABILITIES:
> > > @@ -3423,6 +3430,9 @@ static int tcpm_pd_send_pps_request(struct tcpm_port *port)
> > >         if (ret < 0)
> > >                 return ret;
> > >
> > > +       /* Relax the threshold as voltage will be adjusted right after Accept Message. */
> > This makes sense. Shouldn't we have the same approach for
> > tcpm_pd_send_request as it's equally applicable for fixed RDO as well
> > ?
> >
>
> I don't think we need to do that because for the power negotiation
> using Fixed RDO, the voltage adjustment from Source side takes place
> after the time sending Accept Message plus tSrcTransition (25~35ms).
> So setting the threshold after the Sink gets Accept Message should be
> enough.
>
> thanks,
> Kyle
>

Ah, I know your concern here. So you were saying that the
tSrcTransition may not be enough in some situations so it is better to
do the similar thing for Fixed RDO?

Yeah it makes sense. I will do it in v3.

thanks,
Kyle

> > > +       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB, false, 0);
> > > +
> > >         memset(&msg, 0, sizeof(msg));
> > >         msg.header = PD_HEADER_LE(PD_DATA_REQUEST,
> > >                                   port->pwr_role,
> > > @@ -4196,6 +4206,10 @@ static void run_state_machine(struct tcpm_port *port)
> > >         case SNK_NEGOTIATE_PPS_CAPABILITIES:
> > >                 ret = tcpm_pd_send_pps_request(port);
> > >                 if (ret < 0) {
> > > +                       /* Restore back to the original state */
> > > +                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> > > +                                                              port->pps_data.active,
> > > +                                                              port->supply_voltage);
> > >                         port->pps_status = ret;
> > >                         /*
> > >                          * If this was called due to updates to sink
> > > --
> > > 2.32.0.272.g935e593368-goog
> > >
