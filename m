Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6E603DEF08
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236364AbhHCN1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:27:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:60684 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236245AbhHCN1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:27:35 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173DGRuo012624;
        Tue, 3 Aug 2021 13:27:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=L6zsiz07uHFBN1emnTUGT82hdJ6cNvcbJws13soFeO0=;
 b=lGRZEhDgQSnG2HNH7dHaPWlhubgf89d18oiId8IwocVdl3O4npUQMMHGltoG5iBySD8j
 m5NS9Rv3zyhOqGn/oNPCsYR1V7ACGcfjNHuKI3NZ9U3qop54P61Y0zVm0Ub95GcUWJPV
 7T0R2AkEpvPErsoBFvvRtAcv1m6XIXXRONg3XQiBMoGA7+mYgbyBGuMg78YjHqIWKMqO
 tiOhdukAkzPPWRMm5nymzZL3DsKFG2/6o2pSD1V70goCfJI3RkWOkdc6+SxZbV+EjccU
 Bb7LV/N8SQynzoObCbcsj29COlvYRgwS5WLWsQrShavHidCqwpK2lMNpexiku4qQOPU4 Qw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=L6zsiz07uHFBN1emnTUGT82hdJ6cNvcbJws13soFeO0=;
 b=A7fCccMabR21AXdVqgtOSdIEwLiwFy9uRU4s5wsAdZ8SQ4dYpOcTdSVrODmwGmWevIUE
 6y44laeD4byQggpJlvqlMFv4IaJSR72GYM6ToGQUJ45MbZasL6sCeqSLlKpIbUbQ3Xl6
 jU2zvUw6ySyEGFmhTkxuEoA1tgorm1HCPQhPQqX15z143NtCdrAaRJq7bWVfVrQS/Ccx
 a8rcbrNTXyVzwUROW1LGELG0iYdxeFI9nI3gt2L9sYFW4qPMCdKIptYyPMMT/We7MGeb
 lhuJKKUzFOLyIdB+wl38nmLf0bcS7q17Fjy/uceakPXw7XMVdHWr3EanePMztNk3k9WT UA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a6gqdb48b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:27:13 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173DFwdM148934;
        Tue, 3 Aug 2021 13:27:12 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3020.oracle.com with ESMTP id 3a4xb6rakm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 13:27:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F+GfM5neEleNAvIEZBhq63XO1MWr2mLD4Cf7gMmnbeprV8NUGnnjVcNU9Y6y/FN4tFMN4qnAjeKtCo5pbkGOJsLn3MKmN6aaL9WKqUTqLf61GmH90HynCGfrb43IBKy2JIMIQmMXmehvvTdIf4pE3348ReHpXWlJEwH+MT8XyR6T9mLcpAdZgDbZJ9mp3409SCxI1aBXKILrZy1/n84OL1tEjBc/7kNc8A1xJDB6BIkzCbRScg3ehxqjLsDWi0yT8zJ1Jk0a01OTeQ2XBMw/6u/UFNgYUOXG+UXlk5PPOoqX7yg6BTBcGMr8ph2b67WKKF9Iju+IPhqHQpYXTYb0cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6zsiz07uHFBN1emnTUGT82hdJ6cNvcbJws13soFeO0=;
 b=k4fwtrsw0WhkbOt0+XGTlVlA89YBgoBOryK1GlM4rQzsdwqc0N0w/oS98x7ayy7aI8LyMpHG5Djk3sKeAHEhqI26nVNXRco1zSTU/VrY8LXguCVU7b1xnk/wZvp+gbkCg3oeOJivohfAwChWnQ6ZjyXWwUebrYM/925pHsszrCPHsajWvlBfx+LxtuL0+zVEqIXESVqeOUrH4mSu70T5jXST1DGcBYgVwnvVX8m++Z+ETEgzNgwy4Ni/V8t/T7U/UxvzEw+iDmsbLGEG/jwwwFfrXv6ruR1hTYRCM7ZKeUGYKtaGaB2hfOBu8CK/KK2HD36r5ZlJLiq0SZ4YwIKWZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L6zsiz07uHFBN1emnTUGT82hdJ6cNvcbJws13soFeO0=;
 b=D2z5Bx3iiUBkFJufVvtePpayyaFY8cwxttt8d5t4asWUnqx9MZq16hSrEgPEf4xS3F05iHzEtAO2+LSQHiGWaKV2q8rpDhRbhGZlOXgk1gci2BYPsEK5dRFutsgTEQpywBwx+bL+LjJG9XxtM1mu6Tejs1IXGlDBPGFOb5muKlY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4434.namprd10.prod.outlook.com
 (2603:10b6:303:9a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Tue, 3 Aug
 2021 13:27:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 13:27:10 +0000
Date:   Tue, 3 Aug 2021 16:26:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: core: Change the length of an array
Message-ID: <20210803132652.GA1931@kadam>
References: <20210802203020.9679-1-fmdefrancesco@gmail.com>
 <20210803061441.GK25548@kadam>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210803061441.GK25548@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0045.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 13:27:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef12e6bb-6d5f-4602-b71a-08d9568265c9
X-MS-TrafficTypeDiagnostic: CO1PR10MB4434:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4434685D7EA338810B3640E88EF09@CO1PR10MB4434.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mzqdOtG6cqYCxnIux1t1Z8+du2WWTVoQhgA62cxizaudyXRNfeBzGngiVw5ILJXI5/MoEVRNTGChA03Wm4hCXLCXGwuT6zX7RR7jU/0SZBuuDZpTQM9ZVfZFrLc+K7hbtHyjg2F0E9dizrMME58TMy/eG10YjE6D3uSy1sPafmNexz5Sut7xzj/a3j/K8XPRk/0JPgN0IBVZ936lNgdUpe8MF0dxdEMCcJxUHWZrIVeUX56py9sR90lUyePqgR1o/+BTDDlXCKfuH6M6doQPkagTzF4RVVIwjRElz0Kw2ZXtiSxWL65lW/qeZJPKtWM2ptLMLHpRxiNRmXlG90pbKSn3HZ3xDPOGtyiP3sxRaPsFkaqCzDX7KhzncG9liiTdPrBKqFSpoKORYgwe7U38eTEyjPhLGFvd8SilJXvLqJbGJ8XuEuyQ/key4l7iM3vye7CDEocKhRUcRcbIhWAyApEupwyjY7UWNhl7wL05qjf7I/VxTVmXIwCPrLeOCj6kKJn/yDL35+Cu7QWHD7r//OCMTTOKbvSwy3ugiDT3LzGwrEEVaF2jwKwrebCLzjjoygIZe+/G+szntTV87/AaYJ9vybQoWvpuM948z6sVjffEjbV48IRHcVTp2o6Ow4XZZroNn1SYjG1XsT3MjYJw5AQUzWlUzPwId/oTD+mYK+I5T5NJtVctJp4j3ZS9w4fgO+v6JPmsgDudXmFDaDFBbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6916009)(4744005)(33656002)(66556008)(6666004)(5660300002)(508600001)(66476007)(66946007)(1076003)(9576002)(4326008)(86362001)(52116002)(2906002)(54906003)(8676002)(956004)(6496006)(316002)(8936002)(33716001)(38350700002)(9686003)(186003)(26005)(38100700002)(55016002)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kUMr24h+b3lM6p50PApw7Vl0vvoSsfRTaXRvuiba+E8+RUSqxdXzK95jIoS9?=
 =?us-ascii?Q?f17oO07EiIcgNfTs9fhrhTFwwJk64nrZqCn5GyMv0hjSTZz24pVFrVJtBcD3?=
 =?us-ascii?Q?7uJCct+Q98x6b1L09GF3iY70sg1KWEmOhBSyJvcWWwPSv61h0WrJyIxdxSu2?=
 =?us-ascii?Q?90SwVXHxRj1hnHQ9fWBPltPNl1VDCWvHFOWS4MtK3cPNdtQBvIk8e7pxSMvW?=
 =?us-ascii?Q?XLI9IWaaA8c1Xa+EXaqQQRJ/RPSOEKRMTnP8iFgVespdfPXUt4+xhn70FMz6?=
 =?us-ascii?Q?ybPLjfXxy8BfWb/+tQD4d4p8BMI9ixu5SRCMnEsjo5hzTzJsXmLeHAdfRahi?=
 =?us-ascii?Q?a4biPUDW+8/IyYwe+TfDb2SvfJ39QEyo/RgvIR02yVVmPBpWglL38PJXNOjM?=
 =?us-ascii?Q?Q1EdAhYscJssKaSW9/o5wzA/hjffBstKSY+eFFgfsD9aHE/DUE20MEyP+zuH?=
 =?us-ascii?Q?WUm/CgWZTde93eqlsIyg3lLrGYfWohb/Fqh5xcrAmfP0h3RrVaswP0tMnRqI?=
 =?us-ascii?Q?4G6TDLN+MkkTCuetxtt3nTY0f0aZpja+6D0uTppd6oBSF3zLRXhiqwC2ZS8j?=
 =?us-ascii?Q?VO8FJBhJ4mzdByCDmSYfAtYdajhDPhS4AgK91wuG1uUp1WDXL73KUEDVxtRr?=
 =?us-ascii?Q?1O2yd8hl4Xzp6OyaqkKTHgNFOaHkiox/P1uf+5ogoHTWtNVcOkZ9d77UJPaC?=
 =?us-ascii?Q?ZOlEQdn4jNVaPpatfxddde9wPEPotN+b8VGobr9Jsifur6yJqSxZoVinjJqy?=
 =?us-ascii?Q?TT86WO3SGMtaY2k/cLkLkakB6sNG/CO28ant8T+e6NqZ60fqG0Zs9Rsy5ZaS?=
 =?us-ascii?Q?dycF16QgeErGZt54KnZ3qFaIyvqWfW4Y0DtLmpirWWWFS7ijJL5Q/v2hXB+G?=
 =?us-ascii?Q?+Gnx/AF/GzE1qD/ocEYutuW/YpiMk0kHgqvhTqPsB5aeyzRqrUjiG2CEiIse?=
 =?us-ascii?Q?ma1QY+esXlAHunWtKElhk1c99JOlzD9nN3JPD+PE9QBHGGvU6Cclnfsfiyiq?=
 =?us-ascii?Q?fNS/qfTdSxpEfKXgvETQGVngbkXZwT2ETvN8YYU9ZQw51Ndq+NCBZpP0IeJF?=
 =?us-ascii?Q?H9M6FyKrshipa0+1OOaZZ0a3iSOVXgwo2UG1sarzFPw7SDkKrL4v2EEoE3O9?=
 =?us-ascii?Q?KjgTOpviCBYQQ3GatDPSDTsSGCk7TuscMXreOVWmTAYwXQjHhZQQecCxaPez?=
 =?us-ascii?Q?NsOqYwWCV3TdbVJMBHX/bn7QTKXYsNgvvZUOonYnWMpCVTNzGEWQo2vMKoGp?=
 =?us-ascii?Q?0boXDEPyqjO9DoYMDfMDMU9EfIbuPiN24klMpXMD6AiLDV+biR9TLGOleKL7?=
 =?us-ascii?Q?mErPc2PMN3Ot/y+G3Vezt1aH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef12e6bb-6d5f-4602-b71a-08d9568265c9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 13:27:10.5779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r7vhj7TIQWE4rl41G4sEiQbfAQ/9uh4rrdEKNYS1GIWyAp+xjnciI5C8L5lkkvqj1paeuN6N84AvJ/a42BqM64QF3QuHGaLF4uW4mAWi0QU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4434
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=671 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030089
X-Proofpoint-ORIG-GUID: ot47E3GcDvN2SbTI6MP01nU1xn3wsSlU
X-Proofpoint-GUID: ot47E3GcDvN2SbTI6MP01nU1xn3wsSlU
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 03, 2021 at 09:14:42AM +0300, Dan Carpenter wrote:
> On Mon, Aug 02, 2021 at 10:30:20PM +0200, Fabio M. De Francesco wrote:
> > IPX_NODE_LEN == 6, while addr.f1 should only have 4 elements.
> > Replace IPX_NODE_LEN with 4. In the while, remove the excess spaces
> > before the fields of the union.
> > 
> > Fixes: 56febcc2595e ("staging: r8188eu: Fix different base types in assignments and parameters")
> 
> Ugh...  I really feel we'd be better off reverting that patch entirely.

Get rid of all the unions and the XORing at least.

regards,
dan carpenter

