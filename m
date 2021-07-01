Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A972F3B8F00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 10:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235535AbhGAIpU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 04:45:20 -0400
Received: from mail-eopbgr80110.outbound.protection.outlook.com ([40.107.8.110]:49811
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235336AbhGAIpS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 04:45:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k1dJM18FVXPrV/AdOtdXxRzmF6pjJv5fjkulzPog0cnWpIwjSp9CGBQta88Hd3UssfKId8IKRBY9xRu1/lWg88wEaVmdKZUOsiuV7vQXJqgHyez+etPw3MFEP4DpAvBnAhQKXfonZGml7vG3MjKWx+HBmt5mwMRbqAI2Vio1ZG8QcGo9KUc2MpkmeFFjXba+DQabDhCvuESICGTnPVdHrBkFEYJLG2xVa3IOUcumiE8U67F2ZOiQIlML7ZONZ5JQs8H9PNiUKm4IRVA6d6mVpdV9DDeZZjfl3Gi7M9KmuMDPuBspVTCCF7H81Ag1SmNzGNBOIlSTEtlgFIEv9m667A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFkEaVDJP3tOyKg6pZTHwWeqOiJpx+1RQQKpLRg2IUY=;
 b=NDPpyEzjBnNlkBL5JZml05Rk8uEFoyBudNMzKQoajFX1TjMfKIIqtb2xQH0gta8X0RT4o0i6kMAQS2n8SyvBTEO1tcpAsnJqf1ySnvp1WyCU6llkiq/EoWHdJGBi+XeG/ra8My7OOggRMLzWnk0FRrQkXbY1AK2oHkZ+DPT2eB9h8Q3S7XAGq555FbB4cMD9UJRK0Dg3BwZFI5EiaQmEv8PvK6bnJICvR88D7ZX7iHWX7vSIOp1Ai3G26HpB3g7jE/dSoH576YNNOX2qIPNajIyGi5JwDrtU58ZIDZiHu0LYG/Cr4vrYYGN+6EANEiIszxZCJte5tfwMFvnMy8j1BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NFkEaVDJP3tOyKg6pZTHwWeqOiJpx+1RQQKpLRg2IUY=;
 b=F5+JJ2PgNZVhOM4lEQNf38rKUzi4QLxE9xjUulyVAnhwgHlbLTYrjMU5LTTEjkAXOC4QFxpByJ4LkCQBZ17yukHeA1ANCtkH6oxFpDgE2uiRx08NHW4588XGvzH2rSmvI57ty/KEwk5xknZebVkyhYBIVJGhlJs53XXmBhpYUfI=
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
 <20210611165937.701-2-cristian.marussi@arm.com>
Subject: Re: [PATCH v4 01/16] firmware: arm_scmi: Fix max pending messages
 boundary check
Message-ID: <cb24778e-60fd-4582-c855-238d71319067@opensynergy.com>
Date:   Thu, 1 Jul 2021 10:42:40 +0200
In-Reply-To: <20210611165937.701-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6PR01CA0061.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:e0::38) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2d6f2880-dabb-4a4a-83b4-08d93c6c3076
X-MS-TrafficTypeDiagnostic: AM0PR04MB5028:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR04MB502848E10CA7B5B3BB81F3328C009@AM0PR04MB5028.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f9/PEQemoLVLrVIOuDC7GN7XA7yuaovanxIkITkCuTNiKMWpA4qpL5aVBqeXZ5jdkB0QJsJA5pOxXkQoMljFHl11UhXwm7y589auqfw9W4E52lIeuFaj289fcCTy04WN2HNNYm/ZKI5TcqxsV+IQhdmfwL8q1h0D9iGNmCH1ksggl0upre9c4L+pNRxxUioWmEV9INSjF5M7Innpe56wBFNDBNgs7EhEnziTV5jOS1NJdm8am1lf7hGThYNaNwmUrjRw/DXElEQQRd41TDi9id8zToFPxYFGq4qOpOZybmZHKSUd+uDrxlWSwfuX8diL+vLqb9uJza16ocLdFDZGWPpdBg05G+DCvYbPbO2bJ/d4bBH3tIaI/fhUsOjhTU6BTfD43Wtfb5hrN309U+1+KjNISqKztXjB82Ku/H9ZWteWdCcG1uMoaomwIG5LbYm9FiPUOwQ0XZ9and2dXSxDr0eD0fN1+Omg1rm9JFb/Qs78UWL4GLe+6GzmBWmnDQwlmpkaFgDIqL6ctKdwGkpAr6dve0RSnUuYVfqBySy2BOtJcveTi7iGmvC1XblPfS2/nzaaJLFfP/zaIgoM/WcQJ1+NzSYOw32ZrBbmhXRSX7PC2Dmst0Wsf+Br517zV0lE7ogVFeFaTibHR5LRg28Ufg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39830400003)(396003)(366004)(346002)(376002)(136003)(36756003)(186003)(83380400001)(53546011)(66946007)(86362001)(31686004)(15650500001)(31696002)(42186006)(478600001)(2906002)(316002)(8936002)(8676002)(7416002)(66556008)(2616005)(66476007)(4326008)(107886003)(38100700002)(5660300002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3JvSjMrYXAwZmJ5alpVWHdBVUg0Q3I1ZUNOV21xbm9wZm9zUGg3TGRJdHUv?=
 =?utf-8?B?TFAwdjhEMzR3QjBnWnY0aXdKTVR5dnlPcE5NKzdtcHBSYjBETW1SbHVycS80?=
 =?utf-8?B?RkFrMlRXanBhaWdRUHRaenBpY0xRYkxlNWY1SVNiZ25xYTMxV0xRSk9EcnlQ?=
 =?utf-8?B?NjNqSnhwOEtGbnRWWTlZOEpqN3lEZENmS1o4dEkwRFhUcWlyNnZzWVBISy8w?=
 =?utf-8?B?WUNuZmd1cURrbFRDc0wzQjhTd2o0Z1hTTFJCUnBLOVJFQnVJOE5XdDJzTHI1?=
 =?utf-8?B?bzN0ZVVUUVVYVnRuTGFOaEdqaEV5Z2crQzYyVDRjWEFOS2JqWkQrS1VwbFFx?=
 =?utf-8?B?VFRaTWN4d1habTdLSDcwcVhZaFQvYURNVHdsMVEyODNmOTZ2S3lneXJDeUox?=
 =?utf-8?B?ZWR0QTJTSFJYSkIwMFdyY2wvb1ZGMlNqdlViWW0vcy92aitjaW1YMlpjcEsy?=
 =?utf-8?B?RGlQS0ZONVJTQTVRdG9ueHJQVloxdi9KZXBFc0pCaUtUZ0NtTVZSM1ozdGZ0?=
 =?utf-8?B?YytiVmFBd0V4WEI1ejlHSFF0S3lEdFl3dk10ZmZxWDdHT0FEVFJLSEorQlNJ?=
 =?utf-8?B?WmdxVkJISzAyaVlBb0JHQWxVaVBkcG9sdUczOExmVCthYWJZM21tVlBldFdW?=
 =?utf-8?B?V0VXd1hyYk9QLzh6RjlON1VCd05MTTd3aS9uZGs3NGxVMXpsdWt5QXpXMHRV?=
 =?utf-8?B?TTJRSFVqOW5MUEc3bkE3aE8rNnJEd3hBSFkyc2dsK290OW9VQldIQndTbktY?=
 =?utf-8?B?allXemJiaHhSenI1TjVBbSt5dGUwbmVLaGZab2YrNUpUV3M2MklvRzZxRVZM?=
 =?utf-8?B?ckZWb0pRNVQzL0tZc2kydHZDakhDMHBtQ3pJUHNBU2FlbDF4WS8xc3lYWHFk?=
 =?utf-8?B?R1dDc09hWk1HdmluWUwyY3pRZ3NWUWlaa3NzaXA0OThFbVZ4VElocHgyY3Zu?=
 =?utf-8?B?cE9RaURiTElWaDRPRlcxZkluQjVIVFFjc1BmQjJLbGtrSzFQcGlBZCtFQTdJ?=
 =?utf-8?B?K1hqZUd6UWowbFROc3BiZU5TRmVTV3JPaERpN3dwcFdnN3AybzJIZVN2d09N?=
 =?utf-8?B?Sk9oaC9lczE2cXFmVUl0anJCUHI5T3c0Mkw2OXVrZGNIRkNVUm5tRzRKRlVz?=
 =?utf-8?B?T3JNWVJxcGl6RkhBR1RGTnlyWEIvM1pmaWhYdGtsYUFNS1AyelN0Ujd3T0lW?=
 =?utf-8?B?enh6U3dxV1VIV0dhakxyS0Q4UzN2MUphUjRLTUwvMTUwOFV0Qm9RWkJrbEZn?=
 =?utf-8?B?RWFqYzJHUng2WDV5c2RCeVJ3V2VIRDB5WGhmSVNMdVoxL3VsNC9hNXQ0NUoy?=
 =?utf-8?B?QnhsNk9jNUlNUWhBZWkyVjNuck54UFV6eVBCUnlSRDNvMTJpSkV0TndZQUJ2?=
 =?utf-8?B?VXphQWZVQmJVZytBWEFOUDUzY3JpTW45endIMG9PRWhWY2xOTkkwbHFuR3Jz?=
 =?utf-8?B?cjRsNk9aeVZWVGk0YXVCTEhVSUs5ajRPNDFoTXJJUVNSd3ZDSDJscUc5NTJw?=
 =?utf-8?B?WXRqY2ZVcmRUL1Y3LzY3RHllSHdxYkFHZzBuRUVUa0JDdUdNWHFQdzVCcTlU?=
 =?utf-8?B?T0FGSkZPYU9SU0NDVnk3eUNXNUxRQ21raVBwVnNERFlnY1ZLV1RVUTFndldJ?=
 =?utf-8?B?M0RaMldnK3BIRXlMT2JaSXFrNTR5TVBnRU9tMm42cXNBVCtiNEdDRFRxZStw?=
 =?utf-8?B?QzFZdGJGcHRiUHo4VnRJSTAySWpUNWZadEpIL3gwdTRFODRxTzZvY3FyaldF?=
 =?utf-8?B?TGVxWmQwQVFiTlZqeHBPekdrMk90cWsyR0JTUmRwK0RkS1RxMGR5SnFzR1RP?=
 =?utf-8?B?MjJ4Mk05elowbXNWdlA0d0trbnRJc3ZrMWdKRVJDOXllc2xCQnE5akE3SnN6?=
 =?utf-8?Q?ahUnetoVNXJ/h?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6f2880-dabb-4a4a-83b4-08d93c6c3076
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2021 08:42:42.1543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgrtIDj8Q01VgOQrd4BGWN816NeFsx+9gt+3zfVf+MO86QbiXwl8dMqf/idLNqm+WWefYreMHnYughoy6/u9Fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5028
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristian,

please find some remarks to the patch series in this email and the 
following.

On 11.06.21 18:59, Cristian Marussi wrote:
> SCMI message headers carry a sequence number and such field is sized to
> allow for MSG_TOKEN_MAX distinct numbers; moreover zero is not really an
> acceptable maximum number of pending in-flight messages.
> 
> Fix accordignly the checks performed on the value exported by transports
> in scmi_desc.max_msg.
> 
> Reported-by: Vincent Guittot <vincent.guittot@linaro.org>
> Fixes: aa4f886f3893 ("firmware: arm_scmi: add basic driver infrastructure for SCMI")
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/driver.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 66e5e694be7d..6713b259f1e6 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -1025,8 +1025,9 @@ static int __scmi_xfer_info_init(struct scmi_info *sinfo,
>  	const struct scmi_desc *desc = sinfo->desc;
>  
>  	/* Pre-allocated messages, no more than what hdr.seq can support */
> -	if (WARN_ON(desc->max_msg >= MSG_TOKEN_MAX)) {
> -		dev_err(dev, "Maximum message of %d exceeds supported %ld\n",
> +	if (WARN_ON(!desc->max_msg || desc->max_msg > MSG_TOKEN_MAX)) {
> +		dev_err(dev,
> +			"Invalid max_msg %d. Maximum messages supported %ld.\n",

%ld -> %lu

>  			desc->max_msg, MSG_TOKEN_MAX);
>  		return -EINVAL;
>  	}
>
