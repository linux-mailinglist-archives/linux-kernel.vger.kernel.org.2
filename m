Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2E845D458
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 06:31:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbhKYFe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 00:34:28 -0500
Received: from mail-dm3nam07on2075.outbound.protection.outlook.com ([40.107.95.75]:10008
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345958AbhKYFcZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 00:32:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHu7fM6LuhEtEwtVIsrm+lQGkrilayrWlrf4hGSp/DA2X4ZhzGy9bTOLBB1hqXLc7X9IrYs6a9EihkCou8f3BVpvQ6edcwyYP5EiXfw6r1c9x+O3R8wKOICLGpLKy2qLibRGS4qImdyKNfkVe2eIFFahy8A3Ql4xqpjw/tRari5BXDSOBLYN13P95Hi8rkupfGwz0Ar8IGBSZNoEXO/b6PwZhuwkAi5f7HSLPEFhjqChagZEVEmIcjdGcX5fLcZuInowrmV3PQjfoPSo+FoS3AOmKy0h0GMOXU7X6W6EU1+TaQAWrTP311ZpgvoelEMj38rwp8bAh5f2RT+SM88agw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QP0fk/VbFYjwRT8gBC9gCFsw3fezup9wyLkUAXuhVSk=;
 b=dUv9MNngyAn8r+A9DBupKTh+SujoQSN5VKSXZ8KZqbi8P4Hr0tpJFscIIGNQneGU7kpgIUqLhTVpyD/9WppZPIK+1AOmSa6+xsoAXWDEfTBgPpNNBnIh6UxtEVmwDBacb7TdbnNib0u01jZ7cbqTCG1MSNrwBAmT5Ji0H8+re4pAHUQa1bK53Z/XPm4ofAfa41UvCThB2vGxbqqZgwsg3+vHkIjrb+n0L+vbPOXMovmPRGKzXKH2rSU0eQQM5o3KYe+faGVdcLBdYlWZJdtbz1jnXiITg74XLQHKQ4E9RzTk5SEOJof/ymL+V5P9KkhNNjtbYsCV3WRhoQm4hUNl/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QP0fk/VbFYjwRT8gBC9gCFsw3fezup9wyLkUAXuhVSk=;
 b=g9ai4DCeLh0B6W61CXkfP2q04kR3YF+FkmypOmr4S6tTUmQqdlNpg4bV8w9sOzw9TPQqahArVp1xBRkYh3Nm6q2FDw4BRond5kuzKKq7Pn6Rxm92t5KqGQncnwHyrNeo8I5WrW2lYOkBCDpJzLsvD1CY9s+tJWVxyPe2/+ILX2HAsICr7Q36qJMmUc1yMeYtLMKhyqw0NVD0jTy2rMBkH0A4DqrCNkmqQPHr88TLWbp2AtUfaTXG9iJ+/9a3quZiGfd1joJeviyGjlh9fhdlgZ1eaP9SCX1651k1Eux5lORIZcSEKylz2+hRujgQ4VKLUsVbicQYq9Hyu2PbGDcu4w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BY5PR12MB3713.namprd12.prod.outlook.com (2603:10b6:a03:1a6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.20; Thu, 25 Nov
 2021 05:29:12 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4713.019; Thu, 25 Nov 2021
 05:29:12 +0000
Message-ID: <6e2f8421-b8b7-c8ec-7a2a-646efb134bbe@nvidia.com>
Date:   Wed, 24 Nov 2021 21:29:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] mm: Use BUG_ON instead of if condition followed by BUG
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, cgel.zte@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        chiminghao <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
References: <20211124030849.34998-1-chi.minghao@zte.com.cn>
 <YZ483gwnwTysPt0G@casper.infradead.org>
 <20211124142751.e48cdcc3aea9e0ef899f4347@linux-foundation.org>
 <348f3a1f-c7d3-c21f-419d-7acd2e5290b6@nvidia.com>
 <YZ8Dz/85n1Dogy87@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YZ8Dz/85n1Dogy87@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR16CA0022.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::35) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.51.66] (216.228.112.21) by BY5PR16CA0022.namprd16.prod.outlook.com (2603:10b6:a03:1a0::35) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Thu, 25 Nov 2021 05:29:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4476bf26-c50f-4511-3639-08d9afd48349
X-MS-TrafficTypeDiagnostic: BY5PR12MB3713:
X-Microsoft-Antispam-PRVS: <BY5PR12MB37131E5AD431B52FD2D4CBA5A8629@BY5PR12MB3713.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nbkjC5KAdpnvdKinxQApDm4/cRGqTCCearyQbq2DQ7hu1X0wWA+QW5PAcmeyVOyeRXAbEXTJiKQRDvrCSzGcV455l5BxbuMv1529z/8Ms0iLm5J/rSdh+r0rKZm5h9/Z7yEgDMjCP8eXy4GExQERlTXa2whcScU3UuTGzXp180uwkF5nCML/uQf31qyzLcjYuhkwbmU3c5wghUq3Z0nDFRnyJHff2geWgNzZtcViT3v6xs2dotxkaxvYzCuSuKB5JNYxoqDAAUlgJRELdVwkamzqhI6V2TyPOq47Zy8J9Pi2yVO6ap+FTIyGIiVFKIK4VxRVWgm07fpcK70DIaEsc1Ti8SdQIkfJswXn5sdX2++p318XWwqaf+3qa3qIW+pnItlGosqF6gcmmOzQ3M/BYRPUEDRItvoeIyDNApgcrV6SUodxjCSYK/VxfN6ngt8kObTzQ4HkDk/glVDrxlAh5cPD60hhqB+/BwmzsJ6nzAWatRgdVjA2gckCt5n5WiB2k1yyOagWH6gcjUzEHoe3z7FvzwCJD0WA8SQuX8wgIkGDaCNM4E/89gatE242oyF2USimUTCj+OH8nSyHWTcXSlZJnhQO3MFjmd2poEQDXHAPR4+lXMqv1jSx4y6H0kvUfYHSKr3m1ECNP8PwDE1VBBOby0MlC4LRLvj9+u+VSp4DxhoieTjhhJVNNoaYiG257lZILYUwDtSro6Wqt541qSxSQH906q0cyuvhK2sQxUNdPvdxKkDEKuF8PU3Qz7Ao
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(4326008)(956004)(31686004)(31696002)(8676002)(26005)(36756003)(508600001)(83380400001)(38100700002)(86362001)(6916009)(54906003)(66556008)(8936002)(53546011)(2906002)(5660300002)(16576012)(2616005)(186003)(66476007)(66946007)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFJhdmd5NzMxL0htTUkzNTZIUkh5NllCRWVjZUQrdDFLd0p3MENPS2JyeGtE?=
 =?utf-8?B?cHBBV1hqMExWY000ZlFmM2pGQVpvRUkyR2d4WGdyMDRnaTF0RCtiWkZ6L2tV?=
 =?utf-8?B?dkc2SjBqVTJjOThzNzZrYlpZaFd0ZzlkTGRhQUdLbWNlcW03ZUFZWVZjUHVu?=
 =?utf-8?B?Ui96VzQya08xMmw3MWNUU1UxYkZySVErSW50eHIzcmtmUUhPL1YzbnY2aThK?=
 =?utf-8?B?ZXV6MThEWEg4a3EzYjdsVnF0S2pQb01YaEJ3TmlubjNJUzVsZm00SkYyMTZR?=
 =?utf-8?B?RDdzZGdXdU5UenRucTdvR2pXbkNUZzJLTkd2STJ0M0czellmSFBYSzBRSnpk?=
 =?utf-8?B?WmFpbTFjNnJzMkw0OWlRaVJxK0xNUkpDVmxFSmtvZUZNaWpJTngzb0doeFpz?=
 =?utf-8?B?bmVOY3U0bGFXTjZZNnhkMVZ4YzJDZ3RlbkhaZUVETjRmdzFpaklEcDZibGg5?=
 =?utf-8?B?V2xNQWdxSHJ1OHFJL3YzQUZJeWdhZmFZR0szQ0NIRHUzMTBDZ1R6amVPQmtq?=
 =?utf-8?B?N0ozWnVLVFZ0dnU0MW9XTkNJaDNOUHQ2ekNkUG1md2NVU3oyRXRKTmpBRTcw?=
 =?utf-8?B?dCt2eVpyWjJ0ejYyS1dPM0NPVlZvRm8yQUEySjNLd1lZckVEeWlKR0k3bDRY?=
 =?utf-8?B?UHZMaEh3MHBESWNOZjdmVHV0aDQ5VlA4REZuc2ttYmJqYVFISGZjdHZqckF1?=
 =?utf-8?B?K2JFR3Z0SDk5cnV4MXlxYUtneGpqVm9CcldUOStPMXZ3WE9wVDRBdVJyQ0lV?=
 =?utf-8?B?Qk4zbWZQd3JiTTZZUWJycWp3MllKOS9Wam9nVGFweXRWNnMrQjFLcE9MWmNO?=
 =?utf-8?B?am1JSXRVdmt3dUgwVWIrUnRzdVo4bHYzUTFnVEN3VDhGd3dzNWx4QWFzTThH?=
 =?utf-8?B?RUxwbnZtMVo0Y2tXVEc2UnFZWHNtdXB3Z2g3b0RCNTZ5T0YrOCtYYnVlSjNS?=
 =?utf-8?B?TjRhWDVmdFZaTkYva2pvdk9KbkI1TFBaMkM4akxybnZEWk5qSHkxNG8xM0h5?=
 =?utf-8?B?Q0R2N0R1SUI1dU9JTEhjY2M0QmQwNTExVVR5eGNNODdLTmc3N3lGL3lvSldN?=
 =?utf-8?B?VStERllMZjBud096SFZEZ0REZUxlZVRYV3lvb280VVVTTDI2UG1oRzArM1d3?=
 =?utf-8?B?RW51Y2pMaWdONkI2NGN0S0w1L0lZS0hrbHM1S3lJeVQ5TUVQbTRMVEtPYVlJ?=
 =?utf-8?B?K2Q5Z2IzcGhidmRqc0pUUXR3SFBsQ3BRN2Q1VklHdkZlbzFIWTNCR1BsMmhp?=
 =?utf-8?B?a1pBZFBocG4rWC9sV2xTOFFJYW5IcFRPNTdxUXVFemxyNWkyYUNzUXpaWGFl?=
 =?utf-8?B?dnBPNmwvSDgyeWhsNWg2UG4yL2d2V1U5RU9PSVpPZVYxOS82ejI1cU80RjlO?=
 =?utf-8?B?YkgydFNSSUZoVFgwdDZSVUJ0alk1d3F0TFZ5OGZ2OFpvalh1RGhRaUFlTVFJ?=
 =?utf-8?B?bWFKZUJ0WnlMRVFzckdoVEs5VzZkTzRiaXhqTFpTM0d5aXFZT0U0ZUZ4eCtW?=
 =?utf-8?B?RHZOWkNGNEU1dk44dkp1V3ZZcERjTTdaQk92RG9wVFlTNnBLMmpEY0hmckwx?=
 =?utf-8?B?YWxpL1MzNHFPOGkwUkJablloTUkvQnk2T0RpVHBjYlhsVnFMdW9rN0RsWUZS?=
 =?utf-8?B?a1JxVml5U1JnU1JRazZkbG8wWSt0eTByYld3elJxWEU2QmI1bHJuZVZYWklH?=
 =?utf-8?B?TlFzNVpaaWwrem1nbnJEQmd4M0tnTmFaWHg3RDF2TEp6cDdoaXhDT1JrT0lW?=
 =?utf-8?B?MSs5NU9TV05qTDFnSFRPMTBseTJiMkI1ZmVReDcxaHVMWTZLc2x5SWt0akVG?=
 =?utf-8?B?V05PM0RJYUVJNFFRdFAwaGdXdEtSaWhvbVlZd29Lb2JNR3krdE9xTExEYklT?=
 =?utf-8?B?NThzQWFBWWhhTHg4dDNVeC9zMUhuczFyWXE5alNXVGhkN3laWFEyT0o1cTJF?=
 =?utf-8?B?M0l6VUlOdGRiSStIWnRLVDI0N1dUWm1VVUZOZlNwT01NUm04NUZzTStHNTlk?=
 =?utf-8?B?SnNWaWRGMmhYZHZSUzlFT284cUY0d3gvdzJmekNieGM0OVBNVjFBdGlSM3gx?=
 =?utf-8?B?aDZtUGVWRnAvZ1g2YmtIUlFzNDFEVkpaTWdCL3BkdVNKdW52VU1ZaEdzK2Ja?=
 =?utf-8?B?bHZMZ3F3dmp0QjhWWi90WWk4bStDYklkODV3S1RJWkpDMXA4OWxndlRuZk5F?=
 =?utf-8?Q?YcLypD7h1GrTF4aKl9J4m2c=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4476bf26-c50f-4511-3639-08d9afd48349
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2021 05:29:12.1411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oBGE/Qnb3UeDuwZPfgU5u8gFkRTPPQi03MzVbvfVx1drkz02MIXUb2IoRFQd8GDoAJRCQVVW+e/rEtojPA9xxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3713
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/21 19:32, Matthew Wilcox wrote:
> On Wed, Nov 24, 2021 at 02:45:59PM -0800, John Hubbard wrote:
>> @@ -2201,13 +2201,12 @@ static int __ref try_remove_memory(u64 start, u64 size)
>> */
>> void __remove_memory(u64 start, u64 size)
>> {
>> -
>> +       int ret = try_remove_memory(start, size);
>> /*
>> * trigger BUG() if some memory is not offlined prior to calling this
>> * function
>> */
>> -       if (try_remove_memory(start, size))
>> -               BUG();
>> +       BUG_ON(ret);
>> }
> 
> I'd rather leave it the way it is.  I don't see why the version you
> propose is better.


In isolation, it's *not* better. It's only potentially useful in the
context of "code plus tools". That is to say, if the coccinelle change
request were rejected, then this provides a way forward that is not
worse than the existing code, and also works around the warning.


> 
>> ...and by the way, while going to type that, I immediately stumbled upon
>> another pre-existing case of this sort of thing, in try_remove_memory(),
>> which does this:
>>
>> static int __ref try_remove_memory(u64 start, u64 size)
>> {
>> 	struct vmem_altmap mhp_altmap = {};
>> 	struct vmem_altmap *altmap = NULL;
>> 	unsigned long nr_vmemmap_pages;
>> 	int rc = 0, nid = NUMA_NO_NODE;
>>
>> 	BUG_ON(check_hotplug_memory_range(start, size));
> 
> That needs to be fixed.


Yes it does. :) I pointed it out in hopes that Chiminghao might be inspired
to go find and fix some of these.


thanks,
-- 
John Hubbard
NVIDIA
