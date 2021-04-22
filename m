Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5F53677E5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbhDVD1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:27:46 -0400
Received: from mail-eopbgr130048.outbound.protection.outlook.com ([40.107.13.48]:3715
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230319AbhDVD1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:27:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccxhXRwamDxFAK2QR7B7UjjtqmHMmsJ+wSiYOgFSkP67/uI9gxa4cKnszwEQgkVpK/XmqpNeIOLX5yJDGqI4ke0pXx1yIsSGVQkIo/rYXJfGOWqio3DFhyQYYmOT4/GL+leEnbMEche8dbPrtc4ZXyJXYCmjNC1jBfO98rSfTUqHcaCOtAj/6CTcGGUwMMYageIBRDMvqTppjWDvw3GEg3QBHpt2Eo91OpECMGQoscL1eFM7IzL1+uJ6sepadz4SsrZjfUi63AKgacOGIIINmnFhGLGiHS5vmcrf+qaVStjj40lLs/O3SpVEBRjAtyehS0jKQEn5jKJ1oGtCeHqH3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BliNk5bYnc8UqUl8VbXRrqRHWk67sabAC64tE3A8HM=;
 b=iP2vgSgoaNYvs9MEzG3vsMrEvSvEJWqrqfxVm6ahsZl/2Xv82uuLrP7ELZ3e/z5NNfR/uGAOGR0ukKXWKXz7ftAeXJWbldMcxalpLSl/6pSfFxsVhA+iTJozo+Y9aeQLlphjv1ui3qZ71nEPH2lOK98G8CkiOqH50KUURoAEaA+FFQUSCVU9IljlGFRBbXhispircV4qjdxDEGHb3ljZu8EvKOsO9RqrPm9tww1utsQYIyqASwnYYWb7sfhVDX70CJHqSJwYnPsx7qLkQKhWKeMYRNSoD+ESZYp2H4AuVedRq5h7Cc/u8OVmxJqtn1hjAZyG/9/6lolUOGmaNAgJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nextfour.com; dmarc=pass action=none header.from=nextfour.com;
 dkim=pass header.d=nextfour.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=NextfourGroupOy.onmicrosoft.com;
 s=selector2-NextfourGroupOy-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4BliNk5bYnc8UqUl8VbXRrqRHWk67sabAC64tE3A8HM=;
 b=RG6jq6zUltwNf5/pW1zT5vm+WBlgaRsYh4C88qveO+oD27pYsB1HIYT1FWUw+QLL2Mw4ugtNbJzJNMEiirWDvM2i5r7s5LoI38EozUozchTrEO6BEaU5OuZqb6Cf1jgbtpzwq1nYXwjZrbwtLtvu/4/NPkecxvoru8QRZKgZrUE=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=nextfour.com;
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com (2603:10a6:10:194::6)
 by DBAPR03MB6453.eurprd03.prod.outlook.com (2603:10a6:10:190::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 22 Apr
 2021 03:27:04 +0000
Received: from DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239]) by DBAPR03MB6630.eurprd03.prod.outlook.com
 ([fe80::593:3329:e104:239%5]) with mapi id 15.20.4065.022; Thu, 22 Apr 2021
 03:27:04 +0000
Subject: Re: [PATCH] vdpa/mlx5: Add support for doorbell bypassing
To:     Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>,
        mst@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
References: <20210421104145.115907-1-elic@nvidia.com>
 <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
From:   =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
Message-ID: <a77efb06-b2ae-c94a-96bc-290b8b7332ba@nextfour.com>
Date:   Thu, 22 Apr 2021 06:27:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <e1885255-34f2-9e90-6478-ff0850a5a3d4@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [91.145.109.188]
X-ClientProxiedBy: HE1PR05CA0136.eurprd05.prod.outlook.com
 (2603:10a6:7:28::23) To DBAPR03MB6630.eurprd03.prod.outlook.com
 (2603:10a6:10:194::6)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.121] (91.145.109.188) by HE1PR05CA0136.eurprd05.prod.outlook.com (2603:10a6:7:28::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19 via Frontend Transport; Thu, 22 Apr 2021 03:27:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9567b30e-e91f-48fe-2fba-08d9053e8001
X-MS-TrafficTypeDiagnostic: DBAPR03MB6453:
X-Microsoft-Antispam-PRVS: <DBAPR03MB6453C2D2FF00DFF2F80B7D7E83469@DBAPR03MB6453.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +yEczXmRVrt6k9qwG4gCMftrEX0C96EWIqPSP7Ts05Q+fDu9oRaRZQg/dz7WKVAf1aMfk/LS4QLliPaRZGMoxDLA560sP0b0EQcjjF0v1vUp4ctLuOvREMuDkoe9WO93comb7PNnhrKR1oWhkLSbMJH8pVCJpyAI0pP1wfVRxAuZxjcrly4fLYTfIA02ABXsyw1RplEL23B69XhkGE/5n798L52P2skyRISI5F7qhusTCy18PwC5KnoQ+bCHG5d+vquZiL/0lq/gcUS4a82UxsmoUUbs5K5wpo1w0FXbWsfthp33FoiMjyJgBvFROv6cJzJ9OIa7Se6A0rSTKl5rgY1A7b62Q6lHjNv2p7vvXjMKcEfEjlxXT7bqUmJ3GNA57WHuxlHOnKapSl1PE3bIggXgMpQE103C5YkVSKaMWO9htDwRgdNcBCUm68xkY5FSv97H9w5jcpXMzQH7Oob9qnU2xbm7Mqrsm45yhtVJHTIzEhDYmbr9ufXGI/JKSrinX1VQjvqBaTW8FgPb2zp4++NhhXT0fJrgYazzG30/t1X4fVsui0fMObYrZ9Tox/RCMBzebEO6OYbZ2B7gzPP0mnZ05NviqM/7IQrIRsRxSvF6Tl5n0KTT4SE4ctuoJeYsN19ncDRw2SUXtcviAn3Wb6wM7/leX4ElatKFC6+69DZQgkhe6vo2/YXH8oWeqrDFBCmuZQ7ZpK73YIdgaqo4vqeziXt3+GecOetsPHtB6wI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBAPR03MB6630.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(136003)(366004)(39830400003)(346002)(38100700002)(38350700002)(31686004)(83380400001)(4326008)(16526019)(36756003)(52116002)(186003)(8936002)(66946007)(8676002)(6486002)(26005)(66556008)(66476007)(5660300002)(956004)(2616005)(316002)(86362001)(478600001)(16576012)(2906002)(110136005)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cStQandlYS80VWd6a2IyQ2xQMzdxSUF5TTB3K2xlWkRKWEtpdFY3UlhBNlZh?=
 =?utf-8?B?ZHNtSUk4Z0VvVDN3NWgvUkx0Ky91dSt6dXFsS2t6ZFJ3Nk1LR2JFUjYwNzBD?=
 =?utf-8?B?WnVQU3cvbHhZNVVUTlBOTlRvY25RdHhtU0xyUzBDTlZQanR1K1VHRG0zM1pU?=
 =?utf-8?B?TDZEZUhzWlZnNW9hUFJZaWlVazZPdFRBdzZZOFpyZnV5T2FESkR2azJ1TFZv?=
 =?utf-8?B?ZE9Wa2owVWdZSkxKRXpnV0lUME1SVE9ka0tJVkp2Rll2a2NkbVhxTjhHSlFW?=
 =?utf-8?B?T1ErTm9YTWhOaHljRCtDTVlPamFsY081eE1QRjhXeWFDOUdtWVZmNUZDVmdC?=
 =?utf-8?B?TnJpbHFLR3VuTFNoQWpxZjVNOXhlMXdrZVN0clo2Nmtxci83ZHFBeGpGbEo0?=
 =?utf-8?B?d042ZnhBMlV3WmVEU1dHY3F4cXpCWC9KaWMrbmUvZnBEcVRoLzlyclFZbFM1?=
 =?utf-8?B?N1BCeERVUGJhWjVTZjhFUjNaQ08waGJHOEE5a2pWT3JoTk83QzdzdEUvRDZP?=
 =?utf-8?B?WGtxbmpXOWRKT2hRYS9hSmZpUUlqRk9iVWxMS05ZNlJhYU5WclhxYjI2TTlq?=
 =?utf-8?B?OFJ0dmZPZG9meGtPUm9senBMYUVITUZZVFhhR0VLS2s5N3J2eTJ2T2FEQWI3?=
 =?utf-8?B?NEc0YjR4UE9wb255V1NDWjVEUjZGWGo2aUNLSC92QVRYZS9ESy9zcC9GZmtZ?=
 =?utf-8?B?QlJPQXM4eTE1L1JYK2ZjRXREZTJ3c0VQTk1TU1U0cDdhTHltUXRBR2w2d2dU?=
 =?utf-8?B?NW5Rc0lEUTBKU21WWFMwU0wzLysxMVZCUHE3VkZHUmwyK1lQTlFwUjg0S0g5?=
 =?utf-8?B?cWNhS0hYcTZadzdCbytRaU5nZUZIS2VGRGFnMFFkSEEzQ1BZQldFS2U1NnVE?=
 =?utf-8?B?ZkVpbjJjSms1UCt6NnVnOEdiMUdYOUxPSUdVWkJ3UnFSbDVLR0hHZjlacmZv?=
 =?utf-8?B?MlVzWS80OVhSY2dsWHlMNlhSYy9HYWxJUyt3L2N4ZVkwWmRzaUZpYWxSQXpZ?=
 =?utf-8?B?RDZjdHlhTGxNa2tZbjJTQ0NDVTdEbnlrVitmV1JJTjMyajZGNjhMd2JzYkdK?=
 =?utf-8?B?NTZad2EwVUNDV1BacmdtZWVpV3NaYjd1djRaMDQwR0VjTTVTZHpxZ0lMZEV0?=
 =?utf-8?B?Uno0OUd5V3I2ZDdoLzBEVTdZVFFydDBSdWNlL3pQNzlXdWdRKzdUYWlWMEkw?=
 =?utf-8?B?R3p4WTlGK2hJM2M1T3hnWU5ja0VZc204MGJBMDBLTG1CcTUwa09wazVMZTRB?=
 =?utf-8?B?K0EwcEJqWFZmejkyQkUxd3BHRlBCelhBYzRSRHo3SW5qdE40aC9VUTcvVmNx?=
 =?utf-8?B?dGlOb056VHRZL0loOFRvS0t3bEpRcjlxTXpRTGQ0Q0UrTFRhbnMxTk02bjE4?=
 =?utf-8?B?U09yUU9uaGRQT21hUXZMZjMrdVA3ZW5ZUEZvUUhYemQ3VFVWbS9Cc0lXdDM1?=
 =?utf-8?B?T0sxdHVrS0VzKzI0S2p1aTV0eHNqT1p4T2RteXBoRmI2SzhYdVJmcWlTelp6?=
 =?utf-8?B?cE5CMGpNNjcvRDY1SlN6TlJMT0JiTG8zVFJ1Qmlma0laUm13cGhheVZnVTUy?=
 =?utf-8?B?NTJFN0lPT0xBcnJqd3puSG1teXVzSC9NVUdZaGFkQTl1WDFoeTg0UjRZbHNv?=
 =?utf-8?B?NTB5a2VpUW1ZbHArUWtzYUQvbTlQaWswMnNJMnJJUW14Zkx6K29IbmNpS1Vj?=
 =?utf-8?B?WGdRd2lHWDZnaUx6Mno4YWVrMkFZV3JqNUlXNUM0U1ZRcy96YUdSR202emti?=
 =?utf-8?Q?Tp7Tdiqx5Qj6MCMdr288ZizJ4ERbb9XP9WNirxe?=
X-OriginatorOrg: nextfour.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9567b30e-e91f-48fe-2fba-08d9053e8001
X-MS-Exchange-CrossTenant-AuthSource: DBAPR03MB6630.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2021 03:27:04.5170
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 972e95c2-9290-4a02-8705-4014700ea294
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eCFX11WAB4MDuR6qV4ik59Jwvq2m/xqIn0KIwMplcC8ZvOHNJdEBZmz7aIrJEyueSitenFxclyKRUbxmV/1cFEBB5FOYdh2R5QDgNaK6m84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR03MB6453
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.4.2021 5.37, Jason Wang wrote:
>
> 在 2021/4/21 下午6:41, Eli Cohen 写道:
>> Implement mlx5_get_vq_notification() to return the doorbell address.
>> Size is set to one system page as required.
>>
>> Signed-off-by: Eli Cohen <elic@nvidia.com>
>> ---
>>   drivers/vdpa/mlx5/core/mlx5_vdpa.h | 1 +
>>   drivers/vdpa/mlx5/core/resources.c | 1 +
>>   drivers/vdpa/mlx5/net/mlx5_vnet.c  | 6 ++++++
>>   3 files changed, 8 insertions(+)
>>
>> diff --git a/drivers/vdpa/mlx5/core/mlx5_vdpa.h 
>> b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> index b6cc53ba980c..49de62cda598 100644
>> --- a/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> +++ b/drivers/vdpa/mlx5/core/mlx5_vdpa.h
>> @@ -41,6 +41,7 @@ struct mlx5_vdpa_resources {
>>       u32 pdn;
>>       struct mlx5_uars_page *uar;
>>       void __iomem *kick_addr;
>> +    u64 phys_kick_addr;
>>       u16 uid;
>>       u32 null_mkey;
>>       bool valid;
>> diff --git a/drivers/vdpa/mlx5/core/resources.c 
>> b/drivers/vdpa/mlx5/core/resources.c
>> index 6521cbd0f5c2..665f8fc1710f 100644
>> --- a/drivers/vdpa/mlx5/core/resources.c
>> +++ b/drivers/vdpa/mlx5/core/resources.c
>> @@ -247,6 +247,7 @@ int mlx5_vdpa_alloc_resources(struct 
>> mlx5_vdpa_dev *mvdev)
>>           goto err_key;
>>         kick_addr = mdev->bar_addr + offset;
>> +    res->phys_kick_addr = kick_addr;
>>         res->kick_addr = ioremap(kick_addr, PAGE_SIZE);
>>       if (!res->kick_addr) {
>> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c 
>> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> index 10c5fef3c020..680751074d2a 100644
>> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
>> @@ -1865,8 +1865,14 @@ static void mlx5_vdpa_free(struct vdpa_device 
>> *vdev)
>>     static struct vdpa_notification_area 
>> mlx5_get_vq_notification(struct vdpa_device *vdev, u16 idx)
>>   {
>> +    struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
>>       struct vdpa_notification_area ret = {};
>> +    struct mlx5_vdpa_net *ndev;
>> +
>> +    ndev = to_mlx5_vdpa_ndev(mvdev);
>>   +    ret.addr = (phys_addr_t)ndev->mvdev.res.phys_kick_addr;
>> +    ret.size = PAGE_SIZE;
>
>
> Note that the page will be mapped in to guest, so it's only safe if 
> the doorbeel exclusively own the page. This means if there're other 
> registers in the page, we can not let the doorbell bypass to work.
>
> So this is suspicious at least in the case of subfunction where we 
> calculate the bar length in mlx5_sf_dev_table_create() as:
>
> table->sf_bar_length = 1 << (MLX5_CAP_GEN(dev, log_min_sf_size) + 12);
>
> It looks to me this can only work for the arch with PAGE_SIZE = 4096, 
> otherwise we can map more into the userspace(guest).
>
> Thanks
>
>
Is there support as of today (in qemu  or elsewhere) to use this mmap 
doorbell instead of the traditional kick.

--Mika



>
>>       return ret;
>>   }
>

