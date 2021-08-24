Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA6153F622B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 18:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbhHXQDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 12:03:48 -0400
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:31480
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238287AbhHXQDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 12:03:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I4HplR3N7yqdzoDfee0Yxk4z0es0e/qRT2cnVoF6UFJ1ZeGQK/NM1k9wByWFoGCbo5duWjro+wfSy7xHUfqHDRZo5bRuq7HEyDIOjl+PuTp19CQLgOaIt8zEcj2I3W7ulv8LCwm1nEFeY8WcsI4hnrpau0TA/KgzhGxZEBt9OIQQ0ZybhEv/BDSJP3Y6xyQR62jG1sHiqTZe8NcC0YGn2YwB1yHloin80naOYZsyE/jljmjsblCX2TObjpT20ckYtsKQbVt3MzNy53Ly1NBQlY/eJViXNO/kEe+XtkICCGG5YQmMFhpPU8Cn1Md2UtvhFOKs93/a51vEdeyaaSzvag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zytsSL5sGMfx/5OvkRC7hWK/LM/FJ/la8fdbavgjI80=;
 b=dm1iOi0JM7/mvd9iwjLT7J3YI/AnI0f15WPs8OggxOgFtgsvpBrrCJX/QXeIxbQxRnfHr3Kn48dR+KC3fxI7WOPwIeBEL7xIyVz+5K1+b4Y9O6QXCeARMJcC0tADyOzNIemYwXiyBpy6Oy7fe0N91TvPKC0ql3flQUufKcF654Xiq8Z8c1vzC111XxmqU9IcX9iUkqGh5c98beyZkjofBIEja5oUEDyt8FkNM2cx/FXH2E34NMP9/G+fZW9mZuYiiAfRVMl1LYdsX3q1QHSdqkuTeArjeL7MWZESD4gPL6L5tUR0fnb2HjeNxHfPRHfC2osfq81SJikCasQ0QQKn6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zytsSL5sGMfx/5OvkRC7hWK/LM/FJ/la8fdbavgjI80=;
 b=fhdeVi8f+S4AKTAV2UIl7aUlEkHiFF/aFAs68CWpnV275tEhuxFGWfYTsqEJLEPX5cHo9geHfs/uoh4ZGEp+TZCGG7kSjUCxJ7Ju16aXcIB5pfHG0/VLoesWCnCbW3ogeUeIYteH9ygJbZ+JUM8hS8FmMlewiyjsx//A1iidXmk=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
 by BN9PR12MB5036.namprd12.prod.outlook.com (2603:10b6:408:135::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.21; Tue, 24 Aug
 2021 16:02:45 +0000
Received: from BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e]) by BN9PR12MB5052.namprd12.prod.outlook.com
 ([fe80::b0d4:3c4a:e942:338e%6]) with mapi id 15.20.4457.017; Tue, 24 Aug 2021
 16:02:45 +0000
Subject: Re: [PATCH 2/2] usb: dwc3: pci add property to allow user space role
 switch
To:     Felipe Balbi <balbi@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, kun.liu2@amd.com,
        alexander.deucher@amd.com
References: <20210823184449.2796184-1-Nehal-Bakulchandra.shah@amd.com>
 <20210823184449.2796184-3-Nehal-Bakulchandra.shah@amd.com>
 <87pmu36ypp.fsf@kernel.org>
From:   "Shah, Nehal-bakulchandra" <nehal-bakulchandra.shah@amd.com>
Message-ID: <1d9ecba4-d180-2193-66a3-3812759e1916@amd.com>
Date:   Tue, 24 Aug 2021 21:32:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <87pmu36ypp.fsf@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::22)
 To BN9PR12MB5052.namprd12.prod.outlook.com (2603:10b6:408:135::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2401:4900:16a4:35a1:f52f:38ab:363f:1bfb] (2401:4900:16a4:35a1:f52f:38ab:363f:1bfb) by MA1PR01CA0082.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.19 via Frontend Transport; Tue, 24 Aug 2021 16:02:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3254a9ee-e233-4ab2-7ef8-08d967189c92
X-MS-TrafficTypeDiagnostic: BN9PR12MB5036:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5036E11E3EEB23D17EF798AFA0C59@BN9PR12MB5036.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n8pjKhdLD+Rvk7oIsUuo7tR0X4tB4JpvcUaiwwgQjgzXuFiiOOy8MeYhxzSR2d4HDXFzu53IyXyR+nZjEl9eivC/sY3ZdtB7J0ADVszVW5lTMzAjWUNmhtwEMJv7bdwlMV/Am1Tgzq/3Qot2YjOKVdMauuQlmSE68OpHwXdNWV9xjztBtK4PKHoBy/7PGIBf1IxzYVI1yPhHv6YKqZTpiyjCeTxtrPMwezDld+5YvrUk3/HMAO+eSJVHlHYqbxgDPN8gQGrmJsvw7rOr1imcr8iUxOrAwz2axn2/jQziT3G3eiamFB3RqzeTqXAe0MP8FgxoMosvVTf947DXnKKDD7HOCPgos1MuxsV34rZvS0mhtYK5Q6yHzmewFt9uEsOQ52U0RtX1Z9xdAmTYIk63GnaHGXAhR6pVkFmHiPTDkC4KJ/0eq4RDmil/tTWchX8kK7AQ31Z5szbuDzLnJt5gipc0hx4GYjQB56fmLpMk6YdSf+etW36Kjyjs79sWIHLQtzM0UgMvxStHS4oj4VnohL0nFNIMFpE4cj2YQ12SVETATt7wgeBkFgDaLJrt3seWCtI8LziED6ROG3rdrQI4g4/GFoqmj0bDLifm5ciGBruW6OchgvDeG7NqTpwktae+e6O1QlYetA8a9WDeU5XxBlTMkISppB+CAl1sMVvflVGkXgZUVwLdLAYZ8ahRjwDuVd+eKFA+rCoR1g9O7tT6JagrZebqFQxFger0xeCmtqU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5052.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39860400002)(346002)(376002)(31686004)(66556008)(66946007)(53546011)(8676002)(66476007)(6666004)(38100700002)(6486002)(186003)(8936002)(86362001)(2616005)(4326008)(4744005)(478600001)(31696002)(6916009)(316002)(2906002)(5660300002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SGJBYmZ0aC9lMGlTc2kyR2d0YXJyVFFmN2I4TC9LZHcyUnViaFgrVU5sYXdG?=
 =?utf-8?B?TFFDRDFqVk9NWTIyZ2hSVE1wSWcxdkF1WGNzYVhzTUtGeGZkL2wwaFJKOEhP?=
 =?utf-8?B?enh0VzhzZ2VLQlRzNERSVmtRV3BsZm9NVW1yMi84Q1ZkUHpRMlF6OHhqYzFH?=
 =?utf-8?B?ekVxNnhCd2tKNnJoTk5EaFEwQXZjbGNKSlRDWHRWTjNsajl3L3p0ZHV0NnlD?=
 =?utf-8?B?dkw1U1p0T2wwZ3ZDdnFsdHdSMGhmSHZJYmNJV05kbWxQTjhRM1JoWHI5Mzds?=
 =?utf-8?B?SUhRUkhxTFVPQTVTQllLOTE0bkw0VGl6dnVCVU5jUXdDeWFOVzEwUDV6enY2?=
 =?utf-8?B?eTV5QVpFT1d4cGxEWTF2ZWtROTdmaWQrTkF4anJLQkMwY0dBRXltWG9SeGdo?=
 =?utf-8?B?MlV3Qy8rZ1lEMEhieDFNTHZvZ0drWllIQVp4Tm9JQW83U1p6emxER1BQZzRQ?=
 =?utf-8?B?Zkk5M21yOEhFOGF2YURNbWY3TEdtQlZ5Z09raWpadWFxbmRGdXBQQXNHc3I1?=
 =?utf-8?B?MFFiQ28zclg5STA4MTU0ZEZ5SzBzYlBIeVp5Y0NKK1pjOHlaQUoyZmJSWVll?=
 =?utf-8?B?S2tqc1F3TmFCMzIxSTFHN05YTk5Hck9tYVJnVUExdjhzV01rZklUcGoyZmlR?=
 =?utf-8?B?dThNTW14Y2pFUVAxcnAzM25aY1dDRjIvcmpSbVZjZXlkUWZsa0ZWNG13U01Q?=
 =?utf-8?B?QW9sei91aCtQT3h1MG9sRS9Rdm82RzBudzNRTWVPUUFjNksrOGxQTFh4Mk0y?=
 =?utf-8?B?UUpDVHlEYXVoK3E2dWhXT2orR3FaaEVCekFQSURGejlwN1FSc1I1SXBiOURw?=
 =?utf-8?B?aFhic1pIWTZrY25IK1pGZkR6dlFpSUorMlhpRWFQdEpWNTI3a3pTd3ZRVXh5?=
 =?utf-8?B?dHVZNm9JaGNWb3pSRG1remc5NGFFRnR5SW1qelZWQ3JUN2dtL2pkVldDbmty?=
 =?utf-8?B?c1ErVXo5TENLUjFlazV0ZllDbVhuSitmcWZTdGk5QzFqWHhDYW5RSzNMckhn?=
 =?utf-8?B?azBwYzdnamdURFlyVHVyeTF5TG41ZkNVT3FxeTRyNWRrbURZVytQMFZFMUEr?=
 =?utf-8?B?ZERmNnpvUkppT1BpVDhBTC9rc2FlbUprK3IwWGlYVktFS205UmJ5TVhER2Vo?=
 =?utf-8?B?L2pqZUtqekFTWHBsdmZZa2lXZkJDQ3dsM2VTWXhtNmpLU0o2bUJ2cGdlTzds?=
 =?utf-8?B?VkV6VnhHbG4rWFRmK0pVWHJrSjd4Q3dsZHlubFhqeldXUTFqazZNWXh4K3kv?=
 =?utf-8?B?cnljclJMRG1ETE5IVUNsdzBBZ1dEYkpYN1U0TzBGSzFmenpReXFTbGQxK0Zr?=
 =?utf-8?B?MmlybUgybHVKZ1NtTzBtOEFsNXVPek5sYnZLTHBOdHRZbWhYcDZOZlVERXZt?=
 =?utf-8?B?MFlkbmNlV3lNRkZTUDRYNFFMRmxsN1o0MElNV0U1SXJrZ2VoaGhxdDZ6c0RB?=
 =?utf-8?B?R1ZZZ0E3MkpXdjdMOE80djNRQ3YzTUhyRGhmdm9KOGVjWFJIL2kvZ3NvTExz?=
 =?utf-8?B?dUFRU2JkOUdNT3VsVm5hejVuYUpKa2NUdXY5SnZiTTE1eUViNGFyTmp2QkZa?=
 =?utf-8?B?MWN0OVB4dmVZcEo1KzZ1clErMHdkU1UrUlZ3OEVsenlDaGQ2aXM4M1RCS2o0?=
 =?utf-8?B?SkJxUkNHYnFES0tYdm4raXJLaDlmcU9OeWMwQldBMzVxYUtnK3VzbkcvdllF?=
 =?utf-8?B?ZjRCWHg4R0d3dExqTlY2NWtpUDhNck5Qem00YWhQQXEwenpFeDc3Zm9UNkNj?=
 =?utf-8?B?MjhaOHRwZ1ZRUDJjQUI3THFieUFXV3dIS1hyY1hWZkJScjBBd0dDOWFZbDM0?=
 =?utf-8?B?elhmMUFCdTVhSUt4K3Uvc2xJQmRBdzVoU0lmY2lhak5vT2IydEpqM1cyZit1?=
 =?utf-8?Q?0sy5/5VNMm1+X?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3254a9ee-e233-4ab2-7ef8-08d967189c92
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5052.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2021 16:02:45.4911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kmIgFX6JxtgmNB/OpLjSxVCLe5mD6SmlxIDArWcyUquiRgf3JS4lHhsrvjeUZf3p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5036
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
On 8/24/2021 1:49 PM, Felipe Balbi wrote:
> 
> Nehal Bakulchandra Shah <Nehal-Bakulchandra.shah@amd.com> writes:
> 
>> For AMD platform there is a requirement to enable user space role
>> switch from host to device and device to host by means of running
>> following commands.
>>
>> HOST:   echo host > /sys/class/usb_role/dwc3.0.auto-role-switch/role
>> DEVICE: echo device > /sys/class/usb_role/dwc3.0.auto-role-switch/role
> 
> A more important question that needs to be answered: why?
> 
Our customer platform is not completely capable of OTG i.e with type C 
controller it does not have PD to support role switching. Hence, they 
have script which triggers the role switch based on ACPI/EC interrupt.

Regards
Nehal Shah
