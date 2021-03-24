Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24794347093
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 05:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhCXErq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 00:47:46 -0400
Received: from mail-dm6nam11on2057.outbound.protection.outlook.com ([40.107.223.57]:14177
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232632AbhCXEre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 00:47:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GA38Z81AbZOdOku85YZiVk8lW+VB0P1PPV8HVkkb+O9gvbNKDQdE75pnJpt1zgGj7nuLSOepzerlMAe03Y+Cqt+Axo56p8Mt+cVMuxxY5KWbOBs0jL7rcant8G3v9u+v6Lp/sfqELvvwH2NDEG/I2KZk/mU5+gcXgHDku4sP8bh0KtAGpH2w2aB+jSkLTuFrPS3Z3kYEkqeWh6EmKM3EV6/pFowoaIndV4vS1zbzeEKhxJcLnud3winmgifysoKZUQ+vOUIqHaVSFf337KWPXT796UQz1JaHv5255bC23lAWn6aEkt/BASzPCyZjeYdfI7ObLwVeGMnsnSo7P97i1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw2RQGKZ8W4M1UxBx3j4Et0pthks97LWNjF3A8sdNjs=;
 b=JEZAF74vQ9m/LGP6AnmDLplM7LY0SDqQXsyvnS+aY4+rMQMPtV1QBqMUUCkf07db6PxyF6iBQ2ZgOZBKmrECqbmLQ8hhjMQv+OoBJ7+qJYy6mHxXzlIDbFpygikatuVgBJlmrNrNdYaxhM1xfRd70bvPGqw7UQ+3y9IOhW/5BmGcYuTdaWWiZp71VYFGo5ue8kxc23l+4ROrZuL5Smj9vaBWTpCGoPKYFaVAD7dONM66Fftbf2TxtWx6O8BcXBNDDzwNfOmjoDe3YSbg/OeWoWH7hlzYxEiZuSdxdrFVOht+x9RYQels+0fnV3tIQm/6Fz/yaE0ZYGGwHI4IocGsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mw2RQGKZ8W4M1UxBx3j4Et0pthks97LWNjF3A8sdNjs=;
 b=h6vdR1NQoTvMX5qxC0UDvUtfG3120nQHY1gi6mQgUyBcbRCPNOQkqtok9IQG3CN7uDeJZ/FRnZ4VmzzEvyQ22OUpzzdtI30jvJLe0KrOZL0UD9NiA0hsKsDVi+Mk5XQjhrXL+TorUUSWVSlJ3UfM1eI51VCxbum9cFnGbzwBLIcnG441Ckx8yqD8TMKi2NjKthQSaeUkMBnbmrA6fohmAWCKTNwnU1BVWpJNaWEOB4iiMJE5YeDt2v6gOZ8W3o8lsdAxzzD0neJFswq356aqLwuzImM2UkNRTyozvmdnz4lf3eK0FAuNvfs0j6VMfiOnmzPJCh+HnHO6rN7xBq3woQ==
Received: from BN6PR18CA0015.namprd18.prod.outlook.com (2603:10b6:404:121::25)
 by CH2PR12MB3813.namprd12.prod.outlook.com (2603:10b6:610:2c::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Wed, 24 Mar
 2021 04:47:29 +0000
Received: from BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::3) by BN6PR18CA0015.outlook.office365.com
 (2603:10b6:404:121::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 04:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT025.mail.protection.outlook.com (10.13.177.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 04:47:28 +0000
Received: from [10.2.88.242] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Mar
 2021 04:47:28 +0000
Subject: Re: [PATCH v6] mm: cma: support sysfs
To:     Minchan Kim <minchan@kernel.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>, <digetx@gmail.com>
References: <20210324010547.4134370-1-minchan@kernel.org>
 <cbe10402-6574-6e46-9fd9-98b503bd26a4@nvidia.com>
 <YFqxm7UQBtWqH6VU@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
Date:   Tue, 23 Mar 2021 21:47:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFqxm7UQBtWqH6VU@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7a4ee847-30b8-49ce-b603-08d8ee7fedaa
X-MS-TrafficTypeDiagnostic: CH2PR12MB3813:
X-Microsoft-Antispam-PRVS: <CH2PR12MB38132A65FE5EE1861BB3B755A8639@CH2PR12MB3813.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNJ96rA5w2Lsk/6wqx4k7ieJHQNC8HVW6WB4cGQ5L0amhkhQ6B2prbiu7WY3jPpwUggSd/QDRtG7eiVcIcKJmpZogzAQGrpZzfwRPPUKtIjqgkWEq6uH6amg8TZn5Kaph7Z4AbOsGCklpyhC6rImS4UnjtIfiMbcrxEgA7EMqgEOKHdJmmbZm2H6t8H8KM5wxgNDfFP3tPZo/LmLGq6VceGQHPy4GeiKDwZJRes02HxEkEfD+Leh6fSpbGTrmvfzL9oFz/kao6UTxFiNVUXhSUsFN3v7EcXjImnM9Ms4MjZQraM2SOcPsF8dzc7UnIV8tzhYeZf5ZiwexGmoT6MeUNGVmlNfuJTG9uQ3HkzJ6j6G6FyFGVeSaRI6aHWrWGvnTIK4CyN1J9PqOYnLJnctPy4pGiBnlAlDHhzzfc7ZOuGM+xWVEN1ciFS5Z4jScmq/lx8DTXX8NoR0fyYwdMBbB9R2B0SW/F2JC5aWukKSvOo4f8NmTFqOMP2azPywYNmv/ulQxoT3Jl9uDQ4fJW+uRmG2TzKQIGEg+bSRpaAecncibgx/XjqVpQTwGHhF17P+tzClKkBzOgh8jOnf8VTRawtkUMaE5CO005Bk+vZx303zt2paBi+bADtmUhSxc0ARc6+9YlxdaXdRV3nsLeAXx7k9cKWAqUMq4n5JI25XBt+fOb0szR2wpyGbNS4U1tbE
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(136003)(376002)(46966006)(36840700001)(478600001)(31696002)(54906003)(5660300002)(7636003)(82740400003)(2906002)(47076005)(83380400001)(4326008)(36756003)(6916009)(186003)(8676002)(426003)(16526019)(26005)(356005)(8936002)(316002)(31686004)(86362001)(36860700001)(36906005)(4744005)(2616005)(53546011)(70586007)(16576012)(70206006)(336012)(82310400003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 04:47:28.6591
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4ee847-30b8-49ce-b603-08d8ee7fedaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3813
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 8:27 PM, Minchan Kim wrote:
...
>>> +static int __init cma_sysfs_init(void)
>>> +{
>>> +	unsigned int i;
>>> +
>>> +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
>>> +	if (!cma_kobj_root)
>>> +		return -ENOMEM;
>>> +
>>> +	for (i = 0; i < cma_area_count; i++) {
>>> +		int err;
>>> +		struct cma *cma;
>>> +		struct cma_kobject *cma_kobj;
>>> +
>>> +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
>>> +		if (!cma_kobj) {
>>> +			kobject_put(cma_kobj_root);
>>> +			return -ENOMEM;
>>
>> This leaks little cma_kobj's all over the floor. :)
> 
> I thought kobject_put(cma_kobj_root) should deal with it. No?
> 
If this fails when i > 0, there will be cma_kobj instances that
were stashed in the cma_areas[] array. But this code only deletes
the most recently allocated cma_kobj, not anything allocated on
previous iterations of the loop.

thanks,
-- 
John Hubbard
NVIDIA
