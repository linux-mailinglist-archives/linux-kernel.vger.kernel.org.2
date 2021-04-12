Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A835C2E8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Apr 2021 12:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244411AbhDLJw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 05:52:28 -0400
Received: from mail-dm6nam12on2085.outbound.protection.outlook.com ([40.107.243.85]:32046
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S243863AbhDLJnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 05:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fHfJkZIQjrYkAK8XQSl0uygvIgnDfJ4YmFAmRaP+4xyQeM+zthA9QZ8n1OxsUG/4/ZQhoyPY5VGSxqcxqt5jcyvLLm0nL59useyLtHL8bWOr80kIfxPJkC/t2xHwghwuzH6LsflXZW8EPsi5bB//ddRBy8WgTbLjFf1Hk+/Ah5p7mtG6G5MecAzhxWmVGXYqOJeXSxMRWTxXRoDnBgONUQcUw6ztqgGHEq5Zw6VMGY8Z6VMFlu38uH7qZA85kMl8P1cljX5x6EIZYuW3ajMkULK80F1sicebixbI2fw4J1StptL7XMuULb0VK6MpT3V277RtD8foSmjvifPw73Gt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLNtCqzXzIp4Lmsi7SVcrQMWzDBgGfFv0Fy9YpWj6rk=;
 b=P3ziMEp+q1MlFUUXmmcp+S1+2bQwjqk3AJyyWJTWAk6Ijep32HAzIv7yLQWc9V7X3ePDFf30jqsBHc4FZY42qA6mzIIHq/16fWOE3mkyzeuHxpnInAl4sVHt9U4M/6T8RGlC4ksJ0+TJzrrz2Z9kgYDtfT1SaCD3KCDZ+Mm9XtM/IsxWOia3SH+xitJJH83mebc3t+nD5nnU3QN+HjyfoOrNpb0gex2+kOH+kgqneNxl/NZguv2mjjagkAtg84QnGwpq5yHkdICKcUULZXTx9G5o/JBdzKJ5gpECrP2Cgxn6qdZNbqAH+KwUBrM37Rrz9mLMHtfQfzV9/vkHEVf3Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLNtCqzXzIp4Lmsi7SVcrQMWzDBgGfFv0Fy9YpWj6rk=;
 b=AfAAM11foseS8Xpk3rxqZSxBcTikVZz1JSNSmzW6BtTAdztDceRbxMovBlLuHOMuBNOEc0TDmgdzwxIvSVNyy6FV2/MgL9PSELnCrP+u8xzqtljOiK70s7qeCv3eEPzPCO+01Wy1rniyBKuSsdCnWui8Zmi68n7ytP0HBGm4I2w=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by SJ0PR03MB5504.namprd03.prod.outlook.com (2603:10b6:a03:28a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Mon, 12 Apr
 2021 09:42:53 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Mon, 12 Apr 2021
 09:42:53 +0000
Date:   Mon, 12 Apr 2021 17:42:45 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     "liaochang (A)" <liaochang1@huawei.com>
Cc:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <guoren@linux.alibaba.com>,
        <mhiramat@kernel.org>, <penberg@kernel.org>, <lkp@intel.com>,
        <me@packi.ch>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv/kprobe: fix kernel panic when invoking sys_read
 traced by kprobe
Message-ID: <20210412174245.75f0f717@xhacker.debian>
In-Reply-To: <2aed1884-39d5-4573-71c7-89f805a8a92e@huawei.com>
References: <20210330081848.14043-1-liaochang1@huawei.com>
        <20210408192040.746b0fcc@xhacker.debian>
        <2aed1884-39d5-4573-71c7-89f805a8a92e@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:a03:180::37) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:180::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.8 via Frontend Transport; Mon, 12 Apr 2021 09:42:50 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6941c3c-b97e-42b8-1aa1-08d8fd9757c4
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5504:
X-Microsoft-Antispam-PRVS: <SJ0PR03MB5504C788F6CFBC565015F9B0ED709@SJ0PR03MB5504.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RSmI2p5ALAFKO7O/NkDllLm+oIjIkAKOclesCTvFjtVnyZlSmwZVJOqsvtgUteViJ6Y0Ry+cuu5P4gwzr8V10wZOKFyG4PIRv8jzPrckARRUY5JeXFuhwoYCWuovyS1pO1pw1/oIiQO1224KMz36Pm4zcGZ5Cz2iYwicjXer8eRQ9pppHJi3oglLIOR66j0oM3LUGTjKHu4a6jxJi/amr9AVBVq3cpnXK64HyBNH3ReRiHFSQtL++LqRPZjCikig8pDAgoGhfGetuHEDGhNxbKTO8UQDuyKqqvYeZo+tlwn2191CduwRsC23zN32N9SLjZ/kZwmbeDfO2fH2cHt7z1ECwYM9xbgmbDYbWMX1d+Z3ov7IFlsO/rD5gm8wJ4+4sLWMWGy1WL68HEH64hiOmeAcV0goCb1gntPpAsstzimcaUMHOD8Xvxz9mlkoL6RwzZCajf0VY72m78AjQrEFvkze/idhz5FS+Dd4WXJgQBL9ee4xyUmZos3DrqCtDfQlm9ka2mL2fzTUynzHtPjpOD9SFDE/d5Lv8PrYpiXUnzDh4ridWMGL670QMajVsKuiY9IT8kPqbDJUQm8782RhjztrTWog4DcBqLyDv4JwjqGKvvDQW/ZWmIGo1Glic9qzkx1r1C7x3C4FMiiZVeICmaqkjRimqQXO0Re3tMqwr28=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(136003)(346002)(396003)(86362001)(38100700002)(2906002)(9686003)(4326008)(7696005)(52116002)(45080400002)(66946007)(1076003)(956004)(38350700002)(55016002)(6666004)(316002)(478600001)(16526019)(186003)(66556008)(6506007)(83380400001)(7416002)(6916009)(66476007)(26005)(8676002)(8936002)(54906003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WUVBaEZnMUlzcW5tL2MreGpWNTdPeDNFb0ZObWhaMkduTXdKM2Q2RkRmbCtF?=
 =?utf-8?B?MzlDRXIrdmVGY1RkSFUyWnZkS1JIQXNQUXplYzlFbFJ0akZXM2NpZE1VNHBj?=
 =?utf-8?B?NjhYMkJmVTBzTkZnUllZeXhFam5GOUliWjBVdUltYVZqd1pmdmdGK0VBVFM1?=
 =?utf-8?B?RkRzSm9MOWRPMVlzUWtvbVE3WjUzbk5BV0Q4VGtmSmw1SWh0ZmlkUHJtUVhS?=
 =?utf-8?B?TnRIOVo2eWsxaFB4Njd0UUpoU2VqbFZibUFwZGZQMlRPeUdMNnNSUHJHUDZQ?=
 =?utf-8?B?UENYbktVRmFMNVVIdVNNemJhZThXdkMzR3RtdkR3U1V4aTBXckg4aFZ0SEVE?=
 =?utf-8?B?VUN6SC9USnRRbkJST3p1bjJqeU44ZEwrY04vMDFpS2U5d1ZYWGFsaHpaa1BK?=
 =?utf-8?B?a3Y5d1lhT0N3K2RlYU9RRW1hYnA2QjFXOUFXMWVPajc3WWI0VGFiSmJZWVkz?=
 =?utf-8?B?OGlsM1Z6ckQ5UHJZVU4xeGJ4d0VGd2U5QmFNTVJPZjhDcXNkS2xjUU9FTzZw?=
 =?utf-8?B?eVpYdnZOdlhkbkRINmVnVDQ1NEVGNndBcUQzS3I1TnRMNm54NmFTaTlFeDNF?=
 =?utf-8?B?dHFtNDJzM0YreWNzZGpaSVBETUdWSkI3bG4vNDdHYlRnVTJlZStJcEZaSWpm?=
 =?utf-8?B?SXVGU2h6YlB0NU5Gbkg2WFdqdUtlT3I4OTcybS8zam1CZmFEZHZ6S1hJb3l1?=
 =?utf-8?B?UExNMW0zNURQaHQzZ3dzb2dNb0RoY0ViQXBLREczVFRzVi8yUXZkbzNVaGhw?=
 =?utf-8?B?MmZwTUUxSW5aYnRXQ1lJY0FPZXR4QklDNXErMnJrdkNFQkJQQzJ0a2VXUWRG?=
 =?utf-8?B?ekFVbTFHVUU3MXhpdGlUamtoQzJEYy84a3dpYkorU3laVFRqNTZyUVJFZTdy?=
 =?utf-8?B?R3VPU0pOODhITi9Ea0tsYkRZa3FaUXlmT29QYVNiem1DNXBweVR2SEpaT3JB?=
 =?utf-8?B?VXFXM3dzYTk4NGZHUjFvam5FaHdudVhoMUk0clhjdmRaWExzNFdkbWUxUHNB?=
 =?utf-8?B?Q0NBS2ExL3pwODJUVnRuOVBmRXZKdW1uU0dtYjh3bGtwVG84aHM2ajVvWWkr?=
 =?utf-8?B?cDBNY2MrR2RENjhBK09qQkdqUFFtTldsVGRhb0oraWdoQnFKUVZXL3B2UzRR?=
 =?utf-8?B?SmxtdnlKaFd6V3pJby9XaHJhMzU2Qmp4OGt3RFlJOHRVUDFmQURHcG15MmdB?=
 =?utf-8?B?QmlWa01JV0JMMjhRVWpUNWh0Z1YwVElFa1NWc0J3ay9oV1NpM2hCcmhtVDNx?=
 =?utf-8?B?T3dyMlFsMWppa01jYmRHeXhsYVZscGp0bmpjNzdvSzV0eVgrblhaNXFIbjU3?=
 =?utf-8?B?L3lQbWd4cWpQWGFoZUlLTjJ5NjhHeW83U1FuMEkyTllhSXMxeXRvWDcvVWxh?=
 =?utf-8?B?WUJNN2Q5MkpoQlF5bG5jVVMwRTloejBSMVoreW8yK0dpY2g3Z3lHWVJaTSs1?=
 =?utf-8?B?ZHMrU0s0QTBOL1ozZW5uYi83eER2THJsamQ1NDliaStQbkpkcU93VkpRUDky?=
 =?utf-8?B?cFBhM0dGdEE2bUNZZlp0cEFJU1d3M3JTSXFWc0t0ZCtNUm92bHo2T0tzb3RW?=
 =?utf-8?B?WG5DVDFzYXV5M0cxSjF5M3UwbWt1aTFHbldCc3JwOTBNbHRZWmxyc2tReGxx?=
 =?utf-8?B?WlUwM0N1M3RlTWQ3a21LdXd5eE1BdWFNRStlQ2R0NVhqeEVlZnFDMk85ckth?=
 =?utf-8?B?ejBBMkxqTzllQ1hYVHhLbHRkTFgrc3djdzhpaTQrc3F1UGNBL2ZVdjBWVU1U?=
 =?utf-8?Q?FPsg++oLjmz+Y31eB22LMBJaGpJlMyARqW8B4Xd?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6941c3c-b97e-42b8-1aa1-08d8fd9757c4
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2021 09:42:53.0280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5GYQJCfpuOLDqi8RCCpZkIPYx1Qg6l2aByYnGHwkOcQn6NMQ7EbZEC/BhBc7M/d42wOwgBGakT3ofWDfjGfFoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR03MB5504
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Apr 2021 12:16:26 +0800
"liaochang (A)" <liaochang1@huawei.com> wrote:


>=20
>=20
> =E5=9C=A8 2021/4/8 19:20, Jisheng Zhang =E5=86=99=E9=81=93:
> > On Tue, 30 Mar 2021 16:18:48 +0800
> > Liao Chang <liaochang1@huawei.com> wrote:
> >
> > =20
> >>
> >> The execution of sys_read end up hitting a BUG_ON() in __find_get_bloc=
k
> >> after installing kprobe at sys_read, the BUG message like the followin=
g:
> >>
> >> [   65.708663] ------------[ cut here ]------------
> >> [   65.709987] kernel BUG at fs/buffer.c:1251!
> >> [   65.711283] Kernel BUG [#1]
> >> [   65.712032] Modules linked in:
> >> [   65.712925] CPU: 0 PID: 51 Comm: sh Not tainted 5.12.0-rc4 #1
> >> [   65.714407] Hardware name: riscv-virtio,qemu (DT)
> >> [   65.715696] epc : __find_get_block+0x218/0x2c8
> >> [   65.716835]  ra : __getblk_gfp+0x1c/0x4a
> >> [   65.717831] epc : ffffffe00019f11e ra : ffffffe00019f56a sp : fffff=
fe002437930
> >> [   65.719553]  gp : ffffffe000f06030 tp : ffffffe0015abc00 t0 : fffff=
fe00191e038
> >> [   65.721290]  t1 : ffffffe00191e038 t2 : 000000000000000a s0 : fffff=
fe002437960
> >> [   65.723051]  s1 : ffffffe00160ad00 a0 : ffffffe00160ad00 a1 : 00000=
0000000012a
> >> [   65.724772]  a2 : 0000000000000400 a3 : 0000000000000008 a4 : 00000=
00000000040
> >> [   65.726545]  a5 : 0000000000000000 a6 : ffffffe00191e000 a7 : 00000=
00000000000
> >> [   65.728308]  s2 : 000000000000012a s3 : 0000000000000400 s4 : 00000=
00000000008
> >> [   65.730049]  s5 : 000000000000006c s6 : ffffffe00240f800 s7 : fffff=
fe000f080a8
> >> [   65.731802]  s8 : 0000000000000001 s9 : 000000000000012a s10: 00000=
00000000008
> >> [   65.733516]  s11: 0000000000000008 t3 : 00000000000003ff t4 : 00000=
0000000000f
> >> [   65.734434]  t5 : 00000000000003ff t6 : 0000000000040000
> >> [   65.734613] status: 0000000000000100 badaddr: 0000000000000000 caus=
e: 0000000000000003
> >> [   65.734901] Call Trace:
> >> [   65.735076] [<ffffffe00019f11e>] __find_get_block+0x218/0x2c8
> >> [   65.735417] [<ffffffe00020017a>] __ext4_get_inode_loc+0xb2/0x2f6
> >> [   65.735618] [<ffffffe000201b6c>] ext4_get_inode_loc+0x3a/0x8a
> >> [   65.735802] [<ffffffe000203380>] ext4_reserve_inode_write+0x2e/0x8c
> >> [   65.735999] [<ffffffe00020357a>] __ext4_mark_inode_dirty+0x4c/0x18e
> >> [   65.736208] [<ffffffe000206bb0>] ext4_dirty_inode+0x46/0x66
> >> [   65.736387] [<ffffffe000192914>] __mark_inode_dirty+0x12c/0x3da
> >> [   65.736576] [<ffffffe000180dd2>] touch_atime+0x146/0x150
> >> [   65.736748] [<ffffffe00010d762>] filemap_read+0x234/0x246
> >> [   65.736920] [<ffffffe00010d834>] generic_file_read_iter+0xc0/0x114
> >> [   65.737114] [<ffffffe0001f5d7a>] ext4_file_read_iter+0x42/0xea
> >> [   65.737310] [<ffffffe000163f2c>] new_sync_read+0xe2/0x15a
> >> [   65.737483] [<ffffffe000165814>] vfs_read+0xca/0xf2
> >> [   65.737641] [<ffffffe000165bae>] ksys_read+0x5e/0xc8
> >> [   65.737816] [<ffffffe000165c26>] sys_read+0xe/0x16
> >> [   65.737973] [<ffffffe000003972>] ret_from_syscall+0x0/0x2
> >> [   65.738858] ---[ end trace fe93f985456c935d ]---
> >>
> >> A simple reproducer looks like:
> >>         echo 'p:myprobe sys_read fd=3D%a0 buf=3D%a1 count=3D%a2' > /sy=
s/kernel/debug/tracing/kprobe_events
> >>         echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enab=
le
> >>         cat /sys/kernel/debug/tracing/trace
> >> =20
> >
> > I can't reproduce the BUG_ON with the above step, I may miss something.
> > =20
> My test platform versions
> Kernel: 0d02ec6b3136 Linux 5.12-rc4
> QEMU: fdd76fecdd Update version for v5.0.0 release
>=20
> >> Here's what happens to hit that BUG_ON():
> >>
> >> 1) After installing kprobe at entry of sys_read, the first instruction
> >>    is replaced by 'ebreak' instruction on riscv64 platform.
> >>
> >> 2) Once kernel reach the 'ebreak' instruction at the entry of sys_read=
,
> >>    it trap into the riscv breakpoint handler, where it do something to
> >>    setup for coming single-step of origin instruction, including backu=
p
> >>    the 'sstatus' in pt_regs, followed by disable interrupt during sing=
le
> >>    stepping via clear 'SIE' bit of 'sstatus' in pt_regs.
> >>
> >> 3) Then kernel restore to the instruction slot contains two instructio=
ns,
> >>    one is original instruction at entry of sys_read, the other is 'ebr=
eak'.
> >>    Here it trigger a 'Instruction page fault' exception (value at 'sca=
use'
> >>    is '0xc'), if PF is not filled into PageTabe for that slot yet.
> >>
> >> 4) Again kernel trap into page fault exception handler, where it choos=
e
> >>    different policy according to the state of running kprobe. Because
> >>    afte 2) the state is KPROBE_HIT_SS, so kernel reset the current kpr=
obe
> >>    and 'pc' points back to the probe address.
> >>
> >> 5) Because 'epc' point back to 'ebreak' instrution at sys_read probe,
> >>    kernel trap into breakpoint handler again, and repeat the operation=
s
> >>    at 2), however 'sstatus' without 'SIE' is keep at 4), it cause the
> >>    real 'sstatus' saved at 2) is overwritten by the one withou 'SIE'. =
=20
> >
> > Is kprobe_single_step_handler() handled firstly this time? thus we won'=
t
> > enter kprobe_breakpoint_handler().
> > =20
> No,because this time kcb->ss.ctx.match_addr points to the single-step slo=
t,but
> instruction_pointer(regs) points to the first instruction of sys_read('eb=
reak')
> so the condition is not token eventually, then we enter kprobe_breakpoint=
_handler().
>=20
> bool __kprobes
> kprobe_single_step_handler(struct pt_regs *regs)
> {
>         struct kprobe_ctlblk *kcb =3D get_kprobe_ctlblk();
>=20
>         if ((kcb->ss_ctx.ss_pending)
>             && (kcb->ss_ctx.match_addr =3D=3D instruction_pointer(regs)))=
 {
>=20

Thanks for the information. Inspired by this patch, I think arm64 also
has the similar issue. I will send out a similar patch for arm64.

Thanks
