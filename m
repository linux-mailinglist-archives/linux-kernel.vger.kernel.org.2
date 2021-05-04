Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACC6372508
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 06:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbhEDE1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 00:27:51 -0400
Received: from mail-mw2nam12on2067.outbound.protection.outlook.com ([40.107.244.67]:35968
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229499AbhEDE1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 00:27:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWKxgcm0UTo8KWVVZxXPkqCOTTRbq2u9ig+ymb1tQNimpUFdygJis/WTIVMQEF2UPoV8Mca5O+br9fv6drskwTwk/XH0a+P2XsZIW/H0bUjwJMVkIzhwimeO3Rbnxid2MFaw0Yl2DqIMkGIikwhqHYA5D4RbVJ3tT9BYjbKgHAve3w6HPRTRvesD0Fn59maqavzrKSKKomN+k8oZETDdGZp/swT0htwCPWCJFqmUbQ/8gODXMS5lpdaaIdSEpum3BcIF63YTyuYGWUvoIdLrPuF2wmz26Mv72F3pTI9TLEfflCyzG164tVn1IDZ4Q6XXTYhr+bBA/04zdwTra0Uktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUmYIepkE0esBhf2GSLdA2kZOMOJ3++LYe//QDn4fPM=;
 b=XK541KtbPvMyP9NhM5N08bzIRvbiMk5tFIh2kiaNZ/qjMdLvet2A9BkEbxz5lSEwZDm9QhveY9c2TmVp+KRcoIsNITR54sygEQGSQd1rH/uszVQQ5mXBeqlMAG2Pz3pOe7K9gDHnIxKXjKsq8D/kk69svET9O9XB4c1fjnEoMXWVUrqJLVX6BM2ERB1ZpdG3uTjq6W7eSIwPbM2tmd6Ud0GmLurJKi23cvp0wmEnzjkvhOUMLwWWNOr9H1qOLDPj0J5RkSWn7GUU3MhTjstoC6Bk/kaKvqjb2Qlhr3kKrEsAG118siN8U3jR3RkkJB+rSsG5fRmLN3faNTi/Y+C1Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kUmYIepkE0esBhf2GSLdA2kZOMOJ3++LYe//QDn4fPM=;
 b=hVDolxdtsiHa4gR5woRbiSvDFm05xUyLxL3+xLKvS2kx4HrAxCE9hjsmnHc8TkZQTnu2uXxel/ow8QYuIETE+vVyr0E8t6Dl4TbvcDW5yAU5s+eau6BdCIIBPApxSMZO3mBiwac4P5ESas+Kuz/JdnU4sYozSJT1WUIzCdqfBNo=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Tue, 4 May
 2021 04:26:26 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.4087.044; Tue, 4 May 2021
 04:26:26 +0000
Subject: Re: [PATCH v3] tee: amdtee: unload TA only when its refcount becomes
 0
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org
References: <5057c53afb568fa70234de2f23b0ffeff75af426.1618421014.git.Rijo-john.Thomas@amd.com>
 <5072c20c-7912-4307-6e04-caa1fe54bf1a@amd.com> <20210503114734.GI21598@kadam>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <01387b92-263c-edf1-52bf-b2244ebbd311@amd.com>
Date:   Tue, 4 May 2021 09:56:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210503114734.GI21598@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MAXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:49::32) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.146] (165.204.156.251) by MAXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:49::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend Transport; Tue, 4 May 2021 04:26:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0538c6c0-f536-4597-9842-08d90eb4c7f1
X-MS-TrafficTypeDiagnostic: SA0PR12MB4397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4397954A0C86BEC94B9CDC91CF5A9@SA0PR12MB4397.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6/9Z3RmRBN5zSCyT01eO/NGDZs/z09X0upDylwTznkgbHt7FTFLE9QL3PwYtKBWpNcqoVG4qSIGKQaVgKK7/2F9dCCcR4Rws9PLG+0iJ2Dst4NM17TFP5+NoRIfbsqgBN2vTfC6s2psufoytQOndG/jg7dhMDriUlMtj7DclZTY4JONnuiNXLLEEAw2UQKX12+r1dVkTz8Hx6QknaB0Haz2uC5EpcAEWkYqEmVpSFt64ftvOc8249s+EUdjqqyyyDULyMpxwon4SR57i6RRw0vj5+p6dOmGxGT8o/7LmuZYsfsIN7WMlb4XgD0VY/O42gPEnUTkPBleoGwl/AG+4DvesZqHtT7qhyYpG/LVNS0Kc7HGKvkRC/EAoCiICfgj+mU1OlNWmbux1cAD9WxAvFWa9G6ttzMa/L5a+d4ghOZodFclRx8ee0bpRS4n8gWOYcX70IZtzdAiWGgwXeOH5e7mwKcFaBofkeEj50jnIHSE5gvoYYdiDBlrmZQ4FMGLKW4izhN9KoJix9Y88LWvFZ2FL/0G/HlqEYvFSV0yAnhwdUwIE/+he8QMnqdE6DttaFJdSBoAXjyD0lCAvnpVW1hNqnDqUPUsPgnVSHMA7OlohOsUsRHslWj9uSDXjTDLZW14jz8BDB4t0NyipkuOjF3+IfVkQhpLxB8f+mMPRON1OWyVEIezdBlfDC8QVM7cZXTI/RQhXGoqeoLCrS5nCWPiyt6WyXFf87HTVQe3Pko=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(5660300002)(66556008)(6916009)(186003)(31686004)(66946007)(16576012)(6666004)(6486002)(956004)(4326008)(8676002)(38100700002)(54906003)(316002)(8936002)(38350700002)(66476007)(2616005)(36756003)(2906002)(31696002)(4744005)(86362001)(52116002)(16526019)(478600001)(26005)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?eWFPaFBwVXJPRnorMXlRWEszbU1HbmhPOERVL1J4VDIrUDFpdmJMUmFmWlZh?=
 =?utf-8?B?empabm44WjY4WDI3STZkOE9mN2xrTUtTK3UxTUYrMG02QVFIRTRXVDY4V3k1?=
 =?utf-8?B?eTI3R3BhRldnUkZKTUkvSmtpTmE2cVBJM1VhUWFxdExYbDJRWXh4eERFRW9q?=
 =?utf-8?B?NjBtZk1BT29FaFVzL0JncnNZeXVsYytEbEhib2w0N29ITW91TVJ4QXhtN2xs?=
 =?utf-8?B?YUlEaWRvMmo2My9sVHVpa05LYUxOODFSVGJZV095SndRNFFNZWV5aUh3NDBC?=
 =?utf-8?B?ZzM4UEI0dU1Ca2g2TDRvQ1pQT0JzZkFFNVlXWEtTYlNKNEJVVTlNMGRKSTdZ?=
 =?utf-8?B?WnlMV1JNcFA5WWdSc3NFZmwvcGVoZ0hMUllOd2o2OHltRlhBdnU1TnQzV3la?=
 =?utf-8?B?UWhwRDRiSWw3WmoycmxLWm80RXdKdUJPNlEwbFBLemJmc2hIOG5JaHltQWgv?=
 =?utf-8?B?Y3Y2NlY1cXlYOTBsTXczSmhraUdvdkJ1dFBNeDJQQ2pRTXNaTHliQytvaFFw?=
 =?utf-8?B?NldhUzRSMkw1TVBWY1FSQ21OZFJhQmVLUktYNnQ3cTdpMkNwclI4YWxDelph?=
 =?utf-8?B?UEgvYU0yL2dpT3Jnb2ZFT3hheFJkY1pkYUJlSzI5QnpvUWpPUWF0UlNxUXI2?=
 =?utf-8?B?cDVuTFBXRHcxRlVBeGI3UHNwenlxbU5vM1IyekEvVWExeWZMRVR0TTFIeEow?=
 =?utf-8?B?QmdkU3Zqb3FFMnNYRTdOZU1MejB2dTJVT0dEMTR2QnQzeEZkYjMzK2VYTFF6?=
 =?utf-8?B?TVJBM01UeUNQcUx3b3IrOHl1WkFIRU1wSVZxUFhOYWtYL2lVTEgwcGkwWWRu?=
 =?utf-8?B?SkhvU2F2bmF6aGJCS3JSVEJKLzl6YlE3TXB3OXpNdWhBTGRMeU9LQmsramRm?=
 =?utf-8?B?WGt3T3JTb2lXNXZhcmNVY1pHc1lmN09jV3FQT01PZ3FhZFBkQi9KL3pNeStv?=
 =?utf-8?B?QU9pR1FJZ1V0ZHMzWEdQS0dCRUxEUmdmT0FxM0hqcWlmMkkvUkJIcWZURjR1?=
 =?utf-8?B?by9saEF4THVsbC9uZEx4dDlPWkd6TVEzNkVmbk51eG9iZVYyV0VJcG54NHZv?=
 =?utf-8?B?YW4rU0hiYkRZMEs3Q3YwN2pENW1QQVlCVDdHQVNaWUowYWlXaklFWENMV2tp?=
 =?utf-8?B?Qm5PQnRhTzFPREtLVHJURnVDRzA4OVQxVlFTUkFxS0NlVkpVdHRmSWVoT3FH?=
 =?utf-8?B?SXozR3BQWVJIT2VSMENpR24yeTB2aGdoSDM4aWlqdUpSR24yR1l3R0Jsc3lN?=
 =?utf-8?B?ZGZXcUl3aTNxZHdySG9TckRMSTZTY25JTWpFQmZiWW1LZXVmVVJTTzNveFRH?=
 =?utf-8?B?SFNCa3lPd3lpTllHTFNoTllyZEJDVDNINFdXMTMySWlnNDhZc3dFbk42c3pn?=
 =?utf-8?B?Ymd4dzRlSFlEa25lZnlhWXEzUHFtdXhNd09iRWhhY2hPblpWejVFVEYxUHZR?=
 =?utf-8?B?V1M4VG0veDNRRHEzczV3R29SR20zNGdrOGRVOXVvWTdzank1d05HT2RFbkVL?=
 =?utf-8?B?eDdqYzJlM25yOHBmcnpPRFlZOEFNODZyS2hmUEN4V2hiV29nU1M2MFVmR0Rs?=
 =?utf-8?B?V0NQNno3bVB5NUVEeHRjRnBhbkFnRCtNQkZaalFhdVI2R0FnOGVjblJJOGpW?=
 =?utf-8?B?Y0VsL2hxa2NLMkpYbWJDWDJuaUgwdjhmTVBqaHFxeHJDUHc2YWpBRFhQQjdC?=
 =?utf-8?B?S0IvR0plaTM3Wisxdm5NR0x4a1FPcFNyekpqbWNaK0JGc1hTSExlelNUSlBk?=
 =?utf-8?Q?gdv99uRWHca30VapnY0ySWxvJLD1y9YDOwjdd6Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0538c6c0-f536-4597-9842-08d90eb4c7f1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2021 04:26:26.3195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ew47dVCx7oTfxoWm8lwHgaPkatFLb08cDeGU+Mv6leo1vyX+9u0q86QDrUq63gQol9P++6zAvuMqYYOopLrAiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/05/21 5:17 pm, Dan Carpenter wrote:
> On Mon, May 03, 2021 at 09:04:35AM +0530, Rijo Thomas wrote:
>>
>>
>> On 14/04/21 11:08 pm, Rijo Thomas wrote:
>>> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>>>
>>> If it is a single instance TA, the TA should not get unloaded from AMD
>>> Secure Processor, while it is still in use in another TEE context.
>>>
>>> Therefore reference count TA and unload it when the count becomes zero.
>>>
>>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>>> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>>
>> Hi Dan,
>>
>> Can you please give an Ack if you are okay with this patch.
>> I have incorporated your review comments for v2.
>>
> 
> Oh, Sorry.  Thanks!
> 
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>

Thanks Dan!

Jens, can you please pull in this patch.

Thanks,
Rijo

> 
> regards,
> dan carpenter
> 
