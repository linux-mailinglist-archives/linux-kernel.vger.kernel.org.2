Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D21CC3B8F02
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235493AbhGAIp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:45:26 -0400
Received: from mail-eopbgr10136.outbound.protection.outlook.com ([40.107.1.136]:58247
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235579AbhGAIpZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:45:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zs2nGgNdOnGH5mLDjOkgcxZ1KVvbupb9KB5AbM9VmxovAuOOzV509LSwN2isFTKLHkhIegJa1O+8B4lx2zA9rFROn8Hn+RgsnASRO7cXAxkEuUIkK7MpGzSq+9sCqB+ITu37aBPZNz8Gwb74bUrG24IrnWJtPyIvZHJTjTstw8lYtq3FyuhS0BRfIKu8EQBi9I2Iaf2X7a33lEA0hkk46vxnK/wirm0wM1DzcoDjwZjdUK3Bzc9+z4PyW9YIIVvrmcwOJQTbUsvZeUBkdRGj2MRh7hG0FzEup1KRIOVvw3ilyGUvCPCm45Rox+u8dDKUTytUio/VUHIPU4QumsP6UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv4fpEsRaUxFOTAI/knYmC0II/WQYU308jyEr5r8Ewg=;
 b=ONsgySlMRCfFc9UBm3UAyP55Zg49qHwHb2Rf4zCBvEghkwnJqGN9zfBFNzGxS+urr8hzLC5KDwvvDZ09lZJ9jOY6bc8CBrmpvh3YKheRW9wJ3Ct+kiHO3XWz6MWHWJO89xWuH1P80JxvAgsaqfX9eudjG+aWCLJ9WXMKGsaEAPyasswv9OWMQQq7V1U+oHlAYKLkSOsuMhKpmLbCZRwWq4rFiFarbx1Va1hjfxUPQgH1LVc+nh0DrpG6mt8j8HHWy0DCIKc5BV3lPJFuUTx+3LYInW8Y7C4PeFadlr6kGJVzbg8e+2/kZ70E324PqxzhbSMWjIYnYtO4rdZjsn+FkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vv4fpEsRaUxFOTAI/knYmC0II/WQYU308jyEr5r8Ewg=;
 b=smy30pgNWZ1Z5+mVeqMkxlKwIFgcyidAbNtgsTJl+3D7rVa99sk/X1eHQcSvy+NEHzQaWeZaF6elQQTf9pGrW93N3lLhTsAmeiRNt0k2gaKPvUDcH7gv75fnDmfMBGbGFyNtbgcQrvJXT1CUXo0iRKxHh7kKK5VYctlQfxY7sbU=
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
 <20210611165937.701-6-cristian.marussi@arm.com>
Subject: Re: [PATCH v4 05/16] firmware: arm_scmi: Introduce delegated xfers
 support
Message-ID: <1675b521-8164-4daa-baa1-592268474a56@opensynergy.com>
Date:   Thu, 1 Jul 2021 10:42:51 +0200
In-Reply-To: <20210611165937.701-6-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0059.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::36) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0233464-c74f-4825-ba56-08d93c6c36fc
X-MS-TrafficTypeDiagnostic: AM9PR04MB8356:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB8356188E9B0FE8A9130B9AB28C009@AM9PR04MB8356.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /2M9LgYKDnatxOWpZVbmlL3utuwUzAgOrcIeBDfgim8tdikqlJJXq+dbyBbe994hCrD2pa8/muOhZASvPTRfoZ+NnJeJAVo/B78b8pypUZENhIju+ggVUSpHdQo566u34d9kBr+8zQu8Sh0QObshLa27nxuBhRPJJjUCUx3ue6gAvRNmZIrn+l7vAOC2MNtiAR2ze1G5bqlsIMKTVV+Yv6zpZLW3KXvnsuSlIOnlXPb/t5CJjojTWs5f1DXOJcTm+2ntLRgJfatJLFEoW8JkLjSYqCWW+63WJChbQDzd3owbEOT/55X/0k0/lNKjyYDb/IEppBlDL8xvVa2D6HeZX3RZdHGN6/pSJwPcSb6B+limCHNOMjJCUjdbjSKOjp4arAjS0tkiB0Jrgr2i76S4IRU1mJHBZx5Wi9OpumrbxbuCNHyihdAkwYjde0DU+LYgg7iylWqQl/BjyGrQzmR1BAQuX+HAnGUeiiaJa+eMB1LW5napSs4ETarrW0WnCrP1ZyYZ78TUGO1l9R95IYuHdsg6XnS3Oys9fg1YVN+dX8p13M0Qrr1snBTwKHx1VkbWQej7lhYug/HbuDr/FgUfyhPqX+jVV8W+rWhBjwLOfopXgFaEWVTP8sXbRU/duNnZryPOQp9kBcqM0pZPcgooqjKBbSNvb7qRHRpxsk5wB13Mxs4xONBtU+3iJ2IZ3ldr4LBfXWUc4weYoVn0xmEepYxH8ORQUErTlJHVwCh2bYk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(366004)(346002)(376002)(396003)(136003)(186003)(8676002)(4326008)(38100700002)(30864003)(5660300002)(66476007)(66946007)(2616005)(8936002)(316002)(31696002)(66556008)(107886003)(42186006)(44832011)(53546011)(7416002)(83380400001)(478600001)(36756003)(31686004)(2906002)(86362001)(358444002)(21314003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?STVCdC9BMHhIbFBBdkk0a29pU3Y0T2x3aHMzeWpyZnY4RDZjT24rTmJyeS9R?=
 =?utf-8?B?Y25LNm41UTgzckhGS280bGhkNXhieCtrekxSbkh4MHpUR3lpSUEwdzdMRGpX?=
 =?utf-8?B?dmVXSEZuaTVIUGp5MjhPV0V3Mm1wajBvSnh1VUhuVkw2c2VKeithd2YzN1J6?=
 =?utf-8?B?QzlKOFB3dC9sR1BpbVlOMUR0TWtaS0NjZDBIcTFFQkpMd0JSOXJIek1zbGtv?=
 =?utf-8?B?RE81aFloZXpQNk5GTDNHWTBWVForZkI5VFZxT0hhRE5IS0dBMGZEcU41N2NK?=
 =?utf-8?B?b2hWSzNjSnlhK3k0K3VaNHdoVkR1OE9NdGl2WUlIUWdSd3dBbFVUand0UnFu?=
 =?utf-8?B?ckphdDJtQkx4N3dKcWFCZWdrVDl1N1h3NUxkTHpzZFp2eXRmbURDZUlkWkhy?=
 =?utf-8?B?Rk15TXBYQmtuUXRzb3E1aWdFNjROU2ZOZ2dWZldtQmlnRzBDbmxiS1RacUt1?=
 =?utf-8?B?QmJXUnBoMFh0R3V4cnFWUjZzdEh4Mm1CZmZjdU9iNVIxdTd6d1c5T29YL0xi?=
 =?utf-8?B?cERsb1RMTXpaWmx4anN5dkpDWDVOMkVYaEtTQklMYWxDUHRxZHNQVWpleXl6?=
 =?utf-8?B?SVppbUYwRmc3bWtZSmdTa2J5NzRodElRbW5pbHh6SlJUUWxrbEZkUGpWZzFv?=
 =?utf-8?B?TlVBRm4yQlhja1ZFWVZlOUtrRmtaRlVlSDBrVGg0YnJBaldpTUNsRmJMdC9j?=
 =?utf-8?B?SnBUODhVV1lOMCtHdnlOald1aUo0QkloMElpanpnNTRMN3o2b2xSSlhTQW9J?=
 =?utf-8?B?QzNEVkhnd2NyRWtjL2E1NTVOQjFXVUpUN09MUCtBSllIWFUxVnYxS2xXRlZF?=
 =?utf-8?B?UzhLT2VDNHcyK1h0VHpnWk9MaHdLdjdNN1FiZ1F5TnU3Y1ZESkVEN3JzSkht?=
 =?utf-8?B?d2FvZCtReFRuOGg1dkFGdE5DaWhNVUFGU0xNY2lBMERKQzJZajd5YlZva0lt?=
 =?utf-8?B?bXNzRG54NW5vMEhFdTlSUEw0SVozYXRqV0ZjcVlWN3lZWGVYN0Q0YXU1Q1lp?=
 =?utf-8?B?bytsenpGMkkraFNpYnZoWTRhYUV6cTAyb1M1NVkvd2l3eE9tRnk1TEp3TDZK?=
 =?utf-8?B?R2NJRVJGaFh2cW5YQk9LSnkzVTJQK0RqOUh1QzlqQkJVT2JTNTBUZjc5UWJp?=
 =?utf-8?B?a1hXQ3ovWDlZYlBxVG84RzVtUG5mdzRhSitZaVRPcmlxUTR1Tis2dWNHZ3pD?=
 =?utf-8?B?RG1pMFh0QUg5bFkreVUzbDFkcjhrdHRKamxmMGVBWnYzdzZhQmtHbyt5ODdQ?=
 =?utf-8?B?MFhMNnpscFRhVEExZlcrQUkrWTlqKzBqTE53Y25CWm9DL2tCNExTMko3NHJO?=
 =?utf-8?B?QWNsUURCdjlHTzdPejJ4NzQ1b0NYVFc3NW5OT2xOVUVTMjNZREJrODJhUnA4?=
 =?utf-8?B?ME9GUU1QdkZOUW9ZQlpORDRwWHFPdEhTWVJmUm9nQy95Smt1S0FOU0lBK0ZV?=
 =?utf-8?B?TEh0QTE2YmJNNitzdEFQWWpjZS9TaFZZY0Y1UkFZQ2MzY2U5NndGQ1REVk5I?=
 =?utf-8?B?UlpWMzVQTVFIcmdNSHlnamsrQlpkVGNpL3FpT0o5b1lUVUcwUFJUZTVReHdq?=
 =?utf-8?B?T25HOW8vMTRLWHlRUUlMYlQ5bXVJbnBmRW5GMFV3ODh6SnVuVnNaczdkbWNx?=
 =?utf-8?B?aWYxUmVKSFpvOEJWQlFzaUtxdWZxMWhhZXdsRE9sckZTakttSTdnNng5YjBQ?=
 =?utf-8?B?YVh1N0J3cFlFcTljcUhpY0orUC83dloydUVHbUtoLzJSbEdtMWE5STlRWjVO?=
 =?utf-8?B?Z2I2VE0zalFhZTVFZ2Z2V0YyOGhyc0dNL1hVbEtZV24rVmw1WFFtU0ZFdVBk?=
 =?utf-8?B?bnRCeVBPN0tKK3cyb1lRWW1oeVJIVDd2cEtVNjdRa1lRaEFPMURnY0lnZVNz?=
 =?utf-8?Q?uu8iemcFEjrXf?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0233464-c74f-4825-ba56-08d93c6c36fc
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:42:52.9030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aj5nrS9tIoEZLOoKvPPiqkQRA2cpvFatqfcEPXmWY1cZeed+wYCo1iKOtmCXvEtnI01fM9EYwLrCtBaxmIiXJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8356
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.06.21 18:59, Cristian Marussi wrote:
> Introduce optional support for delegated xfers allocation.
> 
> An SCMI transport can optionally declare to support delegated xfers and
> then use a few helper functions exposed by the core SCMI transport layer to
> query the core for existing in-flight transfers matching a provided message
> header or alternatively and transparently obtain a brand new xfer to handle
> a freshly received notification message.
> In both cases the obtained xfer is uniquely mapped into a specific xfer
> through the means of the message header acting as key.
> 
> In this way such a transport can properly store its own transport specific
> payload into the xfer uniquely associated to the message header before
> even calling into the core scmi_rx_callback() in the usual way, so that
> the transport specific message envelope structures can be freed early
> and there is no more need to keep track of their status till the core
> fully processes the xfer to completion or times out.
> 
> The scmi_rx_callbak() does not need to be modified to carry additional
> transport-specific ancillary data related to such message envelopes since
> an unique natural association is established between the xfer and the
> related message header.
> 
> Existing transports that do not need anything of the above will continue
> to work as before without any change.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h |  14 +++
>  drivers/firmware/arm_scmi/driver.c | 132 ++++++++++++++++++++++++++++-
>  2 files changed, 143 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index e64c5ca9ee7c..0edc04bc434c 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -80,6 +80,7 @@ struct scmi_msg_resp_prot_version {
>   * @status: Status of the transfer once it's complete
>   * @poll_completion: Indicate if the transfer needs to be polled for
>   *	completion or interrupt mode is used
> + * @saved_hdr: A copy of the original msg_hdr
>   */
>  struct scmi_msg_hdr {
>  	u8 id;
> @@ -88,6 +89,7 @@ struct scmi_msg_hdr {
>  	u16 seq;
>  	u32 status;
>  	bool poll_completion;
> +	u32 saved_hdr;
>  };
>  
>  /**
> @@ -154,6 +156,9 @@ struct scmi_msg {
>   * @rx: Receive message, the buffer should be pre-allocated to store
>   *	message. If request-ACK protocol is used, we can reuse the same
>   *	buffer for the rx path as we use for the tx path.
> + * @rx_raw_len: A field which can be optionally used by a specific transport
> + *		to save transport specific message length
> + *		It is not used by the SCMI transport core
>   * @done: command message transmit completion event
>   * @async_done: pointer to delayed response message received event completion
>   * @users: A refcount to track the active users for this xfer
> @@ -165,6 +170,7 @@ struct scmi_xfer {
>  	struct scmi_msg_hdr hdr;
>  	struct scmi_msg tx;
>  	struct scmi_msg rx;
> +	size_t rx_raw_len;
>  	struct completion done;
>  	struct completion *async_done;
>  	refcount_t users;
> @@ -355,6 +361,9 @@ struct scmi_device *scmi_child_dev_find(struct device *parent,
>   * @max_msg: Maximum number of messages that can be pending
>   *	simultaneously in the system
>   * @max_msg_size: Maximum size of data per message that can be handled.
> + * @support_xfers_delegation: A flag to indicate if the described transport
> + *			      will handle delegated xfers, so the core can
> + *			      derive proper related assumptions.
>   */
>  struct scmi_desc {
>  	int (*init)(void);
> @@ -363,6 +372,7 @@ struct scmi_desc {
>  	int max_rx_timeout_ms;
>  	int max_msg;
>  	int max_msg_size;
> +	bool support_xfers_delegation;
>  };
>  
>  extern const struct scmi_desc scmi_mailbox_desc;
> @@ -391,4 +401,8 @@ void scmi_notification_instance_data_set(const struct scmi_handle *handle,
>  					 void *priv);
>  void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
>  
> +int scmi_transfer_acquire(struct scmi_chan_info *cinfo, u32 *msg_hdr,
> +			  struct scmi_xfer **xfer);
> +void scmi_transfer_release(struct scmi_chan_info *cinfo,
> +			   struct scmi_xfer *xfer);
>  #endif /* _SCMI_COMMON_H */
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index f0b20ddb24f4..371d3804cd79 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -432,6 +432,124 @@ scmi_xfer_lookup_unlocked(struct scmi_xfers_info *minfo, u16 xfer_id)
>  	return xfer ?: ERR_PTR(-EINVAL);
>  }
>  
> +/**
> + * scmi_xfer_acquire  -  Helper to lookup and acquire an xfer
> + *
> + * @minfo: Pointer to Tx/Rx Message management info based on channel type
> + * @xfer_id: Token ID to lookup in @pending_xfers
> + *
> + * When a valid xfer is found for the provided @xfer_id, reference counting is
> + * properly updated.
> + *
> + * Return: A valid @xfer on Success or error otherwise.
> + */
> +static struct scmi_xfer *
> +scmi_xfer_acquire(struct scmi_xfers_info *minfo, u16 xfer_id)
> +{
> +	unsigned long flags;
> +	struct scmi_xfer *xfer;
> +
> +	spin_lock_irqsave(&minfo->xfer_lock, flags);
> +	xfer = scmi_xfer_lookup_unlocked(minfo, xfer_id);
> +	if (!IS_ERR(xfer))
> +		refcount_inc(&xfer->users);
> +	spin_unlock_irqrestore(&minfo->xfer_lock, flags);
> +
> +	return xfer;
> +}
> +
> +/**
> + * scmi_transfer_acquire  -  Lookup for an existing xfer or freshly allocate a
> + * new one depending on the type of the message
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @msg_hdr: A pointer to the message header to lookup.
> + * @xfer: A reference to the pre-existent or freshly allocated xfer
> + *	  associated with the provided *msg_hdr.
> + *
> + * This function can be used by transports supporting delegated xfers to obtain
> + * a valid @xfer associated with the provided @msg_hdr param.
> + *
> + * The nature of the resulting @xfer depends on the type of message specified in
> + * @msg_hdr:
> + *  - for responses and delayed responses a pre-existent/pre-allocated in-flight
> + *    xfer descriptor will be returned (properly refcounted)
> + *  - for notifications a brand new xfer will be allocated; in this case the
> + *    provided message header sequence number will also be mangled to match
> + *    the token in the freshly allocated xfer: this is needed to establish a
> + *    link between the picked xfer and the msg_hdr that will be subsequently
> + *    passed back via usual scmi_rx_callback().
> + *
> + * Return: 0 if a valid xfer is returned in @xfer, error otherwise.
> + */
> +int scmi_transfer_acquire(struct scmi_chan_info *cinfo, u32 *msg_hdr,
> +			  struct scmi_xfer **xfer)
> +{
> +	u8 msg_type;
> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> +
> +	if (!xfer || !msg_hdr || !info->desc->support_xfers_delegation)
> +		return -EINVAL;
> +
> +	msg_type = MSG_XTRACT_TYPE(*msg_hdr);
> +	switch (msg_type) {
> +	case MSG_TYPE_COMMAND:
> +	case MSG_TYPE_DELAYED_RESP:
> +		/* Grab an existing xfer for xfer_id */
> +		*xfer = scmi_xfer_acquire(&info->tx_minfo,
> +					  MSG_XTRACT_TOKEN(*msg_hdr));
> +		break;
> +	case MSG_TYPE_NOTIFICATION:
> +		/* Get a brand new RX xfer */
> +		*xfer = scmi_xfer_get(cinfo->handle, &info->rx_minfo);
> +		if (!IS_ERR(*xfer)) {
> +			/* Save original msg_hdr and fix sequence number */
> +			(*xfer)->hdr.saved_hdr = *msg_hdr;

The saved header isn't used anywhere.

> +			*msg_hdr &= ~MSG_TOKEN_ID_MASK;
> +			*msg_hdr |= FIELD_PREP(MSG_TOKEN_ID_MASK,
> +					       (*xfer)->hdr.seq);

This will invalidate the token set by the platform in 
scmi_dump_header_dbg(). Maybe it would have been more elegant to 
introduce a dedicated hash table key field?

> +		}
> +		break;
> +	default:
> +		*xfer = ERR_PTR(-EINVAL);
> +		break;
> +	}
> +
> +	if (IS_ERR(*xfer)) {
> +		dev_err(cinfo->dev,
> +			"Failed to acquire a valid xfer for hdr:0x%X\n",
> +			*msg_hdr);
> +		return PTR_ERR(*xfer);
> +	}
> +
> +	/* Fix xfer->hdr.type with actual msg_hdr carried type */
> +	unpack_scmi_header(*msg_hdr, &((*xfer)->hdr));
> +
> +	return 0;
> +}
> +
> +/**
> + * scmi_transfer_release  - Release an previously acquired xfer
> + *
> + * @cinfo: A reference to the channel descriptor.
> + * @xfer: A reference to the xfer to release.
> + */
> +void scmi_transfer_release(struct scmi_chan_info *cinfo, struct scmi_xfer *xfer)
> +{
> +	struct scmi_info *info = handle_to_scmi_info(cinfo->handle);
> +	struct scmi_xfers_info *minfo;
> +
> +	if (!xfer || !info->desc->support_xfers_delegation)
> +		return;
> +
> +	if (xfer->hdr.type == MSG_TYPE_NOTIFICATION)
> +		minfo = &info->rx_minfo;
> +	else
> +		minfo = &info->tx_minfo;
> +
> +	__scmi_xfer_put(minfo, xfer);
> +}
> +
>  static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  {
>  	struct scmi_xfer *xfer;
> @@ -441,7 +559,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  	ktime_t ts;
>  
>  	ts = ktime_get_boottime();
> -	xfer = scmi_xfer_get(cinfo->handle, minfo);
> +
> +	if (!info->desc->support_xfers_delegation)
> +		xfer = scmi_xfer_get(cinfo->handle, minfo);
> +	else
> +		xfer = scmi_xfer_acquire(minfo, MSG_XTRACT_TOKEN(msg_hdr));
>  	if (IS_ERR(xfer)) {
>  		dev_err(dev, "failed to get free message slot (%ld)\n",
>  			PTR_ERR(xfer));
> @@ -449,8 +571,11 @@ static void scmi_handle_notification(struct scmi_chan_info *cinfo, u32 msg_hdr)
>  		return;
>  	}
>  
> -	unpack_scmi_header(msg_hdr, &xfer->hdr);
>  	scmi_dump_header_dbg(dev, &xfer->hdr);
> +
> +	if (!info->desc->support_xfers_delegation)
> +		unpack_scmi_header(msg_hdr, &xfer->hdr);
> +

Why dump the header before unpacking?

>  	info->desc->ops->fetch_notification(cinfo, info->desc->max_msg_size,
>  					    xfer);
>  	scmi_notify(cinfo->handle, xfer->hdr.protocol_id,
> @@ -496,7 +621,8 @@ static void scmi_handle_response(struct scmi_chan_info *cinfo,
>  			xfer_id);
>  		info->desc->ops->clear_channel(cinfo);
>  		/* It was unexpected, so nobody will clear the xfer if not us */
> -		__scmi_xfer_put(minfo, xfer);
> +		if (!info->desc->support_xfers_delegation) //XXX ??? Really
> +			__scmi_xfer_put(minfo, xfer);
>  		return;
>  	}
>  
> 



