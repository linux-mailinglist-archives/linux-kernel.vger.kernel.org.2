Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98153D0BE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237520AbhGUIvK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 04:51:10 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:55008 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237928AbhGUIo1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 04:44:27 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16L9H067018078;
        Wed, 21 Jul 2021 09:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=Zaan1MibUxgAuJpb60kvbJluYkXnFeQYsSDrZWL4a4Q=;
 b=XgvFR0vJDVYxDeL7WPAy22Faof/iBqOS+3Nk8lL7nErrtwE/zx2jlG2LrzX8Ooy7yHTG
 FcEBj9GHEfhfpxfeYiwLoFEnQYNCvRHOixttGzRPKdncAulWkhOUR4VLPtnpgGigi33b
 GrtVoKbKRsa+WZBBTungb4VN3H6dYhhb3MpxE6dIqw2l3Yuge+bwvqoV3qrhFGS7s1Dl
 rfJ4fYlny159nBAwYoNMTj+EO3Hy8EGCRBK1Ra1Q/65EJseGlfACNhgbKKQC5zPuu8Hy
 KwSu05A7Rn2oV+9s8dBaKyX+9BA+S5fHUYGyfcArMhyiPN0BBoYtpskYxr+Mh1x4QfkJ gA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=Zaan1MibUxgAuJpb60kvbJluYkXnFeQYsSDrZWL4a4Q=;
 b=i7yjq6qkpmIY1h/WJRiDlKr0hqsgoykhfk87dcjhTXOu9FjSBdWVMQFVrUnFXB38CVNM
 SZP/5XHEcM+8NxEjIuxU5ezpT2JTWzgwnAwlE6dZTF2Ss2mzOon+lXhVcDvhO0Ijs8G5
 CuBGtr5ECdnoW3iQtqjrEvjGcegE8iLpUtYsyvMgo6lr5/tJd4yhg6XuvKVg5BzymJRE
 xs2eRm//OhqcLOFYwEy+TYrroXny7hA4OrdVYX/9JJgp0zkxf6c/Qo/wsziTMgULIyOF
 U9AhTX5WbM3osNFF2+rqjRicSu0Q1GjLe7TYISBWlKd0Uw3iHNSVMn7bePNl5/TUfuJw AA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 39w83cvvns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 09:24:52 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 16L9LKlu026582;
        Wed, 21 Jul 2021 09:24:52 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by aserp3030.oracle.com with ESMTP id 39wunkjskf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 21 Jul 2021 09:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SqLDYbBSWeiMvm3N2HUYHt2HjdZCV2920pa7N96wG2RCKRZEuEiZB4GSVeJKblEHQc7SFVJEhFGCfKdKdMutOzdQ1IfNfHJV8YhnMGfPuhSTbjfeVC1goLc4HvtGnosJupdfOd0nfw1G92XAk3mobebg0OoBQc4Ybj63JmnOnVMjKqCclv8MqLXhhV+wpDlw6lI8xKnbPeRAzVXQJT214x90A3sP2mwovTQr7GWGlrFEWHjpa8G0t83P2GFupn0LLC7khk5ikxILvAom9o1X1Izvra77ZVLHVpX3EBxybQw0x/mF2zDmvX2+95dYXEmv3KqG3XkdXScd6uXS5OpCzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zaan1MibUxgAuJpb60kvbJluYkXnFeQYsSDrZWL4a4Q=;
 b=Iih4CY0Nt7vxx9af9kxsqdvNTY7Y8D3o0milaouDgdDvNlJ/RgigUTmyeN94cs8Wiyf1ldBCMvIgqWbAMmMXRbv3ziRJ6w2PXN36UXOhpg7iPaE4VWPkN6896pYwO/sORlq6Hc1T1MXxHR7tJ1wtoCCft+u+y1Qph4FkhpVQTLkJYejk6CGez93R/DmXPwNsdoKiorhhk8RRLeS6DwWlnIQzpyyIPggROcTHKCfHf4POm2d8cDvYN4h9KfNpvNEeB/mEPiAmzQ8da+7fT5aJw+38iwxe5koqWrBrv0ZcKJumHB8wTtiBrIO9v/eYdUdtJhbhcrvRxGeTBBNKEpenSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zaan1MibUxgAuJpb60kvbJluYkXnFeQYsSDrZWL4a4Q=;
 b=Ja5reQK54kz+ue09O6OpNPYpkUazKppwa05SfKhCZ4HyJDZQA5h3Be5RM22JdjrjHMZiAIj2FE5/pQpeNHg/agy84WgI3pdo/trh41+JSdxXF56xi6BTsZqrcC5jhcu0LEnr4qPWo8q1FxEC9e525zDjGL7AlyuyxiSV0vKHju0=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1726.namprd10.prod.outlook.com
 (2603:10b6:301:a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Wed, 21 Jul
 2021 09:24:49 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4331.034; Wed, 21 Jul 2021
 09:24:49 +0000
Date:   Wed, 21 Jul 2021 12:24:29 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, David Woodhouse <dwmw@amazon.co.uk>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Joao Martins <joao.m.martins@oracle.com>
Subject: [kbuild] x86_64/xen_shinfo_test.c:109:9: warning: ignoring return
 value of 'fscanf' declared with attribute 'warn_unused_result'
Message-ID: <202107211626.Kjc0WJsg-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Message-ID-Hash: JN7QTABS42YVV33SQOKSCBQQIE3T7O65
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0070.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.23 via Frontend Transport; Wed, 21 Jul 2021 09:24:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d3d02af-11a5-4670-9618-08d94c296348
X-MS-TrafficTypeDiagnostic: MWHPR10MB1726:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR10MB1726298A7DF92E22219EAD8F8EE39@MWHPR10MB1726.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTNWXfcsqGJToIeozHDyPmgjUXWth5i9ISWnLyOYlaM4kEFbTFCpIaXokTUiBKr17ZJ1J1BXNXuonlpNZG815LHk4PUok0Co9x8xQweeMJ5W3MJDvL24IMhN7uZqhCrEW73SFfu6ySj7PDge9QdMnrtyeQhbROAp7G5n5vURMxYoEC+MkhsTN+LQwyInSTLTqBJ7kGxdZeGzHywwJR0gYXlgBvlSCPDRJamfh97lJeSl3FX8KxHJTcrrGkRU0/tJSBY0WH6uiGQAcaQyUhdPqxJKqdtX0l9mQppUcg0UTRNXhLxhRF8Q1vmMrTsHPq239rApJ5Let3DtmFcSPBdj5sdXanWZ3lcVfdE6je5k/tL+JqrMM8k8kbaU7oI7mQV1WY8wcg1kvIK3+zqb/LNhorxo7Hpeik513UfoBBX/4elHqgNZLFVUuE6Ox1cLk4/MwgP6WLovTxH9oQsirO94vPnKXFLJyrfpaR3WRPifOarm0Tm/MkqyfToO/QPb38M0uBhEQ/2ZIauRs+P1eLkPxuyROuvqz+kAygwLPqMYHvCWyMtNetA76k8idc4sCpRc+8PSuaCJhQDViDl5plyMfvyWttaYIcBvoTDRVOhQFpVKpbGzNuK7Yf2J+oTQ2rfqR3nOLZL4KJOm1kvqJkL92hfLLB/8dPvbhZtlE3lxfhY6KteMm5PBpGDnbbjmjUNyff4gx5bUOwP9jdFizRrjdIWPJ0SVGiU2D7fLBcKJhbLshQTE+u8tuqaOQ6E1p7L5P3TaZMb/LCyLK//K3CHEZ0IfxIueNeJRy/b/dXg4NBXYFFtmjpbi17cLHFFykcnM4Brgl2FtXddAyu5GPPYHFA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(346002)(366004)(39860400002)(38100700002)(38350700002)(83380400001)(66946007)(1076003)(8936002)(86362001)(9686003)(6486002)(316002)(44832011)(2906002)(36756003)(6916009)(54906003)(6666004)(66476007)(478600001)(5660300002)(26005)(186003)(4326008)(66556008)(107886003)(966005)(8676002)(6496006)(956004)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vW3mHS3s+HRZkZNJYnqrMcLCQszwT1lNqm3h2U4mnyYT0PTmkXcPkJw8L7wJ?=
 =?us-ascii?Q?sGL2GOMTjT2e0UW3S57myD3vILK0N/VcJRXuqTm65lUGUMllgrtsHDWnskbO?=
 =?us-ascii?Q?MRwD2Zp+X6vFrKgz3Kw4u8uFe+oUKzSqhZmubqkECW6U3kt5GIT6TkJxjHFf?=
 =?us-ascii?Q?HbRWGmhnRDOAOnh75fiFrKFugzY4dPrBOnK/yO8zXjpFCR+/Yd02XaRE045E?=
 =?us-ascii?Q?5K8Orj2hAdfHd4R4lB958jkR0wfUrjKhJTB4E9w2OPgswNiXgJWo4/pLkl+W?=
 =?us-ascii?Q?gL/mLi+fOqkYx/aB0TL1Ht7MW4a+4F5HA4Zwy90BDxWipIojw9tS0uS/OwLX?=
 =?us-ascii?Q?s1yHZQYddMWC3eAWO1Q59P3dnb8UemVhajEVtQDR+ZyB4UjrRVDqK8D/elKK?=
 =?us-ascii?Q?LBouYpqj+Z3PNn4ie5v9VaLFQjzTKcmVNcmjp6RM7ShiEUC3Az93chpmEE9M?=
 =?us-ascii?Q?TJ32Iw9J3wqlNcNLEhrguBsu+ox+6rFp5vV0PFIaQYAKycoQeqfOzpScgFFe?=
 =?us-ascii?Q?Jzwep7bLf4BiwQ8r4QXKUKgqsWKCQ6jrWFWUwadEbOHosVtV6i0WIhRGPHZs?=
 =?us-ascii?Q?Xq5yOs34aH3PkIAjZSUZdQ5T2s9C95x+8GE/9v0BbzY8NAsT1ZRUmzl3Pq68?=
 =?us-ascii?Q?xx84LMrhFcv6CImgr5HfMejF8k2NvwGod9YNhfobVtNsLQksnH63If/+jSsp?=
 =?us-ascii?Q?hWfnAgyyeSg2RX27THxMCQVo8KYo3UhGtcB+yU/1h/7DBFnjgxQRoRwcUtny?=
 =?us-ascii?Q?KrfcUPVE6Wpyt2C+CjFluKwW8B+ttqwD5iVwQlCrmcooAKIhQSG4nEcx8n9a?=
 =?us-ascii?Q?zP+JUk/4jJGM2ZYnfIHZl2AdoNxMrD/iJZ7LudyOL7V2vqGw6pind0hiCoRs?=
 =?us-ascii?Q?5IIKmZnFrgkyeSl+cUAOY62CQVUhxu4Fv0T9DZOOsMeUN3CGhpwuexQU6Knh?=
 =?us-ascii?Q?JxcH94q1lOpx88z7CjMIit4JS9oo/IjJyd4Ox6wj5r4BdQ2VQUthedxCurQX?=
 =?us-ascii?Q?7OnisZtNx4+bcXhtgo6gSoqOAMnE0nO4x7nmMU/uG3VKKqNDP0IvAEjOI1vT?=
 =?us-ascii?Q?5aXJzgJso+v13fSu1mBvcaBGt3TEtP1rz7VxEonxdJguFV74oBktbHpueZL4?=
 =?us-ascii?Q?9LDdGYwSozZ+oeUq6I37XBIpflFkS5y8YSCohdgd85Uq+rhg5wgHN22b8GcH?=
 =?us-ascii?Q?VLpJIqFXEu0zB82NXTTOp8AmFFN3J9kDoTp+D5dNC9iXbBl+EHR7f1plGyon?=
 =?us-ascii?Q?Btuh73v338/Ixs6t+sCmUv7yErFIKakJbjjADdb+9ZD8GAk2AUWhWo4PEeKw?=
 =?us-ascii?Q?CQHeCxW1M78v8HJARBKRSLZL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3d02af-11a5-4670-9618-08d94c296348
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2021 09:24:49.3976
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ywvCwxZZqx1Fnh2nK7u5Z5ZnhVe54owEYxtj5heOKaO6OJ4n8A2UEgguVoRkYp5a98u6mWm+eCnnC/0um0LR+n2MRqT4BK3rVGSsqazM1J4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1726
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10051 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=961 adultscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2107210052
X-Proofpoint-GUID: 1ER1PW3xN3FHXPS8uDfgDY4avNcN3cML
X-Proofpoint-ORIG-GUID: 1ER1PW3xN3FHXPS8uDfgDY4avNcN3cML
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master
head:   8cae8cd89f05f6de223d63e6d15e31c8ba9cf53b
commit: 30b5c851af7991ad08abe90c1e7c31615fa98a1a KVM: x86/xen: Add support for vCPU runstate information
config: x86_64-rhel-8.3-kselftests (attached as .config)
compiler: gcc-10 (Ubuntu 10.3.0-1ubuntu1~20.04) 10.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.3-341-g8af24329-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=30b5c851af7991ad08abe90c1e7c31615fa98a1a 
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
        git fetch --no-tags linus master
        git checkout 30b5c851af7991ad08abe90c1e7c31615fa98a1a
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=x86_64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   x86_64/xen_shinfo_test.c: In function 'get_run_delay':
>> x86_64/xen_shinfo_test.c:109:9: warning: ignoring return value of 'fscanf' declared with attribute 'warn_unused_result' [-Wunused-result]
     109 |         fscanf(fp, "%ld %ld ", &val[0], &val[1]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org 

_______________________________________________
kbuild mailing list -- kbuild@lists.01.org
To unsubscribe send an email to kbuild-leave@lists.01.org

