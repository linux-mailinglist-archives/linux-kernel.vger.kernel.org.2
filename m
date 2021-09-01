Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 426C83FE41A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Sep 2021 22:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243130AbhIAUcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Sep 2021 16:32:21 -0400
Received: from mail-dm6nam12on2053.outbound.protection.outlook.com ([40.107.243.53]:12257
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231761AbhIAUcJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Sep 2021 16:32:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpUvBTjXBLkTvK8hKEoJSXEry39PaSW+OnL3RlBWphqJpTdT72Ej5Eyb0kiH55wpHUm62bczmXXb9MjFdDHndkq1i6P4WxA4WJSEouiUEQpDJAf7jMgDdKNyGxwzrphryHH0GS4wi1UhWQNbNV0PjGhp7awWjtt+/D8wjS0n89NJoUpGwXBJM0sQHjGwZZcfSvYClwCxqZd9iD0lVgf0WywJT5MRzCPUWei3lorabqgyzvpF5dJmXt2iPhmLPrrdx8XqY6mBFXDCfQ9VnH1H/Mu2TCHc8blweX51XTiYY/WncSqVOaN7VHmnqLZkzgz5aGnN2Sou2d7qzLDiDCqe+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/hmyGopsheUTe8C8b3tz4IEHFUT3Yyhv3cpXRIM/+c=;
 b=RbEcxOwEFJ949ABY9yTL+ZPvImsfpLcrbQ/P2PdwjxPfK+69DGNkpKBNtf1sEsves9CQwzlS9nwg88cDs+38Pze8SHKka3ohxJX2LmEwk4aVLtyPPOOjAVDb9AcKv2iOgi6ZUwD7gpghUetb0b8BOJjjqbU2mib2b3XQSr3groZs85rO4UAWp3PYClXf9ywm5rrMRJvVpb004H76aY7qAB4hSEVRt+BlmyLUHU4ZeedkJaCevOi8fbrBhyTpO89HYeN+Eq5o9YtJT3Aj02dZX/ShNq8FoTfIqFEql38aOUtAR/gpf3eKlXFUp8EUFJ0et9QIKIirujHY7P8QYka6VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m/hmyGopsheUTe8C8b3tz4IEHFUT3Yyhv3cpXRIM/+c=;
 b=e5Cs+/s43Mk76AvPyceAvWxKtKQauW64JE2A1jc7o81TCWxDex5SIg4Dd3rbEB8ZuEuqRtWE3WyCnq/+Nhslr5XS66ksSlFBioEmtOcYQ2RmU+ShM5TqKKJPZH8l7u2GfQAPLRi4/QEaOM0myZx/JuFM2xihKuwuJPRNnl7QMTY=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MWHPR1201MB0063.namprd12.prod.outlook.com (2603:10b6:301:4d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17; Wed, 1 Sep
 2021 20:31:10 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::41ef:d712:79a2:30c1%7]) with mapi id 15.20.4478.019; Wed, 1 Sep 2021
 20:31:10 +0000
From:   Babu Moger <babu.moger@amd.com>
To:     writetopawan@gmail.com
Cc:     bp@alien8.de, bsd@redhat.com, corbet@lwn.net, hpa@zytor.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com, babu.moger@amd.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [v6 1/1] x86/bugs: Implement mitigation for Predictive Store
Date:   Wed,  1 Sep 2021 15:30:58 -0500
Message-Id: <20210901203058.14598-1-babu.moger@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210519055001.jtos5a4nu6j6kum2@devbox.home>
References: <20210519055001.jtos5a4nu6j6kum2@devbox.home>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN7PR18CA0003.namprd18.prod.outlook.com
 (2603:10b6:806:f3::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from bmoger-ubuntu.amd.com (165.204.77.1) by SN7PR18CA0003.namprd18.prod.outlook.com (2603:10b6:806:f3::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Wed, 1 Sep 2021 20:31:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f861e4-33f0-4f5d-d928-08d96d876f53
X-MS-TrafficTypeDiagnostic: MWHPR1201MB0063:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1201MB00636B6817EECD7D9EA0006295CD9@MWHPR1201MB0063.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pPmkKVvSpj6YOMXfSMh5RyPBkSp9I53R32CIgD9Yll81zfnR3u2nRHer+XUZ3qmzKWzuXkRVhAk47iyknNAVeY6cYWcjZVO0LV7ZC7djWEXsTWrkWlZzEN8YexPtbI6QGLuhz27odOh9nuyAZRYFvPbjrohc9hBmzodeskm+jYydO+kprNha9JFvDzk2HAQmPx/q39rXRJyDOMnLBvDBkRw3pOMQC/zzWysI/hZ0wgOSZBxGnYJ6e0g/4qEJW3gge7xtdnsEg8NnW27KgJhkoJ8F0TPziyLhtcbsiHLTW0YBCwjkWTt8rOr3aqiiUNfBAlvLiiijqcgf5SyxftdodY6e02pK/E6l0GLlcfHFD3hF/aa1nwJi6rhddAnV3/WKDca8zDij/QHKffoWBFVELelcM3GdUQ8WeJMO1+gaOj7IvhbM3RLaiaozh9YoXe/OEl+fNjsTmCT2XJP0ram4vlfumIMsNpK3/v7P/FsJ4fWCLLleVg8IKL0Bpj6s9yGxeF2g8WHoH5Akm5qtCUDrTBRjKTno9VyDRPp3ArNC8sDeuv0+7ZOuyZG/hKYITSnXXZ/1X+gojRglQEQ36b7vi4+RIhyxYYiVTowXcbXaia9ijcn0y7tlXs5mTCWS7EcORSZOkxN4bV8LrXsAEQySux5bOfwdLqJRqfYSssmHw7NgigB8vMjYsyJz8nrbK6zxpbibfK2ZuRCWm2Kl3FSJPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(366004)(346002)(136003)(6486002)(26005)(2616005)(6666004)(4326008)(2906002)(86362001)(7696005)(5660300002)(558084003)(956004)(44832011)(8936002)(316002)(38350700002)(38100700002)(478600001)(1076003)(66476007)(6916009)(8676002)(186003)(52116002)(66946007)(36756003)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9eBEzIh5AtSgWcJjq8AqwdTZtM4fTdYlchO7s3L3QUtpKYVb9lLbexpFdaWg?=
 =?us-ascii?Q?DHoqUXe4JpYQWuIA67gFPOeOnZZlPGa91R3pLEjtrdd9GedBM++WVXJ1k+U4?=
 =?us-ascii?Q?5DVcJ94ZY7wufRT4zOpLAIn4/l/KZdVB7L3HtiE87P9zIT4lOxWkvEShipyv?=
 =?us-ascii?Q?yE3sku6upQGVJnkcFzp0aw/CXSbUN8RfGLwiQDTkqD4oo2AGlMcS3TQHlYYI?=
 =?us-ascii?Q?WGRbkIh48n8BsBeiHb61GH1zM40TyzWGXC/lQBnC9SK3BEvylln3dOr8gb8x?=
 =?us-ascii?Q?IyeZFaER6oHFYMeI6kVLUdcW+mwdgchaZcCRV/PNySUv8sTJ7B9bg+uVf9Jt?=
 =?us-ascii?Q?XYudE5YbIx3CSnEZ3hGl/0bA5fBOccXUJsKWP/7o9KJ2+nJsUkukwqh8pOwy?=
 =?us-ascii?Q?DblQYqLMktHLxNsQfuq3OhKGeXcZSsux+0nWtDfP4xFcAilxXdwrobvG6WfF?=
 =?us-ascii?Q?Tk6rUGA6ArPmdZjVaC9YCD6f0KJvHksTB3ITuqKw9ilzlt122iKyopLAw/Mr?=
 =?us-ascii?Q?Z3voW/6y9n4i/pHuXnd0vM8TAgHpW3nE6+Is3T+HoqZD+7MmfGImpw9wJqrz?=
 =?us-ascii?Q?rrPVT+dVD5xmG5kl9W3O/zGDV3O/PFYNEenelvTEO/C7EM4l8II8E2RKeG9Z?=
 =?us-ascii?Q?BfMvc1QAg0HqseMMF62y/2O+CCqfIAXamGkbfi+88Rxlk2T/EwY1YVrH+/RU?=
 =?us-ascii?Q?IwtmfDu1vQoU05s94Ptd7Xm1zOH9EDLcf8i/koEarIUESBgZBtNOomyepJFK?=
 =?us-ascii?Q?TUN4FLHHEWzFsX3/SvHVsds6HzWtjVxDrnZTOpsIm5MgGkEJ4r9/wOeNkjbP?=
 =?us-ascii?Q?Vche3yVhDDdtgBLADPDZsy07PJ4ZdcNRKyPLfGJIqDm+4bcg5UZsD0tlC/1+?=
 =?us-ascii?Q?MGU0CuRN7v5grubP2yQ1sYicI59S+6qhrF/9OZlu9RmzMUXB0LUg8Da/G+ga?=
 =?us-ascii?Q?brMXSHoWOcb6dIWYJ8o2AM+gFq6/1Yi0bAApKAUn8vrCGOPpOpl0ocJw1B7t?=
 =?us-ascii?Q?F8kwMye/iybZVDn09hmChjxzQXEpCwSscp1fHuWjyR77kItPxweTJ+inFmSS?=
 =?us-ascii?Q?Xo2NpTdCG1DOpMc2ksw+ZtJ7u0on958QkRL8fwxSDqdSf9vsM0QkSmZBqXxa?=
 =?us-ascii?Q?ZEdJcmQ4WTvvUT/Uj/BMS1l3GiFIG7NNZ3zBDTC21JHfG59vA7LKqfl7zhYY?=
 =?us-ascii?Q?TCxoZgUyGm/KpLiNrKeIlXiBeUcS3Sriull/2Z3mEbnsBv9/VJnrKVj4yLhL?=
 =?us-ascii?Q?REuNyPodp/bsidCwAaaaePhqVSWjWogFPNSSzFg0k4gO4CZu0r8HVHYUJDlZ?=
 =?us-ascii?Q?bXLG+bpfh+ppEsXJiK/SQEYy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f861e4-33f0-4f5d-d928-08d96d876f53
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2021 20:31:10.7873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mwLLAEIMvb8zcU5G1R+AciVvss+ZohUGuUtwG8bFbc241kUcq4fkfetMGx1gye1C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0063
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pawan, That is kind of odd. The ssb_mitigation enums are defined in bug.c. To be consistent it is better to keep it in nospec-branch.h as they are related.
Thanks
Babu
