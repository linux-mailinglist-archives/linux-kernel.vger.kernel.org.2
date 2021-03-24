Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4534719A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 07:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbhCXG0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 02:26:49 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:1249
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235530AbhCXG0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 02:26:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gPkJLhmdWbtvkEFAg8CJ7RLuMnjjrFJk90iWLuwl5WdNmWJFsut6xEADQ8lEVnSbV2pK5nknJbQiX2zxebrS51edDylC7uHjFGD/d6pFSj41syOC+6/1Xbkuc+++wwWFMpbYFDLPTAE6/fonMxBOma0vLG7pf29Mvq+FKC7TMOf+fUjmK5e4NDlJLwLrd/m2MVtjMt2uc+ZIoVdCORzl1+OrdBbpAXRWm1WELF8PKnRRTztovAo375usMlWp2R6/aEkUuJO0aDV/ByNQ/Q6JIPZbyISwqKXV5rVVXAX+TTh3aSvCcERvj6r+d0kdua2/6mVzBaLuMOlYXNVqJ/+3Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vAp+5V43xisT3yPn3JutiVPJ5HVCmbYfmD21lv/B48=;
 b=Tln/S84YI19O8/WZ1TMeHCncqkT1DSmNjVgXScXgaLNTxIOjRUstw4Kpit93De4PYHTpT8EcefTaZkKKZ7RrRW60yTYMumLd2HlSY/NAspLOQi9xSWR0KGzRs5i6PCC8Ubus2dEHpGUcXbBcWaPWVS1GtDbCOboIu15Cl4glnAkLeCJ8PBc9kOeRMd2xE/5Bzl58XlO87iAw0JG8APqMrxGteSAuZij9ntqosrycd1bQjVUYmyDiJSNvMCY/TMUw791lJZ1SgcYyFTk60t3LVddDRg0qbEJSKWsP2z5ABmMtj3SNy47PQUYSylNIiQBePrWnuxPF+p+8UTioixUy4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=kvack.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2vAp+5V43xisT3yPn3JutiVPJ5HVCmbYfmD21lv/B48=;
 b=s+kBUzuWzamcljBZEvb6zF2zljmOhPWG3ozWACx6HLKMvdJsDUsQIAib25J2sZ1ZXvAa1FvLx7BQ5TPUMfeKWI612bOnRcoLGiBifDOTXCt9MulFXDcDtnIYTJmdkqV5wnJUWaqEJWGBpuHyM43I2Pvmi/Phj0u3fBdanGRWb3ghIo5vkTaX77wOCfMj/jjGeCGO/DKdmZu5Oqc4fMPSSngAOlqenfbXwhQSZX7mbu2wLpF3UG8Jw+hk/ST5qmrYJq3vwXd+74b+QtnhEK3Mlm7xJq7pFuql8mmkaCEAU6tacaBuBTYfefggg0pDDluPrHmWyM9UdbHrTosAriIkNw==
Received: from BN6PR22CA0067.namprd22.prod.outlook.com (2603:10b6:404:ca::29)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 06:26:10 +0000
Received: from BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:ca:cafe::e0) by BN6PR22CA0067.outlook.office365.com
 (2603:10b6:404:ca::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 06:26:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; kvack.org; dkim=none (message not signed)
 header.d=none;kvack.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 BN8NAM11FT064.mail.protection.outlook.com (10.13.176.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.3955.18 via Frontend Transport; Wed, 24 Mar 2021 06:26:10 +0000
Received: from [10.2.88.242] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Mar
 2021 06:26:08 +0000
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
 <d224c6bd-f5b1-74f6-2afc-c3d5b0519ba4@nvidia.com>
 <YFrRugjVLlazTNPy@google.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <71b7914d-d9ff-2200-d6c9-6eab28499887@nvidia.com>
Date:   Tue, 23 Mar 2021 23:26:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <YFrRugjVLlazTNPy@google.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01343cf7-75b8-4c68-68bd-08d8ee8db72e
X-MS-TrafficTypeDiagnostic: SA0PR12MB4478:
X-Microsoft-Antispam-PRVS: <SA0PR12MB4478D74BAAF06F077A6B5A02A8639@SA0PR12MB4478.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /pExVOmdFQKLN4PRkG/92a4+XZREQXUCPmdESWBFxPkultOVO/zy1B8ihCYBBgl/B5uaAUlWMOZiOq4WMgBuIZAdw60STIlricaohU8FmuGlaiE5yuiPxgbtxtDXe8i5fpduCyxySi1su0iz69b+fBZPCKHitFmlnWEPj0pgfgqITJSWUh/mONxVT3Cv/Rrs5YtKvCrfLtsRUkR7BLFSyd++0+plK+Y0+dBB5GrmJCKG3LN8Xlf4SUZOQP8rIbjKSPSix8OobhVSdZ+M/SuWUgMqotbyrsQ/7wbOSCD95lJXBtViNP+yOxb6IIOs2OpOpd0fX/kKQdgg7IPyKpgazcHoP0j1vqrxm6M0HHrRJPuENtpjoGS939ZpJj+D8z86Wmx5EGDPi+jSBlGb0iCbv2FkDPSBHFjo6ti1wicqCOb9L4RLqgLJL0/mzeFYNjI3vlKuw650OL3mMkIoM7/JMNBEDIa3eYT0cW5r9eTfx77IJ92VETrgdKYK8yE/nHIVzvYPmE84eLIqZBt5GsTGJ0TNmCQcPZ2vUR50JGtXFkMEME697koShn2VvemhD4IV89JoKJcuasJugVTP37J/zpts5KgRCdXpZllCAmx5IKOic+FJXNUzyeQZ1MLSIdlXXg3hpTYE3syoEqplnK6OytPSdcZTccXWuA0rLVXpeoKpBFWc9HCvDR6OanM53fqi
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(36840700001)(46966006)(16526019)(6916009)(31686004)(336012)(70206006)(186003)(54906003)(83380400001)(8936002)(26005)(53546011)(16576012)(70586007)(316002)(31696002)(5660300002)(36756003)(478600001)(426003)(47076005)(36906005)(82310400003)(7636003)(2616005)(356005)(82740400003)(36860700001)(86362001)(2906002)(4326008)(8676002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 06:26:10.2277
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01343cf7-75b8-4c68-68bd-08d8ee8db72e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT064.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/21 10:44 PM, Minchan Kim wrote:
> On Tue, Mar 23, 2021 at 09:47:27PM -0700, John Hubbard wrote:
>> On 3/23/21 8:27 PM, Minchan Kim wrote:
>> ...
>>>>> +static int __init cma_sysfs_init(void)
>>>>> +{
>>>>> +	unsigned int i;
>>>>> +
>>>>> +	cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
>>>>> +	if (!cma_kobj_root)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>> +	for (i = 0; i < cma_area_count; i++) {
>>>>> +		int err;
>>>>> +		struct cma *cma;
>>>>> +		struct cma_kobject *cma_kobj;
>>>>> +
>>>>> +		cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
>>>>> +		if (!cma_kobj) {
>>>>> +			kobject_put(cma_kobj_root);
>>>>> +			return -ENOMEM;
>>>>
>>>> This leaks little cma_kobj's all over the floor. :)
>>>
>>> I thought kobject_put(cma_kobj_root) should deal with it. No?
>>>
>> If this fails when i > 0, there will be cma_kobj instances that
>> were stashed in the cma_areas[] array. But this code only deletes
>> the most recently allocated cma_kobj, not anything allocated on
>> previous iterations of the loop.
> 
> Oh, I misunderstood that destroying of root kobject will release
> children recursively. Seems not true. Go back to old version.
> 
> 
> index 16c81c9cb9b7..418951a3f138 100644
> --- a/mm/cma_sysfs.c
> +++ b/mm/cma_sysfs.c
> @@ -80,20 +80,19 @@ static struct kobj_type cma_ktype = {
>   static int __init cma_sysfs_init(void)
>   {
>          unsigned int i;
> +       int err;
> +       struct cma *cma;
> +       struct cma_kobject *cma_kobj;
> 
>          cma_kobj_root = kobject_create_and_add("cma", mm_kobj);
>          if (!cma_kobj_root)
>                  return -ENOMEM;
> 
>          for (i = 0; i < cma_area_count; i++) {
> -               int err;
> -               struct cma *cma;
> -               struct cma_kobject *cma_kobj;
> -
>                  cma_kobj = kzalloc(sizeof(*cma_kobj), GFP_KERNEL);
>                  if (!cma_kobj) {
> -                       kobject_put(cma_kobj_root);
> -                       return -ENOMEM;
> +                       err = -ENOMEM;
> +                       goto out;
>                  }
> 
>                  cma = &cma_areas[i];
> @@ -103,11 +102,21 @@ static int __init cma_sysfs_init(void)
>                                             cma_kobj_root, "%s", cma->name);
>                  if (err) {
>                          kobject_put(&cma_kobj->kobj);
> -                       kobject_put(cma_kobj_root);
> -                       return err;
> +                       goto out;
>                  }
>          }
> 
>          return 0;
> +out:
> +       while (--i >= 0) {
> +               cma = &cma_areas[i];
> +
> +               kobject_put(&cma->kobj->kobj);


OK. As long as you are spinning a new version, let's fix up the naming to
be a little better, too. In this case, with a mildly dizzying mix of cma's
and kobjects, it actually makes a real difference. I wouldn't have asked,
but the above cma->kobj->kobj chain really made it obvious for me just now.

So instead of this (in cma.h):

struct cma_kobject {
	struct cma *cma;
	struct kobject kobj;
};

struct cma {
...
	struct cma_kobject *kobj;
};

, how about approximately this:

struct cma_kobject_wrapper {
	struct cma *parent;
	struct kobject kobj;
};

struct cma {
...
	struct cma_kobject_wrapper *cma_kobj_wrapper;
};


...thus allowing readers of cma_sysfs.c to read that file more easily.


> +               kfree(cma->kobj);
> +               cma->kobj = NULL;
> +       }
> +       kobject_put(cma_kobj_root);
> +
> +       return err;
>   }
>   subsys_initcall(cma_sysfs_init);
> 
> 
> 

thanks,
-- 
John Hubbard
NVIDIA
