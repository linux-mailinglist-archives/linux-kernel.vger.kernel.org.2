Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A56245C1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 14:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344346AbhKXNVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 08:21:35 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:3740 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348975AbhKXNSM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:18:12 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AOCw1Qs031449;
        Wed, 24 Nov 2021 13:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=HSKdHTsEQXVqta0L/WUv8c81cmDgmHJni4f8Cg2a5Q0=;
 b=kIHRbwCa278DrVZvdryETul+u8qST/fOQe9ICdA9I8Gy9RoIvlM+YXTOJHnfaO3arehM
 egB9hKyg8DbcxsZvvmv+3GgEZzmTve8bQ1HIWWJLz9qXstTTCrssXCaTm6m6w7gN6vmc
 ADqWYCi0MtwyJ1X80zrL7hiO12Krsn4Vqi+3Fjb+I5J6E8oikjKC6T5mH+if0r3jwqGk
 9q5MseaMFv6Jx9esaHc8GPmn5tM/UihIo8vqzZ52/F8cn3Cz2snKuTAq2EgkzYAHOn0d
 vmDzNxSWW8dCMkwcBKsUfoqCaurFmIQ5oNtb/w/spaxNIIy/5D6KiHyhYtMh4X6HN0Le LQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3chmfn0hxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 13:14:53 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AOD6qcJ051279;
        Wed, 24 Nov 2021 13:14:52 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by aserp3030.oracle.com with ESMTP id 3ceq2g05j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 24 Nov 2021 13:14:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbqP6yXLnFSPOf/VSTUbYX4Xqd/fHDG9FKkHye2Y5+IM3dABzJgvqpoprud0WX/Mry7+yMtuwbkRnpuMAufs6/84PVxAF9NN9vX8uzofuNQx8nJ0oi/E1s6jHmdflSeSlNQr6NHHxplcYfTgcqA12rSnMUUlzP0xmOvScWOCUUKCCP7OClCYsH8vNtgo8PK4A2pwRDhCMU3g4V1IHXhm61I80ZxuAL6ORwd3lIGdDKqZGv5nvVRuhex6hijmXtyCiu15vQh1QZn67QgHpOUyyKKK/Y9Ql2i5xpMM192Mm6z/+DjkCdIreAlUfXn560CPUToIqArozTD+L2TG7L/Zlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HSKdHTsEQXVqta0L/WUv8c81cmDgmHJni4f8Cg2a5Q0=;
 b=O56phrDi+txsQpAbauuyqEPzC2pDX+wXivyUxTG5nG3f03pPbVLv87zA/ToKCkGh3twJlt+bmFL6nRaGtpE1O4IlUfqLsyxhlJIs2IIe31TOafGtLF0uyxYYUWQwSLwi+eHXLyHNsbYvMcGCoJG7oVsK0EW4mNnbr+jQAWUOjjlu5QOHKzJCX9mVi2mJbyNbvRk6NIQRnu7DUz0A/9o6dGKLmmXVmYyq5haLeOP77FRegVhNiQP+0spJVKpmZAJFCcr4IO1YBnLYhDVxT1LhPwSjGtmly3tMnHV135g1ZBswq8NtbRsuKoL6Vadi//gjLPenl0h+GyNHOJ1otYx/cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HSKdHTsEQXVqta0L/WUv8c81cmDgmHJni4f8Cg2a5Q0=;
 b=nqZJ9biZrYT53stIffY6YCoRfba9h9xKlTd/lqAn1a8rDTqWAEcr3KvsGefyh1LenWwKR+TNzgDcuXKCOrV9j+5k3IeC0WChVkYMSIPSYm4se2VBEMHDkhWo2YfR7ycol6vsvtCrPaKxmvjwfYgWRJLeeRtZRf9AgAmKKW6N598=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2206.namprd10.prod.outlook.com
 (2603:10b6:301:32::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Wed, 24 Nov
 2021 13:14:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.022; Wed, 24 Nov 2021
 13:14:37 +0000
Date:   Wed, 24 Nov 2021 16:14:14 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Vihas Mak <makvihas@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        nathan@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: use max() and min() macros
Message-ID: <20211124131414.GJ6514@kadam>
References: <20211123232551.210016-1-makvihas@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211123232551.210016-1-makvihas@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JN2P275CA0046.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Wed, 24 Nov 2021 13:14:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86cf4296-510c-4a92-021f-08d9af4c5d4b
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2206:
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2206C032A5E99E8A732E75C08E619@MWHPR1001MB2206.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:202;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /kngbI8nWX4Lm1In1bD/sRfI2KLgmrEWbXWJRm+bT9iRDgpmiLxL+QyoM+wH2t6F3GpSvzi+UvON4iEqsP/CmPvtod6P4+7tD+7f3AYJkWINW1IRVUG1FI5TmyZkL92wCUGotNiRKO7iAx3LHbRzrq4oegd3RBbpI/lfAW/k+pYQY895A4YDRy/e63n4GiLoNlHtWHvZJ+CD1KuIeL74cY0uBoIIHF9rqZlxEUh8sV7M/or8MwuOEUKVa2CGY81zG00rM8cIobVIFu7mx3HfutbJHb3ZXzZjAxQOPJCBBJ9pXuPLb2fzt1qzKqILRTIhKvAMHqDDHfjavqnlTLpZsKXDAnmiz2bt8dZIOPnKL7wGs78SACemOHZLO81CVUAloTJfm2XF6lLOvTsNVMsLl5fUOqbhdWMbSgLq+VIQWnQeQUeq6sZbMGcqryZdyu1G63FoJw0MikdHa8YWcj9jjfApRPe+wgOsxx4XQjZoJ07hfa0YQq2UijYTnEEHQHB3BCdHagnRmHdmZf/vWzlI3DQwCZZ5122G3DBoYqPk+ncGyX929L7j6urDm20R5Ehes/GaQLbj3YOSE6dD7wcH9xAzPiTfCbF0lp3YmpgoIZH7Ddkd9Ug0zAO1EY5dJcqOv8APC0Z58xJ+C2A5JBbFF3gD2V4reNbQlnjhkOXdaIuuVva9dEJrZov/GK0KU1UoCEQ1bL2LyPM4tvBQytI5Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(1076003)(66946007)(38350700002)(38100700002)(66556008)(9686003)(66476007)(86362001)(508600001)(6666004)(55016003)(4744005)(956004)(44832011)(8676002)(26005)(186003)(8936002)(6916009)(2906002)(33716001)(52116002)(316002)(9576002)(5660300002)(33656002)(6496006)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AWCHDqIyZyg8jHrWYPdson6tjHDS/xa7aRpkBNkDbimG+JgYv8eMAyipPHpn?=
 =?us-ascii?Q?hQPuELNbtuuBO8gqBt1XgrqZwfa13sqoMa3uOYzSTKFjk1qmfRoRGJx7hTqF?=
 =?us-ascii?Q?7sXN74AmDttjJRfcBT8omtWov5q1UxoxljOWdqvApIHdjOs8soSG6TCcf5x2?=
 =?us-ascii?Q?TMQwbVIO2c6EXJDeR5OV68ePjyXxxugPrKtVvdrc7EO9kojcESPxNl4gycOC?=
 =?us-ascii?Q?rpfEd0dnRvLvti+0yjCL/89frX92GtUhZnaF1EVumrm7J0huYDGfViqc9o2l?=
 =?us-ascii?Q?fOMh57Zr2O0BZH7fGRf/Wmcmp8oy313JGc2KB4xU0RtUUyXbco5dpKtyc3/F?=
 =?us-ascii?Q?YSxKnfjcEw6RESLHl9eqF2kYuJaektxjvLw+KWvmUR8LYQHsSXbd0mrMT5AJ?=
 =?us-ascii?Q?UpbagUcRt+uwGHCWZSdfuOj1vVsseIUSANEyDe/FLH5oqmDF9nbxGHp92cAO?=
 =?us-ascii?Q?dDciHzaYOxTEHDCiF5FRcWqJcXdr2t13tobcXizvkhQvmK9s3cIQ9JU6qxco?=
 =?us-ascii?Q?ORVx8e4S2xriqKdjBCxAxZ3oXXG5g5yO9MZA3e6/jW4HxZMt6/V/1gB8y+ny?=
 =?us-ascii?Q?+IA0Ew03anY12xqSrcSJgKCJjsN8CzOnjmjLNbQXqRE1AFrzHHID/q0nr0+P?=
 =?us-ascii?Q?/sS69oR+jnXymq2W8JoMMJokDMRnkNERw8siJExMTNweVTKqsZi41j4VMIc/?=
 =?us-ascii?Q?z6Bvzor8uMkau9lwjNjCWxdzTFNxWzcuYErPhIOg8Xs/Kgz+TajeZau1iOuN?=
 =?us-ascii?Q?G/VH9NFp/vKu6qfBx7xfLDzcQhAQFAa8AZd/vBiZrurwff+cvy7UuWgy66fE?=
 =?us-ascii?Q?qrTt5i5cR15U0Ql+8fJVnVNsQYAKy+nYBsWjFStEg9jeHPDKu/rp59DuewDm?=
 =?us-ascii?Q?oWREZDoTU34LiG1JkOfpDwVhLr3PPEEjsyV22jzlHY7ly79KESPm+CYybbNP?=
 =?us-ascii?Q?ztc3iXBPvH4bZIAa3yzo2dhVfNW53ESA/8LpG0KTmTx9JPzGf2DwarY9TrBb?=
 =?us-ascii?Q?5r1n5ZWYvBmBTf+qgjzehl1wX5ZKfipxlq2Yh5H5pqtBN1HmFSBJkHWgHHZ+?=
 =?us-ascii?Q?oD0rbvv2hPbveiKofbkqeM+DP0lbIWa0GJInIrdftbfMjxpt9I2Z61PjBdYt?=
 =?us-ascii?Q?lpORoeOvM1ZSylZc4Wk7P5LOOdA8we+Z3BczVyv+tppxvok2DDmR3gDaAAxo?=
 =?us-ascii?Q?nuLZoJiGjqdercAdDxkzuH+WtJ5veb+VA8kKRXgeP84K7yeneBoZLlyhEBTV?=
 =?us-ascii?Q?npsFjJJD4VDcnzS2/yL5pPGGJYUzxZvmkrnOVqVllzKPeJw8Qa9TaW7EkT9E?=
 =?us-ascii?Q?AE5RE9A5xKQiCEAYRoRliVuCf6eMNNfIe6c79yhbKw8eOu50bsCqjIFZTchU?=
 =?us-ascii?Q?DuVJqlzhrdKp68wXOZSSGcaeEVR3JhCfDXWwz7soMdjx6cihFUNqgc7psBOO?=
 =?us-ascii?Q?uUMK+tr7m9UVNSVael3ebkhXbE5btOkbB6phGzATl9cVTe+JVjyNljtkzA49?=
 =?us-ascii?Q?d6dvhydgLKxH8u51AfhmBHML6zk2TR6GZojCFhmUTGOSiXo6MbqF6dX5foqb?=
 =?us-ascii?Q?+PndMXlVzdvDx17gu8uxD+KCiyYyG5B69hHSbijgAaKwYPh47M90e2SxpPQC?=
 =?us-ascii?Q?+uLT5ZJ68OA5X4i3sLXDhx3wXxggBPaMAhFUdJ/daEB9K8VtKtkyXBssDnHg?=
 =?us-ascii?Q?h7z5HJTOwkGC796LvkqHk1MN0I0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86cf4296-510c-4a92-021f-08d9af4c5d4b
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2021 13:14:37.0096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0kUEOBpDrCrJZDoieVLH6lgXD2TB30Tk9Vn3RYzLSvaOLqqHo178GnSNIztY+9t366pqrlqkiU4QnCveGBmCgtVEDgClUxPPrpFA92G8uPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2206
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10177 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111240074
X-Proofpoint-ORIG-GUID: r2yc0IUOXi6A6m7zkcDQgMuvmNgJL7dx
X-Proofpoint-GUID: r2yc0IUOXi6A6m7zkcDQgMuvmNgJL7dx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:55:51AM +0530, Vihas Mak wrote:

> +
> +			min_MPDU_spacing = max(pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c,
> +							pIE->data[i] & 0x1c);

Please run scripts/checkpatch.pl on your patches.

CHECK: Alignment should match open parenthesis
#41: FILE: drivers/staging/r8188eu/core/rtw_wlan_util.c:723:
+                       min_MPDU_spacing = max(pmlmeinfo->HT_caps.u.HT_cap_element.AMPDU_para & 0x1c,
+                                                       pIE->data[i] & 0x1c);

regards,
dan carpenter

