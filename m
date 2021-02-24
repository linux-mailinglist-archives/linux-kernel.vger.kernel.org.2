Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979073244AF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 20:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234103AbhBXThg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 14:37:36 -0500
Received: from mail-eopbgr130133.outbound.protection.outlook.com ([40.107.13.133]:35381
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233576AbhBXThb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 14:37:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfOPrLXgG+orvOKb4Eh2QybTYsdTRB+woJaxnQsXD06zZjGQBYhxXEDXW92AcDgwWlZx4cPkkly6fQNBQorjLd9ZV44ut2amEzXco5HzYKNz4bADUJXiV032k0QxE/05cCPsomnHYO/OdqNc1P8n7BXhlKVTOe3hhcma/PhZGw5y5mk+vyAW8WessJTqRxRzhDN4Ffx6yIMQjhU9RWIfkPXh78OTBFiv15edClaXVqYbhHmsA0g8/sO3pKZ+CInByjuKijZwW/XD4n76q93Ewn0zSX/0mS1KspX5aZwznu8v8oy1cVNB+TB/m/GIku+LpYw4obup/a73njggFvdgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Fid+9O00HHbV8ST2POgJL74twLkoyPuuWoymfXvO0=;
 b=YEe8QdxAXUaT6JHyrr9Jg/XiKT2c+YqLA1Y+w1e6Ee9luzB3GP1BHyrjg4JVdggIF3q6SaI4fBLnrmuqizu/csxr/b2jSbT4ObpOK8YVbxObI6Qr+iQlIQMq5eWB/Zgu94pvKwJ+iv0Ncg4cczWoGJmrPn4jDypQe3N/SXTkWJztNRWW1zo48MH3ChCji3KdHiTWP+9R2CXhjsqQUi1ZL3MfmWmuQcmTCAiZZXCRXfc0PgxV3RlbtQ2GQjrkonWfeouwhOiFN4rPYgDd5vyE+xAO08IdIJiCIK7qshPi173y1uqjvNmwULqxpi1hx5rxQQMFHByyvKP0ItNjDxrCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=prevas.dk; dmarc=pass action=none header.from=prevas.dk;
 dkim=pass header.d=prevas.dk; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=prevas.dk;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j1Fid+9O00HHbV8ST2POgJL74twLkoyPuuWoymfXvO0=;
 b=Lun7fKtaNxjwGt7Mx7X1DUc2zXePvDS95PX6PqFHA8pnLHDIINWu5BBF+FJrta10wwKcl0TeWsb5E7fkZPBvXyIwbbMYkN0pJPAg9q/I+ukZonE+rceQ+OjRZTqk6CuJzRQu18+fvJ8VoRBGrJLpXt0ww47QchCM88eBW/oygGA=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=prevas.dk;
Received: from AM6PR10MB1880.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:2f::12)
 by AS8PR10MB4566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:2b4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 24 Feb
 2021 19:36:41 +0000
Received: from AM6PR10MB1880.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::312c:d368:d6f:10c]) by AM6PR10MB1880.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::312c:d368:d6f:10c%5]) with mapi id 15.20.3868.033; Wed, 24 Feb 2021
 19:36:41 +0000
Subject: Re: [GIT PULL] Modules updates for v5.12
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Jessica Yu <jeyu@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?=ef=bf=bcMiroslav_Benes?= <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>
References: <YDUibKAt5tpA1Hxs@gunter>
 <CAHk-=wipCbbXswcFvnrGae01H54dY1+XoaL+9YaiU71zGzko3Q@mail.gmail.com>
 <CAHk-=wh8vHL43v7GWK9MWrWitSmOmrEw1B0AJD9CrhBc4FvpxA@mail.gmail.com>
 <CAHk-=wiuoRKa=F3txoVHvnca+H=7gJyL3SFYwd3549v-sa0+QQ@mail.gmail.com>
 <20210223200130.GA8059@lst.de>
 <CAHk-=wj27tmZBzFRTZTAEPd6eRBzP5xCkQM+1cuSx7vzv8K4=g@mail.gmail.com>
 <YDYPWAtoDpyD9D4Z@gunter>
 <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
From:   Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Message-ID: <cb28abc8-5c4c-90c2-e3f2-a939ff507a8b@prevas.dk>
Date:   Wed, 24 Feb 2021 20:36:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <CAK7LNAQUL4qEgk97z0WfagVDgGAARzj8hqFyrC2wnPjiLduEoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [80.208.71.141]
X-ClientProxiedBy: AM6P193CA0043.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:209:8e::20) To AM6PR10MB1880.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:2f::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.149] (80.208.71.141) by AM6P193CA0043.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19 via Frontend Transport; Wed, 24 Feb 2021 19:36:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c20283f-c973-4ca8-0b2c-08d8d8fb8294
X-MS-TrafficTypeDiagnostic: AS8PR10MB4566:
X-Microsoft-Antispam-PRVS: <AS8PR10MB45669C7BC69A87E57E7BF4CC939F9@AS8PR10MB4566.EURPRD10.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /D80bcLF9h2OaStwqrS+lBbV78KvgSgJh/pCXQwMHoSzYSCgghhPrMTGGqGwJz/lf7cPkMio83QD06bCciiMuX3NrsPQZ+7eFXc3osSDzLFgrPvArYPmppq1pKPuf+mzjSBR3WrFV8YmTp6AlOWQfIOfvxRVvvfIQFhMIUhQF0iSz4bOBVaODcc7tfc/CpYdVAG+F7aduvwaXZcSZGBbKQbhZBPmHaecOOH7o6FdFK3snZu4veXNynINDfFfydZdidoh7KERhL/tnSqfZEtfKz/zQ5X6JYTTDEkS18afMROnvpzQh5TGr1gW/3p+E8064ePg+U68pFcfNIP54SqwwDzQOnqJXnAcgePtYzBbmmJzF7afnpWwjN41sD44OmktvdLJI375/E1gpBBqtw4SqEtNxm9JYXbsbIuqtrc41TBsp2lY0FlVbQTuSB5KmR0vpvKxA84zVqVBFJTNDHcv0vcwZpzylVoY1xqrOirfDMxaeCtdVDVLA953s+yUqZlZZ0u6wp5+cWbpF7ugoJ9fgrVigSKoFgFBSfg8bH5kp9zrYg4D445zysdUOsCk2GTE8hYA7oSn8yqx2cYOck+hOkoCgdm7UDABzEL1xx1KOO0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR10MB1880.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39830400003)(376002)(136003)(66946007)(66556008)(66476007)(16526019)(31686004)(26005)(8976002)(186003)(8676002)(8936002)(4326008)(2906002)(54906003)(31696002)(316002)(36756003)(52116002)(16576012)(5660300002)(53546011)(110136005)(6486002)(44832011)(2616005)(956004)(86362001)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WG42a1lkdTlnRVFvc0pza0w0Q1BvcERlWVlub3A0dnhTSEJLb011Wi9mTDls?=
 =?utf-8?B?ci9BeEcrcUx0clI2TzB1clRBOVF0cVhNcm93SW54cE0vZ2txSFp2bzFDaHpW?=
 =?utf-8?B?bEFDZjc0elY3Ym4xbUZwZWdSTytML08xUnU2T3VSMGhRLzlVVTYzWmh1cStj?=
 =?utf-8?B?cFpzQzNsWlRZM0dPVG9ncHJwS21pRWY4WmdzQzZwUyt2emozdHJRNkY0WXpU?=
 =?utf-8?B?dE84S0JySmNScWNKanRXdnFFZ3pKYXpzSjNGdnlTRWdMdW9SczF6SURvNGRN?=
 =?utf-8?B?d2tWcnUveXo4ZjN1QUZ2SE5TWUd6bnlSK1ZhTG84eHZjZUNORzZxemt0ZGRj?=
 =?utf-8?B?K2RpY2xaYUhBbFlyUUJFbWFzZTRjNS9KbFZWTStjK2hobExLQmZNRTRwL0VN?=
 =?utf-8?B?RWFMYUwzVDE2di9MR0pOZ2NQY0F4RlZHeVp0dzRFNzFQdFAxejhETnhUbzdn?=
 =?utf-8?B?UzYzRGUyQWV0SzJ4OXFPUXZuWWNwNFVueTNEajh2TEVSbFRwdDNCTlkxd1hE?=
 =?utf-8?B?QlVGQ2lJejR0cTBFcmlpbWlIRkFUSnlkcjFtRUh4M2NJOHFxTFM3dEhsSU1w?=
 =?utf-8?B?WjFPWGcvc1pqaDFqZFpiMkFpcGxpWFFTbm8vSkdLcDZ2a0FDb2F3UEplM29a?=
 =?utf-8?B?QzE2SU9uZ3VzVUtKZzVHTlV6K2UwbGk5N3Bkb0ovZWlndkprNldzRUI4M3cv?=
 =?utf-8?B?bHR2TDBFNnVXbUYxM1hCYUtpNDRrWVRQNVdUMmRJSlNkSDBXelIyYkQ0OEZI?=
 =?utf-8?B?alVsY3JkZVRyc3ZjbW1USVVhb2dSQWhYMmdLZFlaM0d6RWtxSldtYlFVNmh4?=
 =?utf-8?B?YzF6aGFISHg5ZXY0V1E3YVlPVExXd2srVXVRdHpXemVtVCtJTzY5L2FMaDhr?=
 =?utf-8?B?bDlzamptQUdWclp2WHVzMkt5blBHVXhuTENJZ2RvakVMQ1BYa0dnSzRaamV4?=
 =?utf-8?B?bFF4SnZVR09QbWhucUE5N21YZVZiREo3TW13bWc4L1dLL2l4OE1nOGRFdlEz?=
 =?utf-8?B?NUJyTkJISkMwcytaWGVhVldsaE44dkR1N2pZQ2xlL0ZLZ3JHOGo3NTJZQWR0?=
 =?utf-8?B?RDFMQkVycTZqeEhtTG9CUVVxajBjTHhpa3h2dmQwUTNuc2c3WnlZYkUxZXZW?=
 =?utf-8?B?L0V6NFJmQ2luZGZLZGtLcEJmTE9HM0tUbEtHajk5WEZNczhOWGpJV255NTZN?=
 =?utf-8?B?T3RHSjJER0g1MnNVMDVQQXdVcnVVNitzL05OWVVPZGxOcGZJZ2JERWpOdzNq?=
 =?utf-8?B?QTlQeThlWW5heWZFaVFNQlpEMmtuZ2VEWGFSK1A2MFhWZDZ4SXYwTlN6Z1k4?=
 =?utf-8?B?LzdLSU5RaUp0MGM4NmZwRkY4Y3NEZytXT2p4N2ZhMyt5NzRONFVPa3ZpNUVS?=
 =?utf-8?B?SGNKblcwQ2c0eHdoYktENlhRM1pMYWNzQ3ZpMnNpUnIxd005cUs2R3B6M3Z4?=
 =?utf-8?B?R3FDbFhKeW96VndPM1RLc1NPZjFFV2NodkdvNmtWelVSMjVyNGJWRytuTWhu?=
 =?utf-8?B?eW1rc3lBZW9oL0FYN1N2M1MwYjlVVDFBWnZTTmRhSktxUWFKT1o0YkQ3aGpP?=
 =?utf-8?B?aGdmU2hNcTFQdldBNWdQZmpwN2hodW5XT09CaEJjWjM5YlRueGJHc1E1Tk94?=
 =?utf-8?B?RTdpeWMxRTRxcVMzb0N1T1JYS0ZpV2FSWDhmR3cvTU5vVDByaFQ4M0gxaEFE?=
 =?utf-8?B?NWNaZUlZRjJlNWNTS250YisyeTQvT3BaYjluUTVBaGdNYkxUclJyV056TGh1?=
 =?utf-8?Q?YykgNN7mKXaAex5zyt7YyIJ4Y4rBOVqPFBDbKrZ?=
X-OriginatorOrg: prevas.dk
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c20283f-c973-4ca8-0b2c-08d8d8fb8294
X-MS-Exchange-CrossTenant-AuthSource: AM6PR10MB1880.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2021 19:36:41.5844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d350cf71-778d-4780-88f5-071a4cb1ed61
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Eip8R0qR6nO0Q0YY2IzHglrZ4Nx02E/6m4SoJgGD2Lrte/6VFCNumvJUwEzN2otBdr72fXHip8+ecoI+Pd8uOfBDH18yu8NBr5O1aufsFj8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR10MB4566
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2021 15.40, Masahiro Yamada wrote:
> On Wed, Feb 24, 2021 at 5:33 PM Jessica Yu <jeyu@kernel.org> wrote:
>>
>> +++ Linus Torvalds [23/02/21 12:03 -0800]:
>>> On Tue, Feb 23, 2021 at 12:01 PM Christoph Hellwig <hch@lst.de> wrote:
>>>>
>>>> Does your build now enable TRIM_UNUSED_KSYMS but previously didn't by
>>>> chance?
>>>
>>> Crossed emails.
>>>
>>> This is plain "make allmodconfig", so yes, now it will enable TRIM_UNUSED_KSYMS.
>>>
>>> This is unacceptably slow. If that symbol trimming takes 30% of the
>>> whole kernel build time, it needs to be fixed or removed.
>>
>> [ Adding Masahiro to CC ]
>>
>> It looks like CONFIG_TRIM_UNUSED_KSYMS had been hiding behind
>> CONFIG_UNUSED_SYMBOLS all this time, and once the EXPORT_UNUSED_SYMBOL
>> stuff was removed, it exposed that option to be selected by
>> allyesconfig. That option had previously caused build issues on
>> powerpc on linux-next, so I had temporarily marked that as BROKEN on
>> powerpc until Masahiro's fix landed in linux-next. I was not aware of
>> the additional build slowdown issue :/ In any case, Christoph's
>> suggestion to invert the option sounds reasonable, since the mips
>> defconfig selects it, it does not seem totally unused.
> 
> 
> TRIM_UNUSED_KSYMS builds the tree twice by its concept.
> 
> [1] 1st build
>       At this point of time, we do not know  which EXPORT_SYMBOL()
>       is needed. So, EXPORT_SYMBOL() is enabled, or noop'ed
>       based on the temporal guess.
>       (in the fresh build, EXPORT_SYMBOL() are all nooped.)
> 
> [2]  Get the list of symbols needed to resolve all symbol references.
>      (this information is collected in include/generated/autoksyms.h)
> 
> [3] 2nd build
>      Rebuild the objects whose EXPORT_SYMBOL()
>      must be flipped.

I'm thinking we should be able to generate a linker script snippet from
[2] and use that when linking vmlinux, so there's no recursion and no
rebuild of individual .o files (and all the __cond_export_sym trickery
goes away).

The ksymtab entry for foo is already emitted in its own ___ksymtab+foo
section (or ___ksymtab_gpl+foo). So if the sorted list of undefined
symbols listed in the .mod files (plus the whitelist) consist of foo,
bar and baz, generate a header to be included by vmlinux.lds.h that says

#define KSYMTAB_SECTIONS \
  ___ksymtab+foo \
  ___ksymtab+bar \
  ___ksymtab+baz \

#define KSYMTAB_GPL_SECTIONS \
  ___ksymtab_gpl+foo \
  ___ksymtab_gpl+bar \
  ___ksymtab_gpl+baz \

with a !CONFIG_TRIM_UNUSED_KSYMS definition of these that just says

#define KSYMTAB_SECTIONS ___ksymtab+*
#define KSYMTAB_GPL_SECTIONS ___ksymtab_gpl+*

and use that

__ksymtab    AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
	__start___ksymtab = .;					\
	KEEP(*(SORT(KSYMTAB_SECTIONS)))				\
	__stop___ksymtab = .;					\

Only one of ___ksymtab+foo and ___ksymtab_gpl+foo will exist, but that
doesn't matter (it's really no different from the fact that many files
(i.e. the * before "(SORT") don't contain any section matching
___ksymtab_gpl+*).

We may then have to add another discard section to put the remaining
___ksymtab_gpl+* sections in, but that's fine as long as that stanza
just appears later in the linker script.

If LD_DEAD_CODE_DATA_ELIMINATION was more widely supported (and I was
surprised to see that it's not even available on arm or x86) one could
also play another game, dropping the KEEP()s and instead create a linker
script snippet containing EXTERN(__ksymtab_foo __ksymtab_bar ...),
referencing the "struct kernel_symbol" elements themselves rather than
the singleton sections they reside in.

Rasmus
