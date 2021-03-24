Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9CED34848B
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 23:23:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhCXWXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 18:23:16 -0400
Received: from mail-mw2nam12on2087.outbound.protection.outlook.com ([40.107.244.87]:55937
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229695AbhCXWXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 18:23:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AoDAELtO+nas/lOFj2CicB+rIB+8UTXBKLpxhNfExJO8/1xImhMdSBU3nzwOkADEGMNaVCkOooX2pJ0US9KdVh1LIm5vXBHahC1P9hHCkiOd/TQXhZq+eDaG08WdGDyKwZuFE7ZZ1s0DkwPQ+MMrZcbelytmqUsbnI6VP3ZekFDuVq1s++oZkjakIyLFp2BA0Bh5kwEk7oqHw1Xn+wx82HDtQSMV2AITpep4eYLfEOoHceneabQ2vPBfASufNlo8mFTtRIoc4ttoQZszj+p+T/nLxXnwyXyjjpuz19gp5etlaVH1hFL9sKuW2KZmSKbav4wNDhEDEwwa2SilqpJyNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hujaOSB4YWRydy27Cmyp8JFql0aHRBjAE9lFeIishgU=;
 b=SoXtL5NvUF4uBUj+ul75ahs56xomOSqZMqILh9nbh8iTsCU3Ete6JSXYx5XlxXVJI2j85X8wcecVTN8DepJ5ICvpty6HKg/WZOzTI7m/V8mABWhpCgc6hrFNZTqjnnbuIuAZBxjNbIFBALzsQRX7dz46D8txpLy0NF5a3IWW5KZlzeJmWF6qbC7LK9ZSrgmG9uOh9jbmi4bQd36fUThuselSdvJn1e98zAeiyuYBtJH8gtKXu5x0u6TK/DmwBR9Z3bkP3b8XO3GNN1cjgbDjheRJfSWbgEjIP57zslyP4QcirwmWL0NyvK1BwILAEAwGpWx57ckPJCshIXREpatt0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hujaOSB4YWRydy27Cmyp8JFql0aHRBjAE9lFeIishgU=;
 b=UO+oAPiuBJ0EEOiPIpxBUPcWF/z2coYnXbP7ZyMgXhFBqhK4a/BXmFqSF0P4oxZqDlWx+7kLyrIm754xLmcy6NqcyCxKhitPBxgTTTjh/A4f55F35+EhDhP2Z9q5U9R80rL1K41RK2qnCsY9L5eWqCv1Bfk0yhWnKDCfIhcbGCNN7Dz5a/tuplBZ+e9hFXQf4HREZfhGoEJrvfEHCj7IeyfNRtEpN2muPXagp9TUfQ5PFudTr5IPrEq44acvD2FEFoc1KXNQ0B2lSMGWyIXrZsTCHa9hRoPpw0Cczl6YZQPvoVkekqGnE6s49Fv/PiQ96Kobo8NZeFmanhmQ3YxWMA==
Received: from BN6PR11CA0062.namprd11.prod.outlook.com (2603:10b6:404:f7::24)
 by MN2PR12MB4205.namprd12.prod.outlook.com (2603:10b6:208:198::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 22:23:13 +0000
Received: from BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:f7:cafe::e9) by BN6PR11CA0062.outlook.office365.com
 (2603:10b6:404:f7::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Wed, 24 Mar 2021 22:23:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT056.mail.protection.outlook.com (10.13.177.26) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 22:23:11 +0000
Received: from [10.2.88.242] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Mar
 2021 22:23:10 +0000
Subject: Re: [PATCH v7] mm: cma: support sysfs
To:     Dmitry Osipenko <digetx@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <surenb@google.com>,
        <joaodias@google.com>, <willy@infradead.org>,
        Colin Ian King <colin.king@canonical.com>
References: <20210324205503.2132082-1-minchan@kernel.org>
 <65840bfd-4471-7c8d-ce71-c4705baf3bfe@gmail.com>
 <0ac4d495-eece-fb71-d334-a46e069b0c35@nvidia.com>
 <0396987d-1331-51a0-83f4-0c49dd3e150c@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <b5607405-d794-0035-e8db-5525aee29e28@nvidia.com>
Date:   Wed, 24 Mar 2021 15:23:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <0396987d-1331-51a0-83f4-0c49dd3e150c@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9dc2b6e3-81ca-4e91-e778-08d8ef1368a5
X-MS-TrafficTypeDiagnostic: MN2PR12MB4205:
X-Microsoft-Antispam-PRVS: <MN2PR12MB420521943CBE1FBE4A5411CBA8639@MN2PR12MB4205.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bVrjUqbUJPuoTuESMuLmJFEFmxmt+eqj/bRu+5oMzuYoidC8XICXofgpHmN41tzkSrg14hCOwlHBw3QdOLMAPjTo7CAuI7/6ad6mqx1xJv7iQntUxrF+pP1hBfsP6et3uR/s6RFJtTpQ/KY79sy1IdU80tbV0weZJCYYyIDO3DXcQShyB9rrl6Ud8tAe/4352Hwfw47Bb+pKj0/h8LxKmes7fGNOyOs4KiZoSSV27bzcuN7gTLKe6SPOllY8i+Q/ci5Q89QzJUIZoNGXG5iu3lTTTfWqfTjxYJEjqfTzZJouFzhQlViJiLGJdRvzQxrKpqTUgaZWApsgS13UJwKoEIyh/JR2ZC7+MCqFO7GkEOxrGZHP37xKTs5OuHTeHv05ZFF1c6JQeWACGm0kfI47ZPO9sI6YVW/rSZTfRPCM674y1qa3k8baFeZ1h5/BGyE+tW7pQ/v9WGPU7YuafHXHI38PrNjp7A09fdsViWMjFH+EqsRNdkrZex9BilbckyGMBOd+s+lSvPXMBYg/RzJPBnw6rlRPaB2SLhiovF+Jux/1xithVYCsCosYXrhouyV6WOPanyFMFk3V5bS9IZ+rm6o458DjUfRhAq88mGvRFjJIJp9j5qfItO45sgDPgYNJH5BZB3XvlWTgY4F8BtjRKm1sTcceFXtgg/KBjV2JCW4HEjD/kAWanQxNM32BayNE
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(46966006)(36840700001)(70206006)(70586007)(110136005)(16526019)(316002)(36906005)(7636003)(16576012)(186003)(82740400003)(478600001)(4326008)(336012)(31686004)(2906002)(7416002)(356005)(86362001)(31696002)(36756003)(8936002)(54906003)(26005)(47076005)(53546011)(5660300002)(2616005)(36860700001)(82310400003)(8676002)(83380400001)(426003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 22:23:11.0396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9dc2b6e3-81ca-4e91-e778-08d8ef1368a5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT056.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4205
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/24/21 3:11 PM, Dmitry Osipenko wrote:
> 25.03.2021 01:01, John Hubbard пишет:
>> On 3/24/21 2:31 PM, Dmitry Osipenko wrote:
>>> ...
>>>> +#include <linux/kobject.h>
>>>> +
>>>> +struct cma_kobject {
>>>> +    struct cma *cma;
>>>> +    struct kobject kobj;
>>>
>>> If you'll place the kobj as the first member of the struct, then
>>> container_of will be a no-op.
>>>
>>
>> However, *this does not matter*. Let's not get carried away. If
>> container_of() ends up as a compile-time addition of +8, instead
>> of +0, there is not going to be a visible effect in the world.
>> Or do you have some perf data to the contrary?
>>
>> Sometimes these kinds of things matter. But other times, they are
>> just pointless to fret about, and this is once such case.
> 
> Performance is out of question here, my main point is about maintaining

In that case, there is even less reason to harass people about the order
of members of a struct.

> a good coding style. Otherwise there is no point in not embedding kobj
> into cma struct as well, IMO.


We really don't need to worry about the order of members in a struct,
from a "coding style" point of view. It is a solid step too far.

Sorry if that sounds a little too direct. But this review has tended to
go quite too far into nitpicks that are normally left as-is, and I've
merely picked one that is particularly questionable. I realize that other
coding communities have their own standards. Here, I'm explaining what
I have observed about linux-mm and linux-kernel, which needs to be respected.

thanks,
-- 
John Hubbard
NVIDIA
