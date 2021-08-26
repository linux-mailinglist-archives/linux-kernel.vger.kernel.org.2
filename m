Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55F6C3F8971
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Aug 2021 15:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242763AbhHZNzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Aug 2021 09:55:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:25558 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242750AbhHZNzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Aug 2021 09:55:35 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 17QBQfE5006537;
        Thu, 26 Aug 2021 13:54:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=fn2wYrfb8mEjBgKEdwE4DCjOZMp31O25aKkBzMn9BMo=;
 b=k81hhEQfmz2vn86Rs6DvBPO6OgbnPOvI9ufcX5oJLkhiOvZlxpksMBGj4Q/c6J8lIzFf
 grvglq93dJDZo7dzw12ByQfLhN0gld6D6+yvkUihrpX1nZ0Uo83D+0o1bnKSGUgyBnc0
 dRDMvjtgOyGVFp/iMKxaIDzznK/btoHbvnylYvK04sOt+Oz+G63wwNrAtGgFApS3Kj3S
 KYJupGMxAdlF8iq7odbtL+4LvGAHF3xQhaznMCljrJrMaGErJH3tMkxutwcJIUXzkpsy
 AH973UFT5N0l+/HdlplyF6U4Ejbb/jIj9RNe47K9Z5VQJ3XrX+oO57Dhy8zcgbTfkzvC fA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=fn2wYrfb8mEjBgKEdwE4DCjOZMp31O25aKkBzMn9BMo=;
 b=W59JzsCpKMB4XZJAwc6N/L1AMbq4JiZNx/Krx/DPW7hPtmtHr2m1NsPYr1aE+asG8DaE
 OqxmG5atSUoDVe/lU6gXgA9HwyPoNoQvf60R2JZHZh8REAuD89Lv6Y4eFJNFj0/qOm/l
 2j14/HarBRDOm1NQvQc8tpTzFscGU5MDXSU1mjUtCci857iMwUJIKEqJXjKmsD/nw07T
 65atBaeaJRS5tpkZjj5RxJwUBAmroROcYiCSxTR/W1mnPeoyGKSh39vmtdS9LZ5ifn0i
 SLggUeOoNszIJzAX4R3lFw7kc71MnEgUEZjbv4+O446no3u1N7iKsOZIHFUnYg+SOhJ5 8w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ap1r5h9rh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 13:54:35 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17QDpVRB171318;
        Thu, 26 Aug 2021 13:54:33 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ajqhjmv3r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Aug 2021 13:54:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bWuK+9vf40CZZ+RNKNcUf2wO383Bpq5tj5Vh9SiUC0gvwAiBym0oF729TEyUs0xPwLQCPkebTBJ+hj7JbJB673L3kuMIQwHO/5wqLap2j5xg61V829XmijNamNnMachLPYMKGrPOQjLvByUk4X4zgFwqt0xvzAXbs9T4oT+GvZAov9I8XyYmORZfhcIq1tI5G0IxEvnnp6QoJ23pvDr8q+TxJN4CZkjlXr7besMlaFlaLGagHz3/ulEl7DSCI1NiwgcOZwBQeZICEAFv4qcthUbE3KYtCJ2kPDEFqmPDkp1fYSUS6uGrUk5xGm2zqNKUfnQ6223aBVeLNLgEj2wteA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn2wYrfb8mEjBgKEdwE4DCjOZMp31O25aKkBzMn9BMo=;
 b=nMiTz7j/LdXJU31HYMjRk/lXDif4nLhrVYT/5kiT+SjW16Z26enBKzSvLycmmQAxvEePJtcyNW9MzVSyWK71cCSKXGsAkw7zGTYdWlYInCq2ORQEgb6Y177bQ0bUzhuVlR5r6HQsbk8bFf61lj7hcEC1ZwP4zUif0MEBmfBCmwCIFADaAldXsNDm5rvbKFWASaj+zslXe8bzTfJMboADy3bMR8Dft8mbNJ1OfFGmexazq0yhWi9ajYQiW+bjOH4jE8tx1/V5KXYekGhhqec4zWCc9tJF2ynnciuwgkJ4orGKfivT1jZFUlXYMUy9NKz6V8gNC8yz9d4rfFiI9gEZYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fn2wYrfb8mEjBgKEdwE4DCjOZMp31O25aKkBzMn9BMo=;
 b=LBO83Ot8CPi5acyniRhNSNDVJiJa2zIBwbVA0FAgGG3uMgcg8W8KFfmyvGWZmCPO0UnsN5YP7cwxoHmzYlkMELx5vag49tocK3aN8PJQxmmCdoUrgU0iDzCLHzZNRbRd86bH8FjfxTKcMDebM9VNWHjHUZWMOfDSS61u/b6j3uY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2094.namprd10.prod.outlook.com
 (2603:10b6:301:2b::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18; Thu, 26 Aug
 2021 13:54:31 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4457.019; Thu, 26 Aug 2021
 13:54:31 +0000
Date:   Thu, 26 Aug 2021 16:54:13 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, Fabio Aiuto <fabioaiuto83@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: r8188eu: Provide a TODO file for this driver
Message-ID: <20210826135413.GA1931@kadam>
References: <20210826130342.9552-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210826130342.9552-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (62.8.83.99) by JNXP275CA0001.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.18 via Frontend Transport; Thu, 26 Aug 2021 13:54:26 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03c53329-960d-4f69-b6a8-08d9689906b9
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB20942FCF83B8B0AE2965F8F08EC79@MWHPR1001MB2094.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K5d1SJ3oEM9fKcZ1L9BtSY3Vht8BZVYxyRyFaBTQCpjUpZh6yy+uIhfVGolvTRzH/y8lAgFEFm94KajC7fHqE7UyJC6dkahjzFYtE2EVRfs5FSl0kjKp559uy0eOytd52z4xY9nwuFeey87Wr/fKauFPvpNd+a5M6p3xwjbgOu9+717CdXkzBk34wrmcsXWr+U3/MUBcYaqZXFqDy3BkNoAmKIltTN8zG4YvkQvg0dkh/YRSFrGlOv1BnaVLzLXrZEwdHOtwF7bHZTkB6R6G9kj58n8EG1fnnxKZ0kYbmkHQ8g8VcgRzb+jS5kFlJGX2PwGMmr/P7yveIuutNEOCszHDCS5eg2enbtpnHT1zQVSEdpSxxZ0REdC+OS34EcMeTFPbmYHLgSCTxotMUGBNfZIF+jiIDmoG53lO0ZzUv0uhovpTcpiDfscuoFCQUbbKqTzC2I16/NBFaPDJBfoBa5LYPmYRJTvEZxSFRqF4ghJYiyp1WjOxqafhUrj4WTfodSpRivqLQsxLqpryaNXWQg7rTa3io1G7eEWCIlkwLDKhDAhfpzILr25MCrRH6C99Qs3bWfAeUWomIoty3Jaus7TWkkC7uQmxxzyk7Wgm0T8F5XRVTFiAG5k3q9DLxHQJ42oBfuBVWICU4lp22VbKc6TxatxTPYc2mZd1N6POubZc9j44mRTWNigynODWYsH/Sad+HMutFd4DJFlGS9w+tw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(366004)(39860400002)(136003)(66946007)(8936002)(478600001)(1076003)(66556008)(66476007)(9576002)(6496006)(8676002)(44832011)(5660300002)(52116002)(9686003)(6916009)(956004)(86362001)(33656002)(4326008)(33716001)(316002)(2906002)(38350700002)(38100700002)(83380400001)(6666004)(26005)(186003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OH1oLfLFr0JHjvPSR37HfnJI4IGHnn+p7nAHbwpN/GYR/483qNCbVCqcFT6P?=
 =?us-ascii?Q?8sf1byRJCjNKBv6f92ep4ghVuAAsdcFwDPaHrA4aSrC76tS8g7LhdfZJxZer?=
 =?us-ascii?Q?FDjiCEN9YM1C8OvTE8FRhW6NBQ/wgo+JnDnH8xPQ4Rn5EXi7hQKhTve2B5O1?=
 =?us-ascii?Q?K6UFzy6Y7qmZ6IjqcRTnKlY+H1YSxpLQjsBm1QJVM7Puf55YmA0BVpo1S25B?=
 =?us-ascii?Q?ulDyRSAyT4pWgFRikZRxALt7nv04ovDMK2SIfd0O4ULpJiIM1oZrYUgKHptZ?=
 =?us-ascii?Q?svtJm6pgFwM1grXtvxYx3Og/JtzSJfNp+F5puXzFe+vO/Gz/dE9VLM6fUrv2?=
 =?us-ascii?Q?rUQVq3WfzopfAvYROUdUmyFlgj64CsoneS1pQ0iRqvireYzMwHfL/GviYK7o?=
 =?us-ascii?Q?wR0qQqprWXW7z3ujQpnljWTLEXCd6d1yEaO8c8NZoebLv36xjV84WQ3DAOAn?=
 =?us-ascii?Q?QtNtL6HVxoK9ZBE/+h6/mbM77TAF64KIb8TEmT7t/ly1wE042tMihyWu6x6/?=
 =?us-ascii?Q?35yHMcz24qxWsRL5L0+GO3NVb9D2ATNG82Z7lKwITIC/3DFKrqmeceH2pt3w?=
 =?us-ascii?Q?YOhdYq42AHV5jOE3lIGIwiRGHRPYswy60UM1MeH1m1ptjin/R/5qsCaLssMK?=
 =?us-ascii?Q?y4P8tW9250WbpISx+o4cXPJFLadI2kywko3zi9mVAieO/g/XxK721qHbCfNy?=
 =?us-ascii?Q?UBdtmB/4pEqU10CE1/aSgdAJA0++xBOn5dntZC5BTeUFynxPEuvWVrow4nmy?=
 =?us-ascii?Q?qXtCPIahj1CSKptB2XX17mAB4fUxHyCr4gcoQIG8N7xn1JR5jO04KZhrldbu?=
 =?us-ascii?Q?s7LZiHGbKClhTnMuOzKu/rotrLt/e6KhTVscRrtooyCWczpbNfv17I91hf37?=
 =?us-ascii?Q?C8WRJVIkWp+tR/Kr1p7dBGIacyLlUpE/naYQrZzelbEp9JMk23T6yIYPYdAt?=
 =?us-ascii?Q?9NCkY8kXAk3YmvGOTUALjPSddU6yNaUp5O7bLne2m+oubF94i1re1gDZtI/Y?=
 =?us-ascii?Q?gODX1LFizEv4YZNGMddtspO7F4RVuTFogfzd6ZZ4A5q/MfyZ45O8Y5Q1Wm9a?=
 =?us-ascii?Q?ZHphHIHxgvuvGhIsThxcnWYDLyGP6DdZtXg3Dx1n6J2DfMy94GnXcYFRbpP7?=
 =?us-ascii?Q?RzcLZPvSwL7FTzw1bscT4buYrKMcBARP/TvuM/5+RNKMz7UzrTIINUOWDY3H?=
 =?us-ascii?Q?s69YMFBoIQMhmg+OK06o06AD0+t3xagwmBYR+nOuTvZ5ASBfMCHC/Y2ulrSh?=
 =?us-ascii?Q?IjJN3/w44Dxx3baHC95A/uxeT2pc78+CFETaqcV1HoO9h/HpdSZT5lxcftn2?=
 =?us-ascii?Q?z356RAGeENP6nYSCRrcJIlQ4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03c53329-960d-4f69-b6a8-08d9689906b9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2021 13:54:30.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOLvKcdj6ZyJ4N28A8oJ9uHfdLOTN3JnliDWorILhee/e/mZSNEJwK9lU51ytCX0gEQeNoWBMxCQkSac0XdFxBy6+HYOsB1BO1uZUJ9159k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2094
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10088 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=938 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108260083
X-Proofpoint-GUID: Nluft7-5D2hDoJQ-2pIjODCSD2S0IlZj
X-Proofpoint-ORIG-GUID: Nluft7-5D2hDoJQ-2pIjODCSD2S0IlZj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Another thing to fix are some of the sleeping in atomic bugs.

drivers/staging/r8188eu/core/rtw_ap.c:139 update_BCNTIM() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_ap.c:1296 update_bcn_wps_ie() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_ap.c:1361 update_beacon() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_ap.c:1725 ap_free_sta() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_pwrctrl.c:79 ips_leave() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_pwrctrl.c:81 ips_leave() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_mlme_ext.c:6764 receive_disconnect() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_mlme_ext.c:7083 report_del_sta_event() warn: sleeping in atomic context
drivers/staging/r8188eu/core/rtw_mlme_ext.c:8133 set_tx_beacon_cmd() warn: sleeping in atomic context
drivers/staging/r8188eu/os_dep/mlme_linux.c:117 rtw_report_sec_ie() warn: sleeping in atomic context

There are a few in rtl8723bs as well since the code came from the same
place.

drivers/staging/rtl8723bs/core/rtw_ap.c:1601 update_beacon() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_ap.c:1919 ap_free_sta() warn: sleeping in atomic context
drivers/staging/rtl8723bs/core/rtw_mlme_ext.c:4270 receive_disconnect() warn: sleeping in atomic context
drivers/staging/rtl8723bs/hal/hal_intf.c:100 rtw_hal_init() warn: sleeping in atomic context

regards,
dan carpenter

