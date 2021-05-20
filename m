Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83F6938B907
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 23:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbhETVhg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 17:37:36 -0400
Received: from mail-mw2nam12on2066.outbound.protection.outlook.com ([40.107.244.66]:26048
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229972AbhETVhf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 17:37:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gY7SlW90FH5ZUmWwGfJK9PTRhbFWogtHFX+8jHoNUmmizGN/uoQ7LIrEfNvyU17etRXwEJ84MuGbOWVSXOYbEhlNO+n4xfRVMqBFLfHd620IScYvR22bFU6itKLFXDrqnlYMNU1SVkZwTspgVGJS+3JgKt+M39XPx8o2L/MZZIQJgml1fvH5ECk2RCA9CjnvHWFgfe1f34qyje4EFiK+71Uz2j6D8iQTzuwgIn2BuKP5JNbIBX3KTrge1o5RS5fb9UfYWTI1ObkJkuTIKB5Mgb2kxwnieOKzkKs7BdGnW7XD59khSi9vbtyrWm80Zm1ZT537FaHTUr0MSwpuBLagYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBzkYKexObS0FkvXYmhBeXSdvMLJtmNG4XEavBiwdlg=;
 b=VAr3zk76i3Hg7WFjVud8r7HLkiWzLORWT4SzmVKfF6SbTt35SGX7HNFGd1SydVVGOxab7Sc8i9zQymR5KxedIy1Swtzmmb/OM4+XoZWo19fYEbo2mXAkJECpcbrXQbZeeyqp1IEK+ppdJQhlt4JbS9WW2wWGywAZw+bCMhvtvmK3pVH/h+DbzTakePI019DgT2oCwIqbCJAef3g9lCFmxJyEePV0GnE/ckwuTCSvAg6jadGzrfjQpTup7foNK74qb48pbA2hzjEkZI389mXDyupJk3uKVfT5ZKV85s6O1S3e6rpTtD1kHVGDk18+jVhbgxW8f61T/tgd/IO8zUvgpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FBzkYKexObS0FkvXYmhBeXSdvMLJtmNG4XEavBiwdlg=;
 b=uYFERaaYUfwQZsBZ8F7qN0uarQZ1/OauAeIsMwQ9zd+iplQ5LJUivjDEDsKjChBZKUbFOqsO8HNHwwShqUUzK/Sz2PyPVAjCH7Y2APtrU9cuLig7aRW4b04zYiLq1URB98oZXO37xFMMCzXvx9FUjaNz+URzT1troMOYh/mZg4s=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com (2603:10b6:4:5b::21)
 by DM6PR12MB4267.namprd12.prod.outlook.com (2603:10b6:5:21e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Thu, 20 May
 2021 21:36:12 +0000
Received: from DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::2833:2120:ed9f:c3e4]) by DM5PR1201MB0201.namprd12.prod.outlook.com
 ([fe80::2833:2120:ed9f:c3e4%4]) with mapi id 15.20.4129.033; Thu, 20 May 2021
 21:36:12 +0000
Subject: Re: [PATCH] x86/amd_nb: add AMD family 19h model 50h PCI ids
To:     David Bartley <andareed@gmail.com>, linux-kernel@vger.kernel.org
Cc:     linux-x86_64@vger.kernel.org
References: <20210520174130.94954-1-andareed@gmail.com>
From:   Wei Huang <wei.huang2@amd.com>
Message-ID: <b6be3a80-df49-70ec-a3dc-e621b1e1a8c2@amd.com>
Date:   Thu, 20 May 2021 16:36:09 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <20210520174130.94954-1-andareed@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.77.11]
X-ClientProxiedBy: SA0PR11CA0168.namprd11.prod.outlook.com
 (2603:10b6:806:1bb::23) To DM5PR1201MB0201.namprd12.prod.outlook.com
 (2603:10b6:4:5b::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.10.87] (165.204.77.11) by SA0PR11CA0168.namprd11.prod.outlook.com (2603:10b6:806:1bb::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend Transport; Thu, 20 May 2021 21:36:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 822f766f-6a72-45b8-917c-08d91bd749be
X-MS-TrafficTypeDiagnostic: DM6PR12MB4267:
X-Microsoft-Antispam-PRVS: <DM6PR12MB426737976CECB4EC5306F2FBCF2A9@DM6PR12MB4267.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9gYboPlSoSFjwtj5GKAFdSMdTPx/g5rRLNHmstKjyFJVD/VXRbM0BRVywlVrpmCFlSzA4UouB6963FDdqPKj7/nyAQgYkF4qAaKu/6ArieRjSNkZ/i26Guvqf/bt/FVmgfp/FzKM5ZZUDACT6M84aCgNoqYpKcJ0WdLmuBE/3WYRkbXryi0D8ylh5SI9fXYD3b13sP2C2aU7p3YK+z7Q/3eEyX8vhEzzoccrAJ4aFTGY2vxQvjSZVx9Ok70BXKjU5NyFVCiJRi65vJw2TgNw9BFp2NbmFr66gN/1mBqJnOJPhusPABYqhgMPmMz6QLrMLYgoFsqxPrjrVMbOoJE2Wo9xX2A4LS3Ha6l7eMpbjLb3te4+5BMpuNyzxc6Qef4xilg9Cavmrel/oh6VihC2AvePmr2WUqIPZfWKf+FLL4GhKYYdLaynC9X0K2mzDs7W7xHIPJ4fLiK9I8mswhntzIM4jvbrf9cbLi0FpXeKZgC79kj/X+qs79VgtVm2h9rrHpjmxKGJHwtUerFFnV5EYhD9d7AJx+T/PngDjMeEexHwPsAYo9P8lRhDYPgKwT+V9S0pkfI9m9oM4ZX7R733jEMKFjz//wJlmUsRyUUx4KPjH+5Y8JR5fj7y64nqAEcK+20XozOE3hJ/Pqn6uGu0XhX9iw6jqdrDv3SI3M+ESge57y8xOldKve61cPInEXnwcVmoeZttm8EmZrboDEk69A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1201MB0201.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(396003)(136003)(366004)(376002)(38100700002)(956004)(2616005)(8676002)(16526019)(186003)(16576012)(31686004)(8936002)(53546011)(478600001)(26005)(38350700002)(316002)(2906002)(66476007)(36756003)(66946007)(66556008)(31696002)(86362001)(52116002)(5660300002)(6486002)(4326008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UFgxTjZGdHlOK1JJSlhTbGtNUTlsZ0pEcFJySUN3TWtnT0Z3UUREVGJmKzdI?=
 =?utf-8?B?NVNLQk9mcURWRUZFMUdmN3hFVkFUVjVjcVJYbGVFayswV3RTZTROY1Y1SzU1?=
 =?utf-8?B?emF1a3ArNUNTMExvWDBTWkxaVVZLaTUyL2hKd2Z2WGx3NjgwaENmWUtjSVdV?=
 =?utf-8?B?SWNpSlBkUFBFdE9uMFJLYXJtb0FCN1VQR243RUsrdTNWT1Z6SE43NW1Vd2Js?=
 =?utf-8?B?UDZ5MlJZM01PY2ptdTg4TXNoYVdQWEllWlA4YlZCTTREbmtQSGdDY1I1Qnkw?=
 =?utf-8?B?eXQwajI3QlFjQXBvRDNiOWdLRkYvUWVpQmIzQTMzbWNvT3VMb2RjTSswVUdv?=
 =?utf-8?B?UXcwdzdOMFlsTjBYb3k2THVNc1FvWUY5ODBSZVdWMkYvL1ljYXdNNFg5UTNM?=
 =?utf-8?B?WTdpNTZnM1RpQ25MTWYxb0RzOElnR0hmTjFuUktkQTFXUXp0L2NaekE3SEs2?=
 =?utf-8?B?d2w5NU81L2tSWmpDRS9ndk5veERXbnBsRjFrMWJWdDZHMUN1ZUtBMEU5UjR1?=
 =?utf-8?B?cytnSklNbWgzd1dnWUFDMFJFbkhWdUk1citNUTRPM0cxdmpoWWlnYTdUNG4r?=
 =?utf-8?B?dXNkTUR4ZUFaZWZrVUFKVTBtWnFhMlVzL29RM3ovazdyZHZVYmZkVGtiMlpR?=
 =?utf-8?B?cnU4OGhvWHJia2xxN0VoL0MyRmF6MVF2bXBxTC8xeVRBNkxHVnNSQ2hWRGw0?=
 =?utf-8?B?dTBsU3dXc3BQM2kvS1pSZDViOGlib1RxWnMwdk04SVhUWm94YUNwZDZVbmJw?=
 =?utf-8?B?N1AzdUlLc0hsaG9aZ0IvbzRZR3Z4SFdoSzlacGdMQlNYYXVCT1ZJUm1ZdHJl?=
 =?utf-8?B?dHR5aU92SzRjNmh2MEZ4YWxseldXbHI5a1ZNNENBZnN0NDRGSnNSU3pzQ3ov?=
 =?utf-8?B?NzhRY3lSM3dJbk5VdzB0b1g1QmYycUt3NkJUUFR1Yll5YkZhWGoyNzh5Z1Z5?=
 =?utf-8?B?Y3A1cWhQdmc1QW8yY1k5dEtKZ2sxZnpqY3lFTXI1SE5mQnZhRVBzMVI4aWs0?=
 =?utf-8?B?YWJqRjNOSklGd3ovbHBPM2RRS0h6ZlF3azljYjBnMTlmSm45UUM2dzdZemlL?=
 =?utf-8?B?TGJLV29lS213dnUwbHZaWWhjL0lROWhuRnV0em5vbHpVMU0vK1MzQWtEQ0J0?=
 =?utf-8?B?U2JzeXRITzJsYUlxcElEdVg3UXY4SS9xZTRsMVVOcndFOW5ZSHdJZnJwOW1q?=
 =?utf-8?B?WUtIU2d0Rkx5eEtLV0liVlBVQ084a1VxeHk4OENrRXFDNDNrWTdmemZ1bTM5?=
 =?utf-8?B?RGV4RHFvd1JsWStubVhWUHVFeHhsN0NqaXhaVi9IK053ZXpXY3U2azM2ekto?=
 =?utf-8?B?Qlp1NVVNWWNwVTc0bktlQVBLYmNzem9OVEhOWXlVNklzNFFkRTFWdkM4MkN2?=
 =?utf-8?B?anFNVmY5RzhiMmxEWVkwVEZrRVhPL2JzMmZROWcxcnNSY211WHEvTEZVaGZY?=
 =?utf-8?B?S3FuWGdLWFc5NER6NzRuMi9YUGFWODBJbE1MY0dSUXBWdk5uNDJaVlZIV3pL?=
 =?utf-8?B?TWJ1V0ZBTzBZUVpyc2FzQzNrazljQUllQ2R5Y1Fqdm14OXU0RElOSlEwRnh5?=
 =?utf-8?B?KzdrczFoM0YzaXhaeklDc2Rvd2xzUlcvL3UxeWlGenNKdTl2QXNhQzBIeHZ1?=
 =?utf-8?B?VkhjSTRGMHA2MjI4QUs5RlNOTkN2am1NaFM4MzQ1SXNJZVRidDB0bkI1aWd1?=
 =?utf-8?B?WGZzcUF5WjdJSzhXaVdBOE5hR2R5eC9PTUJrNlZURkhJUFFHZ3VzanFPRnRE?=
 =?utf-8?Q?7G0nIJP+gYBPkQ+LOm79EkK30aG320W/aPKtW4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 822f766f-6a72-45b8-917c-08d91bd749be
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1201MB0201.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 21:36:12.1359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uc3MrNqunR5xpFAZgMLplEnlvs4bBRNZIddErgnxt61FvlhxBmrXTe+mpN6LDPba
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4267
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the specification, these IDs look correct to me. I also 
found them on two real machines.

Thanks,
-Wei

On 5/20/21 12:41 PM, David Bartley wrote:
> This is required to support Zen3 APUs in k10temp.
> 
> Signed-off-by: David Bartley <andareed@gmail.com>
> ---
>   arch/x86/kernel/amd_nb.c | 3 +++
>   include/linux/pci_ids.h  | 1 +
>   2 files changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 09083094eb57..23dda362dc0f 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -25,6 +25,7 @@
>   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>   #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>   
>   /* Protect the PCI config register pairs used for SMN and DF indirect access. */
>   static DEFINE_MUTEX(smn_mutex);
> @@ -57,6 +58,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>   	{}
>   };
>   
> @@ -72,6 +74,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>   	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>   	{}
>   };
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 4c3fa5293d76..5356ccf1c275 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -555,6 +555,7 @@
>   #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F3 0x144b
>   #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F3 0x1443
>   #define PCI_DEVICE_ID_AMD_19H_DF_F3	0x1653
> +#define PCI_DEVICE_ID_AMD_19H_M50H_DF_F3 0x166d
>   #define PCI_DEVICE_ID_AMD_CNB17H_F3	0x1703
>   #define PCI_DEVICE_ID_AMD_LANCE		0x2000
>   #define PCI_DEVICE_ID_AMD_LANCE_HOME	0x2001
> 
