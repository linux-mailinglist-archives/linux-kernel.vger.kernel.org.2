Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7865742EA34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 09:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236042AbhJOHd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 03:33:29 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23564 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234603AbhJOHdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 03:33:25 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F6N2JK029664;
        Fri, 15 Oct 2021 07:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=4NVHrdWMwZ2PwBMjthP/mVGwcssJguiM4yR5CVPo35Y=;
 b=oUPxAy3Weu744bImtkyIjxfxo5WR/f5vBcOCY5+z2NBeuhkJKGuuGq65/SfwraOwmV6L
 RCrC8WjMVtksIy2W0coBmmb2h3ZD6trCsGNcypt6nTYuExQvUh5JSJ/pjMldKJUv3mHZ
 BZ4sWOGqiOxsrpi+7ETE8TH3LISiX7mINjzf9QYKkmainRIJ6eKRf7tvkzyecRZQo24d
 jqDSuR0hgkxvmBjElG2K+uIohMwao9LDz1HRMShNXHAoCYcjc6cdDJ9PNJF3VtLVyoOJ
 CV5qGfDruxWurQiWrQqhX07Kqei2nqWsYiYJdOrmcMijOuZeCsZnxpfHUS2K6SflLCLg Cw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bphhue5r8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 07:31:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19F7PG2N102647;
        Fri, 15 Oct 2021 07:31:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 3bkyve27c9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 07:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xn2seETxXSQsAWxTtfCJjs9z/bsEL3yi3CBggnuzi2RbZ7/7XlgY8Bum7XFnAz/NcelT6yVZNWPKpErwdjlRPULcbRdtqHvSvhXo75SbtP3bOqS2b/+t11wiEIhqInxlPtd21YNBVjLLZSRwEC0UXeLTxyDu9Vc7P4cGjKt5HNRKoxDPVExL9duBEbjKiLDfzqB6XkAUn1vWG+5NsN1t1jrTdICMkhhobXnjHXMsCR/bJQ4lzSmRziIvspXM5uq1vLi6UfZmnKPuMjI0tolPX7hDilSGWcfwo1K9rgh5UUrm1SgnhyziRboZi80/eDq1C9NCYcsJyON/kduXLSnJVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4NVHrdWMwZ2PwBMjthP/mVGwcssJguiM4yR5CVPo35Y=;
 b=FxF0DpMblcAOg2nT8pVEPBLNyX8thNfzpwSUoi2aTQTZS0SUP6n1M8nmEu8ZkS/kITwTx4cKZbdFcapqDgpq0DPJjoD7zWZtzExEYDQ9TxIJDEsFTeKbp9uYY6giBEaZV3uDzOB4w1RGtqXZcrx4de2Kc7iAH7TRpqu+o4EFozM09QwgjHEyG84U//B86pxcOSKPuM8HSw9RAfbrPSvBAjH9EucftWU4Ls+zFnfly18J3iy6eCb/1Yip3l4H6lCe/IsgkJ/bzrLZBStUrTty4q9ABFcKqopbfEW8JpNeT1J0lUQxScQR5l4/FJDSwFob0V29BTgFDAFEwSzyBw8BaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4NVHrdWMwZ2PwBMjthP/mVGwcssJguiM4yR5CVPo35Y=;
 b=TxlczPUrKhtY+tQ5/Og9gubilsHh+VssLHPE9bds65+rFJZzg/GGqwBiVSn7X9ptZsS071ISowXZGFbm9WxZvqPuFIqAzF1NafpBBY43VYSJbv+kwd99mQcHJTxF22SaHoP6Bk/GazfBz5RebRraMGxVyuFh+ZZFNS8V9P6WHqQ=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1952.namprd10.prod.outlook.com
 (2603:10b6:300:10f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16; Fri, 15 Oct
 2021 07:31:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 07:31:01 +0000
Date:   Fri, 15 Oct 2021 10:30:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mwesigwa Guma <mguma@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Amarjargal Gundjalam <amarjargal16@gmail.com>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, fedora-rpi@googlegroups.com,
        Joel Savitz <jsavitz@redhat.com>,
        Chukpozohn Toe <ctoe@redhat.com>,
        Clark Williams <clark@redhat.com>
Subject: Re: [PATCH] staging: vchiq_arm: Add 36-bit address support
Message-ID: <20211015073042.GP8429@kadam>
References: <20211014223230.451659-1-mguma@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014223230.451659-1-mguma@redhat.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::26)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JN2P275CA0014.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17 via Frontend Transport; Fri, 15 Oct 2021 07:30:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb058b69-6fd0-4630-42a8-08d98fadbd14
X-MS-TrafficTypeDiagnostic: MWHPR10MB1952:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1952DD54FEDA4AAC0B46F11C8EB99@MWHPR10MB1952.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qtpvya1/kgBD1Zvj0z42EAb1R6cjuo1fM/Ns0EPIhX6ZNemycFKjQIqUHvIwJM4r1pWwe4GDDHYTQAKqiQ3OWVVACC5+rE5mWK3oMuh1taEcTDfgQKftF0RmbLbvkAFep0aVVMtyy1BhA7tN8p4Jca9MJBCoJJIxNEK1VQYCKZZgBovMB9SZ2rc470qtIy4OiQxcOutCQ39zaewgQyXpTC62sFqQTL8BRw2nkyfvdIVpU8GcoV+lpGR9VU2dGx+cKqIdJduzcoOac8cg8BS/q5ta9TiP20mggckjTxp5cd3tP5a/JMSJb4UVtHAzuGG+DvOqYJ1nD33qpzrnnGwCMCP1VLYKz8RG3DUsINa6GE4lU8IGX/LhbA8JHMsBnvBwvOVhbpQB1QPzAdngPDVrgBP9GOnnmFzY+hyM2xVNhOE3qU7cvh0mSwA3R223O51FkdIjT9ezrizKyqX/mrXLPTajz4KRipTaxxVrfw80afZjIAHOnnf+qNrIqEQBzOk5fsOq4/rEHJNMTfggeTLRQjjK6rUzLPAzH5KpfgIBve6yxCnSyOsxYacBUoO59gS0OniG5AvjNgO04Ys4FI9Cgbgc4aJDS9kIaRjpAh9EfzggG1keg2pCxGAPNCriCVk1fm4ccjWWM+LQVIuwT7t4wxuj0PAwrBNQxfLpX2ob14KP8H+/qlZ3fr7+Y5jxFCR5nXk7Qpd/TwQ+HHcTttG9FQBRberHj3ByfP6PwsOZPrjygTbdTxA0czki1OPcU2Tg19Pk2rR6dOpYAlflqHQ6bEiHwzzuxMHnNaHztt4M8m4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(8676002)(9686003)(2906002)(1076003)(83380400001)(186003)(44832011)(38100700002)(38350700002)(956004)(9576002)(6666004)(33656002)(966005)(508600001)(26005)(8936002)(52116002)(66946007)(5660300002)(7416002)(4326008)(66556008)(66476007)(6916009)(86362001)(316002)(6496006)(33716001)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vWNQeK/4gHBxTjXYgjDQhwVMYfgnt3yf+nEJ2GluQNTOu3fvRtsTiE9KwQ0m?=
 =?us-ascii?Q?Z7KxYgSkoeJqtsmNu5KVecXsXwIRT89bj97cAS2ZkHjCSD2O7r5l3rrr2BAj?=
 =?us-ascii?Q?fqSDguD5D9R5oz3rQkOiY5SNDK5WGdKEyiAk0RKetWRzpUinfeYn0/DAYmnv?=
 =?us-ascii?Q?tm+/KNQr85bpkBYVAODz2UuISMcndoDIYTlCGdGXNPMaa6cPPDGWeAj0A84p?=
 =?us-ascii?Q?0QZq2OvsFB0KPAHUYmG1Zu6POgsoXeTlhGW5UvV1LqotvPYpu8Maua99tL6C?=
 =?us-ascii?Q?e+W8Zoka/U/XioGv9di1+MiGqUg8GzdHD7mcoJqYEX3A0B8Fzzft+m/cTb3v?=
 =?us-ascii?Q?KtXoJbM96Q6DKIuXYyxiUCOzE++wNoephMlKe0FOIE+PXqNGKviAJ64qU8eC?=
 =?us-ascii?Q?rPStHgSc+JNnk9XsINRDWtNyHNmEGG3xM9eH41d69WjemXihlz/aNJpN9szb?=
 =?us-ascii?Q?CH8f6cNhtI191032v1NIxEb4YIkjVjIIkAmXz5MVv462lvtjrPdP00pIix7n?=
 =?us-ascii?Q?BiYwzvMvkTegJzLFXWLOUp0Ygmijnm5b8HsnDvEZQgLIZ7dFstAeJj4tngBl?=
 =?us-ascii?Q?EhioOu5BRM4WUAWdz7jz5UzCUiekK+8QPZREBMyZ0TaCHWEBDP3S6q1C4F2E?=
 =?us-ascii?Q?H0YU6d4AHmolU5l5OXl4uuFwxdtSqTYdfvNpgyXlPnmETnCIOvgzWa3u5Acv?=
 =?us-ascii?Q?dhdTtQiv3lzhzvYG3FDlJu+vtJNJwtIjQQkEOcNZi85KNOtPCuNnqQws/yX/?=
 =?us-ascii?Q?kdpdGACYz36sFZEt+e5R8+ogEqFqj9zxPf99565D9BUwBPeRw9xYUgtxYqbt?=
 =?us-ascii?Q?q96nicGy0ZEotL+4GvDBBO2fCph37WIClvY7M99R1yf6tvAqP8J7VrCIGifJ?=
 =?us-ascii?Q?5E/sZ/5iWBAV0ypbvhtnqxE84DX8ndUeNnwyDXexpuHVQYS3SpmBfexSVMdY?=
 =?us-ascii?Q?UadWmemQuOxxnl26KoLSH1M7n5rv1yuKNaXqLqsl4ZSyop6qjua/DZp0N0SH?=
 =?us-ascii?Q?R9F3Mu1rLWokWsb6MazvulqSCwVIFebONEOnbTvmHq5QQjhJekcCODIFwO9X?=
 =?us-ascii?Q?vB/XgumSh2FtgD4yFJ3pqWMfK47mdPahUJ3rFo5PuApPwmmLzeDMpk5wjS//?=
 =?us-ascii?Q?r0+Ood5EVRhs3OIy3WJp4WBecw1bbBILjKYu41xNNStk1Nofl9Il9LZG2T7J?=
 =?us-ascii?Q?v0Fh9egoz/2/aErCpngEmwKcOfHPXWTRZ+9qFSkVcZCEBez1If9btAlh5WRz?=
 =?us-ascii?Q?3yyiU8iWq9mlGzawl3b6+ksld8hAexLHzC/4DiSoaTMyPH8XG0Y8UeTdRHG3?=
 =?us-ascii?Q?AnsUP4Sg2PSi6l3d3m5D8CDP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb058b69-6fd0-4630-42a8-08d98fadbd14
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 07:31:01.7669
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85lbac2pQd2OmLC7aGTRwTJhEapoLbmTkxYJ7+uSVYadtt9MmFb5RV+T1RvMRpr9MJwDq5oug3ynHoF07CYyIauis38C5EGo63G5Othgn6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1952
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110150046
X-Proofpoint-ORIG-GUID: kbXBY-94B5WwcXg2tqQk65d503-U-TfN
X-Proofpoint-GUID: kbXBY-94B5WwcXg2tqQk65d503-U-TfN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 06:32:30PM -0400, Mwesigwa Guma wrote:
> Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Stefan Wahren <stefan.wahren@i2se.com>
> Cc: Ojaswin Mujoo <ojaswin98@gmail.com>
> Cc: Dan Carpenter <dan.carpenter@oracle.com>
> Cc: Amarjargal Gundjalam <amarjargal16@gmail.com>
> Cc: Phil Elwell <phil@raspberrypi.com>
> Cc: bcm-kernel-feedback-list@broadcom.com
> Cc: linux-rpi-kernel@lists.infradead.org 
> Cc: linux-arm-kernel@lists.infradead.org 
> Cc: linux-staging@lists.linux.dev 
> Cc: fedora-rpi@googlegroups.com
> Cc: Joel Savitz <jsavitz@redhat.com>
> Cc: Chukpozohn Toe <ctoe@redhat.com>
> Cc: Clark Williams <clark@redhat.com>
> 

Did you intend to put this CC list here?  It goes at the end next to
the Signed-off-by line if so.  I don't feel like it's required except
maybe Phil to show he was Cc'd.

> This is a forward port of Phil Elwell's commit from the Raspberry Pi
> Linux fork described as follows [1]:

Please use the From: header to give authorship credit.

From: Phil Elwell <phil@raspberrypi.com>

Make that the first line of the email.

> 
>     Conditional on a new compatible string, change the pagelist encoding
>     such that the top 24 bits are the pfn, leaving 8 bits for run length
>     (-1), giving a 36-bit address range.
>     
>     Manage the split between addresses for the VPU and addresses for the
>     40-bit DMA controller with a dedicated DMA device pointer that on non-
>     BCM2711 platforms is the same as the main VCHIQ device. This allows
>     the VCHIQ node to stay in the usual place in the DT.
> 
> This commit enables VCHIQ device access on a Raspberry Pi 4B running the 
> mainline Linux kernel.
> 
> Tested on Fedora Linux running on a Raspberry Pi 4B.
> 
> [1]: https://github.com/raspberrypi/linux/commit/97268fd23eb8d08dc74eac5e3fd697303de26610
> 
> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>

regards,
dan carpenter

