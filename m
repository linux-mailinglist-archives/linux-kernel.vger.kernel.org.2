Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009503CA282
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbhGOQjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 12:39:08 -0400
Received: from mail-eopbgr60124.outbound.protection.outlook.com ([40.107.6.124]:30851
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232603AbhGOQjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 12:39:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfXhtXyMKnaOu4TcJzG/LnBqRBV//Ir9622th2y38PO8Urdliztz8xL9GbC9b7/8R9X8DkHXU+DLmpD/hxezynu/Ey2ELFhXT6tdfTT7FRITOPE05FsrilSSZqfd/ISrclCHHtomd8qDmKHHbeGqopUWk92KcXAj9Bzb4OV0hAPWWKjB2gNsixjCSTyNnG8nF2TlKu9HnDJIFumyNXf9emsUvppcoUfru1tQMxPOFxxokjHlAGJbV8f3Pgw7pkB2L7nelmFWoj0AKEfYyC/Sk1hDFd1D2Rk2P2BZJaPQaF8/2OwUm11XCkdjW3EDswq1RAwtykGGyOA/+BfRj4RGpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLcIYyTTpqLNiHSZdx5BXZFnURSEkzKUBfao8w12iVM=;
 b=V3YOP99QukDQa9S+1Y0N/oh4uWwj45HqQfrduTl12rVCH3trIM8H38X3ReOzPLxTleIH5hF4OaQE18Dv55RQxOP1Sr/5dOi01o1GCShW8ZUgJaUZgiNL8eGzD0iQmmDuGNShSRbIk/NS/eQLCb2SSSTSpMumywlNUiYlXvFjt/CklPL290rUZDevsJ5OVYbQ/9B6pxLJ3NbLw86iMzanMy9DLOsxRIXYn2TG8kuUzVX3qJJoZ/eIMu0Jt5HsklzfHbkb8qm608MsPzMwq+z0jIYYJrItnG9zk5sqlUGkENbUXwuempnxlhPHl4nIxw1gCn4iFNAGERu91fO9YLc1/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=opensynergy.com; dmarc=pass action=none
 header.from=opensynergy.com; dkim=pass header.d=opensynergy.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opensynergy.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLcIYyTTpqLNiHSZdx5BXZFnURSEkzKUBfao8w12iVM=;
 b=l/ezQbtCtmv7ykA05cdmVNIId0uGnxeFKkY0foj/k1W1YKtN+CoxnV7S2s8pynlG1mj6Th5Th0bozS8iO5PVdvtE1PlWS0Nv94TFszfJME9MiCLcSm1fTn+W/PVHfA7DgTu/6MP0EnUHrN7tKN3yKo7IdhDiJmT51WbkwWS6o00=
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
 <20210712141833.6628-11-cristian.marussi@arm.com>
From:   Peter Hilber <peter.hilber@opensynergy.com>
Subject: Re: [PATCH v6 10/17] firmware: arm_scmi: Make polling mode optional
Message-ID: <4ad5a421-d9ab-816f-b721-9f88ffabfb39@opensynergy.com>
Date:   Thu, 15 Jul 2021 18:36:10 +0200
In-Reply-To: <20210712141833.6628-11-cristian.marussi@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS8P250CA0008.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:330::13) To AM9PR04MB8084.eurprd04.prod.outlook.com
 (2603:10a6:20b:3ec::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ba875e99-1474-4f51-adf5-08d947aea7f4
X-MS-TrafficTypeDiagnostic: AM4PR0401MB2402:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0401MB24021D0366AB4414C8A1E40C8C129@AM4PR0401MB2402.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xzb9PVNaQCI7zCfpZ09+LhsHa2K8hgFhP3jLjTCMmbzBugcdqEE8Bd8pNwE7um8VVTp9CayX+YLGuU3kaVOsQko66iF+uw869GT4wRy5YdhNv+8pwhfolTU6Vy+DWlvrnrcfAmcYh/GoU4ZCpgawcJrZW7sQd7QeL8njWLbfze6qNIolQby9/wxjyopkJpGkA7hgfqY0GmvO8HNE0KM74bQUi6SLKHLA0UvFcS0Cm/EC52dDGYoz+JsoY6pxLqUiWYZr+ojiE62Aq3gKqoJcONuPp4MRSVSsBUoSwN0/H4EJZo0E1rW2eI+JeKPJhtbkJQh+kVYEwwdXp37cHv9BgD1A6bHxuS00J0U8VXGPOLbwlJBx3ttMQZbc/xIsnp/LZeI3+LPuuKuRkw7VVYHgiFG5fffW8CiK1Sh5CRQmdDepW0JRL3DMNTi02X19E+x7wrpvf1OQJD35px0HIEXH/fvqi5V8htEGB06vv9wOJ87P+AdbUMrOwzKFu3hWW/KnTsNTUFzXLsd1AfdblHaKsFi2SMIoawkkDdk0Eu6aQ+gkmraEaKcpZv+vhZB3rm5riynmER0pVoIw9AzWqe/wPGb3d/0nUP6QKI5QRKWRcuvhckad06od7DZU/dsuI6Ph31xI6zQMOM6QvardQUgvDQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8084.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39830400003)(366004)(136003)(31686004)(31696002)(8676002)(66476007)(2616005)(36756003)(8936002)(83380400001)(107886003)(86362001)(38100700002)(66556008)(478600001)(316002)(42186006)(4326008)(66946007)(44832011)(53546011)(5660300002)(186003)(7416002)(2906002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OG9oNko2ZEhtQ1ZpTEM0Ymg0WjNoUC9yVm95YkhSeGdEelhNUW5FL3BFa2FP?=
 =?utf-8?B?ZTJGYTVuYndvUU5wSWEvV2x3L3F3Q2FtN3VLLzFBRi9DeElGM1dadE1iM041?=
 =?utf-8?B?SWRyWkFSY0R2TGxmUkVUWVRMdDY1a0NQYXFseTkveEdtVGxnaWpxWkQrR1Bh?=
 =?utf-8?B?RXdSMHhnb3ZMb2dhRVovVDRGV2R3UjN0QlJ5UjdoZ1QyRU03M1RmYytUc1JE?=
 =?utf-8?B?UmdKazNKV1BCbXpOdTQ0dno3Q0FGOE9qdWk1Ukh3T1BrVFJkNDZqWHVuSzc2?=
 =?utf-8?B?R1lRdEYrdE5DM3pkcmpEWTVJZXE4a1Y5WHdqNWcyUEhJTi9LMmVJUC9sc3JN?=
 =?utf-8?B?dlZMajg4ZzZDRmxGa2dWWTF4WWJ4ekxQZEprZ24xbHVwdFhYQUVjWmdqeVVC?=
 =?utf-8?B?SUp3cEdKVFJWRklUc0dIem9kYVpwMnVUVjNvWDVnRXlXYXZldHJCaGtZQmFZ?=
 =?utf-8?B?alI3Zno5RldjZGptVFh2MCt5VUFuS2JrN0ZlRWpNdklKTmhJRE12aWUxbkVn?=
 =?utf-8?B?TGxOV2RxN0JBTlVBdnZ3bVNjWlhFTWplZUJJSmo3WU1xZElCMGJIVGo0aTU3?=
 =?utf-8?B?Q3gxdG8yNU9wN1JVMnFYd21oZVpoNGpSVHNNT1d2ZzRsby9LVmkzOG1vN0lB?=
 =?utf-8?B?aG9aaEY5dCtveTVHMTd6b1lhdG1kQUhYbjdKNzhVOXZldENnd1JrcXgrcG9Q?=
 =?utf-8?B?aWl5WEtESkRlcENWWm50czNCSnhpNWZ2bndKS3E5S2poRnNmSklwQlp5NkJF?=
 =?utf-8?B?M2RRUVkrWVk0ZUEzTGRBYUI3QmVqdGRxWllPM1dUVjd1aTkyTlpFWXdPZnBs?=
 =?utf-8?B?RXNKVEN5U3ZTMnBXRWRKRnljNHRJbDkrWUE1Wi9XLzEyd0pjUldmRWs4WVdz?=
 =?utf-8?B?aWNoMG1RMWw1YWZ5RHlpY2NBOWFLYndKNklXR09pVXJRWndHL2MwV0N4M2Zl?=
 =?utf-8?B?RllmVHVOMkczZWFIM0E3VVJ3bXE5RG4rUFc0eVIzVkJXZzhSUlZwV0wwdXU0?=
 =?utf-8?B?ZEIrajQ1N0QvejFLeitBN20xYVpCa1p3ckV3MENCL0NrNFlXTnJqaHNlcHBn?=
 =?utf-8?B?QTlETTdrK1p0Y2ZLbEh4QlYxdWFsUjlFakZMNWlZajFqZFBBTXBvcUt1Vyt6?=
 =?utf-8?B?WHRTOGMrRlIwL3ViQkw2V0lCNVRWKzg4U2NoRnhQWlpMLzJnMUpmbDRzWk13?=
 =?utf-8?B?WkFmZ1BpODk5UTI1MG95UE54OGxLVTg3MytNTlZVbjQ1dzFmcEN3YVE3eFFF?=
 =?utf-8?B?VHRWRVREMXN4eCtEU1phRk5aS2FPR1FTdzFNQmZ0SXQ5SjhjcmVyQlF6SXYr?=
 =?utf-8?B?UDZIYmRVOWpTc0tYeWVQV2xncWJlSzJFNWtPLzc2UVhjNk91YjBUaUYwM28v?=
 =?utf-8?B?RXRKamNrOWhhVS9haVF2UWIwZTRQWkxjNFBZMWhML1ZCdXJWVkI1Y1VyTWJ0?=
 =?utf-8?B?OElpdC81SDhSbkwvbEkvWlIweDdhN1RrQWNFZmhUWFdLdTAwQlV4dCtOYXNl?=
 =?utf-8?B?WFQwVWZYUFlmZmZKYVRvcVB3QS9LZWt2cklLbkZIMXFCczVpQTI2MkxzaWRJ?=
 =?utf-8?B?MW5xbk9IcGlsU0xIQUhmOGMxUit6eWxKR2dyTVNQVXRwU3k0SHlwQUhLKzVQ?=
 =?utf-8?B?bE1jems5Y1p4a0lhMUNUdEUrR3Z0V2Vkenp5eUp1U3VtdVVOMm1SY3ErOEgz?=
 =?utf-8?B?dmxVNXJ5R2M2UnFCcXVac0craVhzMDdld1ZQckxHUm43SUt1NllJbU5COUJR?=
 =?utf-8?B?RFJjUHl1ZkszN08yS1JhZE1zcHh2ZXVQMWlwSzdrN3pqVlZmZkt2cXBNTGR2?=
 =?utf-8?B?Wk5Jd0xPbWxnMzY5TTAxbjhrMU4rdktiS1pOeStkTm55Rm9xQ1pZc1N1VlVs?=
 =?utf-8?Q?PdIEjfN3ENaAQ?=
X-OriginatorOrg: opensynergy.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba875e99-1474-4f51-adf5-08d947aea7f4
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8084.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2021 16:36:11.8602
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 800fae25-9b1b-4edc-993d-c939c4e84a64
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CJzt7/82PV9rfNO/a9bBBcfUMM4IAvKswSDTLeFoLOPKv2cuQoaJjznkzYIJ/nu2ABvw96Cck7vJlt+IcA4yHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0401MB2402
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12.07.21 16:18, Cristian Marussi wrote:
> Add a check for the presence of .poll_done transport operation so that
> transports that do not need to support polling mode have no need to provide
> a dummy .poll_done callback either and polling mode can be disabled in the
> SCMI core for that tranport.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>   drivers/firmware/arm_scmi/driver.c | 43 ++++++++++++++++++------------
>   1 file changed, 26 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index a952b6527b8a..4183d25c9289 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -777,25 +777,34 @@ static int do_xfer(const struct scmi_protocol_handle *ph,
>   	}
>   
>   	if (xfer->hdr.poll_completion) {
> -		ktime_t stop = ktime_add_ns(ktime_get(), SCMI_MAX_POLL_TO_NS);
> -
> -		spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer, stop));
> -
> -		if (ktime_before(ktime_get(), stop)) {
> -			unsigned long flags;
> -
> -			/*
> -			 * Do not fetch_response if an out-of-order delayed
> -			 * response is being processed.
> -			 */
> -			spin_lock_irqsave(&xfer->lock, flags);
> -			if (xfer->state == SCMI_XFER_SENT_OK) {
> -				info->desc->ops->fetch_response(cinfo, xfer);
> -				xfer->state = SCMI_XFER_RESP_OK;
> +		if (info->desc->ops->poll_done) {
> +			ktime_t stop = ktime_add_ns(ktime_get(),
> +						    SCMI_MAX_POLL_TO_NS);
> +
> +			spin_until_cond(scmi_xfer_done_no_timeout(cinfo, xfer,
> +								  stop));
> +
> +			if (ktime_before(ktime_get(), stop)) {
> +				unsigned long flags;
> +
> +				/*
> +				 * Do not fetch_response if an out-of-order delayed
> +				 * response is being processed.
> +				 */
> +				spin_lock_irqsave(&xfer->lock, flags);
> +				if (xfer->state == SCMI_XFER_SENT_OK) {
> +					info->desc->ops->fetch_response(cinfo,
> +									xfer);
> +					xfer->state = SCMI_XFER_RESP_OK;
> +				}
> +				spin_unlock_irqrestore(&xfer->lock, flags);
> +			} else {
> +				ret = -ETIMEDOUT;
>   			}
> -			spin_unlock_irqrestore(&xfer->lock, flags);
>   		} else {
> -			ret = -ETIMEDOUT;
> +			dev_warn_once(dev,
> +				      "Polling mode is not supported by transport.\n");
> +			ret = EINVAL;

s/EINVAL/-EINVAL

>   		}
>   	} else {
>   		/* And we wait for the response. */
> 

