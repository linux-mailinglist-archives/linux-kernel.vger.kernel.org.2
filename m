Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F333036651D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Apr 2021 08:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbhDUGDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 02:03:23 -0400
Received: from mail-dm6nam11on2070.outbound.protection.outlook.com ([40.107.223.70]:54497
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230343AbhDUGDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 02:03:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=an6C+1UnhgMNQP+9VjQSll6KM+STJsVeoGy7zBJlERj74YUWmUCCHwuy3g+7AgE9e0ShKY1B2r7fb226Fw57JMoPpnDtgxAL2d3G2l/3T16rznd6EO0XsTEhOBvTy/5uWr7QXf2km9tAAVCXwMlIuUs0M5Hz99teLFG+ImbjdWtstk38Srukr8TRnh5Q30jtIw9pQIYOTAj+l+JMtZY/DgQBZYrZEd5WM7DVRqpFOC2QLeyvn6pskvIu6VBGZXkBSRgkde+jpaiRr7eVkCMOXxhug15c7X68c+jbxsRLeCqaaDEn+uKXU4mkwK5FR57UPt3yv5FDqD4WMamy9Xt61Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLCBLasi75J2NWMIF1JbuKdPAZrdHZGeM8FNOpK31XY=;
 b=MLGflotwXdyYoZvPqO/P3SatSNMEzJTGz8KIhjA+ly3fiQkZS0VBXzsytDbMr3Z/MEvC0gBO2k7tRHPx/3bdW7IPl0/ySdBf/aJ7A0lB0bCfqry6N9OGRPiED6LnZMa2c6z5bUS2IUFQ2YTARoGJbUYacO5ezBgmG4aILAL4A0gKsYs2O+dxk5XoJRA4B1Y4DQvmS4U3UWw5w35vSXjZXaRI/OaxAXCBhZaYJVBSovDL1hVTjtSnGtrFKCDx3TPpHtKObYGN0oUJoUKFj9sLVSiaosNuoJTECz8VeCBxWhNbZZ636kvAsJkJtsDiMjgvwv3LIbfrO7m0gRoozwYl8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QLCBLasi75J2NWMIF1JbuKdPAZrdHZGeM8FNOpK31XY=;
 b=d/N7WDWx4buX+zbhELPZLLCmGgRo2k069A5H9TWtuivZwf+hkLA56rSfzN/KdvgOEnK7HoGInMFJD2S3qYnr+r0Wd43DaGRe6Wt0KfuYJ0XxztMExs8hclY0FJ0VilE+zjDuvBoX9z4a1BygJ3KGNa3PkXo267VqC3JN8Y/N4r4=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB3691.namprd11.prod.outlook.com (2603:10b6:5:146::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.20; Wed, 21 Apr
 2021 06:02:47 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::1caa:f0c2:b584:4aea%3]) with mapi id 15.20.4065.021; Wed, 21 Apr 2021
 06:02:47 +0000
Date:   Wed, 21 Apr 2021 02:02:43 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] sched/isolation: don't do unbounded chomp on bootarg
 string
Message-ID: <20210421060243.GC194948@windriver.com>
References: <20210418215426.1086941-1-paul.gortmaker@windriver.com>
 <20210419203855.GX4440@xz-x1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210419203855.GX4440@xz-x1>
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: BLAPR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:208:32a::6) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (128.224.252.2) by BLAPR03CA0091.namprd03.prod.outlook.com (2603:10b6:208:32a::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20 via Frontend Transport; Wed, 21 Apr 2021 06:02:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 676476ef-984e-443b-ff70-08d9048b161b
X-MS-TrafficTypeDiagnostic: DM6PR11MB3691:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3691FA374E1C84ADF67B6B6183479@DM6PR11MB3691.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eqb13KiK2RotUUGLwA+JnJPF/axesXyt/GXr3WuweQU2jc8Ms0rz1bpN+3IoSqTfZl4p2EBFP/B0fIZ28fMSRLVnTHjazyaH6IgqCbR+93uWEhtujBGUKe2Wahx5zDPZICzTP5u6ZkQmhcp8amvpiSfCJdfrHeAAnoFzt9h81XTWmgz3E+qW2tX/spEU/st14guKU7QFMT53NoEQPJ2h6+Lzb+CiNxdQFzoyQCbY0SZdXZjGxtaKyQ/D3b6oJfxbjD4/UnFv2Sf/AOVVDXuXNB+1TYn6KDxXrxuNPgDvhmtUcBW/EclmJu2xa06Q9Vcf8UJxHxkUD5ikwnyplvoT6J5q2p2eM9gNHB+9bgqWVuDCH8ntnUJJZOokgEzgeyUhXIYQGcsGe7KbkdUQMRstFOnXOLfxzfRXMT+ZIqlwkJvhc2U9I8KKhFEs7c+I6IX/LHvvYv4poD/7T7udFs6niZ9uInioqsNDEAS59A61m1Uv/L3BImKMxrJB0vnG+Zihurr4ofRubCdm2R+KO5Eop/cg9LK+OBw4R34T1VWKrUrm7yFbhA8+SyAeRpRC5AHJ9WBO96OOTf1npQRWe1teAgp1++vCXyD5D8VZf3VVd+TUyo2kVQ8lYsajdBzHrL7Jr7LOx26u29wESASNG1JiZVUNCjzbkLFjQkMQjjdjsOQL5viqEvsOLXpmrT9O3YNs
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39850400004)(366004)(6916009)(2616005)(8886007)(956004)(8676002)(1076003)(83380400001)(33656002)(186003)(26005)(2906002)(6666004)(316002)(86362001)(66476007)(36756003)(38100700002)(5660300002)(38350700002)(44832011)(8936002)(55016002)(7696005)(66556008)(478600001)(16526019)(66946007)(4326008)(52116002)(54906003)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?faEJ/Fyx0LE5na2P91ZE/r2UZ25laxexakP7OLSR8ub8UaegV6Rlk+IA853Z?=
 =?us-ascii?Q?3jDE3dQOS9n8WTQ6Jzw1EmrXUIacOetvjmxYLRPH1zSRyYfArLqon6rxrvDN?=
 =?us-ascii?Q?t4Chu9wavO/HJwp+ljmWuor4OD4EjZsUaQrOcZCs+BNcmsr673TlMDXP4mZc?=
 =?us-ascii?Q?q1AmSul5alT283SzPM0K+3tDH01hYTa8P07KAtfJWUzxvmeLOer0DuMJqz94?=
 =?us-ascii?Q?cDd69818H5d367UH3/M/EgzCZI/vEbDQPDnHR4VCWWhW4DRt73Deiy94okkt?=
 =?us-ascii?Q?fKvJkUGUf7+Wnaz6UmUDT59P8ZFan3Eq4X4+8NccWHar1aPuN4RTvdxWC66I?=
 =?us-ascii?Q?BIJws79ynY0lZYEWwXueEFwljnVuU9aGbd9zqMYnYIiAVbtaZJgA8jlaAR4O?=
 =?us-ascii?Q?kZv2L4aRzqBa/THyhtY6u2cKCakwIAldZS/irmjMGxl1wxKykP/93ydCZhkp?=
 =?us-ascii?Q?9d5okvtoAfDMvuT/AJxe1in1U5eEL5c14TCt/nP1u1YGt5uWSgh0CpyIHrUi?=
 =?us-ascii?Q?97qniF5Y0EFdOMWYp6KAysO9mrLIys0+JgAwGJw1p7AOV5rl9dS3NoR5Ljj3?=
 =?us-ascii?Q?oEQ8LfrOPci1zqQJjS4aGfn7BixMpp6nDnRHyU571Y4MsGDPWNt10qzyRVpa?=
 =?us-ascii?Q?atSAKkrsoiz+aKFV6NWQcY81SUL2Ofisozx4R4Jx0+9/YRFrtN1tOw+QHTAe?=
 =?us-ascii?Q?S7cfK9NfuwlrW2qOWAjm2Olqs4gwg8dxGsPmQVgy2knAHWWVPHAIDD+OdyTB?=
 =?us-ascii?Q?Rk6gx2gfR8jMh5LpguGYHamkdocR3VWAc7gI3QdK7x2QWLDned+fZcYxKPfV?=
 =?us-ascii?Q?+lS+bMFUwszuxQJYj3r6mG2eLCBfAG/Q6qdWx+jIraG/2O8CE70hmx3b1zAI?=
 =?us-ascii?Q?rrxM72HiYXXOlfgf0REJsmw9BzpGYdI4EgiWAcYk+SztxRkJkxP3UeRs0To4?=
 =?us-ascii?Q?wdJcPtwzQZSzIIxtOpHYoF0IMSEdPSIZlLlomDtwIQuQ739dWIfaBdbi4KgJ?=
 =?us-ascii?Q?4cvVwgQge1b9RTEkmtJ1bTsIzUvGx8PpuAL5cZ6EQGexLgm0tuzRBeTX1rCi?=
 =?us-ascii?Q?60zgplao2n0bkZqwgM95LE/0n3sgPUwVdq5++VvJq9F8DiRFG6PmD0i5l6jg?=
 =?us-ascii?Q?feKNhrf2tAK98O6NGVKp+KBWmW3lOnSo3g7dk410rclqLRdM0TPoSSDfN3QQ?=
 =?us-ascii?Q?+5qxH1DX3ifTZWmQ1CB8GNqDF5844O33Vy4baSO5ik4cRx5R1DLe10k9lEF6?=
 =?us-ascii?Q?ePpXv3cz9OLZjngSwHt7EZcnjyYJ7L33l4J0Utz/ZCvgNSAzO0rTuLXjAM8n?=
 =?us-ascii?Q?aAHiDhJXyNVK3p5q8e9c6jDQ?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 676476ef-984e-443b-ff70-08d9048b161b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2021 06:02:47.3030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+fZ8TEBGUnEyu2bsNJk5adcr4LdBuafEqWRBOvMzq2OV/CYZhGIT+a1roC79h+DnEBlCNgxQNC6bZuS43pyp02J/uis+TUhDy91lSHI9Dc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3691
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH] sched/isolation: don't do unbounded chomp on bootarg string] On 19/04/2021 (Mon 16:38) Peter Xu wrote:

> On Sun, Apr 18, 2021 at 05:54:26PM -0400, Paul Gortmaker wrote:
> > After commit 3662daf02350 ("sched/isolation: Allow "isolcpus=" to skip
> > unknown sub-parameters") the isolcpus= string is walked to skip over what
> > might be any future flag comma separated additions.
> > 
> > However, there is a logic error, and so as can clearly be seen below, it
> > will ignore its own arg len and search to the end of the bootarg string.
> > 
> >  $ dmesg|grep isol
> >  Command line: BOOT_IMAGE=/boot/bzImage isolcpus=xyz pleasedontparseme=1 root=/dev/sda1 ro
> >  isolcpus: Skipped unknown flag xyz
> >  isolcpus: Invalid flag pleasedontparseme=1 root=/dev/sda1 ro
> > 
> > This happens because the flag "skip" code does an unconditional
> > increment, which skips over the '\0' check the loop body looks for. If
> > the isolcpus= happens to be the last bootarg, then you'd never notice?
> > 
> > So we only increment if the skipped flag is followed by a comma, as per
> > what the existing "continue" flag matching code does.
> > 
> > Note that isolcpus= was declared deprecated as of v4.15 (b0d40d2b22fe),
> > so we might want to revisit that if we are trying to future-proof it
> > as recently as a year ago for as yet unseen new flags.
> 
> Thanks for report the issue.
> 
> Is cpuset going to totally replace "isolcpus="?  It seems most hk_flags will be
> handled by nohz_full=, and HK_FLAG_DOMAIN can be done by cpuset.  However it
> seems still the only place to set the new flag HK_FLAG_MANAGED_IRQ.  If one day
> we'll finally obsolete isolcpus= we may need to think about where to put it?

It is probably overly optimistic that we'll ever get to retire it, based
on past history of trying to remove old use cases out of the kernel.

> 
> When I looked at it, I also noticed I see no caller to set HK_FLAG_SCHED at
> all.  Is it really used anywhere?

I guess that would be a Frederic question.  In the commit log of
de201559df (back in 2017) he did note flags might be too fine grained...

> 
> Regarding this patch...
> 
> > 
> > Cc: Peter Xu <peterx@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Frederic Weisbecker <frederic@kernel.org>
> > Fixes: 3662daf02350 ("sched/isolation: Allow "isolcpus=" to skip unknown sub-parameters")
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 5a6ea03f9882..9652dba7e938 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -188,7 +188,8 @@ static int __init housekeeping_isolcpus_setup(char *str)
> >  		}
> >  
> >  		pr_info("isolcpus: Skipped unknown flag %.*s\n", len, par);
> > -		str++;
> > +		if (str[1] == ',')	/* above continue; match on "flag," */
> 
> .. wondering why it is not "str[0] == ','" instead?

Apparently I need to add some more convenient self tests, so I don't
manage to hurt myself with string handling.  Thanks for spotting it.

Paul.
--

> 
> Thanks,
> 
> > +			str++;
> >  	}
> >  
> >  	/* Default behaviour for isolcpus without flags */
> > -- 
> > 2.25.1
> > 
> 
> -- 
> Peter Xu
> 
