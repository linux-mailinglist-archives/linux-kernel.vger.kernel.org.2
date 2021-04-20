Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D263365443
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 10:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbhDTIjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 04:39:17 -0400
Received: from mail-bn7nam10on2045.outbound.protection.outlook.com ([40.107.92.45]:59744
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229551AbhDTIjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 04:39:16 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWwwjc1LPkqyZvNUnkMgV5deTFEGhxv7VMlEeErnrOkBpTS4r5NpDT/H3INfFALAEw9Md4ahJE1EZ2ABxv1x9j4U4QawetvWtEECGd6Vet6NfscDz0JMf8xFUxLZuNAwx08I2qkf5dFTRNu5JBjcLgVBdFHMocMVUwG6RHQ4XxlXGp+KGbiDU0DpnJvn4BaI5cWHWVd1CO+Xtq1ig8G3QK14w+8utcRY6MDLbgtKIqCcNYKvUGVD/hp2OqCTGyAPwOtBoiGoFc3uIy44d+cBsUvuWGu0wnOdq15HmEze0WWZ+ZxBtXYg/ef1zj83anzdwTSiiyJKK6qnlxvG9fux2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x31DrSu2bBLuE3WduxhdsBv5Xf3riWVKJvmzl135tA=;
 b=JyKnSiZibpzUuxaE/lx8PcoqxFn2SpxBaVSoiP4RKrG7dzmMLWna0Y34OXc+FmGdBDHBOg5HRMfzNmjdufjo4EXjNXsfkUagLIIfB86iSZuZxKP4OA1rRA0cSesMyIU4JBzxmryeq8tkFVHPupSia7jHZKbzQXLUynNkCmkQdETsCMzeHl3NrqFmzYw1r8awbmKQmGHVoMimiOJQPadRzCXpLlMp4C8ixiox69BW3NmuX9fNUfBG6ZQSTpqQaqrTkCnLPI01hRgNaf61lI+em5XjO53XkjUa7wq0oAsnLkhobXlGGkug/nIKun/kSuc73jzXL8KfsHhS4LfKHjezXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x31DrSu2bBLuE3WduxhdsBv5Xf3riWVKJvmzl135tA=;
 b=UNLfX6LZqlREaoQAYIONdfcKsEFowpdKseNBCN/dznFGrsjNM3wlftaI/6RTg5Jjciaoz3lfg33RxInN5PRZ1DWKJdn49Ja2w/SoV0O8prHaPV5R23gJj3Sakgb6pXyRd7pvlKbB2VIb8VKpN07Y+OwkimoXdOqV1nCCtuSEx3A=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18) by MWHPR11MB1534.namprd11.prod.outlook.com
 (2603:10b6:301:c::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Tue, 20 Apr
 2021 08:38:44 +0000
Received: from MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87]) by MWHPR1101MB2351.namprd11.prod.outlook.com
 ([fe80::c156:455d:860e:ba87%4]) with mapi id 15.20.4042.024; Tue, 20 Apr 2021
 08:38:44 +0000
Subject: Re: [PATCH 2/3] arm64: syscall.h: Add sign extension handling in
 syscall_get_return_value for compat
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, paul@paul-moore.com,
        eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org
References: <20210416075533.7720-1-zhe.he@windriver.com>
 <20210416075533.7720-2-zhe.he@windriver.com>
 <20210416094324.GA1962@redhat.com>
From:   He Zhe <zhe.he@windriver.com>
Message-ID: <1e55d2b5-4b6e-7fa2-4851-06cac7defb50@windriver.com>
Date:   Tue, 20 Apr 2021 16:38:35 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20210416094324.GA1962@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [60.247.85.82]
X-ClientProxiedBy: SJ0PR13CA0202.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::27) To MWHPR1101MB2351.namprd11.prod.outlook.com
 (2603:10b6:300:74::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [128.224.162.175] (60.247.85.82) by SJ0PR13CA0202.namprd13.prod.outlook.com (2603:10b6:a03:2c3::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.8 via Frontend Transport; Tue, 20 Apr 2021 08:38:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60612d5a-a0dc-4c21-b75b-08d903d7b504
X-MS-TrafficTypeDiagnostic: MWHPR11MB1534:
X-Microsoft-Antispam-PRVS: <MWHPR11MB1534C224F5F7B66176F29C3A8F489@MWHPR11MB1534.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pflDroQnkpETzRijBSPEAkFZDYLZ+LWU5GnudRgi/QBF8ZRaYwLhSxYXJI/9MdgF74ffdCaMDKmKgp3H1Qw1ckkb1SDrKkcKjiU6KhxsSCCYNGppTBIRvr4LxB1MXLe+AriWf8moYNFVGumZcjWL2Oj41FmhS8UrAQUelmseL5sYyHVTKbWxztxExWeII+YtSFvV5BzI4LF8VaRw2YFZZk/XGV8Klr8059cKzg05sJag/fui+827KWy8zD1Sc2ezCwW5f4VdCwUyqAJh+YD/3Li///CNPdeqi1NFbg4sUCjGvh9nrg/fYS95ewy1TBAgoitDBg6Tw97rZCfsco3GG3TGoGfMNBtlXx8M8qJXrHlFAseth+wALthYwHHQFQKPe+QCAEqQNDdQcRF0N1RKfFrGoeMPr2eZdhB2vmcPy36o9ngemCvYG22FtFJ4I0HN1L1XTaT2Q6TIuzy3f9Z1UO0lYxkh7q5Hm9XFBFUYJc3KgXsSgpVzYkKzT8PJjVMbr1KLmjFcmH9MS7zzDfj547vHu1wPvv5uYtiu6HRvczw0fSY0e1aJbOR2nKBFiLmNgNgL6quWNPbLNzikrKIkITHRfadR1/WB9xOmgk+JY/vdGiSFHOrMHMrlY751RExkb0jL/idzxe71RvmEomYxGXlQ4v2flbl6xYV8v6S6PSzCkEOIDVPEDenCqhG/aNeGburGSO+VhByTvrnUB94wIiunL/dJgqe8/cR+Db3APFA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1101MB2351.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(376002)(346002)(39850400004)(366004)(396003)(86362001)(31696002)(38350700002)(66556008)(6706004)(53546011)(6666004)(36756003)(2906002)(6916009)(5660300002)(38100700002)(31686004)(8676002)(66946007)(4744005)(478600001)(4326008)(186003)(8936002)(956004)(316002)(2616005)(16576012)(16526019)(26005)(6486002)(66476007)(52116002)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?QTdvSmFteVBNbUk0RGhJVFJyamwvT3BrNStmRlpWb3c5NGJVWEljVkJQTGs0?=
 =?utf-8?B?MGZoYmlVMit3Tm9FckRCZmJNcFZmY1VEeDFXMy9tbGlWT1lUZ1RVOEJUWFJM?=
 =?utf-8?B?OTJlbWFJKzRTU1k3bjgwbExzZE1CRFc4ZDJJaDdqY0dHWXBKMTU1a2phdEw2?=
 =?utf-8?B?S2xSS2hjRWxtMW04bys5OXpzdHRZM2lnRTM0Z3AwangzcEV2NDMvd25HNzJQ?=
 =?utf-8?B?TVJPU3NHaUdlTkxBbnpEYmVTZFVBZ1dkeG0xWWducFlTVStvZ0UzOUVIdFU3?=
 =?utf-8?B?TW1jb0xpVFdjeEFndHBTN2I2MlpiQ0hUenpEVkxNc2tYR0Q1K1VGQU4vYjBF?=
 =?utf-8?B?MnA4dmxPUVIrblcyOWdiZW4xSkZRc2Q3Qzdualhib1dnZkU0UlBIdVRadm01?=
 =?utf-8?B?Y1lkSUxiSVZUd25lOXZnYm12dmZBZHlYdTZYR2JxcUlpVmMrUFNNMFNwemp6?=
 =?utf-8?B?eTFFNnJsRVVlSXpqSGdRMFVsZ1d3anpPR2h6b1dGTHhQNzRoZ0h5K1l1NUp3?=
 =?utf-8?B?djVOMG9QTnF2U01na0NxWU13bGtocHVaNEt4TEI5clpyNDhGbThGeDVPMlhV?=
 =?utf-8?B?ZVkrb2dxN25QQTdSdDJYKzB5U1NWc2NZVFVreGJaNFl1WGdYZzZ0Y0VmSGlK?=
 =?utf-8?B?dVJrVE9BMDlqaUFFazh6T3FaVkRmcHAwZml3Z3c2dzQyQUZFOGw5bTlDTTVa?=
 =?utf-8?B?ckJiRmRVM3Zxb2laaFlKV2xRUWx5Sm85ODFYRStkbU9jVUFOZ1l4SmZtQlRl?=
 =?utf-8?B?Q1RFQU9VbFowU1lyNUF4bUNNellnNG1RUkFORHgvalFsUi9sb2xFOXBYMkhL?=
 =?utf-8?B?NGtxNjltemV1bG11Y2FWdUpCQlJ0ZHNkVkxRbmh6SlVyUEljUXo5ZndLcVVH?=
 =?utf-8?B?UUZKdXlMSlBnZ2c4YlNPK05aSUxsMzQ4elZuRGo5anpUWlAyOEhwWjN6QVlw?=
 =?utf-8?B?MVJtbGs1NHpLalFwTHJtUlhMV3RINFE1TXdWcDFkWHdnMXdtamhoSFVMYlcy?=
 =?utf-8?B?MDFma1hkRHJmQjJ3K1RrZmQrekJDTVJGV3UvYnZldko0NjJpZW93RVIxZ2pn?=
 =?utf-8?B?UGx1QnN5WThGaTA4b0tndXdGV0Vva01HTC9qaDVFK2xkZ05TRXZYcFc1bjlS?=
 =?utf-8?B?TXRkT1ovMWJtNGpPMnZIMGZwWUVJQWNaRDZBeFJHb1BmK0hDWlVZKzBjdWYv?=
 =?utf-8?B?R2dsc0JyeTNjdzB5a1piQjdrVC96NEFacnUxeE9IY05LK1J5eEV3OEVHb0pi?=
 =?utf-8?B?eEJvMFNxS0ovblp4S000UGdYQ2hiZXVIaitPNFlmWXFRdVJaQ2o3V1hvdEpZ?=
 =?utf-8?B?YURFVEwwaHFiaUlwc0gyS3U4RE5BVFgyUWF1dVU2QVRLeFNIY1o0cDlGWEVZ?=
 =?utf-8?B?RjZJaTZMbjVBTG5RT3ZRMS9QSlFIOVV4R0E3a1ovNjMwcDZDa09icitjd2s0?=
 =?utf-8?B?VTF4QzQwNGluOGE4b3VFWHlzV2U2WmhJQUprVW40SlNuZnhsaE5WRHU0aGFJ?=
 =?utf-8?B?REdDYmlFVU5laXZMeEQ2QjZ4UkNNNlEzcHpTbHpnbXFOYkpzNEpQYmo3eTVD?=
 =?utf-8?B?V09sa013anBPdjVlQ2tEQ2tIQy9qOEwxazNKVXNOK29mTU4zZ0VMdktYRTI0?=
 =?utf-8?B?SkhIdUk3Uy9ORWRUM1VEOTExNG0xRnFqalVmSFVFamhwOUdSSVViZEJUb0V1?=
 =?utf-8?B?ZE0wRnI2N1E1LzR1RGVrUXZsNmtrbWR6VjNzTkYyRTFXSXI5MXlZOUpaK2ht?=
 =?utf-8?Q?9HxNqC2OA6VKMyMTupVCt6842lJghrmbaUTS+mA?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60612d5a-a0dc-4c21-b75b-08d903d7b504
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1101MB2351.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2021 08:38:44.1402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e/NP3skmkwkKNL1wLJ4zQjfEB94U4g7WamfmcJjOqlFY5KMmf5bePhGMQ9wJO4VqGydvPt2aaSn/3CSQIoF8Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1534
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/16/21 5:43 PM, Oleg Nesterov wrote:
> On 04/16, He Zhe wrote:
>> --- a/arch/arm64/include/asm/syscall.h
>> +++ b/arch/arm64/include/asm/syscall.h
>> @@ -44,7 +44,12 @@ static inline long syscall_get_error(struct task_struct *task,
>>  static inline long syscall_get_return_value(struct task_struct *task,
>>  					    struct pt_regs *regs)
>>  {
>> -	return regs->regs[0];
>> +	long val = regs->regs[0];
>> +
>> +	if (is_compat_thread(task_thread_info(task)))
>> +		val = sign_extend64(val, 31);
>> +
>> +	return val;
>>  }
> I can't really review these arm-specific patches, but with this change both
> syscall_get_error() and is_syscall_success() can use syscall_get_return_value()
> to avoid the code duplication.

Thanks. I'll improve this if v2 is needed.

Regards,
Zhe

>
> Oleg.
>

