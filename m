Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B689371744
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbhECO6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:58:37 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com ([40.107.20.133]:22017
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229942AbhECO6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:58:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MTeNfCWv6kb3XCcrUZaiRNhSZOZGtZvSttpav4AWqsFA57/iT8pRNmLuNVO1yuVThFZw2hgERXQW+1Kz3WLnnQTatXojSclVoCGDHe8kFzSJD2rdOtlvVNAYmEOKb1ip6Nl0YpBcrT52+WdouVgW/vdQVkPZCwPUarAXsCNbSDjk/he9nEvrw/sWsZZGKTAvBnAKzUqSRZWNyDZx9drkjHdmMxkSNMhYfFc9r7YpbgMOu0GS4hyN5I1BuXYI/D/ojM1Lnpb//klF4DhusaQ0MUTCMsN/hRSdvt6C8HW8gGZoNaEqObj5H0JKjh8Sz6Mzsa3IKQREHfP2RVG/G0LjYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihds1OKvvQTqDIQF8Wo+OU1Gbts/mpaalKkGDNgHNUQ=;
 b=jpf5JxeJkcJaz0hlhnX0VYyYC4cLm1EkmdynVdp6UOLKcSmsAx2R3sQS7Sf3fl5u1wDJESeXr96FSuRfKIvUhhLWKVEs+ZecU8YGXKEiWMV1X0vRkxJqAgJzpE1DCIJBOVek2JYXhWQc8l1lZYsvODFj8jHshWBuKrtNqfWgjaV95k7Yt6xLDPug2ptuvLOYd3t760aMalDHFEiEUkcR8ZUHZ8ndKSY841CaSUiGLo8dZoL1H0aUuP6kdqeIX8a/M2sO/V5I4xNIe4rdNZYZ6jZO/J7mSoI7ugo1ONV+3dqLVZqy3BlupSWAOwqwzQ2lQZd5gBUJqlfXnFaWI1yjgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.de; dmarc=pass action=none header.from=kontron.de;
 dkim=pass header.d=kontron.de; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihds1OKvvQTqDIQF8Wo+OU1Gbts/mpaalKkGDNgHNUQ=;
 b=aerjPfenR5Z1pYgVKvmptVp/Oj/owHOvSZ/hIQC4awXy2QsltEjd6BVI7P53XvrQB2nouZTbj2EDDl8IR9q+TOTfL52SRLxUTO4JBTrrRQknhRPeAVvORx+BPKH9oUoO0zgZa6o0YzCDWqYr1wvGSlMTxDEhkxSh3l8HjjIM2OM=
Authentication-Results: nxp.com; dkim=none (message not signed)
 header.d=none;nxp.com; dmarc=none action=none header.from=kontron.de;
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:157::14)
 by AM9PR10MB4468.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:263::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.38; Mon, 3 May
 2021 14:57:41 +0000
Received: from AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87]) by AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::3d8a:f56b:3a0c:8a87%7]) with mapi id 15.20.4087.044; Mon, 3 May 2021
 14:57:40 +0000
Subject: Re: [PATCH V2 0/4] soc: imx: add i.MX BLK-CTL support
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        p.zabel@pengutronix.de, l.stach@pengutronix.de, krzk@kernel.org,
        agx@sigxcpu.org, marex@denx.de, andrew.smirnov@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ping.bai@nxp.com, aford173@gmail.com,
        abel.vesa@nxp.com, Peng Fan <peng.fan@nxp.com>
References: <20210430052746.10815-1-peng.fan@oss.nxp.com>
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
Message-ID: <ae7630e5-af69-3504-2298-23e432308ce6@kontron.de>
Date:   Mon, 3 May 2021 16:57:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
In-Reply-To: <20210430052746.10815-1-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.250.134.29]
X-ClientProxiedBy: AM3PR07CA0097.eurprd07.prod.outlook.com
 (2603:10a6:207:6::31) To AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:157::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.10.27] (109.250.134.29) by AM3PR07CA0097.eurprd07.prod.outlook.com (2603:10a6:207:6::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend Transport; Mon, 3 May 2021 14:57:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1f03c86-df5b-4277-7bf2-08d90e43cc9a
X-MS-TrafficTypeDiagnostic: AM9PR10MB4468:
X-Microsoft-Antispam-PRVS: <AM9PR10MB4468331592A5B38CF163DBDCE95B9@AM9PR10MB4468.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bqb/lB2A3ZXlTLk6JSDbl9KfvC1sqSuXuab6Wv2o9aSoNpnoJ89BPISF2HeHn875FH3DYFDO9aOjUsTU9uREmuhJ37+nQwD1hbRyvnnlvaSzcodDQthyTvLeaiJ/JV3DOsur4VXasXIo542Pm6w6eje8iJFLqRvPtrjSIsg4lleqraD7fooq/YA55PEHDOGHvnM6soaxPt0S1gMlUSYRvnthOM3k9Ph6sz+C6kp+s0yzmyTjPAhoTuw+vJcHEjF/N3s0BwwwopRDOWiTVV/2VS43IPsX7ZYrDurijlkdT1uh9hsbOawRm848auHPIg9Ka3G7dGy6CCDNyn04di2WZ/NP2BIb6iM5gAlSik/JuHJ65ZEC+T1sAI3/mtdeTSPhxcoqDxe7yl9RePmE5EO/vTQr/m3pR3iJG2YE9BaC+y9CgxwpYWTp6OukUN65hlQLIhy0IbODGVlPXkRoeeIP8qJ0FiaDNgVLSqD4WOAx+XLObTq8nlb488BzrmD/UymgPg1AZ4t2aCiP2dKsgTf7bUAO95soVICAE62Sas6cCYYOWyihmQSwyae8Pgy/88gsHdj0eV97xp8IFDr1DZunsvUxm6oDdxKXnvpPzR0tB88PhttF5/3o67BIfjX2zS1vGknQCvVqzPICqo3jJgqcWgARi9Nc4U6IcOoc3YpII7uzimsN7jb51a60awEjCvbf221oyiz6YEjMvtohhomyx5OUv1mFJ0E/DXjuRIt6QC09CfyBSwME+5/ifgGnxEIddduBMZ2iYaMg2pRYJpYeSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(83380400001)(38100700002)(7416002)(86362001)(498600001)(31696002)(5660300002)(8676002)(26005)(956004)(66556008)(4326008)(966005)(6486002)(44832011)(36756003)(16526019)(16576012)(186003)(66946007)(8936002)(31686004)(66476007)(2906002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MStsTXpBK1Z2eEdOdStTOWtqcEJYbkl1ZG84N2I4QVF6L3BtOEM4K29iSkZz?=
 =?utf-8?B?cTE5czY5aUxEY2ljbGgzTHFZMEplY1JjKzNzeFVGNHMzVEUxTFc2OXN6c3JV?=
 =?utf-8?B?WUlDajhUTU9NdklCN3IzOFY5MmozcnE2eWxJbU1ta0FCSS91U082WFFPZkR4?=
 =?utf-8?B?Yys4em96V3BVWE5FSmt3MDhZdmg2N2pvNmFFei91QzVmYlFlRUd1ck9DeWdB?=
 =?utf-8?B?R1d2Wm1iRTRwRUdBS0o3OEUvMTg1Q2ZqQmlYQzZOWU0yZ3pKblpJeHRqV3ZP?=
 =?utf-8?B?UGpqaC9UeldSK1J3S3Z0QVBKZG0yK0tRRGI5T1ZodzNORHlsdFpaTE1xZTJp?=
 =?utf-8?B?QnFteUd6UHpQWDNLTExyZGlzNTUwaTc2SnFXVGxTZDlGVmhSR1RIdXVONjEr?=
 =?utf-8?B?ZzVsejY2TTZXdjE4YkRZdnBLZUV6alhHVlByZnVLZkpKcERrN1RySExZMm81?=
 =?utf-8?B?cy9hL01ycHhLUlVRajZFcXg4TVBEdlduYVo5NWZkbzgzbU5yWUxTOUk4dzY2?=
 =?utf-8?B?UzRLQmxEdlF5OXRMSGM0eTdJdU05eFRlQVprNW9hZXVESE5vaGtRTjVOK3g4?=
 =?utf-8?B?RGZjTU5jNlBlUFExZWhOTVh6aXVmZ0x5emVpTFN3Y3l5bjUyQ1JuYVdZRUh5?=
 =?utf-8?B?a1hUZy9BaVI5NWRNdHZSYzdUU3hVdlA4WFcrT3pGOE9kdFFXOEJ1TS9FWUls?=
 =?utf-8?B?T01oa1RaYTQrbUdLcmw5dlZjQ0IyTkQ3MnRZM2IvT1VlVi9idk9lelNVSzdP?=
 =?utf-8?B?TTJaSVJuTUxIaE9BSHg5MnQ5N0pvNmhVUC9JT1RNOHJYSFFQT2MxRFVpS2ps?=
 =?utf-8?B?MjQwYzNvRUFOSTI4RG5DMzlqSHAydVFHRlBxS3pJV1EvWUtGUEl5LzNMZytN?=
 =?utf-8?B?MjB3M1UzQ1Z0VTlSWnZ1ak1lNFBwOHpzWUNYMFJ1b2R4b09Hd0lqRTR3dTY4?=
 =?utf-8?B?ejFJMENrVDdvRGxDQnVDeXViakVna3hDR3RYN2JMblV5Q2l6emUxZFFERWk4?=
 =?utf-8?B?WElaUzRicUg4SXRCVEdXYnVXcWM1b0wydGtDRzk5cnE4ek5vclZjYXR5QXBL?=
 =?utf-8?B?OEpXcTJGSlUrYTBhL3JmSURha3h0dC9LZkRvcTdlaWZHN2tMalp1SkpYQUxX?=
 =?utf-8?B?VW1uVEdqbWplQWFrbUtNWUZiaWg3SUhDbGRpbmF1ODBXSXNIelJQWjdjNHpF?=
 =?utf-8?B?Sk9RVEdheEhqVldEaENiWmtEWmJDTSszSGp1VEl6TWhSNWhId3cyOEsrTzFw?=
 =?utf-8?B?dUZ3N25FWGI5VW9lMlByUjNCTkdEZlNaa2JORjlidHBLSkZBczcvKzNoZUto?=
 =?utf-8?B?UXhOeG02L2NvMU9RUjE2UlZWMTd6V3BlQlgreW9paGJOSlloQnBjUU5iNlNz?=
 =?utf-8?B?Wk1GNDVFV09QTmRmelJjNkZuSy9CWUN0STIrcDFWQjlBb2tXOTJkV2RtNGYr?=
 =?utf-8?B?dzJQa0RvRUYrcWNZUjE3TXZIWCtlclBGMU9SWnM2eWJOd04vSDlQSzBsUmlY?=
 =?utf-8?B?ZE9SamoyWTRHTU96R2tISG40V3BHbVpEUG5MS092UDN1djBIMWdrVUVtK0p4?=
 =?utf-8?B?QzFSeGJtM0o1ODUxNHo3eFhySlVWR21IV3Q4c2FDVmx2VHV6TVhUaG5JZmxs?=
 =?utf-8?B?bHZXeXRjUTJYN1F0YTRSYldTS1dLZkZPVllZTThKbUJIY0hoaU90V2xRU2RV?=
 =?utf-8?B?K3o2MzNNVWhLTGJHckg5RFpZSk5vc1VMZ2NZVVZuY3hiaGUxUlhxS2M2YW1p?=
 =?utf-8?Q?fW8b6grwT9eOdNAhy9Afm73rkw4lOjgSjyqMF4o?=
X-OriginatorOrg: kontron.de
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f03c86-df5b-4277-7bf2-08d90e43cc9a
X-MS-Exchange-CrossTenant-AuthSource: AM0PR10MB2963.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 14:57:40.9199
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MrHxx3U1koXnIr40CZMvxkotmMUEelwsThaR9KZhXAmJA6tDQMCWEuu10zQshxA36AtWlrkNzhEtd2kt9DdHGkURrWjP2X4VJP4wgr1TeRc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR10MB4468
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

On 30.04.21 07:27, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> V2:
>   Fix yaml check failure
> 
> Previously there is an effort from Abel that take BLK-CTL as clock
> provider, but it turns out that there is A/B lock issue and we are
> not able resolve that.
> 
> Per discuss with Lucas and Jacky, we made an agreement that take BLK-CTL
> as a power domain provider and use GPC's domain as parent, the consumer
> node take BLK-CTL as power domain input.
> 
> This patchset has been tested on i.MX8MM EVK board, but one hack
> is not included in the patchset is that the DISPMIX BLK-CTL MIPI_M/S_RESET
> not implemented. Per Lucas, we will finally have a MIPI DPHY driver,
> so fine to leave it.

Thanks for your work. I would like to test this together with the DSIM 
and PHY driver by Michael and Marek. So far the boot hangs when probing 
the DSIM, but I'm not even sure if my DT is correct.

With the DSIM PHY driver (see [1]) in place, the GPR_MIPI_M_RESETN 
should be set correctly, right?

Would you mind sharing your imx8mm.dtsi, that you used for testing?

Thanks
Frieder

[1] 
https://patchwork.kernel.org/project/linux-samsung-soc/patch/20201003225020.164358-1-marex@denx.de/
