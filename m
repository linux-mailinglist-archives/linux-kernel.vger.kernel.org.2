Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0460C3F5F8C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 15:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237572AbhHXNxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 09:53:44 -0400
Received: from mail-bn7nam10on2046.outbound.protection.outlook.com ([40.107.92.46]:28705
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234881AbhHXNxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 09:53:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VfY2FEJ3de8FL3xLFHXMqFZ1UuGMUjbEVMI/dMyrnwYC7ZqshX7P3g3JK8g4fBVofyvBXppGpx2xITNluxygGR17NgiUClVMt2J5dWwgLWveuiNPzuph6qONCKC48hd/TRE96xvSFVmZMMYKxlBZVxnWaCwyqh6yMiG9GZck0llUoY6QM1sEZuWJaGP3QE7AMmMPwUoKX1x+eArfE3vY4QVtGSfesW1hAdTFdsqvSjRoUBVQFNBCyB0tTXrnkNxP0BdlO1YxgfiXhhcqe2QOsNBkTK9b12x3gr0mN3Ms/AzRQcMjnGby9b7YkAHo35st59Gl35KGYo/8ajok07mRqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMLEWSzaqezWgedb32U0fbnFBa6De+UzbiPS6GVK8YI=;
 b=S4O2sMUD3dMjUBZ9gin+PIb2+tXPgxBDLFjAGgBTKoq6B6cqdRRFJa2LcC1DMgpWph6oGpTZo5TwRgAdy0dRttNblTjJNBR0A1mYLfvnmuGZRRvuKDCk56+YUNM6kwalufgs/qNfjUs60QPmXCN+yQiyUxrJAOciw0zUhmE5GQ4ca8kT/USI0DLxurG1TLNKnPwT0vOaoLO8ALSVBx9xBYoXY+f5wytesis3jKV8yMQX64oMgdSRnCuyGu6w28aUZKaKA85RoMCMDqKawYJGZfOR51AqNS2R98u9q0bXhs097o6MJK3d2916SivxRcCn9qqPS8llQnWj4bgsu1Tj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vMLEWSzaqezWgedb32U0fbnFBa6De+UzbiPS6GVK8YI=;
 b=HjoDi/EEEPGrvKFl52XGeSM5UV1ulsYAxZez/DXEAnn8Gur8Wdya6zbpHPN9/am5nnBsxJvZxNlZfWgNP5Fp6o4aME2dv5PvjBPnzihOEW9b7P6/nAVdbCUTa7QHwovkusIjn5Si2jGw9eXlzWA9hrjK7g2nAZYWBFNAJQsI5S4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5349.namprd12.prod.outlook.com (2603:10b6:208:31f::7)
 by BL1PR12MB5176.namprd12.prod.outlook.com (2603:10b6:208:311::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19; Tue, 24 Aug
 2021 13:52:58 +0000
Received: from BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6]) by BL1PR12MB5349.namprd12.prod.outlook.com
 ([fe80::152:9dd3:45a4:eeb6%4]) with mapi id 15.20.4415.024; Tue, 24 Aug 2021
 13:52:58 +0000
Subject: Re: [PATCH] drm/amdgpu: Fix build with missing
 pm_suspend_target_state module export
To:     Borislav Petkov <bp@alien8.de>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <YSP6Lv53QV0cOAsd@zn.tnic>
 <CADnq5_O3cg+VtyCBGUDEVxb768jHK6m814W8u-q-kSX9jkHAAw@mail.gmail.com>
 <YSQE6fN9uO0CIWeh@zn.tnic>
 <CADnq5_PEOr=bcmLF2x67hx24=EWwH7DAgEsPjYqXgf8i-beEhg@mail.gmail.com>
 <YSQJL0GBzO2ulEpm@zn.tnic>
 <CADnq5_N0q8Rfm++O3jK6wcbePxg_Oj3=Xx9Utw60npKrEsSp8A@mail.gmail.com>
 <YSS/F9kcQcRKlNJ5@zn.tnic> <94ff5309-f71a-6107-01e8-8d7d544dd4e1@amd.com>
 <YST2u5UznQjMKulE@zn.tnic>
From:   "Lazar, Lijo" <lijo.lazar@amd.com>
Message-ID: <1bb0baef-7924-98ab-b125-aa3c2ac405d4@amd.com>
Date:   Tue, 24 Aug 2021 19:22:46 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <YST2u5UznQjMKulE@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN1PR01CA0073.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::13) To BL1PR12MB5349.namprd12.prod.outlook.com
 (2603:10b6:208:31f::7)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.157.114] (165.204.158.249) by PN1PR01CA0073.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 13:52:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8095e70c-9a61-4f16-3de4-08d967067ac9
X-MS-TrafficTypeDiagnostic: BL1PR12MB5176:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB51762E4BC8EDE4501B25429E97C59@BL1PR12MB5176.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xaUSI8z+33f9s9baDgOBZyoeA/c9He3XeZN+l+5ktPU9XKTDsMYksK1yVk3ZTsBnMIYPkx6xqcRj/LkneewVPlZlQLOyK9LxuAWuS4TEpLReEN+1lgYDGxektMnaX+HwRO1IdZgz6N++aUZpWej7esWg5SFC9x22NMEwxvpHAg77YnUGMCkBaPpdDb7O8T/nNXY/myy697PUGi7L5sT+7/ndVBgJAgPfxGnSiiyy6+oE/fpb7SX8HkgeUu6TY1omKrk+KjqKqTsxhkBzB3K2LpADk8+fpkvdxhl/7pjtSILSZVQ7FHgGqMbU17NTdobBJXYubLO6Rgn13P6V/KrXAE/NeQ80UYK2DpPNNMPHaCOzIc19t2dGDK+pX+IlNNwxM98q7VE7MgGgPk2LTeGT+HOBc/0cIvCv0uq709JEzTzr78gDAZdUFcRNURz7NZlbu3bj/1VzOT6/x2rOqq4nAsNVWMpzll4QZJ2P1hvtHBRTr6N/f2feBfuoNlsBuVkKVDwvbiTzzxTSxPytM2UINXI57Us7helr1/9YWyFWjt3KQd5pBLFuzsRwJRnE0Onz4bQI4UvWnKNal5sRuGYznLslz24Y7EnM9M/+utkbMQRMK/g5cBT88ln63i50JosYjCVXDoDxKweN7GCasJ+XM2AOBc7zsUhwcAvKwl88eetaffaX2vJ08X6bM6MNY49G6oDV487m7Pe4rjo7mNZLTHxfGomD6VQzAjGxmQle3LoXurb8KMxP797zLt6WF3WpM2k4rvozViHgHlF5cJLw98lvI1aVhdIW0RXCpzSy8vjxDg3U42JTQNj0ISvRmt1R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5349.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(66556008)(66476007)(2906002)(36756003)(53546011)(83380400001)(66946007)(478600001)(966005)(6916009)(26005)(45080400002)(31686004)(16576012)(6486002)(956004)(6666004)(316002)(2616005)(38100700002)(5660300002)(8676002)(54906003)(31696002)(4326008)(86362001)(186003)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFZWR1Q4OHI5eVhtQzZBcVdNd3RFNUhrY1BNVkZaUzllSUFMVnAwYlVGZnJX?=
 =?utf-8?B?YmlqbWNDU1VSRENmNUJqVnU1bzRaTHpDbXBrbWFRQkFxbWk3R0JjUGQrNVJC?=
 =?utf-8?B?SVBhZlhxQXAzMTRiWWZiSnF6eUJiNnFYVXMrNTVNdmRDWDRMbW53clY5T2Vw?=
 =?utf-8?B?dnNudlRKeEtaRzl6SUtUam5BWHVBNkkxSzUxNTFwaDZ3T2VTVVlGay9FRyti?=
 =?utf-8?B?TDV0Wkc5amp6ZXFBd2hITFFwOE51cE52a2x5aTZiWlpkZVZ4MHlLQnhPay9G?=
 =?utf-8?B?eXMxSHJLZi9ZRFFHNCtJYTRrc291Mnh1Nk5aSlo5Wk9TWUtxQzJxemlUWXY4?=
 =?utf-8?B?ZkEvc0lvcE1WeDFVS1BTVzhDMDgzNFZJMjFwL1FTUUg2bE85Q2ZQL2ZrSm8y?=
 =?utf-8?B?dGVSNG9Xa09LMFRjcXpEbHRSN0s5Q0NkU3NXQUloamNIYnI1TjFsQzdOdC9S?=
 =?utf-8?B?NHpId2RkaWtYTmEvOEJNWjJ5TjdEd3F0azA2TVg5QUdXN1RWekp0YjNOMHBs?=
 =?utf-8?B?MFA3NU5LdmoxTTRNbTI4SjNaa1NRclZ0SjBPbU9EQ21WU0lHTjladUlESFNV?=
 =?utf-8?B?blZSaUM1cUZaRlBYcmkzNXlvazdIaitCQkpENk1mQVVyWlBkVXJ3THdtbm4v?=
 =?utf-8?B?ZlV3R1RWT3Q0WGFZV3VmYXF0ZUtRalV3dmFuclp5aTdUMVN4aFhHbTlSN1BG?=
 =?utf-8?B?SXhQOStXZ0FGZDJtSjgrcHg4Z2N5SXI2N2g3Ky81eEd4ejZTRjZhSnpsQ2tx?=
 =?utf-8?B?Slc5RVV0UURudm5SR0p5RE1PREl3c3ZhTGVvSTBuVlpQZmZDTHkwanZQTUZo?=
 =?utf-8?B?RXo5VnZFNEZCL3Y2aWhWVVFpVkI4K2VpL21zRUhDT0Y0RG15aWYwVVRCWENY?=
 =?utf-8?B?Tm5LNFY2MVQvRk9pTzhZcWdtdlpMcUZ3VEZ2eER3S2VoT1U2MGI3TGNQUnZC?=
 =?utf-8?B?ZGZjbXlad09ZcWVJaVZSeGpoTU1XNEUzOGFlVmNjT2gwbGJXTmptVXovY1hl?=
 =?utf-8?B?SkxYb2lGUG9mL3RLMWI2Q2JEc0JUbnlEQjJXcHE5cWZWZ3NUZDU4SHpTYWRk?=
 =?utf-8?B?L0U3UXkvQXJtelB3R3BRNkJvdHp6Znp0bzlEWEVVTFJPN3V0YWxxL2g3eklJ?=
 =?utf-8?B?MTZhWndLYVorRGxPcUZwOWh4Z1NGcDZiMVBUVjZBaWh6UlRlY1lNOE15Qkhp?=
 =?utf-8?B?TVZlcFlFSy9pWm9wbUhwYXRxam5sNEx1emVoZkpIOHFmSWJUcHVBZEdzU25M?=
 =?utf-8?B?WENkaXhjMEFKdzRsT1lCKyswZWxVRnZHZVFKZXZ6UDZJNSt2NDdMT1NCREFK?=
 =?utf-8?B?WEJLTnYvY1JpZDZSQU5iTkVESU8xbnUwYmJtVUh6cGRVeUhIWE91dzBUb0N3?=
 =?utf-8?B?Qk9XQWttcHRnZGNoVWxuRXcrUmxqZnBVUnRvNWZITExBYndJSjdJUDFmcWNJ?=
 =?utf-8?B?Y3k0ZFAzeXBIaDZZTXNpVWd5aXI2U2xTVkRWT2orRVBlcHNjZjQxTVl6YThW?=
 =?utf-8?B?Q2prZTVFT2ZvLzV6a0EwZytmaDh0ZWRhYU9mMGJuc0hZeVNCbTdSNzJaTVQ3?=
 =?utf-8?B?aWlmM2diWWhnTGozanVhWmlzSU8xZkdUcld4MXRZMVMwTkRMWGhWdlduSXRB?=
 =?utf-8?B?aVRwZ0lUTXFpVFpDOGJmVjJRV0syWm5DVUZES3Vma1Rnc0xXZmhWTXBjNGk0?=
 =?utf-8?B?YjNGaDRBNklsZDNXMHNOTHlPNUFTUlAvTFdOY240NHNKN2lReWxqdllrWVFH?=
 =?utf-8?Q?pbtOmSaOXiLSOo3pDCTyHW+qqAcS3i4DZ3XoYSt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8095e70c-9a61-4f16-3de4-08d967067ac9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5349.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 13:52:58.0564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y8CVCx8gdYOys3fL/D6Qm24VnnI6LKHAARTzvybUz8cdoIUIevyB8ejlourQyhi2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5176
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/24/2021 7:10 PM, Borislav Petkov wrote:
> On Tue, Aug 24, 2021 at 06:38:41PM +0530, Lazar, Lijo wrote:
>> Without CONFIG_PM_SLEEP and with CONFIG_SUSPEND
> 
> Can you even create such a .config?

The description of  "(drm/amdgpu: fix checking pmops when PM_SLEEP is 
not enabled)" says -


'pm_suspend_target_state' is only available when CONFIG_PM_SLEEP
is set/enabled. OTOH, when both SUSPEND and HIBERNATION are not set,
PM_SLEEP is not set, so this variable cannot be used.

../drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c: In function 
‘amdgpu_acpi_is_s0ix_active’:
../drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c:1046:11: error: 
‘pm_suspend_target_state’ undeclared (first use in this function); did 
you mean ‘__KSYM_pm_suspend_target_state’?
     return pm_suspend_target_state == PM_SUSPEND_TO_IDLE;
            ^~~~~~~~~~~~~~~~~~~~~~~
            __KSYM_pm_suspend_target_state

Also use shorter IS_ENABLED(CONFIG_foo) notation for checking the
2 config symbols.

So it does look like that error can be extracted as well in some config.

> 
>> I remember giving a reviewed-by for this one, looks like it never got in.
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Famd-gfx%2Fmsg66166.html&amp;data=04%7C01%7Clijo.lazar%40amd.com%7C4d61b17225944c45335b08d967049ee6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637654091831465201%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=GCdVG8N7g2E9DaiM1ek1voKQ9stZNfnEwyghQ0pWoxU%3D&amp;reserved=0
> 
> A better version of that one got in:
> 
> 5706cb3c910c ("drm/amdgpu: fix checking pmops when PM_SLEEP is not enabled")
> 

Well, now it doesn't seem to be a better one. The original one checked both.

Thanks,
Lijo
