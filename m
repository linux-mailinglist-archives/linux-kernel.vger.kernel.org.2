Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132203117A5
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 01:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbhBFAJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 19:09:27 -0500
Received: from mga11.intel.com ([192.55.52.93]:50761 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229466AbhBEN36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 08:29:58 -0500
IronPort-SDR: P4CHLGU32cUGboFJJxqw7qAb5SIftnQfYweKWxnVkMeoRBQhxLHoyP+atqYUkVD3FJ8hkUDheA
 UDYnzgC783Dw==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="177925968"
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="177925968"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 05:24:24 -0800
IronPort-SDR: aS+rBOk+j+5+bJwejQHF/loJJtOuS4YLhMerS8SYm8LqmL6nEu9donoeOafigRuSS/x9xfrC4v
 hWdqWkg2JXow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,154,1610438400"; 
   d="scan'208";a="434448918"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga001.jf.intel.com with SMTP; 05 Feb 2021 05:24:21 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 05 Feb 2021 15:24:20 +0200
Date:   Fri, 5 Feb 2021 15:24:20 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Sam McNally <sammc@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] drm_dp_mst_topology: use correct AUX channel
Message-ID: <YB1HBDEB5/fefQzi@intel.com>
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
 <YBh9HvbIRF4zd+AK@intel.com>
 <2a7c2edc-b83c-dccf-487d-1415b4bc23ff@xs4all.nl>
 <CAJqEsoCOJmS5aVb5du09tXUi7UUKVBQDPe5KTdcBiDr8A7kSYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJqEsoCOJmS5aVb5du09tXUi7UUKVBQDPe5KTdcBiDr8A7kSYA@mail.gmail.com>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 04:17:51PM +1100, Sam McNally wrote:
> On Thu, 4 Feb 2021 at 21:19, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >
> > On 01/02/2021 23:13, Ville Syrjälä wrote:
> > > On Wed, Sep 23, 2020 at 12:13:53PM +1000, Sam McNally wrote:
> > >> From: Hans Verkuil <hans.verkuil@cisco.com>
> > >>
> > >> For adapters behind an MST hub use the correct AUX channel.
> > >>
> > >> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> > >> [sammc@chromium.org: rebased, removing redundant changes]
> > >> Signed-off-by: Sam McNally <sammc@chromium.org>
> > >> ---
> > >>
> > >> (no changes since v1)
> > >>
> > >>  drivers/gpu/drm/drm_dp_mst_topology.c | 36 +++++++++++++++++++++++++++
> > >>  1 file changed, 36 insertions(+)
> > >>
> > >> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> > >> index 15b6cc39a754..0d753201adbd 100644
> > >> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> > >> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> > >> @@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct drm_dp_mst_topology_mgr *mgr,
> > >>      drm_dp_mst_topology_put_port(port);
> > >>  }
> > >>
> > >> +static ssize_t
> > >> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
> > >> +
> > >>  static struct drm_dp_mst_port *
> > >>  drm_dp_mst_add_port(struct drm_device *dev,
> > >>                  struct drm_dp_mst_topology_mgr *mgr,
> > >> @@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
> > >>      port->port_num = port_number;
> > >>      port->mgr = mgr;
> > >>      port->aux.name = "DPMST";
> > >> +    mutex_init(&port->aux.hw_mutex);
> > >> +    mutex_init(&port->aux.cec.lock);
> > >>      port->aux.dev = dev->dev;
> > >>      port->aux.is_remote = true;
> > >>
> > >> +    port->aux.transfer = drm_dp_mst_aux_transfer;
> > >> +
> > >
> > > This was supposed to be handled via higher levels checking for
> > > is_remote==true.
> >
> > Ah, I suspect this patch can be dropped entirely: it predates commit 2f221a5efed4
> > ("drm/dp_mst: Add MST support to DP DPCD R/W functions").
> >
> > It looks like that commit basically solved what this older patch attempts to do
> > as well.
> >
> > Sam, can you test if it works without this patch?
> 
> It almost just works; drm_dp_cec uses whether aux.transfer is non-null
> to filter out non-DP connectors. Using aux.is_remote as another signal
> indicating a DP connector seems plausible. We can drop this patch.

Why would anyone even call this stuff on a non-DP connector?
And where did they even get the struct drm_dp_aux to do so?

> Thanks all!
> >
> > Regards,
> >
> >         Hans
> >
> > >
> > >>      /* initialize the MST downstream port's AUX crc work queue */
> > >>      drm_dp_remote_aux_init(&port->aux);
> > >>
> > >> @@ -3503,6 +3510,35 @@ static int drm_dp_send_up_ack_reply(struct drm_dp_mst_topology_mgr *mgr,
> > >>      return 0;
> > >>  }
> > >>
> > >> +static ssize_t
> > >> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg)
> > >> +{
> > >> +    struct drm_dp_mst_port *port =
> > >> +            container_of(aux, struct drm_dp_mst_port, aux);
> > >> +    int ret;
> > >> +
> > >> +    switch (msg->request & ~DP_AUX_I2C_MOT) {
> > >> +    case DP_AUX_NATIVE_WRITE:
> > >> +    case DP_AUX_I2C_WRITE:
> > >> +    case DP_AUX_I2C_WRITE_STATUS_UPDATE:
> > >> +            ret = drm_dp_send_dpcd_write(port->mgr, port, msg->address,
> > >> +                                         msg->size, msg->buffer);
> > >
> > > That doesn't make sense to me. I2c writes and DPCD writes
> > > are definitely not the same thing.
> > >
> > > aux->transfer is a very low level thing. I don't think it's the
> > > correct level of abstraction for sideband.
> > >
> > >> +            break;
> > >> +
> > >> +    case DP_AUX_NATIVE_READ:
> > >> +    case DP_AUX_I2C_READ:
> > >> +            ret = drm_dp_send_dpcd_read(port->mgr, port, msg->address,
> > >> +                                        msg->size, msg->buffer);
> > >> +            break;
> > >> +
> > >> +    default:
> > >> +            ret = -EINVAL;
> > >> +            break;
> > >> +    }
> > >> +
> > >> +    return ret;
> > >> +}
> > >> +
> > >>  static int drm_dp_get_vc_payload_bw(u8 dp_link_bw, u8  dp_link_count)
> > >>  {
> > >>      if (dp_link_bw == 0 || dp_link_count == 0)
> > >> --
> > >> 2.28.0.681.g6f77f65b4e-goog
> > >>
> > >> _______________________________________________
> > >> dri-devel mailing list
> > >> dri-devel@lists.freedesktop.org
> > >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > >
> >

-- 
Ville Syrjälä
Intel
