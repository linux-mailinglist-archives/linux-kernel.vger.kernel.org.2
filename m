Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E48311781
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 00:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhBEX5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 18:57:20 -0500
Received: from mga01.intel.com ([192.55.52.88]:57295 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231827AbhBEOCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:02:36 -0500
IronPort-SDR: q4cUuGtgrMTga1C8zKoLo+xR6jXPweX4VmJQksqKUSueaDAf5zYpZSQvX09DqOeltppd2/evWJ
 MUGPJCDB4o8A==
X-IronPort-AV: E=McAfee;i="6000,8403,9885"; a="200439286"
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="200439286"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2021 06:00:28 -0800
IronPort-SDR: /oyLOQa5dLlgBICMZwszTvwddPxunCdi0z7SqqMGKMq1ORPIncjXUPHwE3Xw1waIAcJh8MSUnv
 ntKHDcjjqIKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,155,1610438400"; 
   d="scan'208";a="484198514"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by fmsmga001.fm.intel.com with SMTP; 05 Feb 2021 06:00:25 -0800
Received: by stinkbox (sSMTP sendmail emulation); Fri, 05 Feb 2021 16:00:24 +0200
Date:   Fri, 5 Feb 2021 16:00:24 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sam McNally <sammc@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3 2/4] drm_dp_mst_topology: use correct AUX channel
Message-ID: <YB1PeDETlhqg1GC3@intel.com>
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <20200923121320.v3.2.Ided0ab0808c4908238bd2eb9ebb6ffb2c9312789@changeid>
 <YBh9HvbIRF4zd+AK@intel.com>
 <2a7c2edc-b83c-dccf-487d-1415b4bc23ff@xs4all.nl>
 <CAJqEsoCOJmS5aVb5du09tXUi7UUKVBQDPe5KTdcBiDr8A7kSYA@mail.gmail.com>
 <YB1HBDEB5/fefQzi@intel.com>
 <c577f417-b6c2-6714-8c97-ec6d636bb3a7@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c577f417-b6c2-6714-8c97-ec6d636bb3a7@xs4all.nl>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 05, 2021 at 02:46:44PM +0100, Hans Verkuil wrote:
> On 05/02/2021 14:24, Ville Syrjälä wrote:
> > On Fri, Feb 05, 2021 at 04:17:51PM +1100, Sam McNally wrote:
> >> On Thu, 4 Feb 2021 at 21:19, Hans Verkuil <hverkuil@xs4all.nl> wrote:
> >>>
> >>> On 01/02/2021 23:13, Ville Syrjälä wrote:
> >>>> On Wed, Sep 23, 2020 at 12:13:53PM +1000, Sam McNally wrote:
> >>>>> From: Hans Verkuil <hans.verkuil@cisco.com>
> >>>>>
> >>>>> For adapters behind an MST hub use the correct AUX channel.
> >>>>>
> >>>>> Signed-off-by: Hans Verkuil <hans.verkuil@cisco.com>
> >>>>> [sammc@chromium.org: rebased, removing redundant changes]
> >>>>> Signed-off-by: Sam McNally <sammc@chromium.org>
> >>>>> ---
> >>>>>
> >>>>> (no changes since v1)
> >>>>>
> >>>>>  drivers/gpu/drm/drm_dp_mst_topology.c | 36 +++++++++++++++++++++++++++
> >>>>>  1 file changed, 36 insertions(+)
> >>>>>
> >>>>> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
> >>>>> index 15b6cc39a754..0d753201adbd 100644
> >>>>> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> >>>>> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> >>>>> @@ -2255,6 +2255,9 @@ drm_dp_mst_topology_unlink_port(struct drm_dp_mst_topology_mgr *mgr,
> >>>>>      drm_dp_mst_topology_put_port(port);
> >>>>>  }
> >>>>>
> >>>>> +static ssize_t
> >>>>> +drm_dp_mst_aux_transfer(struct drm_dp_aux *aux, struct drm_dp_aux_msg *msg);
> >>>>> +
> >>>>>  static struct drm_dp_mst_port *
> >>>>>  drm_dp_mst_add_port(struct drm_device *dev,
> >>>>>                  struct drm_dp_mst_topology_mgr *mgr,
> >>>>> @@ -2271,9 +2274,13 @@ drm_dp_mst_add_port(struct drm_device *dev,
> >>>>>      port->port_num = port_number;
> >>>>>      port->mgr = mgr;
> >>>>>      port->aux.name = "DPMST";
> >>>>> +    mutex_init(&port->aux.hw_mutex);
> >>>>> +    mutex_init(&port->aux.cec.lock);
> >>>>>      port->aux.dev = dev->dev;
> >>>>>      port->aux.is_remote = true;
> >>>>>
> >>>>> +    port->aux.transfer = drm_dp_mst_aux_transfer;
> >>>>> +
> >>>>
> >>>> This was supposed to be handled via higher levels checking for
> >>>> is_remote==true.
> >>>
> >>> Ah, I suspect this patch can be dropped entirely: it predates commit 2f221a5efed4
> >>> ("drm/dp_mst: Add MST support to DP DPCD R/W functions").
> >>>
> >>> It looks like that commit basically solved what this older patch attempts to do
> >>> as well.
> >>>
> >>> Sam, can you test if it works without this patch?
> >>
> >> It almost just works; drm_dp_cec uses whether aux.transfer is non-null
> >> to filter out non-DP connectors. Using aux.is_remote as another signal
> >> indicating a DP connector seems plausible. We can drop this patch.
> > 
> > Why would anyone even call this stuff on a non-DP connector?
> > And where did they even get the struct drm_dp_aux to do so?
> 
> This check came in with commit 5ce70c799ac2 ("drm_dp_cec: check that aux
> has a transfer function"). It seems nouveau and amdgpu specific.

I see.

> 
> A better approach would be to fix those drivers to only call these cec
> functions for DP outputs. I think I moved the test to drm_dp_cec.c primarily
> for robustness (i.e. do nothing if called for a non-DP output). But that
> might not be the right approach after all.

Shrug. I guess just extending to check is_remote (or maybe there is
some other member that's always set?) is a good enough short term
solution. Someone may want to have a look at adjusting
amdgpu/nouveau to not need it, but who knows how much work that is.

-- 
Ville Syrjälä
Intel
