Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 122E0310473
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 06:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhBEFTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 00:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhBEFTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 00:19:15 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A136C0613D6
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 21:18:30 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id k4so5585925ybp.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 21:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lgOzo6AA5TXNIkBKlwLQRgO7wuH9dEiOWALI05+ya+s=;
        b=NAjY1FvXNmUGUqI5ruw3fTkPLusc6/BtV63R1Ran0vMCGY6MURS28Krjx/21j8FPuy
         N0flzcI/QoXFrpAedwhwSYdn4ARhraxpebOzmm7bOZX0A0p0c9TdKFm6mDsNo95+039r
         6ze8c8K/W3WnRLu90amNei5xMtMVzDQbM0dQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lgOzo6AA5TXNIkBKlwLQRgO7wuH9dEiOWALI05+ya+s=;
        b=TLZOAvLbW5gd+L+F50MELWIvOLQqDtJG5BI4GQ3tWGJzxdxYCNvJ5S/s8HM7v1Yr3i
         6hPUdyVZWAMrCD/8RgAQDHgQxZy66Iu/O+7JXwln1NacORYtET5P/e8UJ2ebmUJn5Qul
         DJdnvuQIE1DHONQLBLop/O6xfi0pUebeu1aFPdDx1IZeLVlyoj8lmPQzfdX0+0l2L2ld
         j5f8U3JDtfNUz5FYaA7rlvkzFQSdoTas4bATf6kv1A8JsQnffSFB1QS6iE4lci+X0vXI
         +1QDieYTVDmhdHW+nqS8UF9NTCU0eJoQKYhK97sGrv1r6NAZ7jKC5oh3/BFqtQMJ0sZ9
         zBYQ==
X-Gm-Message-State: AOAM530A19trKjF1B1opxaekYTtn9hmBT7xzmky2uGz0dMRYcDtHa68w
        df16Rkf/BtZ7+B4XjP9PvZ7rbNj5RAE5G5aVQYIUsw==
X-Google-Smtp-Source: ABdhPJy/Dx6JrLpBx8VlbMaJA6d4oUUMF+XjSPFkmLacUYDtzQGWIKeD1y2Kdkfjs0iYFqc+ffAcW4a1c6K401rcSlU=
X-Received: by 2002:a25:da41:: with SMTP id n62mr3671777ybf.155.1612502309147;
 Thu, 04 Feb 2021 21:18:29 -0800 (PST)
MIME-Version: 1.0
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
 <YBh9HvbIRF4zd+AK@intel.com> <2a7c2edc-b83c-dccf-487d-1415b4bc23ff@xs4all.nl>
In-Reply-To: <2a7c2edc-b83c-dccf-487d-1415b4bc23ff@xs4all.nl>
From:   Sam McNally <sammc@chromium.org>
Date:   Fri, 5 Feb 2021 16:17:51 +1100
Message-ID: <CAJqEsoCOJmS5aVb5du09tXUi7UUKVBQDPe5KTdcBiDr8A7kSYA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] drm_dp_mst_topology: use correct AUX channel
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Feb 2021 at 21:19, Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 01/02/2021 23:13, Ville Syrj=C3=A4l=C3=A4 wrote:
> > On Wed, Sep 23, 2020 at 12:13:53PM +1000, Sam McNally wrote:
> >> From: Hans Verkuil <hans.verkuil@cisco.com>
> >>
> >> For adapters behind an MST hub use the correct AUX channel.
> >>
> >> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> >> [sammc@chromium.org: rebased, removing redundant changes]
> >> Signed-off-by: Sam McNally <sammc@chromium.org>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>  drivers/gpu/drm/drm_dp_mst_topology.c | 36 ++++++++++++++++++++++++++=
+
> >>  1 file changed, 36 insertions(+)
> >>
> >> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/d=
rm_dp_mst_topology.c
> >> index 15b6cc39a754..0d753201adbd 100644
> >> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> >> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> >> @@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct drm_dp_ms=
t_topology_mgr *mgr,
> >>      drm_dp_mst_topology_put_port(port);
> >>  }
> >>
> >> +static ssize_t
> >> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg=
 *msg);
> >> +
> >>  static struct drm_dp_mst_port *
> >>  drm_dp_mst_add_port(struct drm_device *dev,
> >>                  struct drm_dp_mst_topology_mgr *mgr,
> >> @@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
> >>      port->port_num =3D port_number;
> >>      port->mgr =3D mgr;
> >>      port->aux.name =3D "DPMST";
> >> +    mutex_init(&port->aux.hw_mutex);
> >> +    mutex_init(&port->aux.cec.lock);
> >>      port->aux.dev =3D dev->dev;
> >>      port->aux.is_remote =3D true;
> >>
> >> +    port->aux.transfer =3D drm_dp_mst_aux_transfer;
> >> +
> >
> > This was supposed to be handled via higher levels checking for
> > is_remote=3D=3Dtrue.
>
> Ah, I suspect this patch can be dropped entirely: it predates commit 2f22=
1a5efed4
> ("drm/dp_mst: Add MST support to DP DPCD R/W functions").
>
> It looks like that commit basically solved what this older patch attempts=
 to do
> as well.
>
> Sam, can you test if it works without this patch?

It almost just works; drm_dp_cec uses whether aux.transfer is non-null
to filter out non-DP connectors. Using aux.is_remote as another signal
indicating a DP connector seems plausible. We can drop this patch.
Thanks all!
>
> Regards,
>
>         Hans
>
> >
> >>      /* initialize the MST downstream port's AUX crc work queue */
> >>      drm_dp_remote_aux_init(&port->aux);
> >>
> >> @@ -3503,6 +3510,35 @@ static int drm_dp_send_up_ack_reply(struct drm_=
dp_mst_topology_mgr *mgr,
> >>      return 0;
> >>  }
> >>
> >> +static ssize_t
> >> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg=
 *msg)
> >> +{
> >> +    struct drm_dp_mst_port *port =3D
> >> +            container_of(aux, struct drm_dp_mst_port, aux);
> >> +    int ret;
> >> +
> >> +    switch (msg->request & ~DP_AUX_I2C_MOT) {
> >> +    case DP_AUX_NATIVE_WRITE:
> >> +    case DP_AUX_I2C_WRITE:
> >> +    case DP_AUX_I2C_WRITE_STATUS_UPDATE:
> >> +            ret =3D drm_dp_send_dpcd_write(port->mgr, port, msg->addr=
ess,
> >> +                                         msg->size, msg->buffer);
> >
> > That doesn't make sense to me. I2c writes and DPCD writes
> > are definitely not the same thing.
> >
> > aux->transfer is a very low level thing. I don't think it's the
> > correct level of abstraction for sideband.
> >
> >> +            break;
> >> +
> >> +    case DP_AUX_NATIVE_READ:
> >> +    case DP_AUX_I2C_READ:
> >> +            ret =3D drm_dp_send_dpcd_read(port->mgr, port, msg->addre=
ss,
> >> +                                        msg->size, msg->buffer);
> >> +            break;
> >> +
> >> +    default:
> >> +            ret =3D -EINVAL;
> >> +            break;
> >> +    }
> >> +
> >> +    return ret;
> >> +}
> >> +
> >>  static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
> >>  {
> >>      if (dp_link_bw =3D=3D 0 || dp_link_count =3D=3D 0)
> >> --
> >> 2.28.0.681.g6f77f65b4e-goog
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> >
>
