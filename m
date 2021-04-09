Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430C235983E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhDIIrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 04:47:46 -0400
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:23649
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229846AbhDIIrp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 04:47:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RWIQnAfMR2eB6AwQjtffVaCb0Z2G21iTlh3a38ysc6g+rk6mD1JGMMKYkN3XNEjxVz/ygt+QbNKBaSeB+4ceod2ZYBY7kVqiaJstd0F2eYoqNU442vqNCv88/JB8c0O70vcGeq1hr+UlUv9do/TcE2Gwe2/Pmh/Ko0GaL2QwAbOBvpweEGQX0fBhSyq4/zXtBhcsPPdRtVcoq/0blSwWRogvzwV4fpd4j+Pf44vcEJLfMz22fsGE9YbTmD5/zVw3XnTYFCn5G1gBg9osTG1sHY7dJYc3JzrESRM2fK+705Xpi3Ub7ucWF82PhzYroWxJVQSAzERsRyStwQ7MBKXIjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVJ8aZ4GYji1nxK6iPH17iTn16wDS+SYn5itFVukHcU=;
 b=SoYtQdPlSl4DCU+31BTxRXbk4V2K4Tl80zl1gGHxXR2x4mLFM0pmPa74oAXeWVU//d761NwT8E9KRpFL8HvbT285XYjjsWdlqg+IfYyZuu3DmTuEwq6MyiomCAvKUB+kWTeYWazueYcbjCtXASHM0mKJ7tbiw9bYo+mPaZDNWUkKDxG148ADma5IdStXOMBO4ztQfTYRucbB5a9xocB/0+yY55NRjViuDQU52KD5c4sOtK0BzkwzBAZntiJ8K+e5RyGnzhsFIJ6qItjYX3DDkGaPdLoJvaU/I/i4rf28Lm7z7m2WgjFkymDNqcrpGi0VTyCyYNuYCxkwGGd8P4VMAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVJ8aZ4GYji1nxK6iPH17iTn16wDS+SYn5itFVukHcU=;
 b=i69U5ZKxYhfFsVPtp3BD8lan6DOPO7iqP0E5ZcWRHMLHs/eKGpPQ5DT/zvEVTdvfJBGsMK4TezPi090kBA7KqmpcW3So6PQpPXWRNQoZQQ5+PDS1rLOxLD0po9m8fVnVHI4K4iLjJCyS/Cobsl7abLsQ4/JttnVeUtiuSI7jOTc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
 by BY5PR12MB3889.namprd12.prod.outlook.com (2603:10b6:a03:1ad::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.32; Fri, 9 Apr
 2021 08:47:31 +0000
Received: from BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109]) by BYAPR12MB4597.namprd12.prod.outlook.com
 ([fe80::cc86:d78a:bb1d:5109%5]) with mapi id 15.20.3999.036; Fri, 9 Apr 2021
 08:47:31 +0000
From:   Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     joro@8bytes.org, will@kernel.org, jsnitsel@redhat.com,
        pmenzel@molgen.mpg.de, Jon.Grimm@amd.com,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 0/2] iommu/amd: Revert and remove failing PMC test
Date:   Fri,  9 Apr 2021 03:58:46 -0500
Message-Id: <20210409085848.3908-1-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [165.204.78.2]
X-ClientProxiedBy: SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24)
 To BYAPR12MB4597.namprd12.prod.outlook.com (2603:10b6:a03:10b::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from ethanolx5673host.amd.com (165.204.78.2) by SN6PR01CA0011.prod.exchangelabs.com (2603:10b6:805:b6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Fri, 9 Apr 2021 08:47:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6588fbdf-471b-43d8-d7aa-08d8fb341c7a
X-MS-TrafficTypeDiagnostic: BY5PR12MB3889:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB3889BA796A85F81C827E42CBF3739@BY5PR12MB3889.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M0EvTD77kTx52I9n4CdJHuc/kASLfhZlqlRHEmWfbOVN9C40h3atuBB1PgYjBwyQcs0QuJOFZcSryUqgl2r0rx2rvkitj5drz2eW430SJr46etQVm05fjZuFBYhtc6aZvb0mlNrkJ/jeaawEFcmdOsi0ZNOVACOsjYE4BAHv1HlzhE11aIAF75k9JGzEOs45XlSFDfxC9RIeOAyT+MoJdYZJ5kYPPiQQrpl6MWba4ZnAIvVebzX4PfpkK3g/EA9cuanXcI1ps4S7kfLLmbfFUrzb8bLyYE99n8S3aghJSKdkKLbbcPv8UqDMgoJgAEKkEBYyJET9yINhmqm0d5j+nsiEYPekLSpZSkQP1b6zRiYceR/+wRTP6ETAChsMjwFM04ixv7M2g/qWD/P0k62LHqHGsQOhcstutlC9EMn5MzBZdNg0vwdtPoh37/b368hOXi5BhTXa3yyL8qNjG1rG70L0EdcVERLuNOL8D9fCofwQpGbyHd8cS+pdeq1AQVYSKXJjeFYtY8nuStagqJXkWQ6rUt1HZWEZNRVZWQ5WqBieMc9u4xGB7Ht9u/jpxSJr5WDzb8yQlnFu9cM2h253tDdHeCvd1CS/+WL6N4kExwJ7MUfUAIRiI3hJnk0jvHBNgx5tWhk/eIf6tQJQagT2I21zIPtfS+IZFOtJ25rEvy+1D3TOCpGs4HHuiP6Ju5C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4597.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(366004)(346002)(39860400002)(7696005)(52116002)(38100700001)(36756003)(26005)(38350700001)(83380400001)(4326008)(8936002)(8676002)(66946007)(44832011)(5660300002)(2616005)(86362001)(478600001)(2906002)(66476007)(1076003)(16526019)(6486002)(186003)(956004)(316002)(6666004)(66556008)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0bfRJzq3Hjhgl+i5K7rrHv2qjlnQuvYTuMDFrllp4EJqprh2wCRs+2NBhoLC?=
 =?us-ascii?Q?z7RhnSMSvnmpy3jl9TxzlzFRnnNlm5GwIX35tTXVOeNlwUu+eqkGERjyhrZc?=
 =?us-ascii?Q?RBkP8oLgA9mI/a+Lv6YupQw/5WdpACHIvKn/Un1WwspmvdnG1tuPRk4bVD9Y?=
 =?us-ascii?Q?g1Danog566NNeFNdpoGvRdRsY74B0NlDkOGGMqJrEPlv7sN9Y8nxGxAU6jnD?=
 =?us-ascii?Q?pGXF27wra/hLO8gfCDQL2sGO1KUo/YhyelwbI+1RINfxoygm7nFXYktXWMd/?=
 =?us-ascii?Q?NNrBckwOSqNqvdKWUFei7bGnXrofpynp2+lZ/a4Vl33XThH1QKDbdOMH3fjK?=
 =?us-ascii?Q?HMWpxToyuIIlCbBeMdMEaSLGd22InbFMrgIxCezIz6VwP/uCj9b2WGIz+SqC?=
 =?us-ascii?Q?2YHCm3NoKqM+G25BASzZp+YC1HdcQKsKBTEg7n2qczPKI5XAbAo99n2fW68P?=
 =?us-ascii?Q?ucN5COziR75KMfb5K9lX3XqjlI0qXLBW/sD8h/ecPEiIgbOxIImkkAaCND1g?=
 =?us-ascii?Q?sW8bWRBpdUmToyUMJz1QmgB0LAt19R7/aYaLulg3gOU2/ZqcUdtCj4uwsc6O?=
 =?us-ascii?Q?qSH+SVKRRFqkmM4aCXKd/SaQp/MOEuaIXOkklTWij21Jj8qX7v2pv//GXMBv?=
 =?us-ascii?Q?ONMm1vkZibvulpigTDoOkDqUP3vl8XCU7NNK7B79atXHLOLOrE0db6ZnQ3+e?=
 =?us-ascii?Q?YiVQBgH8aCe0cbQERrIs02QVNEla8fxNM6fW7EIn9E8IzMWGIR6FmRsJQLU8?=
 =?us-ascii?Q?wIFIgnxeXr7w5QcP+Fezfh+sXqxN/t2dnIX3ZQY/fYuTwB/GIStFX/mwCVDm?=
 =?us-ascii?Q?ci8r1bxVcE1PO1BjHq0gVvcMGNtAt9r+aySg3y4r/61T0opdKt00/1c+okp0?=
 =?us-ascii?Q?3BR4bzs0XzjD4i8eLoveDmJpyeXH/w89z5TKQE3ks3qpuaDPaToPIZfp1lMz?=
 =?us-ascii?Q?GTANM4ot5+EaY6DCYfATOEAXqc9O7XTTqkYtz1KmZZHZMfc0UARRxl8YLE1K?=
 =?us-ascii?Q?upbOk721JuSHIw9Yu+vGRB7r4SIdbxrq22NLsDnQWdvDgvrNsOmAsCTt34TC?=
 =?us-ascii?Q?PKpas6fLh7GrvyZvH3Fm2HGbI2XeS4cfd9A6ytY5+K5MEOaUiO76JMfT0kuI?=
 =?us-ascii?Q?a0Kpq/pTivBGKYLoiNujweqxaf4qW2EodGVWSLacFjnEVeEsQO47p6ZCXmi8?=
 =?us-ascii?Q?sDuDMKCW1Bf4aLBVykDSimT5CQTPRZim1oeklKmn1dZfMuwECm+HUExSrQlC?=
 =?us-ascii?Q?lU6x18Ea30SvGVJU4RPW7DPAYBC2JBP42btFrCwo+LOF5Lwm8iXjc1KNKKah?=
 =?us-ascii?Q?+Sir5xcnw6eVrYfV3b8HIZOA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6588fbdf-471b-43d8-d7aa-08d8fb341c7a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4597.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2021 08:47:31.1156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FNSUMrGINxbOqiXfnqoneTCYKo4jJSyWBdFxW8i1NPSFtvZLaSituLWAEPEvQ7cNY1ZyaGJJDOYYmMo6PkBP7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3889
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This has prevented PMC to work on more recent desktop/mobile platforms,
where the PMC power-gating is normally enabled. After consulting
with HW designers and IOMMU maintainer, we have decide to remove
the legacy test altogether to avoid future PMC enabling issues.

Thanks the community for helping to test, investigate, provide data
and report issues on several platforms in the field.

Regards,
Suravee 

Paul Menzel (1):
  Revert "iommu/amd: Fix performance counter initialization"

Suravee Suthikulpanit (1):
  iommu/amd: Remove performance counter pre-initialization test

 drivers/iommu/amd/init.c | 49 ++--------------------------------------
 1 file changed, 2 insertions(+), 47 deletions(-)

-- 
2.17.1

