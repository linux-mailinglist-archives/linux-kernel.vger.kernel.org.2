Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16FD930A4C4
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 11:00:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbhBAJ61 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:58:27 -0500
Received: from lb1-smtp-cloud7.xs4all.net ([194.109.24.24]:57277 "EHLO
        lb1-smtp-cloud7.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231992AbhBAJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:58:25 -0500
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud7.xs4all.net with ESMTPA
        id 6Vxgluj1Xefbk6Vxklg06Q; Mon, 01 Feb 2021 10:57:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s2;
        t=1612173463; bh=5L0KAYINbMVLYN+e0G2cePDwOg1VIYpVmSB2dTWAzME=;
        h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=qSK1hWb/oqziIFFXFuJWhVKqj65m7kOj1ae9COJH8emZvesJrJiQe+yu42JRqsRR7
         dqBoWZQyrVO2beEXOhqUSd+5MSd2kHksxil5ksFPy48LO6FO8ENLtM8pGMP/IADVgC
         k25KuoCUXfzlNWlwmmBSXWxzkA1VZVe4+pptWT3nGoW2+aE+/jz/C6X8PbLbxi44EL
         CAkFZtlnamX2kj2YOaUPPEs0xeuzBbPYt1nJbRSaexsdZEYd+scl9VR99iVQZ8M4g8
         2k0kUs6W8XOrf2DsPNFbCkRDpXIL/dLGC2/bS+PpH6iduKgf7GsVpbvHmuXeJMy2//
         2Y/vKyUA+fZ8A==
Subject: Re: [PATCH v3 1/4] dp/dp_mst: Add support for sink event notify
 messages
From:   Hans Verkuil <hverkuil@xs4all.nl>
To:     Sam McNally <sammc@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Lyude Paul <lyude@redhat.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org
References: <20200923121320.v3.1.I8693156f555875e5c8342e86ab37ce968dfdd277@changeid>
 <62e32c43-29b0-9818-a4dc-ba4fb3fd1a89@xs4all.nl>
Message-ID: <8bea06b5-0cbd-a135-e09e-075318bdf054@xs4all.nl>
Date:   Mon, 1 Feb 2021 10:57:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <62e32c43-29b0-9818-a4dc-ba4fb3fd1a89@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfIEqwsQAWZhnwLxqO0Qd65U2+xKP9iljo7e0POX3+htoyyjDuSTtIZ46us8nKb7SsW8DlhK0OoJx6ohT3uV9Abg7XHijMVKAHe4KnfMx0l5y+FUgHrx8
 fYGcsffKvS98VoVGLRoTuB+3S4slSv0wF0Fy2eb15nhDDxAGyZuqqv4vf0w7/MrOFqHgHYMuKnZ3V6z9G4o+r3y4MWIYBWBFTCdwWv28MJWlQUtynaP5SXY1
 Iem414xhK3lxZ8rOYQRFZLU9aMI4SBCa6Y43zYpi0gn91mqrc/cX1yKnGVR6bkrd4R8orjAAXo32ZBbLq7MjGcqCkvZUO7CTJIRealRifRpJHpsEbwpbso7U
 bebInyq3+HoFXGwFiJTTd1yGyQEIHjAOUlDzlry7/hxhG2wRjJ+XemmBuHAvdBCBnPGH/hiQ3RcyizUQaVZQHdQX0rFSCwfWXojzq3C2qcEgCnhIBsY=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lyude,

Daniel referred me to you as the best person to review the MST parts of this
series.

I can commit this, but then I prefer to have a Reviewed-by or Acked-by from
someone for the first 3 DP MST patches. Alternatively, you can take the whole
series (I've reviewed the 4th CEC patch).

Regards,

	Hans

On 12/01/2021 10:24, Hans Verkuil wrote:
> Hi Sam,
> 
> This series still hasn't been merged. It still applies cleanly to v5.11-rc1.
> 
> Daniel, can you merge this series for 5.12? Or Ack this series so I can merge it?
> 
> The first three patches deal with DP MST support, and this needs review from
> you or David.
> 
> Regards,
> 
> 	Hans
> 
> On 23/09/2020 04:13, Sam McNally wrote:
>> Sink event notify messages are used for MST CEC IRQs. Add parsing
>> support for sink event notify messages in preparation for handling MST
>> CEC IRQs.
>>
>> Signed-off-by: Sam McNally <sammc@chromium.org>
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/gpu/drm/drm_dp_mst_topology.c | 37 ++++++++++++++++++++++++++-
>>  include/drm/drm_dp_mst_helper.h       | 14 ++++++++++
>>  2 files changed, 50 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
>> index 17dbed0a9800..15b6cc39a754 100644
>> --- a/drivers/gpu/drm/drm_dp_mst_topology.c
>> +++ b/drivers/gpu/drm/drm_dp_mst_topology.c
>> @@ -1027,6 +1027,30 @@ static bool drm_dp_sideband_parse_resource_status_notify(struct drm_dp_sideband_
>>  	return false;
>>  }
>>  
>> +static bool drm_dp_sideband_parse_sink_event_notify(
>> +	struct drm_dp_sideband_msg_rx *raw,
>> +	struct drm_dp_sideband_msg_req_body *msg)
>> +{
>> +	int idx = 1;
>> +
>> +	msg->u.sink_event.port_number = (raw->msg[idx] & 0xf0) >> 4;
>> +	idx++;
>> +	if (idx > raw->curlen)
>> +		goto fail_len;
>> +
>> +	memcpy(msg->u.sink_event.guid, &raw->msg[idx], 16);
>> +	idx += 16;
>> +	if (idx > raw->curlen)
>> +		goto fail_len;
>> +
>> +	msg->u.sink_event.event_id = (raw->msg[idx] << 8) | (raw->msg[idx + 1]);
>> +	idx++;
>> +	return true;
>> +fail_len:
>> +	DRM_DEBUG_KMS("sink event notify parse length fail %d %d\n", idx, raw->curlen);
>> +	return false;
>> +}
>> +
>>  static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>>  				      struct drm_dp_sideband_msg_req_body *msg)
>>  {
>> @@ -1038,6 +1062,8 @@ static bool drm_dp_sideband_parse_req(struct drm_dp_sideband_msg_rx *raw,
>>  		return drm_dp_sideband_parse_connection_status_notify(raw, msg);
>>  	case DP_RESOURCE_STATUS_NOTIFY:
>>  		return drm_dp_sideband_parse_resource_status_notify(raw, msg);
>> +	case DP_SINK_EVENT_NOTIFY:
>> +		return drm_dp_sideband_parse_sink_event_notify(raw, msg);
>>  	default:
>>  		DRM_ERROR("Got unknown request 0x%02x (%s)\n", msg->req_type,
>>  			  drm_dp_mst_req_type_str(msg->req_type));
>> @@ -3875,6 +3901,8 @@ drm_dp_mst_process_up_req(struct drm_dp_mst_topology_mgr *mgr,
>>  			guid = msg->u.conn_stat.guid;
>>  		else if (msg->req_type == DP_RESOURCE_STATUS_NOTIFY)
>>  			guid = msg->u.resource_stat.guid;
>> +		else if (msg->req_type == DP_SINK_EVENT_NOTIFY)
>> +			guid = msg->u.sink_event.guid;
>>  
>>  		if (guid)
>>  			mstb = drm_dp_get_mst_branch_device_by_guid(mgr, guid);
>> @@ -3948,7 +3976,8 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>>  	drm_dp_sideband_parse_req(&mgr->up_req_recv, &up_req->msg);
>>  
>>  	if (up_req->msg.req_type != DP_CONNECTION_STATUS_NOTIFY &&
>> -	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY) {
>> +	    up_req->msg.req_type != DP_RESOURCE_STATUS_NOTIFY &&
>> +	    up_req->msg.req_type != DP_SINK_EVENT_NOTIFY) {
>>  		DRM_DEBUG_KMS("Received unknown up req type, ignoring: %x\n",
>>  			      up_req->msg.req_type);
>>  		kfree(up_req);
>> @@ -3976,6 +4005,12 @@ static int drm_dp_mst_handle_up_req(struct drm_dp_mst_topology_mgr *mgr)
>>  		DRM_DEBUG_KMS("Got RSN: pn: %d avail_pbn %d\n",
>>  			      res_stat->port_number,
>>  			      res_stat->available_pbn);
>> +	} else if (up_req->msg.req_type == DP_SINK_EVENT_NOTIFY) {
>> +		const struct drm_dp_sink_event_notify *sink_event =
>> +			&up_req->msg.u.sink_event;
>> +
>> +		DRM_DEBUG_KMS("Got SEN: pn: %d event_id %d\n",
>> +			      sink_event->port_number, sink_event->event_id);
>>  	}
>>  
>>  	up_req->hdr = mgr->up_req_recv.initial_hdr;
>> diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
>> index 6ae5860d8644..c7c79e0ced18 100644
>> --- a/include/drm/drm_dp_mst_helper.h
>> +++ b/include/drm/drm_dp_mst_helper.h
>> @@ -402,6 +402,19 @@ struct drm_dp_resource_status_notify {
>>  	u16 available_pbn;
>>  };
>>  
>> +#define DP_SINK_EVENT_PANEL_REPLAY_ACTIVE_FRAME_CRC_ERROR	BIT(0)
>> +#define DP_SINK_EVENT_PANEL_REPLAY_RFB_STORAGE_ERROR		BIT(1)
>> +#define DP_SINK_EVENT_DSC_RC_BUFFER_UNDER_RUN			BIT(2)
>> +#define DP_SINK_EVENT_DSC_RC_BUFFER_OVERFLOW			BIT(3)
>> +#define DP_SINK_EVENT_DSC_CHUNK_LENGTH_ERROR			BIT(4)
>> +#define DP_SINK_EVENT_CEC_IRQ_EVENT				BIT(5)
>> +
>> +struct drm_dp_sink_event_notify {
>> +	u8 port_number;
>> +	u8 guid[16];
>> +	u16 event_id;
>> +};
>> +
>>  struct drm_dp_query_payload_ack_reply {
>>  	u8 port_number;
>>  	u16 allocated_pbn;
>> @@ -413,6 +426,7 @@ struct drm_dp_sideband_msg_req_body {
>>  		struct drm_dp_connection_status_notify conn_stat;
>>  		struct drm_dp_port_number_req port_num;
>>  		struct drm_dp_resource_status_notify resource_stat;
>> +		struct drm_dp_sink_event_notify sink_event;
>>  
>>  		struct drm_dp_query_payload query_payload;
>>  		struct drm_dp_allocate_payload allocate_payload;
>>
> 

