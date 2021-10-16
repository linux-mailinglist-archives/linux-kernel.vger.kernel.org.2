Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A26E24304C5
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Oct 2021 21:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240918AbhJPT2n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Oct 2021 15:28:43 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:58016 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236778AbhJPT2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Oct 2021 15:28:41 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19GGLoeq003947;
        Sat, 16 Oct 2021 19:26:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=fQxrEODUMF4JM1o6CZM1v+E6nmvfXWMuh69fpgTcaN4=;
 b=GBiGPdJnCEoKLYPdayXaZIjd7Ud6VmB/BikRdQ3Cw7nw5tYWzse0gR46XfhcYfABLJbO
 hOFSA8VgxiN0XnoDJE4/cL/Dj9aywO4Vz5Z3B+Lqouf+9nFxCjfY5cSAsEsDJcaSl7rS
 KpYVFcsK4vOFGc7cu0oyo1l1s184DKGojyxcu0DrBmm11Dyx0E1in9CI0jT9685Ag9A1
 yt5YeYjvilC5DzNVOJmZOnt0OgslMcrdk7bT3HO8Mjz6QHUG6DkdBqlqIoCuHe3dy7k2
 0XgZBmVemeCC7uqwOnze3H03ZjAcS3lPDpvBWVx1c9imrOjOWM7n1cBPnf0Pwy3RAbSv aA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bqqj6s8e1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 19:26:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19GJGdx1133595;
        Sat, 16 Oct 2021 19:26:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by aserp3030.oracle.com with ESMTP id 3bqmsbcerp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Oct 2021 19:26:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N1FK2xtgVJVavx48F/X2xIHOhDJSr1y35mOpKCBpk3lG6XDldJsQK1mgCO21BzBxh8h1IpkD4PIYAMtfc/VypLt8RW9s3RfjoZiwOSW/L9iBhV7fob0RsjOz9yXIGCwA/k7Y9HGjL8JKz6igcS5DofOnPRRKouPKwkt1u6OBafXcx3blVIx20wSsSuMIEc5RFeMZveIuxyYDa0UvmxN4LEGCafj27lib+1ojNGCqJSurKQFL2DAfnrqkvIBlk6cekGBBRmF5ZYpB90Fe8Fpe+Yrb/17TvpXPf1XIo+qSMr2YEAhoiiRs56ioXD7qxK1Mbq0mqRqonGtO/mK8ZiANFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQxrEODUMF4JM1o6CZM1v+E6nmvfXWMuh69fpgTcaN4=;
 b=AniJoEX/rsSKtntYtbSxxF7G8qDFMBAjwwKxa067pYZXEDDh3LlxVKU+PZ//GVus/x2KyBA8UJGKCkpklruXO9oHCqvn3KGBcuPtvjQ0qlOTpYtcNz8HCMGNiBnEhEwbtcYvzMU2rGtBM/wTruwrdp5RnBLJ155K+VAf3evSYrQ6wibRjo9GuWshoiNUWnkrNa7DUGHDX76Iw+8or98F4HodGqo4QsfVZKfHtUv8CmCN/UrdC5G0NZH1nNABL8lfVhMkC4Cx8VMEjY7u0O1A3zg4IWoEiicbBdGZduWR3kHDvYBrvmpctgMO+VubCTHKZwWNLRUxoewRBCBhm+blCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fQxrEODUMF4JM1o6CZM1v+E6nmvfXWMuh69fpgTcaN4=;
 b=PNgU9UvNNNLeaCQCS/Gp/4hwnqVrJBj8sV7qDDC1PjTQr+E7sfQ8PAD9wgBYRkVcqYSVMRd3n14soU74VFep2KnRs4L9WKtTrj1IvogNjcFUlMklceCX9Ki+7zypFVe2RvvLF7Iy9AMFzw+TTxxWtJyukqhzUOF+mwEmYNp4aVw=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4547.namprd10.prod.outlook.com
 (2603:10b6:303:96::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Sat, 16 Oct
 2021 19:26:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.018; Sat, 16 Oct 2021
 19:26:22 +0000
Date:   Sat, 16 Oct 2021 22:26:04 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] staging: r8188eu: Use completions for signaling
 start and end kthread
Message-ID: <20211016192604.GV8429@kadam>
References: <20211016091042.19614-1-fmdefrancesco@gmail.com>
 <20211016091042.19614-2-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016091042.19614-2-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JN2P275CA0019.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Sat, 16 Oct 2021 19:26:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a52d60e9-383a-45a4-64da-08d990dad604
X-MS-TrafficTypeDiagnostic: CO1PR10MB4547:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4547FB431A96D6ED1F228ACD8EBA9@CO1PR10MB4547.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: na7LvnHZLgib+foPQuFBAiNiXl55ILfhTUFWaYfVouzPVU00y6o93/M8+CRngPwS2v0t8orwGWLL6EatyqQAtxUBuzss9PuW/KHyeJ/hwDSaepGunTmgo4hrcJWdUcedcfcqVIuuPUiCjuwIqVY9sH9DcbIZolY1fPUdEr0/Wr1TTqmEULn/kHSGNZJUGxZTlM28SKCwJMseypWyH+Hp/aorKur2rd4xJ5O6Fu1198oWKahbE85cGKqUddYpMxnr4/jvrgc7THkbeZq6Jgz5fxtbX23K+S99h+zKT/nVb//486Ich5YG8GCFZ0HVJd/DGqHxYzT9Eq1ERSTU+9ev2f3Yhz79fL2ccw3Mi5BY1yVvkJQCIa2FvUHy8FcQssGBUea2tcgX1HI16YsRD2qVKlD9mLuixCtSyVKxax++kRDURBPGbJPxTCCp3p5HVjGl0RAWL/NcKzsen4y3OCiuVo4bJjcpoY1sv1QpOV1TKuwhvj89Gju3Lk4LZTiPfgx4F+uA5C1pQmOxNOCoh+b/Gx/dgPBf5UzUvTs4Tt/3a2IOTsoN4yG7GX6qzpy8brRCsaTy3vGg9Y0LUVSg5yWCZRLF0d/foZ7UcAmKAjhtD49Yow+jFMmA4Nbv9CmxIayAI871PYNIuVb8MFq8mYA/YkgLQ3w3fgjBdQHclz7rVF8yBKXbtnPSUSDpouJZbteh2+lA291/WvSMTACJr/Tssw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(558084003)(9576002)(186003)(2906002)(508600001)(9686003)(1076003)(54906003)(6496006)(956004)(316002)(33716001)(52116002)(5660300002)(55016002)(44832011)(4326008)(6916009)(33656002)(66476007)(38100700002)(8676002)(66556008)(38350700002)(8936002)(6666004)(26005)(66946007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xYEZPhLBpfuQyf7eItFvNfgJvlI2qjy1PMfwwOs8y/Ar0ehsAjjEoK277pFj?=
 =?us-ascii?Q?geS/qmi3x6XjYJeCi5Nb7hZSIESj46Ex3ceeBhYXeBho82sHiLGz0nyrd+un?=
 =?us-ascii?Q?ho7ngmQW7i18sx0wntqAtS55Vfp+A0vDFG/4UuZtbtWEgovhnVxT5zxQlr7a?=
 =?us-ascii?Q?YjeOLov2zuPduEsbQndS4tWaD+DCzVY5eB47Q87i4BcvVdRNkkblzH3yZdqh?=
 =?us-ascii?Q?N2/E7rP+iSXEaqUI4RVFZrxImO7+irLKuTaWsnK8oyS+NlxvShGWNILAUN0w?=
 =?us-ascii?Q?JXsG6d8qqSOdl6WaeciJHe79qowI63u9+/S7on+Cj4YVHKaz+aZSt5R3wg89?=
 =?us-ascii?Q?ScOw+yEsKiwUsJyvPV67agrQQYWD5Kq5MYFzjJNGAJnVk6+OHKFkA6I1qDgS?=
 =?us-ascii?Q?l9IJDYWE8u96iosMwtFqswKmoB7WeqqbAfAOR1ABzIH7KdT2zIDO1GrgrFCR?=
 =?us-ascii?Q?pI8tUitzmWqa59qnw4ZEPW86zVgfCVys8GdGOoLzw7pvYCkbh3L6r0bHl0+q?=
 =?us-ascii?Q?lWw+/ST84eGkqwEm/79HrCJRwQmczsWYLq3sdkEgpFQCaj+FPN7CTwbBMpe9?=
 =?us-ascii?Q?ZdODJcaMvPmbfivxcbImGTOG1CjWMW4ESrI3jBd/T6aREsmOk/BiPsG9bMbE?=
 =?us-ascii?Q?gPKJ0GhoT1BhmiGGVMdquuNLmA/0g4zVMzAjZLafGf+HriDP+WAQKv86Gvdx?=
 =?us-ascii?Q?OrGhY53w0bcorucF06UxmsF8fiM//Cb6/ZODx+pHacMqemW3X1ZqMqH1ifPl?=
 =?us-ascii?Q?T4QcxcFmfm+Ef3+XNbxX9PCJyFMOVSDehq9Zi2o6RQA+WyXFVv3atXfGXd/z?=
 =?us-ascii?Q?0nrdwDHHCE7OvblqpjSHtwStTMGNQQ8a3rgP8XO8a37Fy0wRzwu9+ifpsx97?=
 =?us-ascii?Q?CNHcIP61MkjcthMxMFLhI55H+M1JBk21oK4FjC+nR9kMGAUvKNgYqTrjHwBL?=
 =?us-ascii?Q?bJBA4KKqkP9mivGQcq2T1rsIVdYbp6B3RjT+411Iq3f7W1ou9jTrZTt827f1?=
 =?us-ascii?Q?up7Oe3jSCWATPokdA09YG6fxTueHkOlsfk87gKbVWleFdusCnHj8X0LmzI+2?=
 =?us-ascii?Q?5iBGrqSMy9ZSP8Dl94zRLb98881TSoPbSy2Z73XMhIoIEV9UnLFrp+GIzlvm?=
 =?us-ascii?Q?XBo4ALybIZfs18axIPfPhnwrxRgr5eOkzQizub+I5c4Ijk7z2ZIGMDjLR5qf?=
 =?us-ascii?Q?5J7izrU4VCgQSo3o88rS7ttfuXwGLirWzKe0xYYz+VMrBHOBDIv0MKuNwIhM?=
 =?us-ascii?Q?0A2y6PL0BS60bFrGdzMzeIHfHvmd11dpHSdmYE/La94iTQ0C4hng0Bg9faO4?=
 =?us-ascii?Q?B6xGgC3rxPEVMS1XpR0+MlMr?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52d60e9-383a-45a4-64da-08d990dad604
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2021 19:26:21.9896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VuTNXKmCi8gNxa7i125V5RgOjHNy188mTX3PL1MeWcx7H2lgfovRygI4urSS8ZLMRdH5MRLjr3xC0STnmv+rkB9eir5P9BFmHYsmtd1D3XA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4547
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10139 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=790 bulkscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110160131
X-Proofpoint-GUID: U9o_Q5YD8CE-h3OpA1pKU9zlMtIZ5Nwo
X-Proofpoint-ORIG-GUID: U9o_Q5YD8CE-h3OpA1pKU9zlMtIZ5Nwo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, you're right.  This is fine.  It's a bit confusing how Arnd
re-used complete to start the function.

regards,
dan carpenter


