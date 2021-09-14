Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B093640AB16
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 11:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhINJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 05:47:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:45290 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230079AbhINJrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 05:47:18 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18E9cqpS024454;
        Tue, 14 Sep 2021 09:45:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=ToOACQBrmkUVrGmEdkVLwX57u4niYVaS+/hBJNNIS6U=;
 b=NlbIuB0o1/tK0KtnQIdCXYO4tlG2gbXV26LCQ+SW5Ex9XYNyq4e9EA57nFbNRbIisWls
 b+v++J8PRwd4k5JCxEu+Bk5rasVToskXHWJFAfepuCDYjYeyCzlLN836pecZxuY1nYzj
 tUgoy6/SBsvemA/Vsu2JkEwBSBPXcov3VKSSJc6ZLW1K8+rd7Po3leV6XphPTpviRw74
 jbBdSP/1ai2tDN4BTyw+d3zv11AmdR4OWg53iYuPy8AXf2SlNkeekgDftLam0hBPELi7
 /h4GwN6wo+UUhjTrF4SR90Yp8gNJx4EQbwJTtb6LaVCKLWQOrayiB2VCHdCkqTDGLzBP 8g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2020-01-29;
 bh=ToOACQBrmkUVrGmEdkVLwX57u4niYVaS+/hBJNNIS6U=;
 b=rXr6ALT/XEVBdlBY8C3RwuiWS9smdQwKMX5oe08bgXUr233yp4OTcv50LyG8Jd8cOAol
 uAh1lQBRwYtyIilGfnjQ4UpHbsxX/n/HeInLcwQIIbm1uZNKV5vWmFxdM0J4soLBQkm2
 fC/WF7SBnQhHhQP0cUyhaL0PFj+kZQSTHQNJsc6JpKvXGVUJ+Ll+7hlCYDsIkdnLSSmG
 VF5nJNqkO+nsU4JdA8s1xPYMlr7GwvlO6m1UImmOX4eiNOPe1BHxIQBX+Xx2G7Q0sPCp
 BAUZYEyCLusZzULwNjWHEcEY62zyX5j9ceMU4S0swuFBuGA9m7XJ5p7sHZ3LDiCcVgeJ Dw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b2pyg8jm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:45:51 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18E9jDlp135607;
        Tue, 14 Sep 2021 09:45:50 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3b0hjuv3xk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 14 Sep 2021 09:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFlZnMd4tka5Egmh9ub5FxqlCtOHb6jRio52Pxo8/JwufjsQ2XorJAIDrXmK27T2GtJWOHqoi2MacPx7EmkThAwdHyqE0KpZcTe1ror44u3YWSFZaSxbo5QGWwnkCFNdbmyr4seS924d0EsoLPadOz2/bfEK3CJn2aaQEob7ojuD/447+4LcKXHch38V0UXAremPy/Cj34eDOPVERWZEjxIjiRyT6/lSXf3fbvsY2vzJw5w71kHB8ktSNaiJOW848kYbfd6NIDqmmnL70S1VQTQ1FhELHq3dFm2nYjg7ATrr9Tuof96A4EG/hkq70a0ijO9jUYOd1otETzkV31OQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ToOACQBrmkUVrGmEdkVLwX57u4niYVaS+/hBJNNIS6U=;
 b=flUcRuL8z9DeQpSdQK70/c+WBcmj+FAk72iKWeZidbjHZFQujoQ3ZJVV5WHfwJm5ra+tuPhralj2LmqBmu17WTixPOR8AvUBpfOtXtWa0sidao1lH2akDvG/6ptgmRlPcA5E7SSwKn+iGp2JSb6yuJr/Bn65JUlzd5TM+vStobZXKRSYzWbnfTnrE2QwJzYxejx2ZG1V7umj8JWX4sLGFPUqOF2l+BljQX/AGSlDditnvh4NkRMsKyLZRCS9zNsG7jHAkrvEypYURbIzHPzwQmoH1h4BYAqutg5H12Jb9XP4JlVFMzxIARVaqAMG1ot504OMypSblQX+z5oGwy1Peg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ToOACQBrmkUVrGmEdkVLwX57u4niYVaS+/hBJNNIS6U=;
 b=eEfH3s850vgLD/6YlOHGXqnyPfr/t90jC0xjYZLUfXKGZLP0A0sFRuWee6gDAs3AAUCQAvDO5FW9R9EBIKdxokwQ0d7rrkI9MWgeMsEPqlocJjkLTROffeiha8y4OMRsMpPerR37RBj+UwPsWZoO8Zg49bWmE/YJTNUbicWkNS4=
Authentication-Results: kaiser.cx; dkim=none (message not signed)
 header.d=none;kaiser.cx; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1950.namprd10.prod.outlook.com
 (2603:10b6:300:10d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.17; Tue, 14 Sep
 2021 09:45:48 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4500.019; Tue, 14 Sep 2021
 09:45:48 +0000
Date:   Tue, 14 Sep 2021 12:45:33 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/8] staging: r8188eu: power management cleanup
Message-ID: <20210914094533.GD2088@kadam>
References: <20210911141521.24901-1-martin@kaiser.cx>
 <20210913185110.3065-1-martin@kaiser.cx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210913185110.3065-1-martin@kaiser.cx>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JN2P275CA0023.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:3::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 14 Sep 2021 09:45:44 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 43c86a39-ea18-4128-3a38-08d977646e59
X-MS-TrafficTypeDiagnostic: MWHPR10MB1950:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1950FE26AF3BAB766EB908FD8EDA9@MWHPR10MB1950.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GeGntZHWnJrhXAoq1SGp0iWOco9AfDCyr5k+LzZTEFb/7ssZ3vOKXPKBJ5h237vW0mLCihaz4/d0k07jgtQ3RG7SXky78mN17JdnFR/hwFLEKqiTGvVKrEhRYl6P1ETI5F5qm5T0Wmv9gzPJSRjDAjOytnIb/bjHn35BoseeJYeDAo3/PRb9xRI23mBw1zvkgseNU5FD9qjB96YtZOUl1G85f/MmzkukuqxtLJs34uu8iVHk5qVTg7DluzUcyFdqiacf+5gTU80VBIGjVgqNSmNfeF858ZwOZs03L3WQiHveRSw2dqGgbdGiJMrkkHNaxaqeIqC/xo20xjmiYaQmaSmDy4ATjI+Tu6P6fiXVwnLyOCWestfV7LNztUki08boMuKB86dK9rtmxDPkGbmMPVmR6UsBbU/zwSV+/Qt6FulCauAC6cnYdpFl2e2F0EGDejsZjGX34h+cHlKwO/EITzmL3XlbPN3b4/7g1I7S9YXcwajRkhy8bsQBGFdQROyJrMPImSZgIvEQQg/SXQ6ht9mgp0BmFWQtBNars1Y3zIi01O+Gs9lJ6uVbz/kBqegOeMrTfnuToiSxU9y/D/1NLZ/bjUF63wdSi6D0EkMgrB46CH+5N7+1bkqhSQzNa4vTaxNvlvPuFgkV8ubl7k+2pje6KfCe4GILp6mJN0PzIGwpU312mFTkUaTfOKTglUkjJ43nbAkCr+5DUTKvrSihsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(376002)(346002)(33656002)(66476007)(956004)(66556008)(8936002)(6496006)(9576002)(33716001)(4744005)(55016002)(66946007)(1076003)(86362001)(44832011)(186003)(26005)(5660300002)(478600001)(6666004)(6916009)(2906002)(4326008)(52116002)(8676002)(316002)(9686003)(38350700002)(38100700002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2wAigZ6SfcRg2MQUPJzVe80mzDk70sA6UZUJdsbMUYcfeW8Jqhq1DYb7gPCP?=
 =?us-ascii?Q?0H7z4fIbm/RB6xaRs8Ifonzc5oSf4klbmKoD+Q5TT6E+wZNcziXK8H3kEn9b?=
 =?us-ascii?Q?x/PIE35J9mC1RdPMw7mP2kf2ynGxdNSJ+6t66SyRznuXztxdxnEw74tz6G2o?=
 =?us-ascii?Q?zUYaInYQlvs4keRJiUd6P3GcP+Vj+AxxjXpXRvWAKtn7DDFgZCUav32yCCZ0?=
 =?us-ascii?Q?Ly1vUMnvwYA9hDCLAmyhHf+FOPemr53QvbwRVjR+ts4nQJolL8rdSvgJgayJ?=
 =?us-ascii?Q?HB3dSZXwr3XB8XNx7gxqG4y0ITyGtpJlFgOAkFX2B3nctxSvoC0yPrGgJCkL?=
 =?us-ascii?Q?Wb2PxffviHpQHPriY4924vSEAp5Q98C2d6T1SOPkUGB/d8nOTnciOTsiccuf?=
 =?us-ascii?Q?d/oxyiIeXivkMOdrTyrlDI8GJbmyMNJ+patmrc5X5ns5dWIuR2jeTZmp75js?=
 =?us-ascii?Q?Y8Bu2B55qFfTeZhu9cha3Qv8xOChS2OLwkr+VnDuCBKtoOX3uRFSy0GkfpIq?=
 =?us-ascii?Q?MQ3ee4UedfFJ32zirIfFQb/Po8oLnkAWlNmpxQuL5V3MSaUwRQI9G5tPu8Un?=
 =?us-ascii?Q?O4UCbIgQmQXxUve1tSrw2uidRJR8s4IusjzE7APChRnpaHqTev1/EeiwQN2A?=
 =?us-ascii?Q?v9/ZMWS4tFr694LzvZ7Fzkl0++rbmbROx0QMj/7ajFH/z4gBR2ZLE9hNyxp1?=
 =?us-ascii?Q?oBIKHp7N1BaDXkvxm4XN/e/qxevgHzNlswLzbZBrznanaaywP50ruAOyNAwm?=
 =?us-ascii?Q?OheU+clYhtq6ZI6A45vt/acy2YuMB42WzukEW2CHYByxkXuJbvmHzrnB1z0N?=
 =?us-ascii?Q?O4Cv38xYQxcdpjTEha/C1f5fGFExgyX+xY/5M2sRPXZUeBbgq2+hoyRMC4Z+?=
 =?us-ascii?Q?zJiCAZ5XnF274Y7l8L8eMyJgBtGLKYTk3JB8gkCTy39QpIku/S9GogUYAbmb?=
 =?us-ascii?Q?MQOaHxtSv3iDw+WpcynRUNPZuvPitDwLtJyoTPrZeE6b/SSdLB50+NAvdXdA?=
 =?us-ascii?Q?viFHF55Ny2V55qMeVA/pPYmdzz5w5QurE/QQSzIXxeWHkL1J3vQW+uTtCYI+?=
 =?us-ascii?Q?5sBvyfdF6yFScaFzdANPLXVTrTW+xJNXZNwdcybqWyF0GxgOuc1FQNJgy0tT?=
 =?us-ascii?Q?YbRKpRoHG3KK3E+n7b4EWVFfr9FuFOOYqeQcwpjcblgNdK7D7yiCJCBcb3d3?=
 =?us-ascii?Q?GTeYa6SrRfYD2W5FqvTZgh6nI2iCkRXlIpIgBWGXFqJwtIRdUGA69YOkBGFI?=
 =?us-ascii?Q?hoAMkAhMkCIRtjTo2JFeZeUJZ9wZOBoTBs3kPECMuM8kVSxi/LMMJhELx4gv?=
 =?us-ascii?Q?0uazoYV+3c/x7UDK1aI++sVH?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43c86a39-ea18-4128-3a38-08d977646e59
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2021 09:45:48.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuGfM7cBEPHVHk3LN3RpLqYcOk4yIbgQv2SBBb7V/wfgCYZJ5MzXBuWcrVTxDYVfz8e7xmczj2EB6lJqkJwkxj2kHrUzwiWdGCvyhMd4Slk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1950
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10106 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109140059
X-Proofpoint-GUID: 4_fMPi3Pq7XwqTNCY02s7MmanSWe2wJN
X-Proofpoint-ORIG-GUID: 4_fMPi3Pq7XwqTNCY02s7MmanSWe2wJN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 13, 2021 at 08:51:02PM +0200, Martin Kaiser wrote:
> Remove some unused parts of the power management code.
> 
> Tested with Edimax EW-7811Un V2 on an ARM32 embedded system.
> 
> v2:
> - rebased against today's staging-testing branch
> - fixed one patch that changed files outside of the r8188eu driver

In future, when you're resending a v2 could you just create a new
thread?  We used to encourage people to send it on the same thread but
these days it's more common to start a new thread.  Also staging doesn't
used patchwork but subsystems which use patchwork prefer new threads or
patchwork gets messed up somehow.

regards,
dan carpenter

