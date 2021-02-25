Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57EA3324F01
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 12:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234811AbhBYLTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 06:19:32 -0500
Received: from mail-dm6nam11on2040.outbound.protection.outlook.com ([40.107.223.40]:21225
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232491AbhBYLTR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 06:19:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ztjk6AsIjVc4hFquB5tamQnz+Q8TVgr/uy9P9kAdnqYuyw83q+aRzv/ahdteArUpCR9FH60TR6OcjhCjenlGSzwTMS3LiZJ+Oxzn9wsJ2xAi1am+AUSrADK8yLswEvumDCnyOtYA1uCpvTzEDmoorkskXWTeq2SwZ7udl4I+yZmG2rFsnTvufoBG172yWP9aCWrxnf/hb0PHLgKbAj3uapW74IO5CMQt6n1pH2AqctS5A5Hv/a8I8b1NmO9Y3Rf3Ykyx119LT0TCIychTVus9/TP5DFN3id6BoaeCodQm7zg3SqJ0ufJRjzXttJdy62oV1/LdwI3I35qWs405RHXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlk94H/cI3o4yavXnAYHSn1zc3N16/pLzg6yv50w2x8=;
 b=M0UqVlEKhdvoB+VpjL5hempmKbdbxS4k8Y5+hcxdNJD+GgJTFYJw3PTNxFMu8e8ScgovhC4qt6Cbt6RIlixaPI256Ppjb/+KX2xZzhj956OEDEAduL9sm+65ag+8a/tE8ECWVXFFNvbCzvtdg84UNbIW0BJ4PHK8YuABAx7zdOneYTHiHMT1FsVZRjJCGwD7MFXyiKCY9Rs4XWcN7T8vq4cG46Bjm1bB++9auVtOSGA+18CrRXHfH8I6BVVUSev1MuKhlETXwwgfB/3nxr0e4CdhhmhDzeFNDMuy7SxxBrayRuFT5qvH56zt32jrwgRmtWL1w95zsEz4GhGiSCsCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlk94H/cI3o4yavXnAYHSn1zc3N16/pLzg6yv50w2x8=;
 b=ATo/piPOxaX3NYr6fTz/Q9Hl9wywsAZG7AkRHu5ktymJ3XzlN2sq0/U2NjLBDFcB6bTl1UzT2i1ISWHr3MjVWJ9NUsiQCpMDTAQD65joBBjl0zCYMHbNXRnrhce58YrNIA1Oe/GJhns/NZG1D5gtXyqP4YEImIxj6cBUTLRjIRM=
Authentication-Results: linutronix.de; dkim=none (message not signed)
 header.d=none;linutronix.de; dmarc=none action=none
 header.from=windriver.com;
Received: from PH0PR11MB4904.namprd11.prod.outlook.com (2603:10b6:510:40::10)
 by PH0PR11MB4984.namprd11.prod.outlook.com (2603:10b6:510:34::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.20; Thu, 25 Feb
 2021 11:18:23 +0000
Received: from PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::4cc3:4690:b257:8c51]) by PH0PR11MB4904.namprd11.prod.outlook.com
 ([fe80::4cc3:4690:b257:8c51%6]) with mapi id 15.20.3890.020; Thu, 25 Feb 2021
 11:18:23 +0000
From:   Mikael Beckius <mikael.beckius@windriver.com>
To:     anna-maria@linutronix.de
Cc:     linux-kernel@vger.kernel.org, mikael.beckius@windriver.com,
        tglx@linutronix.de
Subject: Sv: Sv: [PATCH] hrtimer: Interrupt storm on clock_settime
Date:   Thu, 25 Feb 2021 12:18:14 +0100
Message-Id: <20210225111814.8383-1-mikael.beckius@windriver.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <alpine.DEB.2.21.2102231638540.1861@somnus>
References: <alpine.DEB.2.21.2102231638540.1861@somnus>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [94.254.65.183]
X-ClientProxiedBy: SJ0PR05CA0146.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::31) To PH0PR11MB4904.namprd11.prod.outlook.com
 (2603:10b6:510:40::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from windriver.com (94.254.65.183) by SJ0PR05CA0146.namprd05.prod.outlook.com (2603:10b6:a03:33d::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.9 via Frontend Transport; Thu, 25 Feb 2021 11:18:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 092949b0-f11d-4c76-4867-08d8d97f1076
X-MS-TrafficTypeDiagnostic: PH0PR11MB4984:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR11MB49843BB2361096CE97C8705F929E9@PH0PR11MB4984.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oXHzBLRZRs6Rq7t7atOcLVy9QfuxgpAkhcxYdpXwVzHRc5wr08ESVht/vee6eG5uUyXLzBey/GAvzePE4HYTq8md9j3A+3ighWaJPKjPiJKeZ3q2pQ8zGP+TP2Rt9aGlzdwajGjCMaos+uQf+6JxBGbNSH50w1xyKOeWZ6XmRP4QifzuvVrrmuoaGhesRm1q23NlqjEyGef57oMh8RH4ITjHMPWg9QqmpaE1KFtTenRi+6hDQ6vpogB34uCwwvPgFqnxF7g1QVRbPUnoZuVypmsoebl0MpUDxv6PThA5etwkDM3OXCNelz0PBtsnXqZB8nUdJpxgUUKRlzgXvfN82RRR7I8sX5CM8vmPdDKSv7v3iXvbO6ojYU1ZZGK96UnXMGwaXvTwp81ms7ESYDeb4GOMqOXpS4jlOnYdTKbksluX+9Pjb/vlFuEbLfbyRTVyDefVFqzo6XiVTYuOhnHaC6RpSIZyQhzhaRrbKWf4SQbGWISOxM/3CUgCdKj2sm9lD0EUwZtkUn/0Yv4cdkrvfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4904.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(376002)(136003)(39850400004)(55016002)(8936002)(8676002)(52116002)(6916009)(478600001)(7696005)(6666004)(83380400001)(316002)(86362001)(66476007)(4744005)(66946007)(8886007)(16526019)(36756003)(2906002)(1076003)(5660300002)(4326008)(956004)(2616005)(66556008)(186003)(26005)(44832011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?b5GQ0P8y8VURTqBsBDUmu5P3I55qRCVWs7u0jfX80TCmVnTrj2BumptfKl16?=
 =?us-ascii?Q?bQipyQfEf8nDcgLFoOg21LyIjzTQqXp0WqpZ4YaC5LtkzYQ2uZx4fupdG448?=
 =?us-ascii?Q?Idl/HhFIuUphnQsTyTgksR0tFPFNz72+6GsyvR9kM29h+XWJJHPnpetsNyDg?=
 =?us-ascii?Q?zRqkpDOb4zsOF8DyFlA3NqSRbCHEKmzqy+MBcAGLKMgTDuu30RekwtidlKT5?=
 =?us-ascii?Q?4QgymSZ56hJqaXLCTAxwNA5lpOYL9rTcW9qX1Da41GyR1suWhy20MzzrxNXv?=
 =?us-ascii?Q?6NU8L7Ksesi93tZthJ6Tnbt1x2/InxiD0kAbDb4Plr/tmln90BvOXwA3JrAZ?=
 =?us-ascii?Q?DvVTDbKlnBh+gr+ZGnLtLXMFOtjzo8i39vIjPaDsluZt107AGLiRYaac2Q7h?=
 =?us-ascii?Q?myFyIfYlzKZFqf+h7gMwq1Bf1YCQO6fgStldL+AWuIxbolK5bag3ygKdFSGP?=
 =?us-ascii?Q?+HGYHyDIo8v7/KurYP52Dj9V/B9O9oL+oHzdxTxa4V1CcT65rNQ2nHL8M/ZW?=
 =?us-ascii?Q?i1TD/XwZBO2X5r1cO3zF2NErmLSKoqrerKblumDhHyFk4fokYhfchKQ+hjjr?=
 =?us-ascii?Q?t80/3+y567B3Nv93Ltak2l5t9w/+gG0kvKgNxXzfuMH7p+8EfNVhT6jmZQYx?=
 =?us-ascii?Q?n13BzWodIXOUzEvK1gXgNDqb/kj6HofFsFuuYEKLIkz/enU84ipSKz3wpuwg?=
 =?us-ascii?Q?vadDYU5EtlHh8US5yPKHJqZm5nkkAaS5HkSfFK+6iYB9La/8HY7A/X5xpyp3?=
 =?us-ascii?Q?v5svcT060dt94IezkGgb+pauuhf2fnHrwrnKhM5iUrmDMD6ShFWeaVpmK72S?=
 =?us-ascii?Q?SUCLZIJvsW5FopnuFISLuCI6XYIAprEln6pJOTI1ffUCmVKX+JjSKjQ1k5ph?=
 =?us-ascii?Q?uZzGiko9jFPGmgvE8mVuaZpX6cboBJ0n14oZ/F8CvGzA8m5Nu7/pwS1QKTnd?=
 =?us-ascii?Q?CYeDecXT1JIASipZCTSIx0ChZlXLPSvu8DROKkL++rHM7mmf/ufFNczYH4Xs?=
 =?us-ascii?Q?s55xn7K1pAwTvo2ZYuB9B2dOUwg/AW0vSO6NUR16m62AdKSYefjEP0L5DQ6v?=
 =?us-ascii?Q?tsN943EupzUuzK13n84tK2Nx6uqznythZ9IpLoEHQNJ47v5Z1dC+kyNzCvo2?=
 =?us-ascii?Q?mK0Zkq+hFhL+AeUsm1UCW/qB7aM7o9guGnwUgWhS74Q6cn7Thjf+XLY8uDOF?=
 =?us-ascii?Q?wGhfgQPPZR87TTgdWRt3kCVLbMfIFvpdXH0y2m4WWCjNbp9QCbeyYYkLKiaU?=
 =?us-ascii?Q?8YYMEraVQTCXvAHOYwgOe25wj6KI7gVWRUNfRjOmW8pf19McGt67C4oF+5v1?=
 =?us-ascii?Q?kBJImG0e89te1eYBmtY3zzBs?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 092949b0-f11d-4c76-4867-08d8d97f1076
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4904.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2021 11:18:23.6322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eIGuk1UCiMfFJ1HZGgUKAofK6MEX6YlGmsp/KNnx6MJfg2JCOTIqkYSoA2+BLdZTAJMx5qm0DoFt+OwmF1gzqIxcze5PuZRQoPDVJlO/2MY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4984
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The proposed change breaks the reprogramming logic. To keep it working
> cpu_base::*expires_next is only updated by hrtimer_reprogram() and
> hrtimer_interrupt(). I will send you a patch for testing in reply to this
> thread. The patch is compile tested only.
> 
Ok. I kind of guessed that would be the response as I noticed a similar comment
during the review of the original patch which introduced the softirq_expires_next
logic. Anyway it seemed logical to update softirq_expires_next
when updating softirq_next_timer.

Micke

