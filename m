Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17E5D455EBE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Nov 2021 15:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbhKRO5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Nov 2021 09:57:46 -0500
Received: from mail-eopbgr60093.outbound.protection.outlook.com ([40.107.6.93]:52194
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229490AbhKRO5p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Nov 2021 09:57:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iM6KCmU3Ze8fMlquPOHduO93TmLnm1X4R8OcjJKJya1TCvjpogsYEjzb5tE8UcEoJEYBRQwTqDHw7pgS87zO8IBPqawEoCHjksrJTCNg656Ev/wpjD8QR/+5emGWUn7vp5NBMlcRDMgB68/Sbc/UVipf/M/P4oGT1PiXGWzJralDFHb7TrSj66is5Wr2BGCZvAS10shmLBgjy47Iz5azpeU7xgL50z5mPUn32+p0zopTgj9azkCdInUi06FQhDOi4MhNuR/Ov+CA1nDdUkb0q62UodwQeygUkT32GP/72JELWHWLwGASnyQjqCbVZaV8KnHF51UmvOVeRGf49Gd+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9du3AtqDSVyJdnzGT08/xk0Tihq9o22/ZHZEhRhR7I=;
 b=OpgjoNpwiOYp6EmHT/RaFDLLgiV//mcWegI11FKBj2WDxsV3I/Blbl7eV5o8LwR0GB1m/NJvb4dz0YnNHLGbMqFn9x3AZMwxUi6tW9X0Ov4XrVwCBpbLm8I2Nqjp8imvWEgQLqdofd84rCGviqr6OAHGANq2mbfd83NVBunbwxyaGDuOxpr8H68JziCTFqJtRQv0EgdeNp8hVAPcbjbbhHxwx2Qegw7imLmhGoQf93sg7Dotkia+sqoT+ljPfjYHCdJwMyxSJeyd/hNbL879xVh4x2SZ29JLk4CT7dv5XUSdyoFt21aVXJB9ehsxUS6PDj62nn9A4QMp8gGuxx1Esg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9du3AtqDSVyJdnzGT08/xk0Tihq9o22/ZHZEhRhR7I=;
 b=m/+yHDecLBniPGe+3KQ7lvp5MUqB9P8AFj6zYmFF3mvb5A0722KqHeD+4TL9NOFw9mz1egxXWPw00Puhmc+m5Wnt8cqjheWWxaVkFi/V7En829JSJHy6T2+2wrD5CmqDNLLXIU71FLqPoeOxpjdYWwv5m0Gx74xDtYkJVcXMlVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com (2603:10a6:800:1ae::7)
 by VI1PR0802MB2191.eurprd08.prod.outlook.com (2603:10a6:800:a1::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.16; Thu, 18 Nov
 2021 14:54:42 +0000
Received: from VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::f875:8aa8:47af:3b75]) by VE1PR08MB5630.eurprd08.prod.outlook.com
 ([fe80::f875:8aa8:47af:3b75%7]) with mapi id 15.20.4713.022; Thu, 18 Nov 2021
 14:54:42 +0000
Subject: Re: [PATCH] tracing: fix va_list breakage in trace_check_vprintf()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@openvz.org
References: <20211117183720.15573-1-nikita.yushchenko@virtuozzo.com>
 <20211117183827.4989cfab@gandalf.local.home>
 <ae2254dd-dcc8-3375-e8d6-efb73e280574@virtuozzo.com>
 <20211118093032.31c06b11@gandalf.local.home>
From:   Nikita Yushchenko <nikita.yushchenko@virtuozzo.com>
Message-ID: <4767227b-34d9-3d3b-9f53-d83cfdca01f9@virtuozzo.com>
Date:   Thu, 18 Nov 2021 17:54:39 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211118093032.31c06b11@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::15) To VE1PR08MB5630.eurprd08.prod.outlook.com
 (2603:10a6:800:1ae::7)
MIME-Version: 1.0
Received: from [192.168.112.17] (94.141.168.29) by FR3P281CA0068.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:4b::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.10 via Frontend Transport; Thu, 18 Nov 2021 14:54:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc95b8ae-a521-469a-e3d8-08d9aaa35a44
X-MS-TrafficTypeDiagnostic: VI1PR0802MB2191:
X-Microsoft-Antispam-PRVS: <VI1PR0802MB219115C2060599C669172F50F49B9@VI1PR0802MB2191.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +eVuXc40l3Uq1tcsb37lidIzUgMyUAJiVs4pQcMLIK7so8NqYCbVAQHLNPmFaNKhWSqLO0c4NmkOrlfQ+n1m7SUuUQXNnAnffzU8Kxl7OoxT5ZZx4R9TmxNYmAa2KwjfAzGMppwBFgjet9msGeHRFCK2iy/szzUccjhYAP9CjQ5d4A6PzXLDZIvB+BRBVZvsvENwq4Cw85nIIPQ+kaHIBk8ei8M38Fe6PyfXnwTTyTrAg5wEkt5EzzmsWu4OsEtVlgTP43oBuniC7FdaDO/I8I4HxjeJ6e1lkqPMN0qOz2UFzYz+TXFw9wromkpjjNuITN0cX1cMpDmhhGQl5pZWcEY1J+SDDXKDbx5FHjUNwSHb2dQiUtbu17NzUMS3QTzIJjaf3pP6/3mXt8C3tgjBwXsBuJHe3NcgEc/WzrBEtQoPKApLMJj1PNoom6GTavg4L/50ksRTlEuu5GJvXHkrhy+ofVmwFeOv+jsftyA9MU7VuJCfz0aCJtrLrbjWwwg7JEJ07QHtgBvpx0AdYQ1NayTZ7SUr65qFiUIJO8LX5zPvOt/OwS3DTrqyRkpS0NaGSeFEdTcG/+iUtmGCjZLLV6Bh7YKe0oYin28f85bfDUD6ecbBtmYTmBfhxs+0IwRMQUDkPqDApLssWSReDjTaUtAgeCylqkEteSR22/3A8oiqeslDyVrtWY0ni54SFWObxML3YLUxCe1V7IlaGs55eQNNP+HcNL/0zqgeguqVXEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB5630.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(44832011)(86362001)(8936002)(26005)(107886003)(38100700002)(2906002)(6486002)(186003)(4326008)(4744005)(31686004)(8676002)(316002)(16576012)(66946007)(956004)(66556008)(2616005)(66476007)(6916009)(31696002)(508600001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blhCTko1Ri93Nzd2ajViQnRiMFpjVXVrTFJKaU9uS3lUR1JvaFc3THVBTFRu?=
 =?utf-8?B?QVo4ZlNYWEw4ZHpwdGlvZHNjRHkzRy9jME84WG9FcHFtelpnZHBvWm9rUHJq?=
 =?utf-8?B?T2ZGazc2SXphRmdGa3E2NklZOVZweFVYemRHaGMzN3ppeFNnOGRyU0VndkJi?=
 =?utf-8?B?T00weDhnbHhmdm93dXBVdU9XSGVRcEpjZUl5dUY4L2NBdGwyUzI2VVdhVkFS?=
 =?utf-8?B?U0Y3ZE1YK1BnMGJTemNBTVdDVEVLMklRQTNtTVRhQk5QRWRJWlh0RWprdnQv?=
 =?utf-8?B?ay9FVHZPcjE2emt5UVlBeXVzR2FoNmpZN1Q1bGcvc3lidXpzeGxXYjJqL3JV?=
 =?utf-8?B?Vk1sSUh2Qnd4MVVSelI2TU5JN2t1dDg2WnZaRFY4TytKdlAyLzdxRXo5Tkxx?=
 =?utf-8?B?SzYzTHFma1ZTeUw1SFM4ZVhsckEvSzJjQlU4M3ArWmg2a0huV0lJRVB2MUJR?=
 =?utf-8?B?ZFJoamN4WkZnWTZISWkvOFkwSGk5WHhwQ3NScGVYMFRQR1NvcTNXR2pua0Q2?=
 =?utf-8?B?bi9UV1NveFVNUUxKWTlNamxiR0VVclNiK0s0QUhoWUQ5OUVNSkMrRHRyRTgz?=
 =?utf-8?B?VUYxTFFYT2JORDR1UUNOUkNUTGNsVUlNNVBrdGljb3JqajBoMVkyRVN3SXFR?=
 =?utf-8?B?RndMK1RlckZubE9QRmpjZXEzZjZCQWVpa0xkTk1yMGZSREVLY0hDTk43YnlJ?=
 =?utf-8?B?ajRGeGhxNzlhZ0FDWm11S3c2azRnT2NnQ1ZFMGdwanQvakdRSTE4VSt3SU5X?=
 =?utf-8?B?dHBLN1VUaVRYY1NjL1lFdE1xNUVXMHZpQ0NHdDFGdFNoQ1dscWgyWnUxb0pV?=
 =?utf-8?B?Y21uREhnM2dUWVNHcmcwdVhDVkNCd0w3YjI4cGd4UGtOUnErbTY3RytnTGNR?=
 =?utf-8?B?OWJxN0ljM21YaXhIN3BLOXpROURHMW03Um1wRUIzQjJ0b1JXNWJmUDgwbGNM?=
 =?utf-8?B?eFBpL1ZpcUR5OEFZb3pTUms0czNScXdxM2hwSkFtNDl0ZUNHM3Q5RUpieGFV?=
 =?utf-8?B?Q3FhZEJwMU1YUlE2K3VUdVBvdml6cCsycjRZZzRUc0QyaDBwcXVQWWt2VHp0?=
 =?utf-8?B?Mmk3NnRBWS82blU1c0xSeTFKamJvcmRQK09FMWoySkxqRXNEc1d6K3V6by9m?=
 =?utf-8?B?RXkzTkF5a1djTEdLWFNTT3dxVTQvaXNyZURGcW9pTDhUZTluYXBQcW9DRW9a?=
 =?utf-8?B?VU5SYURvTkt3Y0QzUlBmMktBYVFVTnN1VGttRHg3QzFnenVncEZOTEM2VHh5?=
 =?utf-8?B?eVV0YlFuS25FY1pyK1ZxWEdRY05sOTdScnF6dG1SUEdUUzRUTjRXalpDeW1N?=
 =?utf-8?B?NVVmRGwzR2xwWkVPbDllcDBFVUpiNXhicWN2Q1FycjRCcy9IUmgwKzMyWE1u?=
 =?utf-8?B?MmVrMzNmSEx5YjdNQkMvUXVBc3F0cUYxazVQdDlTSmJGTlJ0S2hqS3ltNUZG?=
 =?utf-8?B?cWtCeFhRdTNwQndSbDNrOFRxU3lkQlBDQkh3dkJmRk15YnNoOXJUSTZHUXhG?=
 =?utf-8?B?Ykl3cmpsNFBhTElubU1mZGtYdXIrcE5uZngxTm4vVkxqZEZmbHQ5WUJyQnZj?=
 =?utf-8?B?ZmJJMTZrMzlzYTUwTk5HNmo5UUUvUDF3RE1ReGoyVW5yLzZIWDUzQkdxeTJ5?=
 =?utf-8?B?UzlkV1VJQzRxOWt0Zk0wRnMzU0xQVW56T2ZTYmJRNTBKWmhhcER6aVNrTDdi?=
 =?utf-8?B?MlpQaEZ3aUhLZEFKbHgvcmVna3ZjLy9EVjJGbVJyUWZPWHhZM2dTWlc0eko0?=
 =?utf-8?B?dlNRR2hKc1BjR0VhY1RNZzBORzhIRzZTSmUvRlpsRUMzWG5yb0ExUERzY2Fk?=
 =?utf-8?B?OXFTU3hyK0JSMURqL3EzZ2V5a0E3aDNPYTg3Q0k2b1F3MjA1bVhsTnc4V1Bm?=
 =?utf-8?B?ekNzTFBwTUVPcmFENWhSSWhrWWFPRUhGY2RqblRKb3hzeXc1Y2NyN0RCQ1FB?=
 =?utf-8?B?eUU4eEErSDhvdjF3UVFUdmRxaWVBZGhwOUdBa1dTUTFleEZjN2NsN0JtMTdi?=
 =?utf-8?B?Ym5OR2VFOXlIZTFUMWxtOC93NTV0QmtDZEMzQmRsSDgzMGp2RFMxOURzTTVk?=
 =?utf-8?B?eGljK3RKZEZ1ZjlOQlg5U0tPZm5TOW5NTmozdmF6YkxkaFFTd1ZiUmhVZzQ1?=
 =?utf-8?B?WnFMOW5nclByMVFYeFYrU2ljNHA1NURRTmJuUnZzRFVNVUpIWUJoZk4zVlZF?=
 =?utf-8?B?Vk1GQ1I2cDFpK2p4aVZja05aK2hlNFlvRjJueklxQzh4WE94RXc5L1h2Mnor?=
 =?utf-8?B?WVBFZVgwT0oyaXRBaUdQQVhLQjVnPT0=?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc95b8ae-a521-469a-e3d8-08d9aaa35a44
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB5630.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 14:54:42.4125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iLDOv/s4pQD7xefPtYtJOFWeokQLauQYZNz0iHoKgPtm8/3BPLFmPF8XIY61MltFRpUv2gvMiSyGuO/EyCiqV12iKbTswoHi6X16fUCpPP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

>> If testing seq->full condition is preferred over forcibly consuming args from va_list, then such a test
>> shall be done before trace_check_vprintf() tries to use va_arg(). Will submit a patch doing that.
> 
> I'm happy with that patch, but can you please resend it as a top level
> patch and not a reply, otherwise my patchwork doesn't catch it and my
> scripts will not work on it.

Sure, doing that now.

Nikita

