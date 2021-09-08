Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0D4403E32
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 19:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352424AbhIHRMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 13:12:52 -0400
Received: from mail-bn7nam10on2080.outbound.protection.outlook.com ([40.107.92.80]:15969
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350166AbhIHRMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 13:12:51 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mepozF55XvIQZugSUd5o0qT0Labw0HvcLwivWiQLgKXVTFoWaS/nUpcEa/17EdiZl4i9VPICpIZysZOfwToJofLixHZ3/E5Hd+hZebStfW3rlLikUudLaAuyguAC/OtobxSe+sxh3BkaQ2KhqI/FAsN8/zd+w33hnWyVDg5NnGIwQim6cs5On/t9KPBmF1+H8O68VvCzqEZLf4RrT8i5wYWZ51pODzxAf9etWr0sEUWLD5fTlAjSzCnsKaxdm5RyoCcfR5KkBvf9n/jWc3cS4lF71GcywjoHlBfkAO1BteGgg6TZ+kYNdrt+09zVYrgVMyxVXyJv9FTww8aAReVuxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=ooob/SMesiZmtdW/oAuJ14H2AltbfMhSXtiI8PnWj7g=;
 b=NLHyC9+9kXgHXqq75UBqIvThRai3h+Mf4QVB7jG+AOgqKEye3ANy9kgOhkvJWQloFtAnkOe1EO9oKC2vaEsdhA0EJCeEb7yeUpUrmIM3rv1WfknHTjK5qaXV97ZlRKfCqcxWhkQ5JEHSLvNGpABzP45Qo7l4y2MBUEnDu/qXzpYLwDsJdOpebRLJXn1A11ehit2GXa35Y0IGA2B6WEMUuznaJLjUOELiiDI5Rc3u7Q6YjeolyZUrFzsT2+gC3kuAUWPqLaJuv0uQzJ2Yz0zbtEdTSp6+g1ryUgBrbSED4uyDlSa2tm6PDcO6IQbvYs3jqACs8qGNHkSoR/8jzSn02Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooob/SMesiZmtdW/oAuJ14H2AltbfMhSXtiI8PnWj7g=;
 b=IO0WKsPeQzRLkOB7godgLKzuipcxvVvIFOj3tflDZslOKv0PC6BFdcU/xZ0khoxdturqIlkAJOO+bqJ17DElpmt0qIcMVNh6mUeQfAkTsYT4f8HEmRfDiTfJH6SYbFBVs8xcz5ti+C066PrDw1lbpArte+YMJkyvM7IwbqPlvYQ=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5286.namprd12.prod.outlook.com (2603:10b6:208:31d::6)
 by BL0PR12MB5523.namprd12.prod.outlook.com (2603:10b6:208:1ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Wed, 8 Sep
 2021 17:11:41 +0000
Received: from BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::f556:bf4a:a9d1:81b1]) by BL1PR12MB5286.namprd12.prod.outlook.com
 ([fe80::f556:bf4a:a9d1:81b1%9]) with mapi id 15.20.4478.025; Wed, 8 Sep 2021
 17:11:41 +0000
Message-ID: <ad2bbcad-857c-f39d-9bee-49cd8ad582b2@amd.com>
Date:   Wed, 8 Sep 2021 22:41:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 1/3] x86/amd_nb: Add support for HSMP mailbox access
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux@roeck-us.net, yazen.ghannam@amd.com,
        mingo@redhat.com, nathan.fontenot@amd.com, lewis.carroll@amd.com,
        Ingo Molnar <mingo@kernel.org>,
        Jean Delvare <jdelvare@suse.com>
References: <20210902174155.7365-1-nchatrad@amd.com>
 <YTEQzIVfY/A1uy32@zn.tnic>
From:   "Chatradhi, Naveen Krishna" <nchatrad@amd.com>
In-Reply-To: <YTEQzIVfY/A1uy32@zn.tnic>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:54::30) To BL1PR12MB5286.namprd12.prod.outlook.com
 (2603:10b6:208:31d::6)
MIME-Version: 1.0
Received: from [10.252.84.184] (165.204.159.242) by BMXPR01CA0090.INDPRD01.PROD.OUTLOOK.COM (2603:1096:b00:54::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.16 via Frontend Transport; Wed, 8 Sep 2021 17:11:32 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1eefe60-17aa-4880-9cc8-08d972ebb918
X-MS-TrafficTypeDiagnostic: BL0PR12MB5523:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB552329342D51F59DAAFFC021E8D49@BL0PR12MB5523.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bFFCObtrlw7w9da7kNi31fst3CQmRKGfICrgNPaFe9TQvrMscbTRo2udCmSeNgux8eLOvn+3/wmrRbdeiWVnZEejmjsdTqOYqLXoBtS5L6bTQbQTJqkme1FzdVCbANf54zwb5H/Fj3YG2PXhwDs4DzjBCxaTcLqAwsQnrB3TNAGcYhjVqALOmFt08Nfpj73CiM7HOY4nClO+VjHCeIJv51oiVvN/ooDzTDxXTihYwq/qB29FW3HitcDKy++IXFJHL639MrwqM2JbizxYsW0V3Vs7kWaKhhf0t4pd0YLYkSqbV1iZl5Ntv15UpvV2NowHdHll+dwWkVqqZWFnL5Sj0GF1iogB120WhuDhLyEyJWa4MG/Ys/4yPj3yxCTyhKS+DAZsL7dLFR6RvWNbnim2ySXfNHD96SYnzYTDZo383WE0PGEZ482ramqv4dh+hX7LsxopGdzsWy/x4J5uLhwIuQ2vgOTT3+HY8jKdNJZjxET2TKyQd1e8RlfXB4gWH/vkD6ph0GBZjcoCikyAeGR7atIDWS0CTyd9DDqRFWIGdbSMwzBplnwkReHfx+fAYT2D2UQ5fMXclfPdNVhTRG7W5sSyMMoS7CE0HbsYv6n4snbzAVugJQGAlhKMUEu36gOXLEsNLfr7R1J9GCz2qNXRxPwQjhOSJJzmhtrboN2pKAZPk9B2J8d5OOwH/tRbd8fNsbo1FXR4fXi2nLTs/OBUMPKn1XPZldLBYUziemBAoPIY8Dh0lURnuJi6VWx5Rr8UvoqWVOXuYUcDXHkcsFijXzfYkDEZSLTUT813Lr8l5WIO5OupApYQc2Sa5W8gtTYl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(136003)(39860400002)(396003)(8676002)(83380400001)(956004)(2616005)(6666004)(6486002)(66946007)(15650500001)(31696002)(8936002)(66556008)(2906002)(316002)(38100700002)(66476007)(53546011)(186003)(26005)(4326008)(966005)(36756003)(54906003)(5660300002)(31686004)(478600001)(6916009)(16576012)(45080400002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nmd0U0ZGano5UCtTWGpFNU5Sa0RsR2NFdjIwSkpBbUtFZEt1V0YrQUhKVEht?=
 =?utf-8?B?Qk42cDFvWVJvdnJQaDRGWW1naG0rMmRlbEJucXJYZ2tkRnhxR2dIZlZtSjZD?=
 =?utf-8?B?Sks4bTZXL1h2eWNBZjlFeTJwZWo0V2E2eTVrc0Fna2VORTVzTEI5MVdtTTZH?=
 =?utf-8?B?Rm9Nc1E1WFQ2M3RxS2VCcDVDTU03WlNOUDVERjl2N1N3a2VtdU5ER2xITVB1?=
 =?utf-8?B?Um5MQi9kK1kyS3VEbFppOU1Yc0haV0RBaW9GV2dUckw0Y0tLdmVNT2lIam5x?=
 =?utf-8?B?WHZYK3dCV1k4U2dBS2FjWlFxZW9QVXpoTDQ2RUNnaXBPNGhzUzhVbEttb1pu?=
 =?utf-8?B?dUc2c0syODVnanBCMDBReXJVd3k3MTRBUFM1dVpidTA1dWJoRW9PY0tSa3RI?=
 =?utf-8?B?dkpsVDZSeFc3cmhxVUczV1lzd3lzU2hBa2NqNzFGNHZXb3NoZDVNb3AySTJW?=
 =?utf-8?B?d1JUU0VueFVjOE5ncVQzUHZNeVk4bHc1cTRqK0t1ZnFDVjhOMTlrUnMxSXNx?=
 =?utf-8?B?c3c0ZDE2TFAxemVsZzNLczhnUGVqNldDQnVsUEpuSjIxYlExcE9vM1FkbkRw?=
 =?utf-8?B?dkZpMHNkRUVnKzJaRFZLd0htVFNEOVplRE91eStvY0NoQ08zdFg3b29Kelc0?=
 =?utf-8?B?aDJGbkdCUHc5VzhxQTJsdWNjMVd4SWVyOW5vQ25TM09UWkphckpBQTFOWjRC?=
 =?utf-8?B?emwxVGppazdSZGZvY014RTJMOU11bXdXTzJqdElBYXRMQ2crSzJ6azhrVnhk?=
 =?utf-8?B?VDNaSy9YVEIzdnY0ZG90YUI5UnNnVUcyVkNWKzhLT3dlQW9NWWxkQm53a1hJ?=
 =?utf-8?B?Q1pGUHdrNjl0MThOZXgxVC9Bb1ZVSFdMTjJJa0I5YmI2MUVLdmVhVk14UHNP?=
 =?utf-8?B?djBjTE5hQVNzeGpoeXdkUFJtK240VW1hY0QzVXpOWmhkNUJwL2hXbUl5Q0V5?=
 =?utf-8?B?MDJNd2pHNXlkY3Urb3Z5eTNlb3lqQW9HMDU2RUZPZmJaV0RMc0I1d1ZPRlN2?=
 =?utf-8?B?Z2p6ZE5oYjQzdXppZjduVHpudEdzU3FOUjVSeStsdUV6cG5WT0VDZllEa0Zl?=
 =?utf-8?B?K0NwMUY1dUg5NGRmSjNMQ1FiS1FLcmduQWNtQ2FMTkVwOGpoRmU2OXVlUC9G?=
 =?utf-8?B?VHowS2tEdWNMell0eElFWDJWTmt3cVlhRm5zQjNkeWZQQnVPbVkxakFUeU5q?=
 =?utf-8?B?UVhYZncvbjZMS1BWd0crKzdXWVVYL0QvTG5CdmFWK1o5YjgwVlNYcHRLN3o2?=
 =?utf-8?B?d2pEZlArMjZraGZWTllONkxUUHJMRzVkSFlreEY2eHd3TVJSOWU1SUNzQVJr?=
 =?utf-8?B?ZURqMjJrTGRSaVMvd2tYL2tiNGFXbFgrRGZwMEVNVGQrcWZNUUhmN2c0WXQ0?=
 =?utf-8?B?c2VkcFYzc21jWnpRYjU4RUdQV2F3UVhocGl0Ry9USmQwUnNmRXgvcW5iSTNs?=
 =?utf-8?B?RDQ3YmpTZysxRjJtKytITVNLdzJLVVdtcm1pSkJtd0NEWDBROTF0RGlra1Qz?=
 =?utf-8?B?Um5GMDcxRFM3eWduWVgveVgzNjc0N3UyelhpVkxzYXNuaEk4OUM2VVRDdkVC?=
 =?utf-8?B?ZVJUNjUyT3NuYk1pOFZsN1h2TllZSllWOFlBVnc4dGRKZHJ4L1FiSzY0OWY5?=
 =?utf-8?B?MG4vUUdRQTJ1SmhkYjYyWTJWQmxiSDF5UWttMVhjbWFKRkNVSDAzK0JXWDR0?=
 =?utf-8?B?c3IvWmZGUUx2dkhmOGovaDl5ZnlSY0JCaFhnVTI4RFIwOC9CMVhydzNIVEJK?=
 =?utf-8?Q?XRFS5hVA98XHQZyuBSnUi69cYBPtCFjTeGrLkl8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1eefe60-17aa-4880-9cc8-08d972ebb918
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2021 17:11:41.4721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGb/patgcpjmaQJAE9fNMVTrW8sC6CsyUyux/Yb220/WOKema9O2CWLeYsQ/NsZyT0CSsmOJCJ+xtfCZOpfzrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5523
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Boris,

On 9/2/2021 11:28 PM, Borislav Petkov wrote:
> [CAUTION: External Email]
>
> On Thu, Sep 02, 2021 at 11:11:53PM +0530, Naveen Krishna Chatradhi wrote:
>> On Fam19h server CPUs from AMD an HSMP (Host System Management Port)
>> mailbox interface is added to monitor and manage the CPU parameters.
> Mailbox? Hmm, that rings a bell. There's drivers/mailbox/ with a bunch
> of drivers in there. Those are
>
> "Mailbox is a framework to control hardware communication between
> on-chip processors through queued messages and interrupt driven
> signals."
>
> I wonder if that HSMP thing can be wrapped like a mailbox driver...

Sure, I will look into the mailbox framework.

>
> If not, I still don't like it being slapped in amd_nb.c where it would
> be built in on *all* AMD hardware which is kinda too much.

In all the future server platforms, AMD's direction is the support HSMP 
interface, which exposes system management knobs.

>
> You could make it a separate driver module called amd_hsmp.ko which
> loads only on the appropriate hw and uses amd_nb.c for detection only
> like the other drivers, for example.

How about, creating a module under drivers/platform/x86/ (lets say 
amd_hsmp.c) export an API from here and it can be extended to support 
all the knobs that does not fit in an existing frameworks (such as 
hwmon, etc) and provide a user space access.

I can see similar references in the drivers/platform/x86/ directory.

>
> --
> Regards/Gruss,
>      Boris.
>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpeople.kernel.org%2Ftglx%2Fnotes-about-netiquette&amp;data=04%7C01%7CNaveenKrishna.Chatradhi%40amd.com%7C52aacf76c0d74c526ade08d96e3b3765%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637662022905004162%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=DYcj%2BcjedWpUaJYMl7yPDy%2BB%2FIe6YDucA00JcJtfLFk%3D&amp;reserved=0
