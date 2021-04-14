Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E7CE35F9F8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 19:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351118AbhDNRiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 13:38:00 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:36673
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350752AbhDNRh7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 13:37:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7PR5xWJlerZ6ls5FfqgqdDe6cy4tzurKxikvjbxhPP0l7XvnUsFMAWzhqba8Uqa69s77VnOhGb/oHS8u1h9+dkfFA6/HYKSBcopnWBwx7EvfzAf3leL7UyCmHRjcXDZWsO5j9LM/0mSV0Wrm4982SPb3yaDf3y8u/wSNMcH83dvuRp0gVvw+eEmKZznDizIIhFC5wk4273GuXitxjJYOdcu30Iufmcun8YK4ejNd29FrhdyQZxJ6qwRQOTNJdwuf4wgFU5gjIvYSmJAr+6j35yVX5fE9cZtKPTgsjgs0hvCo93zCAWc2n931tUwBDShUEQpU7X4yAaUjWE9raLAkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgZv9M5b5lNJj3nKi57t+5/5MoOKX0fCxzwS8n+M0D0=;
 b=SwIpR1oyDNOAsHNbieGVjqTjEnUJYM7MaqfYdcWBPCpVBs2OY+wyW0wH/b/OtMumjhV7AAVo7CF92V4ctQZCeR555zCyQVsVHPe4K3E1qIacLO6omHXMFLJnlaaNb9qkI8pXH1uzU3KfFpGfg5WCICs1wZXk4wdXdMWBLNaxqSnhuBLK2KlWTY2iHBPMAMGgZKeaSJiAF6OxvakjnD4ABpS1w+GnzieBnW+l+ucWGW8+RbTqFJTSWOKrRxkMgeDSJQGKOg9CqdYp+8OWC4t97SZv0S3CwRyhM6bPFq98YEZu9AD1pNPP1f5zKY+XOfAxT09nLHfXFCn5zMCb4ePVwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgZv9M5b5lNJj3nKi57t+5/5MoOKX0fCxzwS8n+M0D0=;
 b=H0RsRp5D207vcf3Vrv9ZsB48urhSusjgPHKQnX+UVNYK1sNG8JQGa3eqiTS+nlvZXyWXzbbehs4WeF38uJBJdNCHtMRWfB/TfCsapq1R8PtofoJtN1zC4Chsy7xPM5jw/CeJj64Zqsu6ZMFYvwl5niEiAig7lA3okbIo+vUnCss=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4719.namprd12.prod.outlook.com (2603:10b6:805:e9::25)
 by SN1PR12MB2350.namprd12.prod.outlook.com (2603:10b6:802:24::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 14 Apr
 2021 17:37:35 +0000
Received: from SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b]) by SN6PR12MB4719.namprd12.prod.outlook.com
 ([fe80::6999:4ad6:8648:9c8b%4]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 17:37:35 +0000
Subject: Re: [PATCH v2] tee: amdtee: unload TA only when its refcount becomes
 0
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Mythri Pandeshwara krishna <mythri.pandeshwarakrishna@amd.com>,
        OP-TEE TrustedFirmware <op-tee@lists.trustedfirmware.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <3150feb19421ca6b15202c853215f8b40fe35567.1617615067.git.Rijo-john.Thomas@amd.com>
 <CAHUa44Gga=k3indU8FC3X5xE=6RnKEDNeZBDWeJzm47-Spm0QA@mail.gmail.com>
 <1318f015-40cb-2bdd-17fb-2a3843ed45bc@amd.com>
 <CAHUa44EtLazK8YezYCV7_oGxfarsXv5CfSivqiBecb7=LrYYqQ@mail.gmail.com>
From:   Rijo Thomas <Rijo-john.Thomas@amd.com>
Message-ID: <1cff3f32-7a12-fbee-80f8-201433849f5d@amd.com>
Date:   Wed, 14 Apr 2021 23:07:21 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAHUa44EtLazK8YezYCV7_oGxfarsXv5CfSivqiBecb7=LrYYqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.156.251]
X-ClientProxiedBy: MA1PR0101CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:21::32) To SN6PR12MB4719.namprd12.prod.outlook.com
 (2603:10b6:805:e9::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.138.129.146] (165.204.156.251) by MA1PR0101CA0022.INDPRD01.PROD.OUTLOOK.COM (2603:1096:a00:21::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 17:37:33 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6c1e310-5bf4-4427-4d77-08d8ff6bfd98
X-MS-TrafficTypeDiagnostic: SN1PR12MB2350:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2350D03AADF328BA27765AE9CF4E9@SN1PR12MB2350.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sJdgitRQII0WUMSPxjDjLtsLodpmN6nXw4ITWY+kpYYZSU0oVS3/BCvsOwY/obD3+StzbOzK+aBHLsntax353j4o8W9lp/uyliZ5HkJwsQXxmYmTyPLqAMGW5JhlSyKkvcX0GB4q7QNMMeyAh9BqhByg+7qmVqmV9gIv5B6h5OUVXuJdGaQ0B2J9fiCeHBCqWxim+bJU2zrGI3Mv4E5F2D+Xkc21/druprPAW87RX/AxzEr8z8sX1JcA/Y5WG4zxn46lCeVbPlZPLG8yGbvu/Ht2dXIyLlUDDpfofQehLjeJtrsP4WcuAFP8CFf2nig+liPIbgP3l9fDyfz0zX9r/1V/xAGjFGfhipXdTUtQLXA0RR/8QqAkz17hYLbeoJClkdxeDMorbSWbPENjyBD5JQWw/aQy0bHMSvz+K0IVPeY+UhW+h+sky/fK1ypWQhMlph2nALRHwuADCqUpd8sLUKYcdnwAxWDF3Lt8eB9qaY/WgZxnBYFwT/d5Gdo0P6lyEqq4HVWWaefoNEkeWJe6nEszvE5ibakcygTjUMOvr95IYHXMzWUDZPxfx01UzeOWFWeYX53TjMv1DjfykIHMDU1aARb1xoG3ctGq1v3pD5EUFwXEngJZ12e76bKpZYKE9xR0zTPU0Wk1V1fuAxPdNPo1frt5y2bBW5M0Mhu6wMhVpasL9c71R2v1N/KntyQDCYCx81JGb8+C5q6p0s0GPA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB4719.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(396003)(39860400002)(136003)(346002)(376002)(186003)(16526019)(956004)(4326008)(66476007)(6916009)(66556008)(52116002)(31696002)(6666004)(54906003)(53546011)(31686004)(16576012)(316002)(86362001)(2906002)(6486002)(5660300002)(8936002)(38100700002)(36756003)(2616005)(26005)(83380400001)(38350700002)(8676002)(478600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MWVrNjVCcDRQRU9uUlFCSk94VHZoRnk4OWtLbDhnYVNWd3BLZkd3K1dWL25u?=
 =?utf-8?B?a3FzMy82S0JaMlNYTEtkb0N0YzI4Y0NCcktJWCtIMjJkb1FyeUxzZFhyaTFO?=
 =?utf-8?B?ZmYyeDJGaG1YRlJQMFJqMUNQTnhsSWowSDV3WlVVTmNDR01ZOUtmN3pxVTND?=
 =?utf-8?B?OHUyOGsxU25CWklFQ0NGY0VYdSsyREd0Z1RlMDk4THdodFVaZ2JTc2V3WWRF?=
 =?utf-8?B?TGRiMGRENWhtUTVwcUZ0dEx1VU14ZUR3M3MxK2tvRnFvY3o2NXlxYWtpbmVT?=
 =?utf-8?B?aDQyb1ROanJwQkhQUkJ2Q2kyb1lNbWp6MXBicTcyekhqWDAvQ1B1YkxnVnA3?=
 =?utf-8?B?MFYycnJ6MVVxM1pQS2s0VmZsRk1sZ2lqRWR1OE1BT2IwZlk3NVZSSXNIWlE3?=
 =?utf-8?B?Mk8yUVpxSjJQMmlObWtVLzBRbUtURGZZZkJhVldyMzJBeXpDS0NKenZmbjV4?=
 =?utf-8?B?UkFjVkhwaXJKdkRQRWt5clJVRzJvNzd1c2ppaFhQNVhkejZ2K1J6bkxxRjRP?=
 =?utf-8?B?bkxyN2JQakJwQkdxc3pDZjlTUlJlaWR4d0dmY05rSE9DS3VzUHJTeWtKdDFY?=
 =?utf-8?B?UGtzUW5xRzE0clZBUEpzdDNRNWdrTlR4QWxkb3Q2Ymd0ek1Da0VFMXp6KzlJ?=
 =?utf-8?B?dzFpMjRjWld5d2RwS1djd1BWTjRUVlZub0FrTzI1cUNLRXd3VkorNjlEZEJS?=
 =?utf-8?B?YWJ6S0dIRDd5bDRaVklLYVRwSlhXNmM1amJNZENZMFBNelM0NHNLUENqMndJ?=
 =?utf-8?B?dEUvL3hMK3lBZkRVcUhNN0RNZ2ZsYjQvZVJCSVdZbkxJTmc5YUxoTjRhV3Vx?=
 =?utf-8?B?UEUwUjdoVms4d0pFWGVQSEtPOU5MNWdKYlhGS25JZWx0UmJnWklYbDY2NXhQ?=
 =?utf-8?B?dEIreWVSTXNZYkRrR2NFZHQyUWpub1FGZWdTZ0UxUVNNZ2YwYTd4anRVa3V3?=
 =?utf-8?B?SncvLytPYjZOMFIzNTNRcUt5YmtJVm42MDZmYTQ3SmFKRFdQRlVmTkdHUGUy?=
 =?utf-8?B?VWZnY2E2OERGQjdmUThrT2pYQVpOTkJRS1Q3a00vWFJDQlVqVDFWU09yVm84?=
 =?utf-8?B?UndQdVlYd0hOSktPVUFUSFhUMDN5OG9xNHhvQlA1RDdmUWxZL3JrMms4OVpk?=
 =?utf-8?B?NTJtZzc1M1hEMG1WTnVWWWU1K2ZQUi9wQVh3Zk16RTBNU3hURzhZci8xK3Jh?=
 =?utf-8?B?NTVEZkUxRk9pMG1VOE1VaHRVdUd2ODZhYWZOT2Z5RDNXY0w3OEswYUQycGZI?=
 =?utf-8?B?aFhrdFpNR1NWR1FMU0oxVzBqM2ZvdFFYR0pPcS9xMkdDMlZkZktEemVnVkty?=
 =?utf-8?B?ZTBDekl6SDVSL3gxbzdRUjRKOTFaMnprcDU1SGZDdDI2RERVWG1kSE1TYmRk?=
 =?utf-8?B?T1ljSUtvajQxZldxVzZCdmRGQUQ4aXBwMC9vWFkvTlFPQmxjUGpIVVlraEI3?=
 =?utf-8?B?VjYzVjc5MG8zUHlkZ0xoNGZ5L3FqSHlKOHByaldybEl5U2hnTjJSZCs3VDkw?=
 =?utf-8?B?R1BpM1hNdUtrMGh1YlhCN3g3VnZmRVlNZmJLNlZtT2lGMzcwYW9QaHFLL29W?=
 =?utf-8?B?b3M0dVNCd2pBVFVsS2w0dEFpLzhRYWw1bUlHMW5Db2VVc2NyR245Y3pYaDQy?=
 =?utf-8?B?cmdHaFF5NnRYQTdiMUhHM0NRTG9HU0hnWURkd1JIVmZLYWg0L0pUZ0Q0enAx?=
 =?utf-8?B?Y0orYWZWeUNqS0ZIc2pUc3Y5bTY3Zzl4SGZyYW5EVFFoL3paVHdJYzd3ODBJ?=
 =?utf-8?Q?AyUioALK3F0C8pNpcB0+30aCs+6KaHV8l44gzA5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6c1e310-5bf4-4427-4d77-08d8ff6bfd98
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4719.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 17:37:35.6924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QXwTB0vOmjrDxDoIfoodzYFHd5rLVAMBMMZzYl8JpwOdEOXzOe1T7GCL0J/bXGRtL9K/pTYzjm8d6abbs72W+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2350
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14/04/21 10:16 pm, Jens Wiklander wrote:
> Hi Jiro,
> 
> On Mon, Apr 12, 2021 at 12:20 PM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>
>>
>>
>> On 12/04/21 1:06 pm, Jens Wiklander wrote:
>>> On Mon, Apr 5, 2021 at 11:43 AM Rijo Thomas <Rijo-john.Thomas@amd.com> wrote:
>>>>
>>>> Same Trusted Application (TA) can be loaded in multiple TEE contexts.
>>>>
>>>> If it is a single instance TA, the TA should not get unloaded from AMD
>>>> Secure Processor, while it is still in use in another TEE context.
>>>>
>>>> Therefore reference count TA and unload it when the count becomes zero.
>>>>
>>>> Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
>>>> Reviewed-by: Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>
>>>> Signed-off-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
>>>> ---
>>>> v2:
>>>>  * Unload TA if get_ta_refcount() fails
>>>>
>>>>  drivers/tee/amdtee/amdtee_private.h | 13 ++++
>>>>  drivers/tee/amdtee/call.c           | 94 ++++++++++++++++++++++++++---
>>>>  drivers/tee/amdtee/core.c           | 15 +++--
>>>>  3 files changed, 106 insertions(+), 16 deletions(-)
>>>
>>> Looks good to me. Please address Dan's comment.
>>>
>>
>> Hi Jens,
>>
>> I have replied to Dan's comment.
>>
>> If you are okay with the current patch, request you to pull this.
> 
> By addressing the comment I meant fixing it not just replying that
> you're going to ignore it. :-)
> I can't see any reason why the preferred style shouldn't be used.
> 

:-) Sure Jens I will post patch v3 to address Dan's comment.

Thanks,
Rijo

> Cheers,
> Jens
> 
