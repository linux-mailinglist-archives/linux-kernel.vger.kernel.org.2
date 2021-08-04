Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 020023E001E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 13:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237598AbhHDLYP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 07:24:15 -0400
Received: from mail-eopbgr70139.outbound.protection.outlook.com ([40.107.7.139]:20506
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237437AbhHDLYK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 07:24:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jnBa5JFs6HQwxBZC4DHsr9lkSaG9WYr7rRVu9DzSidSsiX32tzEQDD6oJ6NU+OlH1VHwsb9r/4/TPgknEXuFYTbZxmUoSvg0LCjSI2gBqjp/UP5jDs147ud/2kHCOyUll5GBuRa4m4LS9r/hsQoudErYNcOOIUnl1AL/cR9+0lAmV0NFLo7z+qbNQdnXTQClwtJtOMFR5vQS9E9OSP23c9MzHVxQpLpD+1o9ge0IGvXNSQ/c7kv7jgf3gJ5oCTwOq6mcxoQ9OFKLPHMWtRxskGWbp2qaFUiJpC+OCVEs/treSMFb1mKL0AT2Ezafzh5kj2VnBdHVIh2nn4fQqhvETw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rHsJJ8xiCOYnWBdvTwCo1xWbC/ywSGWKCUjMznN5r8=;
 b=d6FL5r+Q8XD4bBEzfFhDRP0+UfxrSzrSwqetERFpf4fB8/8H9Hz+3eMHTU6JYfNu5Aaem2NQ/hS/theOYIo4rRcJWl+P4ivZv0bn2GA+OyKixiWWLF6fuGo6w3MXHTQN3l6DTl2CRZTnmwZxGjyn9YozhMSu5uvzjXkrIBbSJjPauEFEZXuoyjgWdAFpIdE87dTcX6n7LMGu1fJpvPkXFccuAOgGk2qXGE/l6AkTDtkTgeHYGUtUmjZojmNTByJs2WW0w8bi17C+rc8m/UiVzxiT4P4vbIVXZcn3SC/e25qJacV+C3isWKt8pPn51iphDOpCTai8b0qhbvHBCm9MLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=silk.us; dmarc=pass action=none header.from=silk.us; dkim=pass
 header.d=silk.us; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KAMINARIO.onmicrosoft.com; s=selector2-KAMINARIO-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1rHsJJ8xiCOYnWBdvTwCo1xWbC/ywSGWKCUjMznN5r8=;
 b=p3nm1DbNhhEqcdUiz01eiAeHqnuHpTlGaxn9u2BBEGDiP9y7Q1Tep95NRiHwHZiEdLklJBWiPCA15kacsvYHOm3mq6btZ8v50i3ll5dtuHNk6GQaRhOfAQblWtv9rrseEsI2y2cjcJfE5qotrrpdTEilAS171+flgKetlwctSJs=
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 (2603:10a6:800:2b::12) by VI1PR04MB4544.eurprd04.prod.outlook.com
 (2603:10a6:803:6f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.21; Wed, 4 Aug
 2021 11:23:52 +0000
Received: from VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f]) by VI1PR0401MB2415.eurprd04.prod.outlook.com
 ([fe80::dd8e:4155:4fa4:605f%11]) with mapi id 15.20.4394.016; Wed, 4 Aug 2021
 11:23:52 +0000
From:   David Mozes <david.mozes@silk.us>
To:     "20201001013814.2435935-1-sashal@kernel.org" 
        <20201001013814.2435935-1-sashal@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Topic: Re: [PATCH] x86/hyper-v: guard against cpu mask changes in
 hyperv_flush_tlb_others()
Thread-Index: AdeJIrv1C1ZBRIv3SEuOCi2rqG3H6g==
Date:   Wed, 4 Aug 2021 11:23:52 +0000
Message-ID: <VI1PR0401MB24150B31A1D63176BBB788D2F1F19@VI1PR0401MB2415.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=silk.us;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aae9b2e6-02c2-424e-4b1e-08d9573a5699
x-ms-traffictypediagnostic: VI1PR04MB4544:
x-microsoft-antispam-prvs: <VI1PR04MB45446EBE32BB82A27914E61BF1F19@VI1PR04MB4544.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLHckaEuNEwx/XRCR/gFeBNcDbgeyt+spSVO2ESfNcG3BgBXN/zK6gMou2+mvm+dHeVHg9H5Eu2Dr3cRhOhusKFG9eirlF09jzpXFsm+lIgB34prTeWqXQGlBU1t58Nra6TKvE/HtFCHT5Vcu5Jg8Rb6THtu9MiI0QMiF/9V+hfA+/eWIrqxomAvbJ5IaUJADPLtOHFZ06MTPi6CMd41ZrGp+n0L3uR3jvMWeYZYbXG6ymPzoz69Hc6wSC0mwOMQG9rCYKfQL9SmcyB8yK04oesLHJsTa3dfCIOcPuC2jW05lzxmONjfIJ9YDcykxfV6ZQEXpa/SG4iMIkXUM38TiuMN4fLy9LNQOtII5yoQmOvHd+XzkcyLbcswJg6a+Nk5OGl/Z/s2TrvMCKBVXckdjWa+XDiSGYcnmOm3pbV25WsCU9W8RXT0JgccxCGvCCEJFX0oWuY/atbJdNZUtyRXYY2/f83LvnHM5E204xOsbhoZsJYoMYdS09e7AyDMjVyKBrUG+ttLZ5Y285dZAvc6ysvClCLLxfjv7tJ+n0IfTK2MuRiolqzYDKzmC+9eDj8q8hcujpAZsYkr9zM0eedhdmOLB7TYrO3FJmIv7JyWI9mMF5iHY5E2jmtWw3sg8gUjBxlMxTNyq6uXkYXP/Ewl/UiVgImdfp7F8fH8K0AwNWQh2BK7jDCfYmIV1HYT/VZ2j6F1TVwlJpeaJFAD+XAtcl4n6tUwsk5NiKaV+kVkj6k=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR0401MB2415.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(136003)(366004)(346002)(396003)(38100700002)(44832011)(110136005)(7696005)(122000001)(55016002)(26005)(316002)(186003)(6506007)(8936002)(33656002)(8676002)(38070700005)(9686003)(66476007)(508600001)(71200400001)(2906002)(45080400002)(66446008)(66946007)(64756008)(66556008)(76116006)(52536014)(83380400001)(5660300002)(86362001)(80162008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ntJgpdpRDa5XyxEWMJpm8xpIxXhm3PGoZ0goLa3Jss7o1/QNi+mdMXhFSD0J?=
 =?us-ascii?Q?ZkRTOq9uIe0QEcK0Wg21LjgmHDxvBj1hFzu2NaT6otZFKXdfPy2+ny6T1cJI?=
 =?us-ascii?Q?z3sAmUpcL5Nv84SqynqWIvN1mQaxHrShweOdSRgNyS8xxQ+4LnzdB3FL/nS1?=
 =?us-ascii?Q?QkVIc6mXHHQdIc/m2nySA6S4Gf2jBKaQ8mfv+hldr5bb6Wm+2/prX+YfT0eJ?=
 =?us-ascii?Q?wXD448n0gDcZ29/eKExJc4a4Ree3pNnLOA5augp5R+WqGXp70Aw0GpAwCbzV?=
 =?us-ascii?Q?ZILvS6DR/ya5PyPQJP5HnXQK6is7uOCyOLZOC0q5YNOULWniCrWcPa50MZYE?=
 =?us-ascii?Q?60OYMBvE5xPItmTmjDo/3T4n+09I2ANHRfdBF3fhGSr3vU28KlN+LB3rngVx?=
 =?us-ascii?Q?kQhLuKAapA6W8msAL2E7XaThhf3iIdNESfx9Ii/qfhRI2qH1CHboYJQ2NMO7?=
 =?us-ascii?Q?xYdjYSv6gEsp2LkGy1GI2ziaPIhFd5ByHWbOLiS/QOw4csEHncWgLdOiApDz?=
 =?us-ascii?Q?vBnbI3c6FMMEzNBRS9pWTitEhSR/th0JLyFvyMQxewTnpw++p4ZsFbsUPSuH?=
 =?us-ascii?Q?krsHxzXzJK9yj4lSiNde5efF+/zEGwHnm5xp4ZojvcRDhZ51fjya9J7drTgh?=
 =?us-ascii?Q?wWB4XbU85cUAF25Bzdkx0Aa39aBK38rKCf0dWixi4A/1xaTol8a0eH54r3Jd?=
 =?us-ascii?Q?Q3o/UeclCOOuTLbJ6Qf+24lM5KgBh1EOPLHOpxRSLkiyiNpH62TrjkDNelrF?=
 =?us-ascii?Q?qbJ7xnbyu58IyJSuOuMkDdIz5gh/PJuubJpps95meMPpJIB/IWAB0c4Zf7me?=
 =?us-ascii?Q?HE8vohLyPTOPTPQP06v5Gfcc8sfkoyR/eVqJ1OgAfj4BIlf0OLys7KN0mUy+?=
 =?us-ascii?Q?k9dY9qZMkvg+86Ca4BB3l8pn1OPiRl3lEi7IBtsVGVkdlOxwXpaXUed5FSqE?=
 =?us-ascii?Q?WJj7gt5ULmYlnDRGb//JBoROqt4gVGpycHFOQ6HkxQ38KTzPoJoWk1voubCu?=
 =?us-ascii?Q?T+ih92wh6/U++7GwbFmJWzpeKAx7MrOBEIvrT++zoOnOiFdYEXWvaBWcJiDv?=
 =?us-ascii?Q?axqYh6pJhGKyu2t4d8Xs4lKzZXfwciI5pMEtP6OSX2sS8vfP1bYHwiOAp/kH?=
 =?us-ascii?Q?NEiyQI4JccFpmlITR8IRnKalMH46DrIG5REiicO0bESq1U5IiMoArEuuVSSj?=
 =?us-ascii?Q?8LqxxRgq+mpCDiJFxW01dvkNujxn3ItJtUpgkAJaLOXUpuCfr6TTpW/do0q/?=
 =?us-ascii?Q?TQHtcd2K/ARPhn5w/wMUxNkEleuNGHwKVhx5laXdMmGJrHFq6tETG7FaviCt?=
 =?us-ascii?Q?USM=3D?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: silk.us
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR0401MB2415.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aae9b2e6-02c2-424e-4b1e-08d9573a5699
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2021 11:23:52.0683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4a3c5477-cb0e-470b-aba6-13bd9debb76b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2xOkuNzXrorBA4zXAbcnSRuu+bTsov97ZFoUd4DsKbzPFCWZsXUHyxA1e85ii90OWND5wxg0XbXGZW3iVjL0eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4544
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
The problem is happening to me very frequently on kernel 4.19.195=20



ug  4 03:59:01 c-node04 kernel: [36976.388554] BUG: KASAN: slab-out-of-boun=
ds in hyperv_flush_tlb_others+0xec9/0x1640
Aug  4 03:59:01 c-node04 kernel: [36976.388556] Read of size 4 at addr ffff=
889e5e127440 by task ps/52478
Aug  4 03:59:01 c-node04 kernel: [36976.388556]=20
Aug  4 03:59:01 c-node04 kernel: [36976.388560] CPU: 4 PID: 52478 Comm: ps =
Kdump: loaded Tainted: G        W  OE     4.19.195-KM9 #1
Aug  4 03:59:01 c-node04 kernel: [36976.388562] Hardware name: Microsoft Co=
rporation Virtual Machine/Virtual Machine, BIOS 090008  12/07/2018
Aug  4 03:59:01 c-node04 kernel: [36976.388562] Call Trace:
Aug  4 03:59:01 c-node04 kernel: [36976.388569]  dump_stack+0x11d/0x1a7
Aug  4 03:59:01 c-node04 kernel: [36976.388572]  ? dump_stack_print_info.co=
ld.0+0x1b/0x1b
Aug  4 03:59:01 c-node04 kernel: [36976.388576]  ? percpu_ref_tryget_live+0=
x2f0/0x2f0
Aug  4 03:59:01 c-node04 kernel: [36976.388580]  ? rb_erase_cached+0xc4c/0x=
2880
Aug  4 03:59:01 c-node04 kernel: [36976.388584]  ? printk+0x9f/0xc5
Aug  4 03:59:01 c-node04 kernel: [36976.388585]  ? snapshot_ioctl.cold.1+0x=
74/0x74
Aug  4 03:59:01 c-node04 kernel: [36976.388590]  print_address_description+=
0x65/0x22e
Aug  4 03:59:01 c-node04 kernel: [36976.388592]  kasan_report.cold.6+0x243/=
0x2ff
Aug  4 03:59:01 c-node04 kernel: [36976.388594]  ? hyperv_flush_tlb_others+=
0xec9/0x1640
Aug  4 03:59:01 c-node04 kernel: [36976.388596]  hyperv_flush_tlb_others+0x=
ec9/0x1640
Aug  4 03:59:01 c-node04 kernel: [36976.388601]  ? trace_event_raw_event_hy=
perv_nested_flush_guest_mapping+0x1b0/0x1b0
Aug  4 03:59:01 c-node04 kernel: [36976.388603]  ? mem_cgroup_try_charge+0x=
3cc/0x7d0
Aug  4 03:59:01 c-node04 kernel: [36976.388608]  flush_tlb_mm_range+0x25c/0=
x370
Aug  4 03:59:01 c-node04 kernel: [36976.388611]  ? native_flush_tlb_others+=
0x3b0/0x3b0
Aug  4 03:59:01 c-node04 kernel: [36976.388616]  ptep_clear_flush+0x192/0x1=
d0
Aug  4 03:59:01 c-node04 kernel: [36976.388618]  ? pmd_clear_bad+0x70/0x70
Aug  4 03:59:01 c-node04 kernel: [36976.388622]  wp_page_copy+0x861/0x1a30
Aug  4 03:59:01 c-node04 kernel: [36976.388624]  ? follow_pfn+0x2f0/0x2f0
Aug  4 03:59:01 c-node04 kernel: [36976.388627]  ? active_load_balance_cpu_=
stop+0x10d0/0x10d0
Aug  4 03:59:01 c-node04 kernel: [36976.388632]  ? get_page_from_freelist+0=
x330c/0x4660
Aug  4 03:59:01 c-node04 kernel: [36976.388638]  ? activate_page+0x660/0x66=
0
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? rb_erase+0x2a40/0x2a40
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? wake_up_page_bit+0x4d0/0=
x4d0
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? unwind_next_frame+0x113e=
/0x1920
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? __pte_alloc_kernel+0x350=
/0x350
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? deref_stack_reg+0x130/0x=
130
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  do_wp_page+0x461/0x1ca0
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? deref_stack_reg+0x130/0x=
130
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? finish_mkwrite_fault+0x7=
10/0x710
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? unwind_next_frame+0x105d=
/0x1920
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? entry_SYSCALL_64_after_h=
wframe+0x44/0xa9
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? __pte_alloc_kernel+0x350=
/0x350
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? __zone_watermark_ok+0x33=
c/0x640
Aug  4 03:59:01 c-node04 kernel: [36976.388639]  ? _raw_spin_lock+0x13/0x30
Pattern not found  (press RETURN)=09
