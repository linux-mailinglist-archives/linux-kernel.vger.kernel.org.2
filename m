Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39983B8F01
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235575AbhGAIpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:45:22 -0400
Received: from mail-eopbgr80110.outbound.protection.outlook.com ([40.107.8.110]:49811
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235445AbhGAIpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:45:19 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBkF22yJp1WWR8P77ud7WhwZ8twOfsOfMaNqTq2OEGvRkemA7yC4LGQvJYIbueMvVrNgcsAcK+uwPrgNNYdTvZDRNF2jM7cWrB84LxoC1kACok3lIRMX/1W2Sa0VB6x9KjSy1DT4fT6wkFzqI8KTXRurZkS5SJWfIB6uJjufekbipnL/y6To3f7Quae4kZDypBuYsc2ecYry9SjPhPXD2QuqEjdt79QCB6TPPn8HAWAE63D6PpiJuiigri+tvRWiJZpOHZlqdAzPMMpl02MATeu7c1WzUqDv5BIzvJYx7BkewDaVFO7jiGmGRG8hS//BMQyUuGjUIbCvCnu5VTjloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCC9YUYrZw5ZD7jTyzsWsWHbfUHYK7DHQRRJvTNRrb4=;
 b=CzH3y0ChubqH0WFYgOsiFwzhJvMjjE+8EisacOCELvISwPTA3NsOQn1Y+lRrUyvt0/lrgVzQ7Llwoioo8jBVLX5tJZ9/nO5lefHjcpKXpat85py8wdjeKEYX8O6gxuFqhgvHFsFjiwfZ26k7Xw8Rdl3XI9OFnedXcAsrvXnLXxXpLg7IfhFqV8P7t/24fR/blZjQRiP/3GiE49hpeE3xoGb116yqdRS30ySmxRTnt+atszyYnZJ+c4/3yEoMFjtFBilXce57aTPMWWvUve8GKFoaK+4UIMQMnViWgxCP5scf2wL2UYWD8wmqwl5YOcwKrlzJtJv2Tf/w7AX+/WmNSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCC9YUYrZw5ZD7jTyzsWsWHbfUHYK7DHQRRJvTNRrb4=;
 b=LAtD+11QZnyjPIqCM1wFy8w/ghBDuoeSPkS2isYh7+LqApJ87NXiM5dKGaAJHSTe/T8Mnu6lYRrwnSzyK6bzb+Mhk7j9Wyte5ufFOBy6JCK8HrE3wiQFRSHmoYMLYOBhu9GUlU6NUiKRHO5WaKY/za0D31xkOPjJRINOpws5O9g=
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
 <20210611165937.701-5-cristian.marussi@arm.com>
Subject: Re: [PATCH v4 04/16] firmware: arm_scmi: Introduce monotonically
 increasing tokens
Message-ID: <cb7f3259-0ad5-8ce0-15e7-2abee1f704ff@opensynergy.com>
Date:   Thu, 1 Jul 2021 10:42:45 +0200
In-Reply-To: <20210611165937.701-5-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0057.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::34) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f68d7d1-f593-4b90-41e5-08d93c6c33d0
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB50287A2742CA3B61C2FE2FC28C009@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3WaJN5ZiQfnFdhhVYmIHfFj1K8kvAlzU6+9EG+y8Bv3ogFwvupJg0MkBzD2aWZ88MmvV+Dc8p4fz522oHmDAmztV4Ey2AE5M9NYdeThzLbVScHuMcOx+hXjQ9xyhBS+UPUJszrk7H6CRkljnmxV97XLO5qwUxfjo5mG+txzSq6rzjEzinzMUPNjZtBcRTycv71gcNHznv0/gtSLRiNM/EEbRtb48ZNKQ7CZ2nZpFVzWSFy84cFajqxCF/wpbcZVgdqD8b3wd6qIAHAz3mH1r0o1jx+x1JZLZylVBcY+Nhrht7T8x9pya/dPyZYqbDTKKlEWdOemIN1valJSHU3zeATF7BCIAoW0YXR56zORjeGcGTSezxq90sBHVKdhd+J2g9Av30m2G0bBtQTKJCzObY9vrep9JDXjQNrKUCwZOOWXFEUtaBDQWzTITi3CK+l8jt+0FjaW10B+IABwj2zUPq6BbCxKFjTltn/xZKfoZiBadevhDHaSBQVHjIZhWfdBmKiZPd62YwWhZDnfTN5dwN1hv8Sai4e7Y7svf8kcUdofbZ4ZuvJ1GhliFMPn8YTb69pOlrEwz/s0AOfDoNooIqTrwTvDo1DVLlLAQsmlJN4EVOLObdqxDmYkGTgJ2BjNrY0NjZZofk9dkUfCsFh6OPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(376002)(136003)(36756003)(186003)(83380400001)(53546011)(66946007)(86362001)(31686004)(31696002)(42186006)(478600001)(2906002)(316002)(8936002)(8676002)(7416002)(66556008)(2616005)(66476007)(4326008)(107886003)(38100700002)(5660300002)(30864003)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0QzYzVqZ0c1YjR2T1M5UUY0Q1pQSkVnbVgzeGhpSHExdzZtZW85UzNqUTF2?=
 =?utf-8?B?K2JJU3dCbU9SMGZ2NEJwM3JhQnU4VnNvcnNhYThWckNCT0R1Ky9IUmF2Q080?=
 =?utf-8?B?dGh5K3RZVW5pVTNXN2ovVytuWEdMZDlRZ1JZS2RwL2x5a2s3aGFSYldXNjFE?=
 =?utf-8?B?S0Q4Z2FwQ3dRYWhwWkRrOTF0OTUzUEw4U21EbFpQejlCOXVPMEtGeWlTM0U2?=
 =?utf-8?B?VkMwM0NEUHRiMUpDWnJQQVcyd3pDWnp1b0xqTWhmMHlzd2RodHA3aE1ESTV2?=
 =?utf-8?B?RlB5a0dYTXhLSzk5ZFd2NUlzVVdTc1FPVjM0TEpYcVViVG84QWYrcTdjMjBn?=
 =?utf-8?B?QXgyQjZySElrT005Z0xIK2svUkZKczZGWGoxZmU2NitJSGlhQ3JBTHkzQWpM?=
 =?utf-8?B?aXZKSG1mdnhabUxWL2xCOTFFaDduaVBrbVo1VzJXN2R4WHMxTWNmak1Obk9n?=
 =?utf-8?B?SWlJTVdkUm85cTRCa2dwU2VqY3JnS2RBb2szdEJESW1tZndzSWFkTWdmM2hX?=
 =?utf-8?B?Q05rQXRuNVB1OVNBVDRIM0tDMzBkMWk0d250OW13bldYR2hQUEtjeTY3UXF4?=
 =?utf-8?B?ZFpsYm12NVJMQWRrcHB2bDVpeVJWWE8xSDA3Tnk4QWtMUTRuc0NIU3duN3dM?=
 =?utf-8?B?YlErQzF3Ry9sRHZ0Nms0V3lmVEM5eTBLYjNsNnBkR1pKZmFTRUw2cm10a3Va?=
 =?utf-8?B?QStoeEI5cXJ2TEZTQW5Hb0Y1VDUyejFHZnFEcFVQS3ljNjhmMytYR01pWFpZ?=
 =?utf-8?B?MmxnSE1iKzNOakd6Ny9NeE1mRUk0MUlKOEt0U0lJK0U1UTFHeVlxNDlBQVdI?=
 =?utf-8?B?SWZOTkhOUTN3S3gwLzBxVG8xU2ZkRWNQY1F3WklnaGRLMzArVFd4UlU5dG9x?=
 =?utf-8?B?RzlTWEhSZUtTTmZzOFFhTG1VbjF2T1RxcnpzRDRaZ2paaUlCSXNXSnVvWFdl?=
 =?utf-8?B?ckFoNHVxQ3JHZm5ZZ29BeEhodEk2ZjdnT0pTSmZMODVNV1N3WERlczVNOWNP?=
 =?utf-8?B?OG1UVzQ4UGpoVEtmM3BzeTJudzZxcEhWY2RtU1NmeE5jd0xncEJTSTBCWlFL?=
 =?utf-8?B?Z0E2K0Vac2ZmOWNNbW10ZDhiUTUybXBNMXVaYjUxcTdQS3B2andjbkJYSldE?=
 =?utf-8?B?KzM4RU9Bc2prVERWQzZjbFhBZmVHZVd3OFk3VG9wUlBpYzI5TmtBZm55U0Rr?=
 =?utf-8?B?d1JmUVdrUjB0c25QbUorYXN2MzFwQzAwcXMzSWk5RE9BZGhXdHIwRHlycENN?=
 =?utf-8?B?eUNkYVNlUjFDTDNPOHN0ODJqbFJJWU1kNDJvRWFiZGtJNWtYTExYQnZvUktF?=
 =?utf-8?B?OVlLYlFyZTlJOFZ0TEZ4SHU3d2ZjbVlBY1VCMStuWVBBb3NZQ3R4WHdkdXZS?=
 =?utf-8?B?QXpkakNpeTNWRm9YamZjM2RRVy9BSkpMY3hLWlIydU4yQ1RpVG5Bd1JsU1ps?=
 =?utf-8?B?TE9NWlVSYVdraFNpbWtNQTNaM0RYS0wyd3FSUExoQjhYNjFWVmVzTFQzWUVv?=
 =?utf-8?B?REpkKy9zclNRS0E4UkRHTzJ1V3pqdHNXdnVDWFFIQUhvZ041dmwrTG85dTZv?=
 =?utf-8?B?dlAwWmlRMjVVQUxOTGFmOFFxOXBSZTUrUXp3OHZLYXB4WnBLS21VNXBxL1dy?=
 =?utf-8?B?Y3FZNkF0VmM3UUxRaU9WN2QzSGY1R01KRVhZMXVzbjdMa3oyZXRhMVMwZ1Zu?=
 =?utf-8?B?MThjZTg5SmMyN1cyOFZZVlRkeUEvQitwUGFZN3g5bGdhdTA0K05pT2FSZlZU?=
 =?utf-8?B?Tk5YZW9qa3BrRnc2YURmZVVoRmdickZ2eiszU1pVdFpIMlAzWXl4VjA3enRW?=
 =?utf-8?B?Z0NUbE43Yi8yeHJ5L1RiNnlGUHBmOEsrcmdQUXYvdDBwRERWekZBYUZpY0l3?=
 =?utf-8?Q?AXHs6WlDtKHQW?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f68d7d1-f593-4b90-41e5-08d93c6c33d0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:42:47.6740
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pVQEpEIZpkQd1GX5X6OgKcCADIP+/d3vqzQ8eEEeVj3UaMHHcfayO9XqhNTeXeVaCoQA+H3jQYgmbIC3Assojg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I find `monotonically increasing tokens' misleading, since the token may 
wrap around quite often during normal usage. How about `modulo 
incrementing'?

On 11.06.21 18:59, Cristian Marussi wrote:
> Tokens are sequence numbers embedded in the each SCMI message header: they
> are used to correlate commands with responses (and delayed responses), but
> their usage and policy of selection is entirely up to the caller (usually
> the OSPM agent), while they are completely opaque to the callee (SCMI
> server platform) which merely copies them back from the command into the
> response message header.
> This also means that the platform does not, can not and should not enforce
> any kind of policy on received messages depending on the contained sequence
> number: platform can perfectly handle concurrent requests carrying the same
> identifiying token if that should happen.
> 
> Moreover the platform is not required to produce in-order responses to
> agent requests, the only constraint in these regards is that in case of
> an asynchronous message the delayed response must be sent after the
> immediate response for the synchronous part of the command transaction.
> 
> Currenly the SCMI stack of the OSPM agent selects a token for the egressing
> commands picking the lowest possible number which is not already in use by
> an existing in-flight transaction, which means, in other words, that we
> immediately reuse any token after its transaction has completed or it has
> timed out: this policy indeed does simplify management and lookup of tokens
> and associated xfers.
> 
> Under the above assumptions and constraints, since there is really no state
> shared between the agent and the platform to let the platform know when a
> token and its associated message has timed out, the current policy of early
> reuse of tokens can easily lead to the situation in which a spurious or
> late received response (or delayed_response), related to an old stale and
> timed out transaction, can be wrongly associated to a newer valid in-flight
> xfer that just happens to have reused the same token.
> 
> This misbehaviour on such ghost responses is more easily exposed on those
> transports that naturally have an higher level of parallelism in processing
> multiple concurrent in-flight messages.
> 
> This commit introduces a new policy of selection of tokens for the OSPM
> agent: each new transfer now gets the next available and monotonically
> increasing token, until tokens are exhausted and the counter rolls over.
> 
> Such new policy mitigates the above issues with ghost responses since the
> tokens are now reused as late as possible (when they roll back ideally)
> and so it is much easier to identify such ghost responses to stale timed
> out transactions: this also helps in simplifying the specific transports
> implementation since stale transport messages can be easily identified
> and discarded early on in the rx path without the need to cross check
> their actual state with the core transport layer.
> This mitigation is even more effective when, as is usually the case, the
> maximum number of pending messages is capped by the platform to a much
> lower number than the whole possible range of tokens values (2^10).
> 
> This internal policy change in the core SCMI transport layer is fully
> transparent to the specific transports so it has not and should not have
> any impact on the transports implementation.
> 
> The empirically observed cost of such new procedure of token selection
> amounts in the best case to ~10us out of an observed full transaction cost
> of 3ms for the completion of a synchronous sensor reading command on a
> platform supporting commands completion interrupts.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h |  23 +++
>  drivers/firmware/arm_scmi/driver.c | 243 +++++++++++++++++++++++++----
>  2 files changed, 233 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 6bb734e0e3ac..e64c5ca9ee7c 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -14,7 +14,10 @@
>  #include <linux/device.h>
>  #include <linux/errno.h>
>  #include <linux/kernel.h>
> +#include <linux/hashtable.h>
> +#include <linux/list.h>
>  #include <linux/module.h>
> +#include <linux/refcount.h>
>  #include <linux/scmi_protocol.h>
>  #include <linux/types.h>
>  
> @@ -127,6 +130,21 @@ struct scmi_msg {
>  	size_t len;
>  };
>  
> +/**
> + * An helper macro to lookup an xfer from the @pending_xfers hashtable
> + * using the message sequence number token as a key.
> + */
> +#define XFER_FIND(__ht, __k)					\
> +({								\
> +	typeof(__k) k_ = __k;					\
> +	struct scmi_xfer *xfer_ = NULL;				\
> +								\
> +	hash_for_each_possible((__ht), xfer_, node, k_)		\
> +		if (xfer_->hdr.seq == k_)			\
> +			break;					\
> +	 xfer_;							\

There is an extra space before the return value.

> +})
> +
>  /**
>   * struct scmi_xfer - Structure representing a message flow
>   *
> @@ -138,6 +156,9 @@ struct scmi_msg {
>   *	buffer for the rx path as we use for the tx path.
>   * @done: command message transmit completion event
>   * @async_done: pointer to delayed response message received event completion
> + * @users: A refcount to track the active users for this xfer
> + * @node: An hlist_node reference used to store this xfer, alternatively, on
> + *	  the free list @free_xfers or in the @pending_xfers hashtable
>   */
>  struct scmi_xfer {
>  	int transfer_id;
> @@ -146,6 +167,8 @@ struct scmi_xfer {
>  	struct scmi_msg rx;
>  	struct completion done;
>  	struct completion *async_done;
> +	refcount_t users;
> +	struct hlist_node node;
>  };
>  
>  struct scmi_xfer_ops;
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 20f8f0581f3a..f0b20ddb24f4 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -21,6 +21,7 @@
>  #include <linux/io.h>
>  #include <linux/kernel.h>
>  #include <linux/ktime.h>
> +#include <linux/hashtable.h>
>  #include <linux/list.h>
>  #include <linux/module.h>
>  #include <linux/of_address.h>
> @@ -65,19 +66,29 @@ struct scmi_requested_dev {
>  	struct list_head node;
>  };
>  
> +#define SCMI_PENDING_XFERS_HT_ORDER_SZ	9

Micro-optimization note: This increases struct scmi_info size to > 8 kiB 
(on 64-bit architectures). A lower size of the hash table would be 
enough for some transports.

> +
>  /**
>   * struct scmi_xfers_info - Structure to manage transfer information
>   *
> - * @xfer_block: Preallocated Message array
>   * @xfer_alloc_table: Bitmap table for allocated messages.
>   *	Index of this bitmap table is also used for message
>   *	sequence identifier.
>   * @xfer_lock: Protection for message allocation
> + * @last_token: A counter to use as base to generate for monotonically
> + *		increasing tokens.
> + * @free_xfers: A free list for available to use xfers. It is initialized with
> + *		a number of xfers equal to the maximum allowed in-flight
> + *		messages.
> + * @pending_xfers: An hashtable, indexed by msg_hdr.seq, used to keep all the
> + *		   currently in-flight messages.
>   */
>  struct scmi_xfers_info {
> -	struct scmi_xfer *xfer_block;
>  	unsigned long *xfer_alloc_table;
>  	spinlock_t xfer_lock;
> +	atomic_t last_token;
> +	struct hlist_head free_xfers;
> +	DECLARE_HASHTABLE(pending_xfers, SCMI_PENDING_XFERS_HT_ORDER_SZ);
>  };
>  
>  /**
> @@ -203,6 +214,117 @@ void *scmi_notification_instance_data_get(const struct scmi_handle *handle)
>  	return info->notify_priv;
>  }
>  
> +/**
> + * scmi_xfer_token_set  - Reserve and set new token for the xfer at hand
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> + * @xfer: The xfer to act upon
> + *
> + * Pick the next unused monotonically increasing token and set it into
> + * xfer->hdr.seq: picking a monotonically increasing value avoids immediate
> + * reuse of freshly completed or timed-out xfers, thus mitigating the risk
> + * of incorrect association of a late and expired xfer with a live in-flight
> + * transaction, both happening to re-use the same token identifier.
> + *
> + * Since platform is NOT required to answer our request in-order we should
> + * account for a few rare but possible scenarios:
> + *
> + *  - exactly 'next_token' may be NOT available so pick xfer_id >= next_token
> + *    using find_next_zero_bit() starting from candidate next_token bit
> + *
> + *  - all tokens ahead upto (MSG_TOKEN_ID_MASK - 1) are used in-flight but we
> + *    are plenty of free tokens at start, so try a second pass using
> + *    find_next_zero_bit() and starting from 0.
> + *
> + *  X = used in-flight
> + *
> + * Normal
> + * ------
> + *
> + *		|- xfer_id picked
> + *   -----------+----------------------------------------------------------
> + *   | | |X|X|X| | | | | | ... ... ... ... ... ... ... ... ... ... ...|X|X|
> + *   ----------------------------------------------------------------------
> + *		^
> + *		|- next_token
> + *
> + * Out-of-order pending at start
> + * -----------------------------
> + *
> + *	  |- xfer_id picked, last_token fixed
> + *   -----+----------------------------------------------------------------
> + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... ... ...|X| |
> + *   ----------------------------------------------------------------------
> + *    ^
> + *    |- next_token
> + *
> + *
> + * Out-of-order pending at end
> + * ---------------------------
> + *
> + *	  |- xfer_id picked, last_token fixed
> + *   -----+----------------------------------------------------------------
> + *   |X|X| | | | |X|X| ... ... ... ... ... ... ... ... ... ... |X|X|X||X|X|
> + *   ----------------------------------------------------------------------
> + *								^
> + *								|- next_token
> + *
> + * Context: Assumes to be called with @xfer_lock already acquired.
> + *
> + * Return: 0 on Success or error
> + */
> +static int scmi_xfer_token_set(struct scmi_xfers_info *minfo,
> +			       struct scmi_xfer *xfer)
> +{
> +	unsigned long xfer_id, next_token;
> +
> +	/* Pick a candidate monotonic token in range [0, MSG_TOKEN_MAX - 1] */
> +	next_token = (atomic_inc_return(&minfo->last_token) &
> +		      (MSG_TOKEN_MAX - 1));
> +
> +	/* Pick the next available xfer_id >= next_token */
> +	xfer_id = find_next_zero_bit(minfo->xfer_alloc_table,
> +				     MSG_TOKEN_MAX, next_token);
> +	if (xfer_id == MSG_TOKEN_MAX) {
> +		/*
> +		 * After heavily out-of-order responses, there are no free
> +		 * tokens ahead, but only at start of xfer_alloc_table so
> +		 * try again from the beginning.
> +		 */
> +		xfer_id = find_next_zero_bit(minfo->xfer_alloc_table,
> +					     MSG_TOKEN_MAX, 0);
> +		/*
> +		 * Something is wrong if we got here since there can be a
> +		 * maximum number of (MSG_TOKEN_MAX - 1) in-flight messages
> +		 * but we have not found any free token [0, MSG_TOKEN_MAX - 1].
> +		 */
> +		if (WARN_ON_ONCE(xfer_id == MSG_TOKEN_MAX))
> +			return -ENOMEM;
> +	}
> +
> +	/* Update +/- last_token accordingly if we skipped some hole */
> +	if (xfer_id != next_token)
> +		atomic_add((int)(xfer_id - next_token), &minfo->last_token);
> +
> +	/* Set in-flight */
> +	set_bit(xfer_id, minfo->xfer_alloc_table);
> +	xfer->hdr.seq = (u16)xfer_id;
> +
> +	return 0;
> +}
> +
> +/**
> + * scmi_xfer_token_clear  - Release the token
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> + * @xfer: The xfer to act upon
> + */
> +static inline void scmi_xfer_token_clear(struct scmi_xfers_info *minfo,
> +					 struct scmi_xfer *xfer)
> +{
> +	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
> +}
> +
>  /**
>   * scmi_xfer_get() - Allocate one message
>   *
> @@ -212,36 +334,49 @@ void *scmi_notification_instance_data_get(const struct scmi_handle *handle)
>   * Helper function which is used by various message functions that are
>   * exposed to clients of this driver for allocating a message traffic event.
>   *
> - * This function can sleep depending on pending requests already in the system
> - * for the SCMI entity. Further, this also holds a spinlock to maintain
> - * integrity of internal data structures.
> + * Picks an xfer from the free list @free_xfers (if any available), sets a
> + * monotonically increasing token and stores the inflight xfer into the
> + * @pending_xfers hashtable for later retrieval.
> + *
> + * The successfully initialized xfer is refcounted.
> + *
> + * Context: Holds @xfer_lock while manipulating @xfer_alloc_table and
> + *	    @free_xfers.
>   *
>   * Return: 0 if all went fine, else corresponding error.
>   */
>  static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
>  				       struct scmi_xfers_info *minfo)
>  {
> -	u16 xfer_id;
> +	int ret;
> +	unsigned long flags;
>  	struct scmi_xfer *xfer;
> -	unsigned long flags, bit_pos;
> -	struct scmi_info *info = handle_to_scmi_info(handle);
>  
> -	/* Keep the locked section as small as possible */
>  	spin_lock_irqsave(&minfo->xfer_lock, flags);
> -	bit_pos = find_first_zero_bit(minfo->xfer_alloc_table,
> -				      info->desc->max_msg);
> -	if (bit_pos == info->desc->max_msg) {
> +	if (hlist_empty(&minfo->free_xfers)) {
>  		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>  		return ERR_PTR(-ENOMEM);
>  	}
> -	set_bit(bit_pos, minfo->xfer_alloc_table);
> -	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>  
> -	xfer_id = bit_pos;
> +	/* grab an xfer from the free_list */
> +	xfer = hlist_entry(minfo->free_xfers.first, struct scmi_xfer, node);
> +	hlist_del_init(&xfer->node);
>  
> -	xfer = &minfo->xfer_block[xfer_id];
> -	xfer->hdr.seq = xfer_id;
> -	xfer->transfer_id = atomic_inc_return(&transfer_last_id);
> +	/* Pick and set monotonic token */
> +	ret = scmi_xfer_token_set(minfo, xfer);
> +	if (!ret) {
> +		hash_add(minfo->pending_xfers, &xfer->node, xfer->hdr.seq);
> +	} else {
> +		dev_err(handle->dev, "Failed to get monotonic token %d\n", ret);
> +		hlist_add_head(&xfer->node, &minfo->free_xfers);
> +		xfer = ERR_PTR(ret);
> +	}
> +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +
> +	if (!IS_ERR(xfer)) {
> +		refcount_set(&xfer->users, 1);

Maybe it would be better to do this inside the lock, so that there is no 
(unlikely) race with refcount_inc() in scmi_xfer_acquire().

> +		xfer->transfer_id = atomic_inc_return(&transfer_last_id);
> +	}
>  
>  	return xfer;
>  }
> @@ -252,6 +387,9 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
>   * @minfo: Pointer to Tx/Rx Message management info based on channel type
>   * @xfer: message that was reserved by scmi_xfer_get
>   *
> + * After refcount check, possibly release an xfer, clearing the token slot,
> + * removing xfer from @pending_xfers and putting it back into free_xfers.
> + *
>   * This holds a spinlock to maintain integrity of internal data structures.
>   */
>  static void
> @@ -259,16 +397,41 @@ __scmi_xfer_put(struct scmi_xfers_info *minfo, struct scmi_xfer *xfer)
>  {
>  	unsigned long flags;
>  
> -	/*
> -	 * Keep the locked section as small as possible
> -	 * NOTE: we might escape with smp_mb and no lock here..
> -	 * but just be conservative and symmetric.
> -	 */
>  	spin_lock_irqsave(&minfo->xfer_lock, flags);
> -	clear_bit(xfer->hdr.seq, minfo->xfer_alloc_table);
> +	if (refcount_dec_and_test(&xfer->users)) {
> +		scmi_xfer_token_clear(minfo, xfer);
> +		hash_del(&xfer->node);
> +		hlist_add_head(&xfer->node, &minfo->free_xfers);
> +	}
>  	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
>  }
>  
> +/**
> + * scmi_xfer_lookup_unlocked  -  Helper to lookup an xfer_id
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> + * @xfer_id: Token ID to lookup in @pending_xfers
> + *
> + * Refcounting is untouched.
> + *
> + * Context: Assumes to be called with @xfer_lock already acquired.
> + *
> + * Return: A valid xfer on Success or error otherwise
> + */
> +static struct scmi_xfer *
> +scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
> +{
> +	struct scmi_xfer *xfer = NULL;
> +
> +	if (xfer_id >= MSG_TOKEN_MAX)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (test_bit(xfer_id, minfo->xfer_alloc_table))
> +		xfer = XFER_FIND(minfo->pending_xfers, xfer_id);
> +
> +	return xfer ?: ERR_PTR(-EINVAL);
> +}
> +
>  static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  {
>  	struct scmi_xfer *xfer;
> @@ -305,19 +468,22 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  static void scmi_handle_response(struct scmi_chan_info *cinfo,
>  				 u16 xfer_id, u8 msg_type)
>  {
> +	unsigned long flags;
>  	struct scmi_xfer *xfer;
>  	struct device *dev = cinfo->dev;
>  	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>  	struct scmi_xfers_info *minfo = &info->tx_minfo;
>  
>  	/* Are we even expecting this? */
> -	if (!test_bit(xfer_id, minfo->xfer_alloc_table)) {
> +	spin_lock_irqsave(&minfo->xfer_lock, flags);
> +	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
> +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +	if (IS_ERR(xfer)) {
>  		dev_err(dev, "message for %d is not expected!\n", xfer_id);
>  		info->desc->ops->clear_channel(cinfo);
>  		return;
>  	}
>  
> -	xfer = &minfo->xfer_block[xfer_id];
>  	/*
>  	 * Even if a response was indeed expected on this slot at this point,
>  	 * a buggy platform could wrongly reply feeding us an unexpected
> @@ -1033,18 +1199,25 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
>  		return -EINVAL;
>  	}
>  
> -	info->xfer_block = devm_kcalloc(dev, desc->max_msg,
> -					sizeof(*info->xfer_block), GFP_KERNEL);
> -	if (!info->xfer_block)
> -		return -ENOMEM;
> +	hash_init(info->pending_xfers);
>  
> -	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(desc->max_msg),
> +	/* Allocate a bitmask sized to hold MSG_TOKEN_MAX tokens */
> +	info->xfer_alloc_table = devm_kcalloc(dev, BITS_TO_LONGS(MSG_TOKEN_MAX),
>  					      sizeof(long), GFP_KERNEL);
>  	if (!info->xfer_alloc_table)
>  		return -ENOMEM;
>  
> -	/* Pre-initialize the buffer pointer to pre-allocated buffers */
> -	for (i = 0, xfer = info->xfer_block; i < desc->max_msg; i++, xfer++) {
> +	/*
> +	 * Preallocate a number of xfers equal to max inflight messages,
> +	 * pre-initialize the buffer pointer to pre-allocated buffers and
> +	 * attach all of them to the free list
> +	 */
> +	INIT_HLIST_HEAD(&info->free_xfers);
> +	for (i = 0; i < desc->max_msg; i++) {
> +		xfer = devm_kzalloc(dev, sizeof(*xfer), GFP_KERNEL);
> +		if (!xfer)
> +			return -ENOMEM;
> +
>  		xfer->rx.buf = devm_kcalloc(dev, sizeof(u8), desc->max_msg_size,
>  					    GFP_KERNEL);
>  		if (!xfer->rx.buf)
> @@ -1052,8 +1225,12 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
>  
>  		xfer->tx.buf = xfer->rx.buf;
>  		init_completion(&xfer->done);
> +
> +		/* Add initialized xfer to the free list */
> +		hlist_add_head(&xfer->node, &info->free_xfers);
>  	}
>  
> +	atomic_set(&info->last_token, -1);
>  	spin_lock_init(&info->xfer_lock);
>  
>  	return 0;
> 



