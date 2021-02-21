Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1397732091F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 09:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbhBUIKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 03:10:13 -0500
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:63329
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229502AbhBUIKG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 03:10:06 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CJ8yNhO+iGvv7B4kyQvwqVlpcG44C0T0FZBNFRfI84knSH4mn64soHdX6sC1gErHT9P//L8/Q0GdkEnJ4hd8pS/QQAd1Ty2h9jMvks9J8Oyu/gz368ATnRp+FgXL8iIOjcrTbOf5HmDG6A7+wdeIwTZuKWyJUjpVjg5ObFz6S/5WkXLjhL3/+zKCfQUdkXnHs9/OM276mFrDWxkP0pYONXN9Zzt81Wp+tsTxHXo//2Yj5Acy8VymElx0TBy501sb69KvAnrh6HhPVFw4hEiVeq56JuO9Uwv5dFuvpmKn3aizoJ6LCsabmXs3qnQAvSX7BV3CGiiHKsccKCJcaKLo2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3neTUxEu3CE2lhS6mIu1YTy4pwfLLVl8sTOJxSFds4=;
 b=ndWCYsDCNOaBqf6LUtS9yyl681zim3lA6LJPWOzJ/M4zl0Rkx49cgWzQAyrryD1m70uU9cMI6QvBE9iN/6wxkuDr4sDUQsUBU4zaBY6bEfGPPAqXlcSMuSZ1hCi0QV70Lq/8jZe+bq0BtFUz5p/Mp6YZkxK7nZvmV5z9zCXINij1O95ZjxH+lWviI2VxwKG+6POGB5xMu0Yc6CpQ3iRkwHugBlFJIWPiXjsig8ahg9CcX6aYuZn6WwcBAZcu0OFBCdK100GQnDvBA4BuAVUeY4qwGLp6PfjOMfYxaXO3jpk2+/bBRXabdoLiD3KNmpt8Kjw62bQ+26jzttawNUp0dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j3neTUxEu3CE2lhS6mIu1YTy4pwfLLVl8sTOJxSFds4=;
 b=l2GB5jcmndoYJllxgy9vZ26bsdr3ANIZpUe6PE3el34rYd2QEk2d3s8qaX2d/EUugdL350+bLcL109kdtLX4545lmFlGwwzZor9TQQu4aAJNECdkiIPRawgLmdJ9tHWnyDlHvseHlaz6qiDv9QG/wcBhWc336lPj6D2rYdmtgXw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM6PR11MB4740.namprd11.prod.outlook.com (2603:10b6:5:2ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.32; Sun, 21 Feb
 2021 08:08:47 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::49d6:e3db:2f06:3432%6]) with mapi id 15.20.3868.032; Sun, 21 Feb 2021
 08:08:47 +0000
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     linux-kernel@vger.kernel.org
Cc:     Li Zefan <lizefan@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Yury Norov <yury.norov@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH v5 0/8] support for bitmap (and hence CPU) list "N" abbreviation
Date:   Sun, 21 Feb 2021 03:08:19 -0500
Message-Id: <20210221080827.84862-1-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.30.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [128.224.252.2]
X-ClientProxiedBy: MN2PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:208:160::49) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from yow-cube1.wrs.com (128.224.252.2) by MN2PR13CA0036.namprd13.prod.outlook.com (2603:10b6:208:160::49) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.9 via Frontend Transport; Sun, 21 Feb 2021 08:08:47 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6bb9aa35-71e9-4381-a844-08d8d63fea69
X-MS-TrafficTypeDiagnostic: DM6PR11MB4740:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR11MB474088444D54068EAB2CE1F783829@DM6PR11MB4740.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHjtwZ3acD5GYyJlTb4A3pmn+Q5M50BtJZH+zbagGqWwgcx5HCLbpvPJtEgo/CagfQ9ufqsCMbAjMW9V2dgvuiROVIVMVUN2KbQrczwbQ6r4ffr5m0YYHQfrcd0sZ79rStJjFzHHYVkQynoOBI+7PnJ151yZCDonj36zXdk6THBjtY4HSbTgpNmP1ByOaojf6ki/fmlFRZVVwiBgi9e8PprkU1N2UY4f23ohvQh7yClzTI5j5kFPy3pwc1bIgxfV8++Gg/ps9vUmZ+yuWOy4HnvJAgqHaEpQUPeYvo/AriQaBHapaj8rONpWcQluqFBlWMhWM/oU8OBHEDGo3hsjZfW5QqncUC5A0/haS/sF4tIjBBacTCSCL288nA/AtML6eayHf0vqlj5ht34XlP/FoQUO7P5asK3mgeakQ1oxNC0Jzb6hzqD5TLbQgtOZfevUNEjH9uC6tUEyE9PuNQXLGt5LtzxVVwaeZUSG82L8XkEshAAEfjuGp3MPRrZAkNAHcgjQShX8GnP979ZV0EPsE5whtgiBp9DCldMK+RaiNE/tuQ9URW9gTu0DqlEE4n6ll5aDG6/P+Mc/Db5HiXVJtL5uYXU+btdXPkuXYsp6Ucg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(376002)(366004)(136003)(39830400003)(346002)(2906002)(16526019)(316002)(186003)(54906003)(26005)(8676002)(5660300002)(6666004)(1076003)(8936002)(4326008)(36756003)(6512007)(478600001)(966005)(107886003)(83380400001)(66946007)(6916009)(2616005)(66556008)(66476007)(7416002)(956004)(6486002)(44832011)(52116002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?vlwSSKnhQ1yk3VLQeP/gL+XdJZLSVaB27h34ll6IorNRGoZceD51arvSQ3qb?=
 =?us-ascii?Q?fT5grjUDJwFHFL1B8bEElUy4rccYJrIEyalKhqvJmbZHosFJ4yFCe890K0fb?=
 =?us-ascii?Q?jvtXG0lJM7ykr+9c2HLHQ3cn90IdSaznG0VjSelmAQbt8nDjscz1ik4IK9VI?=
 =?us-ascii?Q?q5vGHK4SKOr35kLocDlTZ6/SIZVtMQbr4O9ao+deZp49oPPY7dsvOdQ7j42K?=
 =?us-ascii?Q?ZoDsV/OX+nbxlBZXNO3T9tsQ4f2eV7OLFwW4CVulYxbh4oXAKQgYQBHXKgB/?=
 =?us-ascii?Q?PIW1XfraryUtjrRMSxMTOmNORtJawjsAQLdO4evD2tPY1efvi6rdxvTHCQoU?=
 =?us-ascii?Q?86Y7TFwa5LsBPgK8+l7yDlAtJhKe3lQfA39/JI8TwJs21w0pVyj83wEJB1PH?=
 =?us-ascii?Q?ytSJ+GvyA728rYXEUqRT9OWR8+JJzDmTSN0yCr4vJw4c8B4fT806NOqcgemn?=
 =?us-ascii?Q?d8oGxX8IYd/lQA7KbYMCePQzNxM9hIf8MREXVyvlzopKHXdugunerFbbp6fI?=
 =?us-ascii?Q?3Np4baaKdeaubu1/i1ybmbCEqeRrXys+xUF2E0FmOHjXiozVgbL1Uq+oFzf9?=
 =?us-ascii?Q?9pkv7SYUoCYe8Bbm8ewTFUmj5A+DfBkGKfMyu6XafG1WFiXkBUuBNdO6YE0X?=
 =?us-ascii?Q?GLlYD+yGm1x5mwfhcSPkRsO1zcECfxOxz1TUuopiM6/HNwPhwpsB3qZ0FyId?=
 =?us-ascii?Q?PIBcsOi7OCqZ01nA397HJMyf6x5IiDPUE8LYAs4rxisjzUJt2SqhUutbsrCc?=
 =?us-ascii?Q?84ZbrZH1rLc4sNbE3JYXbQB7xKTZVxHyBZEj9pGnOSEvgkcubVE0udsZ2tLN?=
 =?us-ascii?Q?lq2fAoaLNTQkhDiDRPp72yJENqkeyiefxrAN9LcH2hE/h4W/rwySM+hE81ui?=
 =?us-ascii?Q?IDQ7GN42GEs3chE8RaR3u2jUQCcSAdM2dg3zIWAmYXJmD3Hi/4J+/DWxVJ8/?=
 =?us-ascii?Q?jFK+E7A86xh5WwMaOKrGaRzW6IdBCIfhq5pumsVAu+H30tq5SrKXjs1unoDK?=
 =?us-ascii?Q?UAjUXuDX+X59v0HxQGijPWeYTuaRrS3Gfq+R5F2srLXhbDyBYjhTA8SgP0xO?=
 =?us-ascii?Q?ZGlrBq4QRehgzDFw0KKTxPAH/jqsdyixFwJWznU4eym6MWfpUJadhgVVt5nl?=
 =?us-ascii?Q?OBwm4deidqO1QLTXqLLzMa8Z8zzK2D4IDyywqJiH9guI1OSY3tgi1FlZhbSf?=
 =?us-ascii?Q?PqGE8DSje9wVLe6wzMyrjh4kJhRhzMbUUS5Zw+zLMPcxCaBPNH31qxlvZpuQ?=
 =?us-ascii?Q?zzUCh6NZ5SXPDhRXOAFYRSEqnsec0tUVEP8FeNuo9ITBjMiMyVNUbw1Z8axF?=
 =?us-ascii?Q?8F+xXNB/Ix8WRPfR3ZoWGxhC?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bb9aa35-71e9-4381-a844-08d8d63fea69
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2021 08:08:47.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bd0ZkgxtNpT5UgDsLN5XMPyihw02ZvCwPk0g95SjuDSwJIGaUSHfyMcjaEVKUVSz21izVt5nd66ko+EVOEw9dcDnTNS5P7VQv0EylTcjhrk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4740
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 5th and final version of this series.  We got some good
improvements, like adding self-tests, using "N" as "just another number"
that could be used anywhere, and making things not CPU specific.

But now it is time to close this review out since is down to just
hand-wringing over hypothetical use cases, bikeshedding on upper/lower
case, and a wild goose chase on trying to avoid adding a function arg.

So, once again - thanks to all who provided input; it was all considered
even if not all of it was used.  And in that vein, just to be clear:

1) There will be no adaptive modifying or guessing what the user meant if
a range turns out to be invalid.  The caller will be responsible for
handling the -EINVAL just as things are currently today.

2) There will be no use of "L" or lower case "n" because there is simply
no need for it.  Yes, it would be simple enough to add, but it complicates
things and would also be impossible to remove later, once it went mainline.


The original text from v4 follows:

The basic objective here was to add support for "nohz_full=8-N" and/or
"rcu_nocbs="4-N" -- essentially introduce "N" as a portable reference
to the last core, evaluated at boot for anything using a CPU list.

The thinking behind this, is that people carve off a few early CPUs to
support housekeeping tasks, and perhaps dedicate one to a busy I/O
peripheral, and then the remaining pool of CPUs out to the end are a
part of a commonly configured pool used for the real work the user
cares about.

Extend that logic out to a fleet of machines - some new, and some
nearing EOL, and you've probably got a wide range of core counts to
contend with - even though the early number of cores dedicated to the
system overhead probably doesn't vary.

This change would enable sysadmins to have a common bootarg across all
such systems, and would also avoid any off-by-one fencepost errors that
happen for users who might briefly forget that core counts start at zero.

Originally I did this at the CPU subsys level, but Yury suggested it
be moved down further to bitmap level itself, which made the core 
implementation smaller and less complex, but the series longer.

New self tests are added to better exercise what bitmap range/region
currently supports, and new tests are added for the new "N" support.

Also tested boot arg and the post-boot cgroup use case as per below:

   root@hackbox:~# cat /proc/cmdline 
   BOOT_IMAGE=/boot/bzImage root=/dev/sda1 rcu_nocbs=2,3,8-N:1/2
   root@hackbox:~# dmesg|grep Offl
   rcu:     Offload RCU callbacks from CPUs: 2-3,8,10,12,14.

   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo 10-N > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   10-15
   root@hackbox:/sys/fs/cgroup/cpuset/foo# /bin/echo N-N:N/N > cpuset.cpus
   root@hackbox:/sys/fs/cgroup/cpuset/foo# cat cpuset.cpus
   15

This was on a 16 core machine with CONFIG_NR_CPUS=16 in .config file.

Note that "N" is a dynamic quantity, and can change scope if the bitmap
is changed in size.  So at the risk of stating the obvious, don't use it
for "burn_eFuse=128-N" or "secure_erase_firmware=32-N" type stuff.

Paul.
---

[v5: go back to v3 location of "nbits" in region.  Add acks/reviewed.]

[v4: pair nbits with region, instead of inside it.  Split EINVAL and
 ERANGE tests.  Don't handle start/end/offset within a macro to
 abstract away nbits usage.  Added some Reviwed-by/Ack tags.]
 https://lore.kernel.org/lkml/20210209225907.78405-1-paul.gortmaker@windriver.com/

[v3: Allow "N" to be used anywhere in the region spec, i.e. "N-N:N/N" vs.
 just being allowed at end of range like "0-N".  Add new self-tests.  Drop
 "all" and "none" aliases as redundant and not worth the extra complication. ]
 https://lore.kernel.org/lkml/20210126171141.122639-1-paul.gortmaker@windriver.com/

[v2: push code down from cpu subsys to core bitmap code as per
 Yury's comments.  Change "last" to simply be "N" as per PeterZ.]
 https://lore.kernel.org/lkml/20210121223355.59780-1-paul.gortmaker@windriver.com/

[v1: https://lore.kernel.org/lkml/20210106004850.GA11682@paulmck-ThinkPad-P72/

Cc: Li Zefan <lizefan@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Triplett <josh@joshtriplett.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>



Paul Gortmaker (8):
  lib: test_bitmap: clearly separate ERANGE from EINVAL tests.
  lib: test_bitmap: add tests to trigger ERANGE case.
  lib: test_bitmap: add more start-end:offset/len tests
  lib: bitmap: fold nbits into region struct
  lib: bitmap: move ERANGE check from set_region to check_region
  lib: bitmap: support "N" as an alias for size of bitmap
  lib: test_bitmap: add tests for "N" alias
  rcu: deprecate "all" option to rcu_nocbs=

 .../admin-guide/kernel-parameters.rst         |  7 +++
 .../admin-guide/kernel-parameters.txt         |  4 +-
 kernel/rcu/tree_plugin.h                      |  6 +--
 lib/bitmap.c                                  | 49 +++++++++++--------
 lib/test_bitmap.c                             | 46 ++++++++++++++---
 5 files changed, 79 insertions(+), 33 deletions(-)

-- 
2.30.0

