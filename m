Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EEE13D1369
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 18:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbhGUPbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 11:31:06 -0400
Received: from mail-eopbgr00085.outbound.protection.outlook.com ([40.107.0.85]:19893
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231371AbhGUPbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 11:31:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G5NpNtrCp5iDsYonqbElIeWU4Pryopxa1QKJwg9JB5THcdH6i1DiRMXG+NMrA6uPLJPeHs5ak8F9Qz9hyZW+fpA0uTVLI2JTDEX10x2yxOSuZLooWk8FdBGK5zGbGPG2p+XD41RZOJ2gfXFlCiU7WM8lAoHhKVTYF874+ka7EdCf1wd0TOwkmO8/KWGAoGu1cvSVPd+EWqEShsaJUsD1ZTI+Q8gJ/+f5KzVCPIJQe/9xuKUZcfZWKzkkMrH902Y80dp61G3L0ZcqvEe34U9xFK0gPaDDlLipsF07zYc6OHYTxelAygfFNvRcFst4CoKgL+3cGfaJ2Q1ZEw624fGiKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/uJDbgkvdTilhZ20VFaZ+elIlAabdW4bBGcSQ3SCaw=;
 b=exJSAYB+nFliLBlhtBbxE5x4AKMCt/oEUDOGfH9IKGs2tN1+lBoF+/jTa5hiOBxLhxeXatm2/GvOoUZ+g9aWqaPvGqHMUsRhEb0ZC4mUncF7dExODL2slLVlces8Cyc4NugwDHUEuElp8LFytnxywnV2hrXEuFWOMnSOtbKxz0n2W3/izJS6HcBTKd7pu++xsVPN+T4FyusG7yw6I31V5S/ILwRrBxONkzDFyLgE0gJUhC5k7TBCb0IfjQB+y1bdqbyuwm1zK1+0ZHpVgc6PVfomWd+E/zJVLC2TnhWAnYJ0ji0qjha5c5nVtGL/nlv/XyO2gPXIaQg0POSkeWfRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P/uJDbgkvdTilhZ20VFaZ+elIlAabdW4bBGcSQ3SCaw=;
 b=QZcyp7OpCoBjSyDz5E2YRLni0nc9bD26Gz0h18Ine/L3bNad5lwUNZb8/O/RkZ9Mw3IS7flwVTtbxzDOQHJqrgQEaVPC4RFD/vWJCOZhzmOEvstES4YOpG8dTMCUez9le3OSw8Nn0chhL7tfifQAfWsKhiC4FxwK7FLqAtaQmlw=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com (2603:10a6:803:d::26)
 by VI1PR04MB4157.eurprd04.prod.outlook.com (2603:10a6:803:46::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23; Wed, 21 Jul
 2021 16:11:39 +0000
Received: from VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::c401:1dd0:8b6d:27a5]) by VI1PR0402MB3503.eurprd04.prod.outlook.com
 ([fe80::c401:1dd0:8b6d:27a5%5]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 16:11:39 +0000
Subject: Re: [PATCH 1/8] bus: fsl-mc: fix arg in call to dprc_scan_objects()
To:     laurentiu.tudor@nxp.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Cc:     ioana.ciornei@nxp.com, jon@solid-run.com, leoyang.li@nxp.com
References: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
From:   Diana Madalina Craciun <diana.craciun@nxp.com>
Message-ID: <ec1ff647-0e0a-450b-056f-d727d88ea731@nxp.com>
Date:   Wed, 21 Jul 2021 19:11:26 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
In-Reply-To: <20210715140718.8513-1-laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: HE1PR02CA0116.eurprd02.prod.outlook.com
 (2603:10a6:7:29::45) To VI1PR0402MB3503.eurprd04.prod.outlook.com
 (2603:10a6:803:d::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.211] (86.126.4.153) by HE1PR02CA0116.eurprd02.prod.outlook.com (2603:10a6:7:29::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 21 Jul 2021 16:11:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8021fe0d-f032-4d51-0ec9-08d94c6238cf
X-MS-TrafficTypeDiagnostic: VI1PR04MB4157:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB41570BEFDDD6AA2A45E26F57FFE39@VI1PR04MB4157.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CH2DFUVEPBrPB7gcdsPByA77QTpzH5KsU3mzhLZW7VPON8SLj/t3oiZMGDhJ2BzwaESR8qvSn7n1ACtGQyn2X0U/oCze8Hl38MjeVKwbBilTSe1bwZj3x7+tkRJ6BXeMCSgunwG7vp0cOnw5pdgut2QvuEB/qfFmMj0kYXA86NrTuLZD3/7z/tZprBz6hjzjXxwkh5BZVrJBiUw5Jt2pNiPWncl6fRs0SAELacPwXyzzGoLT+t+w9xD/hg1XZ4yCKHQydQhI7ua56CS8Hxz530U4++iNt+rJEE/wxxwwuvmiJIKCMOAxZqxIUhRwJACiKzdnet1zz14AtPuEc7GidNTtkEF4Wubyy0JcS9f1rLaKvfSajyscx9KX3D/ff2ZIERT5ch77PiRn8G41klk6Is67EjpFWmTRlfqDZmlGo8wsMT1y1Mkn6aXwkOBRYDFvi00Z71Z5FP9z9ZeJB3LhC/ji4SGFdC4BQd6VE0LJSYWVv2RZQGtog+4x9PNaB0X4MC4nJeySjOjx58gepCKT31vPmfzIL6uAwO932Llbuzzq5FFjTOtCaC29XMe8epTchxy+FdfCnde0sGmvSs8Q1SpVgIVgYuZaZYHgKQkuFgjERyMY8trH3SQz7PNuYIr0W3zAkziQzp+EkSkPlXYiHHWHCqW45mYd1RLYX/DUuNVesR5LZC6GJqOSKYflwkoRgYN1I0+gRMWccGgCrLtBg3k2ewCmmqWJ0HJ2zhevtVFJ3xWJrE8r55XChgb+j/u0GZbSK/uAT9vwn1+GC3cU1A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3503.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(39850400004)(366004)(346002)(396003)(136003)(31696002)(478600001)(5660300002)(52116002)(956004)(316002)(186003)(16576012)(6486002)(2616005)(8676002)(83380400001)(86362001)(38100700002)(66946007)(26005)(66476007)(6666004)(38350700002)(66556008)(2906002)(31686004)(8936002)(36756003)(4326008)(53546011)(4744005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RmOHpndWdkVy9PMjZVNGI4RXVuelNXK0RnVUp5Z0YxWHFJY3pRNXdObVNW?=
 =?utf-8?B?NHpYbTdheForaXk4ZU80Yms1WHAwTGMySVUwWWp4R1RrVG51YjdsUU1VTGdB?=
 =?utf-8?B?Z0V2NGphQXBmRnlNRHg1N09vUUpUVHBVbUJscGRnd2lDVkFrV0pVOVhiZ2dt?=
 =?utf-8?B?SlBTZmQ3NzNLYUdxeHBWTU0rdDRmd0tJN1cwdng0Mi96UXZzSTBmWmpqSDZB?=
 =?utf-8?B?Y1piOFE2bjJ3aFFVNi83bjFzRmU2Rmw2VVFwVzV0MmNjdmszYndxZ1RUZFY4?=
 =?utf-8?B?Tkh0bTRHYkU3c2EweVR0WWFzemxzb0c2VDBqaGxwQTFROTVmZjVybDVnSk1S?=
 =?utf-8?B?VGJEL0xHbXF2d1hMVmc4Q1VBY0d5S3o4a0pRM05WdGRPZThCN09MZlBCMGgy?=
 =?utf-8?B?cUh5ek8rMnFPdlFDVys0Ry9mZC9WVy9UQ0RtdEZheWdvdUZINHlzdkdsWXAx?=
 =?utf-8?B?YkNQdW5MZVQwZUdmc1RHQk03MEhzMkVWQlhOdFpwRTlUVlUvTW9uZDZ3V2R3?=
 =?utf-8?B?Z2JreE5lWWlBdU0yMTl3QTFkMzlmYW5ERVZKUGVMUDJwQWdURkt2VGRHYkpE?=
 =?utf-8?B?S2tTQnZJL2MyenFhb1BCbjB2M3dJbVdhU2cxR2cwUnlEek5wM2kyNUdVZGNT?=
 =?utf-8?B?OXJoOFk0eVk4emFWNmxIRVRXU3hpcm12ODdBdGhhamFtWXVWQm40Tm9Zcjd6?=
 =?utf-8?B?VEtmVUdwZ0hHdGlEYUdkR3NHSks2bUVUT1pFbFQzdDA2d0hyM0E3d0FadDJO?=
 =?utf-8?B?QUQ3K1I2S1JJWXZ6dlVjMkgxcGJNUXBvd1YyN3UvaWtQVVJsb3c4SDVidmNi?=
 =?utf-8?B?aW15UHZHRWdwaVlJMC9lcFJxaDVWckNjLzZkdWhsRXprTWhnSnk3TVBPZVBN?=
 =?utf-8?B?d3VNUW5xa1NZUHlscUttR3h0YVFFOXhnYXdDWVlFZ0pzUmxvUkpiY0pvWVRz?=
 =?utf-8?B?MzVnR1lrY0plc0VZWnkxdnNyQ2xHSndWcTZ0bGlwRzdWV1dxd0sxWGdsN0tj?=
 =?utf-8?B?ajBqSmo5VjVqVUE2SGV5TC9DWk1ZaExCejY4VmpHQWw3cHJCdGx2TDdJdmk5?=
 =?utf-8?B?K2ZWdXJjQjMrQjgraDdCempGb0RGVnJkcVpvWVpVczNkSGxtZ3lHRWx4enhX?=
 =?utf-8?B?V3JCcmNMR0VQY29FWUIwQkJKWTBFODJ6RWtLOUM0NjJIdFVaRmYxL3BMZlNU?=
 =?utf-8?B?cGVhWmcyR2FQWnlMS3B4dU80d2ViNklscFJPTHJXTWtpRG91K0pmWm5YRVdj?=
 =?utf-8?B?Y2RUNzV5d3poY1kyNGxleThmVXdSVUVwVkU2SDhZMkxqa2VEREJWc0l0NmhU?=
 =?utf-8?B?cUVLeU1wTEtoQVRHT05GYnQxWWR5c0Z2blM3YWpLOUlEME42OUJwUktIdWta?=
 =?utf-8?B?SDBINERMdGRzbHlrOGU1K1BNbFhrZ1hiNHNsTnF4b2Q0WVVMUzBRVzhsNnBu?=
 =?utf-8?B?QUVNU3JvOUdGd2tNQjJEVnJhYUZXalFRTE83NzhoSy9wSjN5MFpLZmFMYlUx?=
 =?utf-8?B?SGExb29iNXFHdDJhTkxiRzd2bXdldWdIcWU0a28rUTdlbFRkY3EyM0ZycURT?=
 =?utf-8?B?ZUFCK1VNTHVpR2g5cjRVc1RJaEdIeXNkSlNUTzR4Zy9kWS9jaEI5UjB0YWZI?=
 =?utf-8?B?blhwRDhLdjZ5c3k4MFkzYUZuODdtQ05qYS9JYVNxSUx6SzY1WHplTm1SSWhY?=
 =?utf-8?B?NFU1T0V4NCttWWNZSzBBU0tjNzU3YWMwangxK3NQa1AyN2g5cU1ENVdKaVhv?=
 =?utf-8?Q?4lP/UFme91AF/wR6WAKxiWO6sITY2Pq5smBtJEv?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8021fe0d-f032-4d51-0ec9-08d94c6238cf
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3503.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 16:11:39.8102
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bycwCIjThMfof2UtW/CKumh5w9lqbh8XPvTzGtlTW2eiAXm85nKv3gBHcLcmU5h2wYwQh0/4E+xJ0eVeXvm3XA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4157
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Diana Craciun <diana.craciun@oss.nxp.com>

for all patches in the series

On 7/15/2021 5:07 PM, laurentiu.tudor@nxp.com wrote:
> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
>
> Second parameter of dprc_scan_objects() is a bool not a pointer
> so change from NULL to false.
>
> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> ---
>   drivers/bus/fsl-mc/fsl-mc-bus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> index 09c8ab5e0959..ffec838450f3 100644
> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> @@ -220,7 +220,7 @@ static int scan_fsl_mc_bus(struct device *dev, void *data)
>   	root_mc_dev = to_fsl_mc_device(dev);
>   	root_mc_bus = to_fsl_mc_bus(root_mc_dev);
>   	mutex_lock(&root_mc_bus->scan_mutex);
> -	dprc_scan_objects(root_mc_dev, NULL);
> +	dprc_scan_objects(root_mc_dev, false);
>   	mutex_unlock(&root_mc_bus->scan_mutex);
>   
>   exit:

