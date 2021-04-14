Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C26E535EE39
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 09:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349599AbhDNHPT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 03:15:19 -0400
Received: from mail-dm6nam11on2089.outbound.protection.outlook.com ([40.107.223.89]:64673
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231240AbhDNHPR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 03:15:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SJq5Ad6RdjsQ95TWysWsotoT82447kIC9dnSzoHE8SZzZF/yauIXFFZyeRN4lnX+nZPH+O0hJnL8S8jVPhQQFuGSnlU67atyPYyiCjDLvxnMdpZ5f6zJpgnocwI6Yy1r64NkR2OQjaAHTFVw2mJ4t6RwoIIeHR/PwmIeLprCHGfikIaSbDjSTZxLDVBMySXoLFZj8RGzFVEgD5KohLBHlikB3Mm9Ys9Hs7h913poLbf4FpoLmuYsi7fDWL3ornIRMetPBF3kj1dK5Wp0ITMx13aW2NcRwxpTUUhVEZxMQDcJ6SjA2+3R8EQPQ38uJuPfN+71/inJTuNDvts6RCYUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0btOV3TyOo6Gv7HVd5FfvhWPzhlqNXXmhPIEEbao/tI=;
 b=D8GHB1a+fcpGvC0iQB0USFr6MkgzUgAM6Uju/BUdBp7B5/aDMNRpLfkCYxHZroHyQ762iGdEzY3BF+sQfpaO576IWbp1pct/adUhRxMymICYNySV/4UaBHmq3t350l734COj9tPrfsO60cRABtFZyYoxVmSoz+4manRty1WKkqjieyHEa7ZAuT9gITS/r7AlPxCHLiR9mSQN6udI8TdPvDAIZ8Dx2sYHI04na2wtxBB8/fw6jCmkiXJviTqupcwfatStc9INrdKpy8S5SyQUK34+n83HV524woI+y+f88Qs6Z/XH4e0m3w1VLgWH5THJk1VSyxyEo8sEag0U6tNxPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0btOV3TyOo6Gv7HVd5FfvhWPzhlqNXXmhPIEEbao/tI=;
 b=jq8zp4sNVkI/shxasyGOKO4UhGjp15+XWQG4eyWu2U0BdB9OsYk/+o8/dr5Ux8D+DvrgJIgrAA0BuV5IJckiGzFrFu+XszjswJ2fJ+4AYhizYyRRIpLhFMeyUgQkKplis3GSG0ZJT+ZaksGwiOxqXdfrSB20UrJIGMdK+uIAgDw=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BY5PR03MB5345.namprd03.prod.outlook.com (2603:10b6:a03:219::16)
 by BY5PR03MB5080.namprd03.prod.outlook.com (2603:10b6:a03:1ea::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 07:14:54 +0000
Received: from BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72]) by BY5PR03MB5345.namprd03.prod.outlook.com
 ([fe80::8569:341f:4bc6:5b72%8]) with mapi id 15.20.4020.022; Wed, 14 Apr 2021
 07:14:54 +0000
Date:   Wed, 14 Apr 2021 15:14:45 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/kprobes: Simplify alloc_insn_page() with
 __vmalloc_node_range
Message-ID: <20210414151445.6e4e5386@xhacker.debian>
In-Reply-To: <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
References: <20210413180231.19b72601@xhacker.debian>
        <20210413220030.d1cbbc63659dcbc52876696d@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.147.44.204]
X-ClientProxiedBy: BY5PR20CA0001.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::14) To BY5PR03MB5345.namprd03.prod.outlook.com
 (2603:10b6:a03:219::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (192.147.44.204) by BY5PR20CA0001.namprd20.prod.outlook.com (2603:10b6:a03:1f4::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Wed, 14 Apr 2021 07:14:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 695455e4-71b5-4962-4e7e-08d8ff150069
X-MS-TrafficTypeDiagnostic: BY5PR03MB5080:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5080FCD50C2D27B7768832CEED4E9@BY5PR03MB5080.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BTnJ5n+V6AU7Q60VnpY1UMxY9eS41iPfGYQ9OPSLRxvzeDIsKxrn8BP4zIfsdGOeOuA6Rj1H4j1OOp+t2kB61FM6K3yGfIzd+T+8Ua7vfPAkiTpN6MUxC7Rd5Myt11ndpVqSQj+Fo2SKc1Dn8sLRaFRnwpPRRgYLcGn32Bksey1pSe3YHKAKo/aBHzIcgPJd9LYo+c3dNheHWTr89gox/jQKjG1TpEul6CiazZ+j47ASmsLUXmP/bJL0+c3ckg04/j5V/4QtYDL4dkXOkkDaU2AduVLKkh2FbFzoS9Aa10pGVnC+nU99Hx4Y38eCjB7RKnGLfKe4jK5JTzI0+T3jRbVv9YhpezNKWlt5Lvtn+d/6+9Sdn24X6K/G5LtpfJYn3hF6pZd4NczNTLq2Xvz2X4/BaJkH2I7RJFw2Wd4rHdYTID7EJjLR/No2r+FytnbXxeDgCMq9mCR6APzub2HlC3fjY/1nDRBghm3s8UvbYXAJxKDImvB384/Mu5nwfTRs3OI199W5RijExHGoMJcZGi6lI2bxEYPv9HICnzu23WeZh7Z0WaXsxldzXSqpgxBOyJlQDaKASafJ8bzV41tVKGLoWdLI/v3Cyn6NdNvbfz0QZ3n8lX2Ou9/Rw6VI0+UmqGj9RKrrsU7UcoCsRzNmChTjjdx8ekLGCr3ktKlf0sI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR03MB5345.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(376002)(136003)(366004)(346002)(396003)(66946007)(54906003)(38100700002)(38350700002)(66556008)(6506007)(8936002)(66476007)(5660300002)(316002)(52116002)(7696005)(8676002)(6666004)(86362001)(55016002)(478600001)(6916009)(1076003)(956004)(9686003)(26005)(83380400001)(186003)(4326008)(2906002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?YoDBWXjPyzVMo7eDCE2GSCfmFw/7/1UuB4PoBb7Dj5IPhM2RFpP+K7ASJNdN?=
 =?us-ascii?Q?x4w5A282qLIHiwLsZNuLGHOVr1V9AKmmzNOoydgrIYS2GndbxtqM9JoB+p5q?=
 =?us-ascii?Q?NGiqQ/9oMQUxNCTX4+bIe905O2BdQqbTjhYUHx/ZDwqC/zuLugDnQrkw4DNS?=
 =?us-ascii?Q?OnwFyUbvakd+E4VEzaUbiqj1tMaoW+LURO87Kk6IiOA+S4kKicEAxrH/yfL5?=
 =?us-ascii?Q?0n60/8DAKKXNnd+DZEHQ3kvNN/qTpC/RZn1te+WxvcTWEU3nMqxLvD5R+kY9?=
 =?us-ascii?Q?WhVrRjxfX9IDjEyq3e5YiwcqY/sVH7U5AuO+q7+1h7y+0a76RohVjuaC25CR?=
 =?us-ascii?Q?Gp8uFfukGNvlgxDgdBp3XWqEyAhrevTzG9T+YT2M3cQIegZjRxsFkMP2X6pB?=
 =?us-ascii?Q?Y+i5hbh+qrMk+ROlK8941lHmY7xmhdB635slRLWvyxxhEQpZZkdB+RHrWEGg?=
 =?us-ascii?Q?NxZUhbm3RLnOP1APtcFPlROPl+FsuC82krwXOQqTXhqN8mlb+foaJSdssd4P?=
 =?us-ascii?Q?3xwFe+LtFWwn/fW9mheUT4fH9/wNBOZNVSLQPuHUNiafOwPRaionWkqpv63F?=
 =?us-ascii?Q?RuAKxiZEUdnbkOMKc0aeXiyTbgmE9k/ZQz2gZirTOeSvJ3MizaTcmzOEo9hi?=
 =?us-ascii?Q?vYRxZyIMTPoiv58pWJnSqJsjaZG1V8VTy9ChnI2ddMl4tSLW06E9o0rhtJqz?=
 =?us-ascii?Q?cawU3AzekZaJ1ZKxRq1jW2MGu+fwYlLNhZbwfNooGDX8PgqeyY5Xp/pRfmTm?=
 =?us-ascii?Q?uNirqBR/yi1+Sc8ZwfleNeWF3G9a0gMH79FwB7yFPpSqymKkjFf8sy8yIrYa?=
 =?us-ascii?Q?+TDMw+IomHYGdgs0XlR3Yc4ZbFGETGIfMOXjhzTDW++2zTIqwFA2RKBIOpZb?=
 =?us-ascii?Q?gLKI12vtQvVLOuPnRACkLlqTFRY8/5RRzB2E8r8nZyM/0AqE5k9wr/kfDyLo?=
 =?us-ascii?Q?y8PCdHeOF0Ct7JK3wLAg9YK2sbHe3u2F/rqoO/nJm1eFMBa/ADBZyhZW0g8p?=
 =?us-ascii?Q?a0mAm4Z+n79UN68hhCaZM7cHbzKan4gfurBSg/v9G5tfbZMncBhT4od4Ijxz?=
 =?us-ascii?Q?JoX+y67nOazd802BxWFo7LBcUUk6q51gLuRTLwZBvOmWXkWpdJb6b5UfVFCZ?=
 =?us-ascii?Q?aC6pRBTuqsGcXKT9AdLPl0dr6IOTznUwHSHkC2WyEDBHru1JWWeanhVTyTEo?=
 =?us-ascii?Q?2RP+8H+nsd2SXIpGnWtGTx5nf6Fizbqx+UzaRnTM9BWKjmZyFTaFRuLdWXOz?=
 =?us-ascii?Q?sieYuaRGp8ruOgi3LZa720BH8Wgirfld6jpLYI4LD9Cm8DgYymuGjp0Yz9CC?=
 =?us-ascii?Q?MInVDK1m46OzEOo+TU40ZiMV?=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 695455e4-71b5-4962-4e7e-08d8ff150069
X-MS-Exchange-CrossTenant-AuthSource: BY5PR03MB5345.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2021 07:14:54.0477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0Gcv1dVDkh8yzNuIWDQSV46rjSviBEEM8GRExA8MwKWe0jsspYDpIDSj0GNQxPKCYytqGSDbCFS61rd6yjX3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2021 22:00:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:


> 
> 
> Hi,

Hi

> 
> On Tue, 13 Apr 2021 18:03:24 +0800
> Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> 
> > Use the __vmalloc_node_range() to simplify x86's alloc_insn_page()
> > implementation.  
> 
> Have you checked this is equivarent to the original code on
> all architecture? IIRC, some arch has a special module_alloc(),

Indeed, this isn't equivarent to the original code. FWICT, the differences
on x86 are:

1) module_alloc() allocates a special vmalloc range
2) module_alloc() randomizes the return address via. module_load_offset()
3) module_alloc() also supports kasan instrumentation by kasan_module_alloc()

But I'm not sure whether the above differences are useful for kprobes ss insn
slot page or not. Take 1) for example, special range in module_alloc is
due to relative jump limitation, modules need to call kernel .text. does
kprobes ss ins slot needs this limitation too?

Thanks


> thus I NACKed similar patch previously.
> 
> Thank you,
> 
> >
> > Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> > ---
> >  arch/x86/kernel/kprobes/core.c | 24 ++++--------------------
> >  1 file changed, 4 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
> > index df776cdca327..75081f3dbe44 100644
> > --- a/arch/x86/kernel/kprobes/core.c
> > +++ b/arch/x86/kernel/kprobes/core.c
> > @@ -383,26 +383,10 @@ static int prepare_boost(kprobe_opcode_t *buf, struct kprobe *p,
> >  /* Make page to RO mode when allocate it */
> >  void *alloc_insn_page(void)
> >  {
> > -     void *page;
> > -
> > -     page = module_alloc(PAGE_SIZE);
> > -     if (!page)
> > -             return NULL;
> > -
> > -     set_vm_flush_reset_perms(page);
> > -     /*
> > -      * First make the page read-only, and only then make it executable to
> > -      * prevent it from being W+X in between.
> > -      */
> > -     set_memory_ro((unsigned long)page, 1);
> > -
> > -     /*
> > -      * TODO: Once additional kernel code protection mechanisms are set, ensure
> > -      * that the page was not maliciously altered and it is still zeroed.
> > -      */
> > -     set_memory_x((unsigned long)page, 1);
> > -
> > -     return page;
> > +     return __vmalloc_node_range(PAGE_SIZE, PAGE_SIZE, VMALLOC_START,
> > +                     VMALLOC_END, GFP_KERNEL, PAGE_KERNEL_ROX,
> > +                     VM_FLUSH_RESET_PERMS, NUMA_NO_NODE,
> > +                     __builtin_return_address(0));
> >  }
> >
> >  /* Recover page to RW mode before releasing it */
> > --
> > 2.31.0
> >  
> 
> 
> --
> Masami Hiramatsu <mhiramat@kernel.org>

