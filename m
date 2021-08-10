Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 295F33E5404
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 09:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbhHJHAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 03:00:37 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55086 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234999AbhHJHAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 03:00:35 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17A6k74k015537;
        Tue, 10 Aug 2021 07:00:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=SMa5jJ70cd2nkyw3M4P6+vxdesTklS7rYfyM9JndQsg=;
 b=S8M0rbf60qlgJuqysads5Z1hfncOsekNHrhUWith99sYx3gKXtWLzHGa0KMMHCO/ec9c
 J4IiqOaankGoJnL1OayVcUUJs9VKTRJdJNd4Ur23Lfe3p0W82HnCxy3dx6b5AZNvE4l0
 qFjx+XY+LiSV7wmFKh5+A0w7jj1I3Wsf01pWDmgVspJ4yEq/lcsezhjwppKGYWU9VACo
 NGmCJW99hUOnq12q4P36GQmAq5/A10jOH4szwqanAGRsMkI+E6IBD9GneE/rIAfoIxbn
 ssvXYaXZvLDkfhrni/BtmI6yk9vI7V/mbEF534LhCoxTGw8Q6CBrsFiHZ8+4ZaEOUH2t vg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=SMa5jJ70cd2nkyw3M4P6+vxdesTklS7rYfyM9JndQsg=;
 b=Qr2683CeZx3Y/g32P3ymd+tKAQWWNHI2DqwL2kjzt1YjisUQlkeaDybptHnCIV9QvHtX
 3gjwgLzCVIaLb2UvyVyq9O8r5hfsfNpmBQCrEj0jEpMEctMg/i/ThO8jKKNQbtHeQEj7
 /cdBY8czBsjRyXi3ouK+nJf7a3cQRgTOLIwI5xGf2CfaDwssHeOn2Tn9DPlgKZu0UHaE
 bO5iwXPBW4q5U355eZmo5yh4EEOBQpl3MH1r9IZ9/OW0eMCq1jzArEPzzZJr56yKE/t7
 JR7nYIIv+h6vL9WTBkLBfUqsIOdDostz6WFYFE0tEenYHwdqRqq4q69suZm08tI80bZS nA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aay0ftusv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 07:00:04 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17A6k7x4195465;
        Tue, 10 Aug 2021 07:00:03 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by userp3020.oracle.com with ESMTP id 3aa3xsjpcm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Aug 2021 07:00:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NRN8S8t0XnxL/aBfTbXHYhN6KVRg0FxSaqi+lSxH5M91wYQdlrzQsONogpKyGVEbpZ6DknPHkqNyieNQKYWbs23gDgy+XE8pp1wUpVTwoRF+wWS77JoSYo1V/jpM9/p8OQhl+N+s9mefQHbnOzyn2kHddCc1kkpMMty2ssEl6NXCodqXiqgZtE6p608j19gnskn586Ctr+B9JeOa7NSdbPg8v+iPEAIsBleJ/H4Y9Wl76ORAfp0iBQB32PhhDNpy0ZA/5tMyxtEiASVFYEyuPkra7w7R4BfC2ghqa4a41l2zk9xreGgkG+EbNdAq8pNvTLx3K1R9t8vM4JHazeLUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMa5jJ70cd2nkyw3M4P6+vxdesTklS7rYfyM9JndQsg=;
 b=cC5D0oyt92e8Z3/4QhVQRc6jTUCFDMKnwBM/bxobao/TtneovMxCbK7uOWxqU9ErizPLZKnC1VeIj7s/EjCEaWRtfwAYRt59pUtkCH/kx2yPXEtzCTffh2GNFlburDFL8Y9v6rQ2ZcZHtbsjEaC8d6U7ExsIACMfw/V2sg9f2zUCO+lswlKVeigInZhCeiL53/NZqJXDwk0l8fFYuN8+gW0cQ9w3MuwpP/fgbncFjhl1jNRPZu8MoWXAQIiYUS5nZS5BXgKe07xvfrPMHwnvGNhehQbVMNAgnxdDgSF4RCl3JM4ff4L59pY2RAaYlTvGIGKq4WU00TPuPPJl4ob43g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SMa5jJ70cd2nkyw3M4P6+vxdesTklS7rYfyM9JndQsg=;
 b=y7OVh+g/rk77KTnTS/rrMoUGgvpKxlfqxxMudhFLDSIogOt1Np4sLJkY0+3CudGdoC1/X/+7jlquwAqsed9COAz709v6NTzyDXT5mhe/cjnn5GtX4GjdwfITaHL2M5/S8SGicy9msZSF5I9FSaPItLXNXyozbH2vItaNi719r7E=
Authentication-Results: lwfinger.net; dkim=none (message not signed)
 header.d=none;lwfinger.net; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2317.namprd10.prod.outlook.com
 (2603:10b6:301:35::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.21; Tue, 10 Aug
 2021 07:00:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 07:00:00 +0000
Date:   Tue, 10 Aug 2021 09:59:39 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>
Cc:     gregkh@linuxfoundation.org, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Replace BITn with BIT(n)
Message-ID: <20210810065939.GU1931@kadam>
References: <20210809182006.29452-1-Larry.Finger@lwfinger.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210809182006.29452-1-Larry.Finger@lwfinger.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JN2P275CA0004.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Tue, 10 Aug 2021 06:59:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55ffe59b-157c-456c-8cd0-08d95bcc786d
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2317:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2317E07DC8E64CC824D291FC8EF79@MWHPR1001MB2317.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RDl6kpE/FEGW9qkt4ORIbiL5mxuWA+CfuQgd0Hi4B4wDuP8IZsTTK+YRgnLEfk1uPXyZyJVVg8bZZkq81XedARKTQeXh/0dLIBxlQB22wIABmCUXY7uUXtbCdsi6LkgD3QDJ6BczOnrIA89LdFZsEcWENaKRx3XGkUlhRxn8GKZcfAwQ2his9aw6+lddSi9g6ULiw+Ep1zIAH4K9PVPLjHcPIM9VCoIqyyxGLc0rahexYmisvdmOPGcMcnG0uHzTVP3zXtcJRfbGWQ9NhVCxFcRv6t/iP+mzmr4Nku5KV1eaDpTUN9WSVy2OAnsrOFDtb6gzHnYB7ZO5aJGQXeTlT3Sr50+DiFvEu5HowVvvsyM68RUlYpJtK4qRcY6of8M0SXBAhk05Nrivp2U8lYOkm+Ueh1XDJNKaK0jfxHJW7ySJeQ+6e4sLMUoO7zQ1Bmwe2/o+n0X0np9YE+JAE9Djvya7xDt1CB/xIE549nc30oqghpC8X/Lgv8GG3N+rPsEK6BnaahFDwwLt92YSHoG7DUBWCF2jLjnCLngs0NriHLs1HpsR1d6RFDL1lJmc37KcS0OGVUmvX6juBDnbE/yRF7kJ36OwJnbdTFWY2Q99zAmDntitiRP3Z774H6aBVm3QHgEOcV8kgplph8hR/wPpiTMSEtJ8SVqtuUZFZO3f0f89y8uZA3vkpdR6qZZDqvVnLf3rhzHaucm24uVNPUYpzw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(396003)(136003)(376002)(366004)(55016002)(4326008)(316002)(33716001)(44832011)(66556008)(86362001)(6916009)(66476007)(8936002)(9686003)(66946007)(38100700002)(38350700002)(9576002)(8676002)(2906002)(4744005)(478600001)(6666004)(5660300002)(6496006)(52116002)(26005)(956004)(186003)(33656002)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KTJ5SNR8UUGwwt4LjBCHgng7XuZfgolRP5AO0YOE/QWUkde/ibMLUSv+sLD8?=
 =?us-ascii?Q?aPvS8u8gfgdc258IaK/2lwgi5K7lyPJXlZ7Af5uUKfZKt0I6zlOsNYpGepgK?=
 =?us-ascii?Q?KcNuqJOKIO0l1RYl4UWWwebaHPnnjxugRADMDtExWzbLJXVIOZvrWmC3l10T?=
 =?us-ascii?Q?gj6WTvZw2FQotIIINQ1G6CEDS5j0o1nnacTzBx8fW6FlByDYwjiLIXgyO8WD?=
 =?us-ascii?Q?EVfFjAE0fEAY2ECroPi9qv6T6rdarytC8I433y4ACUEhiXei9LXwbTPjBXDz?=
 =?us-ascii?Q?YAqyyhnIZbW+6jpWPAYXbFAUrLCxK8n4ml1NRi4U9w0qHELlHTBI3vrxltbE?=
 =?us-ascii?Q?4z9Fkq1Zbu45xDGnNCeDMNRlqF67404lMA7/mClrUDSnswtvnrYrEPzNbWu/?=
 =?us-ascii?Q?Ym7dowSq2+Oz0EAXX2mnjC+IJCuBsG+889o7XrNhE5eN7uRRDLdvGlFEaOPv?=
 =?us-ascii?Q?AcR7otLrO+K16dh4P2SoVL3GMWAJmhHS+I+l35UB8JOrxB8aZAfg/vGERpvB?=
 =?us-ascii?Q?8sKxkQoNI57O4Zf1bvkgdjjPd3x1+QfNLIHbaytYEAV3R4kBoHhvT9ZhK3Sr?=
 =?us-ascii?Q?Kewl5J/HKQMtPoqBuDmH815lYKPc+Dtr7LfW5CYJJn1cK5baHMrVUFhU7WIe?=
 =?us-ascii?Q?33hUkurqFOanDPpuFqM6DUSChPD8h8A8n560kbpianYf8Q7/aAVsVJ6Lu/uf?=
 =?us-ascii?Q?1xMAbL2GO3PxFXGBOIDProF9qHBJDPt+Hv0yYVciXsCn3RJzQLb/KKb4fkdK?=
 =?us-ascii?Q?p7Dj4tFBbA0X2EWpj1AORrGV2CXvxtPZlgpH254Sq0d+E63GreTQU9IIOjOs?=
 =?us-ascii?Q?tz18MB+mSnYVgpb0lQljFZAa2dfVGnUVwrXp/6lKM11Vr1ZIFUyaoJV5fWxg?=
 =?us-ascii?Q?rQ811I72pI+IXrAIGNzoLg54UEWf13qHtUaULdq2K/lZXOWQ57CtlR8B91Or?=
 =?us-ascii?Q?Ts7INsrKzMzZUqwk6aD8DWZ+NWKy+SOAlZ9LFw1izWeOZTvju09MLUDz2YIY?=
 =?us-ascii?Q?tr4lFxft440/3My+/S+4spelf6pzFpyEZ2NBvo1/w18rprd+4252BQ53mrcQ?=
 =?us-ascii?Q?20peGO8qDcmIsk5+kA8uyPS8UWft8X0TpGVLjP1/eBme8D5EOulI6tyi5G2O?=
 =?us-ascii?Q?LDhnSG/1evmoCHNjg1mgM9FwoRefTmMTyafkNnk9MnMT1/CxXJg+Nwm19aw6?=
 =?us-ascii?Q?0EL+a++xKABw68fS7+eleTVjHGBL9azml9ZJHZZt8XG0h37jGr5cojULXKgg?=
 =?us-ascii?Q?INYTZCRdCi9J3Q34ZBhflAHOkAGDKTQvq0YT1E+CtlaPB3xIwR4FnjWkRQW3?=
 =?us-ascii?Q?R9dFLN5jeYqv9l0dT0aXLFv5?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55ffe59b-157c-456c-8cd0-08d95bcc786d
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 07:00:00.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hwupoYsA66g6IXlWV02DTlbLtyZ4zAa2NluSRYEr1/h90Y+NrrUygRMExWWVoSgU0bbOW5cZWMeNIdiqFMz4tuvLfqrHDWsIJ06fw0ijRoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2317
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10071 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=729 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108100043
X-Proofpoint-ORIG-GUID: 2BKfUE66het2QNyztjGvVaP4HRdTJYmu
X-Proofpoint-GUID: 2BKfUE66het2QNyztjGvVaP4HRdTJYmu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 09, 2021 at 01:20:06PM -0500, Larry Finger wrote:
> -#define	IMR_TSF_BIT32_TOGGLE_88E	BIT24	/*  TSF Timer BIT32 toggle indication interrupt */
> +#define	IMR_TSF_BIT32_TOGGLE_88E	BIT(24)	/*  TSF Timer BIT(3)2 toggle indication interrupt */
                                                                      ^^^^^^^
Typo here.  You can clean it up in a follow on patch.

regards,
dan carpenter
