Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B44F630B26C
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 22:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbhBAV6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 16:58:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59345 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229557AbhBAV6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 16:58:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612216615;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eVElEaBBqtrL8TOiMUQHGB1dt8sPXpu5YIgLRwlzHPo=;
        b=aHTLHIKRQ7M0Q6T+/mw3B4B4Qxx2qk0MVrhAESLLbMx6mq3zWvqdrwaJn1+7ku/JmMbfWm
        fLVXNuJYYjLnHvNp2muY8kWwY3VSBYcH2N5pDescE22q063HekbK2hm2M/D3vm+N65na5C
        z3Tc7gY2jDdtrHENSeIapG45w3Rf5Pk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-wqyjNx7FMXaZndvA4PepYg-1; Mon, 01 Feb 2021 16:56:46 -0500
X-MC-Unique: wqyjNx7FMXaZndvA4PepYg-1
Received: by mail-qk1-f200.google.com with SMTP id q7so10525435qkn.7
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 13:56:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :in-reply-to:references:organization:user-agent:mime-version
         :content-transfer-encoding;
        bh=eVElEaBBqtrL8TOiMUQHGB1dt8sPXpu5YIgLRwlzHPo=;
        b=Wt/9vvgTW6NKZ3Cd3DGGi83FXvoxWs8UX9rA3CjtgsKQsCrLDLYQM+c9OWNWkG/lsi
         bI4bNLdYC8GQNJIK8wrWPf8HUuV1cU/lWzmEw1m8y7s8cq78zkuDCC/3FJMNtmjnCqZw
         tfXDOUGgVp0rDZ91/U3XGWJaOKVBDuSD2i704L4DFHPOKp4EBS+Iv33MI0a4r2wzlX2a
         OTkdmc1XIVGHSSKMBD2OC317du1w3AI/Bw6JNWpxnrIuoCx6fyc750lug3Irbl4YF52F
         EGXdSWWDJcekSaHqpFF/4A3IT0kY+SEZrPjD+JskV5xd7MLc6sKIjTDFOs5kXqCAoDHj
         kosw==
X-Gm-Message-State: AOAM5300anS90rO87bhDb8li/pui0DHXxqTH7VTu1IPi4e3mh49+51FW
        XT4oeXB8gtbp3Ck9pt6YcThkssZzp8OZ+IGwX9tjjbLAhHtKhoTEEviw4e9agXKx+s17zqo3Fs7
        fecX6qL0AcJTg7J+EHGISr685
X-Received: by 2002:a0c:83a4:: with SMTP id k33mr10275180qva.1.1612216604986;
        Mon, 01 Feb 2021 13:56:44 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvBBXbzPYp4ccSoIw7JqWjwVJlLX2P2mIPwmos3epXTR7g3n19KogIBpxYGUuacDAMAXeBBg==
X-Received: by 2002:a0c:83a4:: with SMTP id k33mr10275170qva.1.1612216604815;
        Mon, 01 Feb 2021 13:56:44 -0800 (PST)
Received: from Whitewolf.lyude.net (pool-108-49-102-102.bstnma.fios.verizon.net. [108.49.102.102])
        by smtp.gmail.com with ESMTPSA id i18sm15457299qkg.66.2021.02.01.13.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 13:56:44 -0800 (PST)
Message-ID: <57384ff32e3b42e8ea72ca298e9ae1f7fdac25d7.camel@redhat.com>
Subject: Re: [PATCH v3 1/4] dp/dp_mst: Add support for sink event notify
 messages
From:   Lyude Paul <lyude@redhat.com>
Reply-To: lyude@redhat.com
To:     Sam McNally <sammc@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        dri-devel@lists.freedesktop.org
Date:   Mon, 01 Feb 2021 16:56:43 -0500
In-Reply-To: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 (3.38.3-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-09-23 at 12:13 +1000, Sam McNally wrote:
> Sink event notify messages are used for MST CEC IRQs. Add parsing
> support for sink event notify messages in preparation for handling MST
> CEC IRQs.
> 
> Signed-off-by: Sam McNally <sammc@chromium.org>
> ---
> 
> (no changes since v1)
> 
>  drivers/gpu/drm/drm_dp_mst_topology.c | 37 ++++++++++++++++++++++++++-
>  include/drm/drm_dp_mst_helper.h       | 14 ++++++++++
>  2 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c
> b/drivers/gpu/drm/drm_dp_mst_topology.c
> index 17dbed0a9800..15b6cc39a754 100644
> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
> @@ -1027,6 +1027,30 @@ static bool
> drm_dp_sideband_parse_resource_status_notify(struct drm_dp_sideband_
>         return false;
>  }
>  
> +static bool drm_dp_sideband_parse_sink_event_notify(
> +       struct drm_dp_sideband_msg_rx *raw,
> +       struct drm_dp_sideband_msg_req_body *msg)
> +{
> +       int idx = 1;
> +
> +       msg->u.sink_event.port_number = (raw->msg[idx] & 0xf0) >> 4;
> +       idx++;
> +       if (idx > raw->curlen)
> +               goto fail_len;
> +
> +       memcpy(msg->u.sink_event.guid, &raw->msg[idx], 16);
> +       idx += 16;
> +       if (idx > raw->curlen)
> +               goto fail_len;
> +
> +       msg->u.sink_event.event_id = (raw->msg[idx] << 8) | (raw->msg[idx +
> 1]);
> +       idx++;
> +       return true;
> +fail_len:
> +       DRM_DEBUG_KMS("sink event notify parse length fail %d %d\n", idx, raw-
> >curlen);

Is it possible for us to use drm_dbg_kms() here?

Also-there is an MST selftest you should update for this

> +       return false;
> +}
> +
>  static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>                                       struct drm_dp_sideband_msg_req_body
> *msg)
>  {
> @@ -1038,6 +1062,8 @@ static bool drm_dp_sideband_parse_req(struct
> drm_dp_sideband_msg_rx *raw,
>                 return drm_dp_sideband_parse_connection_status_notify(raw,
> msg);
>         case DP_RESOURCE_STATUS_NOTIFY:
>                 return drm_dp_sideband_parse_resource_status_notify(raw, msg);
> +       case DP_SINK_EVENT_NOTIFY:
> +               return drm_dp_sideband_parse_sink_event_notify(raw, msg);
>         default:
>                 DRM_ERROR("Got unknown request 0x%02x (%s)\n", msg->req_type,
>                           drm_dp_mst_req_type_str(msg->req_type));
> @@ -3875,6 +3901,8 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr
> *mgr,
>                         guid = msg->u.conn_stat.guid;
>                 else if (msg->req_type == DP_RESOURCE_STATUS_NOTIFY)
>                         guid = msg->u.resource_stat.guid;
> +               else if (msg->req_type == DP_SINK_EVENT_NOTIFY)
> +                       guid = msg->u.sink_event.guid;
>  
>                 if (guid)
>                         mstb = drm_dp_get_mst_branch_device_by_guid(mgr,
> guid);
> @@ -3948,7 +3976,8 @@ static int drm_dp_mst_handle_up_req(struct
> drm_dp_mst_topology_mgr *mgr)
>         drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
>  
>         if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
> -           up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
> +           up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY &&
> +           up_req->msg.req_type != DP_SINK_EVENT_NOTIFY) {
>                 DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
>                               up_req->msg.req_type);
>                 kfree(up_req);
> @@ -3976,6 +4005,12 @@ static int drm_dp_mst_handle_up_req(struct
> drm_dp_mst_topology_mgr *mgr)
>                 DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
>                               res_stat->port_number,
>                               res_stat->available_pbn);
> +       } else if (up_req->msg.req_type == DP_SINK_EVENT_NOTIFY) {
> +               const struct drm_dp_sink_event_notify *sink_event =
> +                       &up_req->msg.u.sink_event;
> +
> +               DRM_DEBUG_KMS("Got SEN: pn: %d event_id %d\n",
> +                             sink_event->port_number, sink_event->event_id);
>         }
>  
>         up_req->hdr = mgr->up_req_recv.initial_hdr;
> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
> index 6ae5860d8644..c7c79e0ced18 100644
> --- a/include/drm/drm_dp_mst_helper.h
> +++ b/include/drm/drm_dp_mst_helper.h
> @@ -402,6 +402,19 @@ struct drm_dp_resource_status_notify {
>         u16 available_pbn;
>  };
>  
> +#define DP_SINK_EVENT_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR      BIT(0)
> +#define DP_SINK_EVENT_PANEL_REPLAY_RFB_STORAGE_ERROR           BIT(1)
> +#define DP_SINK_EVENT_DSC_RC_BUFFER_UNDER_RUN                  BIT(2)
> +#define DP_SINK_EVENT_DSC_RC_BUFFER_OVERFLOW                   BIT(3)
> +#define DP_SINK_EVENT_DSC_CHUNK_LENGTH_ERROR                   BIT(4)
> +#define DP_SINK_EVENT_CEC_IRQ_EVENT                            BIT(5)
> +
> +struct drm_dp_sink_event_notify {
> +       u8 port_number;
> +       u8 guid[16];
> +       u16 event_id;
> +};
> +
>  struct drm_dp_query_payload_ack_reply {
>         u8 port_number;
>         u16 allocated_pbn;
> @@ -413,6 +426,7 @@ struct drm_dp_sideband_msg_req_body {
>                 struct drm_dp_connection_status_notify conn_stat;
>                 struct drm_dp_port_number_req port_num;
>                 struct drm_dp_resource_status_notify resource_stat;
> +               struct drm_dp_sink_event_notify sink_event;
>  
>                 struct drm_dp_query_payload query_payload;
>                 struct drm_dp_allocate_payload allocate_payload;

-- 
Sincerely,
   Lyude Paul (she/her)
   Software Engineer at Red Hat
   
Note: I deal with a lot of emails and have a lot of bugs on my plate. If you've
asked me a question, are waiting for a review/merge on a patch, etc. and I
haven't responded in a while, please feel free to send me another email to check
on my status. I don't bite!

