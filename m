Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F6AE3E243A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 09:39:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237246AbhHFHjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 03:39:47 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:48484 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230127AbhHFHjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:39:44 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1767bgor030595;
        Fri, 6 Aug 2021 07:39:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=LcZeeUw6xANzM0//49UcfXFlHL1a240J5fkBeveyDKg=;
 b=R4dfljq3qPIcXJmuPUTvHfhDeQyB7aeaIAFDJ9Z4cZHekdtWUglMYtpencabvEJE+SMI
 SsckIYK7b4yoCuH/sSQ1r81hjntOBFAruEGkEErWgtoIdYXXbx8yKHfY0OZpbFF3WRBv
 ceKSNUHTIuDIgNucgIUXd3gYsoImwKKNL4aOGgwbrUOKFZIkysPpPbJ10BtIrwAH06Tj
 iCcEIe5n85ZdY1zy2f0EsEgx1v3/bbU01sXf+NveVfE7jEqNqQEJH0i1WG7SWC5KFef6
 PsTQ1bgWycQDEk1OR83UJfqcex0NcNj3SNkkWMESQ0F5moMJBH+eMDcmq3cwc8v/wZlI Xw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=LcZeeUw6xANzM0//49UcfXFlHL1a240J5fkBeveyDKg=;
 b=d03lBwovt9cEwE8IIqebUAl08R8PzxCML7AWZcTxcYWDD+zk6/Dnevn87eWgFEVUfVtW
 aD3+R2+sTSwm1ta33ZEx54hSV/JqSGZA4pVksKTSER7Y9awiN6X3pk8lTvrwPD90TZA4
 KkO2TIBzkzv9PfTy/fh2630dEYnk9Q5HivdtF1DgFVMUBOofi1Sxe8dqWcKfRczBQlOX
 DovUjF3nGdIr7BLIGjfC837K+Tv8xyRniuL3dp1wU1Rzq+aG46Z7IXAk7Un5mM1uvvi/
 i8PQ+5Uuk7xHzvPHm61Zfgn27rn6papsr/27dhHrDvGK6hqxahvwWguoAvRZa1qfJbpW nQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3a8p6rgym7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 07:39:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1767Zcuw113877;
        Fri, 6 Aug 2021 07:39:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2106.outbound.protection.outlook.com [104.47.58.106])
        by userp3020.oracle.com with ESMTP id 3a5ga1sr52-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 06 Aug 2021 07:39:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eRBxgU2R00HP9hpgHFNX2Qux3sBEzzTyKUMtj1WwsZBuypfMoCPPFm6XauJHqkUO2RH4ljfH+MuYBeJ3kfHDlzXXvwgDA6unH7M+nF3aEHCxPqZyV0Ne2BrrK8uFw+E1C+jG8Y+UgcBc0MCg7Qafh7k263hzZrzN5EU0cy326/Y+RNr+ZcYIQWlnQBG2IHxeAqUkY0DkeAEaT1XH5L7zX+0nguNUNvofHdsJk2kcm7kW5C6rZBl83qw2UJlNMGQJZLpkG23ZsDpwE/S86hE+oMJhPSmZvcNwkI6pRs1yx6tDoMyh0Oa2jvFokvB1Y/Gx7vOXgAtpo2vjl1q7i+sv0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcZeeUw6xANzM0//49UcfXFlHL1a240J5fkBeveyDKg=;
 b=VcjnVX2mvp+fTBXaT1yUq4Au1OIi70X51PaxzR8NboVNMn5a5zzoGX65q6FHGhDq2/TMJd2d/tJepgq7r0/mwq/qmPeytKC/IQ+bLVIC0ZLVUJ2ziEH4mf+LJ57nBK6j6L9vI1ORr7sQa3JsdAF2vJguhGkkPh0HdyzX8cSn+V6mSAbvqWUUxBBEMnwaFKc/UUhzGQ0xA2fbh7qyMt0RO2xTZ8OG1Wr2eteKYA1zNAWjxBxTwgNwykGHrN3gRg2lem2wTYLnfhr7vo3qkibdOejIE1eF/P0f/5Co0ws+yFlsCLnwpL3MKXC3vHzi9gDeMQueyDEsXOyi+VB9I0tsIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LcZeeUw6xANzM0//49UcfXFlHL1a240J5fkBeveyDKg=;
 b=ZXaBMWVP1sX+MAIxThemSXv9Lkizv63CBLh3Khj6/Y1VyuGcUAGy6Lccb7xvpERcV36iSQXMTPeaioC2Zaz7mF1hv7Ex0Kyn+s+0NbqkzrYAiW04CsXxcjj7EcBfliCQT9RSVDRbqhTwD9Bx/depQ+yDt0nOcRIn8oZSnKbVCT0=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4691.namprd10.prod.outlook.com
 (2603:10b6:303:92::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15; Fri, 6 Aug
 2021 07:39:22 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::5820:e42b:73d7:4268%7]) with mapi id 15.20.4394.019; Fri, 6 Aug 2021
 07:39:22 +0000
Date:   Fri, 6 Aug 2021 10:38:45 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Tariq Toukan <tariqt@nvidia.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: drivers/net/ethernet/mellanox/mlx5/core/en_main.c:339
 mlx5e_get_mpwqe_offset() warn: should '(wqe_ix * ((((((((((1))) << (((18 -
 12 > 0) ?18 - 12:0))) + 1)) + (((8)) - 1)) & ~(((8)) - 1))))) << 12' be a 64
 bit type?
Message-ID: <202108061118.ZiCEBH6d-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.16 via Frontend Transport; Fri, 6 Aug 2021 07:39:17 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5765371-6c88-40fd-95d3-08d958ad4e53
X-MS-TrafficTypeDiagnostic: CO1PR10MB4691:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO1PR10MB4691EB7C2718C12749926D808EF39@CO1PR10MB4691.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ous2aYCOUGxlLse+Cb3nREcExhV9xku59MNSMp9Bcb+ZLsqqNH0CMrLh9/WhGkPJtald+Xwa2Ji6c6k6OHwzsrKuvGwPqay+Vfiqbfx5wqg+zcqjA/aS/OTcHanWer/o9FCvEh/3a8gZlVHmRkKRaJjXFTRx5p05ks6emp7sMtMVEfUXONS5dH43lPyBI8wx/VJeG8AY5bSLnO5IJnjkR3mXAP11n32YoggqhWFv7f62hwEw7b/ww024XB3mBEC0w5cdFxx0NgLlcAZZwfNiIMJyX0E9Dzr1vdkiZSFmw4qW5PMlMuCR4NSIpL8xQzR8lDUO54in51nUkq9FxvE2gjNS4lLsqjtK/zm2iTbuVU6nxDFoVzWtE2z1nb7Ztjnx9vNb0vIYMedPDf2L/yoPs7Jaud7IHfgFxcXTAEQsObLICCWJZEt+8qzNsDv6shOywbmLAWU35keLy6mpDoCWvuBOjobqVy6beNvrn1vnXAsFTpfcYM3OxZ0VcIBaK7Vs0kRYLtcUVGfbrUZDWsvozJeA9/HiYqnBF7eYqkHBKXOu7GzjYKrXlNweHYQQBGmL+aNW+MxUHKvcAk8mzjcQHtkSNoyysuV7l6cZ6vDXAotXZhep7aqZJjpAmQ6vMBkVIaWGQq/laNxbe2ZxJyNupZ+QtAHWyBXos9Xct16lrfghpBp+jS8Wh7o55BUX+AMWIElPCZ7M0XRBdi/AZGcN/vPEGuk0Y1HV8KUE05j0IIMWFNzuFpyBA7pEIoxt/DjrKE0Ol12mQ7/bsxerIOW0eATPal/Gs+Xu4HoD9w0YqL8/KLMgQe1B7/pY7wQbpHun95K/j6LMU4y1hVJVFd3ZtJmHDQ1KoiU23MON3ZZBYW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66556008)(6486002)(8936002)(1076003)(52116002)(6916009)(6496006)(2906002)(36756003)(66476007)(5660300002)(316002)(4326008)(6666004)(956004)(508600001)(83380400001)(38350700002)(9686003)(4001150100001)(38100700002)(26005)(44832011)(966005)(66946007)(8676002)(186003)(86362001)(14823001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VNHaufzRMwi7CvXRDlw2PPwSowcuE5zZT1is/S4xC1LMZF0Oo0Z166FJdg1Q?=
 =?us-ascii?Q?mpVStl4h45QzMhpwYTfcAKxWkUnKZK+Su0s7vl0cGamk/iE+3GdUa96Mu7P/?=
 =?us-ascii?Q?K3pFL00x8/K/U+V+ty04RH7DgsYuy2Q0V89OKO2Uuy7uiMtQitIuu8R4MBWH?=
 =?us-ascii?Q?VV2whPujJt6WXXwQkjVL2kpyKG6flgj4MotyIaZ9UFHM9M2QVATYwA+iGF5V?=
 =?us-ascii?Q?GWnp30YcQK5lgVINSltSjlZl4IY1QPwi5s3DPqAv3bXH4qzhMhw2+WQhoBVl?=
 =?us-ascii?Q?NIbNA6EZd1HIpk7CsfG0h/dbQist/Y+6J8Ujaggr71ZiFv9C7JcjYf8KySz5?=
 =?us-ascii?Q?BEnctn7oOVG236woEo+UMjLtoKHc4QPXeIQhGQyR2aXJuB3jMayvu7JPFpWa?=
 =?us-ascii?Q?h/d3xDRvoXux4p2bZ7af3QCwGoXGbxV8JZrHTFlfKSSY67sDiQfzCRD55+vU?=
 =?us-ascii?Q?Fr7VzEoZN9rEc/yUc2riLjUCmZYXp9b8No34g07TEO5QHGs0HQK+TTNsm/ae?=
 =?us-ascii?Q?N1Q3+Oo07tMt+Vfcg0ZoQm4JIK1kB8A12TWEkNfm6AFjU0GREsymokgFGga5?=
 =?us-ascii?Q?vjBJNbqMFSaHYkQFM4mBqIx7s3VSNb34fsEvln/Y3dnh8jykvxTZDA0bcOll?=
 =?us-ascii?Q?48/juD30Fy8or5hRcrCxPc94DyRHDpcT4KX9shi1xDY4OdtmaX5xn0ydnuTH?=
 =?us-ascii?Q?W6lUAMf/gzSaBmG4m4E3lRDbMrYxubvflmllzT1RH/68AU8g9eXzaugnRDo9?=
 =?us-ascii?Q?TjevL08AesDpZfbce39KYBNW5CAcz/wHGJxSqRNzyZrNZCS3SMmmbQ4upniw?=
 =?us-ascii?Q?Eu3MMJYyrwQZAm+E3aYCSzd53SFaXeuyWvPSzMsjUzV0OAiqoFRIOd+1r1FI?=
 =?us-ascii?Q?LNJDYM2k/S8A7ymbZdYRRvhSuh3lwnB1q5M7kHYaCbL24xHY1bd7AawXzpFO?=
 =?us-ascii?Q?wz+uo1WaFvsLLyTXLSvIMIQ1yDlY95U2s5Sf+oT4TrJ/Lf/ohPJqqlINhGLm?=
 =?us-ascii?Q?U01boDJ1eQ3eWw+Q0sncA0rOngdBKPx4414SPg/sKygYFemHrSPL2uNpvxxI?=
 =?us-ascii?Q?sEMn+SGoASL/wk/ZP2RVCwUkK10RUJX5mUNAc7iK3NaEgBJfvNjpga4fyFGW?=
 =?us-ascii?Q?DvvFs5zdC9Kc+Q7QQzHlq5Lwlu7D05BVqoKvU64bW2P5PLm3zdyofQ1buoAa?=
 =?us-ascii?Q?z8lni+9RGtBLWz7CQiWO1NJdF0TJjkmt5rIj3hCzhBUqcPgtRzAg9Xq3NoH2?=
 =?us-ascii?Q?eQLssdHYClUxp0o6ikysbVp/dJEW6zHzezzCL0PHpfg9JAoVKFPCeV3sa/Zj?=
 =?us-ascii?Q?R7XqGAle7uZAHFrgO79dnPEa?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5765371-6c88-40fd-95d3-08d958ad4e53
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2021 07:39:22.0950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NcibOptZx9qfw7DXFYllTBIoy2q+B09a5vVWopQrqEf5PRUqK0gFw3usTAVuUpwIkODvWeeA++CxZTqJuaE3oox+8Av7tx3EMnu3uKiX3h4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4691
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10067 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108060052
X-Proofpoint-ORIG-GUID: 91ffnQM_ELKa6JbdrZkWQHfSrjPwRXTI
X-Proofpoint-GUID: 91ffnQM_ELKa6JbdrZkWQHfSrjPwRXTI
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   902e7f373fff2476b53824264c12e4e76c7ec02a
commit: d5dd03b26ba49c4ffe67ee1937add82293c19794 net/mlx5e: RX, Mind the MPWQE gaps when calculating offsets
config: i386-randconfig-m021-20210804 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/ethernet/mellanox/mlx5/core/en_main.c:339 mlx5e_get_mpwqe_offset() warn: should '(wqe_ix * ((((((((((1))) << (((18 - 12 > 0) ?18 - 12:0))) + 1)) + (((8)) - 1)) & ~(((8)) - 1))))) << 12' be a 64 bit type?

vim +339 drivers/net/ethernet/mellanox/mlx5/core/en_main.c

d5dd03b26ba49c Tariq Toukan 2021-01-12  337  static u64 mlx5e_get_mpwqe_offset(u16 wqe_ix)
b8a98a4cf3221d Tariq Toukan 2017-12-20  338  {
d5dd03b26ba49c Tariq Toukan 2021-01-12 @339  	return MLX5E_REQUIRED_MTTS(wqe_ix) << PAGE_SHIFT;

This function returns u64 but only the lower 32 bits can be set.

b8a98a4cf3221d Tariq Toukan 2017-12-20  340  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

