Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E930D374FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 09:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233131AbhEFHQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 03:16:58 -0400
Received: from mail-eopbgr140111.outbound.protection.outlook.com ([40.107.14.111]:39822
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231254AbhEFHQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 03:16:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iUHtgqGvYgy9wZ6CZVuQkWBJmOZuhA2SVlfAwD7Vv7kruhKL4twLyknlNKlnyjDcYa/XaCJFvj2NIzd2O0xFjyB6bnHYjT6EuqWwxDXj3Lpljs6+JRzKQkBCDcLK2BpJtS5D579815Lh1Ye0/iAEyy+IZ86h+CgmhW/AwrFSsrxDIyJXXKdyTdnehkAjr8YkM+bUIjhYf6OZa7YEWFRBaJi5qBXj2m1Gl56WasKyMtypC822A1FbZOvDnoZBsGbIx+xGNQkkX530HqGpphNmkrUrPWwNxoKTSMOSyYslB2biYOrpdPlsfszO/XI7sNuCy0ZU3hFafEV0I2ph3KUr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDxnGxk291zwF2lJW53jxPPb+MNDTr8W8Zb3LqqJSoU=;
 b=No7NTTtFNwwfdWSDkAzyjnIWHDo4MH53ClEuuScRZwSSbyt/LHq0nmRX7l0eMWhU4o2s84LbtI1eBZDq36eWXjNihC5IiqLFoJEC3dXRxdGQ7LgZPQR8LTBVB6xR7VMu4hAQU0HK/BMJIX4lkoYtp32KMvaz7kr+zoZcX0futo4gq6M+JL13fYacCl9neuMRdKlC1ZXGAbd5uc3j46SgobhNMmY2S8EyesCjzFRbSOHP72pnj7ZyL2RBJCcXTT0HaDhdenpExAzN9m706haeRJkJ/qM6zrjorC4k6XV9MdInxdncNe9gRHMQKx55FS1hqhIg9p/jJZcnmykby0tTbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDxnGxk291zwF2lJW53jxPPb+MNDTr8W8Zb3LqqJSoU=;
 b=bkzjVvfIVILWjde3Mnj5KlY8Yco8ZDpWNjxbSAq9d9a7qPNribeI1Iv4x31uumuDmMov1fJPuY4KxSPrfgmbSet+rtYSVem8mENmCvnqLoQ1+RcHT13F8DdBDaG3oScfqYH5igquusqJ6N63s4AIaFJDmUH+xCT2gY/PSYVM34E=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4069.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:1ff::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25; Thu, 6 May
 2021 07:15:57 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4108.026; Thu, 6 May 2021
 07:15:57 +0000
Subject: Re: [PATCH V3 1/4] dt-bindings: power: Add defines for i.MX8MM
 BLK-CTL power domains
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210506041555.10719-1-peng.fan@oss.nxp.com>
 <20210506041555.10719-2-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <13101b86-65d3-671d-2603-8e091fc71824@kontron.de>
Date:   Thu, 6 May 2021 09:15:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210506041555.10719-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.244.180.42]
X-ClientProxiedBy: BE0P281CA0017.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:a::27) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (89.244.180.42) by BE0P281CA0017.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:a::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.9 via Frontend Transport; Thu, 6 May 2021 07:15:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 526f6d34-a7bc-49f1-42e8-08d9105ecb1a
X-MS-TrafficTypeDiagnostic: AM9PR10MB4069:
X-Microsoft-Antispam-PRVS: <AM9PR10MB406977485DA89F88952F508CE9589@AM9PR10MB4069.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LZQBk/hmrf9qEvwwHAbpJK6nFT+5CNr8I2sUDFmoZBW+6kgsOfMm0mYcPMV+/SDr7yseKhwdBdq5EMzOcHImyqgeouZHjPqHKprp6xWnIwWZpRQUo2qC+DqeEwT/pijtYYz8YqgpjFjooKtHsbvvL1rxYeB9jyZwHYkrlF45L49zFRuJZLeI9yh4BwepyKM9Ozo6dW/82X5V6k/VgCsbqRsFAsJ0W2ugDT4NK7VZLGBE8DvxOf+WJcxYXs5gTHplsmNPznUQnXa8i/NlDc7D/B3yvWGE65MgFHUZCl6RNUO8g2gRc4XCDhj7kdrDhtkybioQGwQ+IHJHXfog4Q+2oVhxxtQmR+U6/DQBwJeA3vpYdxXxle0cfBhC3e9tqQFr7J81nFLwOf7VpsT2d7R+ZzWP5ZrLNKaPofnHXLEzIJc4kUwBx5Uk8VcqP0lmyfBf1ccLOHCQJ8AylWsK/gytNpMOBqeUapo2aqXXnJUKo7PWZIY/w6YrzGMvb3ISOquKPcySw2KBOzxxrqD/jHgei2SlpZhPrc1GRhqRQEAbZkkNnRh+h7I1KQRzoNLobVvzXQQ5aMkkj84gWWF7RspQRX4jWRYpP9JwEcGuYOhwwUKbwtL2GBIs+LCcLSmcZKLZAG6YbswfGRH1ZLv6pbSYeNEoVPDYedeHqG73QDULHWxHdEqTSkP0OaMNITsW+upz
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(478600001)(8936002)(5660300002)(53546011)(44832011)(86362001)(2616005)(26005)(7416002)(83380400001)(956004)(4326008)(2906002)(186003)(8676002)(16526019)(38100700002)(36756003)(6486002)(66556008)(66946007)(66476007)(16576012)(316002)(31696002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?dkx5emtTUnZHQnJVeEs0YnZRNXdpWGw0bTQxUWlqS0ZLNjBVbjdpRy9VZ0Mz?=
 =?utf-8?B?ODUwT0gvdklSVGoyNE1YdHBEalNXZWgzaVluNTZpckNZVTRwalRxZFJvY04x?=
 =?utf-8?B?TThSYkw1SVZ6RnNaQkZNWjdocmJpMjJsNHRxMlVlRWp3YUZYVlh5d09hbzBl?=
 =?utf-8?B?UWtnYVFRcUlPTUc4OGpDYWdwTHJVVGQzTVVpdnpWL3hvazZSbmtIUnlvelMr?=
 =?utf-8?B?MmxZM1ZHMXorQnZIZ2RPR3l6bFZhMmRTbjk3bDF2czBwVTRQTUROQnlJVTRC?=
 =?utf-8?B?L3lJRkxTcEJ0MnNFRnphemVDSzcyNTJvTkVzUXF5aGd5Z3h0OStDUWVBRjkr?=
 =?utf-8?B?NTdQV0ttdE9HMzEzNGdscm9OWkxObVFpMkVmdVNKZnM5TmN0MUY1UGNQNEo0?=
 =?utf-8?B?TnpQN2doUGd1M2VuaGhUcThCTGlmcGdwSVNhRHlzWm1hS0NmRmt0Qi9oeVZu?=
 =?utf-8?B?M0tJaDdpbitKNTN0eUZNRjNjd1VaaGdxbWlIcVRhdWI5bVVQRXl6d3RCU2dK?=
 =?utf-8?B?MDlVOFYvQ1Rtd2R0V0RhdkluaGZ4bmFBK1JpVGhrYXB1RFljRTZtNHFnWjk0?=
 =?utf-8?B?UHpzRUlGdjJhMkRETUNtNWRrUXR6KzlXUUpnVlhLYkVxcmplS25wME1jcXdT?=
 =?utf-8?B?Vmp6Y2lIVGRuekkzZFpoTkpIaUIvQTdWL2lyUEVlNFBSQVV1WmpzZzhZeTJH?=
 =?utf-8?B?UUVZY2ljSFFzY3RnaWlveVl6S2p6YzNkRFFFU0JJQUp1dHhMWllWTDlhWm1L?=
 =?utf-8?B?NmJkWE9jSWtxWTc4Nit5ZFVyWUxUVEdIb1hoTzhxVnhxTFNVNUw4VFNydmRQ?=
 =?utf-8?B?bXdSWlgzQ3BTY2dHamJIY3IrSTVhV2owMWVmQllscDBlL29QekFGVzB2N3E4?=
 =?utf-8?B?YUN0aXdKb21OWmRyazF6cjF1eSs0V3ZGL0N4UFBCVklEdDBvNUJzbEZMKzc3?=
 =?utf-8?B?NWYxMTRrQ3NLUkdoYndwblB0VU50OFJuUVVwVFBFUklMV1FtMWtVZzhySThm?=
 =?utf-8?B?MXpiSEJJV1RvdWZaMUE1dXN5MkdpS0lkWENYL1U2aFoyWDhXKzRQVkVKRmRC?=
 =?utf-8?B?OTFCZFZiZEtZc2R4U01paUhVVXorUmQ1YjZuWHVvbTQzdUx0R3QzdXBYMDVE?=
 =?utf-8?B?ZkxISGRNcTByRDJGM1lWSHBjVzhYb2JPMFVYY3M0blZYRVVHNERZN3BKMjM1?=
 =?utf-8?B?NEQrNzMxLzRIZDR1ZHMzL2NQbHNsUGlTNHQ3SGc5R3BJbTZNSWhyY2xrclpr?=
 =?utf-8?B?TWU0MVF2ajNBOFNFbUtLZzRxNEoxcncrUjVkRDllak4wUTZnY205Y20rKyta?=
 =?utf-8?B?bUxpbmdsek5Od3cxNmo1bXgxTUx6RUtCRUJSbmpFdDJyam9oKyt2SDZ6MXBa?=
 =?utf-8?B?blhmTXo3OHdDSVlHMEFHTnovVUxyVlcvWW9SQzA0UFQwZkdDNTZoV3o5QStP?=
 =?utf-8?B?ekxRMWxYU2loNDZseTQyVVE0R3VWd1hnNVdaeHVBdWdKRDBOWlJVVlV6YUwz?=
 =?utf-8?B?VTM0MTJ4bEtmekwxOTZnMUVPa3JtZXM0Zk91UTcwRzZlVUVIc1NPaXU3T2x3?=
 =?utf-8?B?OFJ1NU55UGxFbVVzOW1IQVVsVXJIRmVWWmZZV3lhN0lKaHVIMGxJaGNVWUlt?=
 =?utf-8?B?Y1lVZzdFY2dWeFlYSkdlUlFDa1hhODhTdnNYS3ZBWVBQWHFWWmYxYVVXaHpV?=
 =?utf-8?B?QktpenJuSXV6R3pvWW9hSUtUL2hpTUdrc2hBU3lqaWxhWktjbEVOYWFSVWZZ?=
 =?utf-8?Q?Lo/myuZPpHdgelixAG8tOwN6YD7KbF8KrUsay8p?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: 526f6d34-a7bc-49f1-42e8-08d9105ecb1a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2021 07:15:57.3020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UmmI2vXcBOVEtqBFW7zPO5nElj7n9soe3ccIV7fVMB1fPQqvr5aNOjdpCRO4l+Mu9I2aAXFou2DL2PcmHqQcOGXvXS4jiJgESsFg9XaFfNY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4069
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.05.21 06:15, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Adding the defines for i.MX8MM BLK-CTL power domains.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  include/dt-bindings/power/imx8mm-power.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/include/dt-bindings/power/imx8mm-power.h b/include/dt-bindings/power/imx8mm-power.h
> index fc9c2e16aadc..510e383d1953 100644
> --- a/include/dt-bindings/power/imx8mm-power.h
> +++ b/include/dt-bindings/power/imx8mm-power.h
> @@ -19,4 +19,15 @@
>  #define IMX8MM_POWER_DOMAIN_DISPMIX	10
>  #define IMX8MM_POWER_DOMAIN_MIPI	11
>  
> +#define IMX8MM_BLK_CTL_G2_PD		0
> +#define IMX8MM_BLK_CTL_G1_PD		1
> +#define IMX8MM_BLK_CTL_H1_PD		2
> +#define IMX8MM_BLK_CTL_MAX_PD		3

I think it would be good to have "VPU" somewhere in these defines. Like IMX8MM_BLK_CTL_VPU_*. And here you have the *_PD suffix, but for dispmix below you don't have it. I think you should either remove the suffix here, or add it below, while I would go for the former.

> +
> +#define IMX8MM_BLK_CTL_DISPMIX_CSI_BRIDGE	0
> +#define IMX8MM_BLK_CTL_DISPMIX_LCDIF		1
> +#define IMX8MM_BLK_CTL_DISPMIX_MIPI_DSI		2
> +#define IMX8MM_BLK_CTL_DISPMIX_MIPI_CSI		3
> +#define IMX8MM_BLK_CTL_DISPMIX_MAX_PD		4
> +
>  #endif
> 
