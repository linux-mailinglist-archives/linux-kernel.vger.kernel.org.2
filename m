Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9245AEE7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 23:16:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231907AbhKWWTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 17:19:05 -0500
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:5312
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231304AbhKWWTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 17:19:04 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3gbZOPKSfeicRTl8aPiVnOjr67SmibVKv2KiZKr10/KuKy3x+P2vWtir9expyErErK4obJ+WRYnkb9imhC4/Ae083YXPv7hOsDSxEdD4pts0ohHLuVVIXm5w4cBzadAkN3omG0CPAasDlR/H78ytrZaRJhGYlHfJu20WYKAv6v+snE5WN+HqcaZOe/8JU/WSbMpiqrRdu8UYlE/c+PJCNXOThWg2CGcLff1Ea8PQKdJxV1Wonn4sTws1B+dQB/X7QzSP8WmCp2y1WGxctXgv+mPqvKONLr3kTD8upzRxuFVhyurHMGwMBUp2TJ8vEStONUbR1Y35yZt+c6y/R8shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SBwZu87Le7NhAcApuc/GTxbu8o5btQcd8iWp9x4V2+8=;
 b=BZgmbSs7TKAxJYAXRMUEyNe+o5vNZ8ojQHIvcMaMZ1fr50SoEHfjSGvnBNh89BQZ21+NeZ9+M79d5X/bm5QOAhvACfVwIGS+G4D1UoX/jLGQ7dCNJkF63EbIJU+aGbMH28dQAgJ+x+/8G9wZLJRxcRJb59iN1BTM9dFEZkwPhYyZw7SoKVhzsqknYqED5V5RQQSf2kM3feo8a9DnWwOSkDyROfurLvB7Ok/7RXilFgy1/5/fuck3UydAUUrTUm81qDW3Pf5jOM51kKeDmZwgEuL63srmylePCcof8sjmVcYgoP/VwVSvgbrsPVuqKDkBt7lm/xbB3YQoO6rhQQz4Lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SBwZu87Le7NhAcApuc/GTxbu8o5btQcd8iWp9x4V2+8=;
 b=T7dpb9LL5QiSUXlI35JBHLiKbfWh/RrOrElHvh3jTPuUH8E7JdiSLDxC/O3CvsjnqO/iFbai+9va9oXdX4aKV8qzxGu/uSihUDrhwRz02SR9PP5WpF6iRq4/SJt15EaAKZJ5GCeHvrxdkSuVhtE5UVQIWnx3CprPgKjGWcVQ7Tg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by MW3PR12MB4556.namprd12.prod.outlook.com (2603:10b6:303:52::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 22:15:51 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::d9d8:7051:7185:6c3c]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::d9d8:7051:7185:6c3c%6]) with mapi id 15.20.4734.020; Tue, 23 Nov 2021
 22:15:51 +0000
Subject: Re: [PATCH 1/2] hwmon: (k10temp) Move the CCD limit info inside
 k10temp_data structure
To:     Guenter Roeck <linux@roeck-us.net>, clemens@ladisch.de,
        jdelvare@suse.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
References: <163770216907.777059.6947726637265961161.stgit@bmoger-ubuntu>
 <937b305c-c61d-e754-c86f-7019b57dd737@roeck-us.net>
 <6e22cf38-39b6-6cd4-1435-c9a9f2e50230@amd.com>
 <b5741cbd-f94b-a405-72c3-699338d6a232@roeck-us.net>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <079a55d3-321c-6b54-fa55-8df1222a9f3d@amd.com>
Date:   Tue, 23 Nov 2021 16:15:47 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <b5741cbd-f94b-a405-72c3-699338d6a232@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: BL1PR13CA0021.namprd13.prod.outlook.com
 (2603:10b6:208:256::26) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
Received: from [10.236.30.47] (165.204.77.1) by BL1PR13CA0021.namprd13.prod.outlook.com (2603:10b6:208:256::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.16 via Frontend Transport; Tue, 23 Nov 2021 22:15:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be84b291-d871-4d68-3e1b-08d9aececf0e
X-MS-TrafficTypeDiagnostic: MW3PR12MB4556:
X-Microsoft-Antispam-PRVS: <MW3PR12MB455634F41B152D2B6D1E94D995609@MW3PR12MB4556.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xc3SIzJjU09pUDEr260C6Ksz96kl/nkNzkT5u5LLVHoAZzEQ+lT7P4sAMxefJ+AGKXEM6EiGLSOgRo0w4XmTcXe4m3DSQJiVkR1QpMaNsor8zbRUHT23HRAjV7y3uwU6id/uf+Up3tQf0sRxTW6HVpMXgz5VKJsZP5lgMyqsklMnyuK7GdH+p9qfWGOSpS+MOw0S+eHONjG3rEqjtyNk7F7dhtvjciKdN8dYCvFqz8m6Yq8MUGqW1URtczk6HKqQ3GHKEBHg5/e27ZcREjwJom+88B6WughWScO1iQhYrBNZ1mVxNfwE5/VSbAkIe1n+7S75RP3tb6h87+Lo8ukbAAkSMZ6yZidp4pK2voADUbcqTbmSW0DjQAMvccoXNhilrguz9rXtEG6gGHchZxfmUs8dLwQds6aQFGEimT2FP0U2Z7duqS/WWbj0DjTLHB+H/VXqr4GTWq4Rwh1l1JSO+ugEb5fTwa2iTdcR80KCr9i0XzAzjuDCbztCQoRNikuZP1CVIlVNVM2NJUPAnUHga+nifC7hClMb2BtXQlT8qGo9xi2ngvdJyef2O5WJLapPbL7U4hbMcRjhxjC/lNpU3RJ2nHWrD6RIxngAQ9Nd8b3DkrivjK+SsmMVbxHWyGjc9L+B6BOGemUQXl1+wyZEijgPB1YczrGoISm+bfmf92D39qeggsN4tHrPAI0w+BWvnwgWP5KHM33waika8V/b7LlrNKR5QMS4GvB80zwj9Pk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(53546011)(31686004)(508600001)(5660300002)(2616005)(36756003)(38100700002)(186003)(86362001)(2906002)(16576012)(26005)(66476007)(66946007)(956004)(4326008)(66556008)(31696002)(6666004)(6486002)(8936002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndGUjhRUmtFdGZMcVBkcEwwdGMrTzVPR0d0QVIwQmkyMU5UY3hjMVA5RlAr?=
 =?utf-8?B?ZFkxV2RneDIxNHpPZHcxa1RyZHBrS3pNcWhYeXdVUWhHaGpGQzI1THpWL2cz?=
 =?utf-8?B?R2kzb3ZtaFdhQklPUnI4bnRCRFJ2enRqTHBqc0lNZE5NbGNzMjdSWXhDdi9K?=
 =?utf-8?B?Y0pXNFhqSFlRRHZTT0pFbllPUjhWT1ZPWi9lNVc1MzNzWDM3a2FWT0Z3VHI2?=
 =?utf-8?B?NmlRTGxTVk5rOXZKdkV4eVU4VDhhcGNnNGlmdmMrL1E5OXhJdCtaelBTL2la?=
 =?utf-8?B?NnVYaEJBcWpiSXd2OUZSc0wwZ3ZUUXdvUjRZYTZQN2Z0Z29xWmZoNGRWTnhx?=
 =?utf-8?B?RTYrbmh6Umh4QlI1eVc1ckRYZDdvS0JmWVdpVzRHMytFQW9PNVZBMnc1ZTV0?=
 =?utf-8?B?a0tvRU1GU0k5V2Fhckd2RXgrdVY4QWRMYU9MeCtvOE5QaGRuMTNMQk5jK0w5?=
 =?utf-8?B?UjBJdHBiWURXR254RS9aMGozN3dZWWN1bEZKRkllbW5rZnB4MWNiYjVyekxK?=
 =?utf-8?B?WU13b0Z2eFk5WVRRWG9yZm1LMldTYkdPL0d0YVM4NkQwSkFYeXBmUTdpR1pq?=
 =?utf-8?B?cUMzYWVVRnRCODhVdHZaRzk2bmllaWt1KzVHMENyelVwemRzUFpORENWUThS?=
 =?utf-8?B?dVllZGp0bmovTXB2RkVGT0lQSzJHNllaYlpTZzRoTnY5NzFBdWliek1tZ3Rx?=
 =?utf-8?B?bFhOSWp0ZG1LdVBteHk0dkZSa3dMYmE5YzJlQ1loUXUxb1dyblpmVGtuQjhh?=
 =?utf-8?B?T0pQdzdkcnUxMldrT0lJcEI3c2lQUEhMTS93MEFmdlA0K2txeTVDSzlpK0VK?=
 =?utf-8?B?b0MzbzBYREZFcU82RW1iVE9PQzNwbloyUitEbHNlNlkyZ25OaUZTQmU0RStV?=
 =?utf-8?B?NVdlMjcvU0syeUJiVDVmTWFGZE55M0xHM3FkQVM0V1RRNjcraG4rWis2T3hT?=
 =?utf-8?B?UE9mYmNGZjhBejhFWlN4aVZ5dWY3R1Aybm9rT21GR3VOZFRaRUQxV1QycEhP?=
 =?utf-8?B?OFdsZ3dLWmZOa2srcWdtM0lFRk9QcEY2MlVZV3lxSDBsb29tVGg0SUtLTUhG?=
 =?utf-8?B?T3VzcFNqTXNpUzdRcVVsczlXRzViQno5aEdXcW1ScTVKQzh0dUlxaE5lU3c1?=
 =?utf-8?B?cWtvQndXMHRzWC9iVjVFdE5XK2s5ekFUMmFFN3FjRHdKUVFBRUo0QUtDY256?=
 =?utf-8?B?ZFgxNVBsTG82RHBZTlhncFJHbHNBU1cyRFFOMWVLWjN2Q3ArbEh0UFpoTlpG?=
 =?utf-8?B?a3FXNmxobkNvY20wcVh3N3lJdUNUMDVMSE00TXcvak1tc3ZyKzQrU05OZnp0?=
 =?utf-8?B?MWdrMHd4SG1RM01YMFFMdmlEYUwvcXBiTWNQeWZxZ3NRMW4vTzFjR0ZTMUlI?=
 =?utf-8?B?RU9KdVBCY2tIUDFKbXlwWk9sY0hWTVAwT1NvRXlPN3phbnR0aUY1ZUdhcU9X?=
 =?utf-8?B?dU8vNm1WNFF5Q3ZKU0RRZjNzUUIvL1UxRmIyQ0U0eUVwYkRIUi8rdGVreWFW?=
 =?utf-8?B?anQvUXI3My9XUXRKWHdnSWlnU1NFTy9zZUxvaGpnNk5hdmRoWDVQMzlQME5z?=
 =?utf-8?B?dEUzSjUyTlFmQ0g1ekNodVFFZ0JJUCswTHlRQ3VRcUxKdXBXQmZFdWRSb1Bu?=
 =?utf-8?B?dGFKM0xpWlVkTjEyTDh5YTlMeWJSQUwxZUNhWGYxY2t1SGE4VmE0NXE1bUxj?=
 =?utf-8?B?T1pvYzRqS0lES3J5S0VVUXd4RCt2NGxoQ0poakxnZjV1SS9oRzJOZ0dFem0w?=
 =?utf-8?B?QnRKYTFZWU91SDVZUiswVDEzL2dZZ1JsSllGRWhlWUVTaGdzVU44a3V1cmJS?=
 =?utf-8?B?VVZzelplcDZKaDV1TDhFT0lqYTVQOEVFeVAyZXJVc2R3TTVwRTBoclU4L3Jj?=
 =?utf-8?B?cDhrYndqTW5FQUxPcE9nNjdUajBMTnd3ckJhaVFoM1Y3aDA0VGRubm5VK1gy?=
 =?utf-8?B?V2NWY3dOVlBtRk9IbXlsQjFBN29IUWR1MVV3NTVDNHBCMlV1SmxUa2F0MjV2?=
 =?utf-8?B?VmdjaEFleW1SRGNkSUpXUzdZSXJhVUFxMGhoU2FCOXFQdU1JTEhocU5SZHVV?=
 =?utf-8?B?MGFnTGVNSWxZSXYrY3NsZ0N5cE55QlhhdXdDWld4RUlCVDNwS0JzK3BoWm5u?=
 =?utf-8?Q?BaWc=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be84b291-d871-4d68-3e1b-08d9aececf0e
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 22:15:51.2418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9FUNMAskpZWXxvFL0/FPc7qXNJmq38+00/wTuG3NY0eulpJceTsp+UZA7s+1NWX8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4556
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 11/23/21 4:07 PM, Guenter Roeck wrote:
> On 11/23/21 1:52 PM, Moger, Babu wrote:
>>
>>
>> On 11/23/2021 3:40 PM, Guenter Roeck wrote:
>>> On 11/23/21 1:16 PM, Babu Moger wrote:
>>>> It seems appropriate to move the CCD specific information inside the
>>>> k10temp_data structure.
>>>>
>>>
>>> Why ? I don't see it used outside k10temp_get_ccd_support().
>>
>> Thought it will be cleaner to have it all together at one structure. If
>> you feel otherwise I can remove it.
>
> I don't see the point of having a value in a data structure that isn't
> used anywhere outside probing but nevertheless lives forever.
>
> I also don't see how it is "cleaner" to assign a value to a variable
> in a data structure only to dereference it in a single called function,
> when it can be just as easily be passed as argument to that function.
> I would call that just the opposite, since it creates the impression
> that the variable is needed outside probing when that is not the case.
>  
Ok. Sure. I will remove this change and re-submitt.

-- 
Thanks
Babu Moger

