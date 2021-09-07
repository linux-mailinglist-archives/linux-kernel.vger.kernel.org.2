Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC7540301A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 23:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346907AbhIGVIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 17:08:46 -0400
Received: from mail-bn7nam10on2070.outbound.protection.outlook.com ([40.107.92.70]:35431
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1344670AbhIGVIo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 17:08:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GIyyqK4b4EAyNsqksnExa5uoW2TF2NUuIQwlg6CpmPpoStkXmsqcF9zAZZrKY2XjVMWxCY0s45Uggpqa0nJpjOOBT9f/ow1Fh3DPm3xxIIjI4FRUPuhAsym0jNiUx31sOVtYJUQhJavIN/Mv2seAaYttWwxPEcI24LjUAVfGndRcpZ+nbzzNJ4iBR6V9+/x0iWZnVjZZFuqvK8oA2LfPFIQX/FxyhxFoLQDX0vn9gZTvcOUAvrAQr17X8zaDaus86N1d2L2i4t93yJ8zXawdN0cjlEzlnk+9AxxyI92HWcelP/xrxaXtliL1f5Hgkl8RgYu32a87sdPH5aXScp2AGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=IdYsgp+KcjWA+hCk4mqDGdLRpo0uRT4j7Rw5ogIVxuQ=;
 b=aftuwszMgwB72muQexOA3tQQ/HD9/dQSJI2TTxhZ+g6IgeHMDIxs2/AVBO6ck7uZeFwYMR9y0IjucGLiTKnVjhHVRV4gOLmkcIFZJpvHIGGmgXU/tSJst8/kEWq96akhlGmPrmRxSOJf8MMBYfCxMgbu7iepeeUInpw0YidGrJP70Re7BxORbWUg/eEoNX/AEX6J/YWKQNnzO0JKktjZ8PZmXLEp9d2Xhm3vptfrc1N1Ckt+Eln06OLGbttemp5RCXj4f6JmWjG9OiE4kn3TTJDowG4+yQ0Iz9fCVy3AVoBvrmbYCNEpL2Rfead3aHOQDepqZrf1xyv9p9PhaCTG6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IdYsgp+KcjWA+hCk4mqDGdLRpo0uRT4j7Rw5ogIVxuQ=;
 b=ROA8SZycfbh9EQGnUOoagbzSuzBzBiCcbr6GLfHk2XumZWRQzWDlsic3LmxCg1XXyuvcg2Jh1h11NWxnI4c3mQuCyucXXunzEyI8yDyRtvkXBngFCTLlGe/cPMC7a9Z/dXuHwpIF8bhzLxvluKf3XnWOqEpFA3en/W1RjJhu2PM=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5394.namprd12.prod.outlook.com (2603:10b6:5:35f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Tue, 7 Sep
 2021 21:07:35 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4500.014; Tue, 7 Sep 2021
 21:07:35 +0000
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@kernel.org>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev, Nick Desaulniers <ndesaulniers@google.com>,
        amd-gfx@lists.freedesktop.org
References: <20210906142615.GA1917503@roeck-us.net>
 <CAHk-=wgjTePY1v_D-jszz4NrpTso0CdvB9PcdroPS=TNU1oZMQ@mail.gmail.com>
 <YTbOs13waorzamZ6@Ryzen-9-3900X.localdomain>
 <CAK8P3a3_Tdc-XVPXrJ69j3S9048uzmVJGrNcvi0T6yr6OrHkPw@mail.gmail.com>
 <CAHk-=wgZkQ+eZ02TaCpAWo_ffiLMwA2tYNHyL+B1dQ4YB0qfmA@mail.gmail.com>
 <CAHk-=wh37UWTqUzbh5qg_x9pFgqBVwpdq_Kf+hnB5mqEUkrjmg@mail.gmail.com>
From:   Harry Wentland <harry.wentland@amd.com>
Message-ID: <fb50dc44-fbe4-e6b3-5abc-d90375992292@amd.com>
Date:   Tue, 7 Sep 2021 17:07:31 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHk-=wh37UWTqUzbh5qg_x9pFgqBVwpdq_Kf+hnB5mqEUkrjmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR01CA0050.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:2::22) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [192.168.50.3] (209.195.106.179) by YQBPR01CA0050.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:2::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Tue, 7 Sep 2021 21:07:34 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fa19f75-1336-42f9-8d1c-08d972438445
X-MS-TrafficTypeDiagnostic: CO6PR12MB5394:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB53942D0A2B74BA58357B10758CD39@CO6PR12MB5394.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:51;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I1BL0orZz308dnIEtkkroUDwwgy7ziTujvTKfkGABTOYevV2k5NrimqiYdRVRXZmiV9kyRCDO61wWJw34vpWAfyXInb4rrUPBPHFxgBAfclVgTgBtFHJdLM1/3Ir+catJm1soZmHmEMKK3wHaGyIwRf350p7qdoM2e8sHoPMyOP35gCWqH/kaGpeKQ8BEJnlidIFZ/Urx6HGczvixh3fu1PPElJLq/0zpCZwFtqKkcbWhPUM8Xj/YeHqsjJpwDsC47hy/WlkEjJfdgN72aA/+qycNESjZAayZ4zxO208EpnBwZhi4qzLCEIsn3E/fXsLJK/H7smAPFsZpCFYvjf1dHb/7rNEx/JcY6mEx2rRpsKTpMXfwjaS0uB47CvUI3Rox1fLniirSNyOGsp1S/kQwGSjfiyiu0AD917i3FmEUhHJJ4G0h5zELrytUwT0cQyrZSodKRGxlZd/M45WoKYb6TaeZ5r1dIABJ6GcKnbMnNEuQc1u+lDOAhqDy1VQ14mnW2xcF65DddgBNpZjg23Q0MVGKINA5IXQDHZ7AEv9lw1w4V8qjxKKzWJDO9WPBCOdA4rP4+RcJV1KiddFfm3y5kmD3b8far0GhMLfgDyr8jYmrZ0ayJfRX87O7X+rqE1DmjAuROKSDk9eTWj3yPkkiC+R5svOgfkXyXLeg4q/Gs9cRsSjRkVwfk9Pp0f/EZJZh56oRzTHsQ3/fZtsWrb0u8P2MVWtvWxhVIkufZnuLBI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(31696002)(86362001)(53546011)(66946007)(8676002)(66556008)(54906003)(186003)(66476007)(5660300002)(110136005)(2616005)(36756003)(31686004)(956004)(6636002)(8936002)(6486002)(316002)(16576012)(4326008)(478600001)(38100700002)(6666004)(44832011)(2906002)(83380400001)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VU1mUnFVcjRPa3lPdE1uWUFNTUdZZFg2WFVidXhvWjcwelgxZUZxeXhzZnpt?=
 =?utf-8?B?S0ZvdGlSN0Z6U0xTSmhQY2tYTUNIdWNua2N0dkhIeU96T2dKVTA4YmU0Qy8y?=
 =?utf-8?B?eDhGemtSaC82ZlJIbGtGQk5yUHR6SnVvMFV6SjZvUFBQTS9DeXBQK3I4Znh4?=
 =?utf-8?B?YVM3VkloYWhwTDZwblBsMFpMNzBkVFY2UDRGYS9wc0VtVEtUMFNqMXgvZCtC?=
 =?utf-8?B?MkNEYWZ5VDVDeVd5UWJ6NzdSMzVuM3NFL0ZPMDExcnZpUWFUWDQ0L21vTzZC?=
 =?utf-8?B?cVRKN1pHVWlMVkJFeE9yeStydnpOd29yQTZoNHRIdFBQbmg4aW1oejRwazcz?=
 =?utf-8?B?NnJXVWNUdWtRMGNHTHd6VGVGWDdFc2t5NWx2RFMxS2IyNWJkS3ZCaDNtbmpZ?=
 =?utf-8?B?TkhTdmxDMHoyTTAvWUJiOWgvWGRaWXJlQ1dkeEo1M1BJWUpXOXJtelJWWVd0?=
 =?utf-8?B?OVFkMVF1b052M2lzUVlqc0REdTdTd285TktYcU9KM3BndzFJSkpQWUpkYW1r?=
 =?utf-8?B?eGh5a25yRktCeFlGNGlacVN6UkhPUjRjQytYUkdmeGFzaGdsZGlCY3NpVUYy?=
 =?utf-8?B?UmtmTzU3UkxwNnJQekF1N3NvMXh5eFd2Z3NKU1BzbFM0ZXFsT0FlK05zbngx?=
 =?utf-8?B?VzRYRm44bU9kWGpsMDEwalNJaldIa0Y2NkZlZTZqc1N5eXBzMG9Ud1NoN2JM?=
 =?utf-8?B?MkhLZUNuNTJEQlQvYS83d011eFN1MlpUa0dZY0xNck9WbGVEUXcrdGxGaldB?=
 =?utf-8?B?YUN5NHgxWGpObk1sS2pHRTFmSGl2eGxqQ0JjdTFwbXNnelpxUzRrbm1MVFNI?=
 =?utf-8?B?dERNeW54Zm8rdmNyM0lKUG5jTFNXRU1WYWtlVk0rcVZzQ1hMOEpvWU5QaEs1?=
 =?utf-8?B?Q3RNcFRvcmQzR0JzMzBwTUdqSkJkV3ZaRXRoUzNlMkllZTFaRzNxeEVJNkJk?=
 =?utf-8?B?UmUyeGFURFFyQnFZTnpGZDBlSnRKQTErL05ITkRHVkk5eXF0a0Y5NVNiWWFa?=
 =?utf-8?B?R3ZiSElMTWlXQSthMjhRME5LaGxhMjR3MTU3RGpjbDVVeW1rOGFPdlBBL1lW?=
 =?utf-8?B?MkthZ3dRNWphaStCSzE3RmFWUmw0OEo2N3Mxby94aGdyeUxTSkpQS29ONWZ0?=
 =?utf-8?B?ZWJEZnNHemVDSGRsZVVIZDByQXlma2g4SmgvZmpqemJlUXpBZk1XamJOUC92?=
 =?utf-8?B?VG1XdzAzdmg1SUxlVDA0VWh4bkQzMEg5NXJHQ0RZZ1lPZExoT0FEWmNoSzVo?=
 =?utf-8?B?cDhvS2pPZlBmMW5xbkJuQXdyWE1ObE53STA3WnZFVFNTQzBpMkFIWlJxK0ha?=
 =?utf-8?B?d2QwVTRnK2cwN20xeWtlR3R1cHc3eE01TFdLOXU4V3FWV1VkbXc0SHlIOHpL?=
 =?utf-8?B?MVByOUtRdEJEQzkwUkZMbmgvdEdPeXRqTklxZXkzbURsWkx4Y2lHTVlxekkv?=
 =?utf-8?B?cUtUZHhYMDIwV1BOb2VPYlVFdVFpK0NDQ3NIMkFFa1c2YUFUY09qL25mZ3Np?=
 =?utf-8?B?K0hPbS9TYlVzaW5GRG80TlBMQVRDbWhwaTlpQmFlcHFXb2h1WVNyV0d6T3A2?=
 =?utf-8?B?OXY1YkVhUTc2UHpQYkRlREpEUytwd2NNdk9Fa0dsZG5URWhDMmZqVnNXM2s3?=
 =?utf-8?B?LzFRaGVmWDRMR0FuY3hVbjdzSXlJRFZyQVRLK3oxd1dzN0JERUpBWDFEOW9N?=
 =?utf-8?B?TTF0cVMvemp1UnNOa3pabnJ3cnpjREFqcTc5eDBZazdkTStyR083RXZOVzFD?=
 =?utf-8?Q?2Jw82inMlOYJib1I7O0jtrQ2gNL7ytUq704tAZ4?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa19f75-1336-42f9-8d1c-08d972438445
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2021 21:07:35.8585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gXIHjRN9Z28Fy3tNpz74uOSFhIS3QsDJDFg1DHNwHaojIfqkbfv5XoIb+AKXAdqDOV4s07aJCJMUkzXeGPzF8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5394
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-09-07 1:33 p.m., Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 10:10 AM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Do I know why? No. I do note that that code is disgusting.
>>
>> It's passing one of those structs around by value, for example. That's
>> a 72-byte structure that is copied on the stack due to stupid calling
>> conventions. Maybe clang generates a few extra temporaries for it as
>> part of the function call stack setup? Who knows..
> 
> Ooh, yes.
> 
> This attached patch is crap - it converts the helper functions to use
> const pointers instead of passing the whole structure, but it then
> only converts that one file that *uses* them.
> 
> So the end result will not compile in general, but you can do
> 
>     make drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn30/display_rq_dlg_calc_30.o
> 
> and it compiles for me.
> 
> And while gcc doesn't care that much - it will apparently either
> generate the argument stack every call - clang cares deeply.
> 
> The nasty 720-byte stack frame that clang generates turns into just a
> 320-byte one, and code generation in general looks a *lot* better.
> 
> Now, as mentioned, this patch is broken and incomplete. But I really
> think the AMD GPU people need to do this. It makes those functions go
> from practically unusable to not horribly disgusting.
> 
> So Harry/Leo/Alex/Christian and amd-gfx list - can you look into
> making this ugly "make one file compile better" patch actually work
> properly?
> 

Yes, will take a look at this tonight. We definitely shouldn't be passing
large structs by value.

Harry

> It *looks* lto me ike that code was perhaps written for a C++ compiler
> and the helpers have been written as a "pass by reference", and the
> arguments used to be
> 
>      const display_data_rq_misc_params_st& rq_misc_param
> 
> and then the compiler will pass the argument as a pointer. And then it
> was converted to C, and the "pass by reference" in the function
> declaration was turned into "pass by value", to avoid changing "." to
> "->" in the use.
> 
> But a '&arg' thing in C++ really is a '*arg' pointer in C, and should
> have been done as that.
> 
> Of course, it's also possible that that code was simply written by
> somebody who didn't understand just *how* horrible it is to pass
> structures bigger than a word or two by value.
> 
> Do we have a compiler warning for passing big structures by value?
> 
>                    Linus
> 

