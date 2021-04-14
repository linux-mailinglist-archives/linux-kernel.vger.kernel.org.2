Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E62635EAAC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244161AbhDNCPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:15:11 -0400
Received: from mail-bn8nam12on2040.outbound.protection.outlook.com ([40.107.237.40]:48640
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230293AbhDNCPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RfGFoOkwtbkw9x8ATSlgHylau11S+jH6U+ZvN5rGLxd/Du6DYzVIeYSzajM/4rF90HKn+mWghbRrjM5nUCcuPzAzUtmLuWp5ffBIYKEW06jU2hRs364v6VQxCJGRWe8K+WIoHDgme3jRYzQEv5gwvDDruMKuCZxDHcB+kRrFBbDKdvMn2y4qleJDD/rU830WnZcdujwGqcbQ+pBWoAGBEYfDskkxrptMbpNN4E6rR9P8IP9WKwQBfoOk/7a48PVPB+jROU9EDpdBb8dqFvwaj9sZtZ6H9QwY+ENgl2Uii8rkpMTMl31iG5D2qCYdKPD8JetXldUcLgW2h0+6TeZJdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/7whDsm0ufeTiZ4uoEc89rydxhUmpah1wpTcpLMJUY=;
 b=adz+0hLSxo8W7Pw09bvmvfjv+S450tsw4KjHNWIwUl9jRhmDxsER/AipampGVu1WEt4hmT9GHXWhqVam9Cyo4ZptLofyd+B9dz/1kl4E7ac9kxbFmv7KXB26bPUfZ0MfdjtKL5zyqKDWiI+n3+RBeatNpoY7eA+/O85+C2XbJL8zK2lZAATVSLXG4AiXUU3ABpG+fFCJDOUmWuCoiJl3xxc7zixOtccs4LZfHiQsKw/V7Jx8EyuWgjAwc67mOEAPWlaz6hkPT4RqlD9xfYUhnVLQMbYqb/VCfP8P5gvpVe2yKc1gkwLE+bVqaXRuBeQtjy6jF26pW/5hcWCPuGwaTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E/7whDsm0ufeTiZ4uoEc89rydxhUmpah1wpTcpLMJUY=;
 b=fzX57QBMZoELLJPjggnFpQBBUGgz7fYB2kvM4woG74ysz8W1OwlzZF8MKmAuz4Vrd9ToY8nmdn9VlHvoJhoW56D64ZmJBaGTLYpir9v8DaaWcjkNdNogxGIPTWieAnOFqBzj+dkQ8/0dl7/5PDQ3imRL5oA7PXYpVziqj7SVsn4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from BY5PR11MB4241.namprd11.prod.outlook.com (2603:10b6:a03:1ca::13)
 by SJ0PR11MB5168.namprd11.prod.outlook.com (2603:10b6:a03:2dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.18; Wed, 14 Apr
 2021 02:14:47 +0000
Received: from BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011]) by BY5PR11MB4241.namprd11.prod.outlook.com
 ([fe80::551b:e310:2ae4:3011%6]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 02:14:46 +0000
Subject: Re: [PATCH v2 0/2] mm: khugepaged: cleanup and a minor tuning in THP
From:   "Xu, Yanfei" <yanfei.xu@windriver.com>
To:     shy828301@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20210407030548.189104-1-yanfei.xu@windriver.com>
Message-ID: <dcb0de3e-826b-139a-487e-5055bcbe2397@windriver.com>
Date:   Wed, 14 Apr 2021 10:14:37 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210407030548.189104-1-yanfei.xu@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: BYAPR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::29) To BY5PR11MB4241.namprd11.prod.outlook.com
 (2603:10b6:a03:1ca::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.160] (60.247.85.82) by BYAPR03CA0016.namprd03.prod.outlook.com (2603:10b6:a02:a8::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 14 Apr 2021 02:14:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 45ef747f-6a6d-41e2-0c3e-08d8feeb132e
X-MS-TrafficTypeDiagnostic: SJ0PR11MB5168:
X-Microsoft-Antispam-PRVS: <SJ0PR11MB5168BF659A9FEA5FA95721D8E44E9@SJ0PR11MB5168.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8hZjgwvtGpJSdw5V5fZCn3K/e0zIEwJarBITnhhGQkaXStNllRU06+X4T/+/Ngpe7kPrSs9tKOKEdFbK2NvAsKgk0saMZS4acS1xK+Lvucg4GcALadEJ7BJ8rZA4A08QH/jxedWEhOyqnuW4xRHhkfnIIrH8maQJLeNiv/XytiuykFJpR2E74SY/aglbxniQxltGiLswuiThQUbYTM8ta+4g7P5SMXoFOAt+9omtO/4TCfIE0/bP2xKeIpQUeXWVCbN0dkBvdT/2/GH78IG8EC/F/td8b+WZn9zwcjMVxa0LGbIpqJNA99P7FG3LOVf/S1lZrVB+kHVM9cGERsmWQg2tioajCKXABlq8VeRUv3d20BkuP1H8mYIYExDJnpjtyl68QikS5qCvOVeOLdu4p+GUvwK/O+QSKsH+2mYRcyWHsENC4hLASLz+85raSUitQva5j6EtnZXN0PihFERSxWzhWmHioKhyfX31l1QF/CO8OsX0mv1821RwprIpnglJWYepb2tstnjmC1rc1ekAFZ4skUZTcxDNK/nC+C9jVVHAhdVCaG35Gnx9nqxUFeUu6vM+zLRogfBheJJM8q4Z0BYOymJxDNiiWYyNR9BU6gWJO4fE0Iw+gccoOM2WFJTRmHuNssc5sgCldGU5HaHwDiW1/faqP0UgtU5CQl2PNfrMRnL/6YFsvty4Oa6HVtpaegBZef6Jc2CKC3KmdaghZPmhrEZO24//TigUF8WXzPk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4241.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(366004)(396003)(39830400003)(346002)(376002)(66556008)(52116002)(4326008)(83380400001)(66946007)(38350700002)(8676002)(4744005)(66476007)(478600001)(53546011)(31696002)(6666004)(186003)(86362001)(38100700002)(16576012)(26005)(31686004)(6486002)(36756003)(5660300002)(316002)(6916009)(6706004)(16526019)(956004)(8936002)(2906002)(2616005)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?VDcvQ0NQeCtXQ3NWNEFNQlJhZmR4K3grcG1VdXYyTmxzQ3ZKUndVeWlZSnNn?=
 =?utf-8?B?Tkp4STF3V1d5WkxBZXcyKzJyTkZRek4yWGFsd0VQeGpHbnRXS3o0dVVjWUxN?=
 =?utf-8?B?WGRUTlM0aUdnQ0c3ZHBha2VOb2I0TWpCOUhlOStkSnBZNjNEYkF5Um0xdUtV?=
 =?utf-8?B?Yko5eWZZM2lrVHVIOUluTWQ1cGhqaVl4amRmVFRqWEZoeVVQUXBlN2NsaDcr?=
 =?utf-8?B?cWg3S28zOUZEUXlNTzdXWkdoZmkrSkR1WUhtUmViZFM1NUl6V3YzOEgxbHEz?=
 =?utf-8?B?aytDQWZmdFprblhMVldhYjR4eExWNk1QNVdiY1Y0ZGhjLzYzWWo4ZjNNbVc0?=
 =?utf-8?B?aTgzbURlVHVQM0k2S1pnWFFuSjdJV25RcWQ4MWZQMXk1ckszeFQyUmlOQVhE?=
 =?utf-8?B?eXVpaHVYVjZ4VlROcS90eEx2OXVCeW03M1BXWW5US2ZrK1l6V0dJYVF5Rk1k?=
 =?utf-8?B?Y1hUZzQ1OWNIdi9XcDRnUjRYSVZHdTl5Y0hLZ1hhRm0vbTZnQllramcvU0Vn?=
 =?utf-8?B?YXA2K0JYYm1QQzYvbTVNU2NzK3dkVkYvcDhDRTVBeVZ4SlhjaGtFVVJlbzhH?=
 =?utf-8?B?enJsa0twbmpxTnR3SFlDOWhTL1VMMytHb1FtTkozR0dXWFhtYUZhaXlSTVVj?=
 =?utf-8?B?QkdKRFp6dGY1dHExZHp6bXUvbE5yMmdodURWbGIvUWU4TXlMR1RyblZuZDhH?=
 =?utf-8?B?Mzh5dHd4UG5hVGQvSHUvbzQxZ0J3bXJpd2tCNHlFZFZKNUhUMDYxdVZGUTV1?=
 =?utf-8?B?Yjh3OVJzUXVtbGdTWHpEYUhVV1Z5cTJZaURJU3ljSVA3NkRpSmZGVUVQOTY3?=
 =?utf-8?B?VUpoelBVUkdvbitEbDBsVkV6d2JxMDJPd2pyNXBOOTlFYVoxR3IwVEVEZGJX?=
 =?utf-8?B?YmNpcHgzSkkzQzNWZFJMVDJZTDMydUdqMG9sQjVtY2xHSDJLNnlCWDZUY1U5?=
 =?utf-8?B?RFphQkh5SEQxbzA0a2dzVk5OOEtGMzQ2eitiVEIrSnVCQXBDMytKczlNeEcz?=
 =?utf-8?B?UVAyMEczSmFKMmNtT1liVDV5MWpQa08vT1MzbnhmdkwwVi95QXVvUlB1ZnBW?=
 =?utf-8?B?Qk1DMnc4a0xPTTRVekRDS1pKMHJCSFJraWszMXI0TlhWUjZJYUw0ek0vYjFr?=
 =?utf-8?B?eUxHSXV1VElOdEYrT2Y5b1owcWkwenRFZmJURkVvcU9rZ3c3YVplODFkKzVK?=
 =?utf-8?B?WjhLa21WMFg4VlRUM3BNbjVOWGJKT1NFUmNQOXRQblkvVjQ4akFQd0Z4R01J?=
 =?utf-8?B?bmltdWViZHpGRHFFa2Z4NnJDZ3BXbUZoYVJVY2MrQ0ZmdWdjYkc4aFNiS0Fo?=
 =?utf-8?B?ZExsSndzUTVwNUZybGZBdDVteW9uem05YVVObENFSHF5Q0xTcHJUMnl3OWZP?=
 =?utf-8?B?OEJKNitMeVZGNzJ0TzIxTCtSUE4zeENoclRHY2s1SjBkUjNrRHIvQ0VGTjFq?=
 =?utf-8?B?MkJJdDIwd3UvRnY0Q2xkQ3Z3aGFnR0tNVzFkMzQ0ODVxeWpmZGd6cmRJb2Q2?=
 =?utf-8?B?aVFBYjhHUU9kNEdJTUlUVm5QNTV3R2xUSXJKSjBBc1dJNnBjeVRaYnBTN040?=
 =?utf-8?B?Z2M1d1gyMUxmSEs3N2tzc1cwZWE3Ym4zRENjS0lHa3NHWUlEbjNJMVYzbllZ?=
 =?utf-8?B?TzlzY21WeUtkN3Zac05FMHJ4N3F3VHlZWnBhclBjY2sxWWNRdUZKMVFQZDBI?=
 =?utf-8?B?MXpORWl2MGxqcGZSR2IvZ1c4amMvLzB6N2p2M1JEbTU4ZzdjTUFvMUpiMGpV?=
 =?utf-8?Q?cfTfHArJXs5kyO/mOGVDIW7lE2p6aYn2B96BTvW?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45ef747f-6a6d-41e2-0c3e-08d8feeb132e
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4241.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 02:14:46.7148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aSOYPS4+ZEvuwbMG3R5oKLMsOL5eavpnC4jTSjy1TzJd0Wb3fLs7AA9dhZQV82oDgqEgQq7Sp6Cr1BkhmuONKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5168
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle ping.

On 4/7/21 11:05 AM, yanfei.xu@windriver.com wrote:
> From: Yanfei Xu <yanfei.xu@windriver.com>
> 
> v1-->v2:
> 1.correct the wrong location where the goto jump to.
> 2.keep the cond_resched() dropped in v1 still there.
> 
> Thanks for Yang's review.
> 
> Yanfei Xu (2):
>    mm: khugepaged: use macro to align addresses
>    mm: khugepaged: check MMF_DISABLE_THP ahead of iterating over vmas
> 
>   mm/khugepaged.c | 29 +++++++++++++++--------------
>   1 file changed, 15 insertions(+), 14 deletions(-)
> 
