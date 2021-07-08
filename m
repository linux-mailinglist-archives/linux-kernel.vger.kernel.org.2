Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6513BF9D6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 14:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbhGHMKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 08:10:05 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:50564 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231795AbhGHMKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 08:10:04 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 168Bv1Ca012170;
        Thu, 8 Jul 2021 12:06:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=NtN8YnO0A3CU0EUvDp3W7MmuM/OLLh5QOipwUnRhlNA=;
 b=ObirnAUOsVeFVKzY3+T+jiHS5CU8KHMlKW/l6bwjUikEPc7nhr3rsEvSMVJrRM38aRQM
 hI3wFPiQnHOtuXT8FiUNxXquctwmtOoG/kPo7wI+DqkCmDUaXe9V+xH3VlLUny5J5+/t
 ihv0Gt500y2KO80luzjoH4fylT+QLrWB/wq0BrPIPe3hvYge4XORBhRJcbNF8CnpUb8b
 bPzfhKYpyOjBMsnSDEhhX78+HY1Sb21UMjC94MiUZa3zNPnC0Nj04No05Goc/+7IRqcL
 XLEkW6v4yzQhQCWJ6UVemxXkF1eVkWpKz3aWvgVBtXlHJcBw07TX8/1oa219IfDkh5x1 zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 39n7wrttax-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 12:06:43 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 168C6Dis129885;
        Thu, 8 Jul 2021 12:06:42 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2042.outbound.protection.outlook.com [104.47.74.42])
        by userp3030.oracle.com with ESMTP id 39jd15fqqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Jul 2021 12:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIB6JgtkYzScy3DEwzzyl8bqQCf4E7NmrTuaXeWkP2zqUeJnpYrb8D4j6X7wLLgGsiOb+fl3eah3T7sWHCE9fgVpiUARen6ufBTAf9qFbwtJi9BWDjNnl92MCMSKlUVGYGH0eIvA5+nxIX3oQk/784Fs2UdX5s+6XIWExTJoHMXr7CKPnL0VYwbydDi3EQqnSgwiweciyEhbhOprMqGcMJOXoWTQ61iLfAoZBjcBi8IV16TABB3/fUajNSd4A9T7a/TnJGLsjuRMDzFwvtUbqBRyCYDnSt7Cu36lX9y7viJfM2fHTBlitw9tDqjIBkB1U9roIVj4tircb1pJsB4QQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtN8YnO0A3CU0EUvDp3W7MmuM/OLLh5QOipwUnRhlNA=;
 b=B+kMROoMfsnD0waAkeMRlVHy+lxXI9QyhM3XJiVhjYuo738gVOJ/LKCKtzS1cVlE00Kx8ESOcv4mADgUi/6jMDzd+8Vw9AT25ShJaZPjTP0DfOdhs3dkI9xYbpEClWYnXQOYFDsXTEmB/7Hn3vFu6p068q7naaQl9DtMdSQmQ9IMAjx9WTy8k8n5D8oY3iA7Hex5P7HGK8ea1e3YBOLSXIOlYl/uxN2KOZ+h5mw0+g3+oMj8ziUM0A7LT7Z4tlwSOtozDlR2Tn0MaxNYD+cfKgRT82/uOrFPnkUe5/PlC6kbU3IsDjD/Buv9Nf+YkXT+yCToWxkHpimogLNrdjKc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtN8YnO0A3CU0EUvDp3W7MmuM/OLLh5QOipwUnRhlNA=;
 b=ENYBjeUZrYkfuCbXg/xeoIIsQAkdsaF7JK9tpfA0wpKUmtSnKtm8HUKpB87k3/OOTrGYjKUEwDrE44jaakYlKscNmLFxAdaTYOlkdoTOPSbI0/nY0YJClQKsSkXTXMwrrlO52yQzZbbbOUu2ueLJ1/Rxtm8pHljsOT6JaGBSexs=
Authentication-Results: lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2398.namprd10.prod.outlook.com
 (2603:10b6:301:2f::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.23; Thu, 8 Jul
 2021 12:06:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::3413:3c61:5067:ba73%5]) with mapi id 15.20.4287.033; Thu, 8 Jul 2021
 12:06:40 +0000
Date:   Thu, 8 Jul 2021 15:06:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Anup Patel <anup.patel@wdc.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [avpatel:riscv_aia_v1 9/18] drivers/irqchip/irq-aclint-swi.c:262
 aclint_swi_init() warn: 'base' not released on lines: 257.
Message-ID: <202107080927.vpWBnLoc-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kadam (102.222.70.252) by JNXP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.19 via Frontend Transport; Thu, 8 Jul 2021 12:06:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8315b9c2-f2d0-447b-fb3a-08d94208d7eb
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2398C0E7BCC35B82600FDF008E199@MWHPR1001MB2398.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:425;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7UoK3ALSFIRZch/RZZsQoSYRhr/il5XuQxtbdMs5T3dmR+g8sSwzGJ1MEUr81OzVWXOH1IT3CWWfVKBLvwaAAZii4ti0cuKZ1i8CUPmYclKIr1nc6ahImhIEAkYXN6u3OQAqH9CWLgC110aznAiFdZNh5OYXLEdTf5bb3FXlEaCUC739UVMmAtD9BpEdmAgmOYdhLJhHeuh5hDqegreEw9juMaJ1jDGcnT4Z9A2/TB4YnRORQetzSkDPEyi7ICnB1b9xG3yV4DkqDDrV/oIis0n3pcLMHehHC9I8FqIWFl0zTzupM5bolo8E9uriI1hVqAiZHqOsDO3WFCQWL9pJS2TLWBbbP/N84+XkVFdOkMA6hsqcCNNUeQJ4ZvzL82gEpvPMcZGdbkTPw4Y7pHJvnitghv7dnQp4MkHGK/rKYlu2nU0QHxuIpSB4Wl+6kkv9jsqM0HygYCpMN5ra9OESR29Xv2Myeg/nSdSrp4nHNqKhZlh4o7CC6cDfUpi8FjCeFlhrMh/i4OIYt0WEl6v9WV0q6Ca3npxEJ8kCjLvAZ3F92Sr38CHBVbzLQTmSxOCA34b/N2NcP9M9AgFplqwYCCZfhZJpwBGIKeIYrXGsHZrOi830OGyVVfZY4f2TkCzpPecJkTYyosXBC9hwxEzxM4tmdqXApIqoNgSweDlyMQZrHE1Wg/3m2ew0mSIxYGPCKsPvhjX8O2Ib3SOLGmIdxuyocRliDZgmxvdz9WFEPZT6AruRe7EG/sNqSGkPqd0Nw2FwAoN/jrGr1NUUQpVjIW7y8Sxlr6uN2kkedYLEvXiu5S2DTN6V2dbQiwWVpeGwGnUW/yP7YGH0ZI4/P2DTjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(136003)(376002)(346002)(39860400002)(8936002)(6916009)(5660300002)(966005)(186003)(6666004)(83380400001)(6486002)(66476007)(316002)(9686003)(38100700002)(26005)(478600001)(36756003)(44832011)(38350700002)(86362001)(956004)(8676002)(66946007)(2906002)(6496006)(52116002)(66556008)(4326008)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o/IIsQxZ+frVJ0lkLtlvPz3vvdNi4QJGJ/45xYqBnEtcIrd+/iEceWNeYwI+?=
 =?us-ascii?Q?fuxXPawnhwVnECSfs24YXBrhfpp8mF6vcUcIkbbrDQq8+dOCm5/AKq4RhJS7?=
 =?us-ascii?Q?hnfbjKocOF/JeHrNt+tHvpbYsnukQqNz0VzA6eZ6ytpnYmW7QxWEyk8t28U8?=
 =?us-ascii?Q?ASZOVUtjc8m+XmmmfFyhNM2EK4dJhGQEAG3Sa7MN8XquVOOjZUGNW0f9soBl?=
 =?us-ascii?Q?idAVy5fHqoBpkiMjiC7NV4x0mp2NZqrKdwc5K5JI381h45j+0cytlKA27a1r?=
 =?us-ascii?Q?Y55pjJT0Q6u5tcxrKt5sQ5CpL4q/nY1LII4FECXNqwXPvHIB2upEwTEyTO/s?=
 =?us-ascii?Q?EwhdjH6e/77i0quuFoQkAuwflBBDJ6Jpwsi07kdrss+Qj+7119dXHOK8Th3w?=
 =?us-ascii?Q?yWR6iE/Jy0RJvaIXiuwj+A/lVPuYDxjlqPeMw/eXWcS2r7qjMmzmm3LriBe1?=
 =?us-ascii?Q?bOyJ0NPlOCVx3KWm1Gbd7oMKQ+p1N3cuUh+BdCvH4Jd8x9d8o7uu9p5mDrba?=
 =?us-ascii?Q?L8qmULt+bsdK/351nCouamtElFXXrldzFVfPFr2J0DFBLjivI4mw6NNOaked?=
 =?us-ascii?Q?/ggopRKNxzGctGsIXI1qpSSh+J15Ln1166eDC33WpJZT5TPmCdafy6jCtSMu?=
 =?us-ascii?Q?bd9hzziTht6apB/wmzYwDRIvp4VxYKQEOiKpFQ0sW8nMM5uVnfCzga6kWpJ2?=
 =?us-ascii?Q?dxkvHgMLyKYomn+hoDFpq43HG2hue5TsAF9CkLnjZcG1X+zmbV8qWxR/BlDW?=
 =?us-ascii?Q?ehUwwTj9LN4qPxcDV5DimO2tEIw+rs8Kmg8uqyU8S3VLo4YLPoP7E5+9MQwI?=
 =?us-ascii?Q?BryiXNtfI7GRNnV0b5yW2XgOqosc99BKZpBFYNMLm7TJpgMOg73KySWId48w?=
 =?us-ascii?Q?zUEpDNP9b2tkK9RGTQaeGUqfvX/gmRlakzQuhDGHO1dc/kAez8Rfjfwp5pAb?=
 =?us-ascii?Q?QUyFSNckJ5wgarkB2wfy7P694C8XkZaYPrO3s6s2APjPEtmcCWzesj7NHBar?=
 =?us-ascii?Q?XT3p8DkaaakoYFai7XVT/tKAvZvBj2nduN6MiD1UkH8/vYI2K23dEk5zuOsM?=
 =?us-ascii?Q?gvPpgZw4/YHttanywVW8KvoEFRQkaGlne9t/pIViGokm5t8xuG8/qQ8HbC3o?=
 =?us-ascii?Q?q6Hv30qbGieaFUjiNgHuv9dVgIQwvB2Eoq1jq8tEJpbhfTLUQltHqXTss7fw?=
 =?us-ascii?Q?2PT0veXqAnszI36ulst/vxZEbMAdmyCcXPupcnsxm/gKR9ynwhfxxq4Ie8qH?=
 =?us-ascii?Q?UgW1VB/Thk8Lk/7LNrYiUNkLZ2o3sX8DD5CkADNVHON6g/NQ3CbMxbh/WUb5?=
 =?us-ascii?Q?Ki9cuDqxt82zCFarWUR84Hak?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8315b9c2-f2d0-447b-fb3a-08d94208d7eb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2021 12:06:40.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yr+6ppdbKfJKm18V34esWVosixRsHKmVRRWscrRsfyEqvONO29+5DChitBgUTNU+dpDYSJ14gaErhtmjr6zrAKOSB/xzdgKNkW3qj5sHu4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2398
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10038 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 phishscore=0 mlxscore=0 bulkscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107080068
X-Proofpoint-ORIG-GUID: ZATGdsCOZuMR9S6MEfNXrQnhOQ-m13mu
X-Proofpoint-GUID: ZATGdsCOZuMR9S6MEfNXrQnhOQ-m13mu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/avpatel/linux.git riscv_aia_v1
head:   e4b6f153340e5471c82603f7b08226ba6e2c6249
commit: 5fc4912d191fc3f4c620e76d500ce19e136d54bf [9/18] irqchip: Add ACLINT software interrupt driver
config: riscv-randconfig-m031-20210707 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/irqchip/irq-aclint-swi.c:262 aclint_swi_init() warn: 'base' not released on lines: 257.

vim +/base +262 drivers/irqchip/irq-aclint-swi.c

5fc4912d191fc3 Anup Patel 2021-05-13  189  static int __init aclint_swi_init(struct device_node *node,
5fc4912d191fc3 Anup Patel 2021-05-13  190  				  struct device_node *parent)
5fc4912d191fc3 Anup Patel 2021-05-13  191  {
5fc4912d191fc3 Anup Patel 2021-05-13  192  	int rc;
5fc4912d191fc3 Anup Patel 2021-05-13  193  	void __iomem *base;
5fc4912d191fc3 Anup Patel 2021-05-13  194  	struct aclint_swi *swi;
5fc4912d191fc3 Anup Patel 2021-05-13  195  	u32 i, nr_irqs, nr_cpus = 0;
5fc4912d191fc3 Anup Patel 2021-05-13  196  
5fc4912d191fc3 Anup Patel 2021-05-13  197  	/* Map the registers */
5fc4912d191fc3 Anup Patel 2021-05-13  198  	base = of_iomap(node, 0);
                                                ^^^^^^^^^^^^^^^^^^^^^^^^^

5fc4912d191fc3 Anup Patel 2021-05-13  199  	if (!base) {
5fc4912d191fc3 Anup Patel 2021-05-13  200  		pr_err("%pOFP: could not map registers\n", node);
5fc4912d191fc3 Anup Patel 2021-05-13  201  		return -ENODEV;
5fc4912d191fc3 Anup Patel 2021-05-13  202  	}
5fc4912d191fc3 Anup Patel 2021-05-13  203  
5fc4912d191fc3 Anup Patel 2021-05-13  204  	/* Iterarte over each target CPU connected with this ACLINT */
5fc4912d191fc3 Anup Patel 2021-05-13  205  	nr_irqs = of_irq_count(node);
5fc4912d191fc3 Anup Patel 2021-05-13  206  	for (i = 0; i < nr_irqs; i++) {
5fc4912d191fc3 Anup Patel 2021-05-13  207  		struct of_phandle_args parent;
5fc4912d191fc3 Anup Patel 2021-05-13  208  		int cpu, hartid;
5fc4912d191fc3 Anup Patel 2021-05-13  209  
5fc4912d191fc3 Anup Patel 2021-05-13  210  		if (of_irq_parse_one(node, i, &parent)) {
5fc4912d191fc3 Anup Patel 2021-05-13  211  			pr_err("%pOFP: failed to parse irq %d.\n",
5fc4912d191fc3 Anup Patel 2021-05-13  212  			       node, i);
5fc4912d191fc3 Anup Patel 2021-05-13  213  			continue;
5fc4912d191fc3 Anup Patel 2021-05-13  214  		}
5fc4912d191fc3 Anup Patel 2021-05-13  215  
5fc4912d191fc3 Anup Patel 2021-05-13  216  		if (parent.args[0] != RV_IRQ_SOFT) {
5fc4912d191fc3 Anup Patel 2021-05-13  217  			pr_err("%pOFP: invalid irq %d (hwirq %d)\n",
5fc4912d191fc3 Anup Patel 2021-05-13  218  			       node, i, parent.args[0]);
5fc4912d191fc3 Anup Patel 2021-05-13  219  			continue;
5fc4912d191fc3 Anup Patel 2021-05-13  220  		}
5fc4912d191fc3 Anup Patel 2021-05-13  221  
5fc4912d191fc3 Anup Patel 2021-05-13  222  		hartid = riscv_of_parent_hartid(parent.np);
5fc4912d191fc3 Anup Patel 2021-05-13  223  		if (hartid < 0) {
5fc4912d191fc3 Anup Patel 2021-05-13  224  			pr_warn("failed to parse hart ID for irq %d.\n", i);
5fc4912d191fc3 Anup Patel 2021-05-13  225  			continue;
5fc4912d191fc3 Anup Patel 2021-05-13  226  		}
5fc4912d191fc3 Anup Patel 2021-05-13  227  
5fc4912d191fc3 Anup Patel 2021-05-13  228  		cpu = riscv_hartid_to_cpuid(hartid);
5fc4912d191fc3 Anup Patel 2021-05-13  229  		if (cpu < 0) {
5fc4912d191fc3 Anup Patel 2021-05-13  230  			pr_warn("Invalid cpuid for irq %d\n", i);
5fc4912d191fc3 Anup Patel 2021-05-13  231  			continue;
5fc4912d191fc3 Anup Patel 2021-05-13  232  		}
5fc4912d191fc3 Anup Patel 2021-05-13  233  
5fc4912d191fc3 Anup Patel 2021-05-13  234  		/* Find parent domain and register chained handler */
5fc4912d191fc3 Anup Patel 2021-05-13  235  		if (!aclint_swi_parent_irq && irq_find_host(parent.np)) {
5fc4912d191fc3 Anup Patel 2021-05-13  236  			aclint_swi_parent_irq = irq_of_parse_and_map(node, i);
5fc4912d191fc3 Anup Patel 2021-05-13  237  			if (aclint_swi_parent_irq) {
5fc4912d191fc3 Anup Patel 2021-05-13  238  				irq_set_chained_handler(aclint_swi_parent_irq,
5fc4912d191fc3 Anup Patel 2021-05-13  239  							aclint_swi_handle_irq);
5fc4912d191fc3 Anup Patel 2021-05-13  240  				cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
5fc4912d191fc3 Anup Patel 2021-05-13  241  					"irqchip/riscv/aclint-swi:starting",
5fc4912d191fc3 Anup Patel 2021-05-13  242  					aclint_swi_starting_cpu,
5fc4912d191fc3 Anup Patel 2021-05-13  243  					aclint_swi_dying_cpu);
5fc4912d191fc3 Anup Patel 2021-05-13  244  			}
5fc4912d191fc3 Anup Patel 2021-05-13  245  		}
5fc4912d191fc3 Anup Patel 2021-05-13  246  
5fc4912d191fc3 Anup Patel 2021-05-13  247  		swi = per_cpu_ptr(&aclint_swis, cpu);
5fc4912d191fc3 Anup Patel 2021-05-13  248  		swi->sip_reg = base + i * sizeof(u32);
5fc4912d191fc3 Anup Patel 2021-05-13  249  		writel(0, swi->sip_reg);
5fc4912d191fc3 Anup Patel 2021-05-13  250  
5fc4912d191fc3 Anup Patel 2021-05-13  251  		nr_cpus++;
5fc4912d191fc3 Anup Patel 2021-05-13  252  	}
5fc4912d191fc3 Anup Patel 2021-05-13  253  
5fc4912d191fc3 Anup Patel 2021-05-13  254  	/* Create the IPI domain for ACLINT SWI device */
5fc4912d191fc3 Anup Patel 2021-05-13  255  	rc = aclint_swi_domain_init(node);
5fc4912d191fc3 Anup Patel 2021-05-13  256  	if (rc)
5fc4912d191fc3 Anup Patel 2021-05-13  257  		return rc;

This code doesn't do any cleanup.

5fc4912d191fc3 Anup Patel 2021-05-13  258  
5fc4912d191fc3 Anup Patel 2021-05-13  259  	/* Announce the ACLINT SWI device */
5fc4912d191fc3 Anup Patel 2021-05-13  260  	pr_info("%pOFP: providing IPIs for %d CPUs\n", node, nr_cpus);
5fc4912d191fc3 Anup Patel 2021-05-13  261  
5fc4912d191fc3 Anup Patel 2021-05-13 @262  	return 0;
5fc4912d191fc3 Anup Patel 2021-05-13  263  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

