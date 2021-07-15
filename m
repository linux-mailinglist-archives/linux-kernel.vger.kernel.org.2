Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 433533CA288
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:37:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbhGOQjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:39:04 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com ([40.107.6.113]:20447
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229990AbhGOQjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:39:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q0dBMkbjqAU06/gocd0cLSt3K2BjMEGdI/UUc976ztKiQh16kHtqMKGa60zkpipr60Rw7MkQnFssZeW9Gnzs+bbevdZ0GYbl99g62Zu+8PtKoDx3rGMVzH+eCuPJZW8NWloYdUWJFw9sxpBrFZsJWLHoDy7vGMkmKm7yC9kLhUBxb86NAGAR/cLHadxFiieE3caEsChgBpGdIBQSzBykrZ0Qc7qSS5JseWG4vo//kT+jiK7ckwzWw2TseZZz4WXalldUnkqP44YQNKuLJByFMMoTNBn/NFkjfSvPzmLDPg/B6R/9a8DKfn5pDAPCzHPNPJs0j6T7RhpbyUXcPbks7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXptpz0hMttAhRTGORaQGQ8NubrmZXq70PQreurXeJE=;
 b=H2xlon78I9WU6WFCwLAFH6GuWh0wt7qsirHVq+f0pVDy2DgROjO+Aljyt7gilMF/I7DUe/u4b4NjLTKvZf/ZxHeWfy58t+f5lt8JKxa0AQ9UTmG9wbbHPp2+EoQuiTBj6oScTzu+1jnNoNpH1MZSXS6oNklZqbtyrGEwuSGiJhNj9vLF1TQ+HkxjOWnv/M8qNoQtDkEpytqlz/kAv7rBwDK6gVAUxsJGK6Fs9HNGy7QJtk7VvgHbng3FZgTi3b1o9Jqk9tb2CJIesIbHgFEjAFKUaxNM9nGP3tI7U9TVp/Y3AWK6HKxovXKr+1sUuQ1l1ySFnXtqiJvbYesbe1iTqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXptpz0hMttAhRTGORaQGQ8NubrmZXq70PQreurXeJE=;
 b=dTHfR6kNPt9h5S/Dhi+U2AiRqnooYZyKkQSMqTMpdOc7boXzXXxLWusF7F156JlvORk8bJa33XdUC9rXonaWvRRxQmFbS5o5Hp3UBMuXbHICVi5+s1wZzvHJOPnCY2glGNaR+3oS+hW0t/lYlPSui8wzuaTomnLyjuWnMBikYf0=
Authentication-Results: opensynergy.com; dkim=none (message not signed)
 header.d=none;opensynergy.com; dmarc=none action=none
 header.from=opensynergy.com;
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
References: <20210712141833.6628-1-cristian.marussi@arm.com>
 <20210712141833.6628-8-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v6 07/17] firmware: arm_scmi: Handle concurrent and
 out-of-order messages
Message-ID: <a163653c-51f9-adf0-c978-b747ddf2498a@opensynergy.com>
Date:   Thu, 15 Jul 2021 18:36:03 +0200
In-Reply-To: <20210712141833.6628-8-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P250CA0013.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::18) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43fd4378-2c5d-4c83-b638-08d947aea3f6
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0401MB240247BAC94702CD58A180E18C129@AM4PR0401MB2402.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pO8AQNskwfcGzhswX6JHs8Dx8rWSXXVqKGMoIWBe5T8oqbr+bGGHOxv7ao7SI9nicGzKkGqWefwmSuRPXJh7pVvmeiP4JkI81xiS+a6kOjN64g/rpTjEIXzSjEwZwBPTINt3hL9BDhAsUyQI4/gWUrheGZL/WLq9JRZnjnYgXA2Wto2IAk85+mL2p6UqCdLVMtiCsU+szVDwtyLXMRsWMVLRbFBNSsPJBQFNsU24IuuiSewO2nL+NFQlYBttMHGQKE7/j/kps/NXtzx7Xl/BwPVFgUs2XDvjgo4G+MWJBYN/kbTAg74jhNQURI3EU78T8GQRQa6YuMhPjOhCd5Y9MC2cx2Pqj8WoBZmMKnqBGxqx7Dd8DL5xkPsQTaDOqp1/RjUaXgcd6SoPxoobmRv1bJdVmto+0O88zOU0uZPkUYhZ7CjbU1wQw4yYBHFk9kP+w9T8pTp28215w1/ItFTSF4ofK0d4b9xI8XCP5Z9QhF00oUnhoe+6NdabWOa8oujW0wDeVJnFDw7otbg+/KbF25FRhaQWn3tQyBRpNdE66FRJZmPW3/44S9y0KIBKj8XCNmmhXXwT8VSpU+d2qA+XgTH7JKvPrNMfb7dBk7DIyOIoowk5k2F5JQyeAmECAFC1tM8exoH11MaZp9w1+uwsPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39830400003)(366004)(136003)(31686004)(15650500001)(31696002)(8676002)(30864003)(66476007)(2616005)(36756003)(8936002)(83380400001)(107886003)(86362001)(38100700002)(66556008)(478600001)(316002)(42186006)(4326008)(66946007)(44832011)(53546011)(5660300002)(186003)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGVvVmF6QkdCMDF4cVpMWkNxay9jcGJlejY0bEhMT0V6TzRicnl0L2FJVFdJ?=
 =?utf-8?B?a0plL2RQdXFjY1kzdkdQVlMxbzYvRXA1M2Z3UDF1QUVMZitnQ2taSi9GaU1l?=
 =?utf-8?B?OW1lTEZYOWN1RW1UVkYxVndERDdUVE5EZHhCbXB5S29IOWhDWWUzUDBUVFNi?=
 =?utf-8?B?UlBrNlIvMXloZkExdDU1bndCa21zaDZqM3E2Z2k3OEdlZkdSSGVTN3BtQmxK?=
 =?utf-8?B?NFlMQjIzdlpYcDlOMUtrL0thVnRnbTB4cjdHN2M1Qi9Oc0NsaWM0c2ZGVXJw?=
 =?utf-8?B?dXFhVEsyeVhXaEpndHJGcE9Va3c3S01BNlNBbml0ZFJkWHlqd0cxOFFkclRZ?=
 =?utf-8?B?cnB1KzFZYmNwaE9Hb2l1ZHVUN3RXZE14a2FvM3FXUW1sZnZWdEVXbldXcnJq?=
 =?utf-8?B?Y1NBNyt3UjY1OVpHenhLbldSdWJpZmpCdEhIRWdYYlk0VEc1WDE3bTJBYVZa?=
 =?utf-8?B?RGc3Q0xNT2ZjbGNtK3VBSkxOeDJCVTljeitFQmJRL1RobXF0V2tHbEhyaFcy?=
 =?utf-8?B?Z2JSUjRzR2pZcHZHcExTZDE4QkM0RGpLY1FuVTNGellTMU5yTm54bGRaVWcy?=
 =?utf-8?B?UHVTUklXN0cyQXdRdWJuWUZ4R003UU9mYjFSSHpVUkRUbGtZSmFTbWQ3cG51?=
 =?utf-8?B?cXBlT1VJQXJiZ3lRZ3BUZWlaeFBiTUx0a0VLczZVeTBLZ0dwdGl0blRZWlo2?=
 =?utf-8?B?L05lNEFBTXhVNklCeVJMakJkK0F5eE42NzNScWtqb2lRbDRZVEllOGNabWlw?=
 =?utf-8?B?TWRhTjJ6RE9mdG8ybVp6ZVBJK1Yvd1o5blhwb0JLTkt3ME5NUmN3NlEwNUJy?=
 =?utf-8?B?VDJ3a3loWDIvak1XOFhwYVhrSFJrMThTTFFPWVJnSnBFZzJpZjdOVUN0NFhq?=
 =?utf-8?B?QndzTDc2RzhVU1Y1UWtxNFp6YnNqWUE4MHpBOVk2TmN1S0tNclk4bnNvQUJi?=
 =?utf-8?B?TXpmZ0tUOVNMQ0dqc3RnZHFCNmNoWUxNd0tGeElyS3ZFRTlDRUFaenZuTFRB?=
 =?utf-8?B?SW5iWktnM3U5ajM5TGl6ZVNxUDk2a0lLSDJqVXlDNnpRQStVVmlsNFVML1Ir?=
 =?utf-8?B?N3pNMHZ3VGprWTJTS0E1dzJvT1FlRGRhOEVkeGdzckttbmtVVCtSTUh5M251?=
 =?utf-8?B?WkFIbnBHeFd4YVJwOUNBNnYvUG5XMWZNbHhXa1dXc0lsdVZXSnVsa0krOCt5?=
 =?utf-8?B?emNqWVhIM3EvRW5YeG9NYTM1WG1DelRFYmo2K1huS3YzaU0wK2xtOWwxVFd6?=
 =?utf-8?B?V2pVZnhzdldIM1JZbWJrbTQ1ZzNOWGhjRkFpMkV0REhaVk1KMUJ6dm1tMzlE?=
 =?utf-8?B?anhWSFhKWnYrQmtxK001QjBDdXlpSitpcXBFMVZrbWZyalhyRU9RNE9IY0hp?=
 =?utf-8?B?dnlMWlE0ZWdvNE5FaHJiVkJDWWphbEgybjMrb1NRc2NycHdqc3o2QWFZbXd6?=
 =?utf-8?B?ZkY4dk1jbkJ5dUhrN2oyb2tQdU5IZkRJZi9FZWtRNUhVK1lTQ29JdkdaOW02?=
 =?utf-8?B?S1MydlJnaXRRSHEzTWhVdTk2TGo1a29Ha1dTRnJkd0xwcjMzR2paTkNXQ3NP?=
 =?utf-8?B?ZXRJa2hqQ1NieVdRQ0JPQmR5ZG01NmsvSUpqREhNMktJTWZUb3dINUlIb1pC?=
 =?utf-8?B?YzZUbFNsZm1ucVBYbXBST3I0QktMYW1RK0xnYkxWWDJaS25nTW5hNVRIUU00?=
 =?utf-8?B?dUQ4TWZEN1VNaEZ6dGZaMFNyN3djNlZMVDZRdm5sUFZpUGlRc2hlYzIrM2t0?=
 =?utf-8?B?ZmJpakgvZzJpTHdYSC9uMFhJWlFVcVVUTlFuUWpmMFlFbnJHY2NTRlFLWkNE?=
 =?utf-8?B?cytIeEw5TlgrSXgrVHM5YkxZbEwybTdNdlhYTUNlcDV4aXVHMmRXVWNhNmdR?=
 =?utf-8?Q?s1UTz9BeILCHz?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43fd4378-2c5d-4c83-b638-08d947aea3f6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:36:05.2283
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 96cyi244QloEXjWcyy2y+QajZFNbigUP5aNvEgXdAn/Hm8biXcXCD/LdCuLRTqZI9qH9oQCoj1+qIe0VHh081Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.21 16:18, Cristian Marussi wrote:
> Even though in case of asynchronous commands an SCMI platform server is
> constrained to emit the delayed response message only after the related
> message response has been sent, the configured underlying transport could
> still deliver such messages together or in inverted order, causing races
> due to the concurrent or out-of-order access to the underlying xfer.
> 
> Introduce a mechanism to grant exclusive access to an xfer in order to
> properly serialize concurrent accesses to the same xfer originating from
> multiple correlated messages.
> 
> Add additional state information to xfer descriptors so as to be able to
> identify out-of-order message deliveries and act accordingly:
> 
>   - when a delayed response is expected but delivered before the related
>     response, the synchronous response is considered as successfully
>     received and the delayed response processing is carried on as usual.
> 
>   - when/if the missing synchronous response is subsequently received, it
>     is discarded as not congruent with the current state of the xfer, or
>     simply, because the xfer has been already released and so, now, the
>     monotonically increasing sequence number carried by the late response
>     is stale.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v5 --> v6
> - added spinlock comment
> ---
>   drivers/firmware/arm_scmi/common.h |  18 ++-
>   drivers/firmware/arm_scmi/driver.c | 229 ++++++++++++++++++++++++-----
>   2 files changed, 212 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 2233d0a188fc..9efebe1406d2 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -19,6 +19,7 @@
>   #include <linux/module.h>
>   #include <linux/refcount.h>
>   #include <linux/scmi_protocol.h>
> +#include <linux/spinlock.h>
>   #include <linux/types.h>
>   
>   #include <asm/unaligned.h>
> @@ -145,6 +146,13 @@ struct scmi_msg {
>    * @pending: True for xfers added to @pending_xfers hashtable
>    * @node: An hlist_node reference used to store this xfer, alternatively, on
>    *	  the free list @free_xfers or in the @pending_xfers hashtable
> + * @busy: An atomic flag to ensure exclusive write access to this xfer
> + * @state: The current state of this transfer, with states transitions deemed
> + *	   valid being:
> + *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_RESP_OK [ -> SCMI_XFER_DRESP_OK ]
> + *	    - SCMI_XFER_SENT_OK -> SCMI_XFER_DRESP_OK
> + *	      (Missing synchronous response is assumed OK and ignored)
> + * @lock: A spinlock to protect state and busy fields.
>    */
>   struct scmi_xfer {
>   	int transfer_id;
> @@ -156,6 +164,15 @@ struct scmi_xfer {
>   	refcount_t users;
>   	bool pending;
>   	struct hlist_node node;
> +#define SCMI_XFER_FREE		0
> +#define SCMI_XFER_BUSY		1
> +	atomic_t busy;
> +#define SCMI_XFER_SENT_OK	0
> +#define SCMI_XFER_RESP_OK	1
> +#define SCMI_XFER_DRESP_OK	2
> +	int state;
> +	/* A lock to protect state and busy fields */
> +	spinlock_t lock;
>   };
>   
>   /*
> @@ -392,5 +409,4 @@ bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
>   void scmi_notification_instance_data_set(const struct scmi_handle *handle,
>   					 void *priv);
>   void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
> -
>   #endif /* _SCMI_COMMON_H */
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 245ede223302..5ef33d692670 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -369,6 +369,7 @@ static struct scmi_xfer *scmi_xfer_get(const struct scmi_handle *handle,
>   
>   	if (!IS_ERR(xfer)) {
>   		refcount_set(&xfer->users, 1);
> +		atomic_set(&xfer->busy, SCMI_XFER_FREE);
>   		xfer->transfer_id = atomic_inc_return(&transfer_last_id);
>   	}
>   	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> @@ -430,6 +431,168 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
>   	return xfer ?: ERR_PTR(-EINVAL);
>   }
>   
> +/**
> + * scmi_msg_response_validate  - Validate message type against state of related
> + * xfer
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @msg_type: Message type to check
> + * @xfer: A reference to the xfer to validate against @msg_type
> + *
> + * This function checks if @msg_type is congruent with the current state of
> + * a pending @xfer; if an asynchronous delayed response is received before the
> + * related synchronous response (Out-of-Order Delayed Response) the missing
> + * synchronous response is assumed to be OK and completed, carrying on with the
> + * Delayed Response: this is done to address the case in which the underlying
> + * SCMI transport can deliver such out-of-order responses.
> + *
> + * Context: Assumes to be called with xfer->lock already acquired.
> + *
> + * Return: 0 on Success, error otherwise
> + */
> +static inline int scmi_msg_response_validate(struct scmi_chan_info *cinfo,
> +					     u8 msg_type,
> +					     struct scmi_xfer *xfer)
> +{
> +	/*
> +	 * Even if a response was indeed expected on this slot at this point,
> +	 * a buggy platform could wrongly reply feeding us an unexpected
> +	 * delayed response we're not prepared to handle: bail-out safely
> +	 * blaming firmware.
> +	 */
> +	if (msg_type == MSG_TYPE_DELAYED_RESP && !xfer->async_done) {
> +		dev_err(cinfo->dev,
> +			"Delayed Response for %d not expected! Buggy F/W ?\n",
> +			xfer->hdr.seq);
> +		return -EINVAL;
> +	}
> +
> +	switch (xfer->state) {
> +	case SCMI_XFER_SENT_OK:
> +		if (msg_type == MSG_TYPE_DELAYED_RESP) {
> +			/*
> +			 * Delayed Response expected but delivered earlier.
> +			 * Assume message RESPONSE was OK and skip state.
> +			 */
> +			xfer->hdr.status = SCMI_SUCCESS;
> +			xfer->state = SCMI_XFER_RESP_OK;
> +			complete(&xfer->done);
> +			dev_warn(cinfo->dev,
> +				 "Received valid OoO Delayed Response for %d\n",
> +				 xfer->hdr.seq);
> +		}
> +		break;
> +	case SCMI_XFER_RESP_OK:
> +		if (msg_type != MSG_TYPE_DELAYED_RESP)
> +			return -EINVAL;
> +		break;
> +	case SCMI_XFER_DRESP_OK:
> +		/* No further message expected once in SCMI_XFER_DRESP_OK */
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static bool scmi_xfer_is_free(struct scmi_xfer *xfer)
> +{
> +	int ret;
> +
> +	ret = atomic_cmpxchg(&xfer->busy, SCMI_XFER_FREE, SCMI_XFER_BUSY);

Naming: Rather unusual to change state in an _is_free() function, 
looking at other _is_free() functions in the kernel.

> +
> +	return ret == SCMI_XFER_FREE;
> +}
> +
> +/**
> + * scmi_xfer_command_acquire  -  Helper to lookup and acquire a command xfer
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @msg_hdr: A message header to use as lookup key
> + *
> + * When a valid xfer is found for the sequence number embedded in the provided
> + * msg_hdr, reference counting is properly updated and exclusive access to this
> + * xfer is granted till released with @scmi_xfer_command_release.
> + *
> + * Return: A valid @xfer on Success or error otherwise.
> + */
> +static inline struct scmi_xfer *
> +scmi_xfer_command_acquire(struct scmi_chan_info *cinfo, u32 msg_hdr)
> +{
> +	int ret;
> +	unsigned long flags;
> +	struct scmi_xfer *xfer;
> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> +	struct scmi_xfers_info *minfo = &info->tx_minfo;
> +	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
> +	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
> +
> +	/* Are we even expecting this? */
> +	spin_lock_irqsave(&minfo->xfer_lock, flags);
> +	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
> +	if (IS_ERR(xfer)) {
> +		dev_err(cinfo->dev,
> +			"Message for %d type %d is not expected!\n",
> +			xfer_id, msg_type);
> +		spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +		return xfer;
> +	}
> +	refcount_inc(&xfer->users);
> +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +
> +	spin_lock_irqsave(&xfer->lock, flags);
> +	ret = scmi_msg_response_validate(cinfo, msg_type, xfer);
> +	/*
> +	 * If a pending xfer was found which was also in a congruent state with
> +	 * the received message, acquire exclusive access to it setting the busy
> +	 * flag.
> +	 * Spins only on the rare limit condition of concurrent reception of
> +	 * RESP and DRESP for the same xfer.
> +	 */
> +	if (!ret) {
> +		spin_until_cond(scmi_xfer_is_free(xfer));

Maybe there should be an additional comment to indicate that the 
xfer->lock cannot be reaquired later during response processing, to 
avoid a deadlock in conjunction with the xfer->busy flag.

> +		xfer->hdr.type = msg_type;
> +	}
> +	spin_unlock_irqrestore(&xfer->lock, flags);
> +
> +	if (ret) {
> +		dev_err(cinfo->dev,
> +			"Invalid message type:%d for %d - HDR:0x%X  state:%d\n",
> +			msg_type, xfer_id, msg_hdr, xfer->state);
> +		/* On error the refcount incremented above has to be dropped */
> +		__scmi_xfer_put(minfo, xfer);
> +		xfer = ERR_PTR(-EINVAL);
> +	}
> +
> +	return xfer;
> +}
> +
> +static inline void scmi_xfer_command_release(struct scmi_info *info,
> +					     struct scmi_xfer *xfer)
> +{
> +	atomic_set(&xfer->busy, SCMI_XFER_FREE);
> +	__scmi_xfer_put(&info->tx_minfo, xfer);
> +}
> +
> +/**
> + * scmi_xfer_state_update  - Update xfer state
> + *
> + * @xfer: A reference to the xfer to update
> + *
> + * Context: Assumes to be called on an xfer exclusively acquired using the
> + *	    busy flag.
> + */
> +static inline void scmi_xfer_state_update(struct scmi_xfer *xfer)
> +{
> +	switch (xfer->hdr.type) {
> +	case MSG_TYPE_COMMAND:
> +		xfer->state = SCMI_XFER_RESP_OK;
> +		break;
> +	case MSG_TYPE_DELAYED_RESP:
> +		xfer->state = SCMI_XFER_DRESP_OK;
> +		break;
> +	}
> +}
> +
>   static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>   {
>   	struct scmi_xfer *xfer;
> @@ -462,57 +625,37 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>   	info->desc->ops->clear_channel(cinfo);
>   }
>   
> -static void scmi_handle_response(struct scmi_chan_info *cinfo,
> -				 u16 xfer_id, u8 msg_type)
> +static void scmi_handle_response(struct scmi_chan_info *cinfo, u32 msg_hdr)
>   {
> -	unsigned long flags;
>   	struct scmi_xfer *xfer;
> -	struct device *dev = cinfo->dev;
>   	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> -	struct scmi_xfers_info *minfo = &info->tx_minfo;
>   
> -	/* Are we even expecting this? */
> -	spin_lock_irqsave(&minfo->xfer_lock, flags);
> -	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
> -	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +	xfer = scmi_xfer_command_acquire(cinfo, msg_hdr);
>   	if (IS_ERR(xfer)) {
> -		dev_err(dev, "message for %d is not expected!\n", xfer_id);
>   		info->desc->ops->clear_channel(cinfo);
>   		return;
>   	}
>   
> -	/*
> -	 * Even if a response was indeed expected on this slot at this point,
> -	 * a buggy platform could wrongly reply feeding us an unexpected
> -	 * delayed response we're not prepared to handle: bail-out safely
> -	 * blaming firmware.
> -	 */
> -	if (unlikely(msg_type == MSG_TYPE_DELAYED_RESP && !xfer->async_done)) {
> -		dev_err(dev,
> -			"Delayed Response for %d not expected! Buggy F/W ?\n",
> -			xfer_id);
> -		info->desc->ops->clear_channel(cinfo);
> -		/* It was unexpected, so nobody will clear the xfer if not us */
> -		__scmi_xfer_put(minfo, xfer);
> -		return;
> -	}
> +	scmi_xfer_state_update(xfer);

Since this update is not protected by the xfer->lock any more, it may 
not become visible in time to a concurrent response which is checking 
and possibly updating state in scmi_msg_response_validate(). I think 
this should be avoided, even if it might not cause practical problems ATM.

>   
>   	/* rx.len could be shrunk in the sync do_xfer, so reset to maxsz */
> -	if (msg_type == MSG_TYPE_DELAYED_RESP)
> +	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP)
>   		xfer->rx.len = info->desc->max_msg_size;
>   
>   	info->desc->ops->fetch_response(cinfo, xfer);
>   
>   	trace_scmi_rx_done(xfer->transfer_id, xfer->hdr.id,
>   			   xfer->hdr.protocol_id, xfer->hdr.seq,
> -			   msg_type);
> +			   xfer->hdr.type);
>   
> -	if (msg_type == MSG_TYPE_DELAYED_RESP) {
> +	if (xfer->hdr.type == MSG_TYPE_DELAYED_RESP) {
>   		info->desc->ops->clear_channel(cinfo);
>   		complete(xfer->async_done);
>   	} else {
>   		complete(&xfer->done);
>   	}
> +
> +	scmi_xfer_command_release(info, xfer);
>   }
>   
>   /**
> @@ -529,7 +672,6 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
>    */
>   void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
>   {
> -	u16 xfer_id = MSG_XTRACT_TOKEN(msg_hdr);
>   	u8 msg_type = MSG_XTRACT_TYPE(msg_hdr);
>   
>   	switch (msg_type) {
> @@ -538,7 +680,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
>   		break;
>   	case MSG_TYPE_COMMAND:
>   	case MSG_TYPE_DELAYED_RESP:
> -		scmi_handle_response(cinfo, xfer_id, msg_type);
> +		scmi_handle_response(cinfo, msg_hdr);
>   		break;
>   	default:
>   		WARN_ONCE(1, "received unknown msg_type:%d\n", msg_type);
> @@ -550,7 +692,7 @@ void scmi_rx_callback(struct scmi_chan_info *cinfo, u32 msg_hdr)
>    * xfer_put() - Release a transmit message
>    *
>    * @ph: Pointer to SCMI protocol handle
> - * @xfer: message that was reserved by scmi_xfer_get
> + * @xfer: message that was reserved by xfer_get_init
>    */
>   static void xfer_put(const struct scmi_protocol_handle *ph,
>   		     struct scmi_xfer *xfer)
> @@ -568,7 +710,12 @@ static bool scmi_xfer_done_no_timeout(struct scmi_chan_info *cinfo,
>   {
>   	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
>   
> +	/*
> +	 * Poll also on xfer->done so that polling can be forcibly terminated
> +	 * in case of out-of-order receptions of delayed responses
> +	 */
>   	return info->desc->ops->poll_done(cinfo, xfer) ||
> +	       try_wait_for_completion(&xfer->done) ||
>   	       ktime_after(ktime_get(), stop);
>   }
>   
> @@ -608,6 +755,7 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>   			      xfer->hdr.protocol_id, xfer->hdr.seq,
>   			      xfer->hdr.poll_completion);
>   
> +	xfer->state = SCMI_XFER_SENT_OK;

To be completely safe, this assignment could also be protected by the 
xfer->lock.

>   	ret = info->desc->ops->send_message(cinfo, xfer);
>   	if (ret < 0) {
>   		dev_dbg(dev, "Failed to send message %d\n", ret);
> @@ -619,10 +767,22 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>   
>   		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
>   
> -		if (ktime_before(ktime_get(), stop))
> -			info->desc->ops->fetch_response(cinfo, xfer);
> -		else
> +		if (ktime_before(ktime_get(), stop)) {
> +			unsigned long flags;
> +
> +			/*
> +			 * Do not fetch_response if an out-of-order delayed
> +			 * response is being processed.
> +			 */
> +			spin_lock_irqsave(&xfer->lock, flags);
> +			if (xfer->state == SCMI_XFER_SENT_OK) {
> +				info->desc->ops->fetch_response(cinfo, xfer);
> +				xfer->state = SCMI_XFER_RESP_OK;
> +			}
> +			spin_unlock_irqrestore(&xfer->lock, flags);
> +		} else {
>   			ret = -ETIMEDOUT;
> +		}
>   	} else {
>   		/* And we wait for the response. */
>   		timeout = msecs_to_jiffies(info->desc->max_rx_timeout_ms);
> @@ -1220,6 +1380,7 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
>   
>   		xfer->tx.buf = xfer->rx.buf;
>   		init_completion(&xfer->done);
> +		spin_lock_init(&xfer->lock);
>   
>   		/* Add initialized xfer to the free list */
>   		hlist_add_head(&xfer->node, &info->free_xfers);
> 

