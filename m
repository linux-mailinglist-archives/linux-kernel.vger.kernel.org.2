Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8089135C3A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238219AbhDLKU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 06:20:29 -0400
Received: from mail-bn8nam11on2040.outbound.protection.outlook.com ([40.107.236.40]:29408
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238193AbhDLKUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 06:20:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gy4iSR7QAeZhYcoJjQxdelhZZxZgS+Iq9LPosXJ9q51OkaePJHv9Mh7+dNP5q9fedNcr/SKcZnnKZXwD9Gyo0vz0iS+anLY9JQZaEeNBbANfBg90sVI7XydNISXtWVf3NuJVm6IprF41xf2iEM0ZgBRL20Hi0CGefdJ5r7O/N1PMnRp7U+mQGpsjTEgSihU6p8VgNgkdjvXTUsQo8TSILQ04N7Q2+vb1vk2j1xV9ZKMrVA7+vgUsACzmDCmwkzoUBn+nHcyiECw0X716N4FkvlcoUYbYAaa9NnknPH+yeeTn4io4iDPO0E5Q6ISlF810HBaYIVTmwZC2k3gVyx4vNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkK77QldDazoImzyI47GKQEyTWGee67sC2yiQfBMEQo=;
 b=H7ffF5rGQCbLA3Zu/AyTsb1WnxnVUHKloDdbmysIhboGtrIC2N/Ark2XOgIURpW1BPGXCj50t1p0eDmzVUUaJcLQu03a5Rl+7aGFNfCxG8ny/BwtuLqmmyX5HgNn6sOgALaZqI7UemmASaRzX7bhhg7OAE8Wl/sh+JRgUsLffnIOrAb4HtGISe/lnksD8fxYem7LR+AL+5EZg9t3MndjY5WeoraueJ/NsyVzJL8lwXzW4hutG7fuJ0VlLaHeHQDc8PrPpGH86GQ0lBFWL9IZkIaeQGOkuivdJdhH4LRLr5KadlQ6CKS352FTm6ZcCQgeHl75n3++F6FunyM/yS+77g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vkK77QldDazoImzyI47GKQEyTWGee67sC2yiQfBMEQo=;
 b=onghnM7wp3EkKtSplwa5pkT9EiZFTt+6skAO32AmF13LCFJjS8FktNF9HeDUmldX+Dg71nuK/zr3ZlAYPLWp13mUYEzamNorCvLjKN1EBUdSG0PwqRqMmD6aX4CgxfJCXz2ZDF82PnfEvI3dLbrpvwIwtbSNwZFfAgxAu4rwzv8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SA0PR12MB4398.namprd12.prod.outlook.com (2603:10b6:806:9f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Mon, 12 Apr
 2021 10:20:06 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 10:20:06 +0000
Subject: Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes
 0
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
 <CAHUa44Gga=k3indU8FC3X5xE=6RnKEDNeZBDWeJzm47-Spm0QA@mail.gmail.com>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <1318f015-40cb-2bdd-17fb-2a3843ed45bc@amd.com>
Date:   Mon, 12 Apr 2021 15:49:51 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAHUa44Gga=k3indU8FC3X5xE=6RnKEDNeZBDWeJzm47-Spm0QA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:1::11) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.146] (165.204.156.251) by MA1PR01CA0095.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:1::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.16 via Frontend Transport; Mon, 12 Apr 2021 10:20:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b43b837d-b2fd-4900-7cfa-08d8fd9c8b05
X-MS-TrafficTypeDiagnostic: SA0PR12MB4398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB43987FA0F67B3D40672038DFCF709@SA0PR12MB4398.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtPSuR686aiyMxEH41Oem9S95RoP+ZuWul2IahVhN7UbY/hsz5wBTbWJs9wbTacMe4mYgUcvGZhLwL5EOVIbLxqyiB0+3Ia33wwyBXdZWo0flLmY5RM7BQlTQxfLKzjOq+XMgJkeW7+m8fljBMz0D3pS+vX1sgSy9gaW8LNufL3OWhumBN5lRnikzvItCBKUd1EXHbgjS0yZQc5SK9M0dmxerakH5ispPsFn6bIEnRlX5AjPF127ci3VQUBaMt9Mm0OsukLnK1JGhesSe5UF4nJm5fdZJoJ8nsaA/j13QUeW/Qimplb1ppP32PWk93Yca7EYemFAahGYVFcg+0k+EEOuEuMAZkgBov2jpFg7Uf3qhTfUPR3I2wAQMnwkZldE1BpTxww5X9SFV9O1sCQyw03mMKJAcLLYIYPZkBVMDIXlBU0+UT2xQqcuvSjtzgiJ4fQBEkSusawZqTojU21xm+gAgRtbgYNmcFxKmiFU/3yozl1ln1y9ST7h40OcpzGBy2MxkIE6buCZJIk7XrCZVms1snDYVk/qiAOYZhQe/1ITBUOPvIU+UtUmOzubtL2IvI14OMgLFgCqHtnXDWX6JhhvUxIh9Xc9/H8SuWHHGyl0hvKKkmqHqIzFDbJ3RC4nQpWfpHvR5CmdM4eI/qDuJ+XYvlQ+JvrzmyFrJBYb6rzLmXG2m4Vy/xBDByxXYMbW/2iCi0vLoNzhQ4WNDB/ezw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(346002)(136003)(376002)(39860400002)(2616005)(86362001)(31696002)(956004)(16526019)(5660300002)(83380400001)(38100700002)(186003)(8676002)(36756003)(38350700002)(31686004)(66476007)(4326008)(6486002)(53546011)(478600001)(66946007)(26005)(6916009)(66556008)(52116002)(316002)(2906002)(8936002)(16576012)(54906003)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WEtxR0hGZFRkYk11V1FTRE05cXJWQmdiY0Irb0dweVQ5WE9HU09GR0xWeVVU?=
 =?utf-8?B?OGtHeTRtQTNobEVua0dSWjdlOWtTZXZHU0E5ZkZ5R1BFeFVDR2MvQTF2ZE1t?=
 =?utf-8?B?d2VSSkMrOXFRaHFVVTFJbGRUZHN5WDBUUUpFcFdCMEdiaGoyREpxdzlBeU01?=
 =?utf-8?B?V3VJdXdha1Bnd0FIaURXa0lPTVBFeVVNU004VXJmbjZ6THFKdnM3UHA1OWdI?=
 =?utf-8?B?bWFObDg3bklpV0RGSGpkNmQvcUVKNGxEcEx6eUo2WFNHbzUrOFhHSktrdEIr?=
 =?utf-8?B?MlpjZnhpMDVETC8zVEJwblZiTzF2d1hwY00xcDhCRHRldEdCa1cwcjJMYlpp?=
 =?utf-8?B?VFhGcTBjd3NQV21mU0M4emVHOHdTdXg4VnJ3S0d4bzNzcEtDYmJsSUh2Vnps?=
 =?utf-8?B?ZFhBR2FtTkFkUnB4cHhCWnArWVNmYnQyUysvdG5JUjEvSXV1MG5ob3F6SDdK?=
 =?utf-8?B?YkVJcFFVYVZucFhoSmJwOUluZlNjamNpWGxZZE5BRmxVOHRJK2x3L3JGSHl2?=
 =?utf-8?B?OTBEZTVsMy8reFR1bXpVdTFjSnkwOTJwN3ZQSnh4R3Yza0lGcE9XdUFORngv?=
 =?utf-8?B?aXJHS1h2ZmREVTRiVjhUbUNONFVsSkRyVjludVMvVzNaVnJiVS9qZFp1VEtF?=
 =?utf-8?B?WFlKaEwxSkZTd3VISE94ZEI1R2Ftc1FvRzJjR0ZrdmpNd0ZXZjZzQ2E0MkFM?=
 =?utf-8?B?RGI4YVg3ZEt2Tkg3K2hYMHdkTEFiaWl4bFNkM0tTdkdKVDhHSXcvdUdoT1Vu?=
 =?utf-8?B?QklGVVpQekUvc0dYWW1tR0Ixc3V3anFFTU1pcUN3OEptandycXhuY2NyaXgx?=
 =?utf-8?B?L0g1ZEpjWHNRc2VPRXRqTVNPcE9xZ3Q5bHp5VFpaQm5nSkpRNEI3bXZaNEdK?=
 =?utf-8?B?NklIR2ZRT1RBYUJoaGJsbnEvT0hvZ1YzMjBQZkVhMGh5TnF0UUthQzFUSDhE?=
 =?utf-8?B?VGVzU1BEN1g2Rm04UFJqN0E1cjNRcTZnZzNmTDE2M25hN1ZTa3d3dkloUVY2?=
 =?utf-8?B?SHVHdUp6TVVtbW0xTjFKaisrRmV2UGMyRi9ndzc0QkFYOXYveHpKajlsWnZi?=
 =?utf-8?B?QWFUWEI5ZUZiM2V4OEpUaDg5L3lBTHIzbUdFcUx5a0FFVU5kdGh3RGRmZy9V?=
 =?utf-8?B?UUkxSUVMVjVGNEtDWWpWbmExakNxR25BTjdCVGFBSW9maXhCNW5EZDN4Y2tS?=
 =?utf-8?B?RktsN0NNVTZ1eThiSTdnQld2cVVPbm5vZTdHWFgwRC9DQzhIYUhyUG8zT24v?=
 =?utf-8?B?dDRYYU5iZHdHb0V6bDBsK1FRS2RqRWZPb2hOQmE2d3FPMkdSTUJ0NTBhd1lm?=
 =?utf-8?B?dXVBRTRFQllQT2UwbUx2T3VxRWhSWVBlallRZXFqS3hIelpiZjJJeGVlTEMw?=
 =?utf-8?B?WGJiazdNVVY4Tkl0OTRJSk40VjdWbVkwYUQvRGJXN01QMHNCOERQSUxyNHh2?=
 =?utf-8?B?QzdOYXRvYmY0YWEzSDY5MkNITElpS1ZaMVlTQlo3ckZtSEhSZ000VDhDN01p?=
 =?utf-8?B?WEV3K3d1RUhqdFNQeHUwWDRNOUpYcTRZSzFaRFNlZE0zNDRWWmhrOEhsMis2?=
 =?utf-8?B?MnRjNXpOWldKMTFJazFPMWRSdTJTUm5PdnZRQVhPbHlyaEdGYjliczdxaG16?=
 =?utf-8?B?VWpwUXlwM1owb1krdVBDZXRmaGpvMzRmTkthUWZEV0JxQ3k2dXdlbkdxTXN5?=
 =?utf-8?B?VTEvRmI0Y2JyVG05dTFWVmhMR21aVXBvVm9MeFk3aTVYekwxbnVBckRJSkE2?=
 =?utf-8?Q?cXWaW5yFJzenmT7MQ9cV7d0now+RvpOyS6Ey7Yn?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b43b837d-b2fd-4900-7cfa-08d8fd9c8b05
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 10:20:06.3092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GPxcKofwow3eHvvvJbRIq2Q1vcL7tPHe2xY70tbUJbpj7KXHwtSOgdnnlc5JmZazXRupK1ROqyhZR06biC8mZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4398
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/04/21 1:06 pm, Jens Wiklander wrote:
> On Mon, Apr 5, 2021 at 11:43 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>
>> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>>
>> If it is a single instance TA, the TA should not get unloaded from AMD
>> Secure Processor, while it is still in use in another TEE context.
>>
>> Therefore reference count TA and unload it when the count becomes zero.
>>
>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>> ---
>> v2:
>>  * Unload TA if get_ta_refcount() fails
>>
>>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
>>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
>>  drivers/tee/amdtee/core.c           | 15 +++--
>>  3 files changed, 106 insertions(+), 16 deletions(-)
> 
> Looks good to me. Please address Dan's comment.
> 

Hi Jens,

I have replied to Dan's comment.

If you are okay with the current patch, request you to pull this.

Thanks,
Rijo

> Cheers,
> Jens
> 
