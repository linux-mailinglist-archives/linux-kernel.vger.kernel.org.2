Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E653DEC50
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235656AbhHCLkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:40:23 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:59162 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235596AbhHCLkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:40:20 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173BVqJe028564;
        Tue, 3 Aug 2021 11:40:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=7I/DsA4EgTYkrqU3w966fT0i0sVbG4pFGG0ytzEROZU=;
 b=bLNlQYSLK489imXg0qR9X+Q637oAsp7kc4wy1ZZOTJlLV5XmR5nDr1+2ginJDbJna9Nb
 weqqEJ7yGL6qUtF/PEy72MZen2nw/qm8+tXvxl8bvfoYsuxMcbuxcdn9WtdEGCnlr8RW
 sHBOyC4u5aw57S2cj50nZ7Ll2XMU49HqAp+8ZEW7LpouQPacb7DmcRa2S0pgIbpL/HQu
 7ifDZfVfazecuEK7t7AWgTP+RDDRW4CX959xORvzZ7NbyDGgaNy7UrWX60yUlOJ2Kip3
 TGyucof7xJKHMXDlMhNhQXtjmYarAqo38CODlL98kNg0w6aBF3vHMY8gFGGh+XNa9yn2 vg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=7I/DsA4EgTYkrqU3w966fT0i0sVbG4pFGG0ytzEROZU=;
 b=DR0goTSJo2OR3aooIsgfHIuTbQE+kvnm69L0mj0jFcI4zrVhWVhoGC/gYGslUSleie2I
 kxPcL3QfURkhheS29WgusEh5fBoDEt7ArMbnqOC8X4JYrytMv4NhmTRpv1/W5fUuN/mi
 yNvgG9lbrWTg3AGl5m2iAGjvE0bjKauRfB2BWs3SZlmpZCveaRP6skuTZJ1v3fczxu0B
 NRzIPsSNBh38SUPGOQ65xpXPRXlnAkmLutVhlaRvRV6fujou8wUYaGXdWeglFT2+7StR
 AHy6CG+XywbEtayWUEEtGpR4qcNJRuXcjKPnzuqMTfdc2rBNoI04kPNbHzrLeGuW7/2u tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a70pjrrwu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 11:40:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 173Bdt0j118767;
        Tue, 3 Aug 2021 11:40:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3a4xb6kf76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Aug 2021 11:40:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nvXjEdvQ2/OLQFNLwnExTPgDl5Am6JxI0FYD9AO2kauwuTebBtFWXcTj/lFl1M6/pqbfKdUUz0t6Zf2ckvOKgIxNUbqBgZzCOmrcIHTvJcgdDgAFqovopLHb76kznCZ9+MVR8rQ+m2WPcWyJvL+V1r1dTAdc8wqZxG+5O4le36+bz2JGDBS+R5UwBfPRRE4t2sS5kFsy38EeCOZWH8V+bjuG5Xx6EOBnY/Iv2EcaxaPaUxVv4H0ca2ND1TTKVrRp7K+Hu1E+sUXdBpCPZEU0Bgbs32O6pcyBmdUx8W8yrzSg3suErqrMLRiCtRWWLQ0O7ECH1rbk9y+OLIwxKnVKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I/DsA4EgTYkrqU3w966fT0i0sVbG4pFGG0ytzEROZU=;
 b=B6VhYHX7Q7CAF0shtaDmRZpn11cqX1ifDrXEsSkg5U/XJnPyWqfX7qvHYxhEy93T1SeFbUAk9PxvXu3DkwI/D1OK7BzTNjUJdd9flnrQ3v94Fc7vTpc8swkQrwWp0PPEQ5o0LYwm27jeLRCXxcV/VsdHwwCmrv/IuJAw5Ao4trZ4I3sScGAyglXj6xEyPnFd7xZE9LlcR2p/CtzcaVVbiHTTMiVbqyXNaH+sAT7f68PbNVcBbLHBCBdRd5gf1N6obEBuCC/3316pmuOxr8yV4n1rjDPvDlaWRZ5QIC5ay9NKxVB1QDhPMTF4rGh4W3uxdwLYDEJEV1143CSGqP/dtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7I/DsA4EgTYkrqU3w966fT0i0sVbG4pFGG0ytzEROZU=;
 b=M3JIiDO5f4cQ717wtrBKK8QKCKZTLEXKROUyCI+F/5tGHurEVcl6v/cWc6RuK1kzXkVaENx6FQPd35h3W2P2dAxgkXC/nyBqQ2t6yg3T1MJG/vcEvPwD02DZTw/xqICxK6A3Db+ikGItQe4+SWJdeZ5fgCmyaODT/A3ebZRJBqg=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4568.namprd10.prod.outlook.com (2603:10b6:510:41::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Tue, 3 Aug
 2021 11:39:44 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::153e:22d1:d177:d4f1%8]) with mapi id 15.20.4373.026; Tue, 3 Aug 2021
 11:39:44 +0000
To:     kernel test robot <lkp@intel.com>
Cc:     Bart Van Assche <bvanassche@acm.org>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [mkp-scsi:for-next 139/143] drivers/scsi/ufs/ufshcd.c:27:10:
 fatal error: ufs-fault-injection.h: No such file or directory
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1fsvqkbiu.fsf@ca-mkp.ca.oracle.com>
References: <202108031810.usXoNW5B-lkp@intel.com>
Date:   Tue, 03 Aug 2021 07:39:40 -0400
In-Reply-To: <202108031810.usXoNW5B-lkp@intel.com> (kernel test robot's
        message of "Tue, 3 Aug 2021 18:03:13 +0800")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0200.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::25) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0200.namprd03.prod.outlook.com (2603:10b6:a03:2ef::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend Transport; Tue, 3 Aug 2021 11:39:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bafd4677-a0b4-4c25-175e-08d95673636b
X-MS-TrafficTypeDiagnostic: PH0PR10MB4568:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4568387E621E30B8982E2E488EF09@PH0PR10MB4568.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D0GZmaU6h0E60oiD6fIoQcI/7vI7TCmVcnB1T1OR1MDiNg0VUKfFXqYTtTbCvzZDUplgKHsw94wzo5HlZNC6E+TL9/R/SrqilnsQv/ufTWJe/b/H3oN4qdFE3HzFYXz2midwWpm6Oqp5NwXH6rO+U/Pti56xJ2LnI1geADOCfsqLV32SX9SrVjjXxbzu+h3unhIn8mXyUFQxraQkmKtILm7I1B/sOxSjKtIEn25NEchXd7hd/KClsUoJBE6Sa+Lp+KGBY9osBudxVCZt+4paNdrb/JCSaTiHq8Ajb/a/3WsJltaKbST4wY0Qy3cuBB7QeCN0N9MHRG5GFAPXAp9lEaBg3CRiVkUH+O6vGK7yYXWn8cNAEfr++LT+S2JcnGe6hsCOOVr4MkSvOzVW6tGAExIGtvt9k+5m6jI/BVcMXNDftPdh3KjMOaa89QW1h/MEoSEDyFw6Qvytbe+85j/kelvgvbBnTj9kOAokSdicRtlHMn5CthSFZVqea+rmUg6msfScTU+jjbP4OvwS8EdBcU77jbw4L9KFf/Vt6zku7AImRccrNN/wPEws0ku0mKqOLRHKNWOgBLxU6p87HGTNmk3l+YlS0zwe9RxhgXng74Kt1RWAj9ccMRimGcPicE11VnRsTcu5+CQM/+59l0bYIaORmeXWcq8ECA4WjAeqpMPY630oQb8nKIy/zL+GUt7UAgND7flBHpvEJjG5J3YfZg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016002)(186003)(6916009)(8676002)(54906003)(558084003)(26005)(83380400001)(4326008)(38350700002)(508600001)(5660300002)(38100700002)(107886003)(36916002)(66476007)(66946007)(7696005)(956004)(316002)(66556008)(2906002)(52116002)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZVzzTdShmdD2zgbd7rmwspMGWEw3ry2RFHtIQce467URI4/aaIua8pGDm2GA?=
 =?us-ascii?Q?1yQ6Xc9PeWJQd4YIu4RRqEKB/jwpNXC6lM0kXhXu2w12U0aiOsVwcSL/9Ayl?=
 =?us-ascii?Q?fY9Ddp4H3xHZl2JldRduYkrGZu+m01Y/TjLRIksTHVsa9DwjCD5mSUZpinxc?=
 =?us-ascii?Q?B9B8chdH1GN4S9v6pfuYsaE0O7EK5LMhEed8yyw9s6hDX61+ffQFHhWxAdpl?=
 =?us-ascii?Q?bu/TJrVMOJIVBjdIkG/ofBN/GI/f933esEpRWrdjrYPcjhBByzPaXqAzX0TT?=
 =?us-ascii?Q?bqKYwhYKuvdZix0EN6dO7YOm1nbN1O5Tl8c1sR6FiZtJ8Rl1j8fT/Tnb9yXt?=
 =?us-ascii?Q?NdBO7LJAxCZkWjkutmQKtEn/8CiGspBFx9hs+UpgigY/+p0yDFYzvgAncnwa?=
 =?us-ascii?Q?kLN+vTYRmxNdPGwU2TU7q0KfOqHBiX9TyzCDV+9daHuskCA7m6u4aHMnJiTX?=
 =?us-ascii?Q?ck65Ofq+xnjsLENABr0CloyHyiSjuMvk8WtvGAGsi4ELvVEv9ccIPz5iBMhA?=
 =?us-ascii?Q?QWcISeLiDjl6PiIJb7yaQKGD60PvZt38bvp2SpgWiEnw1qDdygcpNRGK6bJt?=
 =?us-ascii?Q?X/4V/tUn+UuKIDwRa2VtgbaBK4Cjlt5ur/oKhUEjPY6K1kHq00i673EIpSvv?=
 =?us-ascii?Q?/bG8k+qnsjANFeTdednQgPufkVoI/tIdUYaYH9WjHa8aT9PIBAIg3iSzVxpU?=
 =?us-ascii?Q?W94yOhYBaB6uh0xB2CHiQOSnJpmrfdp3LgcRBedMALjAGQ2Il66GRLzIpMpO?=
 =?us-ascii?Q?P7ArCQkCLQmx1C2hIb+D3HNC9lYEuniNGhNgF/b2kA4WArKLhe/xAA1lqX0m?=
 =?us-ascii?Q?zVPTsLYQhZIMPHPPfuPnyGCM1clIuXwZhf3pBfr0PELzr+SiCdmvegoDK38F?=
 =?us-ascii?Q?jeYnqKlPjJFEHgkQw2sGNO47E0HelM8nze5d5JG+F9MtpOPk769yips8VyBU?=
 =?us-ascii?Q?rjZRP164EY9z8xVCJJypaZd0paEBP86cXnnOK8brPKIU10zyunBxA+9NvW5+?=
 =?us-ascii?Q?zrPdQNd3AvlOWq5fqveG0Ukogk/T2lKyQbNdjuvZ8SPRV0t98sRqQvq7Diha?=
 =?us-ascii?Q?9kJx/NWeiETrt4LJJvVQ3IoTZjywYoa9LKD1TsFcbSoSNb1d7MWbhmefTcXF?=
 =?us-ascii?Q?Meuag/qFcqhxLzu17awj+y4Q+TOEg8vFjOnaFR1dZY4pTn2ITfUFUDOE0IJA?=
 =?us-ascii?Q?ZHjoOMiZajLjZaR5NuZ4hnBemI4vQUNc7jIW74wlXmSU99iFx+AgPgQ7NzKR?=
 =?us-ascii?Q?evgPE6007F4Qe4InuEO9+fxeudO89QMEnAtn+u1ain26Gdb2WwB4EbguwgYB?=
 =?us-ascii?Q?8OnWiJdJWh2ar+O+9b1Qm67x?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafd4677-a0b4-4c25-175e-08d95673636b
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2021 11:39:44.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib5gVJDrWNATbAOw62EDnIZlzzDuf67UJTDzt32YqL2x+NXlenmc61ZE63I2BCfmvuvoAXipDPiv2+tn7/jH0ew8VHnLP0YqC+t78eq69x8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4568
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10064 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 malwarescore=0
 bulkscore=0 spamscore=0 adultscore=0 mlxlogscore=921 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108030078
X-Proofpoint-GUID: 1ECBUl9xCvVJtykqrz_rLmmVju_i1ZFX
X-Proofpoint-ORIG-GUID: 1ECBUl9xCvVJtykqrz_rLmmVju_i1ZFX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> make[4]: *** No rule to make target 'drivers/scsi/ufs/ufs-fault-injection.o', needed by 'drivers/scsi/ufs/ufshcd-core.o'.

My bad. Had to apply this patch by hand due to conflicts.

Updated tree pushed.

-- 
Martin K. Petersen	Oracle Linux Engineering
