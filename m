Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCECA3DE69A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 08:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbhHCGPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 02:15:24 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:35392 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230096AbhHCGPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 02:15:22 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1736BJFU019171;
        Tue, 3 Aug 2021 06:15:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=to4/mMPD2nuNsT/mpNnh2JQ5Z8ZDIW0eaLpCv8YCbas=;
 b=ZKs2FFFyA38zEj0gHaSe4pK28FkSoP0NjG0+7BUuHToRYhXis/m1E/pi0GZCN/7Ej1E0
 invbsVZKVx7YTRV+BQ7OdKQaK9UZXbsIVKKluo9OT980b50R2/9iFG3bKx4GZ453Yz2R
 fcQmCy9pVIkqpKWxEL6IhZH25YtYmS562QmxDfu583vkgvXR81KRgGMktZctbIGJDzjV
 Li0GocoC5mEyEgw0FmqcOS0vth+0cwv5A6jpTLXDAimWp4RL1bPp3x7u8adGwEghuLNw
 Vrm2Q/tG8pOkYmrcROGEXgifZEkzHm6ToCMb1Glm+ghp3WQplICj10WlnMvhdURhBDVl qQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=to4/mMPD2nuNsT/mpNnh2JQ5Z8ZDIW0eaLpCv8YCbas=;
 b=tHrsG/PIPRUjGe4LkKTLIhtDSIKOVxXsKSJ8o95hDCyRzQ0rzJLRtXcjfRKMWFoJt1UO
 6bV9dQHSQcjrzrtJm2d2TlF4X+QiiHOdZZRFB1R4w4SYQJNvr158ffn7ZvK2jjnwovhG
 m2BIu1de/P5Ov83ukkzT3DBc+wD3rkA8PkzQYk8I0notlTsIXRT1WALM23I4lM4BrSvC
 PoqWH67eq7jVh70LaE5tAZzQj8rauXAQaeerFW51HJeSdsT7hKbxAVyE09WnuceznxwA
 Ha/detAySnwloaTGLb+8xSndAAxMIEVITeHU8mi5PpTWXv3y4EcwQ5gikLVh6t78Jfwo 4Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a65vdb1qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 06:15:07 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1736BNLR174234;
        Tue, 3 Aug 2021 06:15:05 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by userp3030.oracle.com with ESMTP id 3a4umy2pe3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 06:15:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gT6lyTZEXiGeiOAoya191YHBAzp+Wb+Soy1D6Cjo0rCRFqL25/3RI/KXbQzeTUFYlCNz7SDfixWZiFtff3/zr+y4az3vjQmZH/kQ/kRqhiOn0ueybtWPZk9AIkKZFafW+nlP7KNBP3TCAukttsz0y0Ddget6aT/zot//fhk2DlonfiQIk5BII9ywzkTBrDwu7/7CSVkZAirOb2DL/R7w6UslR8Xbw4rNLnr2LltWK9qREQJ7WDTlBdgh0huKFcRc5039Su+4AReubsUGhNUnv0oa/H4UJQyy6Zyb+XmSFMw5kRl/Vwq+zBzQn+tPcBMjczfHFAlr3S7ZUBLZJbvSVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to4/mMPD2nuNsT/mpNnh2JQ5Z8ZDIW0eaLpCv8YCbas=;
 b=fLN+MBZCnNEXvEnqvEb8tssyIES6j19CL4Ec6FPhbVjSTGIeo2KRLzqbuevdOi+zxPwZLAblKFHLkleVw6J63bCy5kv6GjEJ+2tNpjE2oT6A45gK1IOA2m/ZS+/4MT3Ic74ctdsbboynk5JSHoc0is6z6fof9oi6U0Hd2ULY2vAZqDTc9WKLiMEWa8t6lrGN0LRIawE80Rf9eny/X/0CXWPw9vF/83FrNrQbA+8TKbVxlU3dzT5k+y7+8iKjB3TRGrTgNG34//jfa9+Y0f31SqZInRdFRJ8hA8+Hn4aM5nO5GDeWNXRbDQCFA8q4syN3fWSbd3Dz225BFgzyLQInnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=to4/mMPD2nuNsT/mpNnh2JQ5Z8ZDIW0eaLpCv8YCbas=;
 b=uz1fTJzGEvhOY8biKYu1lONNiup3HDFRcbMgYEzy2Adx/xhkdMqUxece3x+o12U7REE/j1k35x1EGtkUTXSMbJzLAGqN0mxZcMtlWXNxDa474cpxdbjgdfBtdU+RG/m3b8GevlBhSrqto+o+J1ZfQDJZBqOzGGHEnBFH0YJBiHo=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4466.namprd10.prod.outlook.com
 (2603:10b6:303:9b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 06:15:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 06:15:03 +0000
Date:   Tue, 3 Aug 2021 09:14:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: core: Change the length of an array
Message-ID: <20210803061441.GK25548@kadam>
References: <20210802203020.9679-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210802203020.9679-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0016.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 3 Aug 2021 06:14:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7ded76b4-cebc-4f80-efdf-08d956460800
X-MS-TrafficTypeDiagnostic: CO1PR10MB4466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB44667312E1ACD3C1120B51C18EF09@CO1PR10MB4466.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NahareQpt4wnq0fwQVat0VkDcIic5SlvJ87h56tm3PJaAcOR2oaCCWTeMMDF1dnc9ytT21gP76cKjg7o6HGqI38cJQbNKTEocSQUg8IeXxVEvYo9KW6uL7WiNQOhgllByvISnGOOznor2RJhVt4D3azNTXKtBMUbnOAZ3QvaMYwX3cQbcNUgTRcT3W/o5N0B0y7UI9f+ptNuDfvT7rPqFDA6ZaVBp5B3lvP9w0wSMjsl6ZNhwpRUFIvPrx5VqBED/Oml6gtb+n0RfTLbDnVF9TZ+X5h+8bsrTV93OxQXEGFzioBySj47P96hkANMscQ0KTV5zzEqGhZFGU5RKQbf7jASsM4SCG2HIvi8fsIPAH1gROo56AP2jttUNBtYrTfncYu82VGoKjBzaCgIVsopBn2yh4GYCae06YPfB6LNcV9/pIa1XO1jPiSUbaB9tLvf9oOEoddEto9Ka3eo/bbcOuvihwR0gCBeq57PAhIu+F29kp0iIang4d+WKvWkK/Cd0yDe0uC1lhhuimA4pnhi7GeyetY4q9UweHqecV0wIu8VJC1IvZkRSVTv8Z67VsII1EJTah2HmW90RbjPcdYS01HYkGPYo5/O20jDnVY97gpKOFBn+qxnWBMJ+L7kK4HKwKJ2Bd4FAjFqMOGoHsqKG33SYkPBVhmsmnnPwrDTDLdWyFF67QvRUMG6FLhpE2M1/9SpE7vr9kNhV37O0eLmXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(346002)(366004)(396003)(39860400002)(376002)(9686003)(52116002)(2906002)(6916009)(33716001)(54906003)(478600001)(6496006)(1076003)(55016002)(956004)(38350700002)(38100700002)(44832011)(4326008)(316002)(6666004)(86362001)(186003)(66556008)(8676002)(66476007)(66946007)(33656002)(4744005)(8936002)(5660300002)(26005)(9576002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJTGoLMpW9g9lyQQvL6q5Mm57y6hDAKoSNJTuM/L9ZHkjQAKxzFC0DOGH15g?=
 =?us-ascii?Q?d/IJsETzMR3kSTZ7pgJ2E0CvhFE4IJ1WmXUEoGilTgCoIe2ZNiVQ61A+Mm/h?=
 =?us-ascii?Q?3nSDxE/5l+HNs7qoQO6dTu+ePbBa9WlwClkJ24rmeUJJEc7EVzVXpHQr+Xc1?=
 =?us-ascii?Q?IlGRZq0gzcYk0y4nZSERuTvLNtz0ABydGgxWCjhf3231BvBQJ9o1WXJ6xbBe?=
 =?us-ascii?Q?pwHL+wuxeN4BcXTf4HI04fc5Xo2UVwlP+4OHFt22i4FgZZTm1s+rWYIalVaK?=
 =?us-ascii?Q?d6hvKgcDFasL2ceWbCu0l9mlq9sfHV6GUpgzgTS0rpoDNhdUohlVcKtqoZnf?=
 =?us-ascii?Q?rfFrssDLEhO4y+uc4CbCXAD8xhOd3KADtfFYIhRgiJsddwg+Q907XF/a7yHK?=
 =?us-ascii?Q?PaPHXvFV98AT39tnmL5Y4DfknXoAC+0zf2/hVo/vYr2uDJYvsiknqkYxixlj?=
 =?us-ascii?Q?zsVy3YIe17ZYltwYJMkKYIN3RGPdbHwqwAEfKojqQGSJkiJFYEaOz89mQiGa?=
 =?us-ascii?Q?zRM8L50/BiXri4EZ2kCJZVI2q2TIAvhlTDn1b61FAVv5tDmabbOOwj25DDvd?=
 =?us-ascii?Q?F7RBuV2WKeUMeK8YzTMcPay0IveNf7HHGD5Hu6jef4xSs06iuS+UAQdl+GNP?=
 =?us-ascii?Q?pHLPvlQxSptJsIYxQ5o0vBVVpAkpneuppCowTp+o4e2NImh4sZo9f3wB79mZ?=
 =?us-ascii?Q?2HKgcav8VdoX3nCEQKMQ3JO7r3G94cQ/i4OJ+7Z0deONkMvFX6clo+MmaKRN?=
 =?us-ascii?Q?qgpWEkD5bEzUVG8s5/tEyv9ynU+AcJw6mKU9v/sGhTJBtyehNpR11L0U8+Rd?=
 =?us-ascii?Q?PGBmxxZtR2ISFEy04ZQrJBBayPA7XI5LENE2NM7l/syxVILbpSnQ3AaBy7+/?=
 =?us-ascii?Q?U3W+p9oU6OStyvjxo5QHlohXhFUECM2i4LqGoSaOBLYkjZ1BTjNDGaRa9EFM?=
 =?us-ascii?Q?W+D9hHMaVD+HNCw6YbQ8wY0Nw+ew8LGVRztRuytMQdE86zzEMigIffiTl9MD?=
 =?us-ascii?Q?UYt8S1IWD99gVdJ2QhG1Bb09gnx4SrCf43llxXS25ncNIYUJYQZBfMhP5gaV?=
 =?us-ascii?Q?ELUlXgaQfrr0j9ih/CtipZOhrOvmRk227sAT5AFHC3zsT6P4UjY1d71KhK66?=
 =?us-ascii?Q?lbVzhEmKWD/nan6h8dQVlmsLYRVXAc2RbreYBRJNTaIOqwcv52Y5/4cCgZTE?=
 =?us-ascii?Q?qqWDRkUk7bGHb1gslrxPho6KZSoio6gKmwsC5DOKwHUaWjmy5C00P1NpJ+Uq?=
 =?us-ascii?Q?2tWJf1PXXtyggG0aTymzjA4QzGnlbCn4HuBC1InKMK2Eff7968bfLrN1VOAe?=
 =?us-ascii?Q?dc2ur5Dsr/S4LPs/voDCzaBW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ded76b4-cebc-4f80-efdf-08d956460800
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 06:15:03.3593
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FvfY9GvG/XtjaEouH076SC8T7GF6xQKvPssp+yZ8qtw0PizTso7MZ6GtxsHP9E6x+QYURbJrAS3jEfuhJL1PxPf66fgBBDUgT41SGd62X0s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4466
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 adultscore=0 mlxlogscore=617 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030040
X-Proofpoint-GUID: QMzqobScDGxYzJt0Te9_qLsMUPVUXDDK
X-Proofpoint-ORIG-GUID: QMzqobScDGxYzJt0Te9_qLsMUPVUXDDK
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 02, 2021 at 10:30:20PM +0200, Fabio M. De Francesco wrote:
> IPX_NODE_LEN == 6, while addr.f1 should only have 4 elements.
> Replace IPX_NODE_LEN with 4. In the while, remove the excess spaces
> before the fields of the union.
> 
> Fixes: 56febcc2595e ("staging: r8188eu: Fix different base types in assignments and parameters")

Ugh...  I really feel we'd be better off reverting that patch entirely.

regards,
dan carpenter

