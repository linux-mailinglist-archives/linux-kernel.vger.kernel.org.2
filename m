Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A040424C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348695AbhIIAb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:31:56 -0400
Received: from mail-bn7nam10on2060.outbound.protection.outlook.com ([40.107.92.60]:18913
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234769AbhIIAbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:31:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=amEJN884B+4jEEOrJfNrcS04ni3NtDjc8vABmrz9yPWSwQXaDFhONKyfvGxCHaNAfGVFprvIJo6BJMAi2dcZtmpB9L7KL67BNXEEM8G0SrJyLm5AJJMJVODFWpT5qxOO/Bk7D9Ihed5CRGmJoVGtyqakhV1Ptq+ucpmtiYHMwhlFYXlBYBB5/MNrIz7daZTpFwM6sKmSVXQQb14n7EZpKDOcBy57v+AzOW8YCq6pDIPYZ2YGgqwlnkwsTSfDZjJcO/iXANpwTgngGtEf5cUDxZRlDaKUylMNpBdbp7AF0Lu+2N3LC1ZKSsQUFwWL0/asjU4FPqp+ScJm6NFAFAbRbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iJCCsDddwZZJpsQWkszl7zYVZ01PqM9BETF5j4tTo2M=;
 b=kTWe+T4PiCXBA2ZM4desgjjd3vysK8FqbAW48pBtapNjEitKhrU/P9o9TiAJir1QhqSgtcU5+jkOrDYQTg75W2YwNjzleOS696RKWQn1EyiVZ7r032eMXC5zGSciBIAwuZkZ3RyRAZPj++BiNp14VIWQMoC0EQ5k62+VCHvyUr6a31LKxVDhpqNSf7w+EvyP2y4fP/3oWgKz6+UXHpZ7zpvjzI7lXZUWjW50hldV4Y5D0EVC6nOPCCF71t1pIY06Wt4QcaEv6CUxJ585hzBm9oOL2+KrKYZ4kg391nSGZGR3Zd+TVHsJkihZLLIzRLKXGNlKTOgA2Er+2GB0V3YpXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJCCsDddwZZJpsQWkszl7zYVZ01PqM9BETF5j4tTo2M=;
 b=G++gt+NGgw4ESBciX6u0qlyOQIwB6w+o6vNAvP8xDohXzuLD1OaHvVAhOmPBRXWMQsgRBBqpaeE0H+jSVGwJozXz9ma4HErTRMP1YW804/HPTe621rHBYLfIPclEqq5HhfQ6a6Uj4xc1MPQi4D4Rv6zQzaCYCYhFmbNY0XJWoT8=
Received: from CO2PR04CA0110.namprd04.prod.outlook.com (2603:10b6:104:7::12)
 by CY4PR12MB1573.namprd12.prod.outlook.com (2603:10b6:910:d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Thu, 9 Sep
 2021 00:30:44 +0000
Received: from CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:7:cafe::3f) by CO2PR04CA0110.outlook.office365.com
 (2603:10b6:104:7::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend
 Transport; Thu, 9 Sep 2021 00:30:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT013.mail.protection.outlook.com (10.13.174.227) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 00:30:44 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 19:30:43 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 8 Sep 2021
 17:30:42 -0700
Received: from hwentlanryzen.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Wed, 8 Sep 2021 19:30:42 -0500
From:   Harry Wentland <harry.wentland@amd.com>
To:     <amd-gfx@lists.freedesktop.org>
CC:     <ndesaulniers@google.com>, <torvalds@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, <arnd@kernel.org>,
        <sunpeng.li@amd.com>, <alexander.deucher@amd.com>,
        <christian.koenig@amd.com>, <Xinhui.Pan@amd.com>,
        <nathan@kernel.org>, <linux@roeck-us.net>, <llvm@lists.linux.dev>,
        Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 0/4] Fix stack usage of DML
Date:   Wed, 8 Sep 2021 20:30:35 -0400
Message-ID: <20210909003039.25870-1-harry.wentland@amd.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a683dbd3-18f4-4f40-1441-08d973290fa3
X-MS-TrafficTypeDiagnostic: CY4PR12MB1573:
X-Microsoft-Antispam-PRVS: <CY4PR12MB1573C20DBE47E4F698E40CFB8CD59@CY4PR12MB1573.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HVH9CME7ZQHl8Lg50/4vysO7Q/EG/73LzWaYYhPAfAUwwqXQON2I0uVDpAy7t40KzZiqc5EJ3drqk2+bgOPgjP7aXz2DGuzi1qzFjbzSFKrNFlSoDjPBF1/cbeWMfRnWH1OayaxXJ3LReiJ9PFX3fA4cN88g2A/q8xZaWEuVnPJWbeAzuwhy3QmOln2H/HIp4iibh3SLQqieKBM0B/pVpGqDKW8FtGYCbWOK79qTEiVQHzB6HizMBDwRR1qtqyfV1oXkV0eEtZzVfBkq1eNe70vWBjyYg5dhgdu3zuo0Urr/8s9AWKWu+bBbuyCiB2W/cfeDWlLRjH6zaOH384UyCNfX6BfCXAGXNm8ZHiSEFRavghtrmQkErs5xKBM4E+yxgeewjY1Jf+JkIZt5HA1B8dcib/Fhk+7R4BjJZeqTnrmfqFT+LE34H+/Q8PQIr/1snntjovw+m72oRXGmNQfHRBuXw9/XXeavW2WIPojvElht9pkStAIxzG9yo3DDYSaf6x7v5MysyxM+1nlnSLOXAG20SIif6B3COkjbOTXQQnMjuG+JlOf7fK1k/1qxXg8IYi5x6bDTGYDta2xFg1OI6TRxLyxgiRuAoVAButoLg1ELJjSpFMPHidonKPMaydSqcjtz825HLJyPd1qYAORIxZ0buoJQEhG2iGQjfq32iSYIRIkQlJiVMjsLxWP2165jPQYKKL5dGmkN3QQ/c+cRaO8A5F2inPar0ayBXdxAg/Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(346002)(376002)(46966006)(36840700001)(478600001)(2906002)(86362001)(6666004)(5660300002)(336012)(1076003)(8936002)(44832011)(356005)(8676002)(7696005)(54906003)(81166007)(82740400003)(186003)(316002)(82310400003)(36756003)(36860700001)(70586007)(426003)(4326008)(2616005)(70206006)(6916009)(26005)(83380400001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:30:44.1295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a683dbd3-18f4-4f40-1441-08d973290fa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT013.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1573
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the '-Werror' enablement patch the amdgpu build was failing
on clang builds because a bunch of functions were blowing past
the 1024 byte stack frame default. Due to this we also noticed
that a lot of functions were passing large structs by value
instead of by pointer.

This series attempts to fix this.

There is still one remaining function that blows the 1024 limit by 40 bytes:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6: 
error: stack frame size of 1064 bytes in function 
'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]

This will be a slightly more challenging fix but I'll see if we can get it
below 1024 by breaking it into smaller functions.

With this series I can build amdgpu with CC=clang and a stack frame limit of 
1064.

This series boots on a Radeon RX 5500 XT.

Harry Wentland (4):
  drm/amd/display: Pass display_pipe_params_st as const in DML
  drm/amd/display: Pass all structs in display_rq_dlg_helpers by pointer
  drm/amd/display: Fix rest of pass-by-value structs in DML
  drm/amd/display: Allocate structs needed by dcn_bw_calc_rq_dlg_ttu in
    pipe_ctx

 .../gpu/drm/amd/display/dc/calcs/dcn_calcs.c  |  55 ++--
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |   2 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20.c     | 158 +++++------
 .../dc/dml/dcn20/display_rq_dlg_calc_20.h     |   4 +-
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.c   | 156 +++++------
 .../dc/dml/dcn20/display_rq_dlg_calc_20v2.h   |   4 +-
 .../dc/dml/dcn21/display_rq_dlg_calc_21.c     | 156 +++++------
 .../dc/dml/dcn21/display_rq_dlg_calc_21.h     |   4 +-
 .../dc/dml/dcn30/display_rq_dlg_calc_30.c     | 132 ++++-----
 .../dc/dml/dcn30/display_rq_dlg_calc_30.h     |   4 +-
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 166 ++++++------
 .../dc/dml/dcn31/display_rq_dlg_calc_31.h     |   4 +-
 .../drm/amd/display/dc/dml/display_mode_lib.h |   4 +-
 .../display/dc/dml/display_rq_dlg_helpers.c   | 256 +++++++++---------
 .../display/dc/dml/display_rq_dlg_helpers.h   |  20 +-
 .../display/dc/dml/dml1_display_rq_dlg_calc.c | 246 ++++++++---------
 .../display/dc/dml/dml1_display_rq_dlg_calc.h |  10 +-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   3 +
 18 files changed, 695 insertions(+), 689 deletions(-)

-- 
2.33.0

