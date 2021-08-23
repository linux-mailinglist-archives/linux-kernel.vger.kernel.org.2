Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEFF3F45AB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 09:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235100AbhHWHPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 03:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhHWHPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 03:15:54 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCEFC061756
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:15:12 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id x5so16169015ill.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 00:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SQ2Uwhj6FDqhZFG4Jra0608BEmKaZpqCAcRucXb8YWg=;
        b=ETLmekkWV6Pon4W4wBtnJMeVdWXIVCU1y/9bdRkJA1igZeahWh2OrXa1SQxWUmlPje
         TIuW3ZUM19S+jrBNC3DNGNCJ7kR2hwYBBTmGpnexHVPr6GLllMAajvrK//fe48fJNl6G
         qKV8JKS+evmZ45f6duL4Qzvw/shZg0hwhtmx+RTuEFdW/QP3tzFEwD6kD7CiNV/PSNyD
         hAfh9TfHZkdbEu+bxVxQZL3YXYyKdz366t+CO17h9PkCb+03BT1eLX7OrOZeb7KofZ4q
         8jph3QZap6aR/QUugEtJknXccRBqKcNgnLmSY3iRnARa5xPlmJVAdLMXR0BKU55ej2ft
         B/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SQ2Uwhj6FDqhZFG4Jra0608BEmKaZpqCAcRucXb8YWg=;
        b=g+QdZcvLRVFW81qJBCsYWAGLyYlSC3Jhr0/cD5hMdB8+0DptcdLRjGQbz2+sn2OAoT
         WvIjLWlDvxscUeQkbda+tST/xdq1al7JzHqcslDWspMpFzAID2mjORz1sH3u0V+piQK2
         JYuGCBagyTOEvszfCMeR/kt+YJEzFIjZaW/tynM+zynIT4NcIVBL34zogN7eshYA23JA
         dEN61+drA/M5bk5y5VLdpEXBjNztbYCea5ZUR/7fPlf3YwJ1xIQjWjAC2kUr6BqpTPKh
         YAiR0Yx+/ykVSECJVKyJskyznolvwo9GZwjgXU1e80qi71/wepkO1Y1wY1rWA+E1WbWE
         X7Bw==
X-Gm-Message-State: AOAM533tzYKa+YJZ4PmVjwHY/h8/fE9xsJDQg9Rr7fc3fhqv3fsr7E+5
        DNrh7gL/Cmsp0mywFPBTtl6KvGOt4fy21uRIEbD5cQ==
X-Google-Smtp-Source: ABdhPJwF3KEbUND0vBJu6PjaBVMYCTAXB5wrKTM/Vs5g9Sqw2xCE+VAP1/H2QMLEqWBlPUv4wBdmv1hd038+ZQVNx6g=
X-Received: by 2002:a92:cb0f:: with SMTP id s15mr21046449ilo.59.1629702911172;
 Mon, 23 Aug 2021 00:15:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210816075449.2236547-1-kyletso@google.com> <05b01a2e-b1ee-4111-2e3c-897990544c0a@roeck-us.net>
In-Reply-To: <05b01a2e-b1ee-4111-2e3c-897990544c0a@roeck-us.net>
From:   Kyle Tso <kyletso@google.com>
Date:   Mon, 23 Aug 2021 15:14:55 +0800
Message-ID: <CAGZ6i=0+-Ga2gz2iXOaNv9fCTKJgG=jFXZ7B=i=6wChGqMubbw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Raise vdm_sm_running flag only when VDM
 SM is running
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        badhri@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 10:17 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 8/16/21 12:54 AM, Kyle Tso wrote:
> > If the port is going to send Discover_Identity Message, vdm_sm_running
> > flag was intentionally set before entering Ready States in order to
> > avoid the conflict because the port and the port partner might start
> > AMS at almost the same time after entering Ready States.
> >
> > However, the original design has a problem. When the port is doing
> > DR_SWAP from Device to Host, it raises the flag. Later in the
> > tcpm_send_discover_work, the flag blocks the procedure of sending the
> > Discover_Identity and it might never be cleared until disconnection.
> >
> > Since there exists another flag send_discover representing that the port
> > is going to send Discover_Identity or not, it is enough to use that flag
> > to prevent the conflict. Also change the timing of the set/clear of
> > vdm_sm_running to indicate whether the VDM SM is actually running or
> > not.
> >
> > Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from dedicated work")
> > Cc: Badhri Jagan Sridharan <badhri@google.com>
> > Signed-off-by: Kyle Tso <kyletso@google.com>
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>

Hi Greg,

Do I need to modify something for this patch?

thanks,
Kyle

> > ---
> >   drivers/usb/typec/tcpm/tcpm.c | 81 ++++++++++++++++-------------------
> >   1 file changed, 38 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 5b22a1c931a9..c05ddfbaff08 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -341,6 +341,7 @@ struct tcpm_port {
> >       bool vbus_source;
> >       bool vbus_charge;
> >
> > +     /* Set to true when Discover_Identity Command is expected to be sent in Ready states. */
> >       bool send_discover;
> >       bool op_vsafe5v;
> >
> > @@ -370,6 +371,7 @@ struct tcpm_port {
> >       struct hrtimer send_discover_timer;
> >       struct kthread_work send_discover_work;
> >       bool state_machine_running;
> > +     /* Set to true when VDM State Machine has following actions. */
> >       bool vdm_sm_running;
> >
> >       struct completion tx_complete;
> > @@ -1431,6 +1433,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port, const u32 header,
> >       /* Set ready, vdm state machine will actually send */
> >       port->vdm_retries = 0;
> >       port->vdm_state = VDM_STATE_READY;
> > +     port->vdm_sm_running = true;
> >
> >       mod_vdm_delayed_work(port, 0);
> >   }
> > @@ -1673,7 +1676,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
> >                               rlen = 1;
> >                       } else {
> >                               tcpm_register_partner_altmodes(port);
> > -                             port->vdm_sm_running = false;
> >                       }
> >                       break;
> >               case CMD_ENTER_MODE:
> > @@ -1721,14 +1723,12 @@ static int tcpm_pd_svdm(struct tcpm_port *port, struct typec_altmode *adev,
> >                                     (VDO_SVDM_VERS(svdm_version));
> >                       break;
> >               }
> > -             port->vdm_sm_running = false;
> >               break;
> >       default:
> >               response[0] = p[0] | VDO_CMDT(CMDT_RSP_NAK);
> >               rlen = 1;
> >               response[0] = (response[0] & ~VDO_SVDM_VERS_MASK) |
> >                             (VDO_SVDM_VERS(svdm_version));
> > -             port->vdm_sm_running = false;
> >               break;
> >       }
> >
> > @@ -1765,6 +1765,20 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
> >       }
> >
> >       if (PD_VDO_SVDM(p[0])) {
> > +             /*
> > +              * Here a SVDM is received (INIT or RSP or unknown). Set the vdm_sm_running in
> > +              * advance because we are dropping the lock but may send VDMs soon.
> > +              * For the cases of INIT received:
> > +              *  - If no response to send, it will be cleared later in this function.
> > +              *  - If there are responses to send, it will be cleared in the state machine.
> > +              * For the cases of RSP received:
> > +              *  - If no further INIT to send, it will be cleared later in this function.
> > +              *  - Otherwise, it will be cleared in the state machine if timeout or it will go
> > +              *    back here until no further INIT to send.
> > +              * For the cases of unknown type received:
> > +              *  - We will send NAK and the flag will be cleared in the state machine.
> > +              */
> > +             port->vdm_sm_running = true;
> >               rlen = tcpm_pd_svdm(port, adev, p, cnt, response, &adev_action);
> >       } else {
> >               if (port->negotiated_rev >= PD_REV30)
> > @@ -1833,6 +1847,8 @@ static void tcpm_handle_vdm_request(struct tcpm_port *port,
> >
> >       if (rlen > 0)
> >               tcpm_queue_vdm(port, response[0], &response[1], rlen - 1);
> > +     else
> > +             port->vdm_sm_running = false;
> >   }
> >
> >   static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
> > @@ -1898,8 +1914,10 @@ static void vdm_run_state_machine(struct tcpm_port *port)
> >                * if there's traffic or we're not in PDO ready state don't send
> >                * a VDM.
> >                */
> > -             if (port->state != SRC_READY && port->state != SNK_READY)
> > +             if (port->state != SRC_READY && port->state != SNK_READY) {
> > +                     port->vdm_sm_running = false;
> >                       break;
> > +             }
> >
> >               /* TODO: AMS operation for Unstructured VDM */
> >               if (PD_VDO_SVDM(vdo_hdr) && PD_VDO_CMDT(vdo_hdr) == CMDT_INIT) {
> > @@ -2555,10 +2573,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                                                                      TYPEC_PWR_MODE_PD,
> >                                                                      port->pps_data.active,
> >                                                                      port->supply_voltage);
> > -                             /* Set VDM running flag ASAP */
> > -                             if (port->data_role == TYPEC_HOST &&
> > -                                 port->send_discover)
> > -                                     port->vdm_sm_running = true;
> >                               tcpm_set_state(port, SNK_READY, 0);
> >                       } else {
> >                               /*
> > @@ -2596,14 +2610,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >               switch (port->state) {
> >               case SNK_NEGOTIATE_CAPABILITIES:
> >                       /* USB PD specification, Figure 8-43 */
> > -                     if (port->explicit_contract) {
> > +                     if (port->explicit_contract)
> >                               next_state = SNK_READY;
> > -                             if (port->data_role == TYPEC_HOST &&
> > -                                 port->send_discover)
> > -                                     port->vdm_sm_running = true;
> > -                     } else {
> > +                     else
> >                               next_state = SNK_WAIT_CAPABILITIES;
> > -                     }
> >
> >                       /* Threshold was relaxed before sending Request. Restore it back. */
> >                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> > @@ -2618,10 +2628,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                       port->pps_status = (type == PD_CTRL_WAIT ?
> >                                           -EAGAIN : -EOPNOTSUPP);
> >
> > -                     if (port->data_role == TYPEC_HOST &&
> > -                         port->send_discover)
> > -                             port->vdm_sm_running = true;
> > -
> >                       /* Threshold was relaxed before sending Request. Restore it back. */
> >                       tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_PD,
> >                                                              port->pps_data.active,
> > @@ -2697,10 +2703,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                       }
> >                       break;
> >               case DR_SWAP_SEND:
> > -                     if (port->data_role == TYPEC_DEVICE &&
> > -                         port->send_discover)
> > -                             port->vdm_sm_running = true;
> > -
> >                       tcpm_set_state(port, DR_SWAP_CHANGE_DR, 0);
> >                       break;
> >               case PR_SWAP_SEND:
> > @@ -2738,7 +2740,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                                          PD_MSG_CTRL_NOT_SUPP,
> >                                          NONE_AMS);
> >               } else {
> > -                     if (port->vdm_sm_running) {
> > +                     if (port->send_discover) {
> >                               tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
> >                               break;
> >                       }
> > @@ -2754,7 +2756,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >                                          PD_MSG_CTRL_NOT_SUPP,
> >                                          NONE_AMS);
> >               } else {
> > -                     if (port->vdm_sm_running) {
> > +                     if (port->send_discover) {
> >                               tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
> >                               break;
> >                       }
> > @@ -2763,7 +2765,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port *port,
> >               }
> >               break;
> >       case PD_CTRL_VCONN_SWAP:
> > -             if (port->vdm_sm_running) {
> > +             if (port->send_discover) {
> >                       tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
> >                       break;
> >               }
> > @@ -4479,18 +4481,20 @@ static void run_state_machine(struct tcpm_port *port)
> >       /* DR_Swap states */
> >       case DR_SWAP_SEND:
> >               tcpm_pd_send_control(port, PD_CTRL_DR_SWAP);
> > +             if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
> > +                     port->send_discover = true;
> >               tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
> >                                   PD_T_SENDER_RESPONSE);
> >               break;
> >       case DR_SWAP_ACCEPT:
> >               tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> > -             /* Set VDM state machine running flag ASAP */
> > -             if (port->data_role == TYPEC_DEVICE && port->send_discover)
> > -                     port->vdm_sm_running = true;
> > +             if (port->data_role == TYPEC_DEVICE || port->negotiated_rev > PD_REV20)
> > +                     port->send_discover = true;
> >               tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
> >               break;
> >       case DR_SWAP_SEND_TIMEOUT:
> >               tcpm_swap_complete(port, -ETIMEDOUT);
> > +             port->send_discover = false;
> >               tcpm_ams_finish(port);
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> > @@ -4502,7 +4506,6 @@ static void run_state_machine(struct tcpm_port *port)
> >               } else {
> >                       tcpm_set_roles(port, true, port->pwr_role,
> >                                      TYPEC_HOST);
> > -                     port->send_discover = true;
> >               }
> >               tcpm_ams_finish(port);
> >               tcpm_set_state(port, ready_state(port), 0);
> > @@ -4645,8 +4648,6 @@ static void run_state_machine(struct tcpm_port *port)
> >               break;
> >       case VCONN_SWAP_SEND_TIMEOUT:
> >               tcpm_swap_complete(port, -ETIMEDOUT);
> > -             if (port->data_role == TYPEC_HOST && port->send_discover)
> > -                     port->vdm_sm_running = true;
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >       case VCONN_SWAP_START:
> > @@ -4662,14 +4663,10 @@ static void run_state_machine(struct tcpm_port *port)
> >       case VCONN_SWAP_TURN_ON_VCONN:
> >               tcpm_set_vconn(port, true);
> >               tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> > -             if (port->data_role == TYPEC_HOST && port->send_discover)
> > -                     port->vdm_sm_running = true;
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >       case VCONN_SWAP_TURN_OFF_VCONN:
> >               tcpm_set_vconn(port, false);
> > -             if (port->data_role == TYPEC_HOST && port->send_discover)
> > -                     port->vdm_sm_running = true;
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >
> > @@ -4677,8 +4674,6 @@ static void run_state_machine(struct tcpm_port *port)
> >       case PR_SWAP_CANCEL:
> >       case VCONN_SWAP_CANCEL:
> >               tcpm_swap_complete(port, port->swap_status);
> > -             if (port->data_role == TYPEC_HOST && port->send_discover)
> > -                     port->vdm_sm_running = true;
> >               if (port->pwr_role == TYPEC_SOURCE)
> >                       tcpm_set_state(port, SRC_READY, 0);
> >               else
> > @@ -5028,9 +5023,6 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *port)
> >       switch (port->state) {
> >       case SNK_TRANSITION_SINK_VBUS:
> >               port->explicit_contract = true;
> > -             /* Set the VDM flag ASAP */
> > -             if (port->data_role == TYPEC_HOST && port->send_discover)
> > -                     port->vdm_sm_running = true;
> >               tcpm_set_state(port, SNK_READY, 0);
> >               break;
> >       case SNK_DISCOVERY:
> > @@ -5425,15 +5417,18 @@ static void tcpm_send_discover_work(struct kthread_work *work)
> >       if (!port->send_discover)
> >               goto unlock;
> >
> > +     if (port->data_role == TYPEC_DEVICE && port->negotiated_rev < PD_REV30) {
> > +             port->send_discover = false;
> > +             goto unlock;
> > +     }
> > +
> >       /* Retry if the port is not idle */
> >       if ((port->state != SRC_READY && port->state != SNK_READY) || port->vdm_sm_running) {
> >               mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_MS);
> >               goto unlock;
> >       }
> >
> > -     /* Only send the Message if the port is host for PD rev2.0 */
> > -     if (port->data_role == TYPEC_HOST || port->negotiated_rev > PD_REV20)
> > -             tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
> > +     tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
> >
> >   unlock:
> >       mutex_unlock(&port->lock);
> >
>
