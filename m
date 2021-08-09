Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8623E402F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 08:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbhHIGhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 02:37:13 -0400
Received: from mail-dm6nam12on2047.outbound.protection.outlook.com ([40.107.243.47]:57924
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233436AbhHIGhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 02:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n/nyG70pQIEVINnYRKMwm/xFYCV1NicnK+Zct+C+MW9AQj/xLyXmFAcuFQUevkA5uTqdXd9aaRN2B5zXynkD85LJWwJMyC/WhUgbMfGyXbgFMcrhQK2ujVi/o0QIKQ4IzJBnaDdhCc2sU9PE+XO6ulMvB5knt3gmtLIJXRMbmw1RGWZy/AymivQ09XxQG2LsF/l1wvTYNaVlhqoUFuhL/am3wwe3R4NhX02ArrDYezNVFfsuZDam4G40loQODVWt9z1Hl4OEPEqsE80fvDGletb6Prd36n2YbZx9NOO3W+F6reqsh/XR7TIWn4FV9VjBuj+aNcPmIo/T+Avba1TtEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lkq6T77bIMQP+6DDku6PCx9O82tFzXB3B4HCyi5IQg=;
 b=VSPHs5phY0r9CvZSMAlAQL8GWCIInLTRdvRjyQiAGhjYE6KH4buD0bM5hqcw3VMbgKbvLb89pr9wvdTrwqbK4wO6bDO4Qq++VMRkldNcYYqYmXh3AZ7EJErOxnJFuqwlK2pMxi6Qoa4Cd962VdTEkLtO9aRLHTnRgVxWXNXTllOwyCMGStNB1ELthp9Viph+Hy3TNbP6hES/qwG4lo9siuqYKctrHmUVne0DCrvCXDM1OQznuv3WhZiQrzUHxbSzURx3retU9AnYzsnq73pbZ1yKBeMeD6fukCqNPAmTWislAntAwxxFRzjcn2Z+7X6Vkqalysg1j5SfghkRMM3KGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=linux-foundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=quarantine sp=none pct=100)
 action=none header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lkq6T77bIMQP+6DDku6PCx9O82tFzXB3B4HCyi5IQg=;
 b=tHfiIdVt8/JzkIrZ+GULC0PC9mXLc3mHrnCPfkOLYNwtuubT4uwYRahtb/sq3CdJkiHfl3Ot8yvhgHIkBrvU1chgHKZAl1Z7vpUge7HMCb/2ZtFKRDOkldZvaqDsw5jqGM6TwhE6LcX9xBGkjA4asw+D4Si41C+R/mkaUL4wNtMocqFV4vPZZPsfNLtgB4x7oDcJG8azFMnhJXHVLnLzgshectOkofLQgTyu/0fZF31RKlv8UdpRyXoz7+hN+vffbdGsE7YsH1+4aZOxLm8FP/+JL3d+qi1cJndK7JaEoHdhP415Y8YY019j2eQuMmNedHEoqow0SSrIxV9qRGiEJQ==
Received: from DS7PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:3bb::18)
 by DM5PR12MB1643.namprd12.prod.outlook.com (2603:10b6:4:11::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4394.21; Mon, 9 Aug 2021 06:36:48 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::2b) by DS7PR03CA0073.outlook.office365.com
 (2603:10b6:5:3bb::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.15 via Frontend
 Transport; Mon, 9 Aug 2021 06:36:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; linux-foundation.org; dkim=none (message not
 signed) header.d=none;linux-foundation.org; dmarc=pass action=none
 header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4394.16 via Frontend Transport; Mon, 9 Aug 2021 06:36:48 +0000
Received: from [10.2.53.40] (172.20.187.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 9 Aug
 2021 06:36:48 +0000
Subject: Re: [PATCH 3/3] mm/gup: refactor and simplify try_get_page()
To:     Christoph Hellwig <hch@infradead.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
References: <20210808235018.1924918-1-jhubbard@nvidia.com>
 <20210808235018.1924918-4-jhubbard@nvidia.com>
 <YRDLZ5SBm76FByy1@infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b352a416-ca6b-0665-9a9e-621686e0353a@nvidia.com>
Date:   Sun, 8 Aug 2021 23:36:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YRDLZ5SBm76FByy1@infradead.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.187.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6f7eb4a6-ce10-40d1-66b5-08d95b001098
X-MS-TrafficTypeDiagnostic: DM5PR12MB1643:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1643062BB7CE54FD90E0EF60A8F69@DM5PR12MB1643.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 51PrT/FQsi5Gr/I9kzb74sOw9LSpClMJhM/p6leoW7YFZe1AxWCgv9jqOiROObCBBR91OpqpknxEu17zAcN1Jne7SMHUnj8k5L7cB3+IH52f0y5YZdKa4+c2KvR6pRqxtr3t4+Ysbgy5+Ythp6gmlHzjFQmYBauQgqFNv6SeYcgg8UmA5DilwNjJ3FOoC4/q9Eksol/quMFoQsg6INNmiEyH2mUJjjJ37O4jM4H8KMoUsEosY7eGTwUWo5jfRD1akOXDBjA32QkWKzA4MTBJXiU7pGFUgcRnoQ7C8Q12zxrw4CJ+iDzmQOyKyxx3ZKc6SWpexX5JeXJTAT49Vbg6CETpWpnuUAZDeGUJUuBfefm979AKhtQjzjF2YPm1mR0Tp4ROKuJ8uKD3T306AwccxTjyKvQx8odwUHkAwJHJ6EWAw15sQ1pdedCx17KnlDBcyZ19x2g3cmd7Jyq+nIAgznyos6NoPbxAVw9PJnf7IS02Zk8213CGf1wfkgUKMBIFiBStR5UbBTYj1xG+p4bdhSa9Xs+1utimA4/5d4gsUOA6VA+MgTVYDpVsFAe9IWODTMu5LPaCvs0QyRuypaJ6wkKCuLRxcWrDRUzDo6KDyzzlj+CXgI3lRfuC+OM/yxy+USoOzce3knY9PR3hy1kTJ6+dH8EhCsx2Kj/z0Qb8Q+EMAMcGPJiC76PUdH85flXjb3GbRl6Uv7IVFtVG2z7tP5dPBbBBOcNvCTO2aYHAzEY=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(136003)(39860400002)(46966006)(36840700001)(356005)(53546011)(7636003)(5660300002)(8676002)(478600001)(26005)(36860700001)(6916009)(47076005)(4744005)(2616005)(31696002)(82740400003)(70586007)(70206006)(2906002)(54906003)(316002)(36906005)(336012)(4326008)(426003)(16576012)(8936002)(82310400003)(86362001)(186003)(31686004)(16526019)(36756003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2021 06:36:48.5027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f7eb4a6-ce10-40d1-66b5-08d95b001098
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1643
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/21 11:29 PM, Christoph Hellwig wrote:
> On Sun, Aug 08, 2021 at 04:50:18PM -0700, John Hubbard wrote:
>> +/*
>> + * This has the same functionality as try_get_compound_head(), just with a
>> + * slightly different API.
>> + */
>>   static inline __must_check bool try_get_page(struct page *page)
>>   {
>> +	return try_get_compound_head(page, 1) != NULL;
> 
> What about removing try_get_page entirely instead?
> 

This thought admittedly crossed my mind, but I was worried maybe I was
getting carried away with cleanups. But now that at least one other
person thinks that's reasonable, I'll be glad to cleanup the callers
too.

thanks,
-- 
John Hubbard
NVIDIA
