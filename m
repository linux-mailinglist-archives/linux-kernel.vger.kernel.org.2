Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1367A363A70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 06:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbhDSE2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 00:28:06 -0400
Received: from mail-bn7nam10on2073.outbound.protection.outlook.com ([40.107.92.73]:32941
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229627AbhDSE17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 00:27:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=adWySiZVDsl9jKQSmekdJTIZsL5k61LU/aJKNKi/EleRYS7SQl/uQbaPMKbSK7+jYTytb2UTgyCmbEO7VduH7vFgP2PwYPX9zYyMK7FSCkVLwUcr9b5yd3GuSQA5D6iI9JZU5rfHNDyvUNMh1ejFu0SqfAiBH7KwEWvN0QSSqHu5XH5myAltPMwnU3LNrzDaoOl+jHUmHRc/EQxRCyavyyyE/lEk0JJHR6XBa0rfh5VPjENc8REuOhJQQcq3yoGV4n15LvOQ6nx5Ec8SxOoo0D1LD6GkGeTJLsJ7eeKgxY4oFeiNF6cp/e9Z622PnONKjj0vWGA2P1IMlq5EsPQwqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0erZy9AbAtMDfXhaAalVogem3onfooOOfNnYI6hHLc=;
 b=jDLPa6LGeydoEPkDPSAS3Zs6FCJ0n2NDAXjjQMpou++JVtX3Kx0fcynI5756q5BdD041+tO942gpUs2++5XciVjB45ffDIE30e7gJN9l5mRR6Z0u1J/Pk61252XyWDIiQ+lXvtzSNucqboPtpnL80oFDEG1BwbYp3uYvuQs4S++YRSj4ZriEItIEcMNtU95eCHz8AfeesEzkVl3wd/u8qLEKJ28HqxPxjprC3QuqiEI5Fxq1Ps96lDL6SMHcgGnI4kf/6EUmqY5ZuTZGgkxm8Pp1l9CoyRQX5tFM9gBZEtoZju7dJj4tR/KOGHKR1sJThx3AbOaPnjPix6hxOAdxeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0erZy9AbAtMDfXhaAalVogem3onfooOOfNnYI6hHLc=;
 b=h9pkK0zSyh8WbhRsDYviJRzS7CbCBULcMb6Lp6lh3nEMcCgYnGSRUkXPH04BZ93JTtDxYeDJUbX9bU6d61xk2cFbTJEoMIqS3E8Y/WSrrR0oa0cYX11C78kCWHGdibic8gJDC7j8h+c1JpMO4oJzPLBsNmJ/ixpAunJbKjtX6r8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB2761.namprd11.prod.outlook.com (2603:10b6:5:c0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Mon, 19 Apr
 2021 04:27:20 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::3d20:ed37:cfec:4ad3%6]) with mapi id 15.20.4042.024; Mon, 19 Apr 2021
 04:27:19 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>
Subject: [PATCH] sched/isolation: reconcile rcu_nocbs= and nohz_full=
Date:   Mon, 19 Apr 2021 00:26:59 -0400
Message-Id: <20210419042659.1134916-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR20CA0008.namprd20.prod.outlook.com
 (2603:10b6:208:e8::21) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR20CA0008.namprd20.prod.outlook.com (2603:10b6:208:e8::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Mon, 19 Apr 2021 04:27:19 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ccf2ad2-f8eb-4f36-d284-08d902eb6ba4
X-MS-TrafficTypeDiagnostic: DM6PR11MB2761:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB276115F4209A0934D9E7DBAD83499@DM6PR11MB2761.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RgNK5ex1++N3zeUxLX/G4yaJPnHLYzRd6v5aJnvw2Zcxrqm+nzAgii840xkUyXd4nyzIf2ad3h4tBtaXPym+Z3uGZfeC2hh01fLOOfxm846oiHFAXatZnSxNL86KL0OMYDhD6mx9ELekHMQwGANifpq98F3oEog/fCMpO5BPwkF0GyNTvUPULUPns5TuCq+L2e7qqBnIH2O0gxLRIrxi+ftoGylDfAv052iikKF4fcmhx2IpUtrMhcHCm4i+Vn/yL+uBfcnn21kUNXyZRU1J7UQ+3jfuxahMerl7z0dcW2qTU5glTnw2kBVZuTR4iM1e6QKpvFikJ0TZEM86eQZsvZVOa1KD/nzuJ0mYuwQRiCZuIcc7c6YoZ/vo+T5jU0we9C3acDJlifkIuiEbmekYk9exUEeGhJ2n+jqFvgJcz/bQ8GKTT9vKxoznsRn8EAgxOoEjLKrPKmZqp/h/ZW1NIJ/dpEwUFWnLGH8Z/4KZeHocvyA+KsUDU3Ve8aTGtRyE4ViDH7K9zB3UVqufEsNc0SGIuVFJT0lQxowl2P1dK+CbpWBrvfGviLLYkvz3ngm2lktno/vebZ92TjTLJg5c7yjccKa50y53bsJmcjQzxmJjPcu8vQWqRSIT4oKYsiTUXLu7w/hprqCyBpiEqzNcNg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39840400004)(136003)(376002)(366004)(346002)(956004)(2906002)(38100700002)(38350700002)(6506007)(478600001)(6512007)(1076003)(44832011)(66556008)(8676002)(36756003)(26005)(52116002)(6486002)(54906003)(316002)(186003)(66476007)(16526019)(6916009)(66946007)(83380400001)(4326008)(6666004)(8936002)(5660300002)(86362001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?52pFJERomf02cKaZJwzFHJf+14aIb2/VEDqpk3ehWW/Rhyb+5EPrciFOpaoY?=
 =?us-ascii?Q?6TXsT/0lMJDYMokAtMlPpllmBZj5qTvbloFWhmG4nQqTjCMWIOovijRgyar6?=
 =?us-ascii?Q?DooSTu2TrlgU7GAqBdwVGtfHuyZLabA90QLQq765NDJfQD02Rl2H/IItG72E?=
 =?us-ascii?Q?gn4EOJLOCuLb2Y7npMHaXDpxBdsGd014+num10Iu38+QNmdVN+yp+DGpYLk3?=
 =?us-ascii?Q?+6jpql2NUJF+rIidxXQpIauur3LR5J29VPZPdaDCdeA+7yU+n1rHXDwiegKE?=
 =?us-ascii?Q?sKfOdmhR5dPEIXHfZuj/NgzI63VsWfJAv58L4kB3nxun9scTXxtuGEIYxMnc?=
 =?us-ascii?Q?hejFBPPf7XhLHHps1kzIChyWgqkr8l+V0u3OboSpy+N9GOLsSB7H229fRiJg?=
 =?us-ascii?Q?st/lBsvwbKF879VG55jYzlvfC8UyCpVwSYhnZPCIcM7zD9VUSBahPBDnMZJb?=
 =?us-ascii?Q?Z/Cmg7yt12MsP8MtSNvYXchpl18/Ei6xT4HdVZZ+6hsc3l4MAq6jA5BAZukN?=
 =?us-ascii?Q?jASzbrHOlFrMFOzEVgpAmNVKbdyo3Xu/02hmyXT10+lM/B67YD7iaHs4QkT8?=
 =?us-ascii?Q?hxUhroXH+TfBMKhpO8u2foMXQUF04Dkx6B5RnzqglRcxphyerCdrKxJU4zHX?=
 =?us-ascii?Q?PZH3gdDGdlAsuFIqD+3tj39tm7DLbiTrUQLSRhTb9FtGwKTBLCHq1X5yWMVh?=
 =?us-ascii?Q?Xn+yle8g6o5PpuPpmfZ4rCmzn4w3zIwCmMyTka9BIjewSwZ+yLbqOFwG1f/c?=
 =?us-ascii?Q?p/Y8QIrpZDuoKABimoPhK8Qyrt7fgUmo5ihMOldRHFkVLhP72TQi3Sd1+Aua?=
 =?us-ascii?Q?mo41rvL0HjWMUcrlVSyNLdkHOH5s5lpHgA/LeEI1O1IO+uhS5iMyl1xQB6n7?=
 =?us-ascii?Q?f1FZLiypEAtwGGzsPUGnPhBpcCT5RBgDzD6upIwYbLEtsHShc5BXbjApQHbq?=
 =?us-ascii?Q?qp3ghXfUEeVaZJWslfFPDBf2itcYs56App2Rnrvq4JabNxqcepGiHe0v8oiy?=
 =?us-ascii?Q?YD1bQkPLTZlW/VgsbOPkNjouaS99Cub+PhESNNepzyxL3OdYTdBEaxhtxGor?=
 =?us-ascii?Q?VU5phn0rb8eoyOuvBzKNPi/sC80uD2pykeSS/BSMHB6HGu+3T3S8TeOZFdjO?=
 =?us-ascii?Q?ggb+xwJhg6ZCziqbqXbbc/NBZFNuDe//G+3pHa+cXzpYkg7m51xEzTBd9RPl?=
 =?us-ascii?Q?714JlEK5RrV5E16qU/iDFiwNawGK40ZldmpNtfTgKmLqiwHdgaLCylCcuwZr?=
 =?us-ascii?Q?yGSK8HRHMEYNR8q2oDiApCaoBpy274whrk2t1vLJq1Ud+2CV8gl+CVFQBfKw?=
 =?us-ascii?Q?nYeHGB3/e2yqdkYdp/7/fIJp?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccf2ad2-f8eb-4f36-d284-08d902eb6ba4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2021 04:27:19.7772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qjT9DD/MU4vILizfutmCqkp79ZB3aWk/5n/fhdcWlbHXoKDrGIyP5LsPT1ioaVihu00cyGs7ImLtmId3VTCsdGnk0nx+/QmWqA4jtkxRGdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2761
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have a mismatch between RCU and isolation -- in relation to what is
considered the maximum valid CPU number.

This matters because nohz_full= and rcu_nocbs= are joined at the hip; in
fact the former will enforce the latter.  So we don't want a CPU mask to
be valid for one and denied for the other.

The difference 1st appeared as of v4.15; further details are below.

As it is confusing to anyone who isn't looking at the code regularly, a
reminder is in order; three values exist here:

CONFIG_NR_CPUS	- compiled in maximum cap on number of CPUs supported.
nr_cpu_ids 	- possible # of CPUs (typically reflects what ACPI says)
cpus_present	- actual number of present/detected/installed CPUs.

For this example, I'll refer to NR_CPUS=64 from "make defconfig" and
nr_cpu_ids=6 for ACPI reporting on a board that could run a six core,
and present=4 for a quad that is physically in the socket.  From dmesg:

 smpboot: Allowing 6 CPUs, 2 hotplug CPUs
 setup_percpu: NR_CPUS:64 nr_cpumask_bits:64 nr_cpu_ids:6 nr_node_ids:1
 rcu: 	RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=6.
 smp: Brought up 1 node, 4 CPUs

And from userspace, see:

   paul@trash:/sys/devices/system/cpu$ cat present
   0-3
   paul@trash:/sys/devices/system/cpu$ cat possible
   0-5
   paul@trash:/sys/devices/system/cpu$ cat kernel_max
   63

Everything is fine if we boot 5x5 for rcu/nohz:

  Command line: BOOT_IMAGE=/boot/bzImage nohz_full=2-5 rcu_nocbs=2-5 root=/dev/sda1 ro
  NO_HZ: Full dynticks CPUs: 2-5.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

..even though there is no CPU 4 or 5.  Both RCU and nohz_full are OK.
Now we push that > 6 but less than NR_CPU and with 15x15 we get:

  Command line: BOOT_IMAGE=/boot/bzImage rcu_nocbs=2-15 nohz_full=2-15 root=/dev/sda1 ro
  rcu: 	Note: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

These are both functionally equivalent, as we are only changing flags on
phantom CPUs that don't exist, but note the kernel interpretation changes.
And worse, it only changes for one of the two - which is the problem.

RCU doesn't care if you want to restrict the flags on phantom CPUs but
clearly nohz_full does after this change from v4.15 (edb9382175c3):

-       if (cpulist_parse(str, non_housekeeping_mask) < 0) {
-               pr_warn("Housekeeping: Incorrect nohz_full cpumask\n");
+       err = cpulist_parse(str, non_housekeeping_mask);
+       if (err < 0 || cpumask_last(non_housekeeping_mask) >= nr_cpu_ids) {
+               pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");

To be clear, the sanity check on "possible" (nr_cpu_ids) is new here.

The goal was reasonable ; not wanting housekeeping to land on a
not-possible CPU, but note two things:

1) this is an exclusion list, not an inclusion list; we are tracking
non_housekeeping CPUs; not ones who are explicitly assigned housekeeping

2) we went one further in 9219565aa890 - ensuring that housekeeping was
sanity checking against present and not just possible CPUs.

To be clear, this means the check added in v4.15 is doubly redundant.
And more importantly, overly strict/restrictive.

We care now, because the bitmap boot arg parsing now knows that a value
of "N" is NR_CPUS; the size of the bitmap, but the bitmap code doesn't
know anything about the subtleties of our max/possible/present CPU
specifics as outlined above.

So drop the check added in v4.15 (edb9382175c3) and make RCU and
nohz_full both in alignment again on NR_CPUS so "N" works for both,
and then they can fall back to nr_cpu_ids internally just as before.

  Command line: BOOT_IMAGE=/boot/bzImage nohz_full=2-N rcu_nocbs=2-N root=/dev/sda1 ro
  NO_HZ: Full dynticks CPUs: 2-5.
  rcu: 	Offload RCU callbacks from CPUs: 2-5.

As shown above, with this change, RCU and nohz_full are in sync, even
with the use of the "N" placeholder.  Same result is achieved with "15".

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 5a6ea03f9882..7f06eaf12818 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -81,11 +81,9 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
 {
 	cpumask_var_t non_housekeeping_mask;
 	cpumask_var_t tmp;
-	int err;
 
 	alloc_bootmem_cpumask_var(&non_housekeeping_mask);
-	err = cpulist_parse(str, non_housekeeping_mask);
-	if (err < 0 || cpumask_last(non_housekeeping_mask) >= nr_cpu_ids) {
+	if (cpulist_parse(str, non_housekeeping_mask) < 0) {
 		pr_warn("Housekeeping: nohz_full= or isolcpus= incorrect CPU range\n");
 		free_bootmem_cpumask_var(non_housekeeping_mask);
 		return 0;
-- 
2.25.1

