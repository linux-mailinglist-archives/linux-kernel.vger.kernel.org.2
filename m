Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B4137BB46
	for <lists+linux-kernel@lfdr.de>; Wed, 12 May 2021 12:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhELKtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 06:49:50 -0400
Received: from mail-eopbgr1320085.outbound.protection.outlook.com ([40.107.132.85]:25614
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230184AbhELKtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 06:49:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPbrOjDI8sMyrPUyy5j/zFORvAkKjxdYbDm+aEqyWVbbA94qPT8Ws/IB7svWIsttzt31nV++g3ZqGiYWNynW3ba0rBQwCk20vww2OYxAOeXwF+eURShBlq3rSN6CLyhA9xdLn2KAhe4PXp/FTqu9Q8I5ic9Nx6utyF8Xu5mB8d+8hcaDXgzF+Dzkt/HpQHxE52LEyPGOij7NrzarpOC287hZXquzyrrjpX9tNuNBe5+AtaK47zioNOSSNW5OsuZzPydS3zOLodBIXdUaJdgnYxUocth/558jfIFutSzXFFLWFJ7ofzJc9XrBjWAKjxwnQZlILsEgD73wa4Jq8GJm4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVJ3hwJK5vXAE3PaOxZJ97n0NRcY4xehipcRt5TjZI0=;
 b=kNrkiuksSdfmGggbYrhw0omfRx3IcM6Ksnr9+5qRhT9j4SFPsigeR/TyrsoT8J58itELZUSrdvd0n26OkU6spPoPAv44OZDNTwUAE3Ek/wccuMuEQbLCneBZmIIacpBFa7EU4YNiBK86fUMo71nca+3xCKRt1aXdj/KTpIyxytLLLTih4ZH7DPhw6j/S/H2Q2xJBeg5B1/gES85HaX5YKYfdTh4hFGwGkN28cBz+pYZH//AqKb5mc4q45uPJ+qaOzoHF8Tw1GQdIWJAZp/je8gOCH5XvMKcvMaDINOREPFgrgm8yS6TdTyv5mQc2Ai91GspBARXMbBFMIpHj4bso6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVJ3hwJK5vXAE3PaOxZJ97n0NRcY4xehipcRt5TjZI0=;
 b=hCeLFOY3leAduIanIkYwVlSCOS7G6lB7kuwtSTCQwoA6fL1UOJG0hm4u28UQ+24tyqdzVl02Y68IkZsaT8e96vD4LHg1GvUW0Alhk5CSG7eog8Ud447ivz5htY6Oll9q6xzR/TtBNAdqGy4NdT13bKFhiFQ/9ANTE+L4Kcjw6fo=
Received: from TYCPR01MB6637.jpnprd01.prod.outlook.com (2603:1096:400:af::9)
 by TY2PR01MB2409.jpnprd01.prod.outlook.com (2603:1096:404:77::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 10:48:39 +0000
Received: from TYCPR01MB6637.jpnprd01.prod.outlook.com
 ([fe80::2c85:38b9:eebe:b58b]) by TYCPR01MB6637.jpnprd01.prod.outlook.com
 ([fe80::2c85:38b9:eebe:b58b%5]) with mapi id 15.20.4129.026; Wed, 12 May 2021
 10:48:39 +0000
From:   =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "shy828301@gmail.com" <shy828301@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?iso-2022-jp?B?Tk9NVVJBIEpVTklDSEkoGyRCTG5CPCEhPV8wbBsoQik=?= 
        <junichi.nomura@nec.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "ktkhai@virtuozzo.com" <ktkhai@virtuozzo.com>,
        "guro@fb.com" <guro@fb.com>,
        "shakeelb@google.com" <shakeelb@google.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "mhocko@suse.com" <mhocko@suse.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: [REGRESSION v5.13-rc1] NULL dereference in do_shrink_slab()
Thread-Topic: [REGRESSION v5.13-rc1] NULL dereference in do_shrink_slab()
Thread-Index: AQHXRxxdB7vXvnhRKE6hBVfzFraLUQ==
Date:   Wed, 12 May 2021 10:48:38 +0000
Message-ID: <921e53f3-4b13-aab8-4a9e-e83ff15371e4@nec.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nec.com; dkim=none (message not signed)
 header.d=none;nec.com; dmarc=none action=none header.from=nec.com;
x-originating-ip: [165.225.97.77]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba027b20-5017-45ad-8da6-08d915338058
x-ms-traffictypediagnostic: TY2PR01MB2409:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB240983151A0603411788C18283529@TY2PR01MB2409.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XPiLXoYImrQR1iisapdfn2IVY4HndKj/ctNi4WpH9PUM79j7Gnb9gMHDLo1CdEnTsm0qyUZ4NTRzOWORid83a6PLGCwulEGGQDKDwzFOCF4x1sl1S+tG2szYXQ0s/5eOlR+gErbdE5N3jk/4zINkw5L24xx6eEw/LI7BC+RJR4btqdZgpxlTZbigHNni+4D/YmNnTZreziU8HsH72Bnsfg86KENDtvqcLBJx9Ha9pQBiyFrXigMpqmRwllmN1H1yRJFVV7OB9gg6eXxP9FFH7eZLoZqOwqeRWSJ/BkUDeyTPmE8bJWAARADAdv9FGqwTM2URumy7JheGNbK3l0/07LmlI5kKK67uQIqoWir9Fb0X/wLd+uqbKA0xNCVz2pCVBtgT2EqH/IqS0yN4CAPxOvsdK8o8ZYHOwsRY4tWk4TMC43kxpJrzhPWOGvlU3AbMzFfh/sA0xGS7P7eWkiU3wf1rVbs0IU86GI7IORYKgoaRM6MM9xUTqbL411TxrtxNGKL1YwMSFbg1scfutQImHA7bI6JHBXysi+Dc6v5qVfsyywKy6z237GuXobimnCvu9GN4POSTmWSc8TYywKZskdKO2gPbqZ4jLZzV5gOVU0fCej521ECmSmM4GlFNRdlM66MPLIvz/1Ahko5kRUl7ypinjnl9TGgyDRBsu4uR13M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB6637.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(478600001)(86362001)(2616005)(5660300002)(45080400002)(4326008)(76116006)(31696002)(66476007)(66556008)(8676002)(66946007)(8936002)(64756008)(71200400001)(36756003)(66446008)(7416002)(85182001)(316002)(122000001)(31686004)(83380400001)(6506007)(6486002)(6512007)(186003)(54906003)(2906002)(26005)(55236004)(110136005)(38100700002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-2022-jp?B?R1VMb1pTWDIra1N4aG5zNkhUbm5iWEI1WDhVTU9CNnRwYnpPWXBDTjBi?=
 =?iso-2022-jp?B?Q0c2S3NwS09tMnQ4Z1VFSjRpdXh4U1QvaGtid0YyTWtJdmhqdVNFYmh4?=
 =?iso-2022-jp?B?bnN2VWw0SktHZXB4eWFQUFhuK1ZnUjFLa3RGTEdhUzN0RWFYQVgrZGsv?=
 =?iso-2022-jp?B?bmRRdEd3SVNJaVRRSGNOdXVLV3JlSDdwSmRhaTNpdG1xMW9mVWdqbGpY?=
 =?iso-2022-jp?B?R3o1TzVzSk42NVlWUzFTdGx3bXJiUzl0eTdnWDdCUStxcFQ2c2hpMngx?=
 =?iso-2022-jp?B?TkdKb3hxRnpBK3RNYzdkV3ZMSGJyaHJtYWRUM1F5U3dqKzNHdVFHVHNT?=
 =?iso-2022-jp?B?UUxMN0M2LzNJWWZwbzNEQzZ2TVc5TEZtUmo2R3hoZHRXV1pSdTUyZ0RS?=
 =?iso-2022-jp?B?ak9JRlljNXlUUFhDNkFQd3BEejJGbVlncE5HYURjV2ozTVBYdmVmMDA3?=
 =?iso-2022-jp?B?ZEt0TFpQdXRGWDgwM0x0ZlkzbGxjc1JTSnZjSWtEK0tDM0VuRnJDaVkx?=
 =?iso-2022-jp?B?alJJM0pLL2NJYU90cDZRend6VmkrTTdhSjMyQXpkV0dXdU9QekM2SjR5?=
 =?iso-2022-jp?B?Zzk5RFpEcE1OdzVlSTZ0OFVVRHZQOStvSi95L1VCRCsrbXhyMEJOaTlO?=
 =?iso-2022-jp?B?YjZCdHo2SVhVZTFpTXgrQm5TU25LcTRERmpKY2lMMmU5enBwbW5TTmF1?=
 =?iso-2022-jp?B?K1N1aGNVcjBnS0tHZTExTjBEUURaQ1hzaWkwWmF0aHpMVlZEZEgvYnlx?=
 =?iso-2022-jp?B?WG94TW55Z3dLVEpWbFJtZWlnemgreWxBTkloUGJ5RzhzUXdPRlZYNzl3?=
 =?iso-2022-jp?B?ckdybFNxTmVvMmlaMGVBcjQrbnJ1aTk0Kzh2bjY5dC9XSjRYU0diR1Nn?=
 =?iso-2022-jp?B?YlNSNmxsbGUxU3UvUnZEYi9GYmVEcktCMmZYNWtHc3FKVk9jZTNzT09m?=
 =?iso-2022-jp?B?Wjl5THJvWHo3aGV4NVhPRkxjWnBKTmFYcE01SEhJZFJNZDIzOWJnUW5P?=
 =?iso-2022-jp?B?cFpCN1ZKbTltdFNHOXJJeWRXMmdkYjJSdUp6bzFUQjcrWUpiT3J3YzBm?=
 =?iso-2022-jp?B?YWczY1hNOE9Xci9TTkNqN092UHZZTGoycFErR1VaUzNDYXdyZVNMTWxz?=
 =?iso-2022-jp?B?L05uUFFBUkhjMFhoWkdMQW0xVk1VNEs4RGhPQm1ab2NkSTZuMStsaWVu?=
 =?iso-2022-jp?B?enpwRU5USFlWUmxCSVQ1dndOL25hNVI0QnJrQTZxOVlIditMTCtoWE5y?=
 =?iso-2022-jp?B?c2w0SXd6aWpnTkwrMVU1L3RGOWs1S00wajd5dlZyczlBUVhpeFpGaW9I?=
 =?iso-2022-jp?B?OWpONnFiZ2ZDY29jb0Z6RDhzUXFNR0FDVHFnRHRSRmlMRldJS3o0ZVdC?=
 =?iso-2022-jp?B?Q0xPMVBUeWFLN0tYSGVMZ0hHeDA1TU1lbXJ0T3Q3UWVvYXJvSDcvOUcy?=
 =?iso-2022-jp?B?ejRQbHk5MkF0T0huUVZGZy94SXlMVGRxc1JkMGtMb3RuUUh6R0RqcHZ4?=
 =?iso-2022-jp?B?Nzg1MkxMdDE0T1BiTW8xaGxqd25lbUZMKzNQTkw1UHpXQnNNR0QxSk9S?=
 =?iso-2022-jp?B?Z05PSlJwSzVyVzBESzdvZ1R2QWpIbjJVRHdQOHdjUGgwMDhtM2J5VGwy?=
 =?iso-2022-jp?B?L3krSUJUbjV4eEphMGI3ZnF2M3BVRURmMzJyRGp2bWNDMWowdVkySThj?=
 =?iso-2022-jp?B?d1BMb2NhbVkvcm9ocGo4NDV0SWhSNi8xUTQ0VS9FbUEvdzVkSWJINW8z?=
 =?iso-2022-jp?B?MHlWakkzL2M2SnRtWDJUNy9MNlZEV0FGWkZ4Q24vNlYzcVJrWVVkbFpW?=
 =?iso-2022-jp?B?NG13eFBvWS96NlAvY1BiM0E2RkV6cDNmYU9za0Yvb3pPNHl0SHhmN1pU?=
 =?iso-2022-jp?B?cVg1bXRpeU1vZ3gvazI1VWZRc1pKOXZIelNLNFBHY09NbzVTWnVMQnhB?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-ID: <EF8B3ED6D36A4F498E758440875006F0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB6637.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba027b20-5017-45ad-8da6-08d915338058
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2021 10:48:38.9203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nM/SnQAAktG2Dk2pVGolP1j9fDZjW9Id94+1rzPJmjeOjddhJIhi6nEU0PZ2jDEkea6ugEi3a4ZMBeMvmEQYyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2409
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5.13-rc1 sometimes causes NULL pointer dereference during kdump, where
memcg is disabled with "cgroup_disable=3Dmemory" boot option.
I haven't seen this problem with v5.12, so it looks like regression.

[   73.199590] BUG: kernel NULL pointer dereference, address: 0000000000000=
000
[   73.206593] #PF: supervisor write access in kernel mode
[   73.211845] #PF: error_code(0x0002) - not-present page
[   73.217010] PGD 0 P4D 0
[   73.219556] Oops: 0002 [#1] SMP NOPTI
[   73.223236] CPU: 0 PID: 95 Comm: kswapd0 Tainted: G          I       5.1=
3.0-rc1 #1
[   73.239418] RIP: 0010:do_shrink_slab+0x85/0x2d0
[   73.243977] Code: 49 63 44 24 04 be 00 00 00 00 49 8b 4c 24 18 f6 c2 02 =
48 0f 44 c6 48 85 c9 74 09 83 e2 04 0f 85 19 02 00 00 49 8b 4f 38 31 d2 <48=
> 87 14 c1 48 89 55 b8 41 8b 77 18 4c 89 f0 85 f6 0f 84 82 01 00
[   73.262856] RSP: 0018:ffffc900001abc18 EFLAGS: 00010246
[   73.268108] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00000000000=
00000
[   73.275281] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000000=
00064
[   73.282454] RBP: ffffc900001abc70 R08: 28f5c28f5c28f5c3 R09: 00000000000=
00000
[   73.289628] R10: 0000000000000000 R11: 0000000000000004 R12: ffffc900001=
abca0
[   73.296800] R13: 0000000000000400 R14: 0000000000000002 R15: ffff8880534=
4bc10
[   73.303972] FS:  0000000000000000(0000) GS:ffff888072c00000(0000) knlGS:=
0000000000000000
[   73.312108] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   73.317883] CR2: 0000000000000000 CR3: 000000005cf68004 CR4: 00000000007=
706b0
[   73.325055] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000000000=
00000
[   73.332227] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 00000000000=
00400
[   73.339400] PKRU: 55555554
[   73.342117] Call Trace:
[   73.344576]  shrink_slab+0xa9/0x2b0
[   73.348083]  ? __update_load_avg_se+0x298/0x320
[   73.352640]  shrink_node+0x248/0x6f0
[   73.356234]  balance_pgdat+0x303/0x5f0
[   73.360002]  kswapd+0x20b/0x390
[   73.363157]  ? finish_wait+0x80/0x80
[   73.366752]  ? balance_pgdat+0x5f0/0x5f0
[   73.370693]  kthread+0x124/0x140
[   73.373937]  ? kthread_park+0x90/0x90
[   73.377617]  ret_from_fork+0x1f/0x30
[   73.381215] Modules linked in: xfs libcrc32c sd_mod t10_pi sr_mod cdrom =
sg crc32c_intel ahci libahci libata smartpqi scsi_transport_sas overlay squ=
ashfs loop
[   73.395386] CR2: 0000000000000000
[   73.398716] ---[ end trace 9752d71309d33c00 ]---

The code around do_shrink_slab+0x85 is:
0xffffffff9d094925 <do_shrink_slab+0x65>:       mov    0x18(%r12),%rcx
0xffffffff9d09492a <do_shrink_slab+0x6a>:       test   $0x2,%dl
0xffffffff9d09492d <do_shrink_slab+0x6d>:       cmove  %rsi,%rax
0xffffffff9d094931 <do_shrink_slab+0x71>:       test   %rcx,%rcx
0xffffffff9d094934 <do_shrink_slab+0x74>:       je     0xffffffff9d09493f <=
do_shrink_slab+0x7f>
0xffffffff9d094936 <do_shrink_slab+0x76>:       and    $0x4,%edx
0xffffffff9d094939 <do_shrink_slab+0x79>:       jne    0xffffffff9d094b58 <=
do_shrink_slab+0x298>
0xffffffff9d09493f <do_shrink_slab+0x7f>:       mov    0x38(%r15),%rcx
0xffffffff9d094943 <do_shrink_slab+0x83>:       xor    %edx,%edx
0xffffffff9d094945 <do_shrink_slab+0x85>:       xchg   %rdx,(%rcx,%rax,8)

The NULL dereference occurred at here in in-lined xchg_nr_deferred():

         return atomic_long_xchg(&shrinker->nr_deferred[nid], 0);

that means "shrinker->nr_deferred" was NULL.

Though I haven't fully bisected between v5.12 and v5.13-rc1, I can reproduc=
e
the problem with this commit:

   476b30a0949a mm: vmscan: don't need allocate shrinker->nr_deferred for m=
emcg aware shrinkers

but not with this previous commit:

   867508304685 mm: vmscan: use per memcg nr_deferred of shrinker

With the commit 476b30a0949a, if a memcg-aware shrinker is registered befor=
e
cgroup_init(), shrinker->nr_deferred is NULL.  However xchg_nr_deferred()
tries to use it as memcg is turned off via "cgroup_disable=3Dmemory".

Any thoughts?

--=20
Jun'ichi Nomura, NEC Corporation / NEC Solution Innovators, Ltd.=
