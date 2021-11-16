Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B872F4539DE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 20:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbhKPTJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 14:09:37 -0500
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:46529
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239822AbhKPTJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 14:09:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XfnI0w5SDsM0A99kpHgQJ5b7r4xZ4PJkAcrykqz2A8jU7sBZsNDzCmwEr5ErQ6XclmWBxe+vD6tCQ0MV+e9H3EDTm1igxMqI3g4051rV6s2kp1D3Ze5+JJSE1WKLc9OKoQPn8SKMKwT4Fm1slbJ8ZVQg6PQCmTPUF/KXczRN6bXBtnIPrXm2a4U9BzTXgMyhwpOR/r96yJlhhYadYNIg7ww5mRGbfP96Xwjol7msRZWz8yqwcNDw+Azb5xb9tMpzD40k5OVgqfiUn6duvOwkkEqurgA8bxgIwPN70RFysxjtPxt/ufx/RraWbd6r6nLe5jD6QFm6POEkeb5msAhStw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M8K3KS0RpWB0SHUrATklp/JVlTb6aXCWbkB6jc5yC8E=;
 b=BjzYJxlojbUOGTvObWf0BzMJC2ZUysxKN1/hAutM3UnpEH8p3/BU6oIXrrhtSQYd1hSF9P1svCaOidw+KVGg3xIWai8N/1CY9ZRk5B937M88x+BtziagaIvvhwXlteG85lmHBTQqQqmAMQOGyswkrVQFeCu8SRBdi2tXKGtgnQh1ycE6vTJgnevY08igo1IxBru/MWr2BDfgBH4vYoy1gcnPrJvHfeCbOjLpu4hH6yOxDKR2qZfuNa0S8kKp41fnGIT0us0BmFSGR0Zt2GR6I8nDxDs5/K2lYOFck5syATmBoJiITMA7I2iQxwXHmpeYcgtEBShqoUhjxem6p0w29Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M8K3KS0RpWB0SHUrATklp/JVlTb6aXCWbkB6jc5yC8E=;
 b=IBdbUJaB5ag5OjyMXy1+osRGINltWzl6sGTho73iLYaWZc/oHOcf0it0yzn6YW6lnnhWZ71xLhMd1N4jwHiq7RchvpNlFeLUJ4wUvMYks8sv9dGP9pF4AHkNpzV3QmrALHZzjSWcDJcKaGaXqMhOrDpg8DKmY92acOaIvSu4LeNj3EddQg/eYs2Od0shJIr9aKAUHA80u4d0GpgVg6NCBuhSrGVjw/qNLfjUdbagzcc3pI3+I9jecaOzpquqUZztgM53x8fY2r7kQyb6RRAqSQtl1LGfpFPuVUji8dXZiC8yF0/rUp1lTxmpAR4yRszqURwgsZrvbTaW+PoeatShfA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by BYAPR12MB4693.namprd12.prod.outlook.com (2603:10b6:a03:98::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26; Tue, 16 Nov
 2021 19:06:21 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::a0ac:922f:1e42:f310%3]) with mapi id 15.20.4713.019; Tue, 16 Nov 2021
 19:06:21 +0000
Message-ID: <b055cf62-c957-db35-2bf9-630345d63cf6@nvidia.com>
Date:   Tue, 16 Nov 2021 11:06:18 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH RFC v2 2/2] mm: Rework swap handling of zap_pte_range
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Peter Xu <peterx@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-3-peterx@redhat.com>
 <YZJnTKKXDqKWZ6UP@casper.infradead.org>
 <8a5e44aa-243f-3a9d-e917-09cd3cf6609a@nvidia.com>
 <YZOt7qD6yeSXJgv4@casper.infradead.org>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <YZOt7qD6yeSXJgv4@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR17CA0048.namprd17.prod.outlook.com
 (2603:10b6:a03:167::25) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
Received: from [10.2.49.227] (216.228.112.22) by BY5PR17CA0048.namprd17.prod.outlook.com (2603:10b6:a03:167::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend Transport; Tue, 16 Nov 2021 19:06:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 35b1d679-00d7-417c-fd75-08d9a9342d47
X-MS-TrafficTypeDiagnostic: BYAPR12MB4693:
X-Microsoft-Antispam-PRVS: <BYAPR12MB46931A5127842A9DFD862071A8999@BYAPR12MB4693.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NvlgbaUASuU2rk2FicCKygmU7tc9dI+JZm31Rc+ahXtSn9wkkdjN+RIPjsDgUjPZi51E/C6TmDPf5NEyhbittwXsu+PF6Rl65rfMSHQbaOtb5wTriJMH11ht2hC3RoltNL8beLbJrdvvEgvNUJe2Q+kE5SuIVjCuTO0oGrRaclq0w+3Ik747Pj3lTOaowRL8gNI92OZFdC0Fv3IJ1bVoBVVNYmDLrk5V2JU1LZHEB2RIqv/bwHnE9vWmtGzKORAlzbv7M9B9Us6+iVjZkwaIkufZsCvCxfVXfK5wr4obwWtCCvH7al8pjHRcWtX9jPJqWOr5ucwA1cpfdQH0OM28jQaJ3I7XASSFdnJhloQZX8GpBl//GFTMOMjosDZtUlr4TMcGrleSbk4lcP4tW5jAekVyUTd6fsk8gzXnkM+2flIuGrR3D8oLOp6OGdTUEnc+Z65mm1yIA42JI+1ak0kUzuK3JAwjEMYBbUPfKp428yhy+0AyTa2HXCT0HxYvgbsK3zUlN/ERrw+yCs0JaxD9iFY/X4D81KCkMRz1mItKPguoCM/3BbSUcffO/HKdNE/jhktlrSyjXg7qOKUi1q+Q2bf1vxXS0DsqZF1Xtx3p7SmdIJJ4ckwrBdqUg2mPYbBSzOX/uQdL3ckbBY4b8XyXQiVoDj3uaYCFEziAjVACXodqNxj/8oOU3JrpK5xnfIJcJrqAGKrnPqxLEIiLS3q3BF3Hh1PsgkPwDlLllL9yDZt1TjQ2tsQdzBg4xDJYQkw1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(508600001)(2616005)(956004)(83380400001)(316002)(6916009)(6486002)(66476007)(31686004)(16576012)(66556008)(54906003)(86362001)(53546011)(7416002)(38100700002)(36756003)(31696002)(4326008)(186003)(5660300002)(8676002)(2906002)(8936002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UE5KcUk1RGxZb1VLUVBzTWx2ZTUrdWdVVFI5Ungva3pBM0VCY0JNYU51RnI0?=
 =?utf-8?B?ajZKbVVXOU83UEMwaEJqbXlkMlVxL3ZReHpaSXUwZUhLM1IzbWFLUkZVbFhU?=
 =?utf-8?B?b0pPcnZKRThKcVZtVHh4T0ZyR2o5K0lzd01Dck0zdFlhQVRzb0NSRENGRUIv?=
 =?utf-8?B?Q2xtOHpCT0hGNXVvdk1GdS9EVEUvdDZ4bjBPZU5oRXUxL29MdGtoMkdrSmFu?=
 =?utf-8?B?ZTdNc2czemtkREIxMFNORi82cUhTM3J0RjhlUnBJdkJUOUxrbGUyN2xORnFk?=
 =?utf-8?B?T2VQeEVtVmNGRmdNZjk3NFN2MVp2OFZZNVgzeWRJUDIydVVBWks5aU5hdElS?=
 =?utf-8?B?bkxrWnVCdS9HcXpVb3VIcjk3a1d4eENaSFpIU1JrSVg4bWxHQ0V2Ykh5dW82?=
 =?utf-8?B?TzJaYjlrcTlNSHdWUTl4ajdjRVVobTRRTkJMc1hwZTZXYkRIdWJPdWdPaFBF?=
 =?utf-8?B?OUg3T0cyWm9UR2FEQm1XOW85dVgyclFTZFZPaGloMjBSSlIrRzBJZURlWDJ3?=
 =?utf-8?B?Y29hb2Voa2VNSmdYa29QQWdNeklXK2s5TUkwcjYydkswcy9Ja0xqVzZPTFdZ?=
 =?utf-8?B?eWVGb2gxTjNPdWI1azJqT2JzbTM4SmJWM2dZalYrSTBZRWFyVERNNGtMRkhE?=
 =?utf-8?B?L2NSNkNRL2ZNeVJSczVlanN5aUorL0xhYUFHMFFFNGNneEJsWVRwME5FZ2Rn?=
 =?utf-8?B?N1M1MFhpajJtZzU5UlJ6dWNhQVM5N00vc2hhQW50blk4eGVNM2lRRExXcTZ3?=
 =?utf-8?B?NWk1a1JXK0VBclJ5YWxKdXVQbFZ0WVhLd1FSeUNpOU1pbS9wSXFUSjFhaEY2?=
 =?utf-8?B?aUJoZTNDVHp5WDdNZGZZbzNBbGZlb3lvWTB0aSt4UTdodVgvd2hodUlwQmxx?=
 =?utf-8?B?MDhOWDlSYjhkRW9MeVJpQlVhTlNZVFZxcm5Idm5iRW1iU0x0U2ovS2VCZmNN?=
 =?utf-8?B?RW50UEJQOFIzRTRXMDdsT0hHWHZVSzJEQWt6SUNLbVFCNVkyUUdYSW5FOS8v?=
 =?utf-8?B?U0lTV25oUDdjaGF4aDJpT041WnNWb2FNbjg2T00ySStoN0NqajNRZHBVV3Jy?=
 =?utf-8?B?T1FWTHZIWVpZSCtFVGhGOVo1Rjd1UUxSdVBRaHhRbUFqTW5hd0FPY2hkYys4?=
 =?utf-8?B?M2cyODNTbExDVEpjQURSc0FlMGQ0MWxPdWozcG9QYnpCSnFkeXIyeXQ5bktX?=
 =?utf-8?B?eVdVdFYzd1ZxQlpGVk4wOWlhVWxyZmR1VTJRR1VUeldPQ2xaclJoSnJiVnN4?=
 =?utf-8?B?aDhLZEVUdkJhTW5FNFhNRVczN21UVTBGR1gySnEzeVFQU0JvWkwzN0NUUGU0?=
 =?utf-8?B?QkdUdGhJQUs5SGFLeG42YUJiTW1Lbm9jbEEvOTIxdTRvcHVlNm1CSHpaaDlE?=
 =?utf-8?B?WlVBSUswZEpEOFVKdTFjOG01NWplaG1BN0xIbXF4QVgrTGxmd0QrNlR1YUlk?=
 =?utf-8?B?NHJxVHhoN3FmM0hldlZ1c2lnbUZzd3U0MG9QVWFSVHphekNxd1ZDNkh1T3Z5?=
 =?utf-8?B?YzMyN1ZmTW4yc0FsYkNzMzFaTTJPSm45WXNMbU13UjMwUkFOUW5ENWF6RzFy?=
 =?utf-8?B?bXk1bzVLYXZJWXdFdzA1VGR5RisxakRiRG43VTlJeEphMjY5RzA3ZEZpMkVD?=
 =?utf-8?B?WS9OKzJLbVloVTlDR2JIdDdhN0xOWStnMEJzMlJ3TXc2WnV5Z1NuWitGbkQr?=
 =?utf-8?B?VVo3UU41aktYQ0tqbUYvVmdIK3pUZkhOanl4UkpuZ0dmUC9LREpGSWpjNjNU?=
 =?utf-8?B?aUthRG8vcnJpZ0hmZjJYdmI0RGlLbjI3dU02Z3M5RWlNaTdtOXBhVy94UGo1?=
 =?utf-8?B?M2wwN3F4MEJNaVZVaTEvR3lTcEVoQUZ2b2RJcXZpcDV1VzJtenpnSEZwR0N1?=
 =?utf-8?B?eHdxSzFCMmZSdmRaYUY5Q2E1N1JsQmlPZWFGeTNmWEk0SFVUbG5NN2Z0VVNG?=
 =?utf-8?B?UnRDOEhpdExEVUt4TExkR3VVMDFhV0RoclgvaEQyV294dDVlbG4wOXQzM3pw?=
 =?utf-8?B?elBVSFV6Q1RGMmFkYjdkV3A0QTNDSG10dS9UVzZOSVdVSCtYblAxNEEyOEd3?=
 =?utf-8?B?aWNxQUh1RVRZd3FOOGtWTUpFaDRUMVQwTjRDcmlWWXNISitqbVdsQ2JPejJ5?=
 =?utf-8?B?YXZ1V3RnelZNNkd3aFk1Z01EaGRjdTFIcTl3ZTNITDU5UUg2YWJvVGlNZ0o1?=
 =?utf-8?Q?yexkLnMgDW7uvawx+/9lwS0=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b1d679-00d7-417c-fd75-08d9a9342d47
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2021 19:06:21.3797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xyYApTJocRqtr2mfOYGqumLb3SqlbNwSj6CXMKHuB7aN+Kjc5xYfAhM5Bx2FiETp+00hnxuEaKzBfNWOdoad/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4693
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/21 05:11, Matthew Wilcox wrote:
> On Tue, Nov 16, 2021 at 12:51:13AM -0800, John Hubbard wrote:
>> On 11/15/21 05:57, Matthew Wilcox wrote:
>>> On Mon, Nov 15, 2021 at 09:49:51PM +0800, Peter Xu wrote:
>>>> Clean the code up by merging the device private/exclusive swap entry handling
>>>> with the rest, then we merge the pte clear operation too.
>>>>
>>>> struct* page is defined in multiple places in the function, move it upward.
>>>
>>> Is that actually a good thing?  There was a time when declaring
>>
>> Yes. It is a very good thing. Having multiple cases of shadowed variables
>> (in this case I'm using programming language terminology, or what I
>> remember it as, anyway) provides lots of opportunities to create
>> hard-to-spot bugs.
> 
> I think you're misremembering.  These are shadowed variables:

OK, I remembered correctly, but read the diffs a little too quickly, and...

> 
> int a;
> 
> int b(void)
> {
> 	int a;
> 	if (c) {
> 		int a;
> 	}
> }
> 
> This is not:
> 
> int b(void)
> {

...missed that there is no longer a "int a" at the top level. But it does
still present a small land mine, in that just adding a top level "int a"
creates all these shadowed variables (not necessarily bugs, yet, I know).

It's less of an issue here, then I first thought. Generally, it's probably best
to either use "int a" throughout, or differently named variables at lower
levels...or make smaller functions. Because if a variable name is reused
a lot in the same function then there is likely a relationship of sorts
between the instances, and it's worth deciding what that is.

> 	if (c) {
> 		int a;
> 	} else {
> 		int a;
> 	}
> }
> 
> I really wish we could turn on -Wshadow, but we get compilation warnings
> from header files right now.  Or we did last time I checked.
> 

...and as you say, it would be nice if the programmer could just let the
compiler figure out if there is a real problem. The elaborate rituals to
stay out of harm's way are not as good as a tool that checks. :)

thanks,
-- 
John Hubbard
NVIDIA
