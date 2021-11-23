Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4665845AEC1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 22:52:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233876AbhKWVzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 16:55:24 -0500
Received: from mail-bn8nam12on2082.outbound.protection.outlook.com ([40.107.237.82]:31808
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230005AbhKWVzT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 16:55:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MvnXXDqXxJ7UUJg63PKBViRlA48AJ0Sj4CS+o3LuNPoyf8be3c+p+vGaGxW5K9RVBV5OMiTcbKq3ldWa/FoGgAGzoZAeIqV+JMu3Co6ri7M23mhNtC7nCCIot6lEVMhmbZ8EGyRmF/KCQ18BVAFUBeZ3Oj/rD7NdoYbE7MQx/OChxotmrQB3ZZV8nxXe5ceEt7DIGZ+fvQbQkO0YY4aOC/9IUw1ANKFraT5Fw5HlQ3bEUmVTNdu3xIwl18fj5yJJWh8JgcX80wwq8uxQiQNgdDzJap4yc8MJNBcPKORiTU9UnK/HoLat1YXdv3sPKU4Z5kLbznaPh4vF5wY2domzRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3zqKSDMrvwwGYcbW3Bljfe+oLCNiQnX7386tlX9sxBQ=;
 b=gQo1DawvAao3MZ9dUzkBvjiETzNSTLmdjcsn1nzpC2bpXtKkyIpBf1bcyLHSd71Tg8d+adhSXcDNRNh195r79q+WASmTdBj9x+0UnuIFjyqpGDKiDPLIVaxX+MrD6DzbDknKSLOktJA0mq0IGzK+FYcvHGzyBGomW3P8ZcIPCmSFlypXPHGJXTBYHyh+U1mhTOACO7mZXUM9xhBpwVTVR0srSq68L6ha3ZqyzZfzffpNnButkOgSTuTC9PPypDrlHqENTkdh6ZSakmIxTsb5BWoAr+BwgjmZwzSSP9rB3HfMjsfPufQmJ+m27Fx1CRNrh4poYbxqVyydEz2wZuZoKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3zqKSDMrvwwGYcbW3Bljfe+oLCNiQnX7386tlX9sxBQ=;
 b=C6pkrBP7tYnViDemE9gCmVd8RU9IX029CJpHiFrtUPVBqPIKgGGIeU4jeWX6dYLO4kkDd3LgkjoWGhOOEGDAPt8nTUqmduHLSvOvQIF9sYSoLMOE5SSEUTEyZg6Smrds1dKYrDdslJA58zfLxNrb8qi9iHNml3NphbWeplOoQ/o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA0PR12MB4557.namprd12.prod.outlook.com (2603:10b6:806:9d::10)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22; Tue, 23 Nov
 2021 21:52:09 +0000
Received: from SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::a560:867:ec75:da14]) by SA0PR12MB4557.namprd12.prod.outlook.com
 ([fe80::a560:867:ec75:da14%6]) with mapi id 15.20.4713.026; Tue, 23 Nov 2021
 21:52:08 +0000
From:   "Moger, Babu" <bmoger@amd.com>
Subject: Re: [PATCH 1/2] hwmon: (k10temp) Move the CCD limit info inside
 k10temp_data structure
Reply-To: babu.moger@amd.com
To:     Guenter Roeck <linux@roeck-us.net>,
        Babu Moger <babu.moger@amd.com>, clemens@ladisch.de,
        jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
 <937b305c-c61d-e754-c86f-7019b57dd737@roeck-us.net>
Message-ID: <6e22cf38-39b6-6cd4-1435-c9a9f2e50230@amd.com>
Date:   Tue, 23 Nov 2021 15:52:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <937b305c-c61d-e754-c86f-7019b57dd737@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR16CA0041.namprd16.prod.outlook.com
 (2603:10b6:208:234::10) To SA0PR12MB4557.namprd12.prod.outlook.com
 (2603:10b6:806:9d::10)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by MN2PR16CA0041.namprd16.prod.outlook.com (2603:10b6:208:234::10) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 23 Nov 2021 21:52:08 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12e66afb-4608-45d8-25e2-08d9aecb7f43
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2509CB9C9AE9A31A6AD7F99E95609@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzZih64W1ycR+hd9cDDQe6JLjK++E/8cHm84zJupD6DmCxqyympet8Hy9AcZwS9g8WgjRC/5VauFhfTkuO1OUlzEsgOiTP5uGyDH8vhnT2+uQEYYIB/KODPrRMSaNT78KphYqmoXEpBSokxApQaFb2obKh0OEEKQceERbza9xg8Q528JVMq9ri4oAXX8LNlZPTQFCQWbgNjTEZn5ijR/wi4Rb5AaIdkU1DjE64wG53KH5VxAJzIPY974CysVZalUD5QLrNVZkmnYPuNaJ/AEnZTlrDcIJIvZViSLV1+kjIHbJrQS+lWqSAUJw+Bj565WHYdt3/DqeICTQRrxgjmoyLHSmOS7dRpzY9jqo+rsiq2ffmAN1VwQ7h78gw4FMb7LKnq11ZyoLm2sAKGOjSwG4dJ7KzyIIKpJnpVtg83VgRq5JE7kKUtKsHOlvEdDxoakvz0oxlYk3xCyCGTVKMrg3sHxnVA5RtolXKBJ90cueYysYBl0yJjEyKmjIx83aAZVpM8MPfG9URVs+DKHMfyH+8dvNhiACeK+VaXH9SW3i2grqjJ3ds4YRm6N9a/aLCVYwwyGptOX8ywnkmp9wyvZFZYfzfhFdyAXai2lXQu75+WJ16fbE4BTjq0LTq9IKpgp3LrYdZ7o9nFhEr4FAdmwQ5z9VcwLcbvTNtaMEwoW3jZSzRY5bRDpwwkNBzxDIjslooFJioFZcpR/YU5IlCendGh/7KgLpiQFTXQQcst86WM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR12MB4557.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(2906002)(8936002)(66946007)(4326008)(186003)(508600001)(31686004)(36756003)(8676002)(66556008)(956004)(2616005)(31696002)(6486002)(83380400001)(38100700002)(26005)(53546011)(5660300002)(66476007)(110136005)(316002)(16576012)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2tzTjdYVmF4U2tmYlJDcTlSaFRLT2VkQ2FOZE42YzRTcWNobnZGcm96TUp3?=
 =?utf-8?B?K2gyb3UxOURmWUh1aUJvblV5NjlCaFpoRHpQV0l6VzlFV1JESFJoS2ZodkRm?=
 =?utf-8?B?dlYzT1FLUlYvdGdHbU1XV2Nibjh6S0ZHS01DU1dwUGoxTGJpMU5yNUI4bjND?=
 =?utf-8?B?eHllSlNFN3pzT0lNVERQNTBRaUd3WGZ5K2o1UlJIc1BSZG9QVmxzM3dJNmFl?=
 =?utf-8?B?eEN0Umlra1F3elJtOC81Qld5eW53Y3BTak9aMDZYaXkwS1JKWWkyQWdzN2Q0?=
 =?utf-8?B?RFFzTmZPcHpaUGNUU3lqMXBhZnYrR0xmRXJpUHQ3aG1UcjgzS3B4NldXUVA0?=
 =?utf-8?B?WllWalN4b0xTVnptNmY1Qm1mWWhCRHBpejBJU2JGaVlmbzhuditBUmc2elVv?=
 =?utf-8?B?ZHUxWWxPQ0Vvc2FvLzA1dmVNdUlLelFWanNkeTNua3BldHVZR1lxeUI0OGJB?=
 =?utf-8?B?Nk5veGFIWFNNTEsrN3JTbkpuQ3NjWXlpVUttUzlYYlpYNkZSVFl1TThVRmd2?=
 =?utf-8?B?ZmM5TUNxL3hMVG5DM2JVdURUVmxPQzA5UXZ1VG1oSGk2R1dlSzVwTEJYSktZ?=
 =?utf-8?B?RFZhK0FITXlMNDBrOUh4b1VPLys3eTBrcndSWVduNnovT2NabzFycEpzU0xB?=
 =?utf-8?B?T3VJMCtlNDRoQkJCYkdHZlM2eTIvTUFXYnZSdmdEVW55TkVsNlQvaUpyTTFZ?=
 =?utf-8?B?dHoycm5qNGMzblJOVDMwKzdKSWxTMWpocEJCa3ZyUS9XdWUzblV6MXFaTWVO?=
 =?utf-8?B?c1ZCamg3YVZHbDU0WkNic3hBS0NsMWdxVEZhaUptYzdSUUd3d2ZZMnBWRGhM?=
 =?utf-8?B?Q0lhcmsydnpzenFJWU8zQzJSa0oweFRIZ1NocE95bG84SXNNS016RVV2NnVn?=
 =?utf-8?B?QnRQelJqOU9ucjBldTVwUlpFMG5OMHJCYXdxckp2cStENFlyRzdNL25pa1ox?=
 =?utf-8?B?SEJQRTZxdHlCYk5ZYlNrVkYzT3JVVWJ2bkpPMk1ZdzdLOEVoendwdnZjTWox?=
 =?utf-8?B?YlhhRnJrOC9UbnljUUI5ZHVGOXZBb2NXcG1yaDdJZHIzRmZjRU90RWdRZWsz?=
 =?utf-8?B?RTZqWjcyb2k1T09xaHZFN1FpRDRtclRWcTRwS1c4SEhqL2tMWHd6cEEzUk92?=
 =?utf-8?B?U1hhTG9QZVl0cUlzS3RmbzMxZGcrYytnamtwQjlodGNGV3JpZlJhNXd2ZklL?=
 =?utf-8?B?Ykhja3FKekx1aE8wYk1WZmloSUNqd3dLQkRrYmdDNnUzVjdkYjlqR1ZwS2M5?=
 =?utf-8?B?TUlFUUsySXVXZUVyYlJMRUpmbUx4bEpzczFpU1J2eGZtQi9kZ3dPZHVqN1Zk?=
 =?utf-8?B?TElxMDFDT1pYV1dPUWRvN2VxWTY3TS9xckNEbHZoN2Q4OWVpdnNxZVpoV0ZS?=
 =?utf-8?B?M204ZWVicVFPbnhVdGJ6NGpHYVdRS3Bxa24yMFFFb05EQnIwaEFGQ0ZIY0c0?=
 =?utf-8?B?NnhoQ3RUcmRlbzZ3YmtpZXFjNzFYUUNCVDVza0F6Um1YWnF4RTE4NzBuUFJw?=
 =?utf-8?B?QUl0YzJaRmgrZlBTdDNZbGhXRi8zUUhpNGdaYlhjazdqTWp2eFozQ1dWRWZu?=
 =?utf-8?B?MGcvRHNRNGJTNVJaY2JENzdXVXVOSklZV0FjdkRONG00TGkzQ3BEKzE4MWpY?=
 =?utf-8?B?YTVMZmNtR3V0WVdhRnpRVmFWTFBrTnUySE5RYnBVTWpwM1dQNjFCNDI5Z3B6?=
 =?utf-8?B?S2JWTmtQbmZ2NEFXMTVYWElkNXRlNkNscDd5QWV5b0tFV1FmaXhFaXQ2bTlX?=
 =?utf-8?B?Mk9iS0Q1NmxvZVNsRkY1UmtWSlIxalJtMXY3KzlhSDJ0V3dQWkFPVlFPbkND?=
 =?utf-8?B?ZHJpWkxDczF3N0lnK0drYVI2NnhpaUR4OFYwaXVTRllrd08ra1RaV0hrMy9Y?=
 =?utf-8?B?N3NWaU15d1pLRnllczlxOHVxZmVBYjg4clNtNllKMEhmRHpndWVnNXBxdEtC?=
 =?utf-8?B?NnBaQ3ZQWDEvUjRGOVQ3WFAzQVJYRFFLdDJXODU3eXNsc1VOWVFmMG1hNWs4?=
 =?utf-8?B?MHV2V2t1Z0g0Sk9VN2xFTkN5ZUZOT0FyMndVeGVZOXF1YjRBbnpyMkZEdFlW?=
 =?utf-8?B?Z2VDWXJ4T0Y0ZW5GSXY4amlpSFR4SjE5bDFUeWZ5dG5xL2d3YWswSkN2SzJH?=
 =?utf-8?Q?c43o=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e66afb-4608-45d8-25e2-08d9aecb7f43
X-MS-Exchange-CrossTenant-AuthSource: SA0PR12MB4557.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 21:52:08.8806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3PG+0jZ39lEJbzBdB912Kp3u/Vih0iiI/nqjHvtsKAbnCFX+aUtO4vWCPzdyEdG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/2021 3:40 PM, Guenter Roeck wrote:
> On 11/23/21 1:16 PM, Babu Moger wrote:
>> It seems appropriate to move the CCD specific information inside the
>> k10temp_data structure.
>>
> 
> Why ? I don't see it used outside k10temp_get_ccd_support().

Thought it will be cleaner to have it all together at one structure. If
you feel otherwise I can remove it.
Thanks
Babu

> 
> Guenter
> 
>> Signed-off-by: Babu Moger <babu.moger@amd.com>
>> ---
>> Note: Generated the patch on top of hwmon-next.
>>
>>   drivers/hwmon/k10temp.c |   17 +++++++++++------
>>   1 file changed, 11 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>> index 880990fa4795..bd436b380a02 100644
>> --- a/drivers/hwmon/k10temp.c
>> +++ b/drivers/hwmon/k10temp.c
>> @@ -85,6 +85,7 @@ struct k10temp_data {
>>       u32 show_temp;
>>       bool is_zen;
>>       u32 ccd_offset;
>> +    u32 ccd_limit;
>>   };
>>   #define TCTL_BIT    0
>> @@ -357,12 +358,12 @@ static const struct hwmon_chip_info 
>> k10temp_chip_info = {
>>   };
>>   static void k10temp_get_ccd_support(struct pci_dev *pdev,
>> -                    struct k10temp_data *data, int limit)
>> +                    struct k10temp_data *data)
>>   {
>>       u32 regval;
>>       int i;
>> -    for (i = 0; i < limit; i++) {
>> +    for (i = 0; i < data->ccd_limit; i++) {
>>           amd_smn_read(amd_pci_dev_to_node_id(pdev),
>>                    ZEN_CCD_TEMP(data->ccd_offset, i), &regval);
>>           if (regval & ZEN_CCD_TEMP_VALID)
>> @@ -411,14 +412,16 @@ static int k10temp_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           case 0x11:    /* Zen APU */
>>           case 0x18:    /* Zen+ APU */
>>               data->ccd_offset = 0x154;
>> -            k10temp_get_ccd_support(pdev, data, 4);
>> +            data->ccd_limit = 4;
>> +            k10temp_get_ccd_support(pdev, data);
>>               break;
>>           case 0x31:    /* Zen2 Threadripper */
>>           case 0x60:    /* Renoir */
>>           case 0x68:    /* Lucienne */
>>           case 0x71:    /* Zen2 */
>>               data->ccd_offset = 0x154;
>> -            k10temp_get_ccd_support(pdev, data, 8);
>> +            data->ccd_limit = 8;
>> +            k10temp_get_ccd_support(pdev, data);
>>               break;
>>           }
>>       } else if (boot_cpu_data.x86 == 0x19) {
>> @@ -431,13 +434,15 @@ static int k10temp_probe(struct pci_dev *pdev, 
>> const struct pci_device_id *id)
>>           case 0x21:        /* Zen3 Ryzen Desktop */
>>           case 0x50 ... 0x5f:    /* Green Sardine */
>>               data->ccd_offset = 0x154;
>> -            k10temp_get_ccd_support(pdev, data, 8);
>> +            data->ccd_limit = 8;
>> +            k10temp_get_ccd_support(pdev, data);
>>               break;
>>           case 0x10 ... 0x1f:
>>           case 0x40 ... 0x4f:    /* Yellow Carp */
>>           case 0xa0 ... 0xaf:
>>               data->ccd_offset = 0x300;
>> -            k10temp_get_ccd_support(pdev, data, 8);
>> +            data->ccd_limit = 8;
>> +            k10temp_get_ccd_support(pdev, data);
>>               break;
>>           }
>>       } else {
>>
>>
> 
