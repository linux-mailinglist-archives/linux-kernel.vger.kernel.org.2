Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04143B58AC
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Jun 2021 07:44:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhF1Fqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 01:46:45 -0400
Received: from mail-mw2nam10on2067.outbound.protection.outlook.com ([40.107.94.67]:55841
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230287AbhF1Fqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 01:46:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKx2kVHMLg4n9CyZK/r3gPAqq9CI+mUqovMT4l5scQ4Y78t60i15vGkVWfWS23ZtcVD6BlsLMZAw9k00I0I7lMABZLCumv7Ba7nOo70S++/0qiop8YcRXEyxzihf72kco7S47k0E5URLwlGrqQMLc4Yv4zfviw6shAhgsMs1xsTjlFmZyTKpOQjPqlvow3sDYRFe9w+hXB3yq0/Yz/MfgRmPJ17rJCQZWDnEAL4/0Mgu+9m8xTEo1lv3zydohjDcoF1YOtI4DM6Rge5jwkDCZxSCs++V2WgPHP0fKqABzTsqv40P6c8XNT2QVT1t8k/jmHSs27ZGCa7yDvJIh5esGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEmRrskhcfRyLm1k50tHY8y5ZA+yYrA9I8enOtSB/Cc=;
 b=TEUKKKjgNXSqxKRCZnHyP37+A03fyalefUjpsdzns6LofMqdvP5UDf1LHf67AopF7CnlltVra+EH1GTieysliBuyEmOQW6jGS+ItG6Kl4nUQae/8qI7wXLPs9dXJQLeL70u5gvihbG3UY5wdhU6qMSF8OSvTfPHrp2CGRBdPbYMGfopFq2Riytc4RekfxEnRxdohy17SjohOcj3ka22cDKyiqUwNk8NREqemrbu+yAMvlD1uFwAxYkH3TNrtPAvZWmhvZnRAYR1dut6zPZzP1mJ6MTPpLhgOaH+nNsmy/G1SYjpB7ub95YeHdid2zbYhKFK5JK2bg8JXAtv4NL22SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aEmRrskhcfRyLm1k50tHY8y5ZA+yYrA9I8enOtSB/Cc=;
 b=UOagHTUm28F/X4yhUACxcKsm7FOjbt34zw1wcGYIVS/AS8sqE6rrm1MYUONdb3VqEHWwlFYuD31Zpg7LAzH8osdw+FvLV5M9ZZ+8g1B4sRAGV0K3hJr12ZLwFBCjZEzQTzvR2/WaDzQPhMfCSDStpmBtw02etlL4hkepXn8hjTQ=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN7PR03MB3652.namprd03.prod.outlook.com (2603:10b6:406:ca::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20; Mon, 28 Jun
 2021 05:44:17 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::502a:5487:b3ee:f61c%3]) with mapi id 15.20.4264.026; Mon, 28 Jun 2021
 05:44:16 +0000
Date:   Mon, 28 Jun 2021 13:44:04 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: stacktrace: fix dump_backtrace/walk_stackframe
 with NULL task
Message-ID: <20210628134404.4c470112@xhacker.debian>
In-Reply-To: <20210627092659.46193-1-changbin.du@gmail.com>
References: <20210627092659.46193-1-changbin.du@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR05CA0103.namprd05.prod.outlook.com
 (2603:10b6:a03:334::18) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR05CA0103.namprd05.prod.outlook.com (2603:10b6:a03:334::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4287.12 via Frontend Transport; Mon, 28 Jun 2021 05:44:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f3f7a66d-899e-455e-c253-08d939f7c461
X-MS-TrafficTypeDiagnostic: BN7PR03MB3652:
X-Microsoft-Antispam-PRVS: <BN7PR03MB365210455254E1DE994D7B99ED039@BN7PR03MB3652.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +TMgCie+tFEa2ojtPnhjJ9mcOsGa6T9BBRrc+tsxSSkZ0kx0F8B67nKdpPSIdF8FnUe+jtLrAnCt7sXRxZ0DdHat0N9zMW39jQKbsrSa4wUsI1VPM6wu9pQzZxfCkvHp1ldH+aLObdJOt/M/dbvNHtN1HtxgX00K0einxOUm8SpWRmAKMSo+FSXZ7gtWiRwVSDv23oqNu0OtzwC7cyTggBW3EsUevoLViNXLFJjuAXso7Psc6K5bet5ovwy/BjjpwXShoGl5rUXhWywrg4D/PfofOea+ZB727P3d254oKyYIv4KMas5vQn7Sko6jck76aF13AQtZ8eYZEyV0yRborIP4P5sX4eySzmpw/TgIKjXMWKmy4a0ZmKxyq7KyzSArDiWu/W0loM9kPWFsu2jsPMDncvbgg4iveI1/nG7PY/hCYgyvYQuxy0e5QVskSsi0y4pZzdsDwNigel1bJPx82YnALL7atACUFpRz/emMhbD6960Ab6k611Hd/dnLa7inegr6Ah7IPpz+2fuM0IH5rJdEta2b9wbJQ4BZQVNe08QkjSM/jZuPBFqylOK9t31oSq4XFC9LTxnTPeoZkAFPS/mJgOoU0/+zCcf58sVcUVm6z5afZpXKiXk2GbiV7osokT8CGg8vSwPPf7W0F08Her6krCLBc5ki6cQ39J7oM4298aLQEXXHa3ZOJN9WcksDcyYUL9xIr9Vy2A6IYXTRosmRqPQckolRmzrtNhsHqjCZ23NNUXrdotzDrAD6D3Fi6Zcsb5a6HQgt0M4S3u9szH7AEJ8wzWuy98jyryEbCBg1eO55UOAO8YAtCiiyhnzO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(396003)(39850400004)(136003)(346002)(366004)(8676002)(66946007)(1076003)(26005)(16526019)(38100700002)(38350700002)(5660300002)(956004)(9686003)(86362001)(55016002)(8936002)(316002)(66556008)(6916009)(7696005)(966005)(6506007)(478600001)(54906003)(6666004)(45080400002)(83380400001)(2906002)(52116002)(4326008)(186003)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oGziU77IDfTA5u4MQLQJP+3WG855Z5UJ1QynwPEm/9XkSFmdHi7zuaTBoRdX?=
 =?us-ascii?Q?J6PLM9ZX6TdJGvUs9IBgfOaiW2f4/DP8+WxXJvKOp+SaBbRBikYnx8fFCTMc?=
 =?us-ascii?Q?niBQ5H6myUgUKlFelb1jaQJwhPswSJPwjSvBp93Dxa/EdUiCz5F8UXCahmcL?=
 =?us-ascii?Q?fcbX7ndNZFOfBpl8gs6DwbPMIpjsfUTaIVRU4rdrHar3mzOq9oWzhuOv1nz/?=
 =?us-ascii?Q?suTGDQ9zOIMBRs+Y6e0fEFozcXzUzhYS/kRpNA8BNZmB1nE0qDQ/ZloInI8E?=
 =?us-ascii?Q?M7rCK6ACNOhQFZyzAx8ZfJS10WEsn3cj9hJIKvKpAhidLEhebqKb4bYZ5rOW?=
 =?us-ascii?Q?qL4m5XVXnXn+4fziSrevk0UkLz6twBrhpp4/a/GJpzo70UBfW2Ftv/MhouWI?=
 =?us-ascii?Q?lfy8+14lyP2RO7hV1m59li1B3/Lm6tbkTV/yslvyiijFXbbPex0pWkihuBFp?=
 =?us-ascii?Q?5NdwfygYZwQMyHSZLAlohDhO7FsdYtLl+sHJDiwwHjS+3dDMAUe0GESO2eRJ?=
 =?us-ascii?Q?3bafKyFpv6ENOwqxikHMxsfQlUEOyDsWAt74XQdAwxELaTr09zgkKJQ3JrYV?=
 =?us-ascii?Q?iorwOTM99W9/F2y8f10KAyL1iAr6z3tBXGp7tn5couyPX9XeDBXtCTPxu4g/?=
 =?us-ascii?Q?IZ0huShvdXNG1KZOqvT33vyGs7yccQX/XfDE2xETqDM3FXGavzXRomNePfSI?=
 =?us-ascii?Q?G1KZOBTUwgUJbEDRViHzkR1LBAsofR64VlPv50V6ZOcPl3CWHWjTX6kJtv2D?=
 =?us-ascii?Q?azFrBK1VDiEYt1kEgZqqlEMJEiit/X7OWPDU0sIO1jSbe3CJ/ajMgIJGSK0U?=
 =?us-ascii?Q?VXowUJggxa2A/HtcsXujH2GJgT2gW/gX6TYNW4x5Q4a3VCEGNKwyDZlUkgZx?=
 =?us-ascii?Q?cKYrax3YWzm9p9nTGXkbPrJSvwoYrCXw1hiDS7uNP0D5HgbH155igg0PbL7M?=
 =?us-ascii?Q?dM229PdRgnqIYYEne7/v/qz1+HM2xbEE99NUX0o5y5KFJOixhHSCS/+alS7/?=
 =?us-ascii?Q?Ji6SBzmAvPBO3lSohAzrogY/CmAbyvglTRRzuogLVrIGZR/Hl7fTI5Iu5Hny?=
 =?us-ascii?Q?E4DoufwexoRzwkEpPfiB/uy+jMcQCIV8ItuQPyPOTp3WHdGBc3C/NA37DY6X?=
 =?us-ascii?Q?eg3rhJbgBDrPNbiqiGidyDXqMgPgMxGhcfljzX9Gy3nSDKhs+qGwlZ8ZYbHb?=
 =?us-ascii?Q?Ii3TBbe9N+bRZ16YPNda5d9CEDQzXZjLRVfV+Ub62MdqqB+agTle1+EfrDkd?=
 =?us-ascii?Q?DQNnLzPn8oN7b6eF842lp7DXQze0h98Ajv0YDH2/4V0edDhnFTpogVm13r5x?=
 =?us-ascii?Q?o/HG+dgs29mL5AS+xHe2Phzs?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3f7a66d-899e-455e-c253-08d939f7c461
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2021 05:44:16.6969
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /JwgJNm8gYSiDSs1BXShAlKvB+rQCDKUmU9V12mLj+vyLT0RW/rl7jaoCjWEVEuToaXpgIXM8OC6Zn7+cOuQeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB3652
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Jun 2021 17:26:59 +0800
Changbin Du <changbin.du@gmail.com> wrote:


> 
> 
> Some places try to show backtrace with NULL task, and expect the task is
> 'current'. For example, dump_stack()->show_stack(NULL,...). So the
> stacktrace code should take care of this case.

I fixed this issue one week ago:

http://lists.infradead.org/pipermail/linux-riscv/2021-June/007258.html

> 
> Here is an oops caused by this issue when accessing the NULL task.
> 
> [   15.180813] Kernel panic - not syncing: No working init found.  Try passing init= option to kernel. See Linux Documentation/admin-guide/init.rst for guidance.
> [   15.182382] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc7-00111-g625acffd7ae2-dirty #18
> [   15.183431] Hardware name: riscv-virtio,qemu (DT)
> [   15.184253] Call Trace:
> [   15.223617] Unable to handle kernel paging request at virtual address 0000000000001590
> [   15.267378] Oops [#1]
> [   15.268215] Modules linked in:
> [   15.272027] CPU: 3 PID: 1 Comm: swapper/0 Not tainted 5.13.0-rc7-00111-g625acffd7ae2-dirty #18
> [   15.273997] Hardware name: riscv-virtio,qemu (DT)
> [   15.275134] epc : walk_stackframe+0xc4/0xdc
> [   15.280146]  ra : dump_backtrace+0x30/0x38
> [   15.280799] epc : ffffffff8000597e ra : ffffffff800059c6 sp : ffffffe002383d60
> [   15.281622]  gp : ffffffff8179ad18 tp : ffffffe002378000 t0 : ffffffff81bc1a3f
> [   15.282574]  t1 : 0000000000000001 t2 : 0000000000000000 s0 : ffffffe002383dc0
> [   15.283782]  s1 : ffffffff812b7d18 a0 : 0000000000001000 a1 : 0000000000000000
> [   15.285115]  a2 : ffffffff807ec668 a3 : ffffffff812b7d18 a4 : c76c00cabf08b500
> [   15.286213]  a5 : 0000000000001000 a6 : 000000001a9ef260 a7 : 0000000000000000
> [   15.287317]  s2 : 0000000000000000 s3 : 0000000000000000 s4 : 0000000000000000
> [   15.288323]  s5 : ffffffff807ec668 s6 : ffffffff812b7d18 s7 : 0000000000000000
> [   15.289530]  s8 : 0000000000000000 s9 : 0000000000000000 s10: 0000000000000000
> [   15.290995]  s11: 0000000000000000 t3 : 0000000000000001 t4 : 0000000000000000
> [   15.292465]  t5 : 206f74206e6f6974 t6 : ffffffe002383b28
> [   15.293859] status: 0000000000000100 badaddr: 0000000000001590 cause: 000000000000000d
> [   15.296035] [<ffffffff8000597e>] walk_stackframe+0xc4/0xdc
> [   15.297342] [<ffffffff800059c6>] dump_backtrace+0x30/0x38
> [   15.298333] [<ffffffff807ec6e0>] show_stack+0x40/0x4c
> [   15.299765] [<ffffffff807f07ac>] dump_stack+0x7c/0x96
> [   15.300553] [<ffffffff807ec8be>] panic+0x118/0x300
> [   15.301147] [<ffffffff807f61e8>] kernel_init+0x12c/0x138
> [   15.302056] [<ffffffff80003a22>] ret_from_exception+0x0/0xc
> [   15.338628] ---[ end trace 0a3fa0cc7f3393cd ]---
> [   15.339919] note: swapper/0[1] exited with preempt_count 1
> [   15.341995] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
> [   15.343889] SMP: stopping secondary CPUs
> [   16.802836] SMP: failed to stop secondary CPUs 0-3
> [   16.806264] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---
> 
> This patch fixes it by setting the task to current if it's NULL before
> accessing it.
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> Fixes: 5d8544e2d0 ("RISC-V: Generic library routines and assembly")

Hmm, this fixes tag should be
Fixes: eac2f3059e02 ("riscv: stacktrace: fix the riscv stacktrace when CONFIG_FRAME_POINTER enabled"


> ---
>  arch/riscv/kernel/stacktrace.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
> index bde85fc53357..788b65eba965 100644
> --- a/arch/riscv/kernel/stacktrace.c
> +++ b/arch/riscv/kernel/stacktrace.c
> @@ -23,6 +23,9 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
>  {
>         unsigned long fp, sp, pc;
> 
> +       if (!task)
> +               task = current;
> +
>         if (regs) {
>                 fp = frame_pointer(regs);
>                 sp = user_stack_pointer(regs);
> @@ -73,6 +76,9 @@ void notrace walk_stackframe(struct task_struct *task,
>         unsigned long sp, pc;
>         unsigned long *ksp;
> 
> +       if (!task)
> +               task = current;
> +
>         if (regs) {
>                 sp = user_stack_pointer(regs);
>                 pc = instruction_pointer(regs);
> --
> 2.30.2
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org

