Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C85C403766
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 11:56:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345301AbhIHJ6D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 05:58:03 -0400
Received: from mail-am6eur05on2139.outbound.protection.outlook.com ([40.107.22.139]:36512
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232677AbhIHJ57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 05:57:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=So96wBe6LsspesbiMfV4qCTSywBXbqw8PDTSPlzNa16gOYz3NVKtuTJkfhmHrrA9PYNszPYXN9n9OqIXCkjdeeQeBPaUbMPk+rGfP4wci4Aa6N3/g5q5r3zWlZ6zUycEzf+ttPFVxhNrgXIgkMIMTtLioOpBhsZIvo/dSNl4ap5N+L+03lZ1Oklrj3ZiCN3QOfSjgHvqbget4lkA3vps1MizG2g56cuTSF4S1PUz6QwSlQ/CGL/NtDqnrw8G9gwUKWvOwnhu90pIpFkzhcEnDHrg1QYzmp0cjDbwBQZRrzy1LBxTSKWWJrBIVZ56kozAE25Ik6K1w6VcqvgWPuo5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=uWiepAYHnnvqjVS5Ys2umHMd37Da2fSG6gYoC7hCHzI=;
 b=dOgWQO/tt37r/RPSX3mcYrLyOicTKic+y5TNwUwR/PXb0hCqTbsyaIQ6tTKxIibl6uRdCztIyGW2KL1mnZvFZrPiE+HWliNdfHylI2XuaYv8wJnTFDmmFl7Lm3yGmgRdn4ioe+pLlp3QAN8Hx6BWyQy8OEzioEXvdQDINb/iEvAEu8IxZolbQ6Yd3yPjtHl2CpwVf6VXS+lAA2wGwuuuu8RIK7i/mpY+9VtA5yRw5d9Qp56R3Tt4yR2mpOKLtGC27bpuwwVkJ2wn2+Oi6RvdBZ9ylEhuDEO5bcbCQziZbjP256gwlkG4onUcZ2mjyG/eseSEOrltOowDNhANB/Nzmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uWiepAYHnnvqjVS5Ys2umHMd37Da2fSG6gYoC7hCHzI=;
 b=pHAeeFnkZTIERoCkrHuDA3VZefhPh+Q7l65HAuNYGxG+yc9T8PgZ4DqybNRF1rZ1/WAmaiMiM/6xzMz9YNJ5vmC+zUHp/0rCn6oaQC7DZP171ITWDO67PLTMSrneAZeLQb5afoSVEFRPyrjSpWYCHp4vVQyAz4/N1QczYCMG+fE=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=plvision.eu;
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e4::5)
 by AM5P190MB0417.EURP190.PROD.OUTLOOK.COM (2603:10a6:206:21::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 09:56:49 +0000
Received: from AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf]) by AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 ([fe80::6c02:47f7:ff7f:2baf%9]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 09:56:49 +0000
References: <20210608190327.22071-1-vadym.kochan@plvision.eu>
 <20210608190327.22071-4-vadym.kochan@plvision.eu>
 <b54325f156eaaa6535667a1a7fb695c7688d2db4.camel@pengutronix.de>
User-agent: mu4e 0.9.18; emacs 28.0.50
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Jan =?utf-8?Q?L=C3=BCbbe?= <jlu@pengutronix.de>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 3/3] nvmem: add ONIE nvmem cells parser
In-reply-to: <b54325f156eaaa6535667a1a7fb695c7688d2db4.camel@pengutronix.de>
Date:   Wed, 08 Sep 2021 12:56:48 +0300
Message-ID: <vrcxh2wnnrl7a7.fsf@plvision.eu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR04CA0077.eurprd04.prod.outlook.com
 (2603:10a6:208:be::18) To AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:2e4::5)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pc60716vkochan (217.20.186.93) by AM0PR04CA0077.eurprd04.prod.outlook.com (2603:10a6:208:be::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.15 via Frontend Transport; Wed, 8 Sep 2021 09:56:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 64ae0ef0-c8b2-472a-7ef4-08d972aef9d5
X-MS-TrafficTypeDiagnostic: AM5P190MB0417:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5P190MB0417E9F7E3B085041EDAA7F495D49@AM5P190MB0417.EURP190.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s8FY5uTnvXE6hhUNvAQE9Xy2hDLzKvoCm/6cEurtK4PwRfqGtz8EmY0PyyWAPcJ7X9Y7af4NCD2okN1OyUVfiQuPKJp/i9cLGXiDpbDvU7KRDCw89HLbIVSIcpwzy3n1dBb+egIyqfIbpXC3PN1QBYqOIU9wSvzh6mrBqZ0oOM9FRWM/t/oZTXR5wigtCFLbpMy5PVz3VAx2VPfAUBJs+sqatYSl6vlLHif0V7PvQUd9hpWeXRE8iCXYXmHqe0O6c9q2YipBFICwWgrVZN6K+3NMhriEkfSbQFYg4lGX6nuNZ4xydZJMhInW0jdcgMr8dopJje91qzPJr/SZ98hlkRXaEuzPoTNEY7Np0yD5rQiRoIfsMLajNlgrORSmDgDiElE5rMTCS9lqtR2sZ20UrbU71qoqPRkvpvrWcawdWuvUNePwT7hetiOyu1tc+vavdT6DTc1WCQ6f8YDeNvYiGC81ut83OprMoQMZTBxwF3s+NQhTAdVzpUgilKLyq8LSD4hzwX84M+iipNG+oBdLEeuHDZd2+tz0lTeA5ckxvBxo5QZAPvWwUjWif28wWvG4Y/iJNngbdtaNu4T2mNZB+LD7plqkcqRxI6aee2lEooaZoFArSCakV3A5Ms4SiELRIb7ELbzbdUFw+C3xXYoDJgtQs/S+t4fwbSLplOsG9spEQoC8My1dCriCjBnLVywBrd/sw97LUtfhiNXQEabMnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P190MB1063.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(39830400003)(136003)(346002)(54906003)(36756003)(186003)(66574015)(6496006)(38350700002)(6486002)(38100700002)(66476007)(8936002)(8676002)(5660300002)(44832011)(26005)(66946007)(4326008)(66556008)(86362001)(2906002)(52116002)(2616005)(956004)(316002)(478600001)(6916009);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0grRHdsT2VUOXJHaVg2c2dHSmFISXZXZlEvQWdYbXQ0eUlXdit1bkNHcUtF?=
 =?utf-8?B?cXV2NFBsN0tld1FLVUJnc0hsSmgrdldFY1Z5aWl2SHRBYnY0SmVMTC9PeXlV?=
 =?utf-8?B?WEdhS1BVVWpIeWp6NnV2N0o5ck5lS0lWaFM1UWtuWEREN3lYYjBGNkhMa05U?=
 =?utf-8?B?RFZsWUJ5MjRnUGJZZHZ6cGVrOSt3VW9yVUo5MDcya0NwTjV3RS9QbVFNRk9R?=
 =?utf-8?B?SjdCRldJd3A4bGRDUVhHVDZjQ2M4MEVZMTI5Q09nVDdkUzM1SFBCb1B3RFdD?=
 =?utf-8?B?TWJVUUF4c0swTU5adXJPMVc0cXdtYUVDSytSUTFaRlZBR0pRRFlSTTFZdW5j?=
 =?utf-8?B?V3JaekJXM0ZLVkFabHFianFyMUNsSHZDdk5jV05TaGsvOVpwZGpvSDg5d21n?=
 =?utf-8?B?YURWSkorNUsrNW5QYUxMalVWTW5hSVBzd1NjRGVjVGNkLzhCaVZiRitQUTVB?=
 =?utf-8?B?b3R0R0NsS2xvQUdNekttYWdSaHFqVXRRdnRTZmcxMnhLVEV6R1dWSjBlWkM1?=
 =?utf-8?B?ZFdCbWcvOVFWdzFZU0tBOXhJWEI5dFdHODlDU0V1cmtoTEk3Q255a0RHMmxF?=
 =?utf-8?B?OWxOOUhyMHhaOVN3blFEY0I4bTdzYWQ1QkszMEYwWlJjNXpLcGRPdnZ5d2dR?=
 =?utf-8?B?dk0xTHNGekQzdXVrNERRYllzeW5NMFFkZkVtbDZqSlFpQlRPaHRqdWVNb0lm?=
 =?utf-8?B?ZVZGUXZLUTMrV3VTVENQU1p0ZklnS2xRakVlVWlPLzJGcTB0V0VvZUtYdmFu?=
 =?utf-8?B?eXdjbzM5VWRjVXZjMTZ2aUQ3enBUWWwrVFA4YTZzcDV1Q25YY053SG5nSWUz?=
 =?utf-8?B?WVR6RUFZNjhta0tGWlJMTGtpQTJRUFZJQlArdkVlQUdBUkZ6UnJmOHFvMGh5?=
 =?utf-8?B?NXEvZUVXZEhrNjR5OEhKTzAwVndwa3JWVnBMdHppajNBbW9zbUI2TzdTTzhM?=
 =?utf-8?B?Si91YVQ4YWRxMmJuQXpXRERyamRoREdqT2hKV0RpZDY1QlY3MElyM0dDWVdH?=
 =?utf-8?B?b1BoVzZBYWFsSmw5MXVnUUV1ak1DNUg5NmIzV1JqN2k0bGJ5RiswQXpMbXcw?=
 =?utf-8?B?dklwaTRkQ1J5dDBkenhXeEhUaUQ4bWlXRUoyT1lFN3NxR2pkcktiR0swOVFq?=
 =?utf-8?B?T0MrUmpiMklYVm5uM2hoMUZCOHRKcWluYVZscmtiWmhLMDdnWFQvM0hLTFpE?=
 =?utf-8?B?Rk1FOFVabWxGMjJJMjJQUmIwQ1Y2TUpPZThoUGlLYW0rd3FLbHRRcEpnK2Q5?=
 =?utf-8?B?NUpUaGExMHFPMWpPdEIzeFMrc2w2ZHd3NVR1VmRwUzY5Z1l2eWdXblNpaUdZ?=
 =?utf-8?B?TmI3MFNIaUoyTXRtVDFZZ2xMcXY2VTIyUFRyYnZ0bklyTmxGVG85QTAwSkpW?=
 =?utf-8?B?Mk9zMm8yeityT21tRXdYL3dxYTRtNkJqVW1FQnpIdVBrWU1mbzAzZUJOSEdq?=
 =?utf-8?B?REdyNlJKaVNBejJxK1dXNG5sdEFnV3dZN0ZnSXZ2YVJZdWlLQ3hlOG8ydEVN?=
 =?utf-8?B?c0Z2MmNkbDVtM0pJWFBaWDBEck1ZREZpR2FGNCtDckxkaVVJbEhxYkxkUXNW?=
 =?utf-8?B?K2Y0VzUwNEVieUk3SklldzdpODlvV2xISnQxR01tUVd3NXpPMUsxR0VNd0pY?=
 =?utf-8?B?akVvZ3p3Y0tIQXdkNUtyNTBobE5vbTQ3SGwwVlBaaTFUeENmTjlYT3l0aW40?=
 =?utf-8?B?anlRSHZqVldrL0Jva3VJKzR0QlJDZCtjYksyUTk4ZiszSGVMaHF5Q3JKMmVK?=
 =?utf-8?Q?FvuSdARuf5ToRgNdtam7QnNGNEbV6PjC04uxySm?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 64ae0ef0-c8b2-472a-7ef4-08d972aef9d5
X-MS-Exchange-CrossTenant-AuthSource: AS8P190MB1063.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 09:56:49.3131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYfNMDTjST+8LIDSwOdkQZ8sEdtQbXqTGP9sZKu/HeOpe9O6j6E+HPmWwedQcbNBit3N97kWMqq740oKWheUcmwvyE06IskguoDxWCR9Ihk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5P190MB0417
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Jan,

Jan L=C3=BCbbe <jlu@pengutronix.de> writes:

> Hi,
>
> On Tue, 2021-06-08 at 22:03 +0300, Vadym Kochan wrote:
>
> ...
>> +	case 0x24: return "mac-address";
> ...

This is a base mac,

>> +	case 0x2A: return "num-macs";
>
> Is suspect these properties define which range of MACs is assigned to the

Yes

> device. How would you use them to assign MAC addresses to multiple interf=
aces?
> The nvmem-cells property in the network device's node can only refer to o=
ne
> cell, and not to i.e the cells value + 1.
>

Currently in net/ethernet/marvell/prestera/prestera_main.c it is
incremented and hard-coded by the driver.

> I think it would be useful to have a way to express this setup for system=
s with
> many interfaces, but am unsure of where this should be described. Maybe a=
 "mac-
> address-offset" property in the generic ethernet controller binding?
>
> Regards,
> Jan

May be something like eth_address_provider should be introduced in
net/ethernet/ ?

This provider can provide something like eth_provider_address_next() which
will consider "mac-address-num" (or other specific fields).
