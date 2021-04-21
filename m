Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAB473672A7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245196AbhDUSgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 14:36:46 -0400
Received: from mail-mw2nam10on2061.outbound.protection.outlook.com ([40.107.94.61]:8577
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238217AbhDUSgl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 14:36:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nHYazTLgK1Btk2FerDS+WZIWGvv+KVaJPph1a2ameCO2zSV3K7/BUaGOuhgCqsPNjXjHHskY0MuTjSZu2YCTh9K/43nhPl0+4imSvZKv98RntOFU7O2zHehIdPb4Vu87+izmWPcwYBZGSJ7JNJEaPqJ78ADoTfUWLz4TYO3hTMGQB1EYA6Z7WAbYPS2IMf/q9TI1SrPzCTK3w5JL8plTHsjvP/JcjjLdO1Kqcq17VzoysH48qTAa3aExyu/kRU9AQGkhj2WvZqDPxr4YV2xq3HSOB+2U7+9Czagmq3dbcUr/AGscCb/qjScyFfa66GeGaKML4jkoSbp/f+wAwOnm7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsRBCIhEXHZoe8Evr5Tqcw2b6HlWO0SqeP6Cp+nXUJI=;
 b=R7WW6r64Uf4NWu3MOuJF4OE18/0VaL3Ki4GVrS0cD+SETCXmcyY5cNFViLYzmYNnYFs+20pdQselsip5T/PgxoIiiviwKm8n5e9fdlvvGxI5LzjJYBBTRL1V3mUGmYuKnK7nhekrs3GZZe14mFqeUK4kGt+MWXAcsd/MQ5lpxP69z79cKHCwNYXx/nweU5EkULY+P+nTbUXxYhua2xqfEZBpJXP26sUwH5iISIjM0vwpeh3+g8Y2HhWhudNSeBzZF1OtplJyiL2CI+IFBOT3+4okFiOlAEuW1qXcAyPk1R9SktIHt/KmuszuT7lFifZ0OvYPsGW0c2lKaJIfUdavWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PsRBCIhEXHZoe8Evr5Tqcw2b6HlWO0SqeP6Cp+nXUJI=;
 b=HUqacTC9NQdDdQ4BlVTPqa2x+7lL4MLX8+8DrWThCnugtwMuKtB+mYfaKtfXLoogsUE1xYOqBaja871LA+JiVDP8H8pmYMHFUam73lH0xvBZAhiA2qsTosQ0OrARKlMorqIA+nkQ7+Trl/1eEhQw3jrhXhIyUYkIok9DGLUcTLw=
Authentication-Results: lwn.net; dkim=none (message not signed)
 header.d=none;lwn.net; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3435.namprd12.prod.outlook.com (2603:10b6:5:39::26) by
 DM6PR12MB4698.namprd12.prod.outlook.com (2603:10b6:5:34::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4065.21; Wed, 21 Apr 2021 18:36:06 +0000
Received: from DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b]) by DM6PR12MB3435.namprd12.prod.outlook.com
 ([fe80::69b0:5e8d:c318:3f3b%7]) with mapi id 15.20.4042.024; Wed, 21 Apr 2021
 18:36:06 +0000
Subject: Re: [PATCH 4/4] x86/speculation: Add PSF mitigation kernel parameters
To:     Bandan Das <bsd@redhat.com>, Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, Jonathan Corbet <corbet@lwn.net>
References: <20210421090117.22315-1-rsaripal@amd.com>
 <20210421090117.22315-5-rsaripal@amd.com>
 <4c688fc7-67df-3187-54b2-bf20e510fb39@infradead.org>
 <jpg4kfzfpzm.fsf@linux.bootlegged.copy>
From:   "Saripalli, RK" <rsaripal@amd.com>
Message-ID: <28a97cec-964d-229b-fbd3-8c8c6ce71590@amd.com>
Date:   Wed, 21 Apr 2021 13:36:03 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
In-Reply-To: <jpg4kfzfpzm.fsf@linux.bootlegged.copy>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.25]
X-ClientProxiedBy: SA0PR11CA0080.namprd11.prod.outlook.com
 (2603:10b6:806:d2::25) To DM6PR12MB3435.namprd12.prod.outlook.com
 (2603:10b6:5:39::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.134.241] (165.204.78.25) by SA0PR11CA0080.namprd11.prod.outlook.com (2603:10b6:806:d2::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Wed, 21 Apr 2021 18:36:04 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32116ada-eae5-462d-a135-08d904f452d8
X-MS-TrafficTypeDiagnostic: DM6PR12MB4698:
X-Microsoft-Antispam-PRVS: <DM6PR12MB4698CB709A8D11E26F1B72469B479@DM6PR12MB4698.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2733;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ow2dx61sxwg3odaz3WdtghnBEjsNauKm648/XfctmswYm5vcOMgKqqG9pCSX5K2aVqbKzyPAy00wYHzPCo3dXPb31vBKs3BRPv04ozkx1MsGFVgdXRaVA2U5A2ulmZwMg7jXDYgKsdv0PjPR0I9KOvJJDtq9X3FlwXPp8zz/VqLdNgQpNKIhLQUUJYTS2JQBJszgEKVLYVuyPbHYLKQea/RBjOWPbRIDh2n+5D5HVclwUxqsOyGHPgsm1As7DhqD8XhagDaiHGLb8vUwlvPK9H8R32j9A4/ex5VUZ0T/Mc+SHxCZPOsU/U8vcv7EwhzGB/qf+n7Z27OJCc/fgPyXFL4Oq/s2oy0Xx5iMxkpz32ZNGvw9Lt2LTDoIecelLh8PNp0dPhkAL2mJqQLC8uZeR25b5st2I7PLZPZOwaVqIk60zXPeG9/EtAFhFHML0MkWxC0sOb2lnMC2+9HSOKisnyFxRZMxAmW7GV/W2Xo3HgKRg7Asht6t0AGQyZ5T7uet4fQWRDXHTroIgf539ufKgrq7LSrViCUbOI9F71uDw+JvEWq68VfcpNmrhIpUGGVFM6RmaZekxDiHro+19SAyIz/P+uxaNVOzJEEdS0b4NttPpjPcFEZ8HZOFoF9slAyz2GTS1wq5r9EB3oXJ32E3gcGF99opi3Fc5x8VF7S2FJgAkmJ95z/8e3GuzHPYlASB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3435.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39850400004)(396003)(8676002)(83380400001)(8936002)(36756003)(66476007)(66556008)(2616005)(38100700002)(31696002)(478600001)(2906002)(956004)(16576012)(26005)(186003)(110136005)(16526019)(66946007)(31686004)(6486002)(316002)(4326008)(5660300002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cTFyaGY5OTc3SHJFR3ZxOU1lRW1BQkdJQk5DTWRSYVZMeXZGTFRPUGVUUURz?=
 =?utf-8?B?TmRZY1NwWmU1aFlzTVdwbWV5VG56VEVYdHRnajltZWZYUld6dUdHdTNhdERy?=
 =?utf-8?B?RFZhekkySTdKVVRQTlRKRFBCNFNzaG1SNEtLSUYvUzFLVU95UmN5Q3EveXky?=
 =?utf-8?B?OXBVcitJZk9EcHFmNkxGU2pYWnE4MDhnNFVFRUIvc1pobytjZWtrTVVYdEFn?=
 =?utf-8?B?NjdPZ05ZNHlqVitOZmpJb0srMTF1NzFaTVR4U042VWFTMFFxYlpmWEpxVFlO?=
 =?utf-8?B?Z3hxSzVqeGtOcWVIVmZJOUZHVVBCaGhiREFLWlViWnRjNG1Wc1lJYjlDZVFR?=
 =?utf-8?B?aitzNDF6M2dHaURxTDdOMU9TVlllSmdmY003aWQ5QmVJZi9RaDNOVytaY29X?=
 =?utf-8?B?VXpaNW1ETmRUdGd4WXBnU2p2S1dUVjVSdm94NzRoMnlLNGpVc3pUekExbHpX?=
 =?utf-8?B?NEdSUDBIUFQzNVdxZXJ6UjYrc2lCSDFXL1dmNDFHWm1rdjV4UGpqb0Mwby9I?=
 =?utf-8?B?NVRoOU1lc0UwbWRFeTVoZnR6WkU2ZTI4M3A4dGp1QTVWU0tCNWpDcDlkVUZH?=
 =?utf-8?B?YWZhN002UFZNZ0NiSXZUL2tTWDBPOUNhS1BkRnhQaGlYTlJTRlF4M1VacjNo?=
 =?utf-8?B?Q0hvbDlQYW9MQmxBSC9ySlAwaW5PWVhGUWE3bE42dUpBVGE1Ni9QT1I2Lzhj?=
 =?utf-8?B?a0FvSDdaMTNtMnQ5djNEZzAvZjlJSXl4SEZTNVdKVUFtT1NseTVWZEphZWFQ?=
 =?utf-8?B?dkF1Y08wQjhLMHdWZ1E4OFVCdEo4WGNTdElKejNVU2NWM3lYSWs2aDEzVFlk?=
 =?utf-8?B?ZVFOZXM4VVJWNzNrZGJ3OHFpaDhJdENsWFQyTy9CYjJsU2wyYi90cTV5bXFs?=
 =?utf-8?B?em0wVDdzNXVpa2JmMjF1YVZaUUdadUI3bTM0c0dCVEFEdWpZKzdHck00eXlr?=
 =?utf-8?B?UC9IRk5FTk9sNTkyTVpoNDcyN000V2ZHaE1JaXZvNW83T2RDWXNNcHo3SlJ3?=
 =?utf-8?B?elVXQVVBTWl3Y0dNTmo4aHR3cVluZC9YL0czWGoxY0FPU2VwNnhXblg0SVZN?=
 =?utf-8?B?ak1QRHFBcjNVZUtCRjl4a3ZianVLUXJ0TUJZNWdtTkN2TzBLK0E5dHJZd28v?=
 =?utf-8?B?T3JCZ2NweW9ubzVzUjZVTWoyb011N1R4RTY1K3FkYXFlWCs3djllOHo1VGxk?=
 =?utf-8?B?cmZvY0d2ejZTWml4ci9ObjFWQ3pmS2pRY0d6cmdNVFpHdDBqWEZ6cjA5b0M3?=
 =?utf-8?B?RFdNZVlkTjQzM1RHTTQyZFY4czV6SUxpZEJOWW9oYmZTcStpQllheTBrMlFZ?=
 =?utf-8?B?TjU4TTl2L3hSaXdYMjJyVXMvVUxySjJEOExhYkYxNXVQZCtvdkRvVUFrd1g1?=
 =?utf-8?B?ZERPLzZ4Q1pZckhZdG9qMlM3eVRSMDlQUkZTV1RJRWlHaFBxZzVjNHczbTR2?=
 =?utf-8?B?RWMyUEszSXVzWmVhU0YwdGJOekhzdkc5SkhFVHdQZFRpWkQyN0NMeElYQWZa?=
 =?utf-8?B?THBMb0Z2MHdPZG05dWQzMlJIM0xiU2lZdDd5RXRmaVR3MkVlaGJ5dUNJSWlu?=
 =?utf-8?B?TkNRVXByd0R2MmtWUEJBSjUvSzlBRG5EQWZGN0pnNGk3d2NzZUd2SzZ0cXRK?=
 =?utf-8?B?VEgvV2o4TFJ4V3UzdjI5MmE0aUFnTnZISjBXbnlzTVJLd0VoRS83L2FkOHhK?=
 =?utf-8?B?dVp0Y29qcVQ3NWlSU0RPYUJWNVh2dENtd1BCcHZJYXRWUTRNaFVqTnZUOXk2?=
 =?utf-8?Q?rq6UzaFkAByESKi+UppWwSo/4WSZy3Vpc6/UfK9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32116ada-eae5-462d-a135-08d904f452d8
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3435.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 18:36:06.0084
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/OxeF/SezXwzHBXBkgAtkpRS4oHVGtXrvQdrSbxkb6p+PV4qeKWNsY1ARPorO3YX4di78E9lcB9vddnaA9ZtA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4698
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bandan / Randy, this convention was chosen based on review of the earlier patches from Boris.

For now, the functionality will be just on and off.
Later based on interest from community and other factors, I will online the prctl and seccomp variants of the 
mitigation.

Thanks,
RK

On 4/21/2021 1:32 PM, Bandan Das wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> Hi,
>>
>> On 4/21/21 2:01 AM, Ramakrishna Saripalli wrote:
>>> From: Ramakrishna Saripalli <rk.saripalli@amd.com>
>>>
>>> PSF mitigation introduces a new kernel parameter called
>>> 	predict_store_fwd.
>>>
>>> Signed-off-by: Ramakrishna Saripalli<rk.saripalli@amd.com>
>>> ---
>>>  Documentation/admin-guide/kernel-parameters.txt | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>>> index 04545725f187..58f6bd02385b 100644
>>> --- a/Documentation/admin-guide/kernel-parameters.txt
>>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>>> @@ -3940,6 +3940,11 @@
>>>  			Format: {"off"}
>>>  			Disable Hardware Transactional Memory
>>>  
>>> +	predict_store_fwd	[X86] This option controls PSF mitigation
>>> +			off - Turns on PSF mitigation.
>>> +			on  - Turns off PSF mitigation.
>>> +			default : on.
>>
>> This should be formatted more like:
>>
>> +	predict_store_fwd=	[X86] This option controls PSF mitigation
>> +			off - Turns on PSF mitigation.
>> +			on  - Turns off PSF mitigation.
>> +			default: on.
>>
>> But why does "off" turn it on and "on" turn it off?
>>
> Maybe, rename the parameter to something like psfd_disable, then off -> disables mitigation and on -> enables it.
> Or just rewriting this to off -> turns off predictive store forwarding is probably ok too.
> 
> Bandan
> 
>>
>>> +
>>>  	preempt=	[KNL]
>>>  			Select preemption mode if you have CONFIG_PREEMPT_DYNAMIC
>>>  			none - Limited to cond_resched() calls
>>>
>>
>> thanks.
> 
