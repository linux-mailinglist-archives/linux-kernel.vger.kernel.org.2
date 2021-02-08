Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C66F313FED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 21:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236605AbhBHUHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 15:07:46 -0500
Received: from mail-am6eur05on2062.outbound.protection.outlook.com ([40.107.22.62]:53249
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235582AbhBHS1c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 13:27:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bPfBE8ahHrvf8DPfSm53fTHuEnCz3j1tzNLzxQIu6sh87SIaMRkdCFgKV9xQlhMBvHlOuLYi4hX/CiwTMYFA6JYTeHhzsqqCLSPXR6uusQv4C35k3mzhapGvtCcxx++pC+4l2ozhLEqNNocjU5jYuMBtfb/i0EvrT7XyViGTqKGTYTOL8R2VbkGKiK7Jy0HicdFa9wum8giSQMMQksCIekX+VePxj5My6sFl0g03ANCbVPd5Xl6twD65Tqp16B4TUEHUg1c4M26jtyH3GJjvq6KVO65ygOopv0T/4CdftfCBYtpvdqj+CqLt+jXimg5ZBH7OyfH+Rt9s7BnJ8LK+kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7jB+hUFzqKfaM9F5szd554xC+0ImjFfStHWmgbnexs=;
 b=jHYQgGxgYlcP3Scf4vzFBByHOWA55Sfg0jphTFfNJAgPXFAEg7+h5PQGjbbRnnTdrvs6of3RuYWcXi2Q4snM9rdL9CLsG11pinHjpNgEZPbZCdenaEHNc6Lc+2Q9gMbHV0W51temkrZR6waDKOgfsgoDlpZ+mA5Kyz1+x4jON1kkUhwg491Ry1WFtDLFuz1SPUpqjYvjmLp3AjTU75w0v1ZGMJz0nwPzOctzftBSdxZrL29lzMVHwugAvXSNcHrdZUwFJ8cr6vRImzRnXuQVHrV4SkVb1qNLSM+S/XG7bnjLg+652DnVaIKz8zl1b+Btr/FvlFCZtMeHRYCApRUc+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7jB+hUFzqKfaM9F5szd554xC+0ImjFfStHWmgbnexs=;
 b=NIJY23njVZexqTl+2BkmtXLA4OdbIuQRaQfuflqt547PmQDNGqFEFPBsl5UZi4PIelayiU8srgtZkJKq4w1obJjv5Du4IRQYfxwmOXSLkxFOE1QG+We5C9Wa11DsYK/eT2oo3bX/ZT4DZxcL7ga8kb9KyonheG1/QPEJrQ09RlE=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com (2603:10a6:803:3::26)
 by VE1PR04MB6350.eurprd04.prod.outlook.com (2603:10a6:803:122::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Mon, 8 Feb
 2021 18:26:42 +0000
Received: from VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::d68:ed11:c239:892b]) by VI1PR0402MB3405.eurprd04.prod.outlook.com
 ([fe80::d68:ed11:c239:892b%7]) with mapi id 15.20.3825.027; Mon, 8 Feb 2021
 18:26:41 +0000
Subject: Re: [PATCH 0/3] bus: fsl-mc: minor updates
To:     Ioana Ciornei <ciorneiioana@gmail.com>, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Ioana Ciornei <ioana.ciornei@nxp.com>
References: <20210208170949.3070898-1-ciorneiioana@gmail.com>
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
Message-ID: <3ac87c90-0d3e-3c6e-f283-86cc54fafa93@nxp.com>
Date:   Mon, 8 Feb 2021 20:26:39 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210208170949.3070898-1-ciorneiioana@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [188.25.96.12]
X-ClientProxiedBy: AM3PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:207:3::13) To VI1PR0402MB3405.eurprd04.prod.outlook.com
 (2603:10a6:803:3::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.102] (188.25.96.12) by AM3PR05CA0135.eurprd05.prod.outlook.com (2603:10a6:207:3::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20 via Frontend Transport; Mon, 8 Feb 2021 18:26:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0185a5d0-6294-45e0-f970-08d8cc5f14c3
X-MS-TrafficTypeDiagnostic: VE1PR04MB6350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VE1PR04MB6350CD270544D70221A5CE40EC8F9@VE1PR04MB6350.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D8bf2drAgltw/Zj1p/olPrNtR8+WD2FoZLeY7sO+TSa3vuy5iPWWIUswJ0NhwUgTkqDfK2kEr6a3RTDTMxPsJGKpdMG/XotBCoE+sR5365yn3kzlETG2yPsGuWRdNRfbITsd4cO3PuZor5AWpip1HRVpCRz2AVvaDJcb5HWlzOXOB+AA2FVFWh4mwQCPWId4KAZ0ngVmjxHEEwg80ZSzKzEzcbcldeBEiaSeaOjHh7Cdxqw7LjhRqlB+kbOv9jAC5hD+YKI9FwdAcBZBPDhZCSDwpX01WILPezAJW3xle57atbQlzgXEIiCO/KrqJ10O7DqUmM5NhZ/XUkVJKaX9IQzC0s8mxYdWyTKYKJ7X1bau1vYPrfBuWpqGaytY8Fc9nyp2tAw6vV/l7cqn+D28pHphSIibvt3J34fvQm5NZCKOuxZtYJA8IpopUp/osSUh6VuRKH6DwxGLQiN2VIxI734pslvFGYtaAL5FNmrQLpPbMAgwFK/7xM2f/liUsXQ0gqp5yaq3Cy4wp3gixdAgYQ1kHEeLqo22Lvwe2Kcd5g7+t8F9SlgLrVBKuvVwCRclIwOO+/mO+FV8lF+3z/YBPbBTON8F9zKeG6Fc/r85a2w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0402MB3405.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(316002)(8676002)(2616005)(956004)(4326008)(31686004)(6486002)(2906002)(16576012)(4744005)(66946007)(66556008)(66476007)(44832011)(5660300002)(8936002)(16526019)(186003)(86362001)(53546011)(478600001)(26005)(36756003)(52116002)(83380400001)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Skx3UU9wcFBjcTBUc1I4c3FLbW1LYVpEQkllK1VlV0NrcENpRE5VaUN6cnhF?=
 =?utf-8?B?TXk0WVZwUkJHUDFzV2QveGttL0J0SEQ4cSttcldSa0ZMNS80aWp3WDF0aDRQ?=
 =?utf-8?B?T0NxTDBSTmNyWmY3T0p6TENMSkQ0SjVGOEx0NUlhRktwR2lYRTYvdDZZM2Zv?=
 =?utf-8?B?WEdPcUkvWC9NUHlwZUExYmFvVXROelFvR0szcERBQVkxVXRyaHNHcDdnT2RC?=
 =?utf-8?B?SmJ2bTc1c3FsSmlUcTJGWGg1WjJmLzhzTzVqaE1Ga0MwOXErbUZubGFzSnZr?=
 =?utf-8?B?bndLc2tPZXFRWm5NWHJISEd1VXQ4NHdqay9jN2pJc2dwZzB1Z3czRVY0blcr?=
 =?utf-8?B?WVFVSUJrb1F5bytqbEpTOGkyZm1pUElUbkdYZDg0VjNHTHJqMFNCNzg3ZXJM?=
 =?utf-8?B?ZytSZHJ6STFrcDEvbzlLWFJyeS9yVmhTdVg5WUtXNWltaDh1UW9BTC9wMC9Z?=
 =?utf-8?B?VllMRTE1eEt5TTNOaEY1L0R6eUg5b2dmV2NTMk9MTGNSNVpEaG5kWVc3Ym1j?=
 =?utf-8?B?cXZnVjBCNlNGeHpkYXM4eVlyT2NVbjIxeVNFNTdlRk00TmE5blM5WS9hZnNL?=
 =?utf-8?B?OGU1SWswRS9BbzlkTzdMbmh0R2FWVnp2ZkFpSkxqeTFPd210eEttUkRrb09D?=
 =?utf-8?B?cmNpWkh3cFFWUXpKbmhkK29uU1l1WS8wSHJ0S2pDeVMwYUU5MlYvYXJsOCs4?=
 =?utf-8?B?aE1tbnVXczZXOGVraGdBK0ZNUWJOdTAvTS8vdm1JRUdSKzBZa2h6ZC9WbGdV?=
 =?utf-8?B?T2R0bFA1ZU9QQUwzOUlDU0p1MlI0emczSWp1V21XNWZ4eWRGQmdxRFZvbmlK?=
 =?utf-8?B?MUV3WmNRYnpCNDRWbGxxK0VJcXZKUlRkdFlFU21od0FRUGozOHRVREkzbExJ?=
 =?utf-8?B?WDFhazcxZjNEOWpjNHowSGpncmJMWHZycTBQMzE4eVlZdWhGaDh6bi8wYzFC?=
 =?utf-8?B?S2lmNlpUV3VlaUlkcnFvNnlHYTNUa0ZCYU1rbnR4RVVNV0xCQi9Tc2d1dVJM?=
 =?utf-8?B?TXUzWVBYbXhVaGZNcHA2aUxRbzhlOGhJSWcyNEo2TlVVNzBvNXd3T2JCdW1X?=
 =?utf-8?B?MktaRUREZkh3cDQ2UEc2T2dPblVuTjRaTEJCMkozaU5KQldXTUpZVVFyTW1W?=
 =?utf-8?B?eFk1cjg1cmZPVlNidldKZGlUZTJ6emxKa3doaTYzZW8xcVdpN2FSMHpBdVFy?=
 =?utf-8?B?QnR4SDNkbzNyd1hiWHVEZ1RUbjZEUVRkLzh2VHdmWkNaL3lCUHNwWnNxV0NJ?=
 =?utf-8?B?akxhcVNIVDNLejhWdm4xWUowdHU2Z09Nb0lCZzFIY3FZcjNBWmdwblZWSjNV?=
 =?utf-8?B?c1NYcWpuanRuZld3c2dYL1dzVzZJUnlValVFQzI4UUl1YUdtUkJEb2VmMHJW?=
 =?utf-8?B?TklBVFg1Z3lkR1VWaXBXSVNXbG1NRjArTTg3TDh1ak01RUcvNnNrSFUwSndT?=
 =?utf-8?B?aUprNWVUZmhDM3h4cHpKeUx3bjJKSldOVGxpZWx6WEJ5aVorUHByK1ZwQU5C?=
 =?utf-8?B?cnVZMEhCM0V4LzdMRVBjVjJ5Z3VkN0Z5enJJS0luclVVZnEyV2RzZ2hqLzRJ?=
 =?utf-8?B?TW9kSWYzeit6OFVRUURlVmg4akQ3YmpTVlZ3azNyTDNkNzQ5VUN6elB4Uisv?=
 =?utf-8?B?UlIyNUxHT2lFT2ZCVWRBdThJUTRKRWhaWmd4dzFjVkQ1WHRybVVQeXB1WXpQ?=
 =?utf-8?B?Ym9Ybm9KVk9Sdms4dFJRVWRNc3A1RHM1ZVVySHJZb2dTTlNPeWxCVzM0M29L?=
 =?utf-8?Q?JdmQfhk8g6hDYzC2x0Es9gNVTk5mHAh3X5ppq6w?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0185a5d0-6294-45e0-f970-08d8cc5f14c3
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0402MB3405.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 18:26:41.6411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Q0o/jT/s32YZgQgaZc3yNAF504prRo/27eKIPDxG/Q+5PtHQhjvBxZAmIi/qYd21uiyPn1rw+3C6vMRUvDqsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6350
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/8/2021 7:09 PM, Ioana Ciornei wrote:
> From: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> This patch set adds a fix on the userspace support of the fsl-mc bus.
> Other than that, a missing device type is added and some other commands
> to the list of the accepted ones.
> 
> Dan Carpenter (1):
>   bus: fsl-mc: Fix test for end of loop
> 
> Ioana Ciornei (2):
>   bus: fsl-mc: add the dpdbg device type
>   bus: fsl-mc: list more commands as accepted through the ioctl
> 
>  drivers/bus/fsl-mc/fsl-mc-bus.c  |  6 ++++
>  drivers/bus/fsl-mc/fsl-mc-uapi.c | 52 +++++++++++++++++++++++++++++++-
>  2 files changed, 57 insertions(+), 1 deletion(-)
> 

For the series:
Acked-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>

---
Best Regards, Laurentiu
