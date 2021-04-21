Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E94366EE3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 17:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbhDUPOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 11:14:53 -0400
Received: from mail-mw2nam12on2068.outbound.protection.outlook.com ([40.107.244.68]:27264
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240523AbhDUPOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 11:14:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FqLq0wVsuBdWbZsntEQ3740tMjMIvRYdz9MJRKckAT+x8cGJb3MUYya1pUC5QGvkktl9+CxHxlbC8AlS+QMdK2U6Zx6sT3FdYAVewTwJkNHE5NVTopYM7jsCZJ01ENisLiJyahz/DQ5Jg86orxR/vVDsPdMTEdtpbAuUwQmuVczKf6v3ccurpmmD9WyZ/N1DR2G362QYv7z5yDjbQI0E0iGuPFLQKzv8MWyczYas1X2pLYCxOdpPrQHtfvbx95hy22PT3gsa2sGCCHBjD6ubs+Fd50a4v1DJ1zURD8umnrfVb0aPXd9ltCecn59I8bz3aYLgc+zEL7EOIwHidMSRmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNDe1xj12QvX2vKf4agyoeZ8V6hmh13qOv3iB1rehDE=;
 b=RpeHudUF8naeCH+ZyjWF45SNpVB47TNaJfnOD7YbjoXwsL6tM6CaR2FrV+JjBk8q2cLckV42b2rWyuw3tvmmChKRIug9+Uy1aKOaeGkjkkG+NhHJF1QgCssTIwZQ8O7OKsiUdPIY4qvKdyid002YE4zJH86d3dqnLVVNrrgSW5WRa7+d0ixaM6ZB50GJ+c6HHg13zgZr1wmMVgRTwRpxHGCE4HZCSfXbBBGPyky70jsg0VQCq96VkrKUsc2xOOMv1rNkvbHN9FHSSykw6eIycR3bhTz4GVqcTdn/oYpGHusc53CNpGUQQ21/f+q/bSOoKJ5Mw6GqEe0A0lc+hekssA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNDe1xj12QvX2vKf4agyoeZ8V6hmh13qOv3iB1rehDE=;
 b=kkb1zIo6btDxtFqqCvJA6j5odimeLPz+sxsu6ZkcsKY3WycjxMBDkDyl4bc5cNAqEk1YlSVRn7jWdnMRFuULaJ1AD6HKj5YXkqDRGISh+Q0Tr5l6J24dVoFGhMhoIqusS6qKvO7QL0kKM6T6W1we/06JD6Zrww/4Za3Ma/iX3G8=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BL0PR12MB4948.namprd12.prod.outlook.com (2603:10b6:208:1cc::20)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 21 Apr
 2021 15:14:13 +0000
Received: from BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033]) by BL0PR12MB4948.namprd12.prod.outlook.com
 ([fe80::70f5:99ed:65a1:c033%7]) with mapi id 15.20.3933.040; Wed, 21 Apr 2021
 15:14:13 +0000
Subject: Re: [PATCH 024/190] Revert "drm/amdkfd: Fix reference count leaks."
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Qiushi Wu <wu000273@umn.edu>,
        Alex Deucher <alexander.deucher@amd.com>
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-25-gregkh@linuxfoundation.org>
From:   Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <5c09de50-d013-e5a3-d638-f1ca222a6431@amd.com>
Date:   Wed, 21 Apr 2021 11:14:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210421130105.1226686-25-gregkh@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00::49) To BL0PR12MB4948.namprd12.prod.outlook.com
 (2603:10b6:208:1cc::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by YTXPR0101CA0036.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.21 via Frontend Transport; Wed, 21 Apr 2021 15:14:12 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 452dfcc4-2167-4211-3249-08d904d81eec
X-MS-TrafficTypeDiagnostic: MN2PR12MB3680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB36808297E1D3EDF2C21E36CC92479@MN2PR12MB3680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J0mUoi6M7edE3O1TsRoXG7k+x7M7F/6i0KE87gIW93ZDSMydKX1e+PuFSLW7Bc1tEcoSalxdAACKssvuJNp/XJa4DXtgD3gF827DIqJY9eiTMqj8YnMxSOyg9aJS9dCg9h/LsIaJ1uVSI60T8sb2bwg1UngvhzWxyoCQDtQXhQ8Vavphx60RUamTXSw+lAJS7uGHWMsF1dtQuvt/GI4Rist5y9k4GbVMAtapSUyaskdDYwIcapGtKbmJ6whzpL5JJKOdHYN0YZtLLXf4POlNToaraO/syaQs3B2VsDw1uXcEefOVnssM6eJb5kA8FehWUq6nKIXB9fRkLn0CLxuOpZVjf5R824Gu9f9hUxCkyKzV62oIiNtSiiX4x0aVwV3D4QLHvoBW/oPH9IhOD5I5Pq/xYGum+Ag9ng8738GNr8QhwnHSbKCFhHnan4bjOXOnupBnECf+kuIo7B2kdGiFY6ovDhrp9gwHlSaEKdWm927IHBtp1yeQXJis95kb9FYL6jBuM9/Syfd/+gM2Ufs4SYEFNVFKIyz4CrETJpSlpQ3vgWrL1QR76C2JCh1hTS1FN3iI9HDUKu/kJJYj1Iq2oDdV/5Ef2Gs80iz5HhprbOJqq3YQOJi4Zzt/F6ygQPhSke9E0Ne+XBZ1TeSbz7CCjxR3+q3yArXyBGISCjDsDkqD59c5PyaVF9Gf/5c6RVq8NQ+a1dJMCuvEUO1LPNMVVWsSEFbPOGGWSTif6QbkGb0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB4948.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(396003)(39850400004)(376002)(366004)(86362001)(38100700002)(31696002)(66556008)(44832011)(6486002)(8676002)(2906002)(31686004)(38350700002)(4326008)(478600001)(83380400001)(54906003)(66946007)(66476007)(53546011)(5660300002)(16526019)(186003)(8936002)(26005)(956004)(2616005)(36756003)(16576012)(316002)(36916002)(52116002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d3o3cDU1elU0MjZuOTVrRmFKaS9oVldrdEM4MWZZY2lNSjlUYk9UWTdjN0w2?=
 =?utf-8?B?L0ZNdUFCaGRDVklaNS9TYlNJU2hIWm5uRlRkL3Zqc3pFZ0RxMTRLY29Tb3FV?=
 =?utf-8?B?ZmFjc3ZHUkJZSEhqc3BNWWdKdTN3V0tZTFdBY3dXOTc5TkQ3Yms5blhCcmNK?=
 =?utf-8?B?WTVweGltNVlJMjRBWUo4QmtTc1VhR3JoSTVBV3JYbG9YY3hUVG5qVjk2Zmcw?=
 =?utf-8?B?QXFMdXAzWWs5WUl3TVA1N2o0N0s1Uk0ycmZMdHpIdU5QeitRdXgrWXVpcXY1?=
 =?utf-8?B?NGd4MGxDRkx0VnVrL1ByWUhRWkhZMFRydTBpOHlvMk1Nc1FPQWpuNjh6UmNz?=
 =?utf-8?B?RWpnbHYyZjJDZ1VUcE9mNExUMXdTdlhSeG0wbkZ4clVDZGEvL3NaUTdseTZ2?=
 =?utf-8?B?R2QvVzVkMm10ZXpuQmRzbDNpYjRqeVpGWi9WNDlPQnVzRXJlQ0VzRnVkRjgx?=
 =?utf-8?B?YUZyTUo3ajM1djV2aU54MVpIc05zQTRnWnJYcUZlNVN2Q0ZxQUFIOHIvdDhQ?=
 =?utf-8?B?U2g1d3B2a2N6MlJwRU9PWDZuLytSeGkyNEwrQ1B4SE8zOUxyTjBCQkZlNUo3?=
 =?utf-8?B?Mi9LVkRxSGlEY281a0NwckhORXNlUFhmRDBJZ1pSUVNxT1h0eEFJTm1oOHN4?=
 =?utf-8?B?UnhBNFNpVUpNaUNmYXNjWTdjdTdKRkpObjZCTDl5V2lQWXJSODRqYWE4aG9u?=
 =?utf-8?B?VmZiMjQ1N0g1a01XcjY1U2ErYUt2N09hb0x5bXZRK2RTREtxcDJCLzJ1L0xC?=
 =?utf-8?B?RURBYktVNVNySWJ0aFh6KzlzWUU0NDJoNHdmYTUyMG83LzVYTXNnN0dnbHpn?=
 =?utf-8?B?VllDUXYvdEpoYkJsVFdBcmYrUlNWQ0ZQN2pZNFlNRkhjWVpZdVh6VzB5MWJs?=
 =?utf-8?B?bjRuRGZYMTBISzJWTHlSUkNNNUZEODNBZVpWV1JHayt0bERFUnJXejZPQkN1?=
 =?utf-8?B?ZEdRTHJBZUdsOG8rQlRVcjk5aXp0dW9kM2RTMUsvVVJGWVFSUEhvVTV0T25x?=
 =?utf-8?B?ZlFCbVordlp3ODNQL1ptNFRpUDd1cUsvVldSazJxVmI4ZnlUZzlJdzRNaHAr?=
 =?utf-8?B?S2g2NExrY0Qva0VPNXloWXdHNXl6a0N1eHNUNVVZcTBoRERPVDBkVWhoMVoz?=
 =?utf-8?B?NnJ6bUR0Z05rUWlUU1I1Wk90QXRQUnZPckF3SFhmTVdHNGNPZFIwY1dCcWVX?=
 =?utf-8?B?MDk2QnNMN3NDc0JRa0V4aWF2cndTK1ZDNTFLVGRhbDJoRS9wMUZ2M0Y5NnYr?=
 =?utf-8?B?VTFLSjBSbUhBMWVMQ2o0VzcvMCtGT1RSbUFyRHhvUk9YMEpLK3BHKy9pV3lu?=
 =?utf-8?B?TWdXa0ZKMHBPVkNpdkdjT2hLcTc0TERhM0pIMVFkNndOMVM0V2FXOFNuYmxL?=
 =?utf-8?B?QW9NdERVemQzSXdxcTdzaHhFcHlWN3JmREUyTTBQRW5Lb1FqRUJXTXpnMmdR?=
 =?utf-8?B?SEpZNkJYL1pIWGZPK3BuM0Z3U1QzcEJPbjk5Mko1NnFwTTJoc0cwa29pWmZ0?=
 =?utf-8?B?SVI4SktOVlBWUXppWGRmWGF5OFpMNTNDZnBQL1hCbTZLdE0yUG9Jd1YvZmRl?=
 =?utf-8?B?VkU0em9CWVBsVC9ZYVdqSGJPbE8vbXNPb2lLWjRJM1dlYkJTdGZrbzUyQjkr?=
 =?utf-8?B?YitHVWM4cUZrRXpsNFV2Q0dkZDUwUk5CYkdWMnhta2gzOHdkbDBpZ21NRlFI?=
 =?utf-8?B?cHkwcXkxMTVtSGU1czExbGtTK2xSaHFWTWYzd3pCQmswY0pRY2J2M0hZMWl0?=
 =?utf-8?Q?XLhXzDPosqpCtk8NVawE0DA10HNIrlUOj5y8T0h?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 452dfcc4-2167-4211-3249-08d904d81eec
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4948.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 15:14:13.0487
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ab/C36qpytgyMFax961NvBUvvWgzNE/j6pP9dUt9pLjQJH2OY3PYa0vlya8RGVQS9LDOht0AEK7eXNu95v5gyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-04-21 8:58 a.m., Greg Kroah-Hartman wrote:
> This reverts commit 20eca0123a35305e38b344d571cf32768854168c.
>
> Commits from @umn.edu addresses have been found to be submitted in "bad
> faith" to try to test the kernel community's ability to review "known
> malicious" changes.  The result of these submissions can be found in a
> paper published at the 42nd IEEE Symposium on Security and Privacy
> entitled, "Open Source Insecurity: Stealthily Introducing
> Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> of Minnesota) and Kangjie Lu (University of Minnesota).
>
> Because of this, all submissions from this group must be reverted from
> the kernel tree and will need to be re-reviewed again to determine if
> they actually are a valid fix.  Until that work is complete, remove this
> change to ensure that no problems are being introduced into the
> codebase.
>
> Cc: Qiushi Wu <wu000273@umn.edu>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

As far as I can tell, this patch was correct and should not be reverted.

Thanks,
   Felix


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 20 +++++---------------
>   1 file changed, 5 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> index 0be72789ccbc..d3c3fa25c2cc 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
> @@ -637,10 +637,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   
>   	ret = kobject_init_and_add(dev->kobj_node, &node_type,
>   			sys_props.kobj_nodes, "%d", id);
> -	if (ret < 0) {
> -		kobject_put(dev->kobj_node);
> +	if (ret < 0)
>   		return ret;
> -	}
>   
>   	dev->kobj_mem = kobject_create_and_add("mem_banks", dev->kobj_node);
>   	if (!dev->kobj_mem)
> @@ -687,10 +685,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   			return -ENOMEM;
>   		ret = kobject_init_and_add(mem->kobj, &mem_type,
>   				dev->kobj_mem, "%d", i);
> -		if (ret < 0) {
> -			kobject_put(mem->kobj);
> +		if (ret < 0)
>   			return ret;
> -		}
>   
>   		mem->attr.name = "properties";
>   		mem->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -708,10 +704,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   			return -ENOMEM;
>   		ret = kobject_init_and_add(cache->kobj, &cache_type,
>   				dev->kobj_cache, "%d", i);
> -		if (ret < 0) {
> -			kobject_put(cache->kobj);
> +		if (ret < 0)
>   			return ret;
> -		}
>   
>   		cache->attr.name = "properties";
>   		cache->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -729,10 +723,8 @@ static int kfd_build_sysfs_node_entry(struct kfd_topology_device *dev,
>   			return -ENOMEM;
>   		ret = kobject_init_and_add(iolink->kobj, &iolink_type,
>   				dev->kobj_iolink, "%d", i);
> -		if (ret < 0) {
> -			kobject_put(iolink->kobj);
> +		if (ret < 0)
>   			return ret;
> -		}
>   
>   		iolink->attr.name = "properties";
>   		iolink->attr.mode = KFD_SYSFS_FILE_MODE;
> @@ -811,10 +803,8 @@ static int kfd_topology_update_sysfs(void)
>   		ret = kobject_init_and_add(sys_props.kobj_topology,
>   				&sysprops_type,  &kfd_device->kobj,
>   				"topology");
> -		if (ret < 0) {
> -			kobject_put(sys_props.kobj_topology);
> +		if (ret < 0)
>   			return ret;
> -		}
>   
>   		sys_props.kobj_nodes = kobject_create_and_add("nodes",
>   				sys_props.kobj_topology);
