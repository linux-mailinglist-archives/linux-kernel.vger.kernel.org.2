Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4396333A341
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 07:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234244AbhCNGIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 01:08:37 -0500
Received: from mail-oln040092253056.outbound.protection.outlook.com ([40.92.253.56]:14367
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232645AbhCNGIL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 01:08:11 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y9P7cuyJVqJBm7Q5mmyWZK2V84aQjarfbQT86zV3x485EfbsglO/rG6G9fwCrtNTpt55m9o385avH1Mnk3Xq5F+QxnmfpEKfDZpXlNKiv8NY0+hrRL+NyVCbwRcPpt5jnwxT3VNPhr3gKlWhuIpmcISVsksQOlo+/A7nstjIc01Tym9+Etg9zLBPC3dzuJOsFd0OSOfma4l2antXeyxdcXNT8/KD53IuXiOIuGjmPOXuhead3wSSDr0lHEZt8pbNhYSONPd/Ti4a8peKfAsoT8Dyrt4DdoA9kU4S0bYpqEX5Mepp/yXW9Pf/eRMgX7kD877PmJDX76rePratsXdREQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFLl76OXzu0Jzn+5i4LnqUwLOxxmSpYV1AumIAOIVEI=;
 b=a/Ng0uqXyWlbKNfBZoVZJq4rJXhy89+/YnPafXZndmWqEbiANMSGdPoa5yoQ5qQMCwqu20B47y5zY9DX2pS/BpavxNCJWbNgLAp67FcbPmMk/ie1A7QKBBiH8AJPmi5FCnTX5SbS4S9i61Vt3QxQWSCsi91Ro4emVoUCP3ZQmU3LCIs83w9g2A4Aky06qqh+Bojp07uwm6KC2+v9oqbDqQM6dux/39jwsUk5gP62d/OvWx1Oa5Ps73zj0erspyB7traaeZ7grB3YhxyqX4BDjSKxob5Q9CG93+6Ml345ahOZK5N39pMLQvoRCDMeoFet2OXtCltvRLuW7+Ch9YYc+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT043.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::4c) by
 SG2APC01HT037.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::388)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31; Sun, 14 Mar
 2021 06:08:07 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (2a01:111:e400:7ebd::40)
 by SG2APC01FT043.mail.protection.outlook.com (2a01:111:e400:7ebd::285) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.30 via Frontend
 Transport; Sun, 14 Mar 2021 06:08:07 +0000
X-IncomingTopHeaderMarker: OriginalChecksum:39C259FE5A352F14B4F90E9CCB7FA2F8F7C7777EE64474FF5C6A5023171A6FE1;UpperCasedChecksum:95508F51B7664242AB8CD115166DA12BE4B51D1A72837CE4D215B65869FFCCBC;SizeAsReceived:7545;Count:44
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::415f:2d37:68bd:23eb%10]) with mapi id 15.20.3933.032; Sun, 14 Mar
 2021 06:08:07 +0000
Date:   Sun, 14 Mar 2021 14:07:59 +0800
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     linux-kernel@vger.kernel.org
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        amd-gfx@lists.freedesktop.org
Subject: [PATCH 0/1] Init atombios timeout when amdgpu is Thunderbolt / USB4
 when IO BAR is assigned
Message-ID: <PSXP216MB04381375699870BA7E39B7D4806D9@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-TMN:  [qzika/1Wl1kRI7bl6FcuhgjFcdonB3fY0tHfPrYhdmyy47T5cEbZOlGm8qJOxaJr]
X-ClientProxiedBy: SY3PR01CA0079.ausprd01.prod.outlook.com
 (2603:10c6:0:19::12) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
X-Microsoft-Original-Message-ID: <YE2oKkRvBNNxzxoM@nicholas-dell-linux>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nicholas-dell-linux (2001:4479:c200:d00:be34:878c:be91:5d31) by SY3PR01CA0079.ausprd01.prod.outlook.com (2603:10c6:0:19::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3933.31 via Frontend Transport; Sun, 14 Mar 2021 06:08:05 +0000
X-MS-PublicTrafficType: Email
X-IncomingHeaderCount: 44
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-Correlation-Id: 24010f98-346f-47a1-67ab-08d8e6af88d9
X-MS-TrafficTypeDiagnostic: SG2APC01HT037:
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: By0OF3fzekiNoOmYuqZv+kSzA3O7gowIVBe/Q4/UIXoI8bigxHDZbsv9ZkCUf72GMC1et7gOtxQ/u5NGhyTeDmT48jQXXwPwf6z8l+g5rdeK41p89h5O29wLaTOSy/orWGSdvix57RjwCtInb3aFvSmfkRCsXqxjvx0Mky34wWxw8Byq2XG525V2IKBc17/s9pIolhIesSaey2LhHYlfhrd1VyPV9afJRV7UjdUvrd4y5ekSij/DUtQqJRDiSvyIB76ityTQNBlahAAiM/k/mWEjflHLMlzkZvD/gxwN2KiicV/kSugr5M+Gw9i0NSXcRgjZCO4DOD4ktdLgtFS5nzpBY5u1XsvazfWc60FYGu/vn7uIuLQhdD9bBK5+g+XF
X-MS-Exchange-AntiSpam-MessageData: yLm1N6zrcwjDoSoNRMDOa3Ba7Xzz7xl0E1MlqDUR5yPdOGFqrOUxepmMIjcTk+vVcWvGtSoyMoQlbWElCL+bMZUfkkjS/86aL04hncRxmaBsAReZtA0ezkU6xiH2Q+dtnFCOcl/s5hISVUlGhCxC0Kso9PV/pWyvH5YhPC5NMib7n1DMc7IKjHK++PUV4DQVrskbl6oKuU5I13uPTn0s3g==
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24010f98-346f-47a1-67ab-08d8e6af88d9
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2021 06:08:07.1775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-AuthSource: SG2APC01FT043.eop-APC01.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: Internet
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT037
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I am not certain why this happens, but when IO bar is assigned on 
Thunderbolt, the amdgpu init fails:

[drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
[drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B456 (len 304, WS 4, PS 0) @ 0xB51B
[drm:amdgpu_atom_execute_table_locked [amdgpu]] *ERROR* atombios stuck executing B104 (len 183, WS 0, PS 8) @ 0xB17E
amdgpu 0000:08:00.0: amdgpu: gpu post error!
amdgpu 0000:08:00.0: amdgpu: Fatal error during GPU init
amdgpu: probe of 0000:08:00.0 failed with error -22

It seems to happen mostly when BIOS-assisted PCI enumeration is used 
(older Thunderbolt systems). I cannot rule it out with native 
enumeration, but generally native enumeration works, as the IO BAR is 
not assigned, due to limited IO resources.

This patch is a simple fix against v5.12-rc2. I have experienced this 
issue for a long time, and have finally decided to do something about 
it. I do not see a downside to using MMIO, which is required to be 
assigned.

Kind regards,
Nicholas Johnson

Nicholas Johnson (1):
  amdgpu: use MMIO to init atombios if device is Thunderbolt / USB4
    attached

 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

-- 
2.30.2

