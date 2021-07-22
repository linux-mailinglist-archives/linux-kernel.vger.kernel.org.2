Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC543D2122
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jul 2021 11:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhGVJFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jul 2021 05:05:35 -0400
Received: from mail-eopbgr00083.outbound.protection.outlook.com ([40.107.0.83]:3904
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231417AbhGVJFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jul 2021 05:05:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM8l22t5cc9VS4WyH2PpS71Fga1x7OzshaXoXIGS8RJQyqwie7hTF4QxzPwrCn0sd2R+A5cmfALy9zCcQ2ZO04k4bijBSPeKmzTp4i+NjeczUw/ongP7uVVOnq68UoATG+wdCPFgnnfn8EkQI/DgL61Sla4ZBHuBwwJXJxbv6HwOzKVmV1FKW6JaWWxM9iJX33ShyxuU7D6LsoKtv0C1ZfmZ+05lGjZ16IOYS5ZiiAS1/rah9GHckucTLnygnABMU76ZmvxW4IJ1fp5C1Cw8hpjPDxQN8XCM3yZVA9A5H1Lrcf30jEEGE1LN+Xl2ctA81e5QEeddWlzZxRnt6/dknw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI63k0pfcgubGsH7+yvOVpNphLc/V+RuMjPgnlDlV04=;
 b=U7EiEn1IbQzZGbKqEb1lTr80ixj0gRCnAqTKwsUTrCpfG20yTSm+kpWsn60YAqEq6u3od5wGRz+YyKoBQQYpV9je6noJyPbciBryvlbavgf14sEXGKyUHcZFFCBE/gcb8BJ13LM6zKU7l34rs/DYIGUItcqrDajC3PO7HLAbsCbqUkq82HMetePb+rP1TUS/HK8RTh9Ip+eg3emIBatFSOoGjOh/gh7IUctbpF+Kq5PZaz5Nkw6nypTLwdtEn/OEY9EBAH/HgTpL9ky1/D1LhqftvvLypySbA2REEFwf1Tj5sFvpkU9NZk6BvBVv7ub208Nki8QxYhzmcEVDb2O4Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GI63k0pfcgubGsH7+yvOVpNphLc/V+RuMjPgnlDlV04=;
 b=d14cgVtTbGPoRPnU1Zp+7y7jdD67QBGUHcTKW2Ijpg7Tv6KTg2Dej2Vg7Bt3IAngIhAfJXG74I4Y3pn5MEzJrNTaCewwSPEunvuH2PqWwyHabCLupdxDfee6DSVJVoeBbLkZH5SPIdFtDQAW376LGGinhyc+OwxF+dNL9sT8s0Y=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB5208.eurprd04.prod.outlook.com (2603:10a6:20b:9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.28; Thu, 22 Jul
 2021 09:46:03 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::8c66:a7b4:1dc7:2c27%8]) with mapi id 15.20.4352.025; Thu, 22 Jul 2021
 09:46:03 +0000
Message-ID: <08ca856c013aba60e686f050e06a6e3179de6030.camel@nxp.com>
Subject: Re: [PATCH v2 2/3] clk: fractional-divider: Introduce NO_PRESCALER
 flag
From:   Liu Ying <victor.liu@nxp.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Michael Turquette <mturquette@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Date:   Thu, 22 Jul 2021 17:43:49 +0800
In-Reply-To: <CAHp75Vdm8nO-zT0vyKcB1hOXkR7_2RY-2P_fnkjV5BCc+uoqXQ@mail.gmail.com>
References: <20210716133448.24890-1-andriy.shevchenko@linux.intel.com>
         <20210716133448.24890-2-andriy.shevchenko@linux.intel.com>
         <9117e5212a3b743ca541918ec2b701c159ac752c.camel@nxp.com>
         <CAHp75Vdm8nO-zT0vyKcB1hOXkR7_2RY-2P_fnkjV5BCc+uoqXQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from blueberry (119.31.174.66) by SGBP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Thu, 22 Jul 2021 09:46:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a0864181-748f-4a9a-8027-08d94cf5851f
X-MS-TrafficTypeDiagnostic: AM6PR04MB5208:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB5208853DA649F8A1B73B986A98E49@AM6PR04MB5208.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 88du+OfJHxE+i1AP1emDIE0VcwH563TE5L1rrGMX9LHxQ89gxieJ4QmiT4rOtY/HG9vDJ90ivTSqnU0ZC46J/14POk/wjpfFhTKJw7JGzw/vM4MyRvJTmwvN4LONpUtlz7IPcAcvj4WtP6y/qhAqZ/eidMkKsfbiiim/XaMwZTynInUqmhX2O6PvOYDaJGqU5AtIUxq+Bn0QEBbM13YlE0rdV0DZuKIY5vHR3RfdHXQmNQEcBhBEIpppgh7dwqTizAyqcLgowP+LPu+CXljtU9vVgc0Cf6iBkI2pNULeSO5MRqfucoNI2PteQa/CWXXRwmCSiZM+DF1O032erY38xmgSm0efGNrQUgSobwTcaUlrso7+zcNyr5oeF0BsgRlG1e6rkpG35MZR6vkmy9rq9LmfGU32b2tNWCoW6CMiHAznFHwc4Uxv8MtK0ff6ShQV5enBfluLz/8qk0S2RZp9wXJlCQgUADRmHFRLKvS/MkHG50Lqm43FqSt+goq3P7nWL9XSDEQqKMAPQ3mrKuG8UwjCYDNcy4Oe24egWTKGoda9dc2WssHzKpvtWBmzat6a0uVkJvvXiGo9TdLSWOPkBd7lRzwPG/wJjrUGx/UFwtS3HrQxgRIu4PaI1d6UcHmHJLccUwkXz2LnfaayCFXGcpZd+LD10ic+TJjIJEbAo/2ax+zfQTLN8Tx3Bx+G79fvtzi20UOVrRif5l/xg/Tfdw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6496006)(6916009)(7416002)(2906002)(52116002)(53546011)(5660300002)(186003)(956004)(4326008)(316002)(83380400001)(86362001)(2616005)(6666004)(8676002)(66476007)(26005)(508600001)(66556008)(36756003)(38100700002)(6486002)(38350700002)(8936002)(66946007)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFNvclpnZDRxWDkrOVJzekVxeElvd2xDTTBXc3ovWGpiZ1VVcWNRNG1FN3hz?=
 =?utf-8?B?YzJjWUVPQkRCcUViV1FsM2tDZm5KWWxMMElSUWhVOEs5Zm9sN2tBYkxhNjhm?=
 =?utf-8?B?SGFUaFU0S0RSMmg2QXFUNUl6VmdWZkFWTXNSaDdWTXRva2YvazhnRmZHTzlw?=
 =?utf-8?B?emF5TDVwdUlNMnJFTUdTQUpxRW1EWDg1b3lxVlNrRkovOWFxV1Y2b3RZN0tW?=
 =?utf-8?B?Y3VyS1lyOWhjbnkwc2VSM3YrMG1JSDIvdzloSHZoK21lb3NnTkF2Qzl4ZVFC?=
 =?utf-8?B?UkVSU0hvMkgyRnlxUzJ2YzFWa0ljZFZ0OUdERURwUXljVHpoOUZiaUZlVTNP?=
 =?utf-8?B?MHpseE5weFc4TjVPNzZPRlBqNXVaMzlzVWJIM1JqU1NPTEF5eVozVWNNWmY3?=
 =?utf-8?B?ZW8yYUhhOUlDU1JzRlppeG1sNHFYeGtlN0ZBcVdKMmh1TStyL3ZCQ0cwU3kr?=
 =?utf-8?B?VU1COHZCSmdZS3dYN3cyK01mdnR2cXBUVzFBcEx4dFYvbG9SQ2Y1ckRXREEx?=
 =?utf-8?B?Q0wwN1Zlb0hNRmVZdkF2aFMxemdza0JhOE54NXFMdmlXZlgyVEJvTWtpYzZJ?=
 =?utf-8?B?Ty84Qm1NLzE3S1BvYklRdFJQR1ZQcExydEFsNGpVTFJnWCtEV2RzRmJoQzd5?=
 =?utf-8?B?YThxcU42SWYyYXh4cGxIdDBlRjZ0UURwaDQ1N0R6WDRwcXBwSW5va3JobWpj?=
 =?utf-8?B?RGJuT2lOVDlyVnlXelFwNTh6T2xFRUZ1V2p4eXc3Ynp1ZjBzemJ6bi8zZzMw?=
 =?utf-8?B?Y3JoakVRQnFHaE50a0c5YmNNVlhzSzUvWHNWRm5vdWhhaDNHZkhiN092QkZB?=
 =?utf-8?B?UDNXblBkdmJoaS9lZ01GMWJNUTlLU256Y21Ib3BlRjBJMHh4Ny9makNiMXM5?=
 =?utf-8?B?S21EaC9qYUY5UmhXb0czUDArdVpYWENHT2FoaUtrYURwazBFVXNrT2RKRzdj?=
 =?utf-8?B?OHVzZlNJVldsRFFEdzlrSmlZY1FFY3dBL3JjMXhxNld1SktQR0lxUWxVVDZr?=
 =?utf-8?B?TFRzdHhiQzgvQTZsUmtVUW1HblZKN3c5ZkRKdlV0Tlh3T2VsaTZTVjB6d0Fx?=
 =?utf-8?B?bmoxWWRWcGFDRGpvQ2pRYjk2dGZYaG8zanpvaVhhV05uOHVMTGhEbldHSit3?=
 =?utf-8?B?NkZOT1J3QnRXSHpDV0tCMjVlS2EzdFgxZmtORjlQemowOFZZZ0VUeVJTdCs0?=
 =?utf-8?B?U3Y1S2RnVTZhbUxYdnBPNmhKRTVOTFovcWpwelQrOG0vb0pCZDZNUlNkNGxj?=
 =?utf-8?B?SHNJcFM3MWR4U0pRWXNOc2ZNTkdjOGp6MkRhM1ZuOEdwTHVWM2VxVUdhNmZi?=
 =?utf-8?B?cVRpVFVnRkpyT25NOVE0S05OKysxUm8vMVJtRWFqb2VKQU9BWHBUQ29WMlhW?=
 =?utf-8?B?VnNkV3RlT3ArMC81WnFSVm8xWmNrNDFISFhYcnhLbzhrZmd4cjJBM203bVhR?=
 =?utf-8?B?b3BGZ3Y2WmY2bjNZNWdFcnhMamp4SXVqRCtYcVZCZER0aVREWnBaMTdQSjlw?=
 =?utf-8?B?SmszS2JwbXJMZDNJV2hQRHFNc0FISXlRQzdFcVZZUUtYU2hvUU14V2trV0J2?=
 =?utf-8?B?UTlJaWVNMjdDcko1S2QzQldMZFZkV0dMMWFqbng1QXNBSndtR3NGY0ttbUVH?=
 =?utf-8?B?dGdQWDJXT1diaTQyNWNZR3JNR3RKOU5lQzl6U2lOY0ppcFF1UVZBRmk0eVJa?=
 =?utf-8?B?TlliQXpTczlsYTNxYnQ5b1VOMFRZVGo0N0NmT1ZUTTQ4NTdpaDBGWVJRUFV5?=
 =?utf-8?Q?qjgGgExxGIuv4cXP3rIbPsh7NubrFg37ewNzpLU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0864181-748f-4a9a-8027-08d94cf5851f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2021 09:46:03.4754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3DkEGy3XH0Rps/tsCSbdhOrjLjdCx1QshJPxYD2MvisfswKgx5m6RRoYTzUBOBP66sf3dmg5jf3YUargkJjvug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5208
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-07-22 at 12:38 +0300, Andy Shevchenko wrote:
> On Thu, Jul 22, 2021 at 12:33 PM Liu Ying <victor.liu@nxp.com> wrote:
> > On Fri, 2021-07-16 at 16:34 +0300, Andy Shevchenko wrote:
> > > The newly introduced flag, when set, makes the flow to skip
> > > the assumption that the caller will use an additional 2^scale
> > > prescaler to get the desired clock rate.
> > 
> > As I mentioned in v1 comment, it seems to be good to decouple the
> > prescaler knowledge from this common fractional divider clk driver.
> > This way, we'll make it simpler and easier to maintain. Also, then, the
> > NO_PRESCALER flag is not needed at all.  However, it seems that two
> > Intel drivers which use the frational divider drivers will be affected
> > and rate negotiation logics need to be implemented for them.  Please
> > consider if it's doable or not.
> 
> The current driver works for the certain hardware without this change.
> If you think it's better, submit a proposal we will discuss.

Well, I'm not afford to do so. Just share an idea. I haven't got the
intel HW to test.  As I mentioned in v1 comment, it seems that you have
experience on relevent drivers and HW to test, may I encourage you to
do that :-) Or forget that if you really think you won't do that.

> 
> > If we ultimately keep the prescaler knowledge here, please consider to
> > add the NO_PRESCALER flag for i.MX7ulp as it hasn't the prescaler IIUC.
> 
> You mean there is a code which is currently using this driver w/o
> taking into account this prescaller flavour? Can you, please, point
> out, I'll definitely update it. Thanks for the catch!

drivers/clk/imx/clk-composite-7ulp.c

Regards,
Liu Ying

> 

