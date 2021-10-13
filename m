Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB6B42BD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 12:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhJMKlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 06:41:36 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45412 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229516AbhJMKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 06:41:33 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DA15eZ028774;
        Wed, 13 Oct 2021 10:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=/k20d+E/NPPmW70csu86axzo+ztAA/NKRgRDGEApeUQ=;
 b=qyNp56igmL8pNZ0HBlNFPdvTFMZ8mxQVc6jPJsZpfUowxE+PFQ4R3XA1h7JxeGi+57Fu
 bDtZJv7jMAkxd1M66ft4mSTsXQEeY/QMfUUd3nfkcVhk1KcOK7UAR5uRYb2JsDTrqrZq
 IgsBG15lcwffCZ4d2FxAJsZIKyFhS0ZtZN91KUa6k4vhNtio39xx4wtKG0jvAaGxSfIA
 DRMUWog+bWpxnHyZjbBrYW3A0+E8QPADrV3fz3E6TDsL+SBSv27LRluis0gSivTamBOI
 e20CTawUCFPKAtahntbB0cmtpkAnKkStnuGtlpCvKbVya40Z4z6SMRLamOaypkR8gJzy +g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bnkbh2wth-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 10:39:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19DAYkmF010384;
        Wed, 13 Oct 2021 10:39:27 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3020.oracle.com with ESMTP id 3bmae0ht28-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Oct 2021 10:39:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lBUUu9/OwskLekkbNa84f9D0QxuB7cwZnMM1ZFvfRLACM1LzA5ARYDqxgMBMo4Awxjb3TDlsZW8WqmEL704FGNotUFuzSzFH2K2Bsm1380vDIb6ViMn61R7z/oIVUrhhSFQm6dZ+xYHTUpxvKR0hkNBRg9A4b4GYpvRhW4dozLRRQ8JXZ2D5s8BzPTk5YTjCk5A705L1u56eMoRgDtDoRJBGidy/zJD0p0GR2L1zG3enbVjvsgcgGJlYpnTMNXoN/hmm9w8unJ250hTyeyMnQ1YErGpbEN/WTT/GC1bso/10azYrBHfYbfG/1fZTqV/snx8gVR7TbJAFN/QmEedkQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/k20d+E/NPPmW70csu86axzo+ztAA/NKRgRDGEApeUQ=;
 b=ccNEZHBCvqeWmCggh1wkYuYt1fh/7+ooPZtkOR1sBG+hnvke75fJ/ehxrRFK9e3pFpsDUsKLAjYyaxelnGs6qvIr3ojz9eaC+zTwZKElSjnlzTlzerRAOFXupSh6nIIO3FNSo+T1gz9uuL/kWMI3qNHLLeiYdMQGpQWGXEHFx9yxcJxWKA2oU6VF/4xj8qaf0D9XbHD8mP2mVKIxdCShr5o7ttBXTOrPlof+MDqLjiB5gIjrTi6tMm/DjLyksoz9D1OnaDVOKa/yV2+I1+J4EOYTfyM4M4qOoNpLBvj/Y0bVvrLTBqDDupG1XGpIMxo5k6dQlUfVRFCsZvo9evyWlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/k20d+E/NPPmW70csu86axzo+ztAA/NKRgRDGEApeUQ=;
 b=Dda7ixPRnE7Db7YcduTibIptgqqslzh+Q2zOSlSAngLNMhrzxS1lk5M/1ablrwUs+Uac5iQNinJfiXLOcK8XD8odcOpZHaRkNsAL+R1/3imKZMNfL2PvSBrnRpGSpIfOPpPV/Fbdzsr+YLbVVoiD8+LsiOpnG7SqkbTEbl/we+M=
Authentication-Results: perches.com; dkim=none (message not signed)
 header.d=none;perches.com; dmarc=none action=none header.from=oracle.com;
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 (2603:10b6:910:4a::32) by CY4PR10MB1286.namprd10.prod.outlook.com
 (2603:10b6:903:28::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Wed, 13 Oct
 2021 10:39:25 +0000
Received: from CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809]) by CY4PR1001MB2358.namprd10.prod.outlook.com
 ([fe80::e5e3:725b:4bb:7809%5]) with mapi id 15.20.4587.026; Wed, 13 Oct 2021
 10:39:25 +0000
Date:   Wed, 13 Oct 2021 13:39:05 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>
Subject: Re: Use of '%#02x' is almost always wrong
Message-ID: <20211013103905.GK8429@kadam>
References: <b04a10ea9682c51764053c1be73d4b3be59d1e7f.camel@perches.com>
 <20211013061547.GG8429@kadam>
 <3c060010a6100aec264f7ad984d2c6920e628a42.camel@perches.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c060010a6100aec264f7ad984d2c6920e628a42.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17)
 To CY4PR1001MB2358.namprd10.prod.outlook.com (2603:10b6:910:4a::32)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 10:39:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db88c53d-f9de-4efb-cd62-08d98e35b99f
X-MS-TrafficTypeDiagnostic: CY4PR10MB1286:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR10MB128667B95A71C74C4684308D8EB79@CY4PR10MB1286.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dIh4O+/4EbYB3DaalACVW/0UtD6UhXp4N6TiFqWicgY1SmjRTYOOkyK/JOcZ1G5iKhzg9cHju8M1uePAoLPAe6xioDVa+rn/4wnXVzZlgrGRdtISxSkGmfWNoT9KnYL0NKqXtYgA0Q+UlRUn/r0uS6GnLLBx2WNB3XZtDRUnZh1EsEtznKMHhvy9QukBCzUd5orBrEulLEoXn2RLy14ev+9rHr/MrqNWSpTXBEX4rXO22IeaFTyUpUJvKlp1tOdRyeCysjMhGQNFpEx4TQTDFKwVXK9BhWrqvdXYNDFzbEyts5846sSeEAvCkGHBxXjfS/lnors1HzitxnLgIgyQSM0NGaahrVZ+qP9SWFaxLHea09Z4wGkA9XnOw8fG63jJOFrw6kX0iz3wzGxYeVjSGwikKiRd8X2Bs+j+dFD+PC7BmcUFIEmTSoPbHDQmmWamf3AetZajcXUUV/77bZrGA26DdENOibyUEqf8EbGYUW+ibI346dglcxQ5WgvMD+gVurJP69SsPMNSTELO2KaXqKsby6xsT2b0/9+d/U9cTBBzbNqawjrliO3NylUTus9A/yx/vnDg25dRX2mq+de0arfwsqWKS5RILX5C6FB0dRdDMpJk+yBfUjv8Hd6ACH84lpUIXs8z64Zs3EwKwEtq7XykF9eMYw/nv+JTmmD0c9ucbAOSx16G/B/jOPbb9Il80MyJV1bNXPo4DiUa0fh3bA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR1001MB2358.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(4326008)(1076003)(66946007)(6496006)(8676002)(956004)(66556008)(4744005)(33716001)(55016002)(9686003)(26005)(316002)(33656002)(8936002)(66476007)(54906003)(86362001)(6916009)(6666004)(44832011)(186003)(9576002)(2906002)(508600001)(38100700002)(38350700002)(4001150100001)(5660300002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iEeqt9wpEoqZtieJGZHX9vHG1KXwvfA0LdbrbIXla8akzzYCLds2BljrWNhv?=
 =?us-ascii?Q?TdI4V/G7eQVbn5nnrhdcZOZISn7mEYgfbyQZbKU98p5dWmouhH0SkM4uIV1s?=
 =?us-ascii?Q?xdLiqjEPJk/TUmiyRV2iLEJDgXd6WWZ5MPVR3z5ChUKNX/pClYIpCO8AT/7w?=
 =?us-ascii?Q?dQ4ssDJ6FnPVHoQQv6fet+WMdr8u4SqM282uKMS6UnTlZnHaMwrNJu2Uni1T?=
 =?us-ascii?Q?3J70inIF/z5yqWYuZQ64nskpu5Owazu6XapT/+sttxNmVtjhSWGvL0BswwDk?=
 =?us-ascii?Q?VbSblEUfSu3MCpoxHFq5s2s9yv+WZzy1YgBiXj0QwmU6o9FySsu8HSUWFbzn?=
 =?us-ascii?Q?EE1PkEpxCbyxvXmBFul3LuP9kYpqGRzoz+qBbdmZA94pTrOjiMHhhvOuMmA6?=
 =?us-ascii?Q?eyZqAdtsOppdXigbnWqLKcZDgq0ofRb09d6LzO/TLlUk1Cscfaqte4DDz5gj?=
 =?us-ascii?Q?qMdgmbg/LmuWwsPXzT3FJqgOX+0vGg4Vqq7Lm4D1ELpLxgBetE75UG0fnwp9?=
 =?us-ascii?Q?u3Md/RweCa3OAzY7k7/G/GF2MXHKaSk9lQxu6ZRXibHghSXBQ+MTfZj+XdA3?=
 =?us-ascii?Q?neMBdQeAUH3TBko21DkVqoJdY18XtDoLCzteTdbGd5XjnHvUFF7cSZ4Yljs1?=
 =?us-ascii?Q?uBoVRzIb0RD8IreoV7jadE0p/sn93BO4sxRa295cpQm0dnExD7nnSfYa5IaA?=
 =?us-ascii?Q?0XL2RWytdU/5tZfO5KbIFxkxiEAyiO9JsAleZA+aWDAEKcLsKv2UaVXJ3D3D?=
 =?us-ascii?Q?nxuHrsLlAkXn1GV5tGzBQjXu5zRjJyZmyJO4HBkzbYxqT7TgzHdJOSY2RUVT?=
 =?us-ascii?Q?f6nli5b2rsvPbd73ZPr+1EMiv+fTFs39EuqtGvIiJJats2e1KzdvS9yKNDvb?=
 =?us-ascii?Q?OPQ/LSbxH3gnqiFRQIpNlB72G9LMrhOP5aDv2wt8vu3gjPRIxgm8jmTc6k95?=
 =?us-ascii?Q?saelTiMnaZAXNrCg2jcQeAYGJcuQ8fKNHM2NWCIJ3M8sxdDGf89ducVU0Jdh?=
 =?us-ascii?Q?LC8P8V3eHKPrCS766BNmco/2NuALg3GaNb/+5YdamINwgDsC8x/ObfA3+lkx?=
 =?us-ascii?Q?UMtLH2Zee0mik9HFvhGXe5HvZJ9ck7z0sd+o6DtXT0ECvikHDxY3JGdo5bLm?=
 =?us-ascii?Q?IBMwY5M1RE9+4YCO28rfRbNLcVOnaZ2RV0qSA7wCM0qwOwszLjSEKhw3qiqB?=
 =?us-ascii?Q?8ppNOeJyhWClcOtc0g4jHhH/WNdfksYFPgwQx0bE/OsuizC5P2JD0Sp6CYor?=
 =?us-ascii?Q?cHaZ+QGfpPZZNTHK5IznMed7ZZuVBz5QdCNdw5L+jBffaAL6MywkxMf0WbGc?=
 =?us-ascii?Q?xOibDSGSZC2TXOxiF60zUs+/?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db88c53d-f9de-4efb-cd62-08d98e35b99f
X-MS-Exchange-CrossTenant-AuthSource: CY4PR1001MB2358.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 10:39:25.0493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A/YQSa/Tla02JzmN9aVXkC7Tlw3KxbCVyQ5uYOJA7QZFgqFselnUn2jh3w02ob/AkVTFMWccqkuyhrTcQl6pdakI2m8L6ZjWyDHX0+pL9T8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1286
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10135 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxlogscore=708 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130071
X-Proofpoint-GUID: rNilQf7qHR6CNRiYroG7a353-IGiaerp
X-Proofpoint-ORIG-GUID: rNilQf7qHR6CNRiYroG7a353-IGiaerp
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 01:17:30AM -0700, Joe Perches wrote:
> On Wed, 2021-10-13 at 09:15 +0300, Dan Carpenter wrote:
> > On Sun, Oct 10, 2021 at 09:45:30AM -0700, Joe Perches wrote:
> > > Perhaps too many developers do not know that using '%#<width>x'
> > > in printf output _includes_ the 0x prefix in the output width.
> > > 
> > 
> > This is a good point.  Presumably you're going to add it to checkpatch.pl?
> 
> Yeah.  Something like the below:
> 

Awesome!  Thanks!

regards,
dan carpenter

