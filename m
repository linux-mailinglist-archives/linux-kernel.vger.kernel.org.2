Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8305738E3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbhEXKL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 06:11:28 -0400
Received: from mail-bn1nam07on2072.outbound.protection.outlook.com ([40.107.212.72]:9635
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232516AbhEXKLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 06:11:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MWfqmzTVGSMOZw1GcdtHd8P4oYzTrW311c3T3Kpd2buy/Oj6/YfAv/hrlfEjtPvyD0dNrS3gH9rsZjDVU0yF9nHerHfuIWb8lzuoTAmyr16tx77R2tWmNTFRCY4kuAKNK7ZgidXSf3+t5deMu9q/TZ5EGKPvnCUnALqJcnug913FSc44TzU1hSnYk6VNQEcB4Zx8eipW9xppqhPBNRSIpRN6hlLH6o+iWZxJg7u108Rf7twmu0iOUZiZNBy//b6RniJCGfwerXyLJrrBo3V4QXhcLaVVPGr/RVAgUY1sI2SN2DWZAOFm5gWFYsGjS7uyxsHMTsmsfJDDaNYEaBhLIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Ob3/wIRLvRF9zIFZ2w0yHQEt/sjX/tkLBlgUxqo1c=;
 b=Opnknu7geyVbo29da6vlul2kE7a1XGLnyy3AT51j8hCddDmso6yJvzK0SalJE9lx066BevOWKOrnZynh93dEbamuCKKOhDcdlGeo8zD78XQVlX2/TfxsATZDraRxCAT3Ri8jwgbl/Ha4o8mfJadejpHwR/CvDJuphigmUkvb1HcR3td7yIyACChVQmjkhR4lhDx+nr0ignEZqlGaI9C4tK+jqfTIQvuzVrVbhChWVW/Hq60hGFESZJLK3Lr+jDuTwEakX66Oa1yCwea9FROS6PRVBsYmtUCvNv8zM8XxqVf7GyCetx8E1xUR1ABzNOtlm+QMCuummD/oC/gdcMWRhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=81Ob3/wIRLvRF9zIFZ2w0yHQEt/sjX/tkLBlgUxqo1c=;
 b=ob0tyBqyK1MC9RbMtcGJGyOcsy/Vt7gr4wInmVwbXFu52i3GU58r5wud5saOvkdFX0vNUCgdcWm4SVw0+RHVCPcf7Ic7zV4VHHQibGjiQAnvMctrzHlQjYTVgqiRDWNTVIWuwZaeRULfGzXBP5xkS1Yo1gYvXgUsEupy1cJo1l8=
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=synaptics.com;
Received: from BN9PR03MB6058.namprd03.prod.outlook.com (2603:10b6:408:137::15)
 by BN7PR03MB4498.namprd03.prod.outlook.com (2603:10b6:408:8::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23; Mon, 24 May
 2021 10:09:48 +0000
Received: from BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791]) by BN9PR03MB6058.namprd03.prod.outlook.com
 ([fe80::308b:9168:78:9791%4]) with mapi id 15.20.4150.027; Mon, 24 May 2021
 10:09:48 +0000
Date:   Mon, 24 May 2021 18:09:40 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Marco Elver <elver@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm64: mm: don't use CON and BLK mapping if KFENCE is
 enabled
Message-ID: <20210524180940.21f7b0d1@xhacker.debian>
In-Reply-To: <CANpmjNPstZ8ytfmxqZFHMqDKSaZJtqCaOAmEC5n9R56YzC4GNg@mail.gmail.com>
References: <20210524153659.58a707a9@xhacker.debian>
        <CANpmjNPstZ8ytfmxqZFHMqDKSaZJtqCaOAmEC5n9R56YzC4GNg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: SJ0PR13CA0144.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::29) To BN9PR03MB6058.namprd03.prod.outlook.com
 (2603:10b6:408:137::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by SJ0PR13CA0144.namprd13.prod.outlook.com (2603:10b6:a03:2c6::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend Transport; Mon, 24 May 2021 10:09:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c41113e-d992-49f2-ac37-08d91e9c1059
X-MS-TrafficTypeDiagnostic: BN7PR03MB4498:
X-Microsoft-Antispam-PRVS: <BN7PR03MB44982843DD5C047048936F3BED269@BN7PR03MB4498.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Etjit+YYa3mDbGSUBQJvfvqj3dzRpy19jW2M096XU4pt1IIhiEAI07dib5e39WJEzxPYwGApCaRvTYgKtd5qJ6S4YIUk23586cSjeZi2UGWmDkgt1GiFiabYvMh4FkhdRY5p0nkXEQ6PB8EAV7dUF7L3tSMt+FifZslNwG5SqhkCMVSllSfbfslYO3USnhpBuzd85ysfT+dk57WPrrYT5IUAw5oXcpnjXo3/7CXYMmW7XWr3OvRriqFCgnddUpgtTCH3dseQEC4JoDOYPoZqEgoSJWgUcAFR/eZ7JLw6l/dBenM43A6lzo4vTTtpjFxWa4agakYIppPC0Kaux63NqA1FzwZyvJfVdCFFkMOKFeTQaNaUv4Zet64icWRopP4nTuvOkXgzCT5rjP/VDgeAZysYx44qpBJ4zaI0TAY41HYsp3LE8S1+5mGX9VwcHwiyxdeFmAayZsJutqkncp+7E67lY3uUyz1IfBj590cOQmOIyshdrPC6hjCrhNAby/jRmfZZkxMTlw1jUeiAWnQSD7ys8P9yfwBOgcHWqA5yHAooxVwKdaLMIwQ0Uo5+5Vek6aAUVKM5TxCyIAPqKZzSOrMA+4Many5zUVcBmZvBj9LO1URSlSnqYeHZmJGOhClinWP1uNX6fBp8jXkMJl8meQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR03MB6058.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39850400004)(396003)(136003)(366004)(376002)(38100700002)(38350700002)(8936002)(478600001)(1076003)(8676002)(316002)(54906003)(956004)(6666004)(26005)(4326008)(2906002)(5660300002)(55016002)(66556008)(66476007)(52116002)(9686003)(16526019)(86362001)(83380400001)(6916009)(7696005)(186003)(6506007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?fLrvfEEHwqd+K2lz6Pu77/6wx3VS+/yK+ewIYAZuHhQHxxCGpXDiYXK80Oa6?=
 =?us-ascii?Q?QiZfRc/u3MdSLB2qeFarwXJMOfPUhn4qATUaZHzG6xU6VSEthiTL9XhDy69T?=
 =?us-ascii?Q?FW5LY/NhEm2TmMP+uHxzR6fDKbT7O/QwzjExLEr8P7gTz/krFqWlEgV8H3Ur?=
 =?us-ascii?Q?drB1LTb6NPuO2XWtpOFf3TOSbjTyZoPx1PhCtVryHUuNEvVUFzCSukdlUlex?=
 =?us-ascii?Q?RGokH/AxeV+FI/BT91GBHUTiX/0X5wWufomLTcLaHkez+QDx4cnG+w6MENtn?=
 =?us-ascii?Q?1p6VcSyeuSUkOMNurxNb7mwTcfng5Ot5cUm4zxiTRb41UXFmnPjSxEDsEU4M?=
 =?us-ascii?Q?KkIFis8pjsKZ4gYU4UoPwn/tuNO9r6czWbhXla9KJg+oRnFYTV42jKTQ4Xt7?=
 =?us-ascii?Q?S5yXG9cpdDHZM0wYLlInxhC85oQQC+m1Kq176QImk8N72rodcNKzWrgOWMlR?=
 =?us-ascii?Q?jHDc9OsE/1MHkhkXR3E6dlaSmLzOchjF/XFSpjgJMbmiMDoPsJgcPBrBa0Hp?=
 =?us-ascii?Q?r3DON1kph7wAg2yiERYqPKTOKYxMEvzdHz0bznDzUqSFg869Kv0JQEigtXKQ?=
 =?us-ascii?Q?pjzBWmu9UuFtteeaaDEu4gj7p347VlO2ZEWDOViKDa7DIxxJhS5wEw0bd7Qp?=
 =?us-ascii?Q?DkP588MbOpeecaP4lXEr+6zvwAfuUdqfmAJK0zULXpQ2fCUpg3Q7aNcfW4Vb?=
 =?us-ascii?Q?1vp/j6vOtgLfUp6n6IoNvq7LyZGhyd6vWBXiHfiz+/BfVZ/3GaJRXxAv6d1Z?=
 =?us-ascii?Q?adpcty/6btMxXxvPP+xGNu6e6noHqT+d4mYCRqB15Xznvg/SriZpXWAzqLFr?=
 =?us-ascii?Q?QlTxLi1rPLViuM/14rSp/nlXFaLlMJJMhOKC5iKnu8xkAmh4lyF9lhD1iJjC?=
 =?us-ascii?Q?mkWBUBsrBK33vLJ8rB3/WtYf1PnPsoWLQbJqhNi8MRWWCORKTtsbr75lsC0D?=
 =?us-ascii?Q?lGqwakKDqrPr0ndO6rusKpWUbOb20x9+nkxH5/fmof27gp6WrgbQz978nrrV?=
 =?us-ascii?Q?j0gn7bT7ipcMw805wXPe09nBf9JkRP3ICyptWvmEUIB9Lryvaery4LwwEQ+F?=
 =?us-ascii?Q?e3Rsp6jEbj1T0oQsLRuqYhatRcDdSCM0m6aOlJsQo4g8JmkYBixfnC7u/kmT?=
 =?us-ascii?Q?AsAUhJZSezBoF7gkQyjk2DSRsbp5bBW5xwv4FGa1C+hHlugC4nwpzCnzA6MX?=
 =?us-ascii?Q?KliAbCG+iJk55nt1OB/9r1meECYaA3CzSLYPgfj3HTVIgZIEsdigRJfMjf8N?=
 =?us-ascii?Q?aTXR3pTrbIOCuNCAZHCAk0NDXzHGFfk7AjIOcPIa+q5H7CLwArba6758xuz4?=
 =?us-ascii?Q?C0sbvePb9dsMzq9XkF4wqRXS?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c41113e-d992-49f2-ac37-08d91e9c1059
X-MS-Exchange-CrossTenant-AuthSource: BN9PR03MB6058.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2021 10:09:48.8426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4yLLCCAyd/CdEHm2oyjggE/sW90mTt9oi+gnT9NIrdsJbhLo//e4w82hyeAD5tzCVFcdq+6V5tTt6EjQ5126/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR03MB4498
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2021 12:05:21 +0200 Marco Elver wrote:

> 
> 
> On Mon, 24 May 2021 at 09:38, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Fix below warning if KFENCE=y but RODATA_FULL=n:
> >  
> 
> Is this patch still relevant given you just sent "arm64: remove page
> granularity limitation from KFENCE" ?

This patch fixes a bug, so I suppose it needs to merged for linux-5.13-rcN
While the "arm64: remove page granularity limitation from KFENCE" series
is an optimization, so it need to wait for next version, I.E linux-5.14

thanks

> 
> > [    0.000000] ------------[ cut here ]------------
> > [    0.000000] WARNING: CPU: 0 PID: 0 at mm/memory.c:2462 apply_to_pmd_range+0xec/0x190
> > [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.13.0-rc1+ #10
> > [    0.000000] Hardware name: linux,dummy-virt (DT)
> > [    0.000000] pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO BTYPE=--)
> > [    0.000000] pc : apply_to_pmd_range+0xec/0x190
> > [    0.000000] lr : __apply_to_page_range+0x94/0x170
> > [    0.000000] sp : ffffffc010573e20
> > [    0.000000] x29: ffffffc010573e20 x28: ffffff801f400000 x27: ffffff801f401000
> > [    0.000000] x26: 0000000000000001 x25: ffffff801f400fff x24: ffffffc010573f28
> > [    0.000000] x23: ffffffc01002b710 x22: ffffffc0105fa450 x21: ffffffc010573ee4
> > [    0.000000] x20: ffffff801fffb7d0 x19: ffffff801f401000 x18: 00000000fffffffe
> > [    0.000000] x17: 000000000000003f x16: 000000000000000a x15: ffffffc01060b940
> > [    0.000000] x14: 0000000000000000 x13: 0098968000000000 x12: 0000000098968000
> > [    0.000000] x11: 0000000000000000 x10: 0000000098968000 x9 : 0000000000000001
> > [    0.000000] x8 : 0000000000000000 x7 : ffffffc010573ee4 x6 : 0000000000000001
> > [    0.000000] x5 : ffffffc010573f28 x4 : ffffffc01002b710 x3 : 0000000040000000
> > [    0.000000] x2 : ffffff801f5fffff x1 : 0000000000000001 x0 : 007800005f400705
> > [    0.000000] Call trace:
> > [    0.000000]  apply_to_pmd_range+0xec/0x190
> > [    0.000000]  __apply_to_page_range+0x94/0x170
> > [    0.000000]  apply_to_page_range+0x10/0x20
> > [    0.000000]  __change_memory_common+0x50/0xdc
> > [    0.000000]  set_memory_valid+0x30/0x40
> > [    0.000000]  kfence_init_pool+0x9c/0x16c
> > [    0.000000]  kfence_init+0x20/0x98
> > [    0.000000]  start_kernel+0x284/0x3f8
> >
> > Fixes: 840b23986344 ("arm64, kfence: enable KFENCE for ARM64")
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  arch/arm64/mm/mmu.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
> > index 6dd9369e3ea0..89b66ef43a0f 100644
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -515,7 +515,8 @@ static void __init map_mem(pgd_t *pgdp)
> >          */
> >         BUILD_BUG_ON(pgd_index(direct_map_end - 1) == pgd_index(direct_map_end));
> >
> > -       if (rodata_full || crash_mem_map || debug_pagealloc_enabled())
> > +       if (rodata_full || crash_mem_map || debug_pagealloc_enabled() ||
> > +           IS_ENABLED(CONFIG_KFENCE))
> >                 flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> >
> >         /*
> > --
> > 2.31.0
> >  

