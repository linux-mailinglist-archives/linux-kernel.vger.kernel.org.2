Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6963F3CA284
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbhGOQj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:39:29 -0400
Received: from mail-eopbgr70134.outbound.protection.outlook.com ([40.107.7.134]:50245
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231648AbhGOQjY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:39:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SdDnNO9Z47Mikhe3NsWdNYAtc9XLQcxo6Py7CMp+Pu7vZwZv/N16Q1AKQ/crzk4BaJ7+jWTzYzFfSFzV0fyU+FW+o6rpsIe2WsaaMmUl1LwROa8sY6z735h0SX8QnuNZHpEYFdKHCQnn3eDm/ZWubFurJlT+u42xyh5ajiFZ8OQ1uP1OcT4vv6T4Xj0kdXaAhRJza/PD96DQBWzt1XsUCoTpAiNu0Xnth1j9j2xVansvKVlAoTVi5nvYuIKx8olOwNF03JIDu5Wtwj7si1I/m/V+/MchNiJXrF6r5+DBaqbbp/YnwL5IG/dPq5uzfC9iXGrhCCEy7WcmYNLHeM559A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToOdyjL81ZG5vvW6YtcRU1V5GFHJHHGt1cNwbrdrmZw=;
 b=MqWVBdLBrHDqNiiF3f0ryLGVY52MF9njSgkd++56G+/31kFXyyfLQRGYgqy9HDprorgp0bEIWMzILxHP1UhQhT9l9Tp2a529fHvo0B2hRVa7aFNaWAqDlS9wcCw8k9Pg7bidquM7/xJAQOKYEZYDBMlQAO5Engo0q5eYPwnitHJjwsR/KCKDTMB0zLfy2RkCrzDYSTJifJ9/5NBOv4CQDw6HWGyjAFBL0eErl/ZHouAwaRWKUzZbkPvmMpMkCd4Z+DnSNheJMXJLyYbiXxDswHFaUCu4nZkRm6S/m38l1PfFfIJtuROxixXp3J43/1Ruf66L/QwKIMZfkgFiHO8quw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToOdyjL81ZG5vvW6YtcRU1V5GFHJHHGt1cNwbrdrmZw=;
 b=gYiRE2wzxO0loXvvjLz15QR59zGu0A5CD8EmykXLkJYdekHBLiKSc39V3/OtuXvcx+TlNk8eduqgSfGIC0vcfJFDkDlDx9RqPz9OeFvczWy8ecbXv/sgoDp0VQGk+9TSz6neRvF9DqQnh3wT2ZLmbeJCpwXN0fSP1TA8BS5//6s=
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
 <20210712141833.6628-15-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v6 14/17] firmware: arm_scmi: Add message passing
 abstractions for transports
Message-ID: <853e757b-1048-1528-7f61-63a482e06458@opensynergy.com>
Date:   Thu, 15 Jul 2021 18:36:26 +0200
In-Reply-To: <20210712141833.6628-15-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P250CA0029.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::34) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e5dc367b-87e2-40d7-a02e-08d947aeb149
X-MS-TrafficTypeDiagnostic: AM0PR04MB5731:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB5731FC785ABCCF64B29A68298C129@AM0PR04MB5731.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XuG6NqGEidcu8P7s1HBbIZ4fO5W8bhe9clMcpxwvYckaPWJ0JQs/+LgP6P+soE2ZUwF8y+foaWQ8ATPFuDFEJXP9DUbLhhtj6X+G3YmO4zRLpMEV12mAYS4eZEKL+fnKvdfRsUCFf6mVHjFsKsokG4vk67ZfcPqXYKf8OYCWHBZOHEygGjSxISOxusjLog6Q4Z2iON8BdujDXPJ53XlCDYHlYA+69TaJV2eWwCv0XpRDwHt7hc0R9mXOI6yNtCnjvo6EVHQX5IPv2WK6w2EC0uHxwApu64IH4gIgZtafQ+fOgBJYgkpMsutIZRkTyHdzSdJUeq9POBzTT3ncp4jK2Sknp0lxWHzhMYkAEpc+Rp+AmpVqkTtSUlXZDyLSvN/qXVe9i5j89vzyQlfA59EcSmVykNqNQMg5xyAI1YE01sXk04Ylxg/leZfHYpnl2ZxcpBVDkmbRvdHVv5f5mwZcTZQSaDGDV/QL8c+y79Z1rE23mihc95gt0vusGMixBk29gQW6yryNUC3y+XlNp2b+NWg7ne/lGX6ZiN67uZpINvyORQ6TiGE3jY5T18WQWe5y1c2t47IWeY1OpZ+kZD2stA6vDcLFtr5knE1SQEMDdVCeOxt2A7YPvguy39DRtn5Ch3EaAeP/Z80iNVjGQ9S4GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(346002)(39830400003)(376002)(136003)(44832011)(186003)(2616005)(8676002)(8936002)(2906002)(15650500001)(7416002)(83380400001)(66946007)(31696002)(107886003)(53546011)(4326008)(38100700002)(86362001)(478600001)(66476007)(42186006)(66556008)(31686004)(5660300002)(36756003)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk9hMnV3OE1McTBKUk9DVkxLNlFLdWlRK1J1L2FHUVZYRTZBWm1ESlZhd2N0?=
 =?utf-8?B?ZkhoV1dZVmhnejlvUjZLenl2VmRPT21ZalFjMzZCV1U3cmUwSHJCemY3K3l2?=
 =?utf-8?B?UURBQURZcEY1QkR0UVVpRmxzY0Yrbm11MjRGMkRFS2o3MkF3aDVSQzdPTlVK?=
 =?utf-8?B?SjlTcTYrRE85dmZKNk5LQWZKOEliUUtLK05nVzNXbjlzRmFXWll3RDJSWVM5?=
 =?utf-8?B?OUh6dVowUTVRVm9XQVFnb1pFVWovR2lCZHd0T0U0QUdJVTNJSEN2a2dPaCts?=
 =?utf-8?B?SllqNmk0UUt0aTBBZHdFRjBjaERmejBra0FpM280V012RHNPUWdxNENtdWg5?=
 =?utf-8?B?YWd3RGlxKy9yUnZ0dlZXUjVjNlNRbFdJMmFTODdsY25VcTdIRGhqdmVHTjNz?=
 =?utf-8?B?ajNOWDcvVk1ieVdDeUlPODZiYVdvQlBGbjdGazQxdERWTUFjLzZtTWtEM0Rr?=
 =?utf-8?B?NDlWTUUxanBXMWY5eEZoRG9TbTdqQ3JlcGJMSXJtZWpZN2ZzRUVYTFRJeTVB?=
 =?utf-8?B?aDZhc1M4dGQ1bTY5KzJXRFowSS9zZ2t6SzEyNTlvdC9zV25pMmdhQVdTdTRO?=
 =?utf-8?B?UVk5WXdjWTBGeDdjQlQ1bmRTaHJpQm11QmkybTlzWnNHYWIxL0pHZUtTTFR1?=
 =?utf-8?B?c0FXdTY3VVNhS2JyUXlNVHhBNTQ1ZlR4ZisvSWoyVDI2TElEWHdtVlVvWkQz?=
 =?utf-8?B?eVJlY2I4bHRJaGx6czBLNm9VaUxRWHcvU2RPQ3FXaDMreE5EQ0l4ODRmOTlL?=
 =?utf-8?B?RXJ5K1B2bkpWSGpsc05qQzd3L094WHFRM1JVYklBNk56UUpGWDBvdHgvYlQw?=
 =?utf-8?B?emIrNURvUUtXV3UwaURsVnBhUit5MmdINWhnQXlLdEdORlZxNm5pMXFPY3cv?=
 =?utf-8?B?NHpIOFBEV0cwbWJYbGxlTUVJaDhKOFRIL0Q0NXNEM0VOZXoyQ2F3WE8rdjlB?=
 =?utf-8?B?Vy9tamVXcTYwQkJCSmt2a3N0U1dEYTAwSXNmclFyVnhEUlZ6V0lxeWNpUmdp?=
 =?utf-8?B?eXJWWVNvM3BiRDNTUGRxdFI2Zmt1REJkQlRJQjVjVmxLYWdsMUVpbXVOU0N6?=
 =?utf-8?B?M2ZLVTcrSlFzUUp6VXh1R2h6Y0Q2NUZCVXdycWRvb0JUczNXMG9ub3V3LzJK?=
 =?utf-8?B?bVJ6TEExRnZ6U1JoNzBKYnVMS215WnhieEtoWDBDY0pnRXN1MjM4b2o1QmZY?=
 =?utf-8?B?SjFYUlJTS1pHVjdtL05IRWQ3dkpFNVBNa3B3WThBUllNeVBJRmNFVWIvRzVu?=
 =?utf-8?B?UXVIdVJicmRzM0FEanZBbUNQZEVhV0NUZk1xRHA4dU93cDZNM1NkazJuRTBJ?=
 =?utf-8?B?T2hmU0RSZ1ZGQjg0cGxUeFlwKytqOEpmY2owS0sxVUJSZVR1MkhCZHltZmE3?=
 =?utf-8?B?TUpmMldldUcrNlNrT0VmWHJ4a21CRVV1NkpVSWt1WDFhK3Y4MXdBcktJb0Rv?=
 =?utf-8?B?UnBnRjhheVNSTytOVzB6bkZjMmhkSjlTNkNUVFE4K1VSWkVBUE5XUS9wMnBE?=
 =?utf-8?B?NnBPamMxS09hOXNVcjRieHRZelVxSXF5N0N3ZCt1ZEhEb2ovNmxDTlZjd002?=
 =?utf-8?B?aHZ5UjRUdGNvTGw1WXQvQnB0VGNrM0dkUEJ5NlU3REpTU3JqRDJYOGhZS3lS?=
 =?utf-8?B?V0ZsMzM4cXhwR3Z0K2doRnk2bjYxWGM4UEdvN1UvVnpmbzVvZllLSGVCZXRn?=
 =?utf-8?B?RmRteEhLbmdBSXowQUlSVGpaUURKc0wzM2lIbUNMVFhpU2NhbXFPRlpuN0VP?=
 =?utf-8?B?OEp4ZURRRzhOTis4Q3pXSnk4cXY4eVR4WEJEMW15ZHpDRFpNd0ZubXkzOG9u?=
 =?utf-8?B?V0doM3p2Ky9YRWdJVDdYSTg4SW5kelByczFSV1kwOTRKNTU3MDRlYTVXOHVM?=
 =?utf-8?Q?DRemrdvQHbD5b?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5dc367b-87e2-40d7-a02e-08d947aeb149
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:36:27.5423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O7oi6B6r0019r6PdhVxjhYYIHEPmmYuNGVEFFRAuWjhXk9FbEBgNAPf9VbsIx8Kdsb5Ak8pojJjb84WFTrMChA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5731
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.21 16:18, Cristian Marussi wrote:
> From: Peter Hilber <peter.hilber@opensynergy.com>
> 
> Add abstractions for future transports using message passing, such as
> virtio. Derive the abstractions from the shared memory abstractions.
> 
> Abstract the transport SDU through the opaque struct scmi_msg_payld.
> Also enable the transport to determine all other required information
> about the transport SDU.
> 
> Signed-off-by: Peter Hilber <peter.hilber@opensynergy.com>
> [ Cristian: Adapted to new SCMI Kconfig layout, updated Copyrigths ]
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
> v4 --> v5
> - adapted to new SCMI Kconfig
> - removed raw_payload msg helpers
> v3 --> v4
> - added raw_payload msg helpers
> ---
>   drivers/firmware/arm_scmi/Kconfig  |   6 ++
>   drivers/firmware/arm_scmi/Makefile |   1 +
>   drivers/firmware/arm_scmi/common.h |  15 ++++
>   drivers/firmware/arm_scmi/msg.c    | 113 +++++++++++++++++++++++++++++
>   4 files changed, 135 insertions(+)
>   create mode 100644 drivers/firmware/arm_scmi/msg.c
> 
> diff --git a/drivers/firmware/arm_scmi/Kconfig b/drivers/firmware/arm_scmi/Kconfig
> index ee6517b24080..1fdaa8ad7d3f 100644
> --- a/drivers/firmware/arm_scmi/Kconfig
> +++ b/drivers/firmware/arm_scmi/Kconfig
> @@ -34,6 +34,12 @@ config ARM_SCMI_HAVE_SHMEM
>   	  This declares whether a shared memory based transport for SCMI is
>   	  available.
>   
> +config ARM_SCMI_HAVE_MSG
> +	bool
> +	help
> +	  This declares whether a message passing based transport for SCMI is
> +	  available.
> +
>   config ARM_SCMI_TRANSPORT_MAILBOX
>   	bool "SCMI transport based on Mailbox"
>   	depends on ARM_SCMI_PROTOCOL && MAILBOX
> diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> index e0e6bd3dba9e..aaad9f6589aa 100644
> --- a/drivers/firmware/arm_scmi/Makefile
> +++ b/drivers/firmware/arm_scmi/Makefile
> @@ -4,6 +4,7 @@ scmi-driver-y = driver.o notify.o
>   scmi-transport-$(CONFIG_ARM_SCMI_HAVE_SHMEM) = shmem.o
>   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_MAILBOX) += mailbox.o
>   scmi-transport-$(CONFIG_ARM_SCMI_TRANSPORT_SMC) += smc.o
> +scmi-transport-$(CONFIG_ARM_SCMI_HAVE_MSG) += msg.o
>   scmi-protocols-y = base.o clock.o perf.o power.o reset.o sensors.o system.o voltage.o
>   scmi-module-objs := $(scmi-bus-y) $(scmi-driver-y) $(scmi-protocols-y) \
>   		    $(scmi-transport-y)
> diff --git a/drivers/firmware/arm_scmi/common.h b/drivers/firmware/arm_scmi/common.h
> index 14457f0d5dea..7a1e84dc191b 100644
> --- a/drivers/firmware/arm_scmi/common.h
> +++ b/drivers/firmware/arm_scmi/common.h
> @@ -415,6 +415,21 @@ void shmem_clear_channel(struct scmi_shared_mem __iomem *shmem);
>   bool shmem_poll_done(struct scmi_shared_mem __iomem *shmem,
>   		     struct scmi_xfer *xfer);
>   
> +/* declarations for message passing transports */
> +struct scmi_msg_payld;
> +
> +/* Maximum overhead of message w.r.t. struct scmi_desc.max_msg_size */
> +#define SCMI_MSG_MAX_PROT_OVERHEAD (2 * sizeof(__le32))
> +
> +size_t msg_response_size(struct scmi_xfer *xfer);
> +size_t msg_command_size(struct scmi_xfer *xfer);
> +void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer);
> +u32 msg_read_header(struct scmi_msg_payld *msg);
> +void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
> +			struct scmi_xfer *xfer);
> +void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
> +			    size_t max_len, struct scmi_xfer *xfer);
> +
>   void scmi_notification_instance_data_set(const struct scmi_handle *handle,
>   					 void *priv);
>   void *scmi_notification_instance_data_get(const struct scmi_handle *handle);
> diff --git a/drivers/firmware/arm_scmi/msg.c b/drivers/firmware/arm_scmi/msg.c
> new file mode 100644
> index 000000000000..639969b7dc10
> --- /dev/null
> +++ b/drivers/firmware/arm_scmi/msg.c
> @@ -0,0 +1,113 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * For transports using message passing.
> + *
> + * Derived from shm.c.
> + *
> + * Copyright (C) 2019-2021 ARM Ltd.
> + * Copyright (C) 2020-2021 OpenSynergy GmbH
> + */
> +
> +#include <linux/io.h>
> +#include <linux/processor.h>

The above two includes appear to be unnecessary.

> +#include <linux/types.h>
> +
> +#include "common.h"
> +
> +/*
> + * struct scmi_msg_payld - Transport SDU layout
> + *
> + * The SCMI specification requires all parameters, message headers, return
> + * arguments or any protocol data to be expressed in little endian format only.
> + */
> +struct scmi_msg_payld {
> +	__le32 msg_header;
> +	__le32 msg_payload[];
> +};
> +
> +/**
> + * msg_command_size() - Actual size of transport SDU for command.
> + *
> + * @xfer: message which core has prepared for sending
> + *
> + * Return: transport SDU size.
> + */
> +size_t msg_command_size(struct scmi_xfer *xfer)
> +{
> +	return sizeof(struct scmi_msg_payld) + xfer->tx.len;
> +}
> +
> +/**
> + * msg_response_size() - Maximum size of transport SDU for response.
> + *
> + * @xfer: message which core has prepared for sending
> + *
> + * Return: transport SDU size.
> + */
> +size_t msg_response_size(struct scmi_xfer *xfer)
> +{
> +	return sizeof(struct scmi_msg_payld) + sizeof(__le32) + xfer->rx.len;
> +}
> +
> +/**
> + * msg_tx_prepare() - Set up transport SDU for command.
> + *
> + * @msg: transport SDU for command
> + * @xfer: message which is being sent
> + */
> +void msg_tx_prepare(struct scmi_msg_payld *msg, struct scmi_xfer *xfer)
> +{
> +	msg->msg_header = cpu_to_le32(pack_scmi_header(&xfer->hdr));
> +	if (xfer->tx.buf)
> +		memcpy(msg->msg_payload, xfer->tx.buf, xfer->tx.len);
> +}
> +
> +/**
> + * msg_read_header() - Read SCMI header from transport SDU.
> + *
> + * @msg: transport SDU
> + *
> + * Return: SCMI header
> + */
> +u32 msg_read_header(struct scmi_msg_payld *msg)
> +{
> +	return le32_to_cpu(msg->msg_header);
> +}
> +
> +/**
> + * msg_fetch_response() - Fetch response SCMI payload from transport SDU.
> + *
> + * @msg: transport SDU with response
> + * @len: transport SDU size
> + * @xfer: message being responded to
> + */
> +void msg_fetch_response(struct scmi_msg_payld *msg, size_t len,
> +			struct scmi_xfer *xfer)
> +{
> +	size_t prefix_len = sizeof(*msg) + sizeof(msg->msg_payload[0]);
> +
> +	xfer->hdr.status = le32_to_cpu(msg->msg_payload[0]);
> +	xfer->rx.len = min_t(size_t, xfer->rx.len,
> +			     len >= prefix_len ? len - prefix_len : 0);
> +
> +	/* Take a copy to the rx buffer.. */
> +	memcpy(xfer->rx.buf, &msg->msg_payload[1], xfer->rx.len);
> +}
> +
> +/**
> + * msg_fetch_notification() - Fetch notification payload from transport SDU.
> + *
> + * @msg: transport SDU with notification
> + * @len: transport SDU size
> + * @max_len: maximum SCMI payload size to fetch
> + * @xfer: notification message
> + */
> +void msg_fetch_notification(struct scmi_msg_payld *msg, size_t len,
> +			    size_t max_len, struct scmi_xfer *xfer)
> +{
> +	xfer->rx.len = min_t(size_t, max_len,
> +			     len >= sizeof(*msg) ? len - sizeof(*msg) : 0);
> +
> +	/* Take a copy to the rx buffer.. */
> +	memcpy(xfer->rx.buf, msg->msg_payload, xfer->rx.len);
> +}
> 

