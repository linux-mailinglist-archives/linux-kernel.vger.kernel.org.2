Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC64A3E3CDD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Aug 2021 23:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232556AbhHHVOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Aug 2021 17:14:00 -0400
Received: from mail-mw2nam10on2089.outbound.protection.outlook.com ([40.107.94.89]:37984
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229895AbhHHVN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Aug 2021 17:13:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ts34UMBUI2c0AP5fh85MUNG+XUfuIDieFS7PuXG9qWJYtDFW7akpCOR+DchD6Cg17GxhHGHgtLbUmfEY4OhpVI4YM03TocRnmEXLpQc9tgO4PnMvy19YRqJNhYps0WKVq/XmgncVpTkeM+BG4JTrwduVCsH39NJaz6a7EBhfjCwY2kCNkSwWUSMW/PCPWAw/yGnJi04mK6dxlGuLQhNGPqke+Rprxtvo03GwurQaHdjTAYE058oqhTkXB++irWFksVG2jOftkb1pIMMuf1Ige1ac2SjYYvxR1tO7R11gGCG0b9VA/wECf6LDfHdOeFY/bi7MpNuZeUNDhS+xPSCCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukzGuvMs7I5EhFA9bVD4Brm3bwMC8IIyEXPT+ENB7Vk=;
 b=FUUXJwCni02pPndlmqXatdFlo7lo/535AGwp9tDA7mJ6A5p3WIgamncsE97Hw3CJPvscjF9dV6iONAhQoA4LAMgtSMKrYYX4INVBiO645QImH38SNzu+IHVXi1qxhq+Qkh57Z8Itapgo3b8od55bj2btHFYbUsyb9VHGPIW15k11/Xduj2EvbzdUu46O6ZqE2ZVO0mzPCqSWMrVIVOUzJaEPH79sfaYmM/TpCaikIMIt3aIDjoOmU2doErFWMOpG46RhPe+UG5tur+wZvr/FX679z+topW7471VV0wfFhJHBMBmTIB70jI6G373hZ+FDVmwsTG6+MF2aV3aqzzJMtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukzGuvMs7I5EhFA9bVD4Brm3bwMC8IIyEXPT+ENB7Vk=;
 b=QMm7UAJ4ss2XT6oLXOcA0J8/zec/xWv5lsMheVbw3xrmTz0sWVwqRNS81uqi7a4uOnWJQFz4aHFxPX24/TPoFagwwcWvNMGKg4Q3lomKKMquEpiEVTdfmjAkItzyo/eRkB8z79b/6N/5/OSfjyQWYZ3AXlF6YKkopgmZgRebBP+oFHUQDop3xnf50XsOEujwGFUlBRyvGOl2TLjuExSCtUT6PbdIVMf83PJZ+S3tPeKNzrv4B8JWJ/XipiDeah+Wi/UiitlCukuYJUMuUjIVlou6dnBD/4G7jbVSTveU/Mmxe75Omcb8mbkOyQcRIEV0/jnwf7R5c2plvNGKSraQhw==
Received: from BN9PR03CA0467.namprd03.prod.outlook.com (2603:10b6:408:139::22)
 by DM6PR12MB2618.namprd12.prod.outlook.com (2603:10b6:5:49::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.17; Sun, 8 Aug
 2021 21:13:38 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:139:cafe::c5) by BN9PR03CA0467.outlook.office365.com
 (2603:10b6:408:139::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Sun, 8 Aug 2021 21:13:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Sun, 8 Aug 2021 21:13:37 +0000
Received: from [10.2.53.40] (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 8 Aug
 2021 21:13:37 +0000
Subject: Re: [PATCH 0/5] Cleanups and fixup for gup
To:     Miaohe Lin <linmiaohe@huawei.com>, <akpm@linux-foundation.org>
CC:     <imbrenda@linux.ibm.com>, <kirill.shutemov@linux.intel.com>,
        <jack@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20210807093620.21347-1-linmiaohe@huawei.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <9ddcde41-7222-8afe-1884-5544d6b5fae6@nvidia.com>
Date:   Sun, 8 Aug 2021 14:13:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210807093620.21347-1-linmiaohe@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d5af6b6-60dd-43e1-5bde-08d95ab163e7
X-MS-TrafficTypeDiagnostic: DM6PR12MB2618:
X-Microsoft-Antispam-PRVS: <DM6PR12MB261874DB52D4F12F304EED08A8F59@DM6PR12MB2618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lVO0v8ao5r7WI1WwKu6VoT9n9A71c7s0LB9PcBgca+uG64EOqaRDhoBFCA3DvR/v0Hg2ecIso74tAUFPvvQIO1BhPSBBb6JXg3Slcq1vyVN6LvqvONQNQuDqD5B03K9lUAGyP0Ic21irfNuNvcY/jNsvosNe0uS86mcmPBwY0ZZ0av+2YGh9qqLtKJZ01AoBifyXbytLQKVcW7PMrDKYNxmgOqjIXd49g7op8kPjV8CWB6EcV76QCwwhCdtuwMLJDm+I/TYMPjz4dWirLR4X5gZN3rQN0EW6Zw42QShst8QWRl004HeLnn9gmHwOda6xVs8i97QoXR/ORcWo2zxW3g/NeNQat3crk7jO9+CcR3O05ZAZxHqqcCYuixUzcmOI0fPTyySqE/JT2LCgrB6bIcj/gW+/VRe+npKcVTjUuEyOAybF8BC3vjv52nR4oZtC3YP1fiv3Pcw/oPcAii+P8N/TDl68FXFu9RaZW9vdUSXh3QZCK2VHsjjKgzRW9C1FJXq0R2XEgA+EZK71cExyjryuCa8q0GpIsey4CBSMds1Vcd1VmH+5AhtHIRQtFitHxuW66icsLqmehnYwzVRF/SyyJIdvtA6cJHZMltISpZvFw1ZaK0FSkQBFE3RRn31cyyqFD4Mu24Mv2Xcg/02wFQTZFJusaRhy2k9fV7cRfg7M8ZtTDhqk0iHs+gDY+NhbZxmrs/fOt6KJiUiz5ByXMPS5O0aEMM3Jt1HKwEEi/0Y=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(36840700001)(46966006)(336012)(356005)(36906005)(316002)(36756003)(26005)(16576012)(70206006)(2616005)(4326008)(8676002)(82310400003)(86362001)(426003)(4744005)(70586007)(47076005)(5660300002)(83380400001)(2906002)(31696002)(186003)(478600001)(16526019)(82740400003)(31686004)(8936002)(36860700001)(7636003)(53546011)(110136005)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2021 21:13:37.9864
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d5af6b6-60dd-43e1-5bde-08d95ab163e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2618
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/21 2:36 AM, Miaohe Lin wrote:
> Hi all,
> This series contains cleanups to remove unneeded variable, useless
> BUG_ON and use helper to improve readability. Also we fix a potential
> pgmap refcnt leak. More details can be found in the respective
> changelogs. Thanks!
> 
> Miaohe Lin (5):
>    mm: gup: remove set but unused local variable major
>    mm: gup: remove unneed local variable orig_refs
>    mm: gup: remove useless BUG_ON in __get_user_pages()
>    mm: gup: fix potential pgmap refcnt leak in __gup_device_huge()
>    mm: gup: use helper PAGE_ALIGNED in populate_vma_page_range()
> 
>   mm/gup.c | 16 ++++++----------
>   1 file changed, 6 insertions(+), 10 deletions(-)
> 

For the series:

Reviewed-by: John Hubbard <jhubbard@nvidia.com>


thanks,
-- 
John Hubbard
NVIDIA
