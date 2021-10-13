Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB9842CED7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:48:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230375AbhJMWug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:50:36 -0400
Received: from esa1.hc3370-68.iphmx.com ([216.71.145.142]:23343 "EHLO
        esa1.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJMWue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:50:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1634165310;
  h=to:cc:references:from:subject:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+W74H0Ty5Rg5+hmkhDp3ANV8rbGfZ602m4/KugyHjnQ=;
  b=NasAEe3U0pHig81OVaVy/LRxUloPnqTe6XtClv2MCR9cbp4DTpQaPg1X
   uoy5bQOBfTPOUlCLAfsNURmlfzwrnbB9xrN7XS5HV7YTk/3TuzpsnXW2h
   3eqY+kW8XWf9LkGmEpRWXlj4dbOHl9Z/Bq7TN3OuWJgV3rgDY3/XR67zg
   M=;
Authentication-Results: esa1.hc3370-68.iphmx.com; dkim=pass (signature verified) header.i=@citrix.onmicrosoft.com
IronPort-SDR: J2OfbYfEIPhPzGX+fbb4cOlqJjgNy+NS3kVQhL60qJw+RuCZ6XrXd4dfqUtiio/eKSGC9hOnmR
 o3/cNwWcpuTRkLfAiDDtnlGyhHkhbCbm2fZOjzJBZi5Su1QVMkQxoWxAuu+7KRKWhWuutCViIz
 iTdQJjhWQ6+2h/rRIVLjTQfUTHWo9r8p0n92KgqCwz8ObfLZ8O1FefP+7HMLwfsOIN29M8RFaH
 BXaBFkSzN0eXXGOF85weyyCE/P0O8Swp6zpU/9TysH5HbJ29P3GTfirMzfh03R+d8H+7I9U2nu
 Q7NWP72qf4ATQ2b0IQBg46ap
X-SBRS: 5.1
X-MesageID: 55541847
X-Ironport-Server: esa1.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:EH+9xqqgJyoDUkW3pk5je75BN11eBmKpYhIvgKrLsJaIsI4StFCzt
 garIBmGM/zYZjfwLt9zaovk8UhUusSDmtZgSgE5pSxjQipA8ZuZCYyVIHmrMnLJJKUvbq7GA
 +byyDXkBJppJpMJjk71atANlZT4vE2xbuKU5NTsY0idfic5Dnd84f5fs7Rh2Ncx2YHiW1jlV
 e7a+KUzBnf0g1aYDUpMg06zgEsHUCPa4W5wUvQWPJinjXeG/5UnJMt3yZKZdhMUdrJ8DO+iL
 9sv+Znilo/vE7XBPfv++lrzWhVirrc/pmFigFIOM0SpqkAqSiDfTs/XnRfTAKtao2zhojx/9
 DlCnc2XFzkoMJfGo8EYeRpXPhEkD/BFxrCSdBBTseTLp6HHW37lwvEoB0AqJ4wIvO1wBAmi9
 9RBdmpLNErawbvrnvTrEYGAhex6RCXvFKoZtmtt0nfyCvE+TIqYa67L+cVZzHE7gcUm8fP2O
 pdENWM/MEuojxtneVRQWZ0XkOeU2XDPUxt4r1S2/ocN7D2GpOB2+Oe0a4eEEjCQfu1Fzhiwp
 W/c+Wn9RBYAO7S3yyKC83emgeLnhy73WIsOUra/85ZCmFCPy3YBIBwQW0GyrfSwhgi5Qd03A
 0oY9zEnsKw09UGxVfHyWBq3pHPCtRkZM/JZF+Aq5QDL0bbd+QGHAWkYSSBpZ9kvtctwTjsvv
 neNntX0FXlsvaeTRHa16LiZt3WxNDITIGtEYjULJTbp+PG6/tt11EiWCI8+Tujl1bUZBA0c3
 Rjbi3YAhrsph/Uu0o+48n332QDxpabGG1tdChrsYkqp6QZwZYiAboOu6ETG4fsoELt1XmVtr
 1BfxJDAtLFm4YWl0XXXGr1UTe7BC+OtaWWE2TZS848dGyNBEpJJVbtb5y1iPw9XO8IAdC6Bj
 KT76F4JusE70JdHa8ZKj2ON5yYCkfeI+TfNDKm8gj9yjn5ZL1LvEMZGPx/44owVuBJw+ZzTw
 L/CGSpWMV4UCL580B29TPoH3Lkgy0gWnD2IGcmml0r4gOTAPBZ5rIvp1nPVM4jVC4ve8W3oH
 yt3bZPWm32zrsWvCsUozWLjBQ9TdiVqbXwHg8dWavSCMmJb9JIJUJfsLUcaU9U9xcx9z76Ql
 lnkAxMw4Aev1BXvdFTRAlg+OeyHYHqKhS9iVcDaFQ3zgCZLjEfGxPp3SqbbipF8r7U4l6QqH
 6dVEyhCa9wWIgn6F/0mRcCVhKRpdQixhBLIOCygYTMleIVnSRCP8djhFjYDPgFVZsZuncdh8
 bCmyC3BRp8PG1ZrAMrMMar9xFKtp3kN3ul1WhKQcNVUfUzt9qlsKjDw0aBrc51dd02by2vIz
 RuSDDcZufLJ/90//u7WiP3WtIyuCeZ/QBZXRjGJ8basOCDG1WO/2oscAv2QdDXQWTqsqqWvb
 OlY1d/mN/gDkAoYuoZwCe8zn6k/+8Hut/lRyQE9RCfHaFGiC7VBJHia3JYQ6v0Rl+EB4QbvA
 xCB4NhXP7mNKfjJKl9JKVp3dPmH2NEVhiLWsaY/LnLl6XIl57GAS0hTYUWB0XQPMLtvPYo56
 u49o8pKuRengx8nP9va3CBZ82OAci4JX6k978xIBYbqjkwgy01YYIyaASjzucndZ9JJO0gsA
 zmVmKud2OgMmhucKyI+RSrXwO5QpZUSoxQbnlYNKmOAlsfBmvJqjgZa9i46T1gNwxhKuw6p1
 rOH66GhyX2ywgpV
IronPort-HdrOrdr: A9a23:oTxcGq/8xfizxNjRHy5uk+DrI+orL9Y04lQ7vn2ZHyYlC/Bw8P
 re+cjztCWE6gr4Ohkb8+xoV5PsfZqxz/JICOoqTNSftWvd2VdAd7sSi7cKqgeIc0bDH4hmup
 uIGJIfNDSfNzZHZWmR2njBLz6NquP3lJxBJI3lvhBQcT0=
X-IronPort-AV: E=Sophos;i="5.85,371,1624334400"; 
   d="scan'208";a="55541847"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FoP7Vjt6jDUPsfZjgQPlkFzOSXJ88W7gJzgp7Ra0+leeehcY03ZKVnDzno6o0RcQKWhi3l4Ay/Hg7lyhRfDQ3XZ36hqWwJY/M//uC1AVdlrBzjxkysCIQFcQz6qlqt6fGJRvhSWJNIfYX6tHG3ErOLWgB7vjliGZG6JkgGqF40oiG1SKuJpyoCd4Y7YdlsmhUb6igzEUeBti4qT2D1Px4tnoUPzODahIda7td1GHtzcWoDVguzXjEVNSCuQ5Q/D01CO+Dqrpsr/E0I/PxEbn7cdmUPbJwLFI1gmQOGl6LUloSPVilmBz68kGzyNV0QgvWWUh0nYXbWx+w7vWhTVFcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+W74H0Ty5Rg5+hmkhDp3ANV8rbGfZ602m4/KugyHjnQ=;
 b=FqH+cw7mWe0FM4ZRBpMJAcJ8mZg8YpMTMTeLsA3CJJps/Y6E6BhvzgGpUm2RzWGKyC0Mouc155aXOjfTGOnrIN+k+VqqN8UoGy6SUA6spO4M+SqCcVbeZO87TqEG3nHy0g5ZzErXXOKV/UtN1UDHicph1SNQgi3R1mLD3ucBZyTqtQaIUIaLGgL0BEMMudlI4LI3tPCUDqHw4YbOVk2lLpd/a2lPQhQgtPb0l1NbU+r6P7LywRBSg3JLprI74UY7LG8u6dGCEYI8WngTuj17famoEIkYY1sUDMOPXD5e38IVsVVUQn8ufa/wxxmwBCfYSw4plvUq0cagqOjnPuKlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=citrix.com; dmarc=pass action=none header.from=citrix.com;
 dkim=pass header.d=citrix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=citrix.onmicrosoft.com; s=selector2-citrix-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+W74H0Ty5Rg5+hmkhDp3ANV8rbGfZ602m4/KugyHjnQ=;
 b=fdXf6RACdEpF16XFR8SasRo/3o2wcnptSyKOnSff8U1XJKTngb79Kh488SsVhwxQg7OwoAfZW/NViO60+4evzdKWF59N8ieN6oPoEjZwm4pjqJkHlMTHu67LEf/WzGuOMl0sxriMBIl82/++u4wxprcdqkEuIq2ixOSVRo9h+yM=
To:     Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>
CC:     <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <alexei.starovoitov@gmail.com>, <ndesaulniers@google.com>
References: <20211013122217.304265366@infradead.org>
 <20211013123645.002402102@infradead.org>
 <20211013203927.zbruy2ux7dug6ljk@treble>
 <YWdNgt47MhYTttux@hirez.programming.kicks-ass.net>
 <20211013214907.pqr3mr2m4xrh426y@treble>
 <YWdZbdo1fVd7JbBA@hirez.programming.kicks-ass.net>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Subject: Re: [PATCH 4/9] x86/alternative: Implement .retpoline_sites support
Message-ID: <0d887118-114a-b7af-ffa3-9a633e74e2e9@citrix.com>
Date:   Wed, 13 Oct 2021 23:47:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <YWdZbdo1fVd7JbBA@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
X-ClientProxiedBy: LO4P123CA0398.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::7) To BYAPR03MB3623.namprd03.prod.outlook.com
 (2603:10b6:a02:aa::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a4433808-eead-4d27-7568-08d98e9b8217
X-MS-TrafficTypeDiagnostic: BYAPR03MB3592:
X-Microsoft-Antispam-PRVS: <BYAPR03MB359206BA048DA85C0F1ED47DBAB79@BYAPR03MB3592.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZPQdYNVrfc7pEliHjIMyozI880MWra+AgvuKtHBZcQjTYvcb51UKyEn7AdDpXo1CcIxDg/vrT9TS7aVuigJLmWs6KZAwcJerX07E/sOyXnTHEkU/AI5NifmqtW/tzY1+PhQtzVsGJNHiPZgj4odjACTsHOqJohmjvGV26e0+85/ce7TKlrqMT+m1ozvmb57qYOG3G4MQqHyCebJD7qaas/FAfmSHm3qtyaRMRIX8bCHpNgusvWiEiC9zQY4LLdaK4HvnlehXkYdmb2+n8wrjeIVYNQfovNnBBLoA8a61Ix5lIkjtrh9iDPVCeYvC0XigqNLxo9bUmMPLoxGyXK5gLOps/JhOqq4dP7lq93nyYwxqBX3/y54shoPHeOmt00fZXSoWrEyTG/UA9uzUsqDpkBUhZwmXiPQyA5mDTBfTEnsbftPzSQUghCQOyxHNKZ3EuZ1aqEGiI03qZjl/y/+3ECE9Cmo4M0Tv0kgiEzrIjYrlmXqjz3C0qW0fFHkc4UzqTMLVmFnHlVmHmCxuRKd22HmlcS73/kQt6gI3zTtlxuNBgyUVJrQjfNxj+fxCXbciLBR9H0KFgKl947GppE1Ex2iz62xTzHoL7yYpQWJNkxLssSximj6NuL061it0L8x/M3fD9bE0AjmFNp0aSGZt5rfJ5r1BwNPkISfsbEty6QcocEISpcvNKKThFeG7knjGyxV3ksLGX75pa6Ye2Pj59BSZJ1DGuQs1CgZn+wwgj0zlCel0vrBuTUI/WcqAwpISyiLryslyk9dkQ/X0t5o/Ug==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3623.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(36756003)(6666004)(186003)(508600001)(38100700002)(66476007)(6486002)(2616005)(956004)(53546011)(66946007)(26005)(8936002)(316002)(4326008)(16576012)(5660300002)(31686004)(8676002)(82960400001)(86362001)(2906002)(4744005)(31696002)(110136005)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QzJTQ24xVW8yYTlEK1dSVzF4VkZpeFRNS2RscG1xNW84T1hnV2lRR1JURFlY?=
 =?utf-8?B?SEV5bG9VQlRTc25VeFU5VDBRdHdCMDBybENoOTRYa3N2TnlTOFZaWkV3MWRD?=
 =?utf-8?B?NEw1N3hxNkZBL3RKOFE5SkR2dDdSYXBCNFFoSXJyQUltNmVnSVluSUJkbGpL?=
 =?utf-8?B?MU9sSVY1WlovbHVDcngvbGJJcTc1WGNocGd1MzE1OGVyZ3Q5dGxWRlhhOGhO?=
 =?utf-8?B?Y3dVSVFJeVhxWWVwQi8reGcvdWpPSGxRL2ltMjNJTDB3amVKaHZ6M2hVUjdm?=
 =?utf-8?B?c280dVZCMjQzM1FPd2VTa05WNE02bHcvZGllTUw1VU5LbW9YK3dhOFFqeDBN?=
 =?utf-8?B?aVdUbUVkekpDdVhxb1hWMVFpVDN3Q0JkWDJrYnlYTHlaemxlQjY5SVZ6cVl2?=
 =?utf-8?B?WW9Ya0ptTHdGN3Z6ZWMwaTBKSTNrd0xGWExKcll2UVNIdC9iZ2NpNFFQSXpD?=
 =?utf-8?B?clc1TEhzc3R0cVc0MzR6MDQvOGtFdXJ5bGo1UHk1OFFLNXBPQkJrdFhoV2t6?=
 =?utf-8?B?YklCcnZidWdxRTRBSDBlbldjV0ZjMTEwcmQ5dFp0QnZPR09LandkZnJMdXpN?=
 =?utf-8?B?dG4wNXdmRlpobFljVURhMDU1djN5WVJUQVY5ckhjV3hYR1dzUzhibFhxTmp1?=
 =?utf-8?B?Vzk2a0R0QmpTY3RzVCtmR3NySzJrdC9LWnVZQVhENW1zRVhSVzU3MkNwTFRx?=
 =?utf-8?B?RURoU0JQTTkzUXJhV0FRbnlqSU5XZE1qUEJ4NmdaMVNPc2ZYbXl0VCtPNHky?=
 =?utf-8?B?QUNSMktjeWFHc1hpbEZveU1NcHNSc0tRcHRYenJOK2MweDdNZ3AyWUxXOVhD?=
 =?utf-8?B?WnM3S3h3QTFVWWw2L1RVdE10c1Y5Vmc5d0pETHpjbEVKQUtReEJLUG9mZkJN?=
 =?utf-8?B?MnJJaVZzRytTL1FOaklUYmJXTzB2N1Vhd3hUTHp6WTJJbDg3V09tdlYrWXd3?=
 =?utf-8?B?SWxOam4raWFHQUloMEFoRE9kSXp0QjJ0ZXJJaFpQYzhsSk15S09ob2dkenA5?=
 =?utf-8?B?aTRwU1ZkajRjTTI5MFNoMWEvSEJpeE5rUFVWdXBJUWQzYkpBcno2TERlRUYx?=
 =?utf-8?B?ZmZTQWJXUWwyUys0Y1B0UmxzcUVVelpQUDVEbEVJMHZkV01Vbzg0b1piaElU?=
 =?utf-8?B?eC9uSmNtK3ZPL3BoSGhQeElmeW91bG82cGxpVWpUV0lQeU5mUUNjQUN5RVQ5?=
 =?utf-8?B?SEFUSmZrM2FscE81RkdtbWgxcDV3aXlpa2VNZW16ZUdCcXk4NmJ1K0psaDMw?=
 =?utf-8?B?WXg3VUZQdWNMcU8rbVViSnRQR1lCcEIva1ErdlgyWmlVMmFwTTRVM1E2ejMx?=
 =?utf-8?B?YXRNMmY3aVIzenNDbXprRDBuRDBvY1VQRlVwRFBDOEYyeWZPRVZrZGp5d0dr?=
 =?utf-8?B?bWpkZXZyR25JZDlCenRJU0l5a0RybHl3OHJnK1BxNVVCVVBrTk9HTDh4ZkVo?=
 =?utf-8?B?TG4rN0VSc0pWWGFHUWVpM002MzRDY0NsN3Z3S2RsanR1STZZam4ya0JEUmxS?=
 =?utf-8?B?UkNDMDduS1BLaGFtd1ZqMGFjRmZQbkZXQlVPa21kRGh5TXgwbmoycGxLMm5T?=
 =?utf-8?B?bzFJdU5Ea0l1Y2JsVmExNWhOMnVhOE1GSnFTQ0RxZnVsV245ZklDaXJ3Mldl?=
 =?utf-8?B?WnVHQlM2WEJJWUlrOXEwa1VYdlZlakxQQktqcm9KcGVMQm5JTndJcFBYNTVP?=
 =?utf-8?B?VmhqU1A2cWhBeWNxYmhVdGpFaHZrejd6aVNaN1BwdXIrM2RadVNDWFJVeWsv?=
 =?utf-8?Q?7o5/Ro+xDTunj3nDk3PnXto6fEnI3bsVndD+A25?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4433808-eead-4d27-7568-08d98e9b8217
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3623.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 22:48:00.6714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335836de-42ef-43a2-b145-348c2ee9ca5b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MdbFPcHwna0lJqNnQHEqvkZhwXGmzIojtSWfKNgx2Kl0gW7gZU4DeSIkR9OHry/G9K3o8dAwrPu1xs5r5bAg9fpEe25nn6yJNHP/FFEI7To=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3592
X-OriginatorOrg: citrix.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2021 23:10, Peter Zijlstra wrote:
>> If performance of the linear lookup were a real concern then you could
>> just put rax and r11 at the beginning of the array.
> That would mean the table would have to be { __thunk, reg_idx }, which
> is even more yuck.

Yeah - it's nasty because it is a reverse lookup you need.

In both cases, it is %rax (GCC) or %r11 (Clang) and change for the other
regs, so you can construct a search which will hit on the first lookup
most of the time.

Either:

1) an array of { __thunk } with a hole for rsp.=C2=A0 Bias searching entry =
0
or 11 first based on compiler, then a 16 step linear search.

or

2) an array of { __thunk, reg }, sorted by thunk address.=C2=A0 This has an
odd number of entries, so arrange the thunk generation to emit rax or
r11 as the 7th thunk, so it ends up in the middle when sorted.

~Andrew

