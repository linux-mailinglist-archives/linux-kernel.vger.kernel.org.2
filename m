Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16E03A0618
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 23:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbhFHVj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 17:39:28 -0400
Received: from mail-dm3nam07on2067.outbound.protection.outlook.com ([40.107.95.67]:20704
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231208AbhFHVj1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 17:39:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0rmYsKWFvbCurwCyvtW2NJwjMKRs20mpUzK7NKXy/XnytUJQE1ou3JEEhsm9ZKTJl9cE0IVSCyNJ776lz7qaN8RDjeoXH6lx2TdhLsnweRs03PW3VATBG0Hz45ovXPGwhjE0Lg5yZjN2WxsxZYwawm7G7rU//WozASPqvVsp+w4ct28OlDZDpbsd30KHH5P+Hcx3wyxy5hhFDd/4F1GuunOWCYOAihDlwoGTrzShGP18i9Fb+Ex0a/NhwRhlr/4XfbqZxDD8L7z2wl8MLj2s1lOFBaa3Cv3MUBbKXhwjiGHmTFjkCn4xkK1W+RA6hdvv7vB1+jWVXcobZkkc6fadw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmKTpPjOTJTDuoqRLQ3S12BRaXCFki9CYU4KgQkrYIM=;
 b=JIIaBuTpTR7eKOhcnBmif87nCFKWh1V5dDaEQ4JtBu2iDydB1uyuA9tqJRlQiDIe6zGsu7X3TM2tfuD9Vh4mSOjGtzCZoINO2BrgwtR2SdChN8Q3pLfTSAaBKfw71t/NVc1oTBy8KLn5M0tzAPAOGXIKMm3L8PVxKbWzep68oHC06ZG9TcsZAvo6G3nhwCd6RB2F8k9lGdsJvc8JLLdF9TSnl3fwww+nfIUiK+Wkl2n1CQMJJ/BkwHeTbJLCjFJIr69Buf0rfMbu3ZmYhn3SJv+ZFMqPhYq/B4fgh8sj4abKbm5UX3T3MQ3oCbEpm/AOUibjwjRe0ZW7WG5piNPjRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmKTpPjOTJTDuoqRLQ3S12BRaXCFki9CYU4KgQkrYIM=;
 b=zhF30o7oXUb7kmEUFDgxoQSWf4Ctgo5JMdU/yGeHBY/VdvoykZh+OZKt+WWTfZdxthC4Q9aRKh8YOerpWUgLIORUdORA/4s4HuyxhOCT3Ql2SdUAWfipeFNigeqxgOVj0fsn45UiC8/KLV+ruVyZyzpfP+GzqZyl5/+EW0rWEf8=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4569.namprd12.prod.outlook.com (2603:10b6:303:57::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.20; Tue, 8 Jun
 2021 21:37:31 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::acae:934f:8e7f:8db2%7]) with mapi id 15.20.4195.030; Tue, 8 Jun 2021
 21:37:30 +0000
From:   Babu Moger <babu.moger@amd.com>
To:     tglx@linutronix.de
Cc:     bigeasy@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        fenghua.yu@intel.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, riel@surriel.com, tony.luck@intel.com,
        x86@kernel.org, yu-cheng.yu@intel.com, babu.moger@amd.com,
        dave.kleikamp@oracle.com
Subject: [patch V3 4/6] x86/pkru: Make PKRU=0 actually work
Date:   Tue,  8 Jun 2021 16:37:14 -0500
Message-Id: <20210608213714.6385-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608144346.045616965@linutronix.de>
References: <20210608144346.045616965@linutronix.de>
Content-Type: text/plain
X-Originating-IP: [165.204.77.1]
X-ClientProxiedBy: SA0PR11CA0068.namprd11.prod.outlook.com
 (2603:10b6:806:d2::13) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from bmoger-ubuntu.amd.com (165.204.77.1) by SA0PR11CA0068.namprd11.prod.outlook.com (2603:10b6:806:d2::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.21 via Frontend Transport; Tue, 8 Jun 2021 21:37:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 609feff1-1f43-4db9-845a-08d92ac59e37
X-MS-TrafficTypeDiagnostic: MW3PR12MB4569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW3PR12MB456930D2EE91CA2D32E2E00395379@MW3PR12MB4569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OcsV/l7ooU+qurYKPcNSqf/al1FQiNOFW/vIcch8PjPM/pXIek15Q4PozYenKCv4e95l4JwUCE9D180QJQ5Qt3GvYhkKtuPDh+EPaLKH9/dbkSv0rppR+plXaH0xadpnnYs5IvHJtJznXFvISHCao1UoVcoU4wLqeOOB5iDpq1I65RWXqmVXQ77eWbKSw+qDV+CP0SOp9BdnFPs/Z7YGqN9emv20qjdAB86VVRIDgtQjwqEUvOvouQPpXxeTr+HTrMX0812dIzhL1Rb7algDIQaWBAW810Vb5RHNuM3Kpl7nAStT4umN9Jp/d5F6uGE9QnyKzOqE6kcTtEVZWevC+/RyjGANfTDegYbvcL5iCvgEJ28sPP2FXBPvBChtLSX1PblA1RL0tk4suN1GBJnQm37tT0WGpMO1tERH8ILsbL1dyrOR3XjrXB5rul5zhpuyrp1MkEplxG6LTTWrDDVWkd5XflU3g/D52HoD9uM6Y/Q5GeNbej1A547JngNmBy5Hu4Or/XJsyGGTiixgMAfwWBZdynTbDyoREXGg8EP4sTvPe5/DKOxslXZWfHbwY7zoFCKS3K2+1apRzEchZgJi+svQX0Hkws+SyvS0yGEQzxQAdUvcoXtoPjACUnm65InCOXp8bPjLvglhrc0UECgKZZPf9ybS8lc4b+/tChjrKAS2zNq56OM9rvRZfo/oHt8bgUspqkeuBHMCoqtm6EbaA1J6v7iLseJOa/hZjVXjsV7oddu/SpQrtU23yBsv01Vbg7tFN7phbyKL/irs+sEZ6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(136003)(376002)(39850400004)(186003)(4326008)(2616005)(956004)(6666004)(44832011)(66556008)(66946007)(66476007)(86362001)(38350700002)(316002)(8936002)(966005)(26005)(8676002)(38100700002)(6916009)(1076003)(7696005)(7416002)(52116002)(16526019)(558084003)(36756003)(5660300002)(6486002)(2906002)(83380400001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bPk7gXO2Y7WogG5yx80FI8VeNBr4YQeDuXkHyodq77aCuuupRloNJlV4xn+V?=
 =?us-ascii?Q?TRr2iyMlznVArQDJzbB3BzJuYqqlbROnaA20UMkqfLv1K2QMePkLDCxJJIQX?=
 =?us-ascii?Q?3jZ5kHMzRS2sNUePXTJuJTxi89nCHb8h0UmyR8RxCArYr9/APkN0s991lPPf?=
 =?us-ascii?Q?wE4pB4ynjlUKvNi4yF6RzAaRtd5/Nu+GTXOV7lVkYFHkN8nusRw4ycjShlb5?=
 =?us-ascii?Q?5hmgHNQynzfx7cwrAM2+H4Jswl+dGOXzX4jXrmo1wGJATfeR38rUUD8VAgpr?=
 =?us-ascii?Q?qBJXGdunr7cW7QHThoYqmYHDzPxy30P/5AmbAG6/00SAt723Fdb9UTuPeb/l?=
 =?us-ascii?Q?H2q9bF4SFHmWFSBgC4cB+PxWigFC28F5KieQvA4NLb3DCI+fX3yibTjYYMG1?=
 =?us-ascii?Q?VC9t9r5TNxkH0f5DKSMzYPwo3cdyWQEEDevROvYMDaZDD/Gd7Z7jeoqC2L9b?=
 =?us-ascii?Q?eb+4h5ugorYPciy7SCqdXtxPnmiHwFm1vaHx0fKjqAj+A7KSbBLA56zrTQXa?=
 =?us-ascii?Q?cY6SVDVLZpeWDMzqBRvWKLFb/VtusjggVWWR28mkgfqKbJvV0bfe8FOo4iUa?=
 =?us-ascii?Q?RHyL4LIFPPK8qB6/5VBCkoxOcVvUt/idwVuiz5lx4oi1BLqgLFCJHm8TWJxK?=
 =?us-ascii?Q?J5OxkKnrLcyCLrKNXCs0zne/WubSEIMPzUE6w4uaqo/wJpTwx7CbRoWTASLf?=
 =?us-ascii?Q?pmGCvtZ4qmaIJGmfK/E9IzsHLXLnW1+Ep7YXVT0L0MynkdmjSlAw6EVeNbMn?=
 =?us-ascii?Q?Ctt6mle3Hcret2euDEb9Wp2oe+PddxWCVwqSNY5s/YKEZE/M+AwqGMASZoAU?=
 =?us-ascii?Q?T851a1Bry4TzEw6pTp+BA4RpAQ6I8XY60/BlUx9jo1X17IDUUwhwi3OWa5UM?=
 =?us-ascii?Q?yNb0r4OkeeDs4c2I8S+kDSddc5ZlTEdzIdJVArwp7U///KqVb3V8+kjCURi6?=
 =?us-ascii?Q?kJbEaOkb+MBc6DCFXlIQXKzpW+vQUcBjuIRKbIneTYt3o1is1SJqrEX9Gz8z?=
 =?us-ascii?Q?0o2y0YA2MLA/1psorCknrQrN3W6m73ysWn+d18QvuXqW75HGd9Wz2GqmdVqe?=
 =?us-ascii?Q?HLz7oAZrmmfBQdLINcJ9dmYIkRalh0TAgcCpzLOJMOV7x43/PGfIQmx0Qjjo?=
 =?us-ascii?Q?VHXrRAmkPUnTVpPlkAgbATJ8/EaHjBAE3PclJUZvEbX5+7n7tO8bW5YfS9H7?=
 =?us-ascii?Q?pxgg/DiDOls9P9JkJTiX9xWBhmbYBF+eZJnEHSk4VQl25pyDrjBhIP3QKbYp?=
 =?us-ascii?Q?/ryLvR1Ju+LHGaG/uVMKue8YduOAisfRBR3TfM9xCLnREQ2KleJEOhTBVqSj?=
 =?us-ascii?Q?WMgOzFe9akJPS4QDrjj4pioJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 609feff1-1f43-4db9-845a-08d92ac59e37
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2021 21:37:30.5807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHqtqIgDmrokefNReBPh2r1emodVXnQZINgUAccgtkYe/cIa/fRZG2XiEsV6hmP3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4569
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can confirm that this patch fixes the problem reported in
https://lore.kernel.org/lkml/b2e0324a-9125-bb34-9e76-81817df27c48@amd.com/.

Tested-by: Babu Moger <babu.moger@amd.com>
Thanks
