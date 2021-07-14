Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0523C8289
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jul 2021 12:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239088AbhGNKPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 06:15:46 -0400
Received: from mail-eopbgr80054.outbound.protection.outlook.com ([40.107.8.54]:49381
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238728AbhGNKPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 06:15:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=folyRDD8lY+DEgEA9OW/LAOCn6QH1p185PYa9UeEBQYp+/xJeKfvkfl/Th6HaOD1QkE99Mgfse4fUbUC7nccDCwZgtYQAjg0XEtXdaVY7gQkXrgSHRieabFLgMOki7f42pM0yOPrfk5V+Uld/XCfhYqd5MBXlTCeVZGHf8aDMC/auDZbt2KA00bcQzcMwMJMgAFUJxVhaNH6CWUkfMCWXG3cYdMSytdU7ooI7op3BHWG/tpMICW2eRLia+WiWIi0d+/VccG/NUw3YC542Rq9Xmu9mPs9j0RbxjGK9OZjT50wgW2L/7lsvEGa9hblKEmIwJf7ST9q7EyiL/euYHujXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nlXTK/S6Sn7ZQw35RAKsibFsEF69qOFlN1S64Cq7wY=;
 b=StivaVzDFkAWIUdWklYN8iYKuphk9jcd0D9eCZwfCfeOMYWRIsvAGSiGjeUX3p9GXBJIB3uCvH9NROQclBs1n22u2KG+7xndpPHLRCQ/lCiRNMRvDz9hBTNd1XiN8D3OwPbFEp9MdriLxaK/32vgkQyx+uxBKXo2FmkbqI6/JsTFHBnQujMzMZHigaxQtQ7UPc+WMAhNaj1zPz/tZW+NZyNKEQEEW83esMMLrYXeGGQHc7gEEpGD9Gvwnkyo+Bq1FAf3mNZdUtDPUhxnX0XpgMmQ16pcYehiXh7GOr5OacKWilclonhkC2MMvQGmmvfCBwn3cmQL1082B2ZA4qEryg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nlXTK/S6Sn7ZQw35RAKsibFsEF69qOFlN1S64Cq7wY=;
 b=HxA7k/8FpwrgMe00TkTqFQY161CZ7oq8mueKov9tom8IHJRgk3d8/q3x8B3CavSTdoQfYjSYnY9GbpZxQfTE8ADbSaaOdsJgZkfMlMFjne/vFRhwCLh4igfRAhhvN9E+ENXOmcHe7WUfZvR5MA+xTGfV7Te9LsmACY8fGYoxybw=
Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AS8PR04MB8311.eurprd04.prod.outlook.com (2603:10a6:20b:3b3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.21; Wed, 14 Jul
 2021 10:12:51 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::1d4c:c3f2:dbbb:88f2]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::1d4c:c3f2:dbbb:88f2%9]) with mapi id 15.20.4242.023; Wed, 14 Jul 2021
 10:12:51 +0000
Message-ID: <1f1b38f9c42093bea5e6a8ccb458bdf799069157.camel@nxp.com>
Subject: Re: [RFC PATCH] clk: fractional-divider: Correct max_{m,n} handed
 over to rational_best_approximation()
From:   Liu Ying <victor.liu@nxp.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Date:   Wed, 14 Jul 2021 18:10:46 +0800
In-Reply-To: <YO6qfQMcvr9szZTJ@smile.fi.intel.com>
References: <20210714064129.1321277-1-victor.liu@nxp.com>
         <YO6qfQMcvr9szZTJ@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0113.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::29) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by MA1PR01CA0113.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend Transport; Wed, 14 Jul 2021 10:12:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 650d8a3b-1c39-4187-f91a-08d946aff007
X-MS-TrafficTypeDiagnostic: AS8PR04MB8311:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AS8PR04MB8311300CC64551554F4316E198139@AS8PR04MB8311.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ik2OaADaH12W91bBtDJhv2krDWAkgvh29u4zASgFJ6G6fca8EOCkvcsv/DAlPBJby6WMAzulu0ztmoNhdHUMUbYMwp2d5T9LyUSNLdaywB7WhOggMt1MmEll0DVtJRGBf52Yw2Lk1iGgH1Xg4Ix1othGKGsm76DzxS9ZYYWyqAM254X/B0zEUY+S3sW8GNs7IGxs8qc6L0B81Nnj+Fum6mSYPmYW++GKH7wYqXuXrWXDozV8qB7zHGtjQyKUmX93VBlaAof0wREsB+hzzD0973VNa8ceoHXVxOzUxxLKouROO6giUC3lKQNgNUC3wDtwAGHm6ZVOsRrmz3GTc5nZd3W9AlblwCCRO26tuMQmDeXBOOog8Lk9/LEu3BLlmWM2ShcxWU1koew1qH8UQDtdiUqwqQQDg277j0zgP/9xWihXbmSC16vSx6TqJNWFN90itq2cRifT8MK8rE2yKVjZ1NoILbb/Xyb2OyZns3am+ykTXtHUzFVjcHnIyQq+bmvl/ft1XFQA3juPR/hzMTljze154MzvVC7NnfWV/Jq241ttdQ1PObV+UsZ4JTHxHnMKRiw+xfeBUm4LRZs0QCSSYCKvnt2spD2Y8PLssde48jbTmmphL7Q74r7ZlW5IoFkoodiIEL8d99X8DITKSKPuvvJa3e5F4SPmzX2XA4B0x1irCGGQClCynutUqNCCZIpcj57wWeTLxezYxHAq2JshBw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(366004)(396003)(376002)(956004)(83380400001)(66946007)(86362001)(2906002)(66476007)(316002)(66556008)(36756003)(5660300002)(4326008)(38350700002)(2616005)(54906003)(26005)(8676002)(6486002)(478600001)(6916009)(6496006)(38100700002)(52116002)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUFOQlNlME5XeEIxdXFEM3VSSmhVNlpUOHZBeURWSXBPVmo1VlBqQnBmeWZy?=
 =?utf-8?B?TXp5dElFakswblFEdXJoZ3pJaFp1M1pibFVmN0FOS2pCcnB2cm9yaW1ieDFS?=
 =?utf-8?B?SVh3VEY3MzZOMHNxSjRKam5NUEFRNzNHa1JHN1VHa3NDS1Z3MDFQcXB2TWEx?=
 =?utf-8?B?eGdyaEpVb1U5L3EzMHoyY1p4VERHRmNuSGcyZStmc1pMeU12VWdVTEplblF5?=
 =?utf-8?B?NTJxUWYvbnFycWFGRkE4QWoyWkZQSU9IOUFON0hHN2Rzdk5WSmszMERhd1Vu?=
 =?utf-8?B?RTd3ZDN0WU8wYlc5dmFCKzZBSDM1M1NjREMyTFIyQUN1SnhaL1FMazc5LzFp?=
 =?utf-8?B?aEo3QmRoQklZQXVKVnpxMzJrZzJXVzAvNHJmbWx2aTNFdFdJdHFGWktHN3Q2?=
 =?utf-8?B?TXV1U05nbnVSTkdMUUxKMUUrMjlrSkYzQXlpeHdJUjlmZDZLaUxOTlFrcWJS?=
 =?utf-8?B?RjljUmpYRUYwZXpXVDRzV3lCS1Z3RTJpREZpNEY5RlVia25iVGNkUjhTcWNh?=
 =?utf-8?B?SW9qZUVCb1E3T2dkZzhkdXhmWWVCb20zdnJvQnY2UU15K3d1RWdxVUFONHlM?=
 =?utf-8?B?dzh1Umk5Z2x0bnMyY21Ya0o3S0ZEbXdNRUNlUDNBUmZTZGpiRStUcC9nL2Z0?=
 =?utf-8?B?cWxNaXJrdHlyTWppVVBRdU1MR0k3YWpCNjI3OE43VEZEZGdQSEthTzVXNS9C?=
 =?utf-8?B?NnBYK1pHVGc2UjNkSzdLTU9od2ozWDh3RVRoTGZCYzI4WW1qSEhnallxUzg4?=
 =?utf-8?B?OGUrWVptMmJ0YVNNQVpWSHBWdTI3c2VteVJDdmVGREpwUHRXekt2aXlOZzNC?=
 =?utf-8?B?VndwR0ZaYkUwTzBEUHBYb1AxMHFUbkpLZkI3YU1GdEszVFhYZHpacjFrN0pL?=
 =?utf-8?B?aERIUmRTMWhMUFpnWmxOSHZraTJGU0ovZk1KZmRnMWlvbzB4QXcyeGFocnRs?=
 =?utf-8?B?T3NXT2cyNWZBampRYXY4aGlIOUZXOWsvMkZUeFZLRnZGSGVYWS9JclVScW9s?=
 =?utf-8?B?T3BuS2pTRGNEcCsyTmlETHBJM3owRFV6SklIOHZ0S1FIdEk0alNyZHBpQnRQ?=
 =?utf-8?B?YVR0ZmMzL1BnY0hOZEhPQ0wvbmhMMWx0T1dWUm1WcldyYUU2VXhST2xiN0M2?=
 =?utf-8?B?eFlHYVZtU3hTdEYydkdaeVFwSktvR0U0Q1Q2ZS9zOUJyYnZXVlJkTVNqZ3pU?=
 =?utf-8?B?UVNrQlo4SmpJT2dicVFrMnYyYURWNmhpdjkwbm9vVWdUUUpnbmFzMC85T01H?=
 =?utf-8?B?bGdvTG1jbWJkeXZQL1dWSk9pYkozWU5tZVhtRDRlblRsS29BK091ZURqUWh5?=
 =?utf-8?B?dEdXMlErR1NRdDBBb001dE9vSithVFdacDdVTG53V04zOFQ2TGQ5WjVMWW1O?=
 =?utf-8?B?eE1lejNuMzVpcUxuL0sza29oQXlsSW9CbkJFQm1BUHhQQThxeG1GVnptNnV3?=
 =?utf-8?B?bG5VVDdQRUgzR25yMFFENy9CdEk1b3RLeWZ6U3lZWHIrYTNEdnVYZktaTGZu?=
 =?utf-8?B?QjFESGQ5TWhzMHNGVmo2ZzRIWVdsaFFKN0s1REhUdGloNkQ3NmFoNmhkaElF?=
 =?utf-8?B?Zm96OUFsdWdHZlFwaHRPclh2b3BsOE0rZVJrM3piNllNbi9jSmFlY2IyWjgw?=
 =?utf-8?B?c1MrK3pQOUh6ZGhEQlJPZU1zdHQ2NVE0VlB5a3BneUJZK0x0L2JYUTA4VnV0?=
 =?utf-8?B?d2NUUHI0eTFjdTFRTTF4RUNGc0h3VXovbWd1WVlUeVpJS0xNSXJEU0lTNS9Y?=
 =?utf-8?Q?oDy3BBVuqw8csXJWkt3O8Bu9jhEY1BROIugjVzt?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 650d8a3b-1c39-4187-f91a-08d946aff007
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2021 10:12:51.1414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6LrdmqhEnEzux+tDa5yoHbYp9hgN1SqAsoiRYAk0M2TXNYDrSpCBp2ST/+8uXrSbaidNSN2Kdd0zg1nKSFGqKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8311
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2021-07-14 at 12:12 +0300, Andy Shevchenko wrote:
> On Wed, Jul 14, 2021 at 02:41:29PM +0800, Liu Ying wrote:
> > If a fractional divider clock has the flag
> > CLK_FRAC_DIVIDER_ZERO_BASED set, the maximum
> > numerator and denominator handed over to
> > rational_best_approximation(), in this case
> > max_m and max_n, should be increased by one
> > comparing to those have the flag unset.  Without
> > this patch, a zero based fractional divider
> > with 1-bit mwidth and 3-bit nwidth would wrongly
> > generate 96MHz clock rate if the parent clock
> > rate is 288MHz, while the expected clock rate
> > is 115.2MHz with m = 2 and n = 5.
> 
> Make sure that your editor is configured to allow you to have lines ~70-72
> characters long.

Alright, I'll see if I can improve this in v2 if necessary.

> 
> ...
> 
> > The patch is RFC, because the rationale behind the below snippet in
> > clk_fd_general_approximation() is unclear to Jacky and me and we are
> > not sure if there is any room to improve this patch due to the snippet.
> > Maybe, Andy may help shed some light here.  Thanks.
> > 
> > -----------------------------------8<---------------------------------
> > /*
> >  * Get rate closer to *parent_rate to guarantee there is no overflow
> >  * for m and n. In the result it will be the nearest rate left shifted
> >  * by (scale - fd->nwidth) bits.
> >  */
> 
> I don't know how to rephrase above comment better.
> 
> > scale = fls_long(*parent_rate / rate - 1);
> > if (scale > fd->nwidth)
> > 	rate <<= scale - fd->nwidth;
> 
> This takes an advantage of the numbers be in a form of
> 
> 	n = k * 2^m, (1)
> 
> where m will be scale in the snippet above. Thus, if n can be represented by
> (1), we opportunistically reduce amount of bits needed for it by shifting right
> by m bits.
> 
> Does it make sense?

Thanks for your explaination.
But, sorry, Jacky and I still don't understand this.

> 
> The code looks good to me, btw, although I dunno if you need to call the newly
> introduced function before or after the above mentioned snippet.

Assuming that snippet is fully orthogonal to this patch, then it
doesn't matter if it's before or after.

So, enlightenment/comments/ideas are welcome.

Thanks,
Liu Ying


> 

