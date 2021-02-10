Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8FC731604E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 08:49:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbhBJHsB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 02:48:01 -0500
Received: from mail-bn7nam10on2088.outbound.protection.outlook.com ([40.107.92.88]:20064
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232992AbhBJHrD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:47:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QzZmKfex30BVNozkgMObCE6xEisZtrCNThOUGz0ejTDvSfXUdhD7jQwQ0W5Wsb4sEnDYL/WCOwoiFYq0zTFqTz8c9rwFKQzIBemIRz1gFMXhMmmsPOoL5i4a8uAhlUOp3RaDO++wk+P9PpWtPoQVsmGMxGEYCFiBSA8KcORzM1Y/Aom0qR8G4eNgLvCYCHkAyGHagZO58aAykIIigS6u0ZcIIufzSNPAG3nZ7GLw8lo9y9OdeniM1+o2Ed4noaNA4/sDKIKF73YKGmTbNdCkxTTS3bQPSJQtSaE4zbXjhf9thkOjj4n7fAstvXD8jt6i/HY3TCtAdcFlJ8SGrk163g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ggxsrKg06qS886z/accRAxAVgeMYsiTsUig0lBPDXg=;
 b=HyONWmfwiktqH4l2eqJs2OCoi3RlwEkKu6au/igMKBKvuuOryLPkBFQ4/+AWecmjxSlbhKu5LCk6ppWgHENgduAo3mMitwi0dY0vBUIgTU1bwpdg2XvcCx/VMFQEYLoqKT3853d0XVoZ8llU1lz9J2CsES4Khkm4Vzs12hNe8Kei4Xl+eGau09QMQGcGrZx23fOT+b0hrSe0oCYqvKx94PVhvH4LXUv4AjsS4+6O1FV5/8YhNW2B2D2wdwd9Y89+9ICnViW4YL1ufZQAQzjzfUTN9S68+1poK7vjj79g7OATvFFcyxn8gSDB4+xutVjoNgHZ9m5gFyDfnmSi0MSniA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ggxsrKg06qS886z/accRAxAVgeMYsiTsUig0lBPDXg=;
 b=5UQKunR169FWgKrh682WgvxqKpmQ6W20p6wcXMHoqv3xqBRlQpP07dIlYrK1n17cQGVrXJJHt889SKqBgiwpznq4PQP/LuQQNGqLkqYL/I9d1rgXGTtpYDamX14MuSOgFkSdUUKK6OuUzFbZiE033VwmwxIpy70sm9B9MmbLleA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4335.namprd12.prod.outlook.com (2603:10b6:208:1d4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Wed, 10 Feb
 2021 07:46:02 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::c1ff:dcf1:9536:a1f2%2]) with mapi id 15.20.3846.027; Wed, 10 Feb 2021
 07:46:02 +0000
Subject: Re: [PATCH 0/3] drm/ttm: constify static vm_operations_structs
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Likun Gao <Likun.Gao@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        nouveau@lists.freedesktop.org
References: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e819cb08-98b6-c87d-4d95-338e06f88a48@amd.com>
Date:   Wed, 10 Feb 2021 08:45:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210209234817.55112-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [2a02:908:1252:fb60:1e1:ad6e:a509:1753]
X-ClientProxiedBy: AM8P190CA0030.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:20b:219::35) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:1e1:ad6e:a509:1753] (2a02:908:1252:fb60:1e1:ad6e:a509:1753) by AM8P190CA0030.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Wed, 10 Feb 2021 07:46:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 17a8d7e6-adc8-4d45-a99b-08d8cd97e9bd
X-MS-TrafficTypeDiagnostic: MN2PR12MB4335:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB433551217B4F5CF4C0491196838D9@MN2PR12MB4335.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8DkFIq3GoWd7BfXPkKpSVvxfBltFyjpU4q0WcDPLtqF4oXWu7/vQ1LQZd+A7CajZATfllZVIEXYTfOc1gmGmYlElkcX1YsqbkVFAHh6wiBToYFc2z4I/T/6wwAYyjbP4f+AB31Zb6d949CFEQJKaba5Hfnt5xkEKIcrRbK40x8Nkell5T8WebOFSIok1XpeWf+gKl61BIUa4a3iY2gyDBZNF94qM4qMAAHDT09g4PxGrsbeI72V6V4SG7MuFLlyOpunrfUCcbvjF0rjixe4PcH30a+9rIQ2JFxvviwo2v7tSMccJ6Z/LzDEQ5gWeKaYXEq88Jx/itK4HXD/x/w/IEgMxbWOAZc8yfIcuA2GF96d+BkDmUom9oH6Ut7/DTnDTJmjqH78NLhb+ueJH7DD/OKPkZ2TCy5X5u1jBL1gk6955exD8oFac60r+bSneuDpm46iCtnJZLsznwnkf6HNi8FicW3RNUR5tDghxQqrixSH03+6s07rz8bIzUkk7Wk+oLc+4eTy4posCw5P8Nh3aIyEZ24X1NFeg0AUtMhyOhfZ701hohC99hhkyu20gBZ2RQKd3iHmnGkvXQOyOHsRUW+Frx3yZhLEQbs46+e5Su2E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(136003)(346002)(376002)(2616005)(6486002)(8936002)(2906002)(86362001)(66946007)(66476007)(31696002)(66556008)(31686004)(186003)(16526019)(4326008)(5660300002)(110136005)(54906003)(4744005)(83380400001)(6666004)(316002)(8676002)(478600001)(36756003)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlM4dnBuV0NIZWtGbjJSdUNCbG95MzVyRmNnai9zaW8zVW84cnpHTHIzK09w?=
 =?utf-8?B?SHA3N3E1RW9NejJGR2RsK3VENDdCZGtSTTY4UC93d2Yrc2tWY0doV0E5RkdF?=
 =?utf-8?B?L1NLaCtnOTVuTHZTb3BwUjJ0OU9UZHlrWWVmOWF2NlZ2TnVaL2RUaGg1UC83?=
 =?utf-8?B?VTliYW5FYkNTdWt1b0lSOHJXK2dYUTZSemlJSEJPb1NiNmZDQ053VWNWWmxP?=
 =?utf-8?B?Q1hYVzFBcDdhSTdRRlJmSlYrWW1HcUVEVEJHY3AvekNUV2w1cUhzYkpqbEJU?=
 =?utf-8?B?TVhNSVhZeVowY1ZMZXlMRlAySm1JL0VGYmdad0Q3Zm5HVFV4Y0gyTGc4R0Zo?=
 =?utf-8?B?WjNuVGErRk5xeEJjcmFDTm15SzdlS0pGY0QrZUJrZUVMY1hudFhTZlUvUUFu?=
 =?utf-8?B?eEVYcWtmV20wU0ZON0dFT2F3ZFFOVnFCL1F0RkR5ZEJsUytpUTdSdzdrYnpj?=
 =?utf-8?B?dmpYOG53OE0ySStmNi9CU3B1OGw4bHZBaUNCVk9JbStPbzdhKzdRaHRZeVVi?=
 =?utf-8?B?czJLTkpHSzl2dGNoYVc4VzVWWUlvTTM2eTRrZ2V3WWR0U3ZrQU5ldzVRV1NW?=
 =?utf-8?B?T2FBZ0lFaDRTRi9BR0R0ejdIelh4aTFsWVVtQkFkOUd2YThWOHRFSlVuWFEy?=
 =?utf-8?B?eE1tTlR1STN0a3BBUUxuTEcySXVBSG14WGxQS3kvalQ3WEt2eFhiRHg1bEtD?=
 =?utf-8?B?VW8vaHY1U1ZKM2JaSzFvQ3hjNEY5ak81SUcyRGlvbDRaRWJ5dkVKSEwvODFN?=
 =?utf-8?B?cnJZZkNHbDdNQlZEczg0SzZ1RlJDQlZqNDN2RjYxK201TWttUy9HZThLYkhN?=
 =?utf-8?B?aHlhTWN3QmFadE5FbU9vc01LKy9SUTFUQ0FpdGpBZm5EMUFxdCtrZXJYendV?=
 =?utf-8?B?eXJvU25qSG01MDhpTWRrdDhBYU5mUmxDOEpSZ3JaS3IvNFUvTTRkQlVHMTUr?=
 =?utf-8?B?WitRRTh2UERIdXpJVjV0SnVmS1l5ZlNmT2hxUHlmcUxoU1pkb2xBZVBOOWoy?=
 =?utf-8?B?VXFnTFBQY1BYbHpXWlhvb3BjcVByMHVZMmk1VGc0akpXTXo5NWpYd3dTS3Yz?=
 =?utf-8?B?VmVONGlWRWhQSmY5K1liS0pRNlZCR2l6MlBuTXY3d0ExSzNhL1JUdDFsanZR?=
 =?utf-8?B?QVhPUkRiMUFFVHV6N0o1OTUrTkM1R0EwQ3RNN05qOVlMbTFPNGhFU2NCdEIr?=
 =?utf-8?B?ZEFtbmFmV0x2QnR6STlxT2RtYVV6aDJzcVZFZ0JwUWU2RUppQ1l0U3hzdTF2?=
 =?utf-8?B?amMwRUUyZ3JjM3g3ZCs2ZjFQM3ZEVklZNXlrWTArcHJrdlZEQjZNcDNjeWls?=
 =?utf-8?B?SnRqYmZsQkRoc2xLaVFkVEx1RVorZUVJRi9qNXVnaVhZRHNwVU4vWDVLbzcy?=
 =?utf-8?B?VWlpYTVkWk05M0xoWkJ1QWdnbTk1MEZIYnBXVDJKV1VRRVZWdHUyZ2pxL1h4?=
 =?utf-8?B?bTJkVUxqRFYvN2I3NkphVEczV3R0QitxdWZSMndpbGdWUlp6OFFNaWNRSGx6?=
 =?utf-8?B?cFJ0ZlNvaHNBbDRKa3Z3eWcyYXZJVzB6K3REUW1OUlJucDN1N0RJMFRGUU0w?=
 =?utf-8?B?SHc3dklZT3dhSEhqOEovbHJtQUVjTlY2Vlc1SHpnMThTelpiVC9pSUlwYkw0?=
 =?utf-8?B?YmliVEJCRmVVak1jeUxKRVVIUWNZdE1odU5ady9Bc0p5TEpvSGc1b1hma1dW?=
 =?utf-8?B?V2xnRitZYmdRM2hIb0pZek8vMDVqekF4U2dQTWd1aVJxU0tUVVMza0ZoUTdH?=
 =?utf-8?B?V0ZxcmRRS29PR1YxZmVyRy9ER2ZHOC80dG5nK0ZyVkFKZmZ2dXNPL1hyaXlO?=
 =?utf-8?B?U1RtZDRJRi9DK2xyN1ZFelJNdXJtQXJYYzN4SUdBc29OMHVqZ1VZVHlNVzkw?=
 =?utf-8?Q?gyMor8rXMQCVW?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17a8d7e6-adc8-4d45-a99b-08d8cd97e9bd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2021 07:46:02.3389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 73B9eRCZpRHXzrttox+NVxppupapTyfpvm+B6DExwz9H2/xJpz82NssTSvCbJLBj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4335
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

Am 10.02.21 um 00:48 schrieb Rikard Falkeborn:
> Constify a few static vm_operations_struct that are never modified. Their
> only usage is to assign their address to the vm_ops field in the
> vm_area_struct, which is a pointer to const vm_operations_struct. Make them
> const to allow the compiler to put them in read-only memory.
>
> With this series applied, all static struct vm_operations_struct in the
> kernel tree are const.
>
> Rikard Falkeborn (3):
>    drm/amdgpu/ttm: constify static vm_operations_struct
>    drm/radeon/ttm: constify static vm_operations_struct
>    drm/nouveau/ttm: constify static vm_operations_struct
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
>   drivers/gpu/drm/nouveau/nouveau_ttm.c   | 2 +-
>   drivers/gpu/drm/radeon/radeon_ttm.c     | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>

