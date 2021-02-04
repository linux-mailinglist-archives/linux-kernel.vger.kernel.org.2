Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 782F430F119
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 11:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235422AbhBDKou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 05:44:50 -0500
Received: from lb2-smtp-cloud8.xs4all.net ([194.109.24.25]:59969 "EHLO
        lb2-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235389AbhBDKot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 05:44:49 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud8.xs4all.net with ESMTPA
        id 7c7HlHadHW4yN7c7Klc7g7; Thu, 04 Feb 2021 11:44:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1612435447; bh=qBOFjvexQpx6t074gNfGRNYI60yBOOT2dXXGLoJP60A=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=DQm6x9oVafxGzRLY1EDIeMUPsytsXJRz/XyA6S6VHxXZanM23Ai3CLgSjLFO6jZ7V
         k29muxcJ0TthMeXBApHUWhvdRh6PYWsVRLEu68+Fnqowb/GSP8iOZcFM3TC6UXdD2F
         64jVtLRc2CSwR2PWjuTg7vut5Q33YyXJFOK0DwECP7PDA3PQ8LXpSyZUrEMHDse547
         um/uStR2f4aaY+iFj/TafCDdTCHtx+EtWG+Sh+wUn2uOKWFZsMF18ee+q9aOdNRv51
         7RZ+z/kX2FYLubIc5+n7aDHDG0jQmZ8X6riaQb6B0ScZ7aMPSOdKM+ksRsyJ/cUNqA
         JtG/fDAM4ApCw==
Subject: Re: [PATCH v3 1/4] dp/dp_mst: Add support for sink event notify
 messages
To:     Sam McNally <sammc@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, lyude@redhat.com
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <57384ff32e3b42e8ea72ca298e9ae1f7fdac25d7.camel@redhat.com>
 <a2a23c6a-4c38-59ee-7b96-70140ada0f44@xs4all.nl>
 <CAJqEsoAAgqnirFirxfiAvTObG-j9DRE_qvMd1uu5DRTHAyFq=Q@mail.gmail.com>
From:   Hans Verkuil <hverkuil@xs4all.nl>
Message-ID: <5d171f6b-4dd5-48ee-bf6e-affed41fc271@xs4all.nl>
Date:   Thu, 4 Feb 2021 11:44:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJqEsoAAgqnirFirxfiAvTObG-j9DRE_qvMd1uu5DRTHAyFq=Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfP5nKHa/hZ4jepDNuozwqJQHVwDbeefgvpV6/X7lNCPEPHWKQJe//snfgR5hAYXp5cw/8/o3N/FvqPWWhJ58YSYShw5DgAfsrRTJU1Y2LjgxeazZeh7+
 qVryipONG9jvb9ebqE5QUX/T2Z8l/zw8HjI8bDmMFXR3PIPwHPJYs/Qqd0HGuRsyjeqCN3Ua2/6JM/0GgcobuKjrm+Z+JV+x0NtURw2A1YjJMt/Gmp98xwUh
 d/qtUl/x21nhm8yt0+wF6wUnT6qzaM9IsOiUMdH1qUZguGjQUk6GGm37htlxV+/wOVN2G+96xmrJUfVwGDz3G8x0FuyK6EdDdpBXVqo0DmmWcMKsIt8ZFyqE
 kuNHUvJR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

I replied to several of the patches: it looks like the drm code has changed since
some of this patches were written, and I think it can be simplified quite a bit.

Regards,

	Hans

On 04/02/2021 10:54, Sam McNally wrote:
> I can for this patch; I'm not really sure of the right approach for the other two though.
> 
> On Wed, 3 Feb 2021 at 20:57, Hans Verkuil <hverkuil@xs4all.nl <mailto:hverkuil@xs4all.nl>> wrote:
> 
>     Hi Sam,
> 
>     Are you able to work on a v4?
> 
>     I haven't heard from you for some time now. I would be willing to take over
>     this series if it wasn't for the fact that I do not have any hardware to test
>     this with.
> 
>     Regards,
> 
>             Hans
> 
>     On 01/02/2021 22:56, Lyude Paul wrote:
>     > On Wed, 2020-09-23 at 12:13 +1000, Sam McNally wrote:
>     >> Sink event notify messages are used for MST CEC IRQs. Add parsing
>     >> support for sink event notify messages in preparation for handling MST
>     >> CEC IRQs.
>     >>
>     >> Signed-off-by: Sam McNally <sammc@chromium.org <mailto:sammc@chromium.org>>
>     >> ---
>     >>
>     >> (no changes since v1)
>     >>
>     >>  drivers/gpu/drm/drm_dp_mst_topology.c | 37 ++++++++++++++++++++++++++-
>     >>  include/drm/drm_dp_mst_helper.h       | 14 ++++++++++
>     >>  2 files changed, 50 insertions(+), 1 deletion(-)
>     >>
>     >> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
>     >> b/drivers/gpu/drm/drm_dp_mst_topology.c
>     >> index 17dbed0a9800..15b6cc39a754 100644
>     >> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
>     >> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>     >> @@ -1027,6 +1027,30 @@ static bool
>     >> drm_dp_sideband_parse_resource_status_notify(struct drm_dp_sideband_
>     >>         return false;
>     >>  }
>     >>  
>     >> +static bool drm_dp_sideband_parse_sink_event_notify(
>     >> +       struct drm_dp_sideband_msg_rx *raw,
>     >> +       struct drm_dp_sideband_msg_req_body *msg)
>     >> +{
>     >> +       int idx = 1;
>     >> +
>     >> +       msg->u.sink_event.port_number = (raw->msg[idx] & 0xf0) >> 4;
>     >> +       idx++;
>     >> +       if (idx > raw->curlen)
>     >> +               goto fail_len;
>     >> +
>     >> +       memcpy(msg->u.sink_event.guid, &raw->msg[idx], 16);
>     >> +       idx += 16;
>     >> +       if (idx > raw->curlen)
>     >> +               goto fail_len;
>     >> +
>     >> +       msg->u.sink_event.event_id = (raw->msg[idx] << 8) | (raw->msg[idx +
>     >> 1]);
>     >> +       idx++;
>     >> +       return true;
>     >> +fail_len:
>     >> +       DRM_DEBUG_KMS("sink event notify parse length fail %d %d\n", idx, raw-
>     >>> curlen);
>     >
>     > Is it possible for us to use drm_dbg_kms() here?
>     >
>     > Also-there is an MST selftest you should update for this
>     >
>     >> +       return false;
>     >> +}
>     >> +
>     >>  static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>     >>                                       struct drm_dp_sideband_msg_req_body
>     >> *msg)
>     >>  {
>     >> @@ -1038,6 +1062,8 @@ static bool drm_dp_sideband_parse_req(struct
>     >> drm_dp_sideband_msg_rx *raw,
>     >>                 return drm_dp_sideband_parse_connection_status_notify(raw,
>     >> msg);
>     >>         case DP_RESOURCE_STATUS_NOTIFY:
>     >>                 return drm_dp_sideband_parse_resource_status_notify(raw, msg);
>     >> +       case DP_SINK_EVENT_NOTIFY:
>     >> +               return drm_dp_sideband_parse_sink_event_notify(raw, msg);
>     >>         default:
>     >>                 DRM_ERROR("Got unknown request 0x%02x (%s)\n", msg->req_type,
>     >>                           drm_dp_mst_req_type_str(msg->req_type));
>     >> @@ -3875,6 +3901,8 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr
>     >> *mgr,
>     >>                         guid = msg->u.conn_stat.guid;
>     >>                 else if (msg->req_type == DP_RESOURCE_STATUS_NOTIFY)
>     >>                         guid = msg->u.resource_stat.guid;
>     >> +               else if (msg->req_type == DP_SINK_EVENT_NOTIFY)
>     >> +                       guid = msg->u.sink_event.guid;
>     >>  
>     >>                 if (guid)
>     >>                         mstb = drm_dp_get_mst_branch_device_by_guid(mgr,
>     >> guid);
>     >> @@ -3948,7 +3976,8 @@ static int drm_dp_mst_handle_up_req(struct
>     >> drm_dp_mst_topology_mgr *mgr)
>     >>         drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
>     >>  
>     >>         if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
>     >> -           up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
>     >> +           up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY &&
>     >> +           up_req->msg.req_type != DP_SINK_EVENT_NOTIFY) {
>     >>                 DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
>     >>                               up_req->msg.req_type);
>     >>                 kfree(up_req);
>     >> @@ -3976,6 +4005,12 @@ static int drm_dp_mst_handle_up_req(struct
>     >> drm_dp_mst_topology_mgr *mgr)
>     >>                 DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
>     >>                               res_stat->port_number,
>     >>                               res_stat->available_pbn);
>     >> +       } else if (up_req->msg.req_type == DP_SINK_EVENT_NOTIFY) {
>     >> +               const struct drm_dp_sink_event_notify *sink_event =
>     >> +                       &up_req->msg.u.sink_event;
>     >> +
>     >> +               DRM_DEBUG_KMS("Got SEN: pn: %d event_id %d\n",
>     >> +                             sink_event->port_number, sink_event->event_id);
>     >>         }
>     >>  
>     >>         up_req->hdr = mgr->up_req_recv.initial_hdr;
>     >> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
>     >> index 6ae5860d8644..c7c79e0ced18 100644
>     >> --- a/include/drm/drm_dp_mst_helper.h
>     >> +++ b/include/drm/drm_dp_mst_helper.h
>     >> @@ -402,6 +402,19 @@ struct drm_dp_resource_status_notify {
>     >>         u16 available_pbn;
>     >>  };
>     >>  
>     >> +#define DP_SINK_EVENT_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR      BIT(0)
>     >> +#define DP_SINK_EVENT_PANEL_REPLAY_RFB_STORAGE_ERROR           BIT(1)
>     >> +#define DP_SINK_EVENT_DSC_RC_BUFFER_UNDER_RUN                  BIT(2)
>     >> +#define DP_SINK_EVENT_DSC_RC_BUFFER_OVERFLOW                   BIT(3)
>     >> +#define DP_SINK_EVENT_DSC_CHUNK_LENGTH_ERROR                   BIT(4)
>     >> +#define DP_SINK_EVENT_CEC_IRQ_EVENT                            BIT(5)
>     >> +
>     >> +struct drm_dp_sink_event_notify {
>     >> +       u8 port_number;
>     >> +       u8 guid[16];
>     >> +       u16 event_id;
>     >> +};
>     >> +
>     >>  struct drm_dp_query_payload_ack_reply {
>     >>         u8 port_number;
>     >>         u16 allocated_pbn;
>     >> @@ -413,6 +426,7 @@ struct drm_dp_sideband_msg_req_body {
>     >>                 struct drm_dp_connection_status_notify conn_stat;
>     >>                 struct drm_dp_port_number_req port_num;
>     >>                 struct drm_dp_resource_status_notify resource_stat;
>     >> +               struct drm_dp_sink_event_notify sink_event;
>     >>  
>     >>                 struct drm_dp_query_payload query_payload;
>     >>                 struct drm_dp_allocate_payload allocate_payload;
>     >
> 

