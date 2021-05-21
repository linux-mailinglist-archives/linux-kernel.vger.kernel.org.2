Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E4438CA96
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234416AbhEUQG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:06:58 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:62688
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229586AbhEUQG5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:06:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXtPlNUBqMpMe5NEKLUR54P8EcEBnUbhN1jdJYlhb+q0TKtl1akhr1Yj4IJc8ChN5wIO3aNNULcNhi+nLtB3mgazZ8LCtjvKN1/oewhCr/+JZ/rIks+o2qc5XwLkmxfc0nN9SH38CvAfjgXzO7hc3TXV+O4QlsIqzjtkxBGeTaU+bYh5U2NciMct7AnmaGfhAZHC6a354Kc/Vf8zyWQO786N5JNNallP7NcEgKrq8D91VKvSBalXEI7dnDGiQYxsJGsXgbFnuLFG/Y+qLtyeh6UxvDoJmQH4dHnt2h5PWdOrZpVa5sLJskk0/tT8uqb3REg+rosXGF8cbfYmxM+goQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B29+sS4RAbUIy/Jq9by0ZOc1dStTH5PWB6tZ9KiMHdE=;
 b=eRbcOFleS9hbtPVQ0PEFYG0xfNSI0KWGa+h55bgXL9hiZdbdmXy7zDXxHyZqtt3CAOThQqhQ3ZohNAP1WDxHq2DG1LQdoMpo6ygmhq/oNCDK3fzUJoihv9Gjv8HRv39pmndHjy+pJKzJgS1PccCBwj+whfZHZWGEoNMwc8A2f57j0zA3OMFLr1XcH7+57AWSqJPA7Bbv0CxIDBuhCHjRFFbWMIahEM0v3ZrfgJT3XkPJ0jU7gtSKHLa+P9YgA5vYXFV8FTMPMFtGJtAd+wgD9SgBMi/UwAsV/TQSva76m0MjeQaFfyzeXItr/5g8mVRod1Ql4M5O4mbxsQKA/3XjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B29+sS4RAbUIy/Jq9by0ZOc1dStTH5PWB6tZ9KiMHdE=;
 b=qrWemh0ofu89razkjIVZw//QgN08boivmP6U6xQYEGKk1kvDFrPVt4jaFxWk5bt1M0A2qy4rZdtwldNql7wq8J5SZjY5TKirNTnUZLzzoq5ySpdhJlZFkePd+m3QQEevbR9lH7vy9N95tzOS6RaQy2z4qUQymhFiQTA7zR2lfLw=
Authentication-Results: roeck-us.net; dkim=none (message not signed)
 header.d=none;roeck-us.net; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Fri, 21 May
 2021 16:05:32 +0000
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::2833:2120:ed9f:c3e4]) by DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::2833:2120:ed9f:c3e4%4]) with mapi id 15.20.4129.035; Fri, 21 May 2021
 16:05:32 +0000
Subject: Re: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
To:     Borislav Petkov <bp@alien8.de>, David Bartley <andareed@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-x86_64@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
References: <20210520174130.94954-1-andareed@gmail.com>
 <YKeHBI757jX65ULa@zn.tnic>
From:   Wei Huang <wei.huang2@amd.com>
Message-ID: <2ba654b5-1c08-85da-b932-9d5a92d5c930@amd.com>
Date:   Fri, 21 May 2021 11:05:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <YKeHBI757jX65ULa@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR11CA0122.namprd11.prod.outlook.com
 (2603:10b6:806:131::7) To DM5PR1201MB0201.namprd12.prod.outlook.com
 (2603:10b6:4:5b::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.87] (165.204.77.11) by SA0PR11CA0122.namprd11.prod.outlook.com (2603:10b6:806:131::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Fri, 21 May 2021 16:05:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 463fa79e-89ce-4423-37bf-08d91c7242b4
X-MS-TrafficTypeDiagnostic: DM6PR12MB4338:
X-Microsoft-Antispam-PRVS: <DM6PR12MB43384F95D365DF39CB471AA6CF299@DM6PR12MB4338.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /rXKPofD8MX0O/lFfN+bi09Nh6hQsiV8wCsZ59IoLUD8EznDUGYrWHz0xNf5sLOPWpyriGL/yhCImEj102Et+gjMTKWAZx6uDVmrRB4W1oDKtdknaHa7FPHYh1qr6G9uU5WA2rSHql/uX1X2Z1FkHVKuVLMY4UxY6DgFnuBA14edIA9TZ0Kz8ZajFCOZ2vJ2npnwKR8ibOKvx+f78ZJKRN5gQjzCqL894pbEnFLYDMNibLBqbSwMpYkV+FjMNoU+qRsW/fLnGxbT0JceS+9pt6LdRrrVVYsRzaZQABH7WvdHB/ODIcRkZf9Y6G125aNxD+sbmGFXeA/bKpaU7SmQjWjHlUtSC8BYO4qy4buLM7jTTIByxTa02HEti7XzgRfj6bQD1rZ3L5fwijbP/72AeeDL+XkCIltZZKIWBrS6TGYStxvACvcUCGk8HdCQym1i3FkIIH6Go3d7a5sunXtH0CnGupI9MZejTVAWPWIrFo5pcXEroQldu4QRxi+SOPzRg6OrER5QuQMdexNbOuWvkd4583uvpI0ntTtMuSU3k0VPLLlTXf2Hb5Hpr+kAwBnn+JZ3A2tvWYjgRn2Qr2Ybzadwm3IjuY1BNXR+hwSGOtM5jaFMyoNTTzGlxtM4U/DSLQyPMhSlY6l5tApZ0Wcx/FiTsOYdWj5sJPbAFoTV2AsZlKMeeLAnSdbza3hjUzrV6DrLF4hROLW7/qzT32sRCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(376002)(396003)(366004)(346002)(956004)(2616005)(316002)(86362001)(110136005)(52116002)(38100700002)(31686004)(16526019)(38350700002)(4326008)(5660300002)(36756003)(478600001)(8936002)(8676002)(2906002)(31696002)(53546011)(16576012)(186003)(66946007)(6486002)(66476007)(66556008)(26005)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?M3g0NVphQzRsdTlkYk9udERZWE9BQXVNNVR4R2h4SHEyeFRxZURmM2ZQM2xr?=
 =?utf-8?B?c1pnNUc0VGY4VWtPbk1GTU1ReW0ybGhlVGpsRm00OERMYjVmOW12RTB3NEJr?=
 =?utf-8?B?NmVIeVMrbGZmSEJ4NGt4YWRtM3RQYzVpbXpDb1BQd2UyMFpaZEx0NXNCUCtW?=
 =?utf-8?B?MGx6VkUxUEJoQVJQbzNLVjl4SkhnenNGMkN0bzRWc1NLU2JIRFlMSlEvcEpW?=
 =?utf-8?B?V2lOdEFFU3hGeXdsOHF3RHYxSVZkUmNPUXFKVlZCMUVjSU1JaDZGajk5SDEx?=
 =?utf-8?B?SDlhUnFGVVRyNjhCUVo5QlNkRXM2MDc2bHlQTW9BR0tFUmR2U1l5R2NFSG9K?=
 =?utf-8?B?bUVheUlzZnlxdFF5ZTdwTTVDTUtSdHRXSVlUZ2dCVy9xRjdlK1VFWEYxY0wx?=
 =?utf-8?B?OU90aWFQWTVtQUFCdisrYVhrYkEvckxmSm54TDU1ZGVEdjJxZU9NMUpjeXNs?=
 =?utf-8?B?ODlMbzhhT010aVM5czI4YzhDWUxkWm1aWlU1Njl2RTY5dlRvY0NDWW1IMEow?=
 =?utf-8?B?dlJ3ZFd2OUswRTNXYy9sWkhvMDZzd1duamo1R2RvRWd0R2FBY2VtZnhMZDRR?=
 =?utf-8?B?R0NnanpmVHpTQksrSFNnZEpTU0MwZlUyaWpWQkxoMjd4cGtNTTdDTmpoSEVW?=
 =?utf-8?B?NVJHeWthWlExNytaSlRtblMvbkU4ZExnd0ZqdHlYOHJpL2trRWFOa2dFZXRn?=
 =?utf-8?B?NWF3TlFtVkUwbkFQUk1UOUlVMnBZZG9sSUUwMnRQL0FPclloS1h4RTdrSWto?=
 =?utf-8?B?QmNPNE5kYlVxeVVzOU5XRDJ3dmo3K2EvNHQ2NUwzY2ZNZ3hRam5Dclo1N1Ay?=
 =?utf-8?B?RE4vVWNHUlpwSGdESCtsR05iYzAzMituZW5lZVZwemZoMWtnRDNYVStBQU5l?=
 =?utf-8?B?KzlWZG5xVlVPeHhkcW1kVkdaYm5ZeE9BUWR5Ly8rTFpGQUNpMkVaUmNNdEZj?=
 =?utf-8?B?SUF3MUhOTThmYkVENmFDV1BDVWhXb2F2cUthKytBNCt6K3BzcWxVSHFrM20z?=
 =?utf-8?B?VTJSN01kenFkNU12MjE1TEdaRTRiK2lLVkUvcGJKaWJQVFYrc1A1c2EvaCt4?=
 =?utf-8?B?c2g3dVRGeno0K1pVbzVCclNJb0NBN2IzRnNlakN2U01ObDU2bDJKcTNIME1a?=
 =?utf-8?B?bk9xbmkyYkN6Q0dlcHpMREo3VlVtSjh4ZE50ZnpTMjNVRGFaL1RSV2FRYy9t?=
 =?utf-8?B?WVFEMzlEV3NKOERYNmdiU1Ureml3cU9JZERUT0dsMHVzb0Q3VDh3T09EODVV?=
 =?utf-8?B?aERXeGZQd05kRyt2WFI0RlNuMEg3blNYNzhUV1crQlJjUW8wNkVYSVdTRk92?=
 =?utf-8?B?djBucklFTVVOdnJ6ZlZaYXU0UXR6SmZURUxySWREWVF5UzlhYlBUQ2xSTWJl?=
 =?utf-8?B?VWF5NzRnaWpYT3o4R3lSc1ltQ3JFa0hKYmhpNGJacXNTRXM3WlMwWUhzVi94?=
 =?utf-8?B?RHkxeXpGb2lvZ3gxV0hXNDFiOWxZUUhxcUU3YlRGZlZJVlViRmJXdXFqSmNh?=
 =?utf-8?B?OUQ0Q292SDhsQWVVVnhua2diYnNSWEdVUjZ6TDFnWHZ2VUtwSEY3dnVUUHFr?=
 =?utf-8?B?cXlhMGoySUR5a09RTVRkMlVpd202VjBkc0MyUVcySTZLd2NmZlNHYXd4OWx6?=
 =?utf-8?B?RnFheE5aKy9EOVNmWGdHWUZIdTc3OHgrZDdlQ1NCa3VRYkY1QmltRjZlbWVQ?=
 =?utf-8?B?L05pL1NWWWxxaDYrUm9TMVpWcUM4YzdFVTEwVVN2QVFWRGVuWmpGTXo4NS9s?=
 =?utf-8?Q?lQwHWJW9hiVQjPzUIr5E2RaGcnyISdFWHVJ82h7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 463fa79e-89ce-4423-37bf-08d91c7242b4
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 16:05:32.2381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6MHxI6aOlg7p7UDOjP/bRpydhvjoEjj2Px91kVDd8QagdUHDOBL9JnJ2qZf61dlP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/21/21 5:10 AM, Borislav Petkov wrote:
> On Thu, May 20, 2021 at 10:41:30AM -0700, David Bartley wrote:
>> This is required to support Zen3 APUs in k10temp.
>>
>> Signed-off-by: David Bartley <andareed@gmail.com>
>> ---
>>   arch/x86/kernel/amd_nb.c | 3 +++
>>   include/linux/pci_ids.h  | 1 +
>>   2 files changed, 4 insertions(+)
>>
>> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
>> index 09083094eb57..23dda362dc0f 100644
>> --- a/arch/x86/kernel/amd_nb.c
>> +++ b/arch/x86/kernel/amd_nb.c
>> @@ -25,6 +25,7 @@
>>   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>>   #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
>> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>>   
>>   /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>>   static DEFINE_MUTEX(smn_mutex);
>> @@ -57,6 +58,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>>   	{}
>>   };
>>   
>> @@ -72,6 +74,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
>> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>>   	{}
>>   };
>> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
>> index 4c3fa5293d76..5356ccf1c275 100644
>> --- a/include/linux/pci_ids.h
>> +++ b/include/linux/pci_ids.h
>> @@ -555,6 +555,7 @@
>>   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>>   #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
>> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
> 
> I don't see this define used anywhere else besides amd_nb.c. If there's
> no use for it outside of that file, I'm moving it there...?
> 
> Or does it need to get added to that k10temp_id_table in k10temp.c too?

[+Guenter]

I think it needs to be added to k10temp.c as well. In the meanwhile, 
k10temp_probe() shall be extended with support for family 19h, model 0x5x.

> 
