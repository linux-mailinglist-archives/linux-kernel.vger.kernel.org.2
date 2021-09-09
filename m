Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5EF404262
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 02:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348871AbhIIAtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 20:49:53 -0400
Received: from mail-mw2nam10on2050.outbound.protection.outlook.com ([40.107.94.50]:11521
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348785AbhIIAtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 20:49:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b5rElIJ59YqVKYQMNJMCoRGFfnZ8yJg2nBcHH541Qo8lADVZw6a1ERgfwMLjL9istlPme5CBE8g4YquPJ029lcxP18geKeh8J2vOKFjd4m2sVo6I7a7vygIcRwl7PFCecFm2XCTe90nyF3yFem6Y3oXOlG/5fhqyclahfPNkU0gO/sx4YFCyyXLdjjsMJoS0mPHyxAZxcp1j2rBi4DAq5K7sK0jmMuuL5qjjHoT7Dbf7PWy5rZsdQQGHHtJbWUPdHIgAg7+CFt+npJu8/Hu8IjosbAko5jQ1XAtVS6vavQ44hc372ZisNyyiPHvs0JPkBkyetGy4/eaR9PSzVJICAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=CEWeA5P82+WGnptpoR/1t7m10wFCGYjqLP54MX0kSKw=;
 b=Io1VoO0sp4mnaYgMk2BaCRhEOnG1fqFxa5ktohpV2gQxE2YxQm9QMwPaMu1d4LXpcWY7xrAo0mN5TR56MeibzCk2d3BBhh7zJompLkkkyupARSZnx9igchkZ7W+ckDdYcZyEQqVncjMQD6qMXYN6i8+TzXiSOj8AfpyklUlAKHm3UcyFw3tDAIi5jstJWwBZl9t7kfUCVMRrzQ5l213PSciYwQ2pbaA4aVi2TIWArU3wTyh67opvrJ+OffEPN7Sq4xhKA6ibKGAMB7A89JiXewTMJy+ENN3oMVMyjTr+mIUqS6XuDea3wCoL3hRQOxdrvwFMuHWQeO7Z4VHViMwB7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CEWeA5P82+WGnptpoR/1t7m10wFCGYjqLP54MX0kSKw=;
 b=R3eqgeBL9MbegWbdWT9ThQZs4MX8zxovwVull3HtAVT+PJJ0xIXhBod4RPOPW2qvnCP9ERcPAC8jdBKY2ayFY98H83E+gchgsXfZUpBSudlMISBcIq/D3+YQO5WOUwtk1FmrDT8Lp+4/rWbEvdOa/yYOlKb6r7J6Pt9iQ1rIQwk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13)
 by CO6PR12MB5490.namprd12.prod.outlook.com (2603:10b6:303:13d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16; Thu, 9 Sep
 2021 00:48:40 +0000
Received: from CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465]) by CO6PR12MB5427.namprd12.prod.outlook.com
 ([fe80::d82f:e8c3:96ac:5465%9]) with mapi id 15.20.4500.016; Thu, 9 Sep 2021
 00:48:40 +0000
Subject: Re: [PATCH] Enable '-Werror' by default for all kernel builds
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Nathan Chancellor <nathan@kernel.org>,
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
 <fb50dc44-fbe4-e6b3-5abc-d90375992292@amd.com>
 <5263c3bc-b741-5fdf-92d9-42a726076e76@amd.com>
 <CAHk-=wjgi9jGiFHs7S2BPrGXKKOaVDqQsVPUsLWxkvZFAQ_WqQ@mail.gmail.com>
From:   Harry Wentland <harry.wentland@amd.com>
Message-ID: <725bc9b7-333f-16c6-dc4a-2e73d9dfbd5d@amd.com>
Date:   Wed, 8 Sep 2021 20:48:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
In-Reply-To: <CAHk-=wjgi9jGiFHs7S2BPrGXKKOaVDqQsVPUsLWxkvZFAQ_WqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0054.namprd03.prod.outlook.com
 (2603:10b6:408:e7::29) To CO6PR12MB5427.namprd12.prod.outlook.com
 (2603:10b6:5:358::13)
MIME-Version: 1.0
Received: from [172.31.6.8] (165.204.84.11) by BN0PR03CA0054.namprd03.prod.outlook.com (2603:10b6:408:e7::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 00:48:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bebd7afe-2e36-49c1-3d4a-08d9732b910e
X-MS-TrafficTypeDiagnostic: CO6PR12MB5490:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR12MB54908CBA8204821AD064397C8CD59@CO6PR12MB5490.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50WWW8WecneKwVhUejGkA4WW1vjR/6Dp+PF4Fb/ZWlPFBVV6D+ejVpocchICjQLRQSk+SjSAxAP+ctyZRIAcTslZekucJuR2uKZ8Pb7Z0W1wzFNHchc2JcniDh+N3QQSe+mutRxCuiozVJIyXQRCGxKe+5BaQObT+5z8NSoyec8uoHVNuUHStZrdRBFW12E53k0bUTNSGM7IiD6OUWd4/CtRxqr+tAjuaecwufetGe4BdpZc3SSlGcuWO8/u3F23MhQKWARASNJ1MiyUcb+9GgjhlzGd/lrtZk/eSU3VkALPesAtKaShys8RhD8VBeyrVnzdmsDLV2nixjFBt2Q5EtYWw2JjKWsuzFPKtpgqUyVcWwN0TF1hLq6aVO09KYPRucL5czkH+awtHUDsWCkfCPDpi1E8soXCSYoq8e2O+eFIbpnAprRJCVXzyUtCm6kdfKmf9h2wubrOyLBa7kxuHJtugTaPp2LFicVsF0ocr9zMAkB8AMUIq/AIMWn9FgZw8Qcbbp5ZYYrDk9xpW2FppOJo8Tb2RIZ9ZBmdKyQAJ+fQTD9Jsq3MeguigpXwWXdA7RcnzPOhMxAOjIDlZ2MpPzTYEtdOfMIxsKdpYlScn2bvAZ9dosp7bjg4Uqrpa+LDO4YVsVaiZDM/OuH8hXEv8fs00yU+CWiqLnZFYJF74jmup8Y6Np11eF5YHMtMiHe+auCTPN0oztESrmJSFp4dSzyjrDcyNmwZp5vBu7l7Csgceen/CsiC4bXli83X739sfBYVR6Yt/izMkqUDPYbSFnB7woUY88eEEM2VtyYdQ9AAYwSvoETskEbmtuPfK14ZYLM9/PUqsFXvSoJN+6xAuTVNRRiDlNK5xxHAeS4wF/M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5427.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(16576012)(66476007)(36756003)(2906002)(4326008)(316002)(44832011)(54906003)(956004)(66556008)(2616005)(6916009)(6666004)(6486002)(66946007)(8936002)(8676002)(5660300002)(83380400001)(53546011)(38100700002)(86362001)(508600001)(966005)(186003)(26005)(31686004)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU1PUHlZT0hYUHRyZWM5M2ltK2FzejhHcHJ1SWdMUTF1N1kvWEFYV3lldUZN?=
 =?utf-8?B?cFBJaFo3ckwyeDZzK1QxejNXUW5zSng4bUl6M2ttUmwzMUdUZDVOU3J4dHdk?=
 =?utf-8?B?K2NINHZJK1FTUVhyVER0NTlQcWQrWmtYUXRKM3JHTERCWi9JZ3JqcmYzajJV?=
 =?utf-8?B?ZC9GcnlLYkwvY1dYbk15U0dFempYclo1K3AxNnNMcXpjblpsMTBBVUpvUDB6?=
 =?utf-8?B?YVNGdCtYUzVSMktFNVhUamE3UXZMZ29EVy9ZTGdmWmQyd3dkZ1NiVi9IU2U4?=
 =?utf-8?B?WnV4TU9nclY3SnhpL005WEhLL216bkdhOWhIdkM1citpUTY3NWc4Ukh3dTN6?=
 =?utf-8?B?cWdyL2pHV2VZTUpVK3FPVk9acThKUDNnbTkrWEJnTjBUNFVtZHExQ0pxd0k5?=
 =?utf-8?B?YWN0V0o2SEpkeDdHK3pSZ3gwa0pnWk9vazlhdVBlYXRGZWd6M20zQWowTWg5?=
 =?utf-8?B?amc4Y3dYZ2Q4Yy8rNW5GeTYvenJ5dlYrRGR2RmV0MGlzc2dkQ0VVMXpSWnVC?=
 =?utf-8?B?YWlnTUR0Y2NGRGtucGp1V2pqZWxaZHJMLyt3dU5VdXl1RmdscGdLODF5VXhV?=
 =?utf-8?B?bCtGWXBOd3ZteVNTUGk1ancvbmFaVWlpSzJ4bVlvandFQ21rZHNrS1NFWXpo?=
 =?utf-8?B?M0l6UDZ2eDNRcWtvZFZVL0NPZ05pOFluMzlyejlmK1dGZTFhcjUvaDlremVL?=
 =?utf-8?B?N1ViVUJoSmxyY25xZlpiYjdkcGpsb0NZdGt6c0E0ZWM1UUdrY2N6WWR4MFA3?=
 =?utf-8?B?allocHlMWVhSdTlKUDBjVklWdk1zTFV1cXZjRml0a3o2QXo2OHhHRDRIb3lZ?=
 =?utf-8?B?eGFIdVo4NVU0SmZNR3k5VGw1R2ZxbWsrUWRZWkJjeGhmVjViUURlalorYjYx?=
 =?utf-8?B?RmJ0NHBKbEt1QTdwTWdLSGxRdWRiMjFnWXVnemdGOU9RYWNEUmtnaGJMOVVx?=
 =?utf-8?B?aXNQS0prZEo1aDZEUUdDd0FrRjVqckdzUHFlNlhlVHdEQ1gybWYrdTNLQ2g3?=
 =?utf-8?B?NkhqRzgwRlFEanFoUS9JSjRERkJRWDRnNGtwcUhVSWp0SzFuKy9KcnZ4RElK?=
 =?utf-8?B?TmtJallJK1hjd0ZBa1QwdmhVM3FsTnVrZFM3WmRrY01kVUJiTnFyZ0ozbU5O?=
 =?utf-8?B?enRJellGbEMwSFVMdnBzaVFKb0FkR0ZGVHlpTnlKZWtwU0cxbHU3TklNeFA5?=
 =?utf-8?B?ejh3bWlJWmJVRVNsUlFPMXpvMDREYW5nSGIvZXNLMVY4NU1iaWM3VTJ5SlpR?=
 =?utf-8?B?ZStBR3ZsOTJaMXJqZ2YzeDNaM0dVL21yYTRCSllLWWhFNnJsYmJFRkxTa0NC?=
 =?utf-8?B?akI3R2lnc2gva3hTOHVjbERwWWtVNHlCeDl3c1YyRWJ4aHNia29CSGUvWkdZ?=
 =?utf-8?B?RW5MYUNldnY0Q01nVFVNQ1p3VHNicHl5aHF3dy95UFNMU1NwT1dZazd0TjBt?=
 =?utf-8?B?dmxKYXZHeUJnQ0ZXWlNtWEwxZklPZXhMaWEzc05uYjhpRStDM1RjMENZK1pY?=
 =?utf-8?B?NFU4WG9WWUJ2dzNTMWVTeTFVUnk1Nkw0U0NidUZTR2wwdityMC84SnlTZkRt?=
 =?utf-8?B?Mlh3N1VpWGJUc2hWdE4yejFzaVRLTFNVMVJ3SFM4MGhVaU5OWlRaQWk2Zmk2?=
 =?utf-8?B?NnFLbG9oS0FEeXd3VHNza1ZJaXNvTXBLNWwvQmRSTEhOQXcxRXRxekE2Q1hM?=
 =?utf-8?B?bU1KcGJVTUgvNTIrd3dXbkE2ZG5ETlBicUZKMTZrL3dvMll6S3hQN002VFVp?=
 =?utf-8?Q?8TCCR8SDdGwcGiOweKDlVtsZhYmE4FS0dk41UWh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bebd7afe-2e36-49c1-3d4a-08d9732b910e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5427.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:48:40.5795
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3nsrKkmgE8xr7GwubCZ2uIQ6yJQ8KiTZcIbZ7DferMb/06YpupsfUBV854+HEwgLs7BbPMvGT2Pg7Ge5BpBDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5490
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021-09-08 12:41 a.m., Linus Torvalds wrote:
> On Tue, Sep 7, 2021 at 8:52 PM Harry Wentland <harry.wentland@amd.com> wrote:
>>
>> Attached patches fix these x86_64 ones reported by Nick:
> 
> Hmm.
> 
> You didn't seem to fix up the calling convention for print__xyz(),
> which still take those xyz structs as pass-by-value.
> 
> Obviously it would be good to do things incrementally, so if that
> attached patch was just [1/N] I won't complain..
> 

You're right. I was focussed on the stack frame limit but fixed up
the rest as well now and sent the series out.

https://lkml.org/lkml/2021/9/8/933

>> I'm also seeing one more that might be more challenging to fix but is nearly at 1024:
>>
>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c:3397:6: error: stack frame size of 1064 bytes in function 'dml21_ModeSupportAndSystemConfigurationFull' [-Werror,-Wframe-larger-than=]
> 
> Oh Gods, that function is truly something else..
> 
> Is there some reason why it's one humongous function, with the
> occasional single-line comment?
> 
> Because it really looks to me like pretty much everywhere I see one of
> those rare comments, I would go "this part should be a function of its
> own", and then there would be one caller fuynction that just calls
> each of those sub-functions one after the other.
> 

Yeah, that's what I'm thinking as well. It would likely fix the stack
size, even without dynamically allocating the two structs you mention
below.

> That would - I think - make the code easier to read, and then it would
> also make it very obvious where it magically uses a lot of stack.
> 
> My suspicion is actually "nowhere". The stack use is just hugely
> spread out, and the compiler has just kept accumulating more spill
> variables on the frame with no single big reason.
> 
> Yes, I see a couple of local structures:
> 
>                 Pipe myPipe;
>                 HostVM myHostVM;
> 
> but more than that I see several function calls that have basically 62
> arguments. And I wish I was making that number up. I'm not. That
> "CalculatePrefetchSchedule()" call literally has 62 arguments.
> 
> But *all* of the top-level loops in that function literally look like
> they could - and should - be functions in their own right. Some of
> them would be fairly complex even so (ie that code under the comment
> 
>         //Prefetch Check
> 
> would be quite the big function all of its own.
> 
> We have a coding style thing:
> 
>     Documentation/process/coding-style.rst
> 
> that says that you should strive to have functions that are "short and
> sweet" and fit on one or two screenfuls of text.
> 
> That one function from hell is 1832 lines of code.
> 
> It really could be improved upon.
> 

Absolutely.

The file comes with an (easy to miss) disclaimer that it is
"gcc-parseable HW gospel":
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c?h=v5.14#n32

The display_mode_vba* stuff deals with bandwidth formulas from HW
designers. At some point in the past we attempted to convert them
to something more readable and elegant but would often run into
difficulties getting support from the right people when things
wouldn't work. Using the HW designer's code directly tends to
short circuit any arguments about SW correctness.

In short, I don't really like this code but it works. It helps
prevent black screens and underflows on the display.

We try to follow the coding-style.rst for the most part elsewhere,
though there are still plenty of areas where we can improve.

Harry

>                Linus
> 

