Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8105A38E352
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 11:27:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232613AbhEXJ2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 05:28:21 -0400
Received: from mail-mw2nam10on2088.outbound.protection.outlook.com ([40.107.94.88]:42363
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232584AbhEXJ2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 05:28:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFOYMr5Hktg3/Q6Fjqii8xfqxiFD9dIpudj2SI9DNvQoSmQDPnBHU9Gizdz8iF8U02BTZIZb1Gyk+OWLhK5ffjSsCrrciy/nevCWrgbX2oHcpv8GtyKlTnPxAvGFtZ9+q+idVSzsX5DUyAH9drMdL2bzz//osum2shbGwkB1h3WMenPs6kD2ejJItWoGtsqSmRNYrRFdBdHnLnNNxab42WSlr4n/4ksDgo67r6njvtDcOlM97+uHCjjsQ2m1gsUtDgJoWZeSqUvfusGtKDeAG1wmeJBRvepx+kjOW8BU/WVQorpleLyO8LAfcMPAPJ+vLYRZD3ohMiRVj7JkV0ywFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRNA0oHHAAfb7k0OVeGAn8OuIozWU2vJ7j619QPiPC8=;
 b=M3jrCVbpR9c9hSyuWXBXWgFNa6sJpndNPRchDivE7I20UfOhRtwBfZjKYjiMNo/IWHRuuVUDkQq7lV54Auronudbem7eEb5GfKCjbAfekZK5CVBAHJ4ygHPi/8yUMFw63B3xasggSa72BMp8yKQNfuLErLhQZfyfHddR9kanVNQYXCrvOqRD3dEjYR6r/Q67pnmMOP4/icCNfZpsAc4y26MhPIP2MBESZC8qQwigvuhDvxtTmVJR2lpl9puXLP4mb4J2efAFogwJSYFdPq+Wx53e951eEu2a+GwY9eqYvHJZmIKxZC2xfhgTi4ak6kmuI8CnvaBVd5kuWvOQbHNVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hRNA0oHHAAfb7k0OVeGAn8OuIozWU2vJ7j619QPiPC8=;
 b=FPiAYLO95I8ft+GElYZ9eLUqBUdxLfQ+0E6WgkExSFtVHNJkbTDC0m/IBt132kvzS9IIH4pOQmTc8G8L9fQmYDyGBUpqQjDL/1qyMDeiDRcNH/9RQm20JD0coKJR4Bp8IgP/apTyC0DA3FTokbOjnHoxq3PBdIJgij5LULuAIwQ=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN9PR03MB6188.namprd03.prod.outlook.com (2603:10b6:408:101::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 09:26:36 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 09:26:36 +0000
Date:   Mon, 24 May 2021 17:24:33 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org
Subject: [PATCH 0/2] arm64: remove page granularity limitation from KFENCE
Message-ID: <20210524172433.015b3b6b@xhacker.debian>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR17CA0069.namprd17.prod.outlook.com
 (2603:10b6:a03:167::46) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR17CA0069.namprd17.prod.outlook.com (2603:10b6:a03:167::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26 via Frontend Transport; Mon, 24 May 2021 09:26:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72084e03-aefd-498e-c934-08d91e9606e0
X-MS-TrafficTypeDiagnostic: BN9PR03MB6188:
X-Microsoft-Antispam-PRVS: <BN9PR03MB61888511E6836EE8C9A424DDED269@BN9PR03MB6188.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HU0fb9/f0lnh5th+0oPMncZXGmB90NV5dWeU5cpWdnYbA7G1C6HnNaa0mvn+95CiZVz1KT6huJGHxrB6OGVxXT5LwBIlKb5aPcVid9G7ZcXYDcJwKajZwHnCFhiLRaoGlB6lGLpA9FX5QTB7q9kbjGqTPot8qw2lkql+bhm6aEkgzeKeWDFCPPSX5XiMGH4aqoqrIfHg2IObx22SVaA6rzmcV81o4MtxX2b8xBEBZ+8g5rOH0Ws007EEdABc0OzFsjUcHT7kcAQG7UUFGlT0EaGqfTHljaxazNsrAc/asmNN3f4Z0XlQWsxMCeVvW3DNIwXbRgpLxBDmwuo/khD7grnJ6Zrni2sJ7gcV1XiRCSflystUmOloJB7EID52kzRUKouPoW1hXcI+/PlsB6pOjefob8APEnxh52szLd1SlemOa3Zh/HF1pyyu7vY0LBd7QYh5RIRKQTxKEn1uDrrGb6WTOu/oubX6IL5DPpvMGCYjNhsCrRYSquVJDC4DfiXNon3XVSfjahBPBy+R9Ubu/2iAXPWGgjukRddTzvkMjEqCLCoTFy96/j9Eapk23QbvnGwBX9wHW/DqsuZmcVTiyRDnJ0SCJuFYC2e5QPlW+k0KtpVTs23yfdIq1FIAWNrDm5Ud2mWhnoMc7Led3psXow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(346002)(376002)(396003)(136003)(366004)(66946007)(1076003)(316002)(66556008)(66476007)(5660300002)(478600001)(2906002)(4326008)(110136005)(4744005)(7416002)(16526019)(186003)(26005)(8676002)(52116002)(7696005)(956004)(55016002)(6506007)(86362001)(83380400001)(38350700002)(9686003)(38100700002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mYVev3WUnmp5ThBPekDsdnf7Ev9VcjKokVWKl7L9clFGs6rbu/gFoPn8UCme?=
 =?us-ascii?Q?MlPj7XpDk5ucsDCpLP6zim5bDpslAGxmk6rXRr90NZ9bCqnIGrPiRfzX7g/9?=
 =?us-ascii?Q?EC/zgVDBfzILHVsb/VbYhbfuAV2VxQNUolBgKmbcbKGxd673lgG4cJha+JB8?=
 =?us-ascii?Q?X21jLkUYr4kTRBCzPOfsqWKelN9hYM/5M1afKE84pfN4lgYqsZw2r6wPhq1Y?=
 =?us-ascii?Q?w6ptxI+ll4i5hOHh/4ss2M80vB/E9hdSpWfPd2lrLe9vKmLkOH3aIpkenIqC?=
 =?us-ascii?Q?FajkW3gKevUEVlkNL5TFNbj1W2UGyCfMU/55l1qmT7/BHIy/0Jli5WzrWJla?=
 =?us-ascii?Q?6Is8nQQ8vj9JSd0/Z2THy/CmtHxzzATVOd3qqRMSXWaFFES5FkQO0ZBSad32?=
 =?us-ascii?Q?iWfHVJx6DTK9NNVZJpjNNrRBBOtmGkKr4SzdzzrJzJ19gIB6ceSWn28fwfat?=
 =?us-ascii?Q?V8/JTH3OmeJYa69AaQATUh8rvJXdRals6Zb0SBijqmfntYPid6/b4Fggmn63?=
 =?us-ascii?Q?uizVt93ar1LL3ZCzQmZbnWW7OWg8ErTHLdP09tAH24k0Q7l7jz0DXGUaNTeT?=
 =?us-ascii?Q?Nql+t96bxWA6hF3nSONASKXcatM8DOF9CZ2rnCe4At39vywusdDjuSAm8wLj?=
 =?us-ascii?Q?hHUdQY3r+pghI9h1FgDdgecCGJTcK0BWH3Vmw+ebza/paZQ1h80R1HQIf07g?=
 =?us-ascii?Q?eP+Fih6olCc3wPhLSSPmfvd8deXeYqm2NxClKuBdKQ4eEUY9FJBPQ5emFqkR?=
 =?us-ascii?Q?RbIfexCdXU5cRy93TiAautiCaWAhHQ7yxhzvsuKQ2bn2KSBJeUkuFhHr3XNR?=
 =?us-ascii?Q?nZ25CSTWZ8Gk+rDSq6lhhPtQEKmOe3MqWcY69N4whvYmLvOrMP5cJk72ZH51?=
 =?us-ascii?Q?aMWS56VcTZnVFRMN4bTLB/gQnxz1H4DcE2h0LfQtCY1ujN57CWsvMISgcu5P?=
 =?us-ascii?Q?HvnEsVPJK4ofq+UAqM6S/ej6SZM2YbLeZ1CqB1zmwj8993TlJvdMSWO9IjqT?=
 =?us-ascii?Q?DWJ1dIUpFxOpbXhoVeev0GjwYp1H6KCrdy3u47xB7lUBpRd23lDOB4uo137A?=
 =?us-ascii?Q?hBWBMaMPorQe2MdGKRqhFjJahqWgwTlQU9ZMcDh8flXzgxOjeLdCvJNGaWmQ?=
 =?us-ascii?Q?OMBmykIhlbuChK5zKbyV0UNzyW7plQHHZtfSVig7XK+UuOcaiQFk0biKv8Me?=
 =?us-ascii?Q?WuHS+82ezIiuZwglZ2uAft7V8FiTlF/kFS7mb2o4L6NKR1LA7s8JVkwOuAbb?=
 =?us-ascii?Q?nRgNsw1jzRt2NGXd2+3AY/ECoDWI00xCJ3vmNoRfdUiho8880BRUNkbip8gO?=
 =?us-ascii?Q?Ae1LRjvhZEF3eyA4k7e5vC5O?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72084e03-aefd-498e-c934-08d91e9606e0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 09:26:36.0312
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: msrkgwyR1nLD/gaTxpt0BWFFO4E5xv7kFCWGqMP9mQRQaGQKrhyyB+Db9HFGRYR+j8NdCZgoUu2iXXljKgwUdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR03MB6188
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KFENCE requires linear map to be mapped at page granularity, so that
it is possible to protect/unprotect single pages in the KFENCE pool.
Currently if KFENCE is enabled, arm64 maps all pages at page
granularity, it seems overkilled. We want both KFENCE feature and
arm64's block level and contiguous mapping for non KEFENCE pool pages.

We acchieve this goal by allocating KFENCE pool before paging_init()
so we know the KFENCE pool address, then we take care to map the pool
at page granularity during map_mem().

patch1 is a preparation patch.
patch2 removes the limitation.

Jisheng Zhang (2):
  kfence: allow providing __kfence_pool in arch specific way
  arm64: remove page granularity limitation from KFENCE

 arch/arm64/kernel/setup.c |  3 +++
 arch/arm64/mm/mmu.c       | 27 +++++++++++++++++++--------
 mm/kfence/core.c          |  6 ++++--
 3 files changed, 26 insertions(+), 10 deletions(-)

-- 
2.31.0

