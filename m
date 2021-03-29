Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2461F34D6DF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 20:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231384AbhC2SUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 14:20:02 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:13016 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231508AbhC2STq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 14:19:46 -0400
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 12TI7NsT017284;
        Mon, 29 Mar 2021 11:19:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=QmgZOQltfC2B7DAumZOXeYFw6BtSbaQX81VqfE8oUKQ=;
 b=b7pfABvO+mF38Zh1mgvsGiUOGHCKuZFp3SBCggdTwF9m57Lqvx0HsQwWbc/aTeSg8k5g
 0AH5rTo17vB+4NCkZ465fbAU2UhemeU/PGDUaCba6yMyxqapTcu5XtOD8OT3E7PDspkF
 ZZVLWrF/Mcq39nePv4g1Ta8YZaxYqrUedTY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37kkjh08ea-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Mar 2021 11:19:16 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 29 Mar 2021 11:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U9OuEMCPSbW/FgTEceHH30HzM5omFFKldErtB/iZxnz7wHCBwOnbJATKtgqJcbJ4noJ5cU1R4q0Px9MpbqXqS8HCF2chMY/F85csXwqo+hdJ2sJ6my4IskD/7eVlOwbfKuylXIM/EGusOeuR1BA2mUskW/LHBrmlBq1wCpinrZShvUlsxm5VJ+k3bM96PsK0rXKz2gHdzJJfg/iyGgQlFEpoSfDkpgg2jTOTE6WvruKGYcfKNTSQ5NfIiCrCAGrdejrD8z8iFCGjKGrOD1hur9RsH7dT5BdBFb+D1kG5Zi2fwYhmbmJ6q10chRBeJZw9MSs4eRZjkEGzKy32mIcv8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IA7a/8cQADhNGQlPf4VdEP8ikwfE5bhiMJY6BvzGbhg=;
 b=E+7MJXF1pe6w3tHZztG/S4P3B86piEKHKkVg3oCrdnm6p3uLfIs2f30NkeXEs7C/02CpKyvYlteWSwY3Q055x9HGnHslQvqB9CKp3qxv59zsLcKMnK2RqpO4OSBINqIhOCCqtA0HMOjq8PKJH4zGSrSZXbmDpYRoHvlVC2Qfkz4ypelYN5rU4B0/mAYdoq1YKcA9fWQJVSvThi2h+FyRofHbSeJOGA5RDZTa9Gdo7xcdzECMyDbTEYGf/5D+Qe0ss3IG2/vycYF9V0aslnXyHOvBM/bid8QuYORHCobGoZrS1jFCzAGyRs/70JDotXSvPj8pTTTfjIFebgk6Y83W+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4136.namprd15.prod.outlook.com (2603:10b6:a03:96::24)
 by BYAPR15MB3079.namprd15.prod.outlook.com (2603:10b6:a03:f5::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.29; Mon, 29 Mar
 2021 18:19:12 +0000
Received: from BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99]) by BYAPR15MB4136.namprd15.prod.outlook.com
 ([fe80::2c3d:df54:e11c:ee99%6]) with mapi id 15.20.3977.033; Mon, 29 Mar 2021
 18:19:12 +0000
Date:   Mon, 29 Mar 2021 11:19:07 -0700
From:   Roman Gushchin <guro@fb.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        <lkp@lists.01.org>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>
Subject: Re: [percpu]  28c9dada65: invoked_oom-killer:gfp_mask=0x
Message-ID: <YGIaG2LecGEWvaGY@carbon.dhcp.thefacebook.com>
References: <20210324190626.564297-4-guro@fb.com>
 <20210329083715.GE3633@xsang-OptiPlex-9020>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20210329083715.GE3633@xsang-OptiPlex-9020>
X-Originating-IP: [2620:10d:c090:400::5:aa8c]
X-ClientProxiedBy: MW3PR06CA0026.namprd06.prod.outlook.com
 (2603:10b6:303:2a::31) To BYAPR15MB4136.namprd15.prod.outlook.com
 (2603:10b6:a03:96::24)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from carbon.dhcp.thefacebook.com (2620:10d:c090:400::5:aa8c) by MW3PR06CA0026.namprd06.prod.outlook.com (2603:10b6:303:2a::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26 via Frontend Transport; Mon, 29 Mar 2021 18:19:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74bf77b3-b855-4e8f-d99b-08d8f2df2729
X-MS-TrafficTypeDiagnostic: BYAPR15MB3079:
X-Microsoft-Antispam-PRVS: <BYAPR15MB3079F47A7EDF7140BEA4F80CBE7E9@BYAPR15MB3079.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rqgks1uFL1j1J9YZSGxkRc1HMZki/VoPwkyBLuM3w7JtpkVgrPHg1wTgTgTGBRi6bPfJ6dTxpU6xfMvHKzTVRZie3J8mTfEMWwugYxamQd0e7AUGqxd7LhtsGsQbAECq4Njb+egxsrjSs6ktb/FwHpWrwTm6wlTLzCIBJB7HFuRbWhyQylxJFtqm9uVfO0vWkTNZlwuZybs8pBBvKU3T8+jreEouX1QRYDMU35Wq7QgzXo9v1t3YSgUNjN6QiE3rNkpwP6tjKxYiZC9E0gfWp/QRA6CSrf6oUZ0ek9MLZIsaLGzcoAzV2I/uukDnNNJYgzTSF2Xpl0g3Rxa8EuT3L2KEMXxRVDmRsDG6ioBAOS3FVRa5i3XztmoXxdvbO/BdIxa4If6/24wGSCmzKvzkOXAZiVi6SmyX9+N5UF8yehKQqgQZbmdr7Y8OAC0evNnTcf/Syw29PKnpt1gUzD8nspKLUU9FHwb0FCn9X+GZkl/NpFDf9UfdYmLsxAON2NksZVCRL4kxXdcGpy4igCMkPxMt8TDAhXHiPgdRSL3P9tTjHApAq9DwGYPBO7B5YZiJ7Vi5goSGlTb5n9ZRJ/PR76F3Lrx1wdNY5eLw0o/UYZKMOM5ILjRQwT885YrJ4tzj6eLf5QVoAlPVugA7au3uT/dMhMWN8f6tCodPAZ2f5M71itLc7uT0UZEtDhMNDTbSYlYUBHLcTfKgahXh111PP3npmJr1gKqnVU1Bx91Qecc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4136.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(376002)(366004)(346002)(9686003)(966005)(66556008)(478600001)(2906002)(55016002)(66946007)(83380400001)(6506007)(52116002)(7696005)(4326008)(186003)(8936002)(5660300002)(316002)(66476007)(6666004)(16526019)(6916009)(86362001)(54906003)(38100700001)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?zzL0bHns2Yx3iRrJ+DtHf9XVy2zruHrqmD898aRBLYA7tPx7pgBhmhIVXa/X?=
 =?us-ascii?Q?po8BIKh6mKKI9rC9jD5gI22L969mxB5XOvTlQDGsKaG3NKhoOk8XJrQdnaPw?=
 =?us-ascii?Q?bOyfw5sBeAa2aThDPplUYrEpC+AN7wBsHiOnHncvR5wyvOZrlEZPdvwkhYyZ?=
 =?us-ascii?Q?SgIB56ILKrnwU9dgkRhf9lu1suBW1cR9+a+cWVnSBJ3UgtlGgzNXfg4XBRF+?=
 =?us-ascii?Q?iDSYlGRMbR4RIOZ2KjSK1EASgr4WGTKgop9gKPenoCxRsucvL3TMKhK4Ncd/?=
 =?us-ascii?Q?UfUTqz5QCxVRf/ccx22q8he87rPvUwJ3bDTIuOm5bbh9V/mf2ZvOU9Ujlvuu?=
 =?us-ascii?Q?aiVvJWxqgJIxFyWVi3chj5N1R+7qV1XKdG8Lx6WEcA5f1KWbr/JNz6fUG0z/?=
 =?us-ascii?Q?cHV/V7TIdGVwQB9iuuE118IarmsxvR7skMSwiRA6Z/OO3/JVsMj6uvULHdp5?=
 =?us-ascii?Q?sQccdHBXMkOA2puVl5WfdL0WSWtsvxdTG7funn++4AQZIE52er35yTXfJW9l?=
 =?us-ascii?Q?UlvxQBp2Y91peVwoU+FnpMqh5Iy0dvYhsuV3zeodEFwoXRcBxUu1VmK26xAA?=
 =?us-ascii?Q?EV56x0K6JM66dJcwRHbSZ8Pv4O2x2rxlg1IeBOBnJDzPys8FCX13akn3d6mX?=
 =?us-ascii?Q?g6884fOCHGUOkeq4bx1GTIn0I3/JTxzRXJ7j3+zlH9UkOOhXxmVwMLTEooko?=
 =?us-ascii?Q?ETHGfcvUW9fBh5KXElmnS8/RQUT1BiWLjo5aqPpam0eLCsU24DZGsBZb5wKw?=
 =?us-ascii?Q?/4zp/bllAPmYrzLNQ7Uiyt1TL5C57DJij+iOeQ1vbWxC6jtlY6/EP8Deev7V?=
 =?us-ascii?Q?kr2Mb1sohkcItKBXr+xSmwsw8mYbSlU4Kr1YFJHItjZ8j2ksfvR4e7mhnWtJ?=
 =?us-ascii?Q?mnZobGe6r/hIgCF0SoCDsWf8zWrXMdocSeb2O1klYRW2IPucIH7st5f2sD2S?=
 =?us-ascii?Q?4yLCHxzkr9eqCf/YTU9IDdVzYqh4XSGGltWlI8JsNB+tVvD16LE9DZdexQN+?=
 =?us-ascii?Q?J3qDngfz+8jb2CAkIPsxju/BLTNTYrMSVGzdH9R6RnfVHTFf9EmRrjG5mRU3?=
 =?us-ascii?Q?V9gI+Noo69bB2r6k6XMDffy2NU4PT801MnzBB3g8gszPF1ZeE88Y7P3U0sAP?=
 =?us-ascii?Q?CG8wUAih4E5C16whPkDGbIpCmsMvMZaZU1ywm3+hTUdZLPjxduwa6FVjWxOz?=
 =?us-ascii?Q?So3cfbBjr98aQmXmhqOc13N9jXUx8Vyngu+t/VTX4kGVDtwhfiCo39LFboxX?=
 =?us-ascii?Q?fHi61mPaes18GuXhWBULMTbHvGr3p5/YuulYhlA05zM+MLx2nucE7hOGgegL?=
 =?us-ascii?Q?p2QAMtywLNbUWNk4nxd2OcvfVQTatHn9H/hSh/+JShI9yQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 74bf77b3-b855-4e8f-d99b-08d8f2df2729
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4136.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2021 18:19:12.4178
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILiIbK2Tc5/4/c6CM8/Pci6ZjIoP7v+t/gOg2go09+v1rx3NYNO3tdZXxnBv7Dty
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3079
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: 9uWdvbYqGMO8sgZFQlXn1TuIXRR67h25
X-Proofpoint-ORIG-GUID: 9uWdvbYqGMO8sgZFQlXn1TuIXRR67h25
X-Proofpoint-UnRewURL: 1 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-29_11:2021-03-26,2021-03-29 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 clxscore=1011 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103250000 definitions=main-2103290135
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 29, 2021 at 04:37:15PM +0800, kernel test robot wrote:
> 
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 28c9dada655513462112084f5f1769ee49d6fe87 ("[PATCH rfc 3/4] percpu: on demand chunk depopulation")
> url: https://github.com/0day-ci/linux/commits/Roman-Gushchin/percpu-partial-chunk-depopulation/20210325-030746
> base: https://git.kernel.org/cgit/linux/kernel/git/dennis/percpu.git for-next
> 
> in testcase: trinity
> version: trinity-i386-4d2343bd-1_20200320
> with following parameters:
> 
> 	group: group-01
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/ 
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +---------------------------------------------------------+------------+------------+
> |                                                         | 0a6ed3d793 | 28c9dada65 |
> +---------------------------------------------------------+------------+------------+
> | boot_successes                                          | 6          | 0          |
> | boot_failures                                           | 0          | 6          |
> | invoked_oom-killer:gfp_mask=0x                          | 0          | 6          |
> | Mem-Info                                                | 0          | 6          |
> | Out_of_memory_and_no_killable_processes                 | 0          | 6          |
> | Kernel_panic-not_syncing:System_is_deadlocked_on_memory | 0          | 6          |
> +---------------------------------------------------------+------------+------------+

Found and fixed the problem. V2 will include the fix.

Thanks!
