Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 897CF41D38C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 08:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348360AbhI3Gnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 02:43:31 -0400
Received: from mail-dm6nam10on2078.outbound.protection.outlook.com ([40.107.93.78]:28513
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348342AbhI3Gn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 02:43:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XM/pY3HSe7jITFDFNq4FRz+kXoLoz7diSGR7lspxjYkYhOgexi81e0eZHarI94YBgn6eWS7N3nkKunnFjAsXeMA5LBY0PZFHi+FtNDsDXaDEDJ8Kr31Q9BgU2dDX2AI17vwTISCovLcFS0qqhf1ct612o8//3QbhMF2TPmAouCQNRKNude6KUWOss+1144LHFr+GfKZsi8OiI8+nASgjnb6lYrAcUoMTeEu9giUeMgjF9rbkW5EH/zcbAwIE09+lQLBRsxjvBuKo7XIE777eJKdn6dErg9VYcRcfwsU8syfH26Ni7woTTslcGkGpd+ar+MpcyRVS4wlItnuD4JrmCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=doO7o9jEr4nKsmiDnV3pgrPe+RrvT71+o8qMNizl/2k=;
 b=d2xTP7T5XItfq3odp3eQJ1onejUSuloeugyvkQ/escFPlndDow68x1fr7EHqEgFAuh6aXjBv5vsR1bB5DDcO3v3qUA3vH6MbT3f4fq7E6JHjgpACXEWE2PxhAIBs2oh6nEGxHnj9ED6oYKWDjwcFALHgu+ILlBA8VWUORU9Onk3fKC6BAtgEubJHA+7ctHuA206sOhZU5hKrYlqgy+pb+s1CU/AxL/G9fNss01Uya6cvk73MhgfzzRea1IDeezFMIOjeOP3nagCQRKX60F9prrg8EL9qcwO/u8QH7f7/IU4BsyB4IISVbvt826f0LhRd3ISO2oDDkl7fcNCQI0SRnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=lists.01.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=doO7o9jEr4nKsmiDnV3pgrPe+RrvT71+o8qMNizl/2k=;
 b=p1M4BuT272c6UwkeufO/do7IEWmhl0wXraggBDmwZ8MXeMVgJqBfgR6HK03Vp+XVIOF32fit0NUMeVJWA3c3y6GY1IzesXzLsAHOJuUa9okHiFTFSGwvKKdSOmM4Pu2qnf3jyoOVhfkG0an7L0pgyI3PUDiH+JA6X1mpMhaGpba52E3q8AlZv0u7phzRKDU7uzH8Ik1DfuZbq7hFXW4t6rxzRAZCWahIb2jOv+LeX4vR0mOo9ndMEjr5tCtmQgEwame54APZBG5JIgyMQftVHhWt5WOlvrKND2yYzVltbDwqLiWSwkEiSPIX904HozwTlSpgx9d3P85zvYoMM72f+Q==
Received: from BN6PR1101CA0021.namprd11.prod.outlook.com
 (2603:10b6:405:4a::31) by MWHPR12MB1280.namprd12.prod.outlook.com
 (2603:10b6:300:12::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.13; Thu, 30 Sep
 2021 06:41:45 +0000
Received: from BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::1f) by BN6PR1101CA0021.outlook.office365.com
 (2603:10b6:405:4a::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14 via Frontend
 Transport; Thu, 30 Sep 2021 06:41:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; lists.01.org; dkim=none (message not signed)
 header.d=none;lists.01.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT010.mail.protection.outlook.com (10.13.177.53) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4566.14 via Frontend Transport; Thu, 30 Sep 2021 06:41:45 +0000
Received: from localhost (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 30 Sep
 2021 06:41:43 +0000
Date:   Thu, 30 Sep 2021 09:41:40 +0300
From:   Ido Schimmel <idosch@nvidia.com>
To:     Nathan Chancellor <nathan@kernel.org>
CC:     kernel test robot <lkp@intel.com>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@nvidia.com>
Subject: Re:
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c:2022:1: warning:
 unused function 'mlxsw_afa_sampler_mirror_agent_get'
Message-ID: <YVVcJLSwGPWyFXKl@shredder>
References: <202109290245.bpgij5Zs-lkp@intel.com>
 <YVQ1cE0Ke2cWzB0r@shredder>
 <YVSWzZvv5fX4iDb7@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YVSWzZvv5fX4iDb7@archlinux-ax161>
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 528bc7b7-da89-4b8f-6e32-08d983dd5ed6
X-MS-TrafficTypeDiagnostic: MWHPR12MB1280:
X-Microsoft-Antispam-PRVS: <MWHPR12MB1280BEE025D205CE164B077BB2AA9@MWHPR12MB1280.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MJr/OJsP8fLvUVPIp5pPG1KhvaV5jinkht7ZwnrclhQQAPEmx1Llz8crIg+GAemqZEm1lSOPRSSQlkLNSlxGcH3Mv9/lk9GzmIVFEfnCE7VOtJqgTnQfb9boEbBaCl1qCj1R0k6gn93QKc6MrSBsmEok0IehvtE0oYnYXWn9xhEqTU4ND97gsJcMUK+35RiV7lNSrrALWhS5vWarntACyq79JWvr8YaNelmt6dqLadF2HJqt0QT6vttkJ46LAs+t0JM/Miq7McZvnP1LwqhpDyLYWVftEzrTVNFjtJJo1FoQseTFBWX9ySgtUvD4UHGCEu1Zi3G1aDhzLDhMAwsZ0aq6n8URAEBXP+aapUlox/ipDMTWQUYHp5N0vMDlaywJIqU08NzS6Io+4cthGQPVtc4Pxlz+XPkaBZb2Msd1uIpDHXzP+meHC2CBAewYU19wqW4OPVtqkA7i/MNaM3L5V8zI9T+hTLw6gzOPDK7pGD+5nihvr6oQGwdC4nIkkE4z14S6YxXtxjqMRM1ElqAELTu4ski0R4UVVG71jpQGxHjPHRjTb9Z/DJPOiYkOjWR2Jj3+PsOVIz8On0vsd3IxUyf/8bZsCMufG0qtttwJP5YnTGH1Lz1zZN0wzDT/UjzJ827SYvU/5Oo8niXG6pqkbN9RPumaBeqAZvi0N6ySImytZo2/HvKKZn8I/IaRvT/5uff7+DkyVkNfmQhBvylbRw==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(7916004)(36840700001)(46966006)(4326008)(336012)(356005)(6916009)(426003)(4744005)(16526019)(186003)(107886003)(36860700001)(82310400003)(86362001)(26005)(33716001)(7636003)(83380400001)(316002)(508600001)(2906002)(5660300002)(8936002)(54906003)(9686003)(8676002)(70206006)(70586007)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2021 06:41:45.0179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 528bc7b7-da89-4b8f-6e32-08d983dd5ed6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1280
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2021 at 09:39:41AM -0700, Nathan Chancellor wrote:
> Yes, I would say this is a perfectly fine solution. The warning is there
> to make you consider if you have forgotten to use or remove a function
> depending on the context and if this is expected behavior, silencing the
> compiler with the __maybe_unused attribute is the right thing to do. The
> kernel does this for resume and suspend functions as CONFIG_PM might not
> be set.

Thanks, Nathan. Will send the patch to net-next (most likely next week)
and copy you.
