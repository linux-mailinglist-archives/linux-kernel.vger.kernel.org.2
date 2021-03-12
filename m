Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31B04338809
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 09:56:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhCLIzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 03:55:52 -0500
Received: from mail-co1nam11on2065.outbound.protection.outlook.com ([40.107.220.65]:29217
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232580AbhCLIzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 03:55:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z6dips5JkR9/BylhebHdv/HmppsiJ7cFu1TvcFt7HXc9CvWQSbUgCchrNpMyLs96yMi7HtHLEy82FqaKtnCIkT+OY7zrInvJHNAk27NJJK0Enp2q7yk+tve8thg16t6hS1Suy9Gs5957UYOejyoc0x+vZd1DPF67239sp3BNCsMU/bHqEfF3S/HzRF4rWm0p042vyFeumT8oCv85MGMjuqT6CgSR2QUmUEVOZOV6umBFrrtVJHquZPR/Fm+s7ivkVc6VnkLFOP8HpE7BAYzCX4JanoR7Hoaary5KDxFnCSxq5xDrnVYehYSjZ3XbqLzf2GYit0wNpN7W0YUvBIoPPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5NlnfaW2kzVSt0MymI5Y7VNTO3FSO3NeZo2Lj3ICOg=;
 b=NxzVzkRx4N6MWx1MWapzkzroPzsaH5L8vpnlma38Yz4maNzKiXVSimBOs49nDI/ay7Z/GGzILuTb7Dz1GQjXyFA6vOHkwjCoMwQPNfG8r0nynn5xdJUzcTik/9THiuOX6jg3pNKpAmx1ACSufjCq2rhQP3rceEP57PlW5xfGpJBVcHOc0yhVuXSuSaeA6lnMbotXpNNu+SMjT68+fCqfCVkxyNPrsjL3jEy8++H0I/natNRwHMyGGeFuHyHqxZKZLrZmajZBsfYKDjOGhSojEsa0qNpsYYpAtp4grw/eHNTFo6y9ITUgWlyqqMiC51+JpMzjB6GY39i35FAxv3uNgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5NlnfaW2kzVSt0MymI5Y7VNTO3FSO3NeZo2Lj3ICOg=;
 b=b/QYUXF+euXsKKaEK1klu/sRGEJhbhzI7+N7ea0YDeaOix5DmPKCsneEgQy5LCbhIpFp+tR3oxxabRUL75xE336KjJ0BpCRd/qIJIKS7U0V8Ii5dVXhSJD9fUaym8Kl8I6VYQsioOfF6uF3CzEsMU+lnJ553d812yNyy5YU3bB8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BYAPR12MB3144.namprd12.prod.outlook.com (2603:10b6:a03:d6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Fri, 12 Mar
 2021 08:55:12 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::a95a:7202:81db:1972%7]) with mapi id 15.20.3912.031; Fri, 12 Mar 2021
 08:55:12 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, Jon.Grimm@amd.com, Wei.Huang2@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [RFC PATCH 0/7] iommu/amd: Add Generic IO Page Table Framework Support for v2 Page Table
Date:   Fri, 12 Mar 2021 03:04:04 -0600
Message-Id: <20210312090411.6030-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN7PR04CA0040.namprd04.prod.outlook.com
 (2603:10b6:806:120::15) To BYAPR12MB4597.namprd12.prod.outlook.com
 (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN7PR04CA0040.namprd04.prod.outlook.com (2603:10b6:806:120::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Fri, 12 Mar 2021 08:55:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2d6c24bb-1177-4ad4-2d35-08d8e5348be9
X-MS-TrafficTypeDiagnostic: BYAPR12MB3144:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB3144BCA06CE44A50E164ABF2F36F9@BYAPR12MB3144.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NxWO+AHJv/Sii+Pw9Zic7QoFuuY0KIc0eBNk60Gyc6LsuG+u2+Ncn9T/3eGCNTBsrlt01c7JRKXice//x0swvb5Bkf1wYCQa8/n0vg9n5tIRotwLqKwcPLglxBTC2qvswg+SaDrqhfDp/KJ0Kc2Re+LX4yE4HOWjV8hOGcdS4fVnYj46XxFVgBy02SvOBOyo7qIpPkEuasHllS7E5mbgCvPnuxtT7wwhpESjyzqkkeydgKqngH9S9Y747s9vmwexe7mLurm8c9BuZjWiQtizD0DLoYslc+55kyTCuF3AQTUGe2UiDbV5dEwcUMHSCwTWb7nE2F9txs+Y7oMKjr7VesU44tiyamizok6Ul8B73YY+cryKtNdkVhnE8CvHTWWkQL6kWVaaOo191tO/R1y1A7EimFdA/HCQNV/4AaAiZQRGrYGfnh1oGpYpGiQAWJZngeB5bRxdW5BW1OKmlMW+mVvHiObJuQjQcVvsqpNRW0Paloodbk2osmTbNcDZ81cdHypaYIEauenXNmwx+OFPtu45jZLhXNxOPXUoAiwA52iIGUzBHSZWV2+I+woI7xXxi7AiihWlbmo70znTuOL0QMdg8ml3fhGmz2QvPYRlC65YX9JayQGliF7kujz61RGrehNljtKdZ2W0bdgbI+110kIpghVbDlXLd61aEgye96NIynd6L7I2mfacJrkKjbRITiLj3GzFQ9oBFjTDpyBqfF1aoE007swEwOGnauOjNy4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(6486002)(6666004)(316002)(7696005)(8676002)(16526019)(1076003)(5660300002)(956004)(66556008)(86362001)(52116002)(478600001)(44832011)(2616005)(8936002)(66946007)(36756003)(4326008)(26005)(2906002)(966005)(66476007)(186003)(83380400001)(71600200004)(41533002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?+vhg87A7rbGUcA1TXo9I/61+6XW/If34KF3H+n5KlxwClsg+IaH1/trAxfLF?=
 =?us-ascii?Q?CyJNAHEcfa47CgKWlioDChTBjmjdCC+Wf0o4bkzjCmjs1SvlplTHeAA/u0TU?=
 =?us-ascii?Q?2P0o8fXqjyNZWogTZL/A/RKqSXS31YV7/LYn9IZ20gnS5qk+LWUNYXtkT4Wp?=
 =?us-ascii?Q?spRX1ABIqEElZAHQEwCsWsUZ57MhJTq1f9c8wCY5FuIitNL5TL7e7gzKIcVI?=
 =?us-ascii?Q?vNaVWStPwPrRMveGL+gVFv63k0uH7fAXHsV6JIicLUX/BD+JQ/PoKbsAsIb5?=
 =?us-ascii?Q?aX3qfRqXJQ/d12yfx32qdD7A8cL8C/UPyOrY0lpEpY75enPNLcIG6F52kInN?=
 =?us-ascii?Q?EPUqmcp9dhziVYs1OH1Qv2a6VMWLM7UQ5O2xaP5V2m/wKcU1MbPYPjzoczqd?=
 =?us-ascii?Q?G7DY9i65tUwl2s9/EOHxSRtVdD8uoQZfjfq/8YKwTFuV25MUvvewEEWObuIS?=
 =?us-ascii?Q?zwrniv/Bvfz0pR5M8d5Wfw0OhSPYWJ8CiGuXEiGB4omZSYGz5jSDTBy1kNXL?=
 =?us-ascii?Q?iIl2QK7xlpWKytyHOtNA17hmgVnDCSaQkw1yWoIT+4cFGU+YrlCkpULoh8jH?=
 =?us-ascii?Q?kb5K4dIbrd7QwpwxOIhMSY9uuuS5fuB3w/dnXK3TMhZ8ARBzptpxnK0ib9dc?=
 =?us-ascii?Q?xTBCWJC1WvoF1FzZ81nZSvvSO8Ws5wT3wPhN/48PqipK9Jpuh4tsQNYVpg6q?=
 =?us-ascii?Q?5BDkFAOJaeILwiUWOpjQd7j6RTCLJ8WHeqT7ndzMuhSddODhdYuhHu1q9kew?=
 =?us-ascii?Q?qh65Cy9b2maGqnhVcmSRpoe6CZiwwRrQt/BiM19KEQD4NUx1fszp8BquWcOE?=
 =?us-ascii?Q?1Ida/I//3JIWG9+OIXxKX3YgVyuCIXx+BkWkrWf/w1kjZ71veB4BdEqsl601?=
 =?us-ascii?Q?qS+DqWQKBdqYsknJvL0FMc1dWw12X8W6cX23ETIy6/TN3KtlfuUl3Lvj/FRR?=
 =?us-ascii?Q?q9Ioyz1h8rVfBNfMydIXf3qrwoOo53HbzVEet4R+YFh0pROTxuPUYODw7yc3?=
 =?us-ascii?Q?S+vDjKSEriMKz+hw7oJZQaLBOb14JzV6+K2YVOx4i+/jSxlpMkfxlyb1gzQe?=
 =?us-ascii?Q?t+XOO87qn4npX9PXr0PwtMUzdzepu3NRj76ADl3CuutnDhh9T1rPebdoaoz9?=
 =?us-ascii?Q?+oLDHjPWkY29fRhebjqblTtQYbOJM7DJDr6pgLWXi6p7KmcsCwU6+xCRp6e2?=
 =?us-ascii?Q?mF2YOzrNk1o/AbdeHm4R24L0Zp6VMYW0+wEH6Alex8DYvMR8acIdWosjuBx1?=
 =?us-ascii?Q?/i46Oiu0kGXv9MJAdu7hW4HsBluM8YauoWjz6BN9mEJJ8ijW5281TVKFJwZn?=
 =?us-ascii?Q?W3i62dLPohslwEgmd8X+YOSv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d6c24bb-1177-4ad4-2d35-08d8e5348be9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2021 08:55:12.3558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: INuuo/Nw4YWjDQ69Too9iFFucqXd1zIVAo09apt6QqAHgZK6VlX0Vd7v4PBjCL+WzWqGKPjmbHEylUH8hKeITw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3144
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces a new usage model for the v2 page table, where it
can be used to implement support for DMA-API by adopting the generic
IO page table framework.

One of the target usecases is to support nested IO page tables
where the guest uses the guest IO page table (v2) for translating
GVA to GPA, and the hypervisor uses the host I/O page table (v1) for
translating GPA to SPA. This is a pre-requisite for supporting the new
HW-assisted vIOMMU presented at the KVM Forum 2020.

  https://static.sched.com/hosted_files/kvmforum2020/26/vIOMMU%20KVM%20Forum%202020.pdf

The following components are introduced in this series:

- Part 1 (patch 1-4 and 7)
  Refactor the current IOMMU page table v2 code
  to adopt the generic IO page table framework, and add
  AMD IOMMU Guest (v2) page table management code.

- Part 2 (patch 5)
  Add support for the AMD IOMMU Guest IO Protection feature (GIOV)
  where requests from the I/O device without a PASID are treated as
  if they have PASID of 0.

- Part 3 (patch 6)
  Introduce new amd_iommu_pgtable command-line to allow users
  to select the mode of operation (v1 or v2).

See AMD I/O Virtualization Technology Specification for more detail.

  http://www.amd.com/system/files/TechDocs/48882_IOMMU_3.05_PUB.pdf

Thanks,
Suravee

Suravee Suthikulpanit (7):
  iommu/amd: Refactor amd_iommu_domain_enable_v2
  iommu/amd: Update sanity check when enable PRI/ATS
  iommu/amd: Decouple the logic to enable PPR and GT
  iommu/amd: Initial support for AMD IOMMU v2 page table
  iommu/amd: Add support for Guest IO protection
  iommu/amd: Introduce amd_iommu_pgtable command-line option
  iommu/amd: Add support for using AMD IOMMU v2 page table for DMA-API

 .../admin-guide/kernel-parameters.txt         |   6 +
 drivers/iommu/amd/Makefile                    |   2 +-
 drivers/iommu/amd/amd_iommu_types.h           |   5 +
 drivers/iommu/amd/init.c                      |  42 ++-
 drivers/iommu/amd/io_pgtable_v2.c             | 239 ++++++++++++++++++
 drivers/iommu/amd/iommu.c                     |  81 ++++--
 drivers/iommu/io-pgtable.c                    |   1 +
 include/linux/io-pgtable.h                    |   2 +
 8 files changed, 345 insertions(+), 33 deletions(-)
 create mode 100644 drivers/iommu/amd/io_pgtable_v2.c

-- 
2.17.1

