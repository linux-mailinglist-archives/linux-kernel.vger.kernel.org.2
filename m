Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437633AFAF4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 04:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhFVCR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 22:17:56 -0400
Received: from mail-dm6nam10on2131.outbound.protection.outlook.com ([40.107.93.131]:39108
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231252AbhFVCRz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 22:17:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DvxrrBhn0oAg381DGfRhSsouxQFwiHwo7oVX625fYIByKE8FiINXj+ih5XxlkGK4DmpM6rQ/loyj5dcFvYpjocxt8iT7RzmgYwjkZlYBG7cVWRVFbOnlbmJQvjinkbowsAHglEZcDkeUiEPDDcFNlRbIblfMwK+KUNRjX63Yf75SDTEi/ny6LQdpyY9WzLFfrOnN+nSlfV7lcMFk4REoxJJTJOXZF89lOIDupaQBfwkMk7CnQufDb9gd/nS/k/qqxxPKe99IgSgtBV0G/CxYr0VqTQEPk6nW7OMcYjDc/9BL2pLvunaHjLR5gVQyB1kn6RWMioOE9cyaFXIsgNFr0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrkyDw9xbcuOO8xxlunuQ2pa8s+7ssS00WCGH4WyPMA=;
 b=Gws2UHyxUMVpfhXlULSmoT1DEKw+UrOjt4n0MQ8+bboGLLBWrk0K+HZefuJQ0k+2GwRCOgWPq9Q3b6sCQ9D45aLGB6b0zI0ycHoT1Io2cF8ps83xqSHNkB4WCo6bWiKwvQWX741/TgUeY/pC/JMRRf9zYHrrX4UHGoEX7oDDBq6rd8zz3kL6s05mqDgj7Xe1uzZDZGOlMcxkxRdmgmsKCZO5beSOqMy5HRcNJj5BZgf+ql/nggaskTDkzxqWlBFbDyRbYedzNox5OaftyN6vZzISvatToSTbxJjkqDjBK8QlmGbhs1Ac4UX0Hh43zddIOSNZGnEzayRxoY918WNCGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KrkyDw9xbcuOO8xxlunuQ2pa8s+7ssS00WCGH4WyPMA=;
 b=uky+lr1uzgJPQ1tXuT1Na1LnJLc7zaa0Rmpe+chPF4+OTnHuVzIUdXUVwMSEyh9HcpxHYwWUkAcsv1XyAb5ZThqbvv0AgEks/MTmIlfU1fxFTERHA5FTfBuppQyUi+3G7dRF6SnTt1xmHOwVZWB1fVdHmM9qy1GAzLMjElGWIjc=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from MWHPR0101MB3165.prod.exchangelabs.com (2603:10b6:301:2f::19) by
 MW2PR0102MB3530.prod.exchangelabs.com (2603:10b6:302:12::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.22; Tue, 22 Jun 2021 02:15:33 +0000
Received: from MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::921:cd21:94b0:c87b]) by MWHPR0101MB3165.prod.exchangelabs.com
 ([fe80::921:cd21:94b0:c87b%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 02:15:33 +0000
Date:   Tue, 22 Jun 2021 10:14:38 +0000
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
Message-ID: <YNG4DgMPluU9T9+R@hsj>
References: <20210617125023.7288-1-shijie@os.amperecomputing.com>
 <20210617175211.GE24813@willie-the-truck>
 <CA+CK2bC5XW_AjnieWZ-ro8iqr0Jb7cz5Ss5549tJTq3Zm4GYiQ@mail.gmail.com>
 <20210617175822.GG24813@willie-the-truck>
 <YMxhXkdqU+MVJW33@hsj>
 <20210621100836.GA28788@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621100836.GA28788@willie-the-truck>
X-Originating-IP: [180.167.209.74]
X-ClientProxiedBy: CY4PR06CA0043.namprd06.prod.outlook.com
 (2603:10b6:903:77::29) To MWHPR0101MB3165.prod.exchangelabs.com
 (2603:10b6:301:2f::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hsj (180.167.209.74) by CY4PR06CA0043.namprd06.prod.outlook.com (2603:10b6:903:77::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19 via Frontend Transport; Tue, 22 Jun 2021 02:15:30 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 608ab9f2-cc93-45da-e935-08d935239d72
X-MS-TrafficTypeDiagnostic: MW2PR0102MB3530:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR0102MB3530B3F66E071BFD204A02CCED099@MW2PR0102MB3530.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lXfJYWNvtBixFru2kh/NFkyuu7P4ak1EZMtNhv48M+3zwAgvQeTbP5jLmj3TRwJ7rLavFL+8EKw6uAx2QuvLqknakPntYyPJvW0OhEohTk1ltml0luL15YSVcSiajcYgtIX+aI8Rj9EeLXcTFkk0wBTDDwvL6dIzFfF9bzF/aKp7FODsWQp27TaXBqp98UYioho0KxMloIOJJewXW7/Z//m4d66k1ulUplzIxlsNZz2BLkIHCnMLVICiNVd/tu6nzw8FWkYc89by253gO31yB39oKlNMB8WoSbbPkv9if93gJWASGtiSMOKoKnT+Rq6BIUFY61xJlfgxj+JvkSOPol9YbsJtTaxSB9/8/hOX+L4zXMpm2XfHYOSADh++Tl1AVhI32iGQ8bEw+HIyebPw/a33YQ36RiZUIl+Y5zRxNsd0hxsPl8gfRp+kgN3A0F+GmLbDSbExFrFO+W+IWDmPiaYlHxN3BXcpoyBn8ySoRUSlz0dulmR8gp2b03y0T0Lp0yxdNgWMn1D/zBOhg+vfTdq7oUx2oT30MPWNd+zrLPRtzMLfHuBQfS02p2JCj2Fpii8GALreHK/pKOJ4E5Vyi0mEmj0yMMlo4cwm1rTMPkQHvcOFZVrSV0MILP87enLKjrqyVriEqaZ6bVixnPqKKj94Gq9ROjpOjKahhyG3fYpNZGdwRkyV42f/I1iN7ShY
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR0101MB3165.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39840400004)(376002)(136003)(366004)(16526019)(26005)(186003)(33716001)(956004)(8936002)(9576002)(8676002)(316002)(6916009)(52116002)(6496006)(2906002)(9686003)(54906003)(38100700002)(86362001)(55016002)(107886003)(66946007)(66556008)(38350700002)(83380400001)(5660300002)(4326008)(66476007)(478600001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4rBlZ6+KtdnKHHvB0lXZ0dzWQ66axspSCtikZdd4evFlATARwsI8NiUG7aG4?=
 =?us-ascii?Q?CM3H0Jo75HiZ45hkVp4NCx64S0MqeZEV6XHVMb1PXbqvA3dFF1e7bWhsaic4?=
 =?us-ascii?Q?+0ne+Y+wEdtWiXBVvms7PrqDvoPk6JSv35gEgwgrWyhC1AGTb8RCEjK6Gl4a?=
 =?us-ascii?Q?4wsqoBFlOc0MNdpBc+PxUuUHjlSnVjcnXiWvCvPasNajE3HmGcVtoh1xCUX2?=
 =?us-ascii?Q?/XWHZQthnvlsASltH6VkuLjcMZ1nxJu9qwJn2FqfSosLBcLT+k/kinz5nbcz?=
 =?us-ascii?Q?U25P5urLWNqZrJxK3o7IrHu6gUK1z5A9++1VpxmbbIWiXzt9EU8OZzaJYdat?=
 =?us-ascii?Q?lxrQ604yHCe9WqK3KiWbKT7pjQKJS59hVffOWjqmeTPT67ZdFY2lmDpGythF?=
 =?us-ascii?Q?6k/oKOIGSlC/bgoUP2XLxXpaMQJJ/klgeNSswkailI3k8zL4d7x6M04642tB?=
 =?us-ascii?Q?VCnkcYQuQkX0mN39wZgkb4GXKcx2UEp4w4BXdJXQgh8+R8B9BAisyId86IyT?=
 =?us-ascii?Q?fpj/ceTFjF8SViyzV6oiSpK/+yAIPyTZbhRdmmqrg5a1u2cn3xt/ZRfIDx9D?=
 =?us-ascii?Q?VUDw0Dnj6OkIQVX4+VTpF0MD7XQoOB/hNpKYmh4cLROxIthUry+nvoPpMksS?=
 =?us-ascii?Q?br/bV7EI+VuvuAmZI1zMkHnniiyrgFKslWr5a3R9pv15W5PG99VHGYsSp24+?=
 =?us-ascii?Q?cuxAX4Ddp/ml9+hTi9PIcqu13zTsFe3MjnLd0Aov16igzc7Kv1fjIm6rq/bJ?=
 =?us-ascii?Q?+4oPr8R79hffaxzN02yVcUFNrEttDlDAyB8e4gvu4waeQgU5H1aLWsqvtuZ6?=
 =?us-ascii?Q?PkOu/bfBOq6yorjkTIVt7vext6QNUJMm0eaLSOCJGDIONUGlCn6bjOh0sDCD?=
 =?us-ascii?Q?/1B7vnPX0xwJs3WGyU00Ii98gX5CX8PYDNXhheh6vylnMmXtPbzlAxa5VREb?=
 =?us-ascii?Q?/ROMYC8Th6ApH+LbrBa57v4fvREm8NFXY65b9AFcua41hQFc3nNQf7rRLKX7?=
 =?us-ascii?Q?Wo1ds7blk/fvIfWMb/QmeZQQXcHCPfy7/lFG5QigUIarBnWIdFWdEmOiF5sZ?=
 =?us-ascii?Q?lH+0277gdaVHoMQN/E1F3s5F+Gx3znR7cFRl5R0H3ecra4nHwKW0/NDKB/5l?=
 =?us-ascii?Q?zN7obU7Femf+zFqdX1TkwNetSwxCuYrmWM5ZgL9D2be1+U4pxWD3vquzitSr?=
 =?us-ascii?Q?xKlORMWcof4Li+uYRz9PJos90J77KBS/U418spCzKllMyGRX3iLeRSUoUe9z?=
 =?us-ascii?Q?nbXkNNucMisOWy4vKTe2r68eCk260TaJCYxTrZwoUaF3X9doOo9zBU/X2k/3?=
 =?us-ascii?Q?eyoVksxZkOrnlCB9ZPAEdXeL?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608ab9f2-cc93-45da-e935-08d935239d72
X-MS-Exchange-CrossTenant-AuthSource: MWHPR0101MB3165.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 02:15:33.4984
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 417a74yPlk6JRivEt+J+tJT1Io8GzSAf8bZXVy2ZtoHQDlQz0VdTjw3qIDNyWnPEtlSAQpQlUONCLo29lGOOn51+PL74LHIiKHfAY1C/3tJVoXN22uPq42ci4s5BvX3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR0102MB3530
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,
On Mon, Jun 21, 2021 at 11:08:37AM +0100, Will Deacon wrote:
> > > That sounds like something which should be done in the core code, rather
> > > than the in the architecture backend (and looks like panic() might do this
> > > already?)
> > In the non-kdump code path, the core code will take care of it, please read the
> > code in panic().
> > 
> > But in the kdump code path, the architecture code should take care of it.
> 
> Why the discrepancy? Wouldn't it make more sense to do this in panic() for
> both cases, if the prints that we want to display are coming from panic()
> itself?

In the kdump code path, code call like this:
	panic() -->__crash_kexec() --> machine_kexec();

When we reach arm64's machine_kexec(), it means we can __NOT__ return to the panic(), we will run
to the kdump linux kernel by cpu_soft_restart().

So we can not depend the panic() to print the log. :)
	
By the way, I quote part of the arm64 log after we enter __crash_kexec() in NMI context:
	1.) the log in machine_crash_shutdown()
	      ..............
		pr_crit("SMP: stopping secondary CPUs\n");
	      ..............
		pr_info("Starting crashdump kernel...\n");
	      ..............

        2.) the log in machine_kexec()

	      ..............
		WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
			"Some CPUs may be stale, kdump will be unreliable.\n");
	      ..............
		the logs in kexec_segment_flush(kimage);
	      ..............
		pr_info("Bye!\n");


We cannot remove them all, and need to flush all the logs above to console in the NMI context.		


Thanks
Huang Shijie
