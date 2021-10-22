Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A678437558
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 12:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhJVKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 06:19:19 -0400
Received: from mail-bn1nam07on2077.outbound.protection.outlook.com ([40.107.212.77]:4045
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232521AbhJVKTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 06:19:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpIiW+XtOOxlr6MlQ9USiZYq7USWaf4gJHaJBQDEhpVAoQzu6JztOawE7DPrxywg3hPEyxqq4Y9Yi9WYRWNCMJuI3sBaNF9AAN1cZZEWm40bbgogGCziE8l/rOn1Gh3q/eKkmjs0nDEpyhAi8r0bHupwGgMkYoky89/6QUXvD1m1auYAkAsnEIqKA9e2wgGVJTVuzuP78wSc6lJL5bw5DcM2RYeRRWfiAAWm4eG7N1APVnf8t/3AQlp/rux+6Qne/tWLBcWonJ31kvIfkEDtCSk2glpK821UUMYwKKOfbgCkjOgg+gDWC/tmLCPF2gZYtlTL3AyqtS4q+c3D/2aXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2io7CsFEBBVz7gjqqJebQqVJaMIylFKxkATz6EOeAE=;
 b=SkfZATg6VBeRiO9vxv2BwHxg7PjVVz+E/wDX0NRlfMIIcpePf/BcpxzWsAun3w5QgRS/KN66ZFNdbDo81wjKtawpXOeFV47AvuZ1QEq5+9pFJnMuMmUHN9flsqnQlNUzMCa6oDaRkeqYzZQjNhPvQfgTZKQgDzK7l6vkUdXcFOhbMj1Z+5jO0eepf3pklnSIKydJg2vSYw7KhG2euw4Vtl72BBZpA7BxsSoA0vydHujXbX7VPlbCApMpfRHJ8xf08sraWxiOF2Id64hrJO6IYI6/+yMyHjbA/gRPKJP/UUV2vfG4It5o655oLSCj9tjCd8+4NVOQLwFhyrwmD4OLcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2io7CsFEBBVz7gjqqJebQqVJaMIylFKxkATz6EOeAE=;
 b=Tr88AMpOmHYGxzISTYB+3jYXEXIDBmEjoYYMz05xz+2rrBeqOXuIRVbyB0Jjb4N5fX7QSLmE8Zf+ascwZ4A4FHrAoYfonTwJ88HSL46AVL3JRo/4I3LJUK2l59AZnykOezxLa+ENO7wZUheC1esG6nK4lPtYOdz2uvrMx/nIyc0=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3508.namprd12.prod.outlook.com (2603:10b6:408:6b::19)
 by BN6PR12MB1682.namprd12.prod.outlook.com (2603:10b6:405:4::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Fri, 22 Oct
 2021 10:16:58 +0000
Received: from BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::1d74:c55a:fe83:bd18]) by BN8PR12MB3508.namprd12.prod.outlook.com
 ([fe80::1d74:c55a:fe83:bd18%6]) with mapi id 15.20.4628.018; Fri, 22 Oct 2021
 10:16:57 +0000
Message-ID: <b3c0b917-0dc7-d3aa-fee0-b8181f0fcef3@amd.com>
Date:   Fri, 22 Oct 2021 15:46:43 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/2] platform/x86: amd-pmc: Store the pci_dev instance
 inside struct amd_pmc_dev
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, Shyam-sundar.S-k@amd.com,
        mgross@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20211021092938.196933-1-Sanket.Goswami@amd.com>
 <f903b9d5-0477-1618-6596-b6039b56a5af@redhat.com>
 <7714d522-36b4-47bd-332c-c4ff5eeb1237@amd.com>
 <ff8b1f12-5123-324d-a8dd-2161c04cafad@redhat.com>
From:   "Goswami, Sanket" <Sanket.Goswami@amd.com>
In-Reply-To: <ff8b1f12-5123-324d-a8dd-2161c04cafad@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::14) To BN8PR12MB3508.namprd12.prod.outlook.com
 (2603:10b6:408:6b::19)
MIME-Version: 1.0
Received: from [10.252.90.71] (165.204.159.242) by BM1PR0101CA0028.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:1a::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4628.18 via Frontend Transport; Fri, 22 Oct 2021 10:16:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ca0f636d-4fab-47da-b646-08d9954513fa
X-MS-TrafficTypeDiagnostic: BN6PR12MB1682:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1682255D59586CD019D501449C809@BN6PR12MB1682.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OviiE/nv4wvd+dqE7mxs7BFJrStUX4so/r9swzPWTvBSxPE7MNO2kUpHWqsfiUYlxE/iLq5GvthG3kaq3tQLidEYj2riBjSvKymgbr4bNxrR0/Lo1tqSwX9hxU7237wJrNsL+G/0oyQYAwCTtTasojzwUTt4ju7HTGXDk8IDti4dCno1PoT0R+oG7L4wazrli14C+7OYWMsXyma7u+fubDl3tjQKqKdTKAvdUwfDkDfC2MtmPXD+RVfKRY3MZj75M6NycZUp8Fyj9cXS5ANaUiwB5KoB1AOge1hnmYcdriAD1AC0P1hGUJzNT3co2a4aBbjd1PGyWzJm8Gzn8SPI7iUKRWrX9OqsFWcd9zNJPAz31UVVvoU+s9r6Z4xxoYAPZDqmA7wvbsRynMVkoJDtHL+l2P4mt78qTDd/4Zdt3Pbnyo1byh5fp0Zu+GiPtL7rFg8B4S9L06VOIJtdCCG46ko0E6OKmpXWzWodURgdPd5psEpJTjHjaE60FAupPyO2HNPxXyqNJNHETe2LFSAe7az9wnb4L0wlBb5m0O0wxR/PVeSK8UUPqe7Xc+UK109k6XXQhP43KORFzBcHOcXY5i9QPNuWyz9t5LuE74X3Sa8frVNOh6FIAITTHzarSuqouxbVhZ45Q13liU+0D07xhQSS4MRkwmVNn+KQSxN7O4nqnINlpr9nlxXNsjowyDAroX7Q7B/YFI6WmUdbJzqzSOibVkylg3NOCxUiKXalJ30=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3508.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(83380400001)(4326008)(16576012)(66556008)(8936002)(508600001)(66476007)(6486002)(53546011)(8676002)(36756003)(31696002)(66946007)(186003)(31686004)(316002)(2616005)(38100700002)(86362001)(2906002)(26005)(956004)(6666004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dGNKeEliV2p6Y2Z6THd3UTBPYkRraHUrQWFqUHZZNUplSlhQRm9BMGRoaDlB?=
 =?utf-8?B?b2F4OGRuZ0RWVGluNFB2Zm1vVDZjMU9kbzhlYWNaZFBRWDNJWWRwVkJiWnpQ?=
 =?utf-8?B?emZvSWZBSGFzaWc0QzFQbkNKaWIyREQzTVdWLzF6UUVBK2RQL29HTDNHNjA4?=
 =?utf-8?B?SEtVekZ2WVJuWUk5aW4xN1VmU1Y4MzN0QWk4UFpKTjJ1YkhtcWpVVzlRckxw?=
 =?utf-8?B?NE5QQ0lnZ25BMTlMV3lXMW9icjREdFlPTjgyRGgzMExSN1QyZjg0bjFWQ295?=
 =?utf-8?B?aXhEaldmTmpLTE9GM2FzKzgwbXBvdzI1SHhaNXlXMXdrZTlBWTBGdHdJZ0ZZ?=
 =?utf-8?B?aFJ4amkwWnZkSGdIdkRNTXhjRFVaaXZROGpMOHVaZXFidk9UemxiV09tOUw2?=
 =?utf-8?B?SitRN2NzVXp4Ync4RnRneFk2dDBsUjFSUlk3Kzk1VWlqVjQ3TkgvakNyOEFY?=
 =?utf-8?B?MythVi9WNWlVYndienUyczNrajJFUDFlY1BadXBXRU9FNTR6OFNrQ2c3S0Y5?=
 =?utf-8?B?eTFrMVRWSE4yUnE3QlFrbGNVMXltQzYxZUExdUxtSDlGUEdpZk5SaC9iMlRE?=
 =?utf-8?B?U205TGRJT3lyckt3MTFKTjgybldEWU05YXMrOFoyV0xGblFLVnEwdk9FK2Zv?=
 =?utf-8?B?dlVtMlc0UTV2cnp5d0F0K0pLYktETWJrRzBsWUR4MEZZTnNCdGVDZWJ2NFRZ?=
 =?utf-8?B?YnhhRG1TSE5aR1ZKMmdENVZxRVl1K2g4TUloTmlCY3RFd3A0Yjgwa1F1b3lV?=
 =?utf-8?B?RDVJdkZST0dJdDNVS2JlcHZpMXoxcGRiUUxlMjd1ejZ6SG93ZlVld3hpL05w?=
 =?utf-8?B?Tzl6L0YwWnl6YjdkQXhhcUpIMTFsck9LUmhtcDNvTTBKUFlmbENyZmplK1hS?=
 =?utf-8?B?TDdvMlpvT3pjTWFSeGFScjJ5bkgxMnlIUHF5MmUzbEN0NTZ4S3gzYjNab2lh?=
 =?utf-8?B?TytNMG53Q28yZmNJUzRxNkxhOW5kWXFCZTV1TFBQbGdvWDJ2WWtsMktueFBO?=
 =?utf-8?B?bjJGR0ExVEpjMmJiZlpGYldMQXBwSjN4NmtFVGpjbUx6Wjl5a1dQU0xaSXMv?=
 =?utf-8?B?YlZ6eXBJTmNxTk0yRVRDUy8yU1JvaS83cGJ5eTVUMzdwVHo5WUV2bHFWRGor?=
 =?utf-8?B?ZHhzaGRHbmdmTVFYRFVhSXRkOGlvWktwczc2NExBOGhOeUd4TFRRTC9KUmdj?=
 =?utf-8?B?OVdWQ1VhTmxUdmRMNENXOTB0a2M0QXgrY1QwY092Z29nSnJ4YmpUUEVOSy8v?=
 =?utf-8?B?NVZEbFRPdWp2YW9HMEJROEdWaURNd0s0VzR4bUFGK3R5WmtvWlphVDdockNO?=
 =?utf-8?B?KzhJS05PVkVUWWpwNUVQM2d5bWs2ek5wZ0N3R2dNeFZ3QkNXMDlJb1Iza3RW?=
 =?utf-8?B?Y2JrVm9ld3RCbm1qVDVuM1A3SGZPcmpmRVBpM3ZtQmhOWHp2UE9oMVFmSS9q?=
 =?utf-8?B?MVFOTFdBaXp1TWN0WFg2QURxVkJlb2lXUlFhZEhMSW1jRVM3dk9JSE5NQXlw?=
 =?utf-8?B?Ri9mbHQxSHJPa2grUFRHS0hJdS94OXRFOWU2elBVVUhSVXYzTTA1dXpWTTBK?=
 =?utf-8?B?TVFJSmNUWXFRUWYvUjlVaFJhMXplM0pVUld5dUlVSm1MWFhSNWZuY1hCTXFB?=
 =?utf-8?B?TEVDZEtnektJQ3VPT0diMU9tSmF4SGJJM3NJTHdUL1pqVHJKWS9kNnhidnNV?=
 =?utf-8?B?Q1RRTmd5dEZma2xEMTZzay9OOWE4MkZTVFF6ZmtQQTQwR1piRGpDektHUHZH?=
 =?utf-8?Q?EhkOPNLFLo6Qh2hv84PMu2J5IeDp6kUaqj/B2Fk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca0f636d-4fab-47da-b646-08d9954513fa
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3508.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2021 10:16:57.4713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgoswami@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1682
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

On 22-Oct-21 14:21, Hans de Goede wrote:
> [CAUTION: External Email]
> 
> Hi Sanket,
> 
> On 10/22/21 08:55, Goswami, Sanket wrote:
>> Hi Hans,
>>
>> On 21-Oct-21 23:48, Hans de Goede wrote:
>>> [CAUTION: External Email]
>>>
>>> Hi,
>>>
>>> On 10/21/21 11:29, Sanket Goswami wrote:
>>>> Store the root port information in amd_pmc_probe() so that the
>>>> information can be used across multiple routines.
>>>>
>>>> Signed-off-by: Sanket Goswami <Sanket.Goswami@amd.com>
>>>> ---
>>>> Changes in v2:
>>>> - Store the rdev info in amd_pmc_probe() as suggested by Hans.
>>>
>>> Thank you, but there are still some issues, see below.
>>>
>>>
>>>>  drivers/platform/x86/amd-pmc.c | 4 +++-
>>>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/platform/x86/amd-pmc.c b/drivers/platform/x86/amd-pmc.c
>>>> index 55f14bdfdbfd..502f37eaba1f 100644
>>>> --- a/drivers/platform/x86/amd-pmc.c
>>>> +++ b/drivers/platform/x86/amd-pmc.c
>>>> @@ -119,6 +119,7 @@ struct amd_pmc_dev {
>>>>       u16 minor;
>>>>       u16 rev;
>>>>       struct device *dev;
>>>> +     struct pci_dev *rdev;
>>>>       struct mutex lock; /* generic mutex lock */
>>>>  #if IS_ENABLED(CONFIG_DEBUG_FS)
>>>>       struct dentry *dbgfs_dir;
>>>> @@ -482,6 +483,7 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>>>               return -ENODEV;
>>>>       }
>>>>
>>>> +     dev->rdev = rdev;
>>>>       dev->cpu_id = rdev->device;
>>>>       err = pci_write_config_dword(rdev, AMD_PMC_SMU_INDEX_ADDRESS, AMD_PMC_BASE_ADDR_LO);
>>>>       if (err) {
>>>> @@ -512,7 +514,6 @@ static int amd_pmc_probe(struct platform_device *pdev)
>>>>       }
>>>>
>>>>       base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
>>>> -     pci_dev_put(dev->rdev);
>>>
>>> The current code here actually reads:
>>>
>>>         pci_dev_put(rdev);
>>>
>>> Note (rdev) not (dev->rdev). I don't know what you based this on, this is weird.
>>
>> rdev is already retrieved before doing this:
>>            pci_dev_put(dev->rdev);
>>
>> i.e.
>> in amd_pmc_probe()
>>
>> rdev = pci_get_domain_bus_and_slot(0, 0, PCI_DEVFN(0, 0));
>>       if (!rdev || !pci_match_id(pmc_pci_ids, rdev)) {
>>               pci_dev_put(rdev);
>>               return -ENODEV;
>>       }
>>
>> after this I am storing rdev in "dev->rdev"
>> i.e.
>> dev->rdev = rdev;
>>
>> after this I am using "dev->rdev" at places where "rdev" was getting used earlier.
>> Do you see any problem?
> 
> What I was trying to say is that the patch does not apply, because it is
> trying to remove the pci_put_dev() line from a block of code like this:
> 
>         base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
>         pci_dev_put(dev->rdev);
>         base_addr = ((u64)base_addr_hi << 32 | base_addr_lo);
> 
> But the actual code in platform-drivers-x86/review-hans (and for-next too) has:
> 
>         base_addr_hi = val & AMD_PMC_BASE_ADDR_LO_MASK;
>         pci_dev_put(rdev);
>         base_addr = ((u64)base_addr_hi << 32 | base_addr_lo);
> 
> 
> 
> After your patch using dev->rdev instead of just rdev is fine
> (but please be consistent, which would mean use just rdev everywhere).
> 
> But your patch is removing a line which does not exist in that form,
> IOW it is based on some intermediate version of amd-pmc.c and not
> on the HEAD of platform-drivers-x86/review-hans.

I will rebase it to review-hans branch and will respin a new version.

Thanks,
Sanket
