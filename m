Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573C83887F4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbhESHHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:07:21 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:48723 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237212AbhESHHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:07:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1621407959;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3id1KjhwQFqi1hEvMXz76+JdA15JtcOP8MZQKQUGOo=;
        b=TolQN7iNwg6hEvGvCkzDOBjqdUOW4DyEBIdWUkv3+RK+eJkdJ9ZNJvbBtpiUo1C6TojcRs
        Y4M9TSRyYBB0BkUKfUDdheGd3DREoPcBhXHiPwvVQMo7+eekeqdbD1O9GtBvPnyRKBn3Hg
        yNM70QxVijHnrNld0dSSoSvZWA0YuDM=
Received: from EUR02-AM5-obe.outbound.protection.outlook.com
 (mail-am5eur02lp2053.outbound.protection.outlook.com [104.47.4.53]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-37-XUgV8jdqPAa05F3KOuy0eQ-1; Wed, 19 May 2021 09:05:58 +0200
X-MC-Unique: XUgV8jdqPAa05F3KOuy0eQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YkraVsEgIGtlnao1O11g85JyXEpMsaSi4SeZQBgkOzvx5yZyoXswzEoOKXQHUnJcQgh7Tae70hgb6XKndS8nsVj7YnqYM8gyt82nfpYummCzgttK1B/xyispuF6L6LFoCoNR3OU+Zk+kgvl3CV8j4lp9CS6gP9Trk9SUIcCCOV1363AU7teD3KI+lFzd0Zh/PxCEeGt6TTSEErwtgPVrLsogMyysrcLDaLKwkGA4+tOOmOgRWaWOrctohrpxpwQAIHyQSXO+CXBZnxq8mYSJuEfYS+UeOWM1RF75CvjNyjsKt185qZpEJuK/clkbVy8AnlKnr24oz0zsp4DS036NRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF+RC8x3t/j/46CofMDWyIVzU4asckKKReHPLpqpevw=;
 b=SYN6CEq889sHxH0IpKqE/wZucVTAWrT7iAnXTolg2TkfsPJerw2uskykI4fv5FeI7bHI69xk9eG4xiI/XNKSh+hzKyatLpLjMqsJArCPx8utpGVpcbl+THIa7euagurL4Ka5N+AkWSkfHRCk/3hAc/csETf/WuKvLUEM6SLAYhaxUv/rWIqBwkysS5GWV95DAXipt8uaDRCw1oHDcOshplVEGpgjszmaq7qblJKSO7Y6TRa1oIOJ9d0IOrRnYYVsQdXV8aTXPsdjMAAp/Q//1TIYe5eACzHurpzYqFyBFJ/P7rsCDIi9sKW1TJU0pkGz54uqMkl/4VoylOp2chV6KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=suse.com;
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com (2603:10a6:20b:105::22)
 by AM5PR0401MB2562.eurprd04.prod.outlook.com (2603:10a6:203:3a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Wed, 19 May
 2021 07:05:57 +0000
Received: from AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb]) by AM7PR04MB6821.eurprd04.prod.outlook.com
 ([fe80::b8b1:d726:a3c7:9cb%7]) with mapi id 15.20.4129.031; Wed, 19 May 2021
 07:05:57 +0000
From:   Qu Wenruo <wqu@suse.com>
To:     Alexandru Elisei <alexandru.elisei@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-rockchip@lists.infradead.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        heiko.stuebner@theobroma-systems.com, leobras.c@gmail.com,
        Rob Herring <robh@kernel.org>
References: <7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com>
 <09cbf655-0f13-5df6-b6a9-4a6a784e211d@suse.com>
Subject: Re: [BUG] rockpro64: PCI BAR reassignment broken by commit
 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit
 memory addresses")
Message-ID: <94fbb521-d045-3c2e-eeb8-4029e1f92015@suse.com>
Date:   Wed, 19 May 2021 15:05:48 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
In-Reply-To: <09cbf655-0f13-5df6-b6a9-4a6a784e211d@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [149.28.201.231]
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To AM7PR04MB6821.eurprd04.prod.outlook.com
 (2603:10a6:20b:105::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [0.0.0.0] (149.28.201.231) by SJ0PR13CA0003.namprd13.prod.outlook.com (2603:10b6:a03:2c0::8) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.11 via Frontend Transport; Wed, 19 May 2021 07:05:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 41768993-de90-496f-4c50-08d91a948d10
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2562:
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2562FB19E51B15208732D55BD62B9@AM5PR0401MB2562.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /HwK7qNK5I9ElfBMugJrQKOVg1mY6/DhMVPNyNS8EQ6g3SahPqApNgGuI6rz8T/O9YLohFEuBv3JDTECPgpBbYXp9amQNxNIXB92hxdQKcrpzluizYsT1K338YdtdHRliKBgT1bkjf0t71kA3yF5CPnny+4kczU27pzHOyl37zMhFvlBXzjALSwn4lFpwIUio8rhrcYuAJYWDkWOLNp9wMjvL6al7wBV2LijkjiGoqEJJEFv3rSc3AkYdYYfXqjd5Qy2pun2uIyOnyD5FiY1eUnWHOoZKQ2so3l9jt8KpE28OPHp5bbcK9Ma9B6NRJeIt0tT34vLEFfK85CMGiNZ9AIydIe6ggvQF0y9CNiiMML7P5ezGx52qR4EuBn6PAEaYhcxSseexHZL2xIG8BA6yMV6umfhWPHvdwXuk8c1MI+uxvN73MEvd4HobPj6prZIqoJ31lTAs/SZ79lF1bqGn32EJbAIHCjsAHsRRbNH9WUOpVuzt2FE2iPnAG61Za8rg0aG5+FNalYrjworbQolPwTqe5qd5H1lSDZiq6ZVE+jOWpOyUY6GngJJhphMATIMcw2728THaocmdaJL8qzNpx5yhtegS4Es8JIWxFvf5K5wWVjkugOgOhrWdp2uMC0JyEo4tOt/Jw4V9rHND+NiO2+iTNS5Pb8XM+xQquEsjQAA8EABcV3F9pBGtTa7CtXl5uoJ6+OlG0yO6XVHC4fiGyCZmTS6wEnqiHS0au0oF7IDokIVvaA2hRUIwvlIijrG/ng6BjSf1y487gy7CypzRxQW5mCcTWi4K6vVw1Lpy2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB6821.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(346002)(376002)(39860400002)(31686004)(31696002)(83380400001)(66476007)(6706004)(66946007)(66556008)(2616005)(110136005)(36756003)(26005)(38100700002)(8676002)(316002)(16576012)(2906002)(966005)(86362001)(45080400002)(6666004)(5660300002)(478600001)(8936002)(956004)(16526019)(6486002)(186003)(78286007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?OD7bXIOKlW5osfwmNEOO2pW2IjlWte99lKIGLs3f2maWmlvnbqeBXRc+imFz?=
 =?us-ascii?Q?5X+p4aUQ+iKm29wsl+T4hC3AzHDrj2uiVlguonq9YJseT9L3fGLuizneRmfw?=
 =?us-ascii?Q?Khz8y5kGIo3U/iTsMei5q3UiiK9lto2qX4L/2fFac4KtEJMzbaOJYbj9NxdF?=
 =?us-ascii?Q?MKvkEJTlQCoqGmL545c9RDsqMZ/lSWcprkrVRhfbzhhTWIyRopoCJgF6wF0V?=
 =?us-ascii?Q?523TRStu8oLrxOCKb6SxzN0LLIH/Wr1I0/PUuA4i4ZncV4yfvRhf+RN523US?=
 =?us-ascii?Q?zB7yy94/g7g5ZKyExlydVoCcOZX2cLUGKFJg79HjrX1l/i+31cn1Jici+9/a?=
 =?us-ascii?Q?xMtBEkIwPWdSPy33NuiqvdgKgydLjaAlkFKCH9YU5mM9LDAlOdGSGZ3tkyuj?=
 =?us-ascii?Q?zpn+BJlrhDUrMpkcWJmEVd9zk3Pte8eKH7w7HQW6MeciICmIMOCt4j9nOS8O?=
 =?us-ascii?Q?i7tTgpDBoQb8ot/SOXVDOnz12Mo+OQfZPK+TOJbuCRbbn+UltMpqwmCEeMpP?=
 =?us-ascii?Q?xyd6QwWi5DuP0OCglQiTMeSoy2TTtlFTqmWTcBfXOL8Bk+GCRbEgJ9cRtrnc?=
 =?us-ascii?Q?AUFBYBdPNYGlAn5+AFnyur0VRepglu2JoDlSqmd/rzoW/5MrQOREO+4V0eHC?=
 =?us-ascii?Q?1GRwG5H/oI6AZ722HcO+Y6VJ2cOQyclt1Bu0dqE4loI414QGMGGkBUq5Twgg?=
 =?us-ascii?Q?3guONkOpurZ56vR2dS8V1EI1uEKi47cH8fkfsxUFJjYqo52TztQkfRjZtYCK?=
 =?us-ascii?Q?b0MEw7uAHYEb55B7lU/KAHJa9EQIL+mfJbypzWmZZnLM5DsskihqeJLP1KoB?=
 =?us-ascii?Q?ixIS4WE9fxrNV85piikxa8DjHHNdUOMky1/ndftjj6yyFRjY72jWiiQ+AeeZ?=
 =?us-ascii?Q?6z8vst2plogkU2StgCQHgnWXD6boF+luspGZS7kpdTP3AJ+3z5HKGxLby/j4?=
 =?us-ascii?Q?hbQum3GS3yrpCXQq1s0NVvqESaK76cvNG408FsK50DlxgzeFmmb3+AYy1ddS?=
 =?us-ascii?Q?3+O1T1COm7/MRlxh1oXmupabUvVBWJFTLHAPZBcF3GlgDTPHmF8167MuPfVf?=
 =?us-ascii?Q?QtoXT8CImA74fvrkDO+Tx/lx7zoT/msZgEu3OwbJfy+jhhzUNQuzwhg5dFk7?=
 =?us-ascii?Q?g1Od19UctQoshPmXieR3WBB7onvssRF72KJd6f/lGR0bwsyKFPTmCqs40u1/?=
 =?us-ascii?Q?uUYCT21Onwrt4dUQ8pGQyhZFrb8cIvl/WdVGKY1E+y1MP1WAI10pfmZYRGnj?=
 =?us-ascii?Q?ElqWDb4whClWN86Dz+bkw4Is8XWc2kBbxt/OPACAIjyQrkBhBTYJE/WxIEur?=
 =?us-ascii?Q?v4MS2/Wwc9lXUC8dnMC43nZH?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41768993-de90-496f-4c50-08d91a948d10
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB6821.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2021 07:05:57.5167
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pir6zrKiNvr6kbHRh3Dqm1uBaoLNytbToOEJ3Rqb6uG7ECbUv+VvQk03bF0hNP9u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2562
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/5/19 =E4=B8=8B=E5=8D=882:28, Qu Wenruo wrote:
>=20
>=20
> On 2021/5/18 =E4=B8=8B=E5=8D=885:09, Alexandru Elisei wrote:
>> After doing a git bisect I was able to trace the following error when=20
>> booting my
>> rockpro64 v2 (rk3399 SoC) with a PCIE NVME expansion card:
>=20
> I'm also hitting the same problem, with a RockPi 4B board.
>=20
> [...]
>> [=C2=A0=C2=A0=C2=A0 0.393269] pci_bus 0000:01: busn_res: [bus 01-1f] end=
 is updated=20
>> to 01
>> [=C2=A0=C2=A0=C2=A0 0.393311] pci 0000:00:00.0: BAR 14: no space for [me=
m size=20
>> 0x00100000]
>> [=C2=A0=C2=A0=C2=A0 0.393333] pci 0000:00:00.0: BAR 14: failed to assign=
 [mem size=20
>> 0x00100000]
>> [=C2=A0=C2=A0=C2=A0 0.393356] pci 0000:01:00.0: BAR 0: no space for [mem=
 size=20
>> 0x00004000 64bit]
>> [=C2=A0=C2=A0=C2=A0 0.393375] pci 0000:01:00.0: BAR 0: failed to assign =
[mem size=20
>> 0x00004000 64bit]
>=20
> The same error here.
>=20
>> [=C2=A0=C2=A0=C2=A0 0.393397] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [=C2=A0=C2=A0=C2=A0 0.393839] pcieport 0000:00:00.0: PME: Signaling with=
 IRQ 78
>> [=C2=A0=C2=A0=C2=A0 0.394165] pcieport 0000:00:00.0: AER: enabled with I=
RQ 78
>> [..]
>>
>> to the commit 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource=20
>> flags for
>> 64-bit memory addresses"). For reference, here is the dmesg output=20
>> when BAR
>> reassignment works:
>=20
> Great thanks for the pinning down the bug, at least I can try to boot my=
=20
> board again with the patch reverted.

Although after reverting, the kernel just BUG_ON() when alternatives try=20
to patch the kernel:

[    0.175009] alternatives: patching kernel code
[    0.175640] ------------[ cut here ]------------
[    0.176260] kernel BUG at arch/arm64/kernel/alternative.c:157!
[    0.177080] Internal error: Oops - BUG: 0 [#1] SMP
[    0.177579] Modules linked in:
[    0.177910] CPU: 0 PID: 12 Comm: migration/0 Not tainted=20
5.13.0-rc2-custom+ #11
[    0.178665] Hardware name: Radxa ROCK Pi 4B (DT)
[    0.179137] Stopper: multi_cpu_stop+0x0/0x1bc <-=20
stop_cpus.constprop.0+0x98/0xf0
[    0.179927] pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO BTYPE=3D--)
[    0.180546] pc : __apply_alternatives+0x21c/0x254
[    0.181047] lr : __apply_alternatives+0x100/0x254
[    0.181538] sp : ffff800012b0fca0
[    0.181883] x29: ffff800012b0fca0 x28: ffff800010011128 x27:=20
ffff80001001112c
[    0.182633] x26: ffff8000114dfec4 x25: 00000000001b0020 x24:=20
ffff800011212368
[    0.183377] x23: 0000000000000000 x22: ffff800011b041e6 x21:=20
ffff800012b0fd20
[    0.184125] x20: ffff800012b0fd30 x19: ffff8000114dfec8 x18:=20
0000000000000030
[    0.184872] x17: 0000000025e8361a x16: 000000004a78ba60 x15:=20
ffff0000020e1cd0
[    0.185623] x14: ffff8000118dc548 x13: 0000000000000000 x12:=20
000000000000016b
[    0.186370] x11: 0000000000000079 x10: ffff80001198c548 x9 :=20
00000000ffffe000
[    0.187115] x8 : 80000000ffffe000 x7 : ffff8000118dc548 x6 :=20
0000000000005ffd
[    0.187861] x5 : 0000000000000000 x4 : ffff8000100242b0 x3 :=20
ffffffffffffffc0
[    0.188606] x2 : ffff8000114fbb54 x1 : 0000000000000004 x0 :=20
0000000000000000
[    0.189353] Call trace:
[    0.189612]  __apply_alternatives+0x21c/0x254
[    0.190073]  __apply_alternatives_multi_stop+0xc4/0xdc
[    0.190610]  multi_cpu_stop+0xa8/0x1bc
[    0.191007]  cpu_stopper_thread+0xb0/0x144
[    0.191439]  smpboot_thread_fn+0x130/0x240
[    0.191884]  kthread+0x13c/0x140
[    0.192226]  ret_from_fork+0x10/0x30
[    0.192616] Code: aa1c03e1 aa1a03e0 97ffff27 17ffffb8 (d4210000)
[    0.193268] ---[ end trace d8c66e3e26751651 ]---
[    0.193746] Kernel panic - not syncing: Oops - BUG: Fatal exception
[    0.194395] SMP: stopping secondary CPUs
[    1.361467] SMP: failed to stop secondary CPUs 0-5
[    1.361980] Rebooting in 5 seconds..
[    6.362979] SMP: stopping secondary CPUs
[    7.530049] SMP: failed to stop secondary CPUs 0-5

Is there anything special needed to boot the kernel with that offending=20
commit reverted?

Thanks,
Qu

>=20
> Thanks,
> Qu
>=20
>>
>> [..]
>> [=C2=A0=C2=A0=C2=A0 0.307381] rockchip-pcie f8000000.pcie: host bridge /=
pcie@f8000000=20
>> ranges:
>> [=C2=A0=C2=A0=C2=A0 0.307445] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 MEM=20
>> 0x00fa000000..0x00fbdfffff ->
>> 0x00fa000000
>> [=C2=A0=C2=A0=C2=A0 0.307481] rockchip-pcie f8000000.pcie:=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 IO=20
>> 0x00fbe00000..0x00fbefffff ->
>> 0x00fbe00000
>> [=C2=A0=C2=A0=C2=A0 0.308406] rockchip-pcie f8000000.pcie: supply vpcie1=
v8 not found,=20
>> using dummy
>> regulator
>> [=C2=A0=C2=A0=C2=A0 0.308534] rockchip-pcie f8000000.pcie: supply vpcie0=
v9 not found,=20
>> using dummy
>> regulator
>> [=C2=A0=C2=A0=C2=A0 0.374676] rockchip-pcie f8000000.pcie: PCI host brid=
ge to bus=20
>> 0000:00
>> [=C2=A0=C2=A0=C2=A0 0.374701] pci_bus 0000:00: root bus resource [bus 00=
-1f]
>> [=C2=A0=C2=A0=C2=A0 0.374723] pci_bus 0000:00: root bus resource [mem=20
>> 0xfa000000-0xfbdfffff]
>> [=C2=A0=C2=A0=C2=A0 0.374746] pci_bus 0000:00: root bus resource [io=C2=
=A0 0x0000-0xfffff]=20
>> (bus
>> address [0xfbe00000-0xfbefffff])
>> [=C2=A0=C2=A0=C2=A0 0.374808] pci 0000:00:00.0: [1d87:0100] type 01 clas=
s 0x060400
>> [=C2=A0=C2=A0=C2=A0 0.374943] pci 0000:00:00.0: supports D1
>> [=C2=A0=C2=A0=C2=A0 0.374961] pci 0000:00:00.0: PME# supported from D0 D=
1 D3hot
>> [=C2=A0=C2=A0=C2=A0 0.379473] pci 0000:00:00.0: bridge configuration inv=
alid ([bus=20
>> 00-00]),
>> reconfiguring
>> [=C2=A0=C2=A0=C2=A0 0.379712] pci 0000:01:00.0: [144d:a808] type 00 clas=
s 0x010802
>> [=C2=A0=C2=A0=C2=A0 0.379815] pci 0000:01:00.0: reg 0x10: [mem 0x0000000=
0-0x00003fff=20
>> 64bit]
>> [=C2=A0=C2=A0=C2=A0 0.379997] pci 0000:01:00.0: Max Payload Size set to =
256 (was 128,=20
>> max 256)
>> [=C2=A0=C2=A0=C2=A0 0.380607] pci 0000:01:00.0: 8.000 Gb/s available PCI=
e bandwidth,=20
>> limited by
>> 2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0=20
>> GT/s PCIe
>> x4 link)
>> [=C2=A0=C2=A0=C2=A0 0.394239] pci_bus 0000:01: busn_res: [bus 01-1f] end=
 is updated=20
>> to 01
>> [=C2=A0=C2=A0=C2=A0 0.394285] pci 0000:00:00.0: BAR 14: assigned [mem=20
>> 0xfa000000-0xfa0fffff]
>> [=C2=A0=C2=A0=C2=A0 0.394312] pci 0000:01:00.0: BAR 0: assigned [mem=20
>> 0xfa000000-0xfa003fff 64bit]
>> [=C2=A0=C2=A0=C2=A0 0.394374] pci 0000:00:00.0: PCI bridge to [bus 01]
>> [=C2=A0=C2=A0=C2=A0 0.394395] pci 0000:00:00.0:=C2=A0=C2=A0 bridge windo=
w [mem=20
>> 0xfa000000-0xfa0fffff]
>> [=C2=A0=C2=A0=C2=A0 0.394569] pcieport 0000:00:00.0: enabling device (00=
00 -> 0002)
>> [=C2=A0=C2=A0=C2=A0 0.394845] pcieport 0000:00:00.0: PME: Signaling with=
 IRQ 78
>> [=C2=A0=C2=A0=C2=A0 0.395153] pcieport 0000:00:00.0: AER: enabled with I=
RQ 78
>> [..]
>>
>> And here is the output of lspci when BAR reassignment works:
>>
>> # lspci -v
>> 00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd RK3399 PCI=20
>> Express Root
>> Port (prog-if 00 [Normal decode])
>> =C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, latency 0, IRQ =
78
>> =C2=A0=C2=A0=C2=A0=C2=A0 Bus: primary=3D00, secondary=3D01, subordinate=
=3D01, sec-latency=3D0
>> =C2=A0=C2=A0=C2=A0=C2=A0 I/O behind bridge: 00000000-00000fff [size=3D4K=
]
>> =C2=A0=C2=A0=C2=A0=C2=A0 Memory behind bridge: fa000000-fa0fffff [size=
=3D1M]
>> =C2=A0=C2=A0=C2=A0=C2=A0 Prefetchable memory behind bridge: 00000000-000=
fffff [size=3D1M]
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [80] Power Management version 3
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [90] MSI: Enable+ Count=3D1/1 Mas=
kable+ 64bit+
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable- Count=3D1 Mas=
ked-
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [c0] Express Root Port (Slot+), M=
SI 00
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100] Advanced Error Reporting
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [274] Transaction Processing Hint=
s
>> =C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: pcieport
>> lspci: Unable to load libkmod resources: error -2
>>
>> 01:00.0 Non-Volatile memory controller: Samsung Electronics Co Ltd=20
>> NVMe SSD
>> Controller SM981/PM981/PM983 (prog-if 02 [NVM Express])
>> =C2=A0=C2=A0=C2=A0=C2=A0 Subsystem: Samsung Electronics Co Ltd NVMe SSD =
Controller=20
>> SM981/PM981/PM983
>> =C2=A0=C2=A0=C2=A0=C2=A0 Flags: bus master, fast devsel, latency 0, IRQ =
77, NUMA node 0
>> =C2=A0=C2=A0=C2=A0=C2=A0 Memory at fa000000 (64-bit, non-prefetchable) [=
size=3D16K]
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [40] Power Management version 3
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [50] MSI: Enable- Count=3D1/1 Mas=
kable- 64bit+
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [70] Express Endpoint, MSI 00
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [b0] MSI-X: Enable+ Count=3D33 Ma=
sked-
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [100] Advanced Error Reporting
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [148] Device Serial Number 00-00-=
00-00-00-00-00-00
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [158] Power Budgeting <?>
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [168] Secondary PCI Express
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [188] Latency Tolerance Reporting
>> =C2=A0=C2=A0=C2=A0=C2=A0 Capabilities: [190] L1 PM Substates
>> =C2=A0=C2=A0=C2=A0=C2=A0 Kernel driver in use: nvme
>>
>> I can provide more information if needed (the board is sitting on my=20
>> desk) and I
>> can help with testing the fix.
>>
>> Thanks,
>>
>> Alex
>>
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>>
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

