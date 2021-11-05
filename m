Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA4A344641E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Nov 2021 14:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhKEN3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 09:29:02 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61218 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232820AbhKEN3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 09:29:00 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1A5CRLLJ014221;
        Fri, 5 Nov 2021 13:26:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=IitpCMjdtWkwEk6o5OA4EZK5jBKQNA/eBnXu7HRxslE=;
 b=b6jMMrzXNd1FdXBKbj5rDIGXg56W8RtvHYC/hsK0r40eTl7PGYx/GgxOVqJWjTaB48H6
 Qmh7KRf26SR/jWuZlPfTcM5smV8brSVTfENN71PUHQi81f+eMT0KB1aeqDx/kXiqguHA
 NVQdr5HziCSZ7+oJgB889uxXDCN59c+nQC4rmRAX+tfJqrqcqo7qFgcYtgjKfPFsfUuu
 xxa2X8IfIWUlhqiLTPm0UYiMt7s53khg6npQ9aTpt6LEe4mbBUcTl7j2ozr+8DvJ6QFN
 zyelWOFG/XVnocKgHGnbVresV6k5StGPgGTWvZ7Z5LpAnMMRTsqg214ZLWZ89fhXHkMM Vg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c4t7k2f9t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:26:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1A5D6S4C052847;
        Fri, 5 Nov 2021 13:26:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3020.oracle.com with ESMTP id 3c4t617uwg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 05 Nov 2021 13:26:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RHbnhbY+313B3CZOPXeIPnDYBpiJ4N/1VoiXvLaxXE1RRpxRSfyJQQJDG2gZTNZhcLC3R3WHFguMBgMqx4h3cqIqCPp29ax29/ByKxq0SOCsbaT71DwqGHEw1lA6HzpWEiGELMkh1gbd95fdCZFlnLg0MjrMGuwRja0Xs9DYI2XxY41kDUWZwfMqWuJ+YINP58ViKddx59BReonJ/vPSKUKY8CGyTQjpSunsmhIk1ssqyXBl+OjkMkDgZcVcfMZIJOpYJmj6RA1UTUL/Ai5GJ3F5jD+AHOGN8sGybikMI2XPTpSCC2N1xG1eci3QrITHPq4iTUQpaBNSbxvW/gBPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IitpCMjdtWkwEk6o5OA4EZK5jBKQNA/eBnXu7HRxslE=;
 b=EJhrWQPx/RC7tRRtWeyZfVsYmGmfRBXbdo9YjHyTvQaRieSKbj75EyIsTxlbmVcqY5Vv6RiYODirKG2IGzeLEVeIuLA9I8mWdfs7Ramm5851IhaL37Qty9O6fwVGx2Ux7f55pliKfZ1Xw9ElANq14qp5T4KtXn3a0rqGWq5CKwYFTluc+wgm19OzuLpvtJNVs4xCFjxL86BSKTpgJwig43+BBpOQUr+yH/G4grnoEcXA4EcDwiQSEdiquZ3WNAdtz7ROow9E1SbIQvuV8THkSDV/syiiJJxW3bu8lXGxrUjjdInJGgEmslSgHBz8FToX+deNESeIIv2T17uV3UGtYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IitpCMjdtWkwEk6o5OA4EZK5jBKQNA/eBnXu7HRxslE=;
 b=Mwp30Kx0mBywuTsUX0NPcIL/auXdqUOeFrkGH5IQhDRL4YL4LqrNK7HdYER+n81PkgwE6wI22CIzInUUR3e8Sw5eUAY+UP4Z2yiu66LLiOGPNj3Q/qVkJq1C5hkna1wiid3BZhQduA5MquMpN5edBRWusiuTHWdALsv2qJaMrrg=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4417.namprd10.prod.outlook.com
 (2603:10b6:303:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.11; Fri, 5 Nov
 2021 13:26:09 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4669.011; Fri, 5 Nov 2021
 13:26:09 +0000
Date:   Fri, 5 Nov 2021 16:25:52 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: Use kzalloc() with GFP_ATOMIC in
 atomic context
Message-ID: <20211105132551.GB2001@kadam>
References: <20211101191847.6749-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211101191847.6749-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend Transport; Fri, 5 Nov 2021 13:26:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c10fc014-8851-49af-596b-08d9a05fd3d4
X-MS-TrafficTypeDiagnostic: CO1PR10MB4417:
X-Microsoft-Antispam-PRVS: <CO1PR10MB441715FCE159601738E291758E8E9@CO1PR10MB4417.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xn3nqPqrMB08UQdnn+J8H1a8MbSQqt7zAZaHw2VtDBrxZyGrHiCsj29JUZiJf8opcLSUvNPU4sPXL5O98+WDQ2URtzCd20N3/s8LIyj0yusu2afIVH1vRAfwJDBD/EVqYc8D61Q9CydWzC4PXIBM6/IGlBJB3Ke1QQH7wJxaZGcBtIfjwmPPEQOMGYtpBPwaT4zOlhYBIVOF0kDlZ64iOJrUJ1Cs9fxZpemptBBluJ/Y0aNGFpYv2hlKm2XaVaCeijMZP4L45qv7b4io3MqZWCjgBjuaC2ImLqev624ghtDPghwdcQaiWt1AfH6q5krmVvHtWyMHOdDemuoZnBAD+itV3bV2MiRL0W3eOAwwU3NjFeVrFpgu96zQo1vztJd3SSAAeFsHL44c70VQQtZONjKtg6sfVZbh3NVd73LMYutSdCxOQdWkWQ0MSMO9IYA4WsYuHiespbOurziAGS8ONdVmkWLEPMPvw3v5xD/MXxj3pZZF0EI0FyD9KRVKNsr7Wge8dweBQJkWfQFApo1wL7zI6+ThSXTQDR5ySkeRp61t3BgHmm1BJxMqjsVsDVje8FIpRbTfhn6YxXpQLcUfyVjJpOGAoYfrdeDsN7BKLetTVy4LJHEyM03SO02wuGazbVoYH234dmy9VEzCAEZTjB+0NJ8PEgsPqR5DsrwPymDH73fxOlWn1mp/A2ftOe1WBi+bPeLBWkdxGjfGJ6iKZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6666004)(8676002)(33716001)(38350700002)(86362001)(1076003)(9576002)(8936002)(4326008)(508600001)(66946007)(66556008)(66476007)(186003)(26005)(52116002)(6916009)(956004)(5660300002)(6496006)(54906003)(55016002)(38100700002)(9686003)(44832011)(83380400001)(33656002)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5dAkHt2m21eT5Q7+mkeyt3elBiSbRQ3PJOyt1VMha61kF+ZEJYPQEcvu5k52?=
 =?us-ascii?Q?FqKAAHdeBMFkA/iW046BjWgnCKLDwV/NmSp645rWxTcSUCGQh50ZFdnr1rIq?=
 =?us-ascii?Q?gJuIi7eErwyyK1gfHKOa6oGD8deBahhQgTcIirHEI0D+CmV+Ur9UGaVNDqpl?=
 =?us-ascii?Q?t9LfXhdUbL1kmtoQ4f2c64q0fmAo6aHlDuu4NAugpEEwUL3vX8i9BBCqrw8q?=
 =?us-ascii?Q?OFBHTG1bXunUI8n8FSiLsxEfWvpXsmfcLuRDbQVbv+4QF7NDIs/s3MZtNUKZ?=
 =?us-ascii?Q?Quxuo42i/CRGz3ph5Q3W+CKMmiQLgeuoabSq78OsifBykSAHBBZMBvOgncKG?=
 =?us-ascii?Q?pPILohU3Slvu0DfPfjS1AAEvXHDSAgFwCRSGZwuxZPwTlkkdjclxC1QdGPpN?=
 =?us-ascii?Q?atAtoJDYOAZKMMQ20QPO5Ep/CEnxQuTyQ5gC3Q6rzjhXhFEaoXgDEMZhnDHv?=
 =?us-ascii?Q?9Dhsb4d+EwtCodgFalYVVMRmBwnsx7ppk/+t+z7I5mub5h4LlEBAMHhlbmQp?=
 =?us-ascii?Q?RBNXAio3hzdta2h6doRuq39wHufuDzwhMVkct8o8EkNyRSXTFmcEWvINZ3rC?=
 =?us-ascii?Q?8ZSqlwzvVH8I53ehiU7ufSJ1DIUvWBBC0MGyH/7BIyA1y3PSUT5hxszp0a1b?=
 =?us-ascii?Q?Poa3750l/8klkH92GngSByJTBO8Y0dqyyYRVCyEJ4FIn0YEkt/2jXv1bwbm+?=
 =?us-ascii?Q?kc2cOwnqKkZrGi2HHGVrGrYj8FzTSMEeIVLkdvMU1EUP36md/3Cs1E1WaXsV?=
 =?us-ascii?Q?PIVvpmoeflRaKJxqF56b7daqWoK/W8pkcBdcGcU9gEp5Ig7pkHrv6jOC21zK?=
 =?us-ascii?Q?yOTUGFXcADcYFF/FWOaQ5+6XIL7y+h8sS1DQxqc6EC3dKLBfz8Fy5tsaqlpR?=
 =?us-ascii?Q?apqyA7mL8mr4j1k+vQrvqC39hCX7eCmuWtingIAqt1xRiOPXk/KD6pYg4v0u?=
 =?us-ascii?Q?puOg9wK+poLLpFa6+cPEMcP3RxfG2vh9fiQDKN6KMZQ/KfpKVM7TEUzcLUHe?=
 =?us-ascii?Q?zoYTFEktfwRtcygI2GIz5irkW6iwdgPpalhsxlncpafPOs5rsmWB/tQDE5i2?=
 =?us-ascii?Q?DLaAD81f/l2znyO3tj3XmLF0doaSB2fO3yLsrz5EJgOsI8Jh2pR1S7QvEnBf?=
 =?us-ascii?Q?NAnBjo9zMXCe/BqWlMZUbSpgSmhbSyxre9DkMoMUN5O9kvCQsMQrUyjporGc?=
 =?us-ascii?Q?G9QwmZtlYU2YGkQ+9a+mvLl3EB5EAje+x9SSHqt1WxRWvj7TvSGBOT+zre2d?=
 =?us-ascii?Q?3L5q0p7IHEF8TdG7CHrefx6wP+wuqNZKgeOAr8hZzmd8SnZONf1+AjpioQ40?=
 =?us-ascii?Q?1s6kzRDRDBSCSHBSxm03sbqAIKIYbZ/bCvl8unJeSaP8eHmd/hxEvnl+NlZc?=
 =?us-ascii?Q?km0AI1vPxmRZZvu83A5BjldqLh4GhUukcWyIpQAoHCvO7rO3Plvj0BJ7HRE0?=
 =?us-ascii?Q?xpMQABeodH1ezNlP/ih9unPvrCpoE992MQrVAxrnsR8OYC9QFfUt5h0+ZSeT?=
 =?us-ascii?Q?4M4EaY8SJ+/7y6vQsFd5i8haBrt7sC+sa9mvEVmtsLejEe9WSchmC9aSZW3F?=
 =?us-ascii?Q?jDGq8VmrlNkc39muJLBETlDXAYAIMgm09UPZxfs1V+xiBKuXKM2n9tWOk4y1?=
 =?us-ascii?Q?VWJw88YDNWMsDjZJtRGG4AQjoPRecY/yRWOEt/XQCHwjpa637ROGAA5FpKGn?=
 =?us-ascii?Q?ESVVZoZ9F9OPwyYCtVfmj+JsurU=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c10fc014-8851-49af-596b-08d9a05fd3d4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2021 13:26:09.3313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cnzGFonEG26K8ONdamSO5KsOGFFui1PcCKbHQ/dNrEInC4mXeopOClcOqv0GuLtcPAePek2UKiazVh/+RORSL8KGckrdJKpku5ayuz8AogA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10158 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111050077
X-Proofpoint-ORIG-GUID: 1aQKgw9Z8aDCR_ueQPCt_qddcrjrq9SL
X-Proofpoint-GUID: 1aQKgw9Z8aDCR_ueQPCt_qddcrjrq9SL
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2021 at 08:18:47PM +0100, Fabio M. De Francesco wrote:
> Use the GFP_ATOMIC flag of kzalloc() with two memory allocation in
> report_del_sta_event(). This function is called while holding spinlocks,
> therefore it is not allowed to sleep. With the GFP_ATOMIC type flag, the
> allocation is high priority and must not sleep.
> 
> This issue is detected by Smatch which emits the following warning:
> "drivers/staging/r8188eu/core/rtw_mlme_ext.c:6848 report_del_sta_event()
> warn: sleeping in atomic context".
> 
> After the change, the post-commit hook output the following message:
> "CHECK: Prefer kzalloc(sizeof(*pcmd_obj)...) over
> kzalloc(sizeof(struct cmd_obj)...)".
> 
> According to the above "CHECK", use the preferred style in the first
> kzalloc().
> 
> Fixes: 79f712ea994d ("staging: r8188eu: Remove wrappers for kalloc() and kzalloc()")

This is not the correct Fixes tag.  The original allocation wrappers
checked in_interrupt() they did not check in_atomic() so they had same
bug.  The correct tag is:

Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")

regards,
dan carpenter

