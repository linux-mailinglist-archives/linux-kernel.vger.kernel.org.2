Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7E83D59C5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jul 2021 14:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhGZMIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jul 2021 08:08:44 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:25346 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234031AbhGZMIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jul 2021 08:08:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16QClMMk001501;
        Mon, 26 Jul 2021 12:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=GKRdJJ28ozN5DvD4lqkp3Oy9vcHQNW4fhXNC8bXCPuU=;
 b=GsJ6Eqp5oOeiX1b56u7DvfsjmrPklkGsNAdBM1o5BOTwpqLQt5cnQhtykTznsuzx1mVl
 g8ROnJDtp0R72uBDIUGD1Cr7FNSnx4nRRdS4y9Qj0dc/v/EDhc1UGOl+buXwA71aA8ZG
 oTwO1YHk+iNBbLo87Ba0uAGpO8lOkaMsV5hmM+AaRmNtjG72sX5ULTfi+fVUnVCIKg5u
 MsXkeEZ2xdGoIAQzVsBIHGNKT2XYg5vCMeoAEUI4DkTsQltu5OAix7Z2d5kq/xqXwd8h
 ae/jjt2qRSBOvTDSlzbhDkzLo1XfjqYlPmnDMgfqPAiNoZyJ/Sf77KN8TtTKDtrVMXTA +g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=GKRdJJ28ozN5DvD4lqkp3Oy9vcHQNW4fhXNC8bXCPuU=;
 b=Icy7yBzj7rbmLLGdQ6tyh4aBJXEtAsZwIKMVi+J8fGIR5PwT+m+Nm5xkCFIdTBkJTHPc
 g2oUoHI11MXc9n5tRwzQUsWniYq0JNZkNgwyNrru+UOc84i82ZgzIPsUtSTQbV+1dDNf
 LUBVlApPyGOSHXMlsGvqAYfC1GXEfV+kormQYTs4ETumJjoQ1jNmdVa6drbIWH3VL6a4
 +W+4kB2mNpQEOg/X/qCDFWFBUKXsEkUow9/xMaVmo2L9Zj8Nk712YLiDfifcF0FaegnG
 Z1QHPZ56TjSnN0nyeMDCHC4eBg3B4rCY+pUDHcfuVirJ7aaTTsDSWEK9hXaoC1lJwl0K uQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a1vmc03j5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 12:49:06 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16QCiha5035108;
        Mon, 26 Jul 2021 12:49:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by userp3020.oracle.com with ESMTP id 3a0vmswvyf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 26 Jul 2021 12:49:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFA3Np5aQzuT4RbDBFtstvfYwgl6MGdQnFBagIuFr8hA434qcxvAAPueNngRr/sgT+fEZQvDlbkI26793WQ6dv8TXnyyZebVkgSDQYtsCgy6ZV6KiTzc0D+oDfud3y+3MDOgArJ/g8sWXzroDLBkBc111x//XGBD4p7DokhatDyprpaHHxSDxcQ1YSEBCbOPpbW3mDCjmhDNBnEoMwo+z4qVvF+s8a6rPNPyPzUtGzk0POyapVZdOcPosO+FdhZ4yWr06kMaA6UmKR8waRxlYwHmBQR5jrfi/3Xk4eoCgBCbnuL8TBiGc+9SWwW+a/sjWT0pUs6EbTIqGz5ar5IoMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKRdJJ28ozN5DvD4lqkp3Oy9vcHQNW4fhXNC8bXCPuU=;
 b=Ed83eunTu9cVVAPnA0w3lmasbLaE7YSgl+VdPA5hlKsNzFGYc+NUo66fAX2jMNEhMdEIPuzRl0QVg5OIp/Ry/Ew9D7vFZTdDzQLhDHg1WLQ+5UR0tkc22iONpA+K1FGMQ+ZcIjNwzKUfnZ4A3IuvwcyrnuYFrmjTep8KCxw0eSbUanEr1RKQASvJxSQECNpG/UKGmLsrxG1r1nxLs6Di+4bJ4R+IqwSAR2VH/28wAOP1b91AxqGLKvvuzZ5RPDafJAiA4yKTMUTdK+QWYQp1alZS/4oGUIgHDYXRRpp44x3jgFzYCoRHvvLi8i5/pgG5vJtqwxFR2z/WLitaayYmww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKRdJJ28ozN5DvD4lqkp3Oy9vcHQNW4fhXNC8bXCPuU=;
 b=TtaI6LnXCktbPO7G43OEKN5+jHZiDX7kls6F019YZFQCn/CdbtYzW8HI7i1t8RqcmroHEQn+b4Lvrbbd/xOgB3UsL7iGrMTmT3UpvnyK5w++O3572XDvH3r+9T8msWw3KWmdBVaM0QMP4YEetn/R0YTlGNOUJE0E3l9N2E7T+eA=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2367.namprd10.prod.outlook.com
 (2603:10b6:301:30::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.30; Mon, 26 Jul
 2021 12:49:03 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4352.031; Mon, 26 Jul 2021
 12:49:03 +0000
Date:   Mon, 26 Jul 2021 15:48:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Vineeth Pillai <viremana@linux.microsoft.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: arch/x86/kvm/svm/svm_onhyperv.h:73
 svm_hv_vmcb_dirty_nested_enlightenments() warn: variable dereferenced before
 check 'vmcb' (see line 65)
Message-ID: <202107262020.UobvBBnZ-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0033.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24 via Frontend Transport; Mon, 26 Jul 2021 12:48:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f16956db-84f8-47d6-103e-08d95033bee9
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB236791C31F0B39D37A8E948C8EE89@MWHPR1001MB2367.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:63;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Haf0CWJocWlJc8UBbTWRX8Bd+Zw33n2iKgA3LAgbc64srchBo8hBuwnkDmVZMZD1+zOlE225EohlFb+wVkqr2+nxHziU5xF/R08YapaoCQhi90piSA2HC2XNA/RsDgPabykMOwpdTxrfA/OF3L8d5KkCEvhExC5okkWFmdo36n2BkwpMA6eAGltTAUmCm4ZWq0yIpmHBGgLVRKxgitxsFgVyFlo1dqHSTLJK+NIA8bgi9znKRKNn1Ts6n3LPs9zkRc1yYSKshFMLcmNoNqm/euwn3uSLmSqXADetVvfQyXrf+nYrbvWgu4ygxDziGS4viwdIse6i1h39AajTlZZ1QeZU3VaSooe6G+HyifCYwjYfLhgP1gjyqoqW2/laUKFthwexe48NhdoVGkX0yQ+pIvoLhGD9eAaYYNWMCqqMbgnzURR4h6sZvrpQBcVofyZ3dndFJWCEALJt1Zr9SOG/8msFJSoDpWaeDaOJFTgBmu1PIzf5v5Et00izNfFOtq1VBLB8Me1LNcKAzX2sBNNPYEngUHRXMKMjsfo8aUuvSafPek4C61esj8qThzM2Js2Dag1uYYH+AdecBYUA2qAP8M7iKTkh8FgJRYuSvkKLm4n0kOL5X0fSlq9y2lTYvfElRvTr5Kw0rIo8Vju+PitM9FEDOrzCvH0FkuEYQLAGfpnUbFiMBIjmnKFJhyLcDZJjawHsiuPJKRrpkdLefN0/h2dvkYHypEPkzZ9X0tMLMLdA4IaqpCFIkpsY3aoad4KPRPoEUgiB5motyFomurPOXi90pCYhcMM8gWVvcrE3IEHorIwXsUj0JOSjyF0yLdgMk+xSlQs159kyhrF7lEoVrlBJpH3hyFMs/Ak8MmKT8kg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39860400002)(396003)(966005)(2906002)(66946007)(956004)(478600001)(316002)(5660300002)(6486002)(9686003)(1076003)(83380400001)(186003)(6916009)(4326008)(6666004)(86362001)(44832011)(26005)(52116002)(66556008)(38100700002)(36756003)(38350700002)(8936002)(66476007)(8676002)(6496006)(14143004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tfQWikdg724qPRzU80C2SgNBRxl8MeexvACfL896/OJHE3SIR6eNJWhEO7g6?=
 =?us-ascii?Q?0a6YlpJkeOIiMxjHLS89Ogsn+eO91eM76rXXuaxLic2LT2+z+kMMyQGQeBRi?=
 =?us-ascii?Q?WsYgtxhx1t+ais+e+3tG68KHvth38/8td9aiDdsatn+rFcK0Xx852h4R7leC?=
 =?us-ascii?Q?H/O/hH75c63O3GLKNnQsXZlxWApR7MxGn4JGJIGsTNF5R5An5Do2cA307YhL?=
 =?us-ascii?Q?c0qRsAIqzRHVdyDWfWjlamVrVplBMub3fGji75f5Fudwwiah/tcZiijt8GM+?=
 =?us-ascii?Q?tqevP6Ov23WvzGq1i2/w5ox83jo/qBbTnhPc+WeIwRZk6eemTnSaR9QDGdyz?=
 =?us-ascii?Q?NixC9HCYuZgxj6fMPu5f3zhPdnGACBoDT5rrj3f8V+rBH2wrz+8xbPCD00pt?=
 =?us-ascii?Q?eegG3pzzekC6AsYFD6LnfvUsZj0Z5dDI+eYc67OfgXzUEvWg87mpN77+78PP?=
 =?us-ascii?Q?GwFvgmDizQgh9OLPBHwkkXBAJdg1u0WpY4tqRnTNtK7Ant0+q60dGKu+K3DB?=
 =?us-ascii?Q?7hk//kWS0zFQhf51HuJXw/RU0NmoKT0HhljoCSRm2fYurqwxFWvaVFf7VNse?=
 =?us-ascii?Q?Hagt9oWnDfRgpo/SxOm5JyVnoo6jmFKReIAJ6m6S0UnFkgQeccTtKtFLIY8q?=
 =?us-ascii?Q?dtoIqzp/Lbr5H4me8TQtH7ATsd9fEUhgt/1emvea9JWR/JDlmBfd45aHZfVQ?=
 =?us-ascii?Q?+6yXBJ0LNsrjRhvZVj1y6LWBzgQTKb/ptYUzAzD3Rpj3GzGU+GnEhmAex/ha?=
 =?us-ascii?Q?NW/wd9f6351v15L8zYL4IXEJAsmXaZovKB1QWc0eWdvjVIOnyek5BzC75qoj?=
 =?us-ascii?Q?pVRJ27QRW4ylVAtaQZCAt1FREs0IyjM/NqQGcYJNKzA5dtMXwCTF8Fj79f/o?=
 =?us-ascii?Q?Os9chMNxUoV51gW8CkGGn54koEisDZQA8HQPkpJQnjOOZm2LRKQGGkJHuNNJ?=
 =?us-ascii?Q?39rAaUhBrMkB9Ev7vejNCpQQurQDzmveT5ddAbFVlb3XLwgHd9bhxVihXcQd?=
 =?us-ascii?Q?fn+rxB+TeMigUuRRXnWe5XUtMEOecNFsx755GI3etY3latV2fYWCqXakHX3e?=
 =?us-ascii?Q?boTtt6aAi5K0m4WYHffSuG61lo+Jjv5L4trHb2wmhE6uKp/PVoQobRhuojA7?=
 =?us-ascii?Q?9a5YbcdAkLPx7xpTnUJvdo6JbjLlISNlfyaBeP8UvVfHlKUCtnbU23LEdp/b?=
 =?us-ascii?Q?PeaQ3C+9PpN7JCz6XGJRHUrhwlHgodm3tmz/xMgzdlltcbARXTW+j/9VNS9d?=
 =?us-ascii?Q?Ttm3d5sWctpEnIkGyfTw2ot5uilK6pguLtPt8Dkgx0eXjWVzMDqgPL+LWkDA?=
 =?us-ascii?Q?FEk0q821MI2XGk3P4TH5Zn2N?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f16956db-84f8-47d6-103e-08d95033bee9
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2021 12:49:03.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XwfCf0eHlxg2/Vdp8Z0ky9k5pSDIBziknpyWepLh9rrN+EBVHZomCoRHcTp8aq93VzHvtlSWzCFmp8ka0iicsl5DEu+htGV5qW/9avPEAto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2367
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10056 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107260073
X-Proofpoint-GUID: jT2MaTOjlzsQGbSLVRchwMAlg5kouoDH
X-Proofpoint-ORIG-GUID: jT2MaTOjlzsQGbSLVRchwMAlg5kouoDH
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ff1176468d368232b684f75e82563369208bc371
commit: c4327f15dfc7294b2abde0ea49b3e43eec3cca38 KVM: SVM: hyper-v: Enlightened MSR-Bitmap support
config: x86_64-randconfig-m001-20210726 (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
arch/x86/kvm/svm/svm_onhyperv.h:73 svm_hv_vmcb_dirty_nested_enlightenments() warn: variable dereferenced before check 'vmcb' (see line 65)

vim +/vmcb +73 arch/x86/kvm/svm/svm_onhyperv.h

c4327f15dfc729 Vineeth Pillai 2021-06-03  60  static inline void svm_hv_vmcb_dirty_nested_enlightenments(
c4327f15dfc729 Vineeth Pillai 2021-06-03  61  		struct kvm_vcpu *vcpu)
c4327f15dfc729 Vineeth Pillai 2021-06-03  62  {
c4327f15dfc729 Vineeth Pillai 2021-06-03  63  	struct vmcb *vmcb = to_svm(vcpu)->vmcb;
c4327f15dfc729 Vineeth Pillai 2021-06-03  64  	struct hv_enlightenments *hve =
c4327f15dfc729 Vineeth Pillai 2021-06-03 @65  		(struct hv_enlightenments *)vmcb->control.reserved_sw;
                                                                                    ^^^^^^^^^^^^^^^^^^^^^^^^^
Dereferenced

c4327f15dfc729 Vineeth Pillai 2021-06-03  66  
c4327f15dfc729 Vineeth Pillai 2021-06-03  67  	/*
c4327f15dfc729 Vineeth Pillai 2021-06-03  68  	 * vmcb can be NULL if called during early vcpu init.
c4327f15dfc729 Vineeth Pillai 2021-06-03  69  	 * And its okay not to mark vmcb dirty during vcpu init
c4327f15dfc729 Vineeth Pillai 2021-06-03  70  	 * as we mark it dirty unconditionally towards end of vcpu
c4327f15dfc729 Vineeth Pillai 2021-06-03  71  	 * init phase.
c4327f15dfc729 Vineeth Pillai 2021-06-03  72  	 */
c4327f15dfc729 Vineeth Pillai 2021-06-03 @73  	if (vmcb && vmcb_is_clean(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS) &&
                                                    ^^^^
Checked too late.

c4327f15dfc729 Vineeth Pillai 2021-06-03  74  	    hve->hv_enlightenments_control.msr_bitmap)
c4327f15dfc729 Vineeth Pillai 2021-06-03  75  		vmcb_mark_dirty(vmcb, VMCB_HV_NESTED_ENLIGHTENMENTS);
c4327f15dfc729 Vineeth Pillai 2021-06-03  76  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

