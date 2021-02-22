Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7638321B65
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 16:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhBVP1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 10:27:07 -0500
Received: from mail-vi1eur05on2131.outbound.protection.outlook.com ([40.107.21.131]:39872
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230507AbhBVPQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 10:16:59 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7QH3zMKJlNiMDZyK9X4HjD+HNHT0ZJED/g/HLIla+srZy3GFsENT+Ky2sM6+teNjYjwLDr3lgNT0TqH9e360dHylWOEJX3YAo8OVY4LvkPVfyzeKmDiphwBPmaJ4TLDqHvE00172k3DZt+G1YlI15uNsvU5a95sn/j9bIF8xGCcCXf5wOMeeyfDmBqO4mT2U40FG0eZJ2JkD3aN22jq0TqUnBZbIWPBNsqoUjQmSL9y75sMBGehAMzzZ+ayLmIgvXAc/kN3I5okYRpr5xzUL4C1rpx7pWLwb9OipkDBaNImlEaME8n7OyVVF7YBTYiPRDiBV0/FsS8KRTkwaDtcAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duhahUMxknKyLAfquSl11kPnp2FSmKFW10CvdN9mI+4=;
 b=ieuRq6UjLSczZ8oIjpBgR+f3htkLNtP9rfmTR64QeQf5MnDsWGzgND3655ygC+Q+eF0kWJia4WEE6OK/vMRhHXeMvgmHL2YiEwDV4GdMrEje7Vnk6yLDwn1hwR6S/jKqOps4Exk/GlvnSZAsefa8JzIpbAvrCPKs//Yn+TKVY66fEXv0/Xy+TEn2b8hBX9ct2IPRrpDHD4lpcqz0UArDukRxB1M3O8tHd7ICxdsyu3cl8C8RX07rjSGa/skZW4JEkcZ5pz3LDYiHVXmelWu71r7kjgikroMCB20aLvhkUyTMtwM5WtEmSFyN6ti0D1BF0Dc3IJMMic/VSRmquTcC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=duhahUMxknKyLAfquSl11kPnp2FSmKFW10CvdN9mI+4=;
 b=LONoJiiBdGw8EH9gAbnoEKhvwcFVlzRqzrQp2OiDYhWwPutLVQaFlGLypOjM/1wcVg8ZaOTF80D28mFTaQe9x/cQuvAMoA1Hz1T+EOizwWCPeUl5ldsDMVmpysmPKOWmuDe8MYSYt18IjhmKMnvEJ/JfRsf6MuAgc07gB2yBShI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM8PR10MB4242.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ed::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Mon, 22 Feb
 2021 15:16:08 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a907:416:cdde:9538]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a907:416:cdde:9538%3]) with mapi id 15.20.3868.031; Mon, 22 Feb 2021
 15:16:08 +0000
Subject: Re: [PATCH] regulator: pca9450: Fix return value when failing to get
 sd-vsel GPIO
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Robin Gong <yibin.gong@nxp.com>,
        Axel Lin <axel.lin@ingics.com>, linux-kernel@vger.kernel.org
References: <20210222150809.208942-1-frieder.schrempf@kontron.de>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <e0c35d5c-1deb-e5db-df85-c508c6b2f228@kontron.de>
Date:   Mon, 22 Feb 2021 16:16:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210222150809.208942-1-frieder.schrempf@kontron.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [88.130.66.75]
X-ClientProxiedBy: AM0PR04CA0090.eurprd04.prod.outlook.com
 (2603:10a6:208:be::31) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (88.130.66.75) by AM0PR04CA0090.eurprd04.prod.outlook.com (2603:10a6:208:be::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 15:16:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dabf5e9d-ce4d-4eed-e589-08d8d744c7d5
X-MS-TrafficTypeDiagnostic: AM8PR10MB4242:
X-Microsoft-Antispam-PRVS: <AM8PR10MB4242643AEF2D55AB5AD23F92E9819@AM8PR10MB4242.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F03w3ABz5KDDsFcu3YlTzksAcilQLO5pykU0IdCHRn2UoIKsk9Q16XH57YMrH7SbgjGJJxlvDcLzGIPR9MC9t6Wvj9Ab25pQBhNebDoDkLHh8ZeOouqBr/YAA9i62CejG3zG/g41MwvvIaxKZU/OpJtX+ju9GdFfoeBZ6IfQooFAIsDRusg0GVi1eOb34LuKVgoEwwk236txN+f8L71dtd5HBezQ9a3Zq0Lki7Ooed7yDSVOj06F3+XS6S6PSZ/6IY7FkTuyk6ZNBwaFpAXgmYZSLga9cAXw1Kq+PyLlVtnm6mq5hsCe2m3tupoUAsoQPu/BQ57aKlEhBX8fMenLclUmuUh0x0kRXnKwJLP+huAjeAgFSDQPdBauaOeIOnqDbCpMVBqJ1KPRx+n2l6n9cnvOvPF0pDOpunTcVDsjmG8xw6FqJFLgLqK5rAFIN4o7DE/rkhJ6im7v6OmQcOObrDrUwjlDipQaogLhimjiUO4jKzWqK4//LbRnhfLXOZ7u3TMgqpayO38ddtA9n0wRXUZ3qiT0VDktqU1nYWagUr+adN1f7QBZI+vbseMjW3+PnyU7iY95APXG2zoTbSiOv67lIoEd8HU9o1dOKzTEHVE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39850400004)(376002)(136003)(346002)(186003)(36756003)(2906002)(8936002)(66556008)(110136005)(83380400001)(31686004)(16526019)(31696002)(86362001)(16576012)(316002)(54906003)(26005)(8676002)(66946007)(478600001)(4326008)(2616005)(53546011)(956004)(66476007)(5660300002)(52116002)(44832011)(6486002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Q3E4MVNpUTd1KzNwWWhMeXEwOVNGMHZsMGRFUU1TNDBnYlpCTURGMWc4QUVF?=
 =?utf-8?B?anlBQ0xSaTFWWk9oRUVMUUw4bzNIdFFON1BGcWRoZEZGMkovNVV1WFJFRXN4?=
 =?utf-8?B?MGs2WEdoSDZoNUJHbzJESnNBVUtXTk1SUmlsdUhWSTIyc1ZiNzQydGlUb1JU?=
 =?utf-8?B?SG14QTVOSTZGSGxxTXdqUjEzNVRJMGZXcGt5TG1DNXFoalJEeEZ4RjZtSHBR?=
 =?utf-8?B?YXhnYWc5Y3h0WWs1KzNrV0pEeGsvQ0NPQm5WWEVrSVEwemk0Y1NzQks0d2xX?=
 =?utf-8?B?YWxXQitLSHNBbUFlOGFUNDY3cWEwZ3JSeWZuNlJoS2RlTnVrSHNNbFM1R3ZL?=
 =?utf-8?B?eDhVZHg1ekRXSFNTT3NESitOcVAwdkw5ZEdYQUQvcjE2RFNHUWpwU0hoTGdn?=
 =?utf-8?B?bDVUTmQweFpDUDlpZWRUcDJ5VURyQ1NqbDAwdjFxTEUyNEZlQVR0ZU1Mb3F2?=
 =?utf-8?B?SE5PMk5qNlYxanNGUnFmK1hpQ3lmcjhkRHo1REtkSFpaaVRJS0VOby93QkUv?=
 =?utf-8?B?dDhwbDJGZVh6anppOXdodDZ4WXByWk8zSUU0TC84emw5M1g4VjBmOEtBYk1l?=
 =?utf-8?B?MGMrTFk1Sk43M0xLUVl5SXNsb1V0NjdJQithTjN1Sm51SW1aeG9CNFFNM3p3?=
 =?utf-8?B?c1NRcWxqcERLS01oSmUrNUN4T0RySlNsWWFPSFJ6WmlYNWxWeXRTSk16bFZ1?=
 =?utf-8?B?OHhkSG0rZzVBTVU5R3JVY3ZHYXdUcEhMUzZUdVVoTlhJR3RweHVNM2dEa3dY?=
 =?utf-8?B?NmF3clpNY1NVd0hSTFE0RDdjRjNTRVB6aFQrVnRqMjdXL3U3b0xFQmxlVmN1?=
 =?utf-8?B?dlh0OUs2MjNhdjErNzM4bW1YTnRnMHRkaVdiYndqV003ZVJwK3UwbldLY1Vi?=
 =?utf-8?B?K0p4TmszdlRtRmRNa3BoK0wzMkYzS0kwaGh6OFQxNTM0U3MrTFNrdHRQakdu?=
 =?utf-8?B?cFMwc3RNUzBSSlNPUlQ3U2gxYklkaDBOaWdCK0IycExKTllQallnTUZESnp5?=
 =?utf-8?B?WHl1Sm96WnJsR0xURkwzeGExZUdnMS9TV00wbHZ1ay9OYlFxOEY4OHpjN1dM?=
 =?utf-8?B?RG1USHdSU2hjN05wTjd2N0Mvb05za1cyMEwrTzhNc1dHS0licEVpV3VxSmMr?=
 =?utf-8?B?YmY3NmFwNlNkeTFITkZZdkJGbW43cVMyL3Rma0w0TmdQbVlwek5IVUxWNjJG?=
 =?utf-8?B?ZXR0NW14MFRNa0x3T1NwQ0NzaGFGajlFQ0JndEc2VkMwUTBVcllRb0tyNjZa?=
 =?utf-8?B?K3VSTk5VVVpBWVd1WWVRalRPNnhYa3dYcksrdFVJWVVETnBac2VTRnp5MTRQ?=
 =?utf-8?B?c3FHdEJ0K24vNnJ1eHl0dlNEOW84bVZldFVWSlBSSTdQSG9TdVlNQkpBNTRV?=
 =?utf-8?B?V2w2alhiNndTSnVTay80WjRGbHIrTFJWLzdoa1F6WXRTUlBDeHRpM1RBYm53?=
 =?utf-8?B?cmY3endKbVhYOVlvcnM4QmJVUkFKaHlPaTgrZFFtN1JFYnc0Qyt6SVBLWU02?=
 =?utf-8?B?UlVaRHRTdzhUVkowa2tTSUYxTHR0WGJyYmt0UDJGMm90SXExeWFOY3FwUWFU?=
 =?utf-8?B?MjAxa2VnZk1OWkxUa3JObmRxOHBzRzdUVmRSWk03MnpFdnIycHNQMVd5ZGE3?=
 =?utf-8?B?a3Q2R1lPTVI1VjdvcmZkVG1vZ1lGQTJaNk9McGdweElhaTdCS3VUYnlsY1BP?=
 =?utf-8?B?bStSV0ZBSnJTY0VEQ2xiVmwwNHVDeHUzdzRQdHRXNm5vQTJhSjlmRkJNZjBk?=
 =?utf-8?Q?BTbinWlCN1YfV121vu2/7hIFaYm1JgliYaVf5Yt?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: dabf5e9d-ce4d-4eed-e589-08d8d744c7d5
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 15:16:08.4746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDVjxfro1UwnYf7Ttikc/TLbpRwu2FlaIo4PQjWbWELiZL3bhrC1iahcyYRbqK9+DhKdMF3Y8ykD4DkD9/3UlcYc2A1DSJYjvOkKc3T1jjg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR10MB4242
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.02.21 16:08, Schrempf Frieder wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> This fixes the return value of pca9450_i2c_probe() to use the correct
> error code when getting the sd-vsel GPIO fails.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Sorry, I just noticed, that the PR for v5.12 was already sent, but I 
think not yet pulled by Linus. So I probably should have waited for this 
to happen and added a proper Fixes tag. I guess I will just resend after 
the faulty patch found its way into Linus' tree.

> ---
>   drivers/regulator/pca9450-regulator.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/regulator/pca9450-regulator.c b/drivers/regulator/pca9450-regulator.c
> index d38109cc3a01..2f7ee212cb8c 100644
> --- a/drivers/regulator/pca9450-regulator.c
> +++ b/drivers/regulator/pca9450-regulator.c
> @@ -822,7 +822,7 @@ static int pca9450_i2c_probe(struct i2c_client *i2c,
>   
>   	if (IS_ERR(pca9450->sd_vsel_gpio)) {
>   		dev_err(&i2c->dev, "Failed to get SD_VSEL GPIO\n");
> -		return ret;
> +		return PTR_ERR(pca9450->sd_vsel_gpio);
>   	}
>   
>   	dev_info(&i2c->dev, "%s probed.\n",
> 
