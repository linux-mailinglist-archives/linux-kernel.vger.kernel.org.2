Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE14392135
	for <lists+linux-kernel@lfdr.de>; Wed, 26 May 2021 21:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234617AbhEZUBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 May 2021 16:01:06 -0400
Received: from mail-dm6nam11on2061.outbound.protection.outlook.com ([40.107.223.61]:13024
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234459AbhEZUA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 May 2021 16:00:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CmV5NhfWAXomyVX6wb/e61f/HVu7jS/2vRdXS05xqupq+Pb6hZflleTvl6UWfs7mp8xyIq0JG7Jr65H1zf7xXy77wBqgIsWqYWzHZueGiy3ToDA8QMSq5TeO4yY2e3Agq9t0FVvRHStJaznwgxTGmpN9vnzRQuIHbBfUOxfaOCQZ+vLZOaYXmwjjpleLzgMOAps/NLSRWXDsNdkNS2jTCOQeoqKa645McTaQukeRvq2brTzWrPDOTVw+3JTvUswS3cbbue2nI01ffuHU43TNIBOkyBqsXGjwEIDBk97jYEV6GW11eCwkFyrS/lJqewlHm3sJbZ5siUxMhOMNTGEhFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhZEnDbSPVwyTbXddwbsVQuukH38/fczIB1BaMEotz8=;
 b=Gfxg9pjsMK9e9pRvap/4EidJcBF43HOQoiF/JK3/fV/13TpmLDZCCpbR26JSdUZ5LPsK7Ko2UIjhArgHNB8diTrx++uxuUzva+bN7cDoBhswXoAidx+Kin5bjsyD71GA+XDty0xYicQKU/yRgQQ1FWEOGcHBfspUpWbZd3WK56akUVo4sAnEVOKt/RAJTkJFdejza1sjQG06iOVY9UAbQ0aRnrWXwm5S7fDZivfKtIlHB0vrrKk2mtHT4i2eO+ujAHxCrRkpkfRFVH/NeQomvyuJTZ2IRqdPum3TwWMX7w3eM9EiHFkRHoWzTCWfpz/Rvhon1RDvj/c40g6klik6dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.36) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fhZEnDbSPVwyTbXddwbsVQuukH38/fczIB1BaMEotz8=;
 b=rM4L6M5GqxYh9D9QgzyFouC3CKQl4VywfSHPYzD6TINidBGsUeRggFB4CC1+6y3OvAcJktx4uw2zV1lBVUZF/bBWhlkksCPJ9zh3BhoIwdwIPJsEGERcnuyMPjIziiJnl9q+++rgW878A3r4FFJpDhuq+0t06dF4IdNMhNRxwLuk8/AAsRAIA02L3Giy++h67W/cZEPJSFmY0MU2RvRGv6NXarJavSphedGYQnsk5m6I13b+36jgOZevsTWxZax1Rs0oCgdXCCarrFsj7Q3lWBw98ewYb8JreQprIB+/BnMkHMkzc1Jnt8j5EnXqZ9nwQAVtk4GG1cP/tG5H8G9l3w==
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Wed, 26 May
 2021 19:59:24 +0000
Received: from BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:111:cafe::32) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Wed, 26 May 2021 19:59:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.36)
 smtp.mailfrom=nvidia.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.36 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.36; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.36) by
 BN8NAM11FT015.mail.protection.outlook.com (10.13.176.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4129.25 via Frontend Transport; Wed, 26 May 2021 19:59:24 +0000
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 26 May
 2021 19:59:23 +0000
Received: from rcampbell-test.nvidia.com (172.20.145.6) by mail.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.2 via Frontend
 Transport; Wed, 26 May 2021 12:59:23 -0700
Subject: Re: [PATCH -next] lib/test_hmm: check page after calling
 xa_untag_pointer()
To:     Yang Yingliang <yangyingliang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
CC:     <jglisse@redhat.com>, <apopple@nvidia.com>, <sfr@canb.auug.org.au>
References: <20210526140522.2535643-1-yangyingliang@huawei.com>
From:   Ralph Campbell <rcampbell@nvidia.com>
Message-ID: <a6fc49ec-353b-832b-d3de-6caabbb55434@nvidia.com>
Date:   Wed, 26 May 2021 12:59:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210526140522.2535643-1-yangyingliang@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c8610b7-616a-48a6-9217-08d92080c303
X-MS-TrafficTypeDiagnostic: BN9PR12MB5365:
X-Microsoft-Antispam-PRVS: <BN9PR12MB536520C3C89A0496698A5CEBC2249@BN9PR12MB5365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UilbFczA4JM9UyOchcK0L04ydbrcyFMPOEGsnA2r0pffXWKpaDXhUwaTx/Jl1TGBQ5tpUra0gWd06BuzT/2J/Y04hFYePdsavKwpckqPzy171+VikrxcOdPZ6+jTX4C5b1Ar89tAZ9OAC8wGZWsfmaWKxmkmJ8QLSR1OZw53vEWRETPJmFpLMNbDjOlR65GYlsXCbBoeRwFULbSdrOLUG1zmb0qyS3yvw1knmW6QBHmSqbG/GUTZEdS2QK1Xeoej8E1TgM4Yxi69E3CpHDC+HgCqh8uu6ruScI8eYNLDtoE5G65m81mlvS7C/577SNVSN5QDTsymlSrpXN11+KVbRAYvMTe+3N7y1Y8fXe4YDZH7Oj98ZD7kvjEQHwZHn22ny1/qz0SnD098Z4NIWDyR2i4m/0E8ebfqj6yFLNcXHpqovfThIA88IZIGDNCnRERTrKBNhL0Z0CEoF3x/cs9iXXlv/40Jkfw6m6q/1t9pA3/fg6ftFpISAN6kQ9KUcHW5Q+nLFvdZXpd4jPhiCZbBiYTX5H0Dy93M+HuF7wRt5ClJXlmFPLdXGdqBIdl00iaGZHF3LRmQJfhN8590UcOXW6NKlOrtRj5mFCctory+YMQUiIGp9wT1KStopgvOdubp9IXTqVZpWZxKp2VMRfjxepKoaEpFTtrWMIcucVtxBOwY3a6roVLLxVGYykFvDV4uBXt5C+HXQj+HS8hOWHCC1g==
X-Forefront-Antispam-Report: CIP:216.228.112.36;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid05.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(39860400002)(136003)(346002)(46966006)(36840700001)(83380400001)(2906002)(426003)(4744005)(316002)(186003)(2616005)(36906005)(336012)(31686004)(478600001)(82740400003)(110136005)(82310400003)(7636003)(356005)(36860700001)(54906003)(5660300002)(8936002)(86362001)(26005)(8676002)(7696005)(31696002)(36756003)(4326008)(70586007)(53546011)(47076005)(70206006)(2101003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2021 19:59:24.7620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c8610b7-616a-48a6-9217-08d92080c303
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.36];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT015.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/21 7:05 AM, Yang Yingliang wrote:

> Check page after calling xa_untag_pointer() to fix compile warning:
>    lib/test_hmm.c:631:16: warning: variable ‘page’ set but not used [-Wunused-but-set-variable]
>    631 |   struct page *page;
>        |                ^~~~
>
> Fixes: 8b2a105c3794 ("mm: selftests for exclusive device memory")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>

