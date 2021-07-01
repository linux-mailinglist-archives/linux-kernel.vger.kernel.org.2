Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21E3B3B8F07
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235580AbhGAIpt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:45:49 -0400
Received: from mail-eopbgr70121.outbound.protection.outlook.com ([40.107.7.121]:7815
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235534AbhGAIpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:45:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dszO5oOEuygPgBkc7Sowo+K7M/t7Q+oGykO01S3dypqLWCDF6GNnnhfs0WWf7K+tOrJhwP8Gq6zYU9RmNNJPDjIXg0exnlzAF3gneZL0LUPlMWHmdVG8QKgxsrnufSS4y7LN8bdqBdSdaZ16Bcr0QvOVNBMk/fzvbjGC7rpFKmk0otxPT9s5MDNinQ88CWseoQPFRzkGukOgAiwMqsP9Q7hAus8e4R5cn9sDlFvnuDoS0EINyR9YYnFkBUVr9agYx5YF1CMT8gRQUR1judMtxTsKf2xdht8DSMw17SHUNnZmf3dzYkEg2IuaQH5qMDh9FwEIZ4vREZyGgetHAPGhUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnX48kBehlFqBCXoiJLJUsNXVsDuz9BPCuouazN7ktk=;
 b=NiZW1wxWbXFZ09QuRcD/ds/QfI1lNkY1+f1kPiDJzRHXuGVy4XfrIoUSDNFY8M7Fk3rcP0KkPaOuLdaSxaI9D/WRR0hA6WwMOkEId/k9JVI0X4dGh60VKT/o44pfMzF/Ryoe0bfae5WCHl08PiuGVDkHptuGKjLOOHPYITL9hs725GwuPeaUyv8qTpbCFECl60CAIsVMKzjD10LXewmZMn5KYz5H1xSPfn0blnGtB2HdzK5VzLRzUFE1IJrgDdvnkIXnUPjVpJG2ZPO+4PIUymX9th27nAuOPUm/IVNLC8dcEpDM5I49IdzM/I/dTgVl6dIF5izsEdt/iR3g1ySLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnX48kBehlFqBCXoiJLJUsNXVsDuz9BPCuouazN7ktk=;
 b=cFTkNkwOZiyj37q3SddlOFhOrvO4j6Ibb8ePeuHGx30qPsB+MHtHJbMnjhBskG8/UWeLr3Lb14PxdqVBacN3ZgFRVi6ScLkZQLYZbvtbOZKlDsLMTWCGNKyBRs1PO3H0EaE+uat9XKAY4fPZVaNnJgKYgNqVXWOKcEfzE0tPdOA=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
From:   Peter Hilber <peter.hilber@opensynergy.com>
To:     Cristian Marussi <cristian.marussi@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, igor.skalkin@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com,
        Andriy.Tryshnivskyy@opensynergy.com
References: <20210611165937.701-1-cristian.marussi@arm.com>
 <20210611165937.701-16-cristian.marussi@arm.com>
Subject: Re: [PATCH v4 15/16] [RFC][REWORK] firmware: arm_scmi: make
 virtio-scmi use delegated xfers
Message-ID: <81b5d6f8-860b-594d-a6f8-417241083425@opensynergy.com>
Date:   Thu, 1 Jul 2021 10:43:12 +0200
In-Reply-To: <20210611165937.701-16-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0063.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::40) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 339710b1-4dd4-43d8-987b-08d93c6c43f8
X-MS-TrafficTypeDiagnostic: AM0PR04MB6899:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB6899FF85D89348EC8AB3F8EB8C009@AM0PR04MB6899.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LKuqQkfIF6EpjL5uE5a3c/Za4Ob1iAYxlxWc8NP7WP2o+Ns7H7cQCLjSlwJgkprLMMRUJdp2nwM6Ehp2YzDpPrQXtZ5vbVLsFsV6sa7NgxCrSDf2oKLW/keKYFtcMBWtxRBzi6RGmEHpeHvaGKNqRGp1QCBdmZov5+GW7UwlE7fw4AVkKjnZrBP/JVVuJI/fk7D8bBWv1ORpIlxKPrerqjM8k77TEiybK7qbtPWLW6c7kmKHY1OT21EnzzfolRTmJ3SlkE7FJ2lG3WOc4+t5qTNudpM8boPZGdGEdU/K47Bl8p7pSTezrb7XfmAa1K+klxTVfMk8BMt9tukxg42WWKrq/5ZGxgRmOwcdEhfC2yDQ/8QFDAKTJjUF+fKPmvcIhxk0FjVjHMGv3zZTPMKTWLZkSaupTAcC+c3ux79mEq5el3RQREwYeN0zTK+7egFtDhW/Q6e/T4mIqC+ivfgt5MReZvoLbCM+sKAcLkqeK1tWdY7w6PJsPtdpA9+3WSjyzFBHo+27s4RhPXFlrO5cA79PdUpCT+/SVdPvU1bV9Wdh1kli3q5SOeVz8p2uxaCQa5NnMiPquHTTZXPiOnZTTbj7lst19WiLpsFWhcBAD1QQxV+zD9/t1aXJc+fHyBMw7joC0RfWIBE3zY4yL+aA4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(396003)(39840400004)(136003)(366004)(5660300002)(2906002)(186003)(4326008)(8936002)(44832011)(316002)(83380400001)(8676002)(38100700002)(42186006)(31686004)(36756003)(478600001)(30864003)(53546011)(86362001)(2616005)(66476007)(31696002)(66556008)(7416002)(107886003)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnA0Y2VNY2NlMHJCRzVVa0I3dmoreUNZQUxYYkVFZ05SRWJRNnNqM3FCWDNW?=
 =?utf-8?B?eSttVjJpTTVvTDNLQXNGLytGbStoTlRsSEN4b2k1eEFhOWFhSjFWMUhTdHJK?=
 =?utf-8?B?UEZOanhsUkFkVXhyallmM0NLTUtGUkYwSTlqWTV6NkY2Y3FmdXpYRStPYlNK?=
 =?utf-8?B?RkpJdG9DUU1vUnlPWDFsSzUxM0ZsWW9VQVFsblpydkdIVHZMbWJWUnBJWEdk?=
 =?utf-8?B?bGJJb3pqNng2U3hLUElsQ0JVbmFrbUlVWVZQZXQxQ1k0bldxYUZnZHV2Y3NE?=
 =?utf-8?B?SVM5MlB3bUI5TlA4M1E2VFVQMVg2UklIUkpLVkd3WUFrWmtvbWtLajRzWFlu?=
 =?utf-8?B?RE1FOUE5cFNWdlFzMmlVVy9pWW5CYVdDZHJVRVdreHhmUGFQamZSOXFnMS8w?=
 =?utf-8?B?RGpvWGgxRVJVZVpSdEVGUkZPam9aL1dlRTRuOGtyUGpLUDF2RDNOYnlyZjl0?=
 =?utf-8?B?RVJnN3U2VDhzMkY4dUk1ZUpvTHNHS2g3NGx2M1lucU9zMVZwQUYxcElpbDJQ?=
 =?utf-8?B?SjlDWUYwN2o0akJMQUhHYWY0ei9JTW9rem1vd1Vvc0Fhb3RRYVZxcXBUWUNG?=
 =?utf-8?B?b01DczJOVEdTRGFLOVBDdWw2TEZNMGhZeXM3UHN1a3ZaNzQ0M1JQNDJCbDBu?=
 =?utf-8?B?ODE4bm1RVjZnZFplUk1Gcmx1ZWpYY015TlY1UlZ6WTFxQVZQbCsvdkdiNlcx?=
 =?utf-8?B?TUZxYTBWMi9LZURnQjN5Q2J3N3ZhZFJnUGRHYVpwVjhxdjdQbGIvaHNuWncx?=
 =?utf-8?B?S3dqQlBiMWx4M21TQW0xalBpaURtUG9Pc1JUZnFxMGVjTWx2R1c5MWFyc3Ba?=
 =?utf-8?B?UlhKb3U4T3dGb0djOXpPYkY2VEZRaHJqemhUdEFXS0FaNnBBbTdOY0RYdXBR?=
 =?utf-8?B?M0JFakxXQkFQRDhieThWTWlZczcwbngzOGd2Mi9oeTdiSng3SEdyM0JGdCtC?=
 =?utf-8?B?RDRzNmlCV1BQMHZPSUhnZkVUVno3TVJBdVRTWEx5N0tKbkw1QWVkOTRhRDZJ?=
 =?utf-8?B?aVJJQU9wb1BkVjhRZG5jZWZwUndwYndrajRzTXVKdXZXdzFaVW05QVFhUzdO?=
 =?utf-8?B?ME1uUzc0cTdFcWJFajNZNXRJVmhDWTJEakpJNVluUmFTbnFQbkp5akc4em5V?=
 =?utf-8?B?U3pkNjZlc1VSWSsxaEdlc2lpSXdCM3Z4WmczdmVSTVFQV0txWWM0SE01eWRI?=
 =?utf-8?B?M2JWby9WVGU4VGZJa2diZWtlbzBreERBbXNaSHZwWFF6M0JXd1AvMUkwcDBr?=
 =?utf-8?B?WWZnTnhWNFFocW44ZWE0em5vdnI0NkFJSmZVVUxUdC9DeWRBKzZMcGRZUjM1?=
 =?utf-8?B?eXJlQkFlb3R0MWcrWVYvT3dSYVJacWdIUnEzYWlEYksrZm1YaXU1Z28xaXBh?=
 =?utf-8?B?dDV2WnIrQWNxNjNtVkVHMU5DWGpEWEVCME1XQytnMUlLbUprTVhBcUdWeFR0?=
 =?utf-8?B?aHRlMzRUT1MzazlqczBsZ0JkdmU4QTROMW5uR09ibnpJWDZYdHhZZXdwZ09H?=
 =?utf-8?B?V2xZU1hKME9MWFFtVVJrT25kQ1RYUUVDQVpiWmw3bk5CbWsvUHJBQ2RBMWZZ?=
 =?utf-8?B?c3U4SUQ4SGJ1c3dhbGVvaXZmN3h4OGpqSTVNTnJLblAxaUk4YzVFZEE3R29t?=
 =?utf-8?B?M0RGOTFDcjI4OVZwSHJ1enQvalpWZ2FiMVlha0lMWXYxUFpxVURPUndhVDRr?=
 =?utf-8?B?b1pLM0p2U2tURW9paGVhcXVRNHUxLzV2Z1hXaWU4eWtBYkVJRURERXgvUEJT?=
 =?utf-8?B?NlNhU0ZNWXh1VVQ3T2kvVmFaU2xyL004SzNTYnV4eS9CTTVpS2JwNHNkUExa?=
 =?utf-8?B?TUpubFZvN2JjMkdiTzdmNElkUDdQSzVlbGdtSmlQQzdMVmlqY3I2aVNlNVdw?=
 =?utf-8?Q?8Up2wzR7GAOC7?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339710b1-4dd4-43d8-987b-08d93c6c43f8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:43:14.6744
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9jOHOPXjk6iZwqPW4tJtfQteODVE3ckI30IR1gedQL1SjPDiqMSTOaMaz8u0JLC57N3YMb61zzAL/wpGhr8oIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6899
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.21 18:59, Cristian Marussi wrote:
> Draft changes to virtio-scmi to use new support for core delegated xfers
> in an attempt to simplify the interactions between virtio-scmi transport
> and the SCMI core transport layer.
> 

These changes seem to make xfers delegation mandatory for 
message-passing transports, so that might be documented.

> TODO:
>   - Polling is still not supported.
>   - Probe/remove sequence still to be reviewed.
>   - Concurrent or inverted reception of related responses and delayed
>     responses is still not addressed.
>     (it will be addressed in the SCMI core anyway most probably)
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/common.h |   5 +
>   drivers/firmware/arm_scmi/msg.c    |  35 +++++
>   drivers/firmware/arm_scmi/virtio.c | 212 +++++++++++++++--------------
>   3 files changed, 152 insertions(+), 100 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index c143a449d278..22e5532fc698 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -428,6 +428,11 @@ void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
>   void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
>   			    size_t max_len, struct scmi_xfer *xfer);
>   
> +void msg_fetch_raw_payload(struct scmi_msg_payld *msg, size_t msg_len,
> +			   size_t max_len, struct scmi_xfer *xfer);
> +void msg_fetch_raw_response(struct scmi_xfer *xfer);
> +void msg_fetch_raw_notification(struct scmi_xfer *xfer);
> +
>   void scmi_notification_instance_data_set(const struct scmi_handle *handle,
>   					 void *priv);
>   void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
> diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
> index 8a2d3303d281..3ed3ad0961ae 100644
> --- a/drivers/firmware/arm_scmi/msg.c
> +++ b/drivers/firmware/arm_scmi/msg.c
> @@ -74,6 +74,17 @@ u32 msg_read_header(struct scmi_msg_payld *msg)
>   	return le32_to_cpu(msg->msg_header);
>   }
>   
> +void msg_fetch_raw_payload(struct scmi_msg_payld *msg, size_t msg_len,
> +			   size_t max_len, struct scmi_xfer *xfer)
> +{
> +	xfer->rx_raw_len = min_t(size_t, max_len,
> +				 msg_len >= sizeof(*msg) ?
> +				 msg_len - sizeof(*msg) : 0);
> +
> +	/* Take a copy to the rx buffer.. */
> +	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx_raw_len);

In the usage throughout arm-scmi so far, scmi_desc.max_msg_size seems to 
consistently refer to the payload excluding the return status. 
scmi_desc.max_msg_size is the actual max_len parameter to this function.

So the logic here would reduce the maximum payload length for responses 
to (scmi_desc.max_msg_size - sizeof(return status)).

> +}
> +
>   /**
>    * msg_fetch_response() - Fetch response SCMI payload from transport SDU.
>    *
> @@ -94,6 +105,25 @@ void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
>   	memcpy(xfer->rx.buf, &msg->msg_payload[1], xfer->rx.len);
>   }
>   
> +void msg_fetch_raw_response(struct scmi_xfer *xfer)
> +{
> +	__le32 *msg_payload = xfer->rx.buf;
> +
> +	if (xfer->rx_raw_len < sizeof(xfer->hdr.status)) {
> +		xfer->rx.len = 0;
> +		return;
> +	}
> +
> +	xfer->hdr.status = le32_to_cpu(msg_payload[0]);
> +	/*
> +	 * rx.len has been already pre-calculated by fetch_raw
> +	 * for the whole payload including status, so shrink it
> +	 */
> +	xfer->rx.len = xfer->rx_raw_len - sizeof(xfer->hdr.status);
> +	/* Carveout status 4-byte field */
> +	memmove(xfer->rx.buf, &msg_payload[1], xfer->rx.len);

Wouldn't it be feasible to align properly in msg_fetch_raw_payload() 
already? That could also get rid of .rx_raw_len.

> +}
> +
>   /**
>    * msg_fetch_notification() - Fetch notification payload from transport SDU.
>    *
> @@ -111,3 +141,8 @@ void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
>   	/* Take a copy to the rx buffer.. */
>   	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
>   }
> +
> +void msg_fetch_raw_notification(struct scmi_xfer *xfer)
> +{
> +	xfer->rx.len = xfer->rx_raw_len;
> +}
> diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
> index 20972adf6dc7..4412bc590ca7 100644
> --- a/drivers/firmware/arm_scmi/virtio.c
> +++ b/drivers/firmware/arm_scmi/virtio.c
> @@ -37,23 +37,24 @@
>   /**
>    * struct scmi_vio_channel - Transport channel information
>    *
> - * @lock: Protects access to all members except ready.
> - * @ready_lock: Protects access to ready. If required, it must be taken before
> - *              lock.
>    * @vqueue: Associated virtqueue
>    * @cinfo: SCMI Tx or Rx channel
>    * @free_list: List of unused scmi_vio_msg, maintained for Tx channels only
>    * @is_rx: Whether channel is an Rx channel
>    * @ready: Whether transport user is ready to hear about channel
> + * @lock: Protects access to all members except ready.
> + * @ready_lock: Protects access to ready. If required, it must be taken before
> + *              lock.
>    */
>   struct scmi_vio_channel {
> -	spinlock_t lock;
> -	spinlock_t ready_lock;
>   	struct virtqueue *vqueue;
>   	struct scmi_chan_info *cinfo;
>   	struct list_head free_list;
> -	u8 is_rx;
> -	u8 ready;
> +	bool is_rx;
> +	bool ready;
> +	unsigned int max_msg;
> +	spinlock_t lock;
> +	spinlock_t ready_lock;
>   };
>   
>   /**
> @@ -100,6 +101,73 @@ static int scmi_vio_feed_vq_rx(struct scmi_vio_channel *vioch,
>   	return rc;
>   }
>   
> +static void scmi_finalize_message(struct scmi_vio_channel *vioch,
> +				  struct scmi_vio_msg *msg)
> +{
> +	unsigned long flags;
> +
> +	if (vioch->is_rx) {
> +		scmi_vio_feed_vq_rx(vioch, msg);
> +	} else {
> +		spin_lock_irqsave(&vioch->lock, flags);
> +		list_add(&msg->list, &vioch->free_list);
> +		spin_unlock_irqrestore(&vioch->lock, flags);
> +	}
> +}
> +
> +static void scmi_process_vqueue_input(struct scmi_vio_channel *vioch,
> +				      struct scmi_vio_msg *msg)
> +{
> +	u32 msg_hdr;
> +	int ret;
> +	struct scmi_xfer *xfer = NULL;
> +
> +	msg_hdr = msg_read_header(msg->input);
> +	/*
> +	 * Acquire from the core transport layer a currently valid xfer
> +	 * descriptor associated to the received msg_hdr: this could be a
> +	 * previously allocated xfer for responses and delayed responses to
> +	 * in-flight commands, or a freshly allocated new xfer for a just
> +	 * received notification.
> +	 *
> +	 * In case of responses and delayed_responses the acquired xfer, at
> +	 * the time scmi_transfer_acquire() succcessfully returns is guaranteed
> +	 * to be still associated with a valid (not timed-out nor stale)
> +	 * descriptor and proper refcounting is kept in the core along this xfer
> +	 * so that should the core time out the xfer concurrently to this receive
> +	 * path the xfer will be properly deallocated only once the last user is
> +	 * done with it. (and this code path will terminate normally even though
> +	 * all the processing related to the timed out xfer will be discarded).
> +	 */

This comment would better fit to scmi_transfer_acquire().

> +	ret = scmi_transfer_acquire(vioch->cinfo, &msg_hdr, &xfer);
> +	if (ret) {
> +		dev_err(vioch->cinfo->dev,
> +			"Cannot find matching xfer for hdr:0x%X\n", msg_hdr);
> +		scmi_finalize_message(vioch, msg);
> +		return;
> +	}
> +
> +	dev_dbg(vioch->cinfo->dev,
> +		"VQUEUE[%d] - INPUT MSG_RX_LEN:%d - HDR:0x%X  TYPE:%d  XFER_ID:%d  XFER:%px\n",
> +		vioch->vqueue->index, msg->rx_len, msg_hdr, xfer->hdr.type,
> +		xfer->hdr.seq, xfer);
> +
> +	msg_fetch_raw_payload(msg->input, msg->rx_len,
> +			      scmi_virtio_desc.max_msg_size, xfer); > +
> +	/* Drop processed virtio message anyway */
> +	scmi_finalize_message(vioch, msg);
> +
> +	if (vioch->is_rx || !xfer->hdr.poll_completion)
> +		scmi_rx_callback(vioch->cinfo, msg_hdr);
> +	else
> +		dev_warn(vioch->cinfo->dev,
> +			 "Polling mode NOT supported. Dropped hdr:0X%X\n",
> +			 msg_hdr);
> +
> +	scmi_transfer_release(vioch->cinfo, xfer);
> +}
> +
>   static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>   {
>   	unsigned long ready_flags;
> @@ -138,15 +206,9 @@ static void scmi_vio_complete_cb(struct virtqueue *vqueue)
>   
>   		if (msg) {
>   			msg->rx_len = length;
> -
> -			/*
> -			 * Hold the ready_lock during the callback to avoid
> -			 * races when the arm-scmi driver is unbinding while
> -			 * the virtio device is not quiesced yet.
> -			 */
> -			scmi_rx_callback(vioch->cinfo,
> -					 msg_read_header(msg->input), msg);
> +			scmi_process_vqueue_input(vioch, msg);
>   		}
> +
>   		spin_unlock_irqrestore(&vioch->ready_lock, ready_flags);
>   	}
>   
> @@ -163,27 +225,11 @@ static vq_callback_t *scmi_vio_complete_callbacks[] = {
>   	scmi_vio_complete_cb
>   };
>   
> -static unsigned int virtio_get_max_msg(bool tx,
> -				       struct scmi_chan_info *base_cinfo)
> +static unsigned int virtio_get_max_msg(struct scmi_chan_info *base_cinfo)
>   {
>   	struct scmi_vio_channel *vioch = base_cinfo->transport_info;
> -	unsigned int ret;
>   
> -	ret = virtqueue_get_vring_size(vioch->vqueue);
> -
> -	/* Tx messages need multiple descriptors. */
> -	if (tx)
> -		ret /= DESCRIPTORS_PER_TX_MSG;
> -
> -	if (ret > MSG_TOKEN_MAX) {
> -		dev_info_once(
> -			base_cinfo->dev,
> -			"Only %ld messages can be pending simultaneously, while the %s virtqueue could hold %d\n",
> -			MSG_TOKEN_MAX, tx ? "tx" : "rx", ret);
> -		ret = MSG_TOKEN_MAX;
> -	}
> -
> -	return ret;
> +	return vioch->max_msg;
>   }
>   
>   static int scmi_vio_match_any_dev(struct device *dev, const void *data)
> @@ -195,13 +241,14 @@ static struct virtio_driver virtio_scmi_driver; /* Forward declaration */
>   
>   static int virtio_link_supplier(struct device *dev)
>   {
> -	struct device *vdev = driver_find_device(
> -		&virtio_scmi_driver.driver, NULL, NULL, scmi_vio_match_any_dev);
> +	struct device *vdev;
> +
> +	vdev = driver_find_device(&virtio_scmi_driver.driver,
> +				  NULL, NULL, scmi_vio_match_any_dev);
>   
>   	if (!vdev) {
> -		dev_notice_once(
> -			dev,
> -			"Deferring probe after not finding a bound scmi-virtio device\n");
> +		dev_notice_once(dev,
> +				"Deferring probe after not finding a bound scmi-virtio device\n");
>   		return -EPROBE_DEFER;
>   	}
>   
> @@ -245,12 +292,8 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   	struct virtio_device *vdev;
>   	struct scmi_vio_channel *vioch;
>   	int index = tx ? VIRTIO_SCMI_VQ_TX : VIRTIO_SCMI_VQ_RX;
> -	int max_msg;
>   	int i;
>   
> -	if (!virtio_chan_available(dev, index))
> -		return -ENODEV;
> -
>   	vdev = scmi_get_transport_info(dev);
>   	vioch = &((struct scmi_vio_channel *)vdev->priv)[index];
>   
> @@ -259,9 +302,7 @@ static int virtio_chan_setup(struct scmi_chan_info *cinfo, struct device *dev,
>   	vioch->cinfo = cinfo;
>   	spin_unlock_irqrestore(&vioch->lock, flags);
>   
> -	max_msg = virtio_get_max_msg(tx, cinfo);
> -
> -	for (i = 0; i < max_msg; i++) {
> +	for (i = 0; i < vioch->max_msg; i++) {
>   		struct scmi_vio_msg *msg;
>   
>   		msg = devm_kzalloc(cinfo->dev, sizeof(*msg), GFP_KERNEL);
> @@ -322,13 +363,6 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>   	int rc;
>   	struct scmi_vio_msg *msg;
>   
> -	/*
> -	 * TODO: For now, we don't support polling. But it should not be
> -	 * difficult to add support.
> -	 */
> -	if (xfer->hdr.poll_completion)
> -		return -EINVAL;
> -
>   	spin_lock_irqsave(&vioch->lock, flags);
>   
>   	if (list_empty(&vioch->free_list)) {
> @@ -351,6 +385,11 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>   			     "%s() failed to add to virtqueue (%d)\n", __func__,
>   			     rc);
>   	} else {
> +		dev_dbg(vioch->cinfo->dev,
> +			"VQUEUE[%d] - REQUEST - PROTO:0x%X  ID:0x%X  XFER_ID:%d  XFER:%px  RX_LEN:%zd\n",
> +		 vioch->vqueue->index, xfer->hdr.protocol_id,
> +		 xfer->hdr.id, xfer->hdr.seq, xfer, xfer->rx.len);

Indentation appears to be inconsistent.

> +
>   		virtqueue_kick(vioch->vqueue);
>   	}
>   
> @@ -360,36 +399,15 @@ static int virtio_send_message(struct scmi_chan_info *cinfo,
>   }
>   
>   static void virtio_fetch_response(struct scmi_chan_info *cinfo,
> -				  struct scmi_xfer *xfer, void *msg_handle)
> +				  struct scmi_xfer *xfer)
>   {
> -	struct scmi_vio_msg *msg = msg_handle;
> -	struct scmi_vio_channel *vioch = cinfo->transport_info;
> -
> -	if (!msg) {
> -		dev_dbg_once(&vioch->vqueue->vdev->dev,
> -			     "Ignoring %s() call with NULL msg_handle\n",
> -			     __func__);
> -		return;
> -	}
> -
> -	msg_fetch_response(msg->input, msg->rx_len, xfer);
> +	msg_fetch_raw_response(xfer);
>   }
>   
>   static void virtio_fetch_notification(struct scmi_chan_info *cinfo,
> -				      size_t max_len, struct scmi_xfer *xfer,
> -				      void *msg_handle)
> +				      size_t max_len, struct scmi_xfer *xfer)
>   {
> -	struct scmi_vio_msg *msg = msg_handle;
> -	struct scmi_vio_channel *vioch = cinfo->transport_info;
> -
> -	if (!msg) {
> -		dev_dbg_once(&vioch->vqueue->vdev->dev,
> -			     "Ignoring %s() call with NULL msg_handle\n",
> -			     __func__);
> -		return;
> -	}
> -
> -	msg_fetch_notification(msg->input, msg->rx_len, max_len, xfer);
> +	msg_fetch_raw_notification(xfer);
>   }
>   
>   static void dummy_clear_channel(struct scmi_chan_info *cinfo)
> @@ -402,28 +420,6 @@ static bool dummy_poll_done(struct scmi_chan_info *cinfo,
>   	return false;
>   }
>   
> -static void virtio_drop_message(struct scmi_chan_info *cinfo, void *msg_handle)
> -{
> -	unsigned long flags;
> -	struct scmi_vio_channel *vioch = cinfo->transport_info;
> -	struct scmi_vio_msg *msg = msg_handle;
> -
> -	if (!msg) {
> -		dev_dbg_once(&vioch->vqueue->vdev->dev,
> -			     "Ignoring %s() call with NULL msg_handle\n",
> -			     __func__);
> -		return;
> -	}
> -
> -	if (vioch->is_rx) {
> -		scmi_vio_feed_vq_rx(vioch, msg);
> -	} else {
> -		spin_lock_irqsave(&vioch->lock, flags);
> -		list_add(&msg->list, &vioch->free_list);
> -		spin_unlock_irqrestore(&vioch->lock, flags);
> -	}
> -}
> -
>   static const struct scmi_transport_ops scmi_virtio_ops = {
>   	.link_supplier = virtio_link_supplier,
>   	.chan_available = virtio_chan_available,
> @@ -435,7 +431,6 @@ static const struct scmi_transport_ops scmi_virtio_ops = {
>   	.fetch_notification = virtio_fetch_notification,
>   	.clear_channel = dummy_clear_channel,
>   	.poll_done = dummy_poll_done,
> -	.drop_message = virtio_drop_message,
>   };
>   
>   static int scmi_vio_probe(struct virtio_device *vdev)
> @@ -467,10 +462,26 @@ static int scmi_vio_probe(struct virtio_device *vdev)
>   	dev_info(dev, "Found %d virtqueue(s)\n", vq_cnt);
>   
>   	for (i = 0; i < vq_cnt; i++) {
> +		unsigned int sz;
> +
>   		spin_lock_init(&channels[i].lock);
>   		spin_lock_init(&channels[i].ready_lock);
>   		INIT_LIST_HEAD(&channels[i].free_list);
>   		channels[i].vqueue = vqs[i];
> +
> +		sz = virtqueue_get_vring_size(channels[i].vqueue);
> +		/* Tx messages need multiple descriptors. */
> +		if (!channels[i].is_rx)
> +			sz /= DESCRIPTORS_PER_TX_MSG;
> +
> +		if (sz > MSG_TOKEN_MAX) {
> +			dev_info_once(dev,
> +				      "%s virtqueue could hold %d messages. Only %ld allowed to be pending.\n",
> +				      channels[i].is_rx ? "rx" : "tx",
> +				      sz, MSG_TOKEN_MAX);
> +			sz = MSG_TOKEN_MAX;
> +		}
> +		channels[i].max_msg = sz;
>   	}
>   
>   	vdev->priv = channels;
> @@ -520,4 +531,5 @@ const struct scmi_desc scmi_virtio_desc = {
>   	.max_rx_timeout_ms = 60000, /* for non-realtime virtio devices */
>   	.max_msg = 0, /* overridden by virtio_get_max_msg() */
>   	.max_msg_size = VIRTIO_SCMI_MAX_MSG_SIZE,
> +	.support_xfers_delegation = true,
>   };
> 



