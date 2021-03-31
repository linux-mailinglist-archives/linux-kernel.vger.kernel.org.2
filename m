Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E28F34EC43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 17:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbhC3PZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 11:25:19 -0400
Received: from mail-dm6nam10on2081.outbound.protection.outlook.com ([40.107.93.81]:14553
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232483AbhC3PZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 11:25:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzalUoy6jZ2vLlZ5RrXKkpvyabDMrNWARxn9QFta9AksUCKmttZvov50jbjf7G/H4y2FiNZ+eWZZwKDnafc//jv4l1Dqe56ibDqmhM4afU3+6I5gpIePtfChxuwBiZlADQ6TcrjKrDGbJrxz28k3lRfWZHG0ke4EwDvwNIKNi/8w+TFmkLPIyi7tLpWUrGnpDjq01NT3GgjJD5eqJMkstEDPibq3FnpfvjXO6a8wfFLE6IlDifGxwERUfvYIsXJeVIj+/KmWrb0rnaDU8gCW3UUXxUB423Fj3khfebBizKM6Kdh5L2WOaue7UjGZMZKudHAxKUU1VG/G83idd6S4Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NiVrmNKC7Zhb3UBQQWID/g8gJjKzHGpS90YvUYH7/M=;
 b=bCfn3ynC3rBEalPi6/Qk2cj96itMluSXSbCpgb7jgRzskpDRsM3BIfKPxEhN51+gz/3/lVaYToYUSEpGaP1AGk5Km6znayD2NIsfiC0F3HzCaKn5lizpGdXAjxsX+Eq5tm4Sx+9DQ7YaOVzW9KeQRpYT5c1piLAGtqsxyjJVj7oV8sI780zifzkIIqXcnjVAM/qEfupr8gJ0azYDQ6YW71z704PVEovMPl0MtWh/Nuk54Kk7Bd463d5ltJiGEGKKuTF+pZXobLmf8DT2EsQGpx0IazKeTCAkWMzaR3EF5bN++ZWFHXWSmt1aMPE8sHgBRjgl6+gQkVhST9RwuIYmNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NiVrmNKC7Zhb3UBQQWID/g8gJjKzHGpS90YvUYH7/M=;
 b=USZWi6OjvxlB+wewkZmz7Aup665w8WWPXOruk6ONEXuo7LM01CGHWHXDUq4AW5Uichzsatg9LDtpYysCTebuhy8iznpgT5ENwH7l7hNLD7ksix5E8MfR9awHn3El7E7dbrJM2dDPyAO4j+i48OQQihCOOPRhTZ5hE2RGGZ6/1dk=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23) by MW2PR12MB2569.namprd12.prod.outlook.com
 (2603:10b6:907:11::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Tue, 30 Mar
 2021 15:25:03 +0000
Received: from MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::c977:4e9:66b8:a7e]) by MWHPR1201MB2557.namprd12.prod.outlook.com
 ([fe80::c977:4e9:66b8:a7e%11]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 15:25:03 +0000
Subject: Re: [PATCH] ASoC: amd: Add support for ALC1015P codec in acp3x
 machine driver
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        broonie@kernel.org, alsa-devel@alsa-project.org
Cc:     shumingf@realtek.com, flove@realtek.com, kent_chen@realtek.com,
        jack.yu@realtek.com, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ravulapati Vishnu vardhan rao 
        <Vishnuvardhanrao.Ravulapati@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Akshu Agrawal <akshu.agrawal@amd.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <1617095628-8324-1-git-send-email-Vijendar.Mukunda@amd.com>
 <82817878-a30d-2b0c-07f8-48bcca3ebc80@linux.intel.com>
From:   "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <a55c7a75-22ab-31fc-81b3-ed8fa24027f4@amd.com>
Date:   Tue, 30 Mar 2021 21:12:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <82817878-a30d-2b0c-07f8-48bcca3ebc80@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [165.204.159.242]
X-ClientProxiedBy: BMXPR01CA0058.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:2c::22) To MWHPR1201MB2557.namprd12.prod.outlook.com
 (2603:10b6:300:e4::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.252.93.39] (165.204.159.242) by BMXPR01CA0058.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:2c::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend Transport; Tue, 30 Mar 2021 15:24:57 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 1b28ccf8-f1ff-4f24-42ef-08d8f38ffd5c
X-MS-TrafficTypeDiagnostic: MW2PR12MB2569:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB2569CC11BC11581A75C8E002977D9@MW2PR12MB2569.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EYlu9YdBoPmVF29o7UkPCaVYu2db23z1w1xH+unZ0yBRqW5DkLzgivkvcWOjGcmZISbJMSYRuylvyMr3NFUyJ4CKBSkkiKygTY2qvuJeXUAFfhvzVnhWj//+ue292muBEuuxlxWtFBL2EJgOEhnC+ZNYJxbfCmdQ5nHcxPHzygianP3hog0SEmqr2dDn9XhHCH1USHABiI/DN3kQD2sABpv9wiHzlGRcMOXUJfkWfszis/CqggLNPlLFKeE/gDs1wvmnDSXzfuEKLSnmTULydzYogvGKrQzlQsU5gnZasmBQ+SB2VnrE0bmLwkrYYPe9JSOFj706TmZKvbnb+c5BlkleDS6HsPV6rCIygmwTfx/rTHNFVKiXk2Q0kXbmJwPb6LB3oPm7bO21T/6+Zx2uz6UV+/uUOiV7XojkzIYTQeadwnpy++b/OkMwyeTCy1QCV1jaK4ozm3MZYGDUqKZlKEfKwbZa6HZbAmcU1PLW0gHhZFjs7DLuLQJffY2toirIAn2h+7MITuoi9ekJsaPpyA5UmLzo1Ov3IQaZ0B/DRhqYpRpgpBc+FmDTxWFcTtiFUOxNahLHAF+GeBzsOobZCc6bnDB2suQ+X+lDqM25AC5gtB5cb1gAbg+KOq4VAZy8xwgUpf2ixc18QUL6Y+jFnvoV4cH0puUfOMlUuNDqHaixdVvFmfOWLJvC7avrxb6OS+K3CE9BnoIEM9fYyjJkyMVOaN2kTnkSyyGRWDUurGRgZBk+5Fi/lVPxn3X5KfGPdXHJTZRm5y2hDnvBPP9c3M9iXPwUhqLTfgj6v1N3PFatC9K/t34lzl7weoc+drMuvUGYXyXiV95yqvsmpxhwpw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1201MB2557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(136003)(366004)(396003)(956004)(66476007)(16526019)(186003)(2906002)(316002)(2616005)(66946007)(4326008)(966005)(54906003)(16576012)(45080400002)(66556008)(4744005)(31696002)(38100700001)(52116002)(7416002)(31686004)(36756003)(478600001)(8676002)(6666004)(26005)(5660300002)(8936002)(86362001)(6486002)(53546011)(42413003)(32563001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?d2Y5V1NnOWNKN21WeWZlNW5BdHoxMG53RFI3Lzk5eEVBTUpzLzcrRXhLMXFO?=
 =?utf-8?B?SldLbHhiZTBSR0F3Z3VVVDJRV2Fid1h0SGZnZEYvaFlBM1VuOXE0TmNPdTBH?=
 =?utf-8?B?NXRlbUExYmpkOStaUExvZHdlNW1ickVaTXNDa2tvU2lSanUzaUx6d3JpeGY4?=
 =?utf-8?B?ZEVQN1JyRWU5NWlOdGNFdXI1RGwzaG9JOUI3anhrWXl3VytCNVlvanpBaHAx?=
 =?utf-8?B?UkpHQ3RXQVdjVUpaVnJSTHU3UWROWmoxTEp4bThGY2pPblJHNy9PazlUMURU?=
 =?utf-8?B?R1BjbC93YTBucmpyQld5cEFGZHMvMjgxaWZzVFZTRmdZRDBNWjdBYnoxZGoy?=
 =?utf-8?B?UXZrMEUzYjlybDJ0V0E5TUdQZzJrMWNocEFxc05zVDhpNldZU1pTNG40RXV3?=
 =?utf-8?B?dWljUDVibHFPQXpqdHZGNG9kYlNkYy9OOStiNkk3b0V2Szlic0Q4MnlvTmcz?=
 =?utf-8?B?dmZGR254dFphMDNZeXhRZUg4RW1VOVMyaVVGTEhxWmJ4M2ZTNHlFcktmcFUy?=
 =?utf-8?B?ZzlhY043ek9JNUIwNnB3bFFaTzUxYVZyUFU0U3Z5b1EzM2RPN1l4Zkg5cldM?=
 =?utf-8?B?ZTdGaFgvdWZ1YkZpR3BkallpRFlPVXBZMXNXUCtqQnErbTRlNUZCRjVwT3dk?=
 =?utf-8?B?blZuQ2lNKzg0bG5KNW1oVmNQY2JpeEIrU2FEbzRmbFlhSWFhYVVEY01xcHRY?=
 =?utf-8?B?MUVwVVVtVnZja2dDd1U0bTdybzM2R3pseUd6L3VpVEJxcVJ0QzVqbDlmV25s?=
 =?utf-8?B?YzBCUURiSC9ycWFORVFBSE9MRDFRQ1pvUnFyZmxjaUMvTlQvNDYxYjNWNExU?=
 =?utf-8?B?ZDdqVVBCWW44OVgrUFl2UlZzRVFrMXBjbE5CdUVDTGdCdGlHM0hjVnZLWXdB?=
 =?utf-8?B?WXJJTkR3OGx1bk5Hb2Q0dVkrcmxyTDQ4ZjVTZW8wRGt1U3hBUC8yZVBINjVj?=
 =?utf-8?B?NjVDcmNucThrcmxySW9LSWRVK2lDTVAweEpLS0dlUTJ5LzArNTBJLytHeGd3?=
 =?utf-8?B?RFh5MEFWNk9LVU9kUnhFOTZFc2dkdDFKSGZFSDVrc21CSTVmSklDRXVHMGM5?=
 =?utf-8?B?UHJ2a1Z3bXVrWmg2cDF1OUxRNHE3NHFXQ3ZLakgrWVVqZ3d3UDkvdTNHcXBk?=
 =?utf-8?B?OE9iMXBHbFFoa2I3MmVNaE1sNG9lNnQ0dFJZZ1lKNVhqbGQ4eWQ4SkFpdmM3?=
 =?utf-8?B?QkVaZlhnVnhRK1YxTElhMEkzOUJhVC82b1ZPWmtDdlgraExoNkU4anhCbG0x?=
 =?utf-8?B?Y3FmRlVGd0pHMkt2ZC9uNURJeGZNTHhjK3ZHRVdBcEVqQjhCTVNzOEpqK0pY?=
 =?utf-8?B?c3c3Z2dCQjZ5dWE4ZVB2N0tHa1RSa3NoSFNZUmk2Y0h5ZVEvbHhKNGlLT2pC?=
 =?utf-8?B?RVVrVzZzZDhuQzdKMGozZlgwbHkxRk5sdU1FZk9LbzdjdFd5TytDakRJeWVW?=
 =?utf-8?B?eUxtOWNOSkVoNlhUUFpYQWkvbzhSUWJvb3owU2J5T2tlMzNGVU5zR2todmZW?=
 =?utf-8?B?MU10OVNEbFVYaDl5WG5FbGkyOUlSL2NIME9PbUk2djFzZXlpZUUyTUhCdVVP?=
 =?utf-8?B?VHBpcGdqaEVtbFdkMXVCbzFNTG5VTVQ1N0JDckh5RmRscGRoNmRWa0Zva3Vu?=
 =?utf-8?B?V2JwalZOa25GR2MzS1czcWROazlmMFJUdUt4VzV1TzZWdC9ySVZyR3pPRURk?=
 =?utf-8?B?b0NXcFQyRXFUUWtsQml0U1NnUExOcXVhZmQ5R2pIYmFLK2RLbFVCTnFGTDky?=
 =?utf-8?Q?dFm6Eme1c+wXn5zyAH+JcmS6M9TajwaaCoKFKbs?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b28ccf8-f1ff-4f24-42ef-08d8f38ffd5c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1201MB2557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2021 15:25:03.6507
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1kUNMbHaGc/cctybAtN6pO+7RWz/VGetnIEh2xQD0oK42oII44CtmvM9/UKUrCJffaa3vNp2NYyreWnBRlCp5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2569
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/30/21 7:52 PM, Pierre-Louis Bossart wrote:
> 
>>   static const struct acpi_device_id acp3x_audio_acpi_match[] = {
>>       { "AMDI5682", (unsigned long)&acp3x_5682},
>>       { "AMDI1015", (unsigned long)&acp3x_1015},
>> +    { "AMDP1015", (unsigned long)&acp3x_1015p},
> 
> This isn't a valid ACPI ID. AMDP does not exist in
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fuefi.org%2Facpi_id_list&amp;data=04%7C01%7CVijendar.Mukunda%40amd.com%7C7406bd8053104c021c6c08d8f3875396%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637527109839548809%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=WXNykTVcn4tgxIHPsJVXaDf9J5a63c29IMUOhJ3X8LU%3D&amp;reserved=0 
> 
> 
> There was a similar issue with Intel platforms using this part, we had 
> to use a different HID.
> 
> 
Is it okay if i use "AMDI1016" for ALC1015P?
