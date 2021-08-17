Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA263EEB08
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 12:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239651AbhHQKds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 06:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236034AbhHQKdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 06:33:46 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D83C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:33:13 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id b1so16729686qtx.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 03:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aNMkpRnxokEiN35voeIsPlll8J9yfhYxxDFi7lB25Vk=;
        b=nAQ8XrY950uggmEdputorsbZPVaLVHhNwXUT/8kPREnOJIx2SW2uPTaGfgNzp/XZqy
         g2Nv2+Mqn//zKss3hFbQ+ibwIeuA0cQkcIogI8pn43oJdcw08SAWHQSshVV58nCy4i3D
         p6c0X+kHZ/Ke6rL/4vGiVBKolpU+DAWj0qF+LnexMn9GTD3YluWBsRG3eLlo4f0ALnPu
         D4lwDozu8cuVWnl0EnuQXvpPcR3SjPm7fDek3j+y2X0ppJVcj4nv2VGVvi0xJqRyCVdo
         gs4FhpBxNDd3LlLHBq+zAsKva2FZJRmzOxdN0rN2+BPAyyMsJxxkEX8jm1MH0e9zxeKB
         8iAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aNMkpRnxokEiN35voeIsPlll8J9yfhYxxDFi7lB25Vk=;
        b=UoCCpXi4p3Bpr0igQa/toF5sT5HbZFrbd+qK27osA1GGzLvJWrZsedrJGzTRSWXvNp
         j19Eb0be++lZ/TkuNtAeqfRO1Q5ivfrx06F/0yJMzdpLs68OIGp6Ih+OPra58JcSP26n
         ZBo1rR/WEXF3RhE9fsAw1PMVdpcKZfsHcGBM7Re0wtsBtuQ3LO/zqAGeaJTj1/Gjpwto
         OvtuYYDukD71BhGCzITIfJJ+FGXjc+8YL2sK1s8vkIh7gaaoVk5c+38ejAswEaXtSG/l
         IwenD8S076uRSsEG0xBAGGshPKay5UQRXr0kM/t16R9Z+teLt7SZ+HKgPbxvjhbPywl+
         YHSA==
X-Gm-Message-State: AOAM530+Uv8iOxTrMC96m8Zm5XX0MKyGZC0T/LO3hVOl9cAUtt2BhkEE
        Dx4s816H9xz/IbFKGmrC8n/SitbMWh3/GuXWDgMuAQ==
X-Google-Smtp-Source: ABdhPJxwmIi5gHphgdaSDZhWbGmN+HTar72lkgocDfkY1JUrrdNxsr422Wk7oYtlNrrOANM+ArgmY2/XUR2J19o9QtM=
X-Received: by 2002:ac8:5745:: with SMTP id 5mr2358230qtx.347.1629196391785;
 Tue, 17 Aug 2021 03:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210816075449.2236547-1-kyletso@google.com> <YRuD4HDNuWOx3Xrv@kuha.fi.intel.com>
In-Reply-To: <YRuD4HDNuWOx3Xrv@kuha.fi.intel.com>
From:   Kyle Tso <kyletso@google.com>
Date:   Tue, 17 Aug 2021 18:32:55 +0800
Message-ID: <CAGZ6i=0=shyW-Y7G+SrySi7Sum8qnjhpOwp=vC+SUmwHkbQMrw@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Raise vdm_sm_running flag only when VDM
 SM is running
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     linux@roeck-us.net, gregkh@linuxfoundation.org, badhri@google.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2021 at 5:39 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Mon, Aug 16, 2021 at 03:54:49PM +0800, Kyle Tso wrote:
> > If the port is going to send Discover_Identity Message, vdm_sm_running
> > flag was intentionally set before entering Ready States in order to
> > avoid the conflict because the port and the port partner might start
> > AMS at almost the same time after entering Ready States.
> >
> > However, the original design has a problem. When the port is doing
> > DR_SWAP from Device to Host, it raises the flag. Later in the
> > tcpm_send_discover_work, the flag blocks the procedure of sending the
> > Discover_Identity and it might never be cleared until disconnection.
>
> This is a bit off-topic, but I just asked this in another thread: Why
> do we have to do discovery with data role swap?
>
> thanks,
>

This can be separated into two cases:

1. in PD2: If the port is originally UFP, it cannot send
Discover_Identity Message according to the Spec. And then DR_SWAP
happens. The port becomes DFP, and now it can do that.

2. in PD3: DFP and UFP are allowed to send Discover_Identity Message
and the responses may differ based on which roles they are active on.

Quote from the PD3 Spec:
```
The Discover Identity Command Shall be used to determine the identity
and/or capabilities of the Port Partner. The following products Shall
return a Discover Identity Command ACK in response to a Discover
Identity Command request sent to SOP:

=E2=80=A2 A PD-Capable UFP that supports Modal Operation.
=E2=80=A2 A PD-Capable product that has multiple DFPs.
=E2=80=A2 A PD-Capable [USB4] product.
```

thanks,
Kyle

> > Since there exists another flag send_discover representing that the por=
t
> > is going to send Discover_Identity or not, it is enough to use that fla=
g
> > to prevent the conflict. Also change the timing of the set/clear of
> > vdm_sm_running to indicate whether the VDM SM is actually running or
> > not.
> >
> > Fixes: c34e85fa69b9 ("usb: typec: tcpm: Send DISCOVER_IDENTITY from ded=
icated work")
> > Cc: Badhri Jagan Sridharan <badhri@google.com>
> > Signed-off-by: Kyle Tso <kyletso@google.com>
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 81 ++++++++++++++++-------------------
> >  1 file changed, 38 insertions(+), 43 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index 5b22a1c931a9..c05ddfbaff08 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -341,6 +341,7 @@ struct tcpm_port {
> >       bool vbus_source;
> >       bool vbus_charge;
> >
> > +     /* Set to true when Discover_Identity Command is expected to be s=
ent in Ready states. */
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
> > @@ -1431,6 +1433,7 @@ static void tcpm_queue_vdm(struct tcpm_port *port=
, const u32 header,
> >       /* Set ready, vdm state machine will actually send */
> >       port->vdm_retries =3D 0;
> >       port->vdm_state =3D VDM_STATE_READY;
> > +     port->vdm_sm_running =3D true;
> >
> >       mod_vdm_delayed_work(port, 0);
> >  }
> > @@ -1673,7 +1676,6 @@ static int tcpm_pd_svdm(struct tcpm_port *port, s=
truct typec_altmode *adev,
> >                               rlen =3D 1;
> >                       } else {
> >                               tcpm_register_partner_altmodes(port);
> > -                             port->vdm_sm_running =3D false;
> >                       }
> >                       break;
> >               case CMD_ENTER_MODE:
> > @@ -1721,14 +1723,12 @@ static int tcpm_pd_svdm(struct tcpm_port *port,=
 struct typec_altmode *adev,
> >                                     (VDO_SVDM_VERS(svdm_version));
> >                       break;
> >               }
> > -             port->vdm_sm_running =3D false;
> >               break;
> >       default:
> >               response[0] =3D p[0] | VDO_CMDT(CMDT_RSP_NAK);
> >               rlen =3D 1;
> >               response[0] =3D (response[0] & ~VDO_SVDM_VERS_MASK) |
> >                             (VDO_SVDM_VERS(svdm_version));
> > -             port->vdm_sm_running =3D false;
> >               break;
> >       }
> >
> > @@ -1765,6 +1765,20 @@ static void tcpm_handle_vdm_request(struct tcpm_=
port *port,
> >       }
> >
> >       if (PD_VDO_SVDM(p[0])) {
> > +             /*
> > +              * Here a SVDM is received (INIT or RSP or unknown). Set =
the vdm_sm_running in
> > +              * advance because we are dropping the lock but may send =
VDMs soon.
> > +              * For the cases of INIT received:
> > +              *  - If no response to send, it will be cleared later in=
 this function.
> > +              *  - If there are responses to send, it will be cleared =
in the state machine.
> > +              * For the cases of RSP received:
> > +              *  - If no further INIT to send, it will be cleared late=
r in this function.
> > +              *  - Otherwise, it will be cleared in the state machine =
if timeout or it will go
> > +              *    back here until no further INIT to send.
> > +              * For the cases of unknown type received:
> > +              *  - We will send NAK and the flag will be cleared in th=
e state machine.
> > +              */
> > +             port->vdm_sm_running =3D true;
> >               rlen =3D tcpm_pd_svdm(port, adev, p, cnt, response, &adev=
_action);
> >       } else {
> >               if (port->negotiated_rev >=3D PD_REV30)
> > @@ -1833,6 +1847,8 @@ static void tcpm_handle_vdm_request(struct tcpm_p=
ort *port,
> >
> >       if (rlen > 0)
> >               tcpm_queue_vdm(port, response[0], &response[1], rlen - 1)=
;
> > +     else
> > +             port->vdm_sm_running =3D false;
> >  }
> >
> >  static void tcpm_send_vdm(struct tcpm_port *port, u32 vid, int cmd,
> > @@ -1898,8 +1914,10 @@ static void vdm_run_state_machine(struct tcpm_po=
rt *port)
> >                * if there's traffic or we're not in PDO ready state don=
't send
> >                * a VDM.
> >                */
> > -             if (port->state !=3D SRC_READY && port->state !=3D SNK_RE=
ADY)
> > +             if (port->state !=3D SRC_READY && port->state !=3D SNK_RE=
ADY) {
> > +                     port->vdm_sm_running =3D false;
> >                       break;
> > +             }
> >
> >               /* TODO: AMS operation for Unstructured VDM */
> >               if (PD_VDO_SVDM(vdo_hdr) && PD_VDO_CMDT(vdo_hdr) =3D=3D C=
MDT_INIT) {
> > @@ -2555,10 +2573,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_por=
t *port,
> >                                                                      TY=
PEC_PWR_MODE_PD,
> >                                                                      po=
rt->pps_data.active,
> >                                                                      po=
rt->supply_voltage);
> > -                             /* Set VDM running flag ASAP */
> > -                             if (port->data_role =3D=3D TYPEC_HOST &&
> > -                                 port->send_discover)
> > -                                     port->vdm_sm_running =3D true;
> >                               tcpm_set_state(port, SNK_READY, 0);
> >                       } else {
> >                               /*
> > @@ -2596,14 +2610,10 @@ static void tcpm_pd_ctrl_request(struct tcpm_po=
rt *port,
> >               switch (port->state) {
> >               case SNK_NEGOTIATE_CAPABILITIES:
> >                       /* USB PD specification, Figure 8-43 */
> > -                     if (port->explicit_contract) {
> > +                     if (port->explicit_contract)
> >                               next_state =3D SNK_READY;
> > -                             if (port->data_role =3D=3D TYPEC_HOST &&
> > -                                 port->send_discover)
> > -                                     port->vdm_sm_running =3D true;
> > -                     } else {
> > +                     else
> >                               next_state =3D SNK_WAIT_CAPABILITIES;
> > -                     }
> >
> >                       /* Threshold was relaxed before sending Request. =
Restore it back. */
> >                       tcpm_set_auto_vbus_discharge_threshold(port, TYPE=
C_PWR_MODE_PD,
> > @@ -2618,10 +2628,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_por=
t *port,
> >                       port->pps_status =3D (type =3D=3D PD_CTRL_WAIT ?
> >                                           -EAGAIN : -EOPNOTSUPP);
> >
> > -                     if (port->data_role =3D=3D TYPEC_HOST &&
> > -                         port->send_discover)
> > -                             port->vdm_sm_running =3D true;
> > -
> >                       /* Threshold was relaxed before sending Request. =
Restore it back. */
> >                       tcpm_set_auto_vbus_discharge_threshold(port, TYPE=
C_PWR_MODE_PD,
> >                                                              port->pps_=
data.active,
> > @@ -2697,10 +2703,6 @@ static void tcpm_pd_ctrl_request(struct tcpm_por=
t *port,
> >                       }
> >                       break;
> >               case DR_SWAP_SEND:
> > -                     if (port->data_role =3D=3D TYPEC_DEVICE &&
> > -                         port->send_discover)
> > -                             port->vdm_sm_running =3D true;
> > -
> >                       tcpm_set_state(port, DR_SWAP_CHANGE_DR, 0);
> >                       break;
> >               case PR_SWAP_SEND:
> > @@ -2738,7 +2740,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port=
 *port,
> >                                          PD_MSG_CTRL_NOT_SUPP,
> >                                          NONE_AMS);
> >               } else {
> > -                     if (port->vdm_sm_running) {
> > +                     if (port->send_discover) {
> >                               tcpm_queue_message(port, PD_MSG_CTRL_WAIT=
);
> >                               break;
> >                       }
> > @@ -2754,7 +2756,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port=
 *port,
> >                                          PD_MSG_CTRL_NOT_SUPP,
> >                                          NONE_AMS);
> >               } else {
> > -                     if (port->vdm_sm_running) {
> > +                     if (port->send_discover) {
> >                               tcpm_queue_message(port, PD_MSG_CTRL_WAIT=
);
> >                               break;
> >                       }
> > @@ -2763,7 +2765,7 @@ static void tcpm_pd_ctrl_request(struct tcpm_port=
 *port,
> >               }
> >               break;
> >       case PD_CTRL_VCONN_SWAP:
> > -             if (port->vdm_sm_running) {
> > +             if (port->send_discover) {
> >                       tcpm_queue_message(port, PD_MSG_CTRL_WAIT);
> >                       break;
> >               }
> > @@ -4479,18 +4481,20 @@ static void run_state_machine(struct tcpm_port =
*port)
> >       /* DR_Swap states */
> >       case DR_SWAP_SEND:
> >               tcpm_pd_send_control(port, PD_CTRL_DR_SWAP);
> > +             if (port->data_role =3D=3D TYPEC_DEVICE || port->negotiat=
ed_rev > PD_REV20)
> > +                     port->send_discover =3D true;
> >               tcpm_set_state_cond(port, DR_SWAP_SEND_TIMEOUT,
> >                                   PD_T_SENDER_RESPONSE);
> >               break;
> >       case DR_SWAP_ACCEPT:
> >               tcpm_pd_send_control(port, PD_CTRL_ACCEPT);
> > -             /* Set VDM state machine running flag ASAP */
> > -             if (port->data_role =3D=3D TYPEC_DEVICE && port->send_dis=
cover)
> > -                     port->vdm_sm_running =3D true;
> > +             if (port->data_role =3D=3D TYPEC_DEVICE || port->negotiat=
ed_rev > PD_REV20)
> > +                     port->send_discover =3D true;
> >               tcpm_set_state_cond(port, DR_SWAP_CHANGE_DR, 0);
> >               break;
> >       case DR_SWAP_SEND_TIMEOUT:
> >               tcpm_swap_complete(port, -ETIMEDOUT);
> > +             port->send_discover =3D false;
> >               tcpm_ams_finish(port);
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> > @@ -4502,7 +4506,6 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >               } else {
> >                       tcpm_set_roles(port, true, port->pwr_role,
> >                                      TYPEC_HOST);
> > -                     port->send_discover =3D true;
> >               }
> >               tcpm_ams_finish(port);
> >               tcpm_set_state(port, ready_state(port), 0);
> > @@ -4645,8 +4648,6 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >               break;
> >       case VCONN_SWAP_SEND_TIMEOUT:
> >               tcpm_swap_complete(port, -ETIMEDOUT);
> > -             if (port->data_role =3D=3D TYPEC_HOST && port->send_disco=
ver)
> > -                     port->vdm_sm_running =3D true;
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >       case VCONN_SWAP_START:
> > @@ -4662,14 +4663,10 @@ static void run_state_machine(struct tcpm_port =
*port)
> >       case VCONN_SWAP_TURN_ON_VCONN:
> >               tcpm_set_vconn(port, true);
> >               tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> > -             if (port->data_role =3D=3D TYPEC_HOST && port->send_disco=
ver)
> > -                     port->vdm_sm_running =3D true;
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >       case VCONN_SWAP_TURN_OFF_VCONN:
> >               tcpm_set_vconn(port, false);
> > -             if (port->data_role =3D=3D TYPEC_HOST && port->send_disco=
ver)
> > -                     port->vdm_sm_running =3D true;
> >               tcpm_set_state(port, ready_state(port), 0);
> >               break;
> >
> > @@ -4677,8 +4674,6 @@ static void run_state_machine(struct tcpm_port *p=
ort)
> >       case PR_SWAP_CANCEL:
> >       case VCONN_SWAP_CANCEL:
> >               tcpm_swap_complete(port, port->swap_status);
> > -             if (port->data_role =3D=3D TYPEC_HOST && port->send_disco=
ver)
> > -                     port->vdm_sm_running =3D true;
> >               if (port->pwr_role =3D=3D TYPEC_SOURCE)
> >                       tcpm_set_state(port, SRC_READY, 0);
> >               else
> > @@ -5028,9 +5023,6 @@ static void _tcpm_pd_vbus_on(struct tcpm_port *po=
rt)
> >       switch (port->state) {
> >       case SNK_TRANSITION_SINK_VBUS:
> >               port->explicit_contract =3D true;
> > -             /* Set the VDM flag ASAP */
> > -             if (port->data_role =3D=3D TYPEC_HOST && port->send_disco=
ver)
> > -                     port->vdm_sm_running =3D true;
> >               tcpm_set_state(port, SNK_READY, 0);
> >               break;
> >       case SNK_DISCOVERY:
> > @@ -5425,15 +5417,18 @@ static void tcpm_send_discover_work(struct kthr=
ead_work *work)
> >       if (!port->send_discover)
> >               goto unlock;
> >
> > +     if (port->data_role =3D=3D TYPEC_DEVICE && port->negotiated_rev <=
 PD_REV30) {
> > +             port->send_discover =3D false;
> > +             goto unlock;
> > +     }
> > +
> >       /* Retry if the port is not idle */
> >       if ((port->state !=3D SRC_READY && port->state !=3D SNK_READY) ||=
 port->vdm_sm_running) {
> >               mod_send_discover_delayed_work(port, SEND_DISCOVER_RETRY_=
MS);
> >               goto unlock;
> >       }
> >
> > -     /* Only send the Message if the port is host for PD rev2.0 */
> > -     if (port->data_role =3D=3D TYPEC_HOST || port->negotiated_rev > P=
D_REV20)
> > -             tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL,=
 0);
> > +     tcpm_send_vdm(port, USB_SID_PD, CMD_DISCOVER_IDENT, NULL, 0);
> >
> >  unlock:
> >       mutex_unlock(&port->lock);
> > --
> > 2.33.0.rc1.237.g0d66db33f3-goog
>
> --
> heikki
