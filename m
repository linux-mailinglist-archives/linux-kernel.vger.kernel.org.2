Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377A43AC06B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 03:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233484AbhFRBGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 21:06:31 -0400
Received: from mail-dm6nam12on2090.outbound.protection.outlook.com ([40.107.243.90]:9664
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233421AbhFRBGa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 21:06:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lu4hWSMduEz1H17eGMavWVTL8/1M9KXViGwWJDBhlAG5XwoQMg6qdxCFA3vqPTUNhGaHxZM2uwW5YkAo00JiqTV+3JmBsQ1gansJ26/1ptaKfcFiaPlCDeO0ROelk4k7WtHaGn3DMv7DiWGqzVVTZg+xOe41meoXcFvvmidyDoUvn7NawCuoB5Y1X/ugNqAWXLnZBd2qWuEA29GzbQDjetjlbvl5ZDJXYEOgRQwMNcjsKkVFUkvTjW3G7OTROGwIINHJTtj9N0/BUusXm9YGSjeQZjLdRvFv8GF13SohNy8XtXlgp1xRe+eY+/esXxo2kN8VeWAtuVZ1DUluxPo4/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgZ5lfbMW3APirQPUc9yDp3yWl7VeqsZE2020I9nhmY=;
 b=aJpmlkAzEhtKWrNKb5Mrnb2Thk2wJAKWzXwf/QBfHLKDcKwvAUDW/l6v0W/BYa0qTDQbWjR8wSMB/8x7CyWWkL8RW1r1HYTaBTg0Zh5zPRXMmQXbTjqf38ertZqAio1gU5DpWKxNPZi8w1WwltrqGGqU0YEjohm/9223A6m8hEwjVuvZNnG9jj7/m6QfKKHYJZcPsXThJgDOe0wY7kOcDMcz02kzRGAPjxYxD5DxV7gb/euvhmY4UA+HhCvi8ph5G6qhiA80WTPyplyaFAo0rsEOVJPF46A606e2pQpRafvnY0/LZhiS9tJpYzx7c1IjUIY+TQ1dETb+PEjpokpdyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgZ5lfbMW3APirQPUc9yDp3yWl7VeqsZE2020I9nhmY=;
 b=kvdgDMlki/kDDdnUY4SYS+ehb6rL3WGVaCHK3T16SKBKDrBgJXhV4wSbpXXJUlbnOVN7YgdhJJ78YjP5wQsUDeyQY//mQpYqUH2lxiJBOFNBZvGZIvBUP+GSRxL07hGaZ0Wp4JE5xLZU+zMoXMmjylmgEbCfUTgn7lw0kZT90ts=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 CO2PR01MB2039.prod.exchangelabs.com (2603:10b6:102:7::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4219.24; Fri, 18 Jun 2021 01:04:17 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::842:9ada:565f:8b98%3]) with mapi id 15.20.4219.027; Fri, 18 Jun 2021
 01:04:17 +0000
Date:   Fri, 18 Jun 2021 09:03:26 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Will Deacon <will@kernel.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Catalin Marinas <catalin.marinas@arm.com>, tabba@google.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@amperecomputing.com,
        zwang@amperecomputing.com
Subject: Re: [PATCH] arm64: kexec: flush log to console in nmi_panic()
Message-ID: <YMxhXkdqU+MVJW33@hsj>
References: <20210617125023.7288-1-shijie@os.amperecomputing.com>
 <20210617175211.GE24813@willie-the-truck>
 <CA+CK2bC5XW_AjnieWZ-ro8iqr0Jb7cz5Ss5549tJTq3Zm4GYiQ@mail.gmail.com>
 <20210617175822.GG24813@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210617175822.GG24813@willie-the-truck>
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR22CA0039.namprd22.prod.outlook.com
 (2603:10b6:903:ed::25) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj (180.167.209.74) by CY4PR22CA0039.namprd22.prod.outlook.com (2603:10b6:903:ed::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Fri, 18 Jun 2021 01:04:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1cc1c33-ee24-41c0-7011-08d931f4feac
X-MS-TrafficTypeDiagnostic: CO2PR01MB2039:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO2PR01MB2039C67FFDE7F2BF3BCFBECAED0D9@CO2PR01MB2039.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KB/+BGs4V5cRx2K+Xmgoyr5Bih08T0/wr2v7eQuZkm2z2RKQB2CepbbES3r0XebasDx95NY6tR6PX85Iu5fdiJWOqilnyTSkhwkMFM5K4t5wqAVFiqBSGa/ISBt09VdVP9ViwzYKd94saWXOJ5OCBYhAjHctECumtBl/TwWdChoIyFFUbj/0+GYhQ+kqjVqgCNdNrTgTFOQTcAmaoK5Twg4LtncFquP+pCiMhoEFe/Qsq65+5HuDfxKrO+xW5tToQXP8HC91ZhDJNV0ujjpVt3F2j14PUp0RTfFvtkyzFtLSTv7ff9pjeWqT4lIEv5tkl1HeoaukwUEK9dK/oltqVf0TGk/uOLci1fQk8H9iuqkhIzCErtSMj8mNlxaJsRlWX6monxy23P3edvVyMGE9SrnY7V1cr/GPLEZ0TcNXu+4xvUD6ykZd5SZ3qHshXhonQui0PcIIcWwIh+Rw380rxwYFuvinN+6fdCoNH4+sEmVqDs0r9VfJADylK4h1bWM41W3SO1lusKqrjVhJJzus5lYLNqA0CXv+K8BkMeOqTPdrA+QBd/aFbswDxoyDhgiVHvZBySPJ7CNnK6CGU1CDVh8Vps760Hh2kJbA87iMv2sPDu78L59S9GuAa7D5lcGlJIncL4MjIxoCNXFmU9NQBZQ4/yUfkE/idiGGKy49RaCtsQszuEoyUA4DJV9QslzO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(39840400004)(346002)(366004)(376002)(396003)(136003)(478600001)(316002)(6916009)(54906003)(9686003)(55016002)(66556008)(66946007)(26005)(53546011)(86362001)(5660300002)(8676002)(52116002)(8936002)(9576002)(16526019)(186003)(66476007)(6496006)(38100700002)(38350700002)(83380400001)(2906002)(956004)(107886003)(6666004)(4326008)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6ju6o5OjX1aMjGqa3uWXNYI91gtiZHJlmmWxQik9l280sQuyOXqjcwtfEPiZ?=
 =?us-ascii?Q?NcVDPyEWU5cOTTKvAfTzwJO6Pp1zuTIXisaFRjI7vDHKoSrhfDB/MZifnicS?=
 =?us-ascii?Q?L1rbsw9Wo6gSzNRRXqzoFIi7suTaIe1RDM1HlrZEKatYHi6GhkORpOTJk1ij?=
 =?us-ascii?Q?YrhgMCxFSXTpeK/1XqQATR7Hk6cEMuuwcoP3FdGNR40STcMvVlHJZgPjkJY2?=
 =?us-ascii?Q?3JCBDPyaZ/KhVgdhhZN8P+uTfMe9PGvZWDKM0pcih19pxUaEebMlk0E8F4Sm?=
 =?us-ascii?Q?nZWiOKQddhGB4cE93KHZLR39A4efXjSsf2DQv3gFeHZ6ggS4E6UHHHk32nG4?=
 =?us-ascii?Q?IlCopCK0cxE7BxkvHhzpCUtPHwlRInubH5kxf7P+zPgZAlsvKSqn4oURsq6H?=
 =?us-ascii?Q?y6GEhajvuQ0YA8PwehdVC18FR1cokqLCxK/2DND3cKENMFH6z9rpUfIqfuSh?=
 =?us-ascii?Q?McAVKLB3gNw+51/bF6hHqAzb94jhJov69Srgq/zJKJ6TiqlPduAKEMfPjv+n?=
 =?us-ascii?Q?wuSxQ+welyQJA1n2uIhcR8jF1D0QvRGg/649nOWjTyLGcvqMmvcixQaa6ZMV?=
 =?us-ascii?Q?Px8tO1hWbjhjnhVKyJj0WHEmBpddJbI0dFndrtnNtXEFto5n3dAVQnCXnyIV?=
 =?us-ascii?Q?szc+O8ZSN9uwAugIqbTDMpPTDow+Cn4sL95/40TgOcl7bsXSI7zH9re7LJee?=
 =?us-ascii?Q?vIxndjgrCcb2no5O0Q2CU+7HpYIeNX8KpLs+LQ929wvi0aUPaIfG6t8WKCzO?=
 =?us-ascii?Q?7ZjAqcSf3Xa2AuUCudbUuUNbuK/Gi+jBgF1oDMzFrsLFY3xlX9cEEOgDpPkC?=
 =?us-ascii?Q?aEyb7yAO6+A+yEQlJGohY0vQScX/kEKsZb4b0kN5MAY4Vs96z4ujAlWd5KB4?=
 =?us-ascii?Q?mnudVuKYO5Ec4HCpiWfVKeYfsEOZHpUuAs2c6nyJINUzdtLrLoJxn89rlKsD?=
 =?us-ascii?Q?ubSxK1APKMlUX8SrtHr+A0MrAFNLKNBPXgB2O4hoj1d33og3ZO0j53LL0kdi?=
 =?us-ascii?Q?ZPvQMVNvz21xaJfGrxr5Nqa1vg4G5qU1H1XbjqiisiGDILW5kgguWXS0Stze?=
 =?us-ascii?Q?7yF4PMz6jtLedp+6Ln73EDczcJVegLo9ISqbAO3G9352AnR41NSnN+p5Ec9W?=
 =?us-ascii?Q?ycj5T4BObmpoUoRtGrcOqtn7Ng2WJs+mmwmmt8HeAAtqi+yLwi1XFl8mP3s9?=
 =?us-ascii?Q?ydIvji67zUM4/orCX7kS2oGWe+XmR4qQeEAGWrDLd5fWotZDF8Gbkl4ukjil?=
 =?us-ascii?Q?s4ghWr/O6ShFofDxK6FtuPiXp1Lq6Jm6h2e08lQNxnPp7jDIOnQFhF8deA6S?=
 =?us-ascii?Q?2Ij6hvO6ETK9SWY6FG7zl/0T?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1cc1c33-ee24-41c0-7011-08d931f4feac
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 01:04:17.2595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XmWik1AkUd5zsekRZULPIfX1FCcoM8i6+fawN/PU63yvgH4oxwv22wQ9VE4deF5kmpEMznHgN3hGl4wHSH/bmyRNpgODPKJ3PaQQBHorI80AWyES/bAbB1BPl5Z5jwlU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO2PR01MB2039
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2021 at 06:58:23PM +0100, Will Deacon wrote:
> On Thu, Jun 17, 2021 at 01:55:08PM -0400, Pavel Tatashin wrote:
> > On Thu, Jun 17, 2021 at 1:52 PM Will Deacon <will@kernel.org> wrote:
> > >
> > > On Thu, Jun 17, 2021 at 12:50:23PM +0000, Huang Shijie wrote:
> > > > If kdump is configured, nmi_panic() may run to machine_kexec().
> > > >
> > > > But in NMI context, the log is put in PER-CPU nmi_print_seq.
> > > > So we can not see any log on the console since we entered the NMI context,
> > > > such as the "Bye!" in previous line.
> > > >
> > > > This patch fixes this issue by two steps:
> > > >       1) Uses printk_safe_flush_on_panic() to flush the log from
> > > >              nmi_print_seq to global printk ring buffer,
> > > >         2) Then uses console_flush_on_panic() to flush to console.
> > > >
> > > > After this patch, we can see the "Bye!" log in the panic console.
> > >
> > > Does it matter? I'd be more inclined to remove the print altogether...
We may remove the log in the arm64 code.

But in the panic() itself, it still has many log, such as:

	..............
	pr_emerg("Kernel panic - not syncing: %s\n", buf);
	..............
	dump_stack();
	..............
	kdb_printf("PANIC: %s\n", msg);

Without this patch, all these log above will loss..

> > 
> > I agree, the print could be removed entirely. But, my assumption was
> > that this patch meant to flush other buffered prints beside this last
> > "Bye" one.
> 
> That sounds like something which should be done in the core code, rather
> than the in the architecture backend (and looks like panic() might do this
> already?)
In the non-kdump code path, the core code will take care of it, please read the
code in panic().

But in the kdump code path, the architecture code should take care of it.

Thanks
Huang Shijie
