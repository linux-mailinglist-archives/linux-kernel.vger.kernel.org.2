Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAC342EDEC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 11:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237614AbhJOJqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 05:46:42 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25976 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237622AbhJOJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 05:46:37 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19F86EjR001724;
        Fri, 15 Oct 2021 09:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=DzTqS9vZ6SnImbZYd3I7Di5MNOzfJygXgusXLoDOcwE=;
 b=BQtAatkJVdBYMOdWiiXWRrDh3c0iAv+EJ+qUMe1kgSaib4BPJ6CY9Imbk1Jbx0trEBjz
 o8RtY2LX468cCvdLZJ/ai9xOOO1uP9V3RQLIIQzLyBgIuEK8u4gORnf1A90I99oYIZnK
 NM+IkuOJPUTe0jwkjdIKXEh9k+ER9OQLqydRyZBGfOZ7p3eW+l7pmIXLSb9An8z15bz/
 AK/2zj0h7jVGM+krJsmvv7aa2tDl5Tq/T/ZgLABeHn/llRteb1oqM+xgJ/AhdiYsRfYz
 hUPGth3fPr1nLAw+wErz/AkBDsNtxkbM1CydF5i+0qh1UxlT9Y9PPJE2Xcyi7EqixyqW TA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bpfy67sfk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 09:44:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19F9FFo2037290;
        Fri, 15 Oct 2021 09:44:03 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by userp3030.oracle.com with ESMTP id 3bkyve6s2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Oct 2021 09:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVDSU+gjOGL/wpm9zuyQkQ+XN1GHgvcUIKOA/I6TyWIyDSQo5cO4sWGOII4pyqPy/hi3Q/219g2lVaodDiuqPDWnvq0Di9cTh1FvOuPmoVpPIiw/BVxfrP8CQCcNkt9BXnoU5Rwh7xHdnSO2iF9yT5QYm1JlP9Yp+4z2nt37aUy2CXILBCQfQmtRRQTkrMq7rnj9IH/NQABmfyRitUg37N+qZUJMb4rT09JnG1OMDPAitegTCwaH9lGt2YQWefvza8odm2lHchII9nlaEoHm4DDadSPva/Co59JBVeqUckxpMIMTAXuFdWLfFFH8MhV5xmepV/ZCGHNXRh6Gcvy0eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DzTqS9vZ6SnImbZYd3I7Di5MNOzfJygXgusXLoDOcwE=;
 b=PURFgBXzFR0GWVUwwm8yS5vSJ6jMDINZYJuej9mz2NbNuy42Bdbl9d5D6wAKKxUbRf1OW7r4C92O+XToZNVXSzPiPIBanl6r5iKPKFfif9mW7hQ1a7iLPYA8tisVPPkUZg09sASiS05uwuWwY1DZoV7U6mmd9iqVMB/esHkxdosxKTqiS9h2q79Pji2MXu7odweqWedfnrVqbsIuRipPUXjkxvejnmIf/+76jtSXVxHNJcqjVmfIH9IZdSAuLfsdQMKum7SRqU2HBm7q7JYO8P/Iyfa+5UFKj6Jj5TVmnntffyg+4E5ajg0C8P4Q5ah2OYZmgtRFVYGbzs6fPfPWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DzTqS9vZ6SnImbZYd3I7Di5MNOzfJygXgusXLoDOcwE=;
 b=CjOi8DnTZ1gSIJun817yKDY0Wyn4B+pPIBdUWqV65Am18u/kSdgGRTTJS8yAgc2Tz/6w4rrxSI3CFcyvHKpbuxExzMxVm+nPL1Mtw6AkvU9u4STSwUlIFbzdaVcmWYfpAfPgqTiqbec42wualZlBzenD42MFTp8Vm88YiaYLFmk=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1888.namprd10.prod.outlook.com
 (2603:10b6:300:113::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.22; Fri, 15 Oct
 2021 09:44:01 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4608.016; Fri, 15 Oct 2021
 09:44:00 +0000
Date:   Fri, 15 Oct 2021 12:43:44 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] staging: wlan-ng: Avoid bitwise vs logical OR warning in
 hfa384x_usb_throttlefn()
Message-ID: <20211015094344.GQ8429@kadam>
References: <20211014215703.3705371-1-nathan@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014215703.3705371-1-nathan@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.22) by JNAP275CA0044.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.14 via Frontend Transport; Fri, 15 Oct 2021 09:43:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ef027e86-d7bd-4df4-80d9-08d98fc050ec
X-MS-TrafficTypeDiagnostic: MWHPR10MB1888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB18889D71453485A54B4B02268EB99@MWHPR10MB1888.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mFRctfjPQbflyazBL0IyJC5q64OPi6OWtQ0fOCchYdJ27gs8laZgsDDMbDKaKeODQbQPd4QzmepNawS+crwuo9x0xwzCOKeoX7QRLztQYydmLp9PqopOYEqh2Gk6FipQztsAAR6mPv/DoQ+KkujLHa4BKpdWJTJYw3LXfUesoL8I2rC2B4Pk0DdDXElzFVybF2dzFsR+2dLhWMcg1RXhd4P+L+Aqd1XhnCiqvLUaYBMRvdmoSoz7U++r7u7VqlCupoFGSw/f0W2ZgTu/Tv23D7T3fRw9IpZYHh99EJAB4KXPymYcw4BTj6GseAPxiXGNBMRGw2F+duY+6PGP+I8Wjdb78RmB9n0HeSWwjnjQXdG3PE3AwQQ1Qeaz8+q53uPv7aqT4waBlXGdRaQbJNM2B9N3aIki0MPlYdfgedindBEhdidEwq8Jvgb+ufSnomMjaHUQIjrwFZADxXLcE64b9xFHcXqkHs0hvqrHd0fag49jFqtLOWLBzTqlw2b2chOVjHv91jMVN9N+wPnEocrzHW9+J5ax8k+GtYKzVoKq6Zle7Fmcokx4A+tbd0AoBrjCUzQto+BfiOaacJOkwm0FvTw+XRz9bVKGbbl2OW4qm+XvSm0v5kYabfozeV/7ELkYtaHT+bg/pEec6dD3bW1BCYOZtul+V3+Y+7q67oFSZ8mSO8/PnMmOJhQwuURfwGmRHxt0SXc7Ddv/zBHMBdicXQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(9686003)(86362001)(55016002)(316002)(54906003)(83380400001)(33656002)(33716001)(66946007)(9576002)(1076003)(8676002)(4326008)(6916009)(186003)(6666004)(508600001)(26005)(66476007)(8936002)(2906002)(66556008)(5660300002)(4744005)(38350700002)(44832011)(52116002)(38100700002)(956004)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SvkZMQ/BUkPxIyLIgkElO6odrk6HxR4VKrs5wAGq6loiCf5JRb4wHHA2UXal?=
 =?us-ascii?Q?/SxectQzvm8oT4JcHdpQqHYd/5oEge9iXKW4kKl4C3a3L3dUJkB/WvOz4BRl?=
 =?us-ascii?Q?3j05oqnEKLY2V0J0laaiWc5O4Yn16MVnhBydnJVsqTTrmTt47+zuAMJ4mr5e?=
 =?us-ascii?Q?/+DVptoU6Xto9upCtyHGwTBQG25Jocz7G15sGLfvdsIP04cMdWU/8CG8lRKx?=
 =?us-ascii?Q?PIKrYPVnr7+klkDkL0M34RBg3KaED8VVZGPTLazeSym24A1vj1O6dz5UoLSL?=
 =?us-ascii?Q?K3Mu9cL8oLaltcpmH2YzCuQXuR/z2iNde+DeEronN4TMH5pR5dfr0iEC1hen?=
 =?us-ascii?Q?mTpLQww4estfJqfwcD4OEXXrnFSggvFuHEEvZ4I5Zi3ueVwa1dEBU6BsP6UF?=
 =?us-ascii?Q?sF8qAkKTPGrmlEn/ZazyPbOyAi2by4p6oy8eQUuwvcW9pfNSKr9DPbTkIW8c?=
 =?us-ascii?Q?LoA6/g00zSb0Nc/iyYoceGqQoU5aPV4Pap4n2bC4K2svSk+JobLQRLBNERb+?=
 =?us-ascii?Q?n+EEE+eC0tw9KR8Z2RYAGT+9LiR8V2X2tPtgFrY/o0VWFg3AIyAJ5g5sLKVR?=
 =?us-ascii?Q?EAEmWzA09s7p9kjkMhOAl0q7r+YXDwPPafrYN/y7XsyqfM+a6q6Ecz1OmRMv?=
 =?us-ascii?Q?nnboJOf8QqzvUC01h5bXqG8U2wE5TLi/ztkwAxuNFgJVVfoZ7JbJL2nVpmzT?=
 =?us-ascii?Q?N8E3bpP7pNr2Mp/xJmjINb9rCKrF6iBLWGmmvpxtw5phIqdsSi1iGcrsZ84O?=
 =?us-ascii?Q?+mSjE5v2rsc8WBgSJ8RTH2xQUEtl4GXeMDdu5Ta0ac11EAGu7hX7cLxFoXf/?=
 =?us-ascii?Q?oQTppJg8EtDYvtMygiVs7MJDivLJbd6HAqzyS4Y7bGrMRuJtTMZIfB8DH/Kd?=
 =?us-ascii?Q?lY9Re09raIGXb+SkZCYOx0fnUkI0my+bcCSR8ItoOTB0fJ9yeVhY3h55GEU6?=
 =?us-ascii?Q?ojBXv0Vo0NFgKTNFs6E9UUpoAn1kggQ1xJHMeq0NW2U+OsWBbHXHVrqmiuq1?=
 =?us-ascii?Q?IVNNrpA3V3p2+ELybQs94R3Ox/+NrnyNwISqHhhZr6JoXd+/A9zM8o5wnNTA?=
 =?us-ascii?Q?rvJX7mbweWSM3x2Z1Zun+EVLdeoJYtrb5kFcQYmCTos21h9StGrU+Xk1idOr?=
 =?us-ascii?Q?3Scs38BZO1C4Jj+lkk04Vwj79ulVCsJ5MmV9enDHsFAP3pBRNkyjKh2C/lmo?=
 =?us-ascii?Q?KjFIfMXKmjDIj9Vf0ddAR9TdAwOdrS3qOdUmNHk8GfEyg2TIueO90HKVW9op?=
 =?us-ascii?Q?r2QLEN3sEbQeAkegmLbEujO/T7oa59ZjoWkgSa+pRR0h+wQDNEoGUvhsiLDV?=
 =?us-ascii?Q?RnarGRPQerkVGhiQvj1RTpOs?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef027e86-d7bd-4df4-80d9-08d98fc050ec
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2021 09:44:00.7573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5eWyFC3Tc422fWlwoHMuYEdlH+onBBG9LRf7cYC1zXXg72/y6FPohTC5HWf2+qaUsXCpKIECAvJofQF4u7Lv7T2WXw825eJjtsA+/yxdDDE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1888
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10137 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=974
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110150058
X-Proofpoint-GUID: 1nSXDdkPCQZ4VNIgrqps8rfaWTksFGsZ
X-Proofpoint-ORIG-GUID: 1nSXDdkPCQZ4VNIgrqps8rfaWTksFGsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 14, 2021 at 02:57:03PM -0700, Nathan Chancellor wrote:
> A new warning in clang points out a place in this file where a bitwise
> OR is being used with boolean expressions:
> 
> In file included from drivers/staging/wlan-ng/prism2usb.c:2:
> drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
>             ((test_and_clear_bit(THROTTLE_RX, &hw->usb_flags) &&
>             ~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> drivers/staging/wlan-ng/hfa384x_usb.c:3787:7: note: cast one or both operands to int to silence this warning
> 1 warning generated.

Both sides of this bitwise OR are bool, so | and || are equivalent
logically.  Clang should not warn about it.

regards,
dan carpenter

