Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11D8035819D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbhDHLVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 07:21:06 -0400
Received: from mail-mw2nam12on2082.outbound.protection.outlook.com ([40.107.244.82]:24896
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229831AbhDHLVF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 07:21:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRsYPAC1igHvmKSm/hoLL+LV1tJs2KN402XQxh/6HF4jU89hEM0qxk92r2brJ4WNnYrZecdRyoZRCAVuklWUFnjRCfSI/32hJKDwfUykGdU0QwojtRCCrjEEP/3Y6oHeGauxpbsC2mpFA6w+8sJLWem7iZKcoMCl2oQ2UQeaDq+DFD2i1H6wSlANWkmYXzun5BR1GlMUwwWufwJ0wULjkvVt5jYoJhT7e0gHjWxQW9eP/IZszkfllMY15yFyq3lKS8uFDDQhy2g/xRI9YqGuGpKEw8psNrJ3dE9trDd3KvRD1pCh3qRbYKZDElt4PTdvJMB3EQfi326Tk8JyjloiuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TukpbsVdmVuh+DxnqHHLyQNp1IqDyKQ9vIis7DVJVzA=;
 b=WN5mhUQn8nod9PRzJpt6LYZ5IyidefBEwTDAXpmNZ+VH+Lg90dwxjkTbiMnFwWigLZL+bQiJL1q9g7iVf0BLSPPltl4WJ4yW7OzKwMRPHRgVmDbJfXfbz3lf7XCPOj7dcdJzwLGJEzQROwLy1VMo1W3AE+OvC5PFoFiCGqyRgcqOfEgJmhERuzMf84OdvVLgp/JzjGyKW3R0arJxzufghWNX+7BdWn1YBaR8mjf0h/oNSwCUnCBXjf0acIbm0Fitw6X1jZnO1N/9GmvoeK9JXiFpdamzo0CMN+XoVgghiuFyKXQG8OjH0JynN21vIDc18xkZ1pUzj3+qgSSv0jAjsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TukpbsVdmVuh+DxnqHHLyQNp1IqDyKQ9vIis7DVJVzA=;
 b=QH+USveSv27VJMwlWECb8+Zn45U9dYA7ByHXFR0RPL5HcCNoiIbFVL19hiTWmpqZi7TfO6eDAooDXqdoM7V46wvwDVGpdm40i46f7Db1WW2sgPUmMq56OgS8Dbgy3+MmxIhB0oVX7LRmKIOfSgHq88PKDtwk66IcLsnDDFrOyrw=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BYAPR03MB4551.namprd03.prod.outlook.com (2603:10b6:a03:c3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Thu, 8 Apr
 2021 11:20:51 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%9]) with mapi id 15.20.3999.033; Thu, 8 Apr 2021
 11:20:51 +0000
Date:   Thu, 8 Apr 2021 19:20:40 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Liao Chang <liaochang1@huawei.com>
Cc:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <guoren@linux.alibaba.com>,
        <mhiramat@kernel.org>, <penberg@kernel.org>, <lkp@intel.com>,
        <me@packi.ch>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] riscv/kprobe: fix kernel panic when invoking sys_read
 traced by kprobe
Message-ID: <20210408192040.746b0fcc@xhacker.debian>
In-Reply-To: <20210330081848.14043-1-liaochang1@huawei.com>
References: <20210330081848.14043-1-liaochang1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BYAPR05CA0059.namprd05.prod.outlook.com
 (2603:10b6:a03:74::36) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BYAPR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:74::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.6 via Frontend Transport; Thu, 8 Apr 2021 11:20:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a5cbec2-8b50-441c-0d5f-08d8fa805dfd
X-MS-TrafficTypeDiagnostic: BYAPR03MB4551:
X-Microsoft-Antispam-PRVS: <BYAPR03MB455135E48B1778EF18CC88BFED749@BYAPR03MB4551.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h9lthm228lNXwS0zF8LoCmroYks2W9A3/DnGhQoxkWQvKODelBZ+kCSCmrEhTnDwoYkCBRQBqLnhgCz8m5uL7JkFitefip7BXK+IqJMC1DoK8ZDi5qPBqyt6wrWriNSuAV2v2zk87rkyE3wMNpj22mdjhzr8+SdQ0xhcL4dFtsw/21UrPFMjZ/9iv0Kwhf9VN+LwTX+tinljQE7R8pwnuVNwrFn5GV6SUrHMcpD0IL+I1Km899+hZ4RQXwm4CWRZSZ/gcr/2tZU32UXvn30psde4GiDaK7VQCD5cQJCcWUzlToIyxiMv+/84Ex1j8DPLlK915cZpW5HOLTBv8XEgiWMlE/hE/flRpvZwCJCmxXQM++D+rPAe1ImDePbBZphR1U245RuiastQm53xv7rlf929s/lpW7NLRGrnLI/HpU39EY5UuuEu9933qMwmR4/vC+E6EsPTmDa10OVILgTtyaJejyOl4556JspEZn1KvF+6NuZ44njTNXr+UzdFSvy78CsYEG3Yo3zQGGYZurHAbxK6s7SMnhSKHczQXvqfUDBTX9ZmDPDxBXax+dDpaCzM9q5H/QrhpcBfwKkG4/6kEqLR4mRmQZMjQ3v+O1vu526l/91zt+y8i9ZvFRt4tUa82USkPI7ZTNw73t1+Y+XBjoLSdMvIwPNAggGQIzBdTkSrCAcCCz1ZUaxSXdV/IkVI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(346002)(376002)(136003)(6506007)(52116002)(7696005)(5660300002)(6916009)(8936002)(66946007)(8676002)(66476007)(4326008)(38100700001)(478600001)(38350700001)(66556008)(55016002)(9686003)(45080400002)(956004)(6666004)(54906003)(83380400001)(86362001)(316002)(1076003)(2906002)(186003)(16526019)(7416002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?gFNSoQ0Rk9Ph6kY20S+VL6SG/5ROtz+g/bei88G/tBnc+D7MMEXDG7Bndkj+?=
 =?us-ascii?Q?swdnIuvNjBl963fLsOX4NDP8tvAnTh2ZnrVnI/31vUIFwpYuDSFynvZn0CKM?=
 =?us-ascii?Q?yZfqvcYmGLK4JhFSxN02NciMp1WaeftbaKIJo1/bF2hatHriFJw0T56aKCp7?=
 =?us-ascii?Q?COsvPOAL+DT4NeRA/Cj00Z1UL0TW7ftIjLmIuCILvsDvlAlldee50kuioq5w?=
 =?us-ascii?Q?wNMZqqkZJLtRfuMg8HDCXB1LaOQxR1ac2jkuF74CdFj91LACUXQEln5MJCYM?=
 =?us-ascii?Q?ew548subvDWfTLZizwt4HjuI+jO/D/zYhYAkH/SDAwv9OuIZnCNYJRUFqzlV?=
 =?us-ascii?Q?kPz7ewf2hDtetAlv9J29EsB7RVXgx6knhCF2EBkCeSOcc9hntr57fCmehxBf?=
 =?us-ascii?Q?0KE/GJQI6yelL2QsTttouI6cVJ5CurHajKkhniTB1WkHy2RgjAOuszsCu3OT?=
 =?us-ascii?Q?iZqCgIakUX/d+fcI/06cP7zjuOONU1SllG39rv+exWNw259fGSrPFw54R+dP?=
 =?us-ascii?Q?ksYq8YM8Y0Y0anb4be7HLYkiFJfvnkIpSL+e0VrmzQ7CzuaE8WKh7cC5i3Mf?=
 =?us-ascii?Q?pmsehv7olloSeEdpWt0q0PHxq4Azwvs4wLVrG6thGsMlfCYLe2x+uxuBIisF?=
 =?us-ascii?Q?zxL6c255Ryrab//M4Y9oJfFSnNI5Z2vKdX9k9ay+pgxcUEAn/6hCc1Raz5Ka?=
 =?us-ascii?Q?laRoZnN7aZDU2+2ZP+tYdvm0LvFVKq1lRBzAST56erfK/XnX832BGSdyiDNr?=
 =?us-ascii?Q?3ZaTyeslbCa4N4gmop9hpqPZGkcVmED3Pj2/eEqaMX/Qe1NLlgK3LWIW1QAh?=
 =?us-ascii?Q?MqM0Eed6h9FQylDEwIN+3HRN458tMqZRzMZ3meN1Kxss7C1sqRUCDmpbsMC+?=
 =?us-ascii?Q?9oyVx1dvyUrQjMKhmk5NvwmVJERxYQEmwPLdhbK3KE0Y0krho/qrdijUUCP7?=
 =?us-ascii?Q?V2BZDExHNLl+dGXtUuUiejwC5VAeUW9qjHaaIEIskSy2BkMS3Rwnomw27PLZ?=
 =?us-ascii?Q?Y5J1gGQw8tLWNyKgtorxiTYHQqW2M2tcI+8Xp3YPH2xdl3o9Y+LwyPDgSUlx?=
 =?us-ascii?Q?keH9fXnJCLSb8+1SWnHJL1T0Smrqu7NgMsDz1mVhHs9qvGuCXRJODP9p/IUP?=
 =?us-ascii?Q?K5oD0cy+O+k6nuCpxbMKt6gFp2DCjMf6qvcdkW+GcyCdI6125JEX6PwE5f4C?=
 =?us-ascii?Q?7luC8jmvBydU8x5K/NQV7kDMSOpO5hQddd2t3TUzdqR5lNw3Hz87GKjMSGb3?=
 =?us-ascii?Q?Cy9KVsd1cx75yZdFLT32JI4kXr8jpApDG0XpVzVEKXPpK4me20EwgPzl/QZx?=
 =?us-ascii?Q?1YfRKOmUu0FPHWxp2ktQkBPa?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a5cbec2-8b50-441c-0d5f-08d8fa805dfd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2021 11:20:51.4171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4t6V25jvgamdkGqT51ND4ByOOy43IZpxez3LfrcHAjp2LKKL02pjcscWv+uJbspzb/yP7z7xcXBcoD7Sq4+TIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4551
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Mar 2021 16:18:48 +0800
Liao Chang <liaochang1@huawei.com> wrote:


> 
> The execution of sys_read end up hitting a BUG_ON() in __find_get_block
> after installing kprobe at sys_read, the BUG message like the following:
> 
> [   65.708663] ------------[ cut here ]------------
> [   65.709987] kernel BUG at fs/buffer.c:1251!
> [   65.711283] Kernel BUG [#1]
> [   65.712032] Modules linked in:
> [   65.712925] CPU: 0 PID: 51 Comm: sh Not tainted 5.12.0-rc4 #1
> [   65.714407] Hardware name: riscv-virtio,qemu (DT)
> [   65.715696] epc : __find_get_block+0x218/0x2c8
> [   65.716835]  ra : __getblk_gfp+0x1c/0x4a
> [   65.717831] epc : ffffffe00019f11e ra : ffffffe00019f56a sp : ffffffe002437930
> [   65.719553]  gp : ffffffe000f06030 tp : ffffffe0015abc00 t0 : ffffffe00191e038
> [   65.721290]  t1 : ffffffe00191e038 t2 : 000000000000000a s0 : ffffffe002437960
> [   65.723051]  s1 : ffffffe00160ad00 a0 : ffffffe00160ad00 a1 : 000000000000012a
> [   65.724772]  a2 : 0000000000000400 a3 : 0000000000000008 a4 : 0000000000000040
> [   65.726545]  a5 : 0000000000000000 a6 : ffffffe00191e000 a7 : 0000000000000000
> [   65.728308]  s2 : 000000000000012a s3 : 0000000000000400 s4 : 0000000000000008
> [   65.730049]  s5 : 000000000000006c s6 : ffffffe00240f800 s7 : ffffffe000f080a8
> [   65.731802]  s8 : 0000000000000001 s9 : 000000000000012a s10: 0000000000000008
> [   65.733516]  s11: 0000000000000008 t3 : 00000000000003ff t4 : 000000000000000f
> [   65.734434]  t5 : 00000000000003ff t6 : 0000000000040000
> [   65.734613] status: 0000000000000100 badaddr: 0000000000000000 cause: 0000000000000003
> [   65.734901] Call Trace:
> [   65.735076] [<ffffffe00019f11e>] __find_get_block+0x218/0x2c8
> [   65.735417] [<ffffffe00020017a>] __ext4_get_inode_loc+0xb2/0x2f6
> [   65.735618] [<ffffffe000201b6c>] ext4_get_inode_loc+0x3a/0x8a
> [   65.735802] [<ffffffe000203380>] ext4_reserve_inode_write+0x2e/0x8c
> [   65.735999] [<ffffffe00020357a>] __ext4_mark_inode_dirty+0x4c/0x18e
> [   65.736208] [<ffffffe000206bb0>] ext4_dirty_inode+0x46/0x66
> [   65.736387] [<ffffffe000192914>] __mark_inode_dirty+0x12c/0x3da
> [   65.736576] [<ffffffe000180dd2>] touch_atime+0x146/0x150
> [   65.736748] [<ffffffe00010d762>] filemap_read+0x234/0x246
> [   65.736920] [<ffffffe00010d834>] generic_file_read_iter+0xc0/0x114
> [   65.737114] [<ffffffe0001f5d7a>] ext4_file_read_iter+0x42/0xea
> [   65.737310] [<ffffffe000163f2c>] new_sync_read+0xe2/0x15a
> [   65.737483] [<ffffffe000165814>] vfs_read+0xca/0xf2
> [   65.737641] [<ffffffe000165bae>] ksys_read+0x5e/0xc8
> [   65.737816] [<ffffffe000165c26>] sys_read+0xe/0x16
> [   65.737973] [<ffffffe000003972>] ret_from_syscall+0x0/0x2
> [   65.738858] ---[ end trace fe93f985456c935d ]---
> 
> A simple reproducer looks like:
>         echo 'p:myprobe sys_read fd=%a0 buf=%a1 count=%a2' > /sys/kernel/debug/tracing/kprobe_events
>         echo 1 > /sys/kernel/debug/tracing/events/kprobes/myprobe/enable
>         cat /sys/kernel/debug/tracing/trace
> 

I can't reproduce the BUG_ON with the above step, I may miss something.

> Here's what happens to hit that BUG_ON():
> 
> 1) After installing kprobe at entry of sys_read, the first instruction
>    is replaced by 'ebreak' instruction on riscv64 platform.
> 
> 2) Once kernel reach the 'ebreak' instruction at the entry of sys_read,
>    it trap into the riscv breakpoint handler, where it do something to
>    setup for coming single-step of origin instruction, including backup
>    the 'sstatus' in pt_regs, followed by disable interrupt during single
>    stepping via clear 'SIE' bit of 'sstatus' in pt_regs.
> 
> 3) Then kernel restore to the instruction slot contains two instructions,
>    one is original instruction at entry of sys_read, the other is 'ebreak'.
>    Here it trigger a 'Instruction page fault' exception (value at 'scause'
>    is '0xc'), if PF is not filled into PageTabe for that slot yet.
> 
> 4) Again kernel trap into page fault exception handler, where it choose
>    different policy according to the state of running kprobe. Because
>    afte 2) the state is KPROBE_HIT_SS, so kernel reset the current kprobe
>    and 'pc' points back to the probe address.
> 
> 5) Because 'epc' point back to 'ebreak' instrution at sys_read probe,
>    kernel trap into breakpoint handler again, and repeat the operations
>    at 2), however 'sstatus' without 'SIE' is keep at 4), it cause the
>    real 'sstatus' saved at 2) is overwritten by the one withou 'SIE'.

Is kprobe_single_step_handler() handled firstly this time? thus we won't
enter kprobe_breakpoint_handler().

> 
> 6) When kernel cross the probe the 'sstatus' CSR restore with value
>    without 'SIE', and reach __find_get_block where it requires the
>    interrupt must be enabled.
> 
> Fix this is very trivial, just restore the value of 'sstatus' in pt_regs
> with backup one at 2) when the instruction being single stepped cause a
> page fault.


PS: I'd suggest improve the commit msg. To be honest, I can't exactly
get all the meanings of above 1) ~ 6)
