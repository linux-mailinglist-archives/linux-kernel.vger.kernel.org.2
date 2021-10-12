Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98E3429E73
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233808AbhJLHUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:20:10 -0400
Received: from mail-dm3nam07on2041.outbound.protection.outlook.com ([40.107.95.41]:62798
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232500AbhJLHUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:20:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NS3LuAEhF46aHbz6bdSXBCJN66oZ+OlPDxhJrfbyTdlcYOttJDjGiB8vWnQjRiyN3lXLxRPR+Ji4aLrDaETKtZjcfvAP5eJqOv4Nx04HPqK9lZ09linf6ct2oEDf5oAoSTTV4PMJ3llPRq8AhXgFc4nGciKRHGxPZeiCtzGPc0Ta0mq9pvGO7Cc9hYbbk5fittRGgmH99BQQQ1XYXYxNyUbCfyxql4p56njCfdk4r3PKH0SRhT9XS0Q5knOc/G5/vO1LEwA3e64ePzTRstXnkd0CEmPFAtaZaDqSgXoBoA6obzCRW4QRSISaMBPibHeI96GWtt628WQ4I0c5L1PHPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tCBSrVDBzhtsIN2koaqiBLoDSv4WsJuJFf5oHK/HD0k=;
 b=lRA0PJE19/GZ3ACJxEOuQT+Ed5kU8hgy2LPxUTILnB9gPOFUmwTsNiYwDRQIyCKCHMpSqwtXC+X4iA4rpGxSAYad1zrIi5APNW0CT4gLXPQcZlbfCz35Mv7Y1NSArQBBd9s4i3yjuWWB158J3vMTpJhzBIArJ1+XhmAVuaJq+yzEO2nyW4Tdaa+UJcdj/yYdkw70970pmvZr654qNCIZygm6DL5aOQzCPbofebgfJIKIZK+l9jl+XgEYojjZXPaeQ2ZtgzSBy7ypmyC2mPmQ9xz+O++IVPBlQgVejQhlbu561To8Z95UWdrv2lgdOLNwVVBH+2dK5bnPWSqS3MsWCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tCBSrVDBzhtsIN2koaqiBLoDSv4WsJuJFf5oHK/HD0k=;
 b=T6UsAbkOn2KYku0+EytwY0x42FAjdEoIBbD/pz93orW5cg/mJyos0LvGF4iWsoKjO6tO9Yb6mQVuKOEGHVNEcBEU8n5eBin9oE337QK9o4lrXqEoGqrcscDIWK3z73yDuFXQRg+nfKSZse8zkaFekueJEoeEpn932fK6vAIZY5Q=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18) by
 DM5PR12MB1385.namprd12.prod.outlook.com (2603:10b6:3:6e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.22; Tue, 12 Oct 2021 07:18:02 +0000
Received: from DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::549b:1773:f036:9ee2]) by DM6PR12MB3627.namprd12.prod.outlook.com
 ([fe80::549b:1773:f036:9ee2%4]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 07:18:02 +0000
Message-ID: <bcd9fa5c-4fc8-989f-f38c-d4c48348a2fa@amd.com>
Date:   Tue, 12 Oct 2021 12:47:44 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 1/8] ASoC: amd: Add common framework to support I2S on
 ACP SOC
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com,
        Sunil-kumar.Dommati@amd.com, Alexander.Deucher@amd.com,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20211011154452.76849-1-AjitKumar.Pandey@amd.com>
 <20211011154452.76849-2-AjitKumar.Pandey@amd.com>
 <8f025871-fe7b-6224-cb54-26dd6d3def11@infradead.org>
From:   Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>
In-Reply-To: <8f025871-fe7b-6224-cb54-26dd6d3def11@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BM1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::19)
 To DM6PR12MB3627.namprd12.prod.outlook.com (2603:10b6:5:3e::18)
MIME-Version: 1.0
Received: from [10.252.92.171] (165.204.159.242) by BM1PR01CA0103.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend Transport; Tue, 12 Oct 2021 07:17:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 181a43e5-bee1-4a0f-2b29-08d98d506ce6
X-MS-TrafficTypeDiagnostic: DM5PR12MB1385:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13853E4F0DBD35C3A8592ED882B69@DM5PR12MB1385.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gunj5VsdDj9POXI+Exr6AGwL2oYm2vkBdiUzQ6/rdMTM7JDAXFEwiMWbDCanLqNb4Fi4LB4Pe/9COXd4dTk/D5JGJbFKHD8oRNrR6KAtYXf1MbspggrZabYoI5V3iJmHtLaVBilkcFV1+KkKKzv6eO2nEeY8tGDI9TAZ/89S4TwlvlwJRDO6BINAVe1pD9O7P0DIcNa2T9z+lo9mR12BatgKZvESdeFgxVr3tPSbf2fSWKR4ojuaYkUhmG3MchVzEsQfVBAxfPek8RPDLEsfXVh3ONqOkexWl0wvRRjv0nulbxfbyGETXxslvYlJDagf04krvd5coXXjSR7pBph+FDUWG9jCpAPCYpIQSBG8pSBHysQhDQAYsqoKYyh/kiTyG72+ug9yLbZQ7EkGJAtLEc2PcJgM0cOSJj7KxXyfjzjvvQV/pdG8iLRRqEiV2q5FuHaAJz+IrB6R4fVia7sPVlcMqx9Fm+BNKDZn6SY94crzNVAOqOCtD8dT0d5Qp0v7q9Ah7gzW3HZICQgf/vQ0aJc9TeBwkSudbh+8kpoKfa3fSgNFMUchmRAcjXtINyw6VWdZhVhwTWggjTRkCwuI7bu54NwgB8Z/u2QjNckTWthvic9LaWnYChDxadMP+OH9cy9kfTyZhOnokwju8VErtOEfkRZBaSS5QxsbNY+k6wcG/Z6yXu8N8EkbpMrDo6v3NhX2HQTD+Sn/3gsKNOgvg5aG/Yl6v4zFdo6pyIgcxbQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3627.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(8676002)(16576012)(8936002)(86362001)(36756003)(316002)(83380400001)(31686004)(6666004)(54906003)(31696002)(26005)(186003)(6486002)(2616005)(5660300002)(66556008)(66946007)(66476007)(2906002)(38100700002)(53546011)(956004)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkZuSjNnOTMycmZDeE1jZ0dQaWhocTRmSjQ5U2dsbTU0MXA5aWp6cW1FMzEy?=
 =?utf-8?B?RzFTUVQxY1dCeUhaTGFDREZWZ2JMOWdHWFZDblFCRGNzdDk5ZlM4UU1YU2tz?=
 =?utf-8?B?T3hFMDNha0tlK2F6NUhLd2cxYWl3ODhlRFV1eXpVY1FuNWM1eHpoc3JuNFR6?=
 =?utf-8?B?YnNuSDF4dlRtT2txYU90enRmVFovQ0JiMW0vS0IxbGNNcDVTSmhmNWJZdXJh?=
 =?utf-8?B?cWpiZis0MmlYYWJXOWM1OTVERFVMbDl3OGFkNzltdm5xRVBabnlPZ3N3MThF?=
 =?utf-8?B?UVFPd2Rvc202Q3dMYVM1bWlGMmpFNUpuUlJHWURIZlJrV0JkVTViT3Znallq?=
 =?utf-8?B?ZmxhNFpZUVBZYzNOeENKUmJNS0FSbFJpQ1BBaTJqS0JMMU55S2RlZ1VzMUox?=
 =?utf-8?B?cGlhaXFCMzZ6TnI5dSt3K1VkbHdJSDY0MDVRR29NYThubmx6NFA1SWxsVy9x?=
 =?utf-8?B?amlKaEtQT3J6Q1VWWkdCNUdDUjk5K2FRNTFNUE5HYmtLbTlGcmxzVncxWVc2?=
 =?utf-8?B?ZWlqMHVwSVB2M3B0SXVWQmxsb3NkWW5QZXhlMzN5NDFsT28wNzNrc2hpWllu?=
 =?utf-8?B?Vi9nVEJ3VlJ5MlR1NHl2ZkcvdUs0WlNtN1hzdlA1dTl6NnJITk1MVVlzTlZr?=
 =?utf-8?B?UFJHZkRuVElqOGduZHRKeW4wWFc3VEJGTzVJbXlYVmt0K2VYTUpUV0ZDRnpO?=
 =?utf-8?B?ZXNITzYweWlrUjNCb29zanUwaVJOTWtVM25aZmc5QldyUXU5a0w0QldEMmVa?=
 =?utf-8?B?NVBMV0w0T2x1aENLK2k3cXJ3bTFBdUJNZFloOHRyRzhKYWgxSzhZbjNYTU5G?=
 =?utf-8?B?eURuU3d1dDJpTHptdGQxWCs3c1NQZXFsOXU0TFB3dnovcXJ2Y0d0L3hTUWNK?=
 =?utf-8?B?akVnUk02QzErUzBCdDQyM0MxbnN5eThEWFNTWU5zaS9ZNkVJaVNSVUdiM2I4?=
 =?utf-8?B?RXF1NUFuemVqUFZDQmFHVDdsZnJ0YzZXbmZXbjZFSENYTWxyMi9Fek5Hbk1V?=
 =?utf-8?B?WVFVajZqWkxPdlFyaEhYTHByUVo0L3A4dndzZk5rWDhpOUk5aXVKZ3dYYzhq?=
 =?utf-8?B?dGtoSjRCbGdUeXN0WS80U1dyOTJiWnRvUkpsdDB6TnZhQnFVbU1NUGNIRkJQ?=
 =?utf-8?B?MFg5aFZrbW1jQytFUjl2Si9Cbyt1aXZLUnBDby92VXVHdEF6K0ZPbURZQllJ?=
 =?utf-8?B?TTlQbFY5U2xTU2FHeTQ2ZFh5Wm93QVIzRWdjQ1dWbXRvWms0Vnd5anRpSEtN?=
 =?utf-8?B?OGhzOS8wMlgyUWJJNnI3WEk2ZTVhTVVKZGZMc1JNRnZHM1hkUXlEYVEwZVNZ?=
 =?utf-8?B?UGdLUkZTT01FelEwRXBGRVFablBaWmYzV3JaWE5VRjkzWjVxdnBDeGJwOGw5?=
 =?utf-8?B?UE5NK2pKeWx2ME45amMySnRnN1QzNWZCTEkwUmJFc0xMV014WnRpZWtXSFdF?=
 =?utf-8?B?WFZ2RFVaQTlnWTByR3NwbkttRjAxOU9DZEZFR0VuRFVYYU9DSlV6MWVUbU83?=
 =?utf-8?B?VGJwNkdMd3Z4TEo4WG9na1c1SElwMjgyODJpSE9oYjNEMlMvb241VTMxdnB3?=
 =?utf-8?B?Rlh0MlB4dW9FZ1dYUHYvV0Z0ZGhNSW5QSzBndThRZlQ5TWtPbVNhS3NXL0s2?=
 =?utf-8?B?WStmWlVWK3VzYnV1ZFNWVjlPb1ZWQ2kzYWJEMXYxYURtS3V1c21WcVM5RE81?=
 =?utf-8?B?V080V3l4K3hNYkxlN2pIZFh3S2xlM085cVVFMzJDZElYZWNMZ2hGNTBDRy9L?=
 =?utf-8?Q?2eiXUK0igFCUs4MpFMl3LdYo93fv8LVmhVgMFeH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 181a43e5-bee1-4a0f-2b29-08d98d506ce6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3627.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 07:18:01.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YvUlqEluZCyeO8bSxg7oim8FcG1sAw0SqXrOW+oaJVsO35B63se171K8wC5xnOca5ja10wqFnmqcnFTzE1Wyig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1385
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/12/2021 1:46 AM, Randy Dunlap wrote:
> [CAUTION: External Email]
> 
> On 10/11/21 8:44 AM, Ajit Kumar Pandey wrote:
>> We are using legacy way of exposing dais and DMA configuration that
>> requires separate driver modules for various ACP SOC with almost
>> similar hw configuration. Moreover the legacy approach requires
>> separate I2S and DMA module platform devices registration and need
>> machine specific quirk to control various I2S endpoints. Add generic
>> dai driver and platform driver for I2S controller on ACP hw block.
>> This common framework can be used by various ACP platform devices
>> that shares common specs.
>>
>> Signed-off-by: Ajit Kumar Pandey<AjitKumar.Pandey@amd.com>
>> ---
> 
>> diff --git a/sound/soc/amd/acp/Kconfig b/sound/soc/amd/acp/Kconfig
>> new file mode 100644
>> index 000000000000..6b993074e2c4
>> --- /dev/null
>> +++ b/sound/soc/amd/acp/Kconfig
>> @@ -0,0 +1,18 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
>> +# This file is provided under a dual BSD/GPLv2 license. When using or
>> +# redistributing this file, you may do so under either license.
>> +#
>> +# Copyright(c) 2021 Advanced Micro Devices, Inc. All rights reserved.
>> +#
>> +
>> +config SND_SOC_AMD_ACP_COMMON
>> +     tristate "AMD Audio ACP Common support"
>> +     select SND_AMD_ACP_CONFIG
>> +     help
>> +       This option enables ACP support on AMD platform.
>> +
>> +config SND_SOC_AMD_ACP_I2S
>> +     tristate
>> +
>> +config SND_SOC_AMD_ACP_PCM
>> +     tristate
> 
> Hi,
> I don't see anything that tells us what "ACP" is.
> Please add that somewhere -- either in the Kconfig file or
> at least in the commit description.
> 
> thanks.
> 
> -- 
> ~Randy
ACP stands for Audio Coprocessor in AMD platforms, will update
Kconfig text with that in v3 patch chain
