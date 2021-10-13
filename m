Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A45A42C1A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 15:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235381AbhJMNo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 09:44:27 -0400
Received: from mx0a-0064b401.pphosted.com ([205.220.166.238]:8156 "EHLO
        mx0a-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235247AbhJMNo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 09:44:26 -0400
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19DDaeMB004112;
        Wed, 13 Oct 2021 06:42:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version; s=PPS06212021;
 bh=THK2Ej01zVo098dT2njRoMhH0MNooiveZNrEzZNg59Y=;
 b=VvDf8V+ejQPpFzSSTrQJpJ1VRjPVktr+tKhF16HwobI9364TZ3grycobR29jZm59Jmgf
 UfDF9G3u0wD7hJqAEXTB6uSYK7h/r343iqaEEv4Q6/XgFj0CG/Lg0dGevtKa578PD7w9
 XqamJ4lvFWsslZX9Dp+p6i0oAfklm7NF661cEOET3s1Xp7MginmEggN52VLEXSjOiQCA
 SDSVWVTuqOXhln2XjApNPrQA5W/uaFDjsD5FNv9zbQUych1DlAnnX2WSaoZRpSVo1zBw
 Yp/auleAP/JpUBJae77f0rXkojQ4CO5mJRcKLOu0dACfdlnbCPjVlkBtLe1FzotrKcAs 9w== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bnka48k96-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 06:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGfX6AunTwesSAIQVW8cEJi6prkBqHX0OCiDIb8oiNwnDPvb9lostXPv6wmljoCkszRiMvW8jGWP+/c11YmuESOAiLpRtyHuAzHYt9OtFEEBjk3+Ptl8VFEPeBJRV0lQfE1+DuM/Tu1ZuFT5yatxQ9sUmZ/Z6ztZthlyuzAwVRcn9EI+AS0RSHV5v/qZwMQz7MkLzZvVkwTzWVNW4aIIRKu4ywBaCd0Xz/uhuw+2YZ9c1rYlxoad8CE2/3SpkVwqk9rBkhMW+JYhpY/q1zU2NQDRnLrP/pRpmZykZ3GyURkqlnIbvsrs1woAoGbMv7pxnu9afTcg1FeXB0UI8aFtbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=THK2Ej01zVo098dT2njRoMhH0MNooiveZNrEzZNg59Y=;
 b=ImrVuXS6hQQN+/hhkbuqkO/Ey6Q0C8Q0kF/ERBugd4zLkS5X/Z+0Pi/jgGeqeSoVKV/xW0FYsnM2Bu5N3jOXGeavCvhgRIQN7JmTlZ5MQhdGZ4/a2J9iASENu89OfNlg2/tyRaJdoaBDsxNPLJGsiLB9BzwOr4SAxW1x+5vKqj60yCj86+UH4+9Oii9832ovCepa2HuFA/QS2qT021lF2GZttG+lOTE8ryx16duU5y4LaJUYIGJSvdzmfpWS+2jFP8sn4dQQhzixR48B2ABaib7yOgl92xwr24ZpyjrIIjNsUM7voiRY7Ne7jw9+EJw6vFipZVZZvSmmh+cH70MxrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3290.namprd11.prod.outlook.com (2603:10b6:5:59::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.25; Wed, 13 Oct 2021 13:42:12 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%3]) with mapi id 15.20.4608.016; Wed, 13 Oct 2021
 13:42:12 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH V2 1/3] locking: remove rcu_read_lock/unlock as we already disabled preemption
Date:   Wed, 13 Oct 2021 21:41:52 +0800
Message-Id: <20211013134154.1085649-2-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20211013134154.1085649-1-yanfei.xu@windriver.com>
References: <20211013134154.1085649-1-yanfei.xu@windriver.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0148.apcprd02.prod.outlook.com
 (2603:1096:202:16::32) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0148.apcprd02.prod.outlook.com (2603:1096:202:16::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.15 via Frontend Transport; Wed, 13 Oct 2021 13:42:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c203ac40-d340-4300-4d78-08d98e4f4280
X-MS-TrafficTypeDiagnostic: DM6PR11MB3290:
X-Microsoft-Antispam-PRVS: <DM6PR11MB32906C9CFDE0D54B6691F8E7E4B79@DM6PR11MB3290.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pBvtNY4rmKzK8NZx8J2tTchLnnVVdFuNHLtJUUh4V5Xwyd6T/WXjEBdb3h+I3CswhoBw7Dwni1aFVfcE1JI+evOIqHLOsUfe6LiN/bKGNxTZ+pwCy8kl/tooqrTopnh0SOCs6QYA0EVCKdOPSV4p61+WoPiZGapZjibK62lMBWPx77VarH8W5LIbTG32UHI8PtneECDejE2WxN/5MDFyxJ7IoAbbZK1/tqZk4M5yNayHpu9u6vhvLJ4ujIabLFXIi+RQZwW9akM95LX6Xm0A07FSu/Gthd69nLtaScxcgaMxMtqLTDWTNnpazzdt0ZN0HYnSgOzAVYAuanzbJ2F65FMaP2lM/JzXEbrasqKKpiWz9HSfXN7/h4FX7ov2XujrsolEDURErcNhII5q1eULio7unwM0cFyNs3ATTL2QbyCCKdDZIrP1X6PaC5pALKAt86rMmODEVopXmW4lGZ2hZnNOFVJiu03oXz8GLGszAiMxe8XDkWHg5sw7/Ej5sjFlGTMe1P5YvbgtlVTUmVEgHC4BNXmJkWASMUu/V96O3p0LVCjJxZX8SwhvXaB0zo1m0LjtBtNgDnGPCcrmhWPDiibvqCQU+pSeKmOdJhCfGmUWnTanQIZf6M/3zq3s9wObhFVp6ORpG6Jg3gkRMiuEKoInaswXfzQWGons7LXaDHoD654rm4JLUOyCRI2AxSf8igdjYzqkomnggmbfsWgf1w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6666004)(956004)(2616005)(66476007)(26005)(66946007)(5660300002)(8676002)(36756003)(66556008)(6506007)(1076003)(6512007)(8936002)(38100700002)(186003)(44832011)(4326008)(52116002)(83380400001)(2906002)(508600001)(6486002)(316002)(86362001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0PEWAu8EjNDktFtZsJnAFtwMcQUyZhOIPjHWVr3zZaZ4YhAy8ZVgWQcUZQdZ?=
 =?us-ascii?Q?AQbzUqIfxGhlXys2fPhQbnf2FQ1i2zrO4/KSFmMajVd2TO6Hb2lN+LJ4HaWv?=
 =?us-ascii?Q?przVkbmTbuUwbEq313xUpJKJCPu2GD9vzgXDdwQLyWNjpn+MUFuRE2kE3Jnp?=
 =?us-ascii?Q?JGlVmk/+fc3WS4PE+evA79pP2/8SKMAo4mlEOMurrdxYYyxiiDyMsE8eq/7I?=
 =?us-ascii?Q?y9A/3eAq+zrKG5rvoLc+yqYbQRzj0rYNYL7yjC0PmWnE+rIqW286qMj6zSSw?=
 =?us-ascii?Q?TEz0ZU7NfI3kqyML5Uf3yjyVe5+IfPbfMAGPHDUjovAWKqmCvbwbstylLjAu?=
 =?us-ascii?Q?gkZXH/DlPHsd+qsQIuc+LJWUvGaSws6SGER9V9Decenhc648HXAsa416F2Op?=
 =?us-ascii?Q?pkInRw0Co8fgyIpAOLzNturejwlySgDjKDq21AWdotC4ltrKeGl5JBPW9D+Z?=
 =?us-ascii?Q?XMQcW4cvGMleVBua/EwfyoBP4xb8nCCjBlp/6vS7nlJCR03AWVhyHEDl543d?=
 =?us-ascii?Q?gVMK1bhVyuWUjVLArPnCyFvahpReEIaqUlC/noBM92qQlXPRLvcZkBwloIP8?=
 =?us-ascii?Q?XN6FeFhUBuLs2jKIA0TDxXd9Bz6lpwS0DRye3NAVNx0xQH30kW9DK3GfEzJy?=
 =?us-ascii?Q?lIhIKP68USLFGNDi5IkCi4Vkrtuia5OABQMwOTqtZxH7l/tTIkiq8ISgY8Az?=
 =?us-ascii?Q?mC4STJ8xTMc+rrRIg2SKrQuoQWv+gQnyeNwnt/RAGvY8AzLYfrjBSemgR+gP?=
 =?us-ascii?Q?cZXrACUdCff9Ku3auLJAs6YP/TV+91NmQC2bSiFWTDrtAuQmL/VBC/3TpXVw?=
 =?us-ascii?Q?32xPzItYhRgDwqroNM8X4ktqN5mXOeTrNfHN5eBIAVsZb5IpjazlfI69DE+h?=
 =?us-ascii?Q?pZn1KMiJYDFZD21DbBRM1sCZL3ycAEWcZq7Uxl++tFYzNXkkbdCMnE2vglIm?=
 =?us-ascii?Q?Q/hoc2IBGxCXp0YJyGRiPrhNccdJwraPu5aPI3U8ajgOBTqvyYEiDckqCdKJ?=
 =?us-ascii?Q?NV6jsqgVszvTdgpcpvmjZTzo7JknISUN/LxbwtCd+zu+detDJLnRx6HmSvrn?=
 =?us-ascii?Q?IWgtHUHQswquAHVQbireMzrT/Xdf37SvARh1cXFERCR3CwUICS98e1pIudM3?=
 =?us-ascii?Q?ANcTMOZ7RY5MQzxNgkiVq0K2hDHo1/wgHVal+op3TVecJSJmIawZ4+bJHqt8?=
 =?us-ascii?Q?c3Tc8VRdoYGKbHrz3eirQO9o4WoRfE9Gucyf1Q8vJX9GDLoh6/U+NSOGer40?=
 =?us-ascii?Q?1YF3rwbw3KMz5ayoPY2Jo2rRRbkeYgB9un6ltMXMdw2bhe5LaS0M42vgFGi6?=
 =?us-ascii?Q?0SU1ynZ0beTOEnBJVqH8Erof?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c203ac40-d340-4300-4d78-08d98e4f4280
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2021 13:42:11.9906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F425GnEh3Afh3qaCJLPBAy2GpQ4kw865MQqvjwg/oa7fO13+EeGMTrtx76qQ+pXX2lpsR46Bpc4cF9gmnY22eQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3290
X-Proofpoint-ORIG-GUID: aH14XHttzoFvzccI3CZVEBMXApe4ST0Y
X-Proofpoint-GUID: aH14XHttzoFvzccI3CZVEBMXApe4ST0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-10-13_05,2021-10-13_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 spamscore=0 bulkscore=0 mlxscore=0 mlxlogscore=732
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110130093
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preempt_disable/enable() is equal to RCU read-side crital section, and
the spinning codes in mutex and rwsem could ensure that the preemption
is disabled. So let's remove the unnecessary rcu_read_lock/unlock for
saving some cycles in hot codes.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/mutex.c | 22 +++++++++++++++-------
 kernel/locking/rwsem.c | 14 +++++++++-----
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2fede72b6af5..db1913611192 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -351,13 +351,16 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 {
 	bool ret = true;
 
-	rcu_read_lock();
+	lockdep_assert_preemption_disabled();
+
 	while (__mutex_owner(lock) == owner) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
-		 * checking lock->owner still matches owner. If that fails,
-		 * owner might point to freed memory. If it still matches,
-		 * the rcu_read_lock() ensures the memory stays valid.
+		 * checking lock->owner still matches owner. And we already
+		 * disabled preemption which is equal to the RCU read-side
+		 * crital section in optimistic spinning code. Thus the
+		 * task_strcut structure won't go away during the spinning
+		 * period
 		 */
 		barrier();
 
@@ -377,7 +380,6 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
@@ -390,19 +392,25 @@ static inline int mutex_can_spin_on_owner(struct mutex *lock)
 	struct task_struct *owner;
 	int retval = 1;
 
+	lockdep_assert_preemption_disabled();
+
 	if (need_resched())
 		return 0;
 
-	rcu_read_lock();
+	/*
+	 * We already disabled preemption which is equal to the RCU read-side
+	 * crital section in optimistic spinning code. Thus the task_strcut
+	 * structure won't go away during the spinning period.
+	 */
 	owner = __mutex_owner(lock);
 
 	/*
 	 * As lock holder preemption issue, we both skip spinning if task is not
 	 * on cpu or its cpu is preempted
 	 */
+
 	if (owner)
 		retval = owner->on_cpu && !vcpu_is_preempted(task_cpu(owner));
-	rcu_read_unlock();
 
 	/*
 	 * If lock->owner is not set, the mutex has been released. Return true
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 000e8d5a2884..7b5af452ace2 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -617,7 +617,10 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	}
 
 	preempt_disable();
-	rcu_read_lock();
+	/*
+	 * Disable preemption is equal to the RCU read-side crital section,
+	 * thus the task_strcut structure won't go away.
+	 */
 	owner = rwsem_owner_flags(sem, &flags);
 	/*
 	 * Don't check the read-owner as the entry may be stale.
@@ -625,7 +628,6 @@ static inline bool rwsem_can_spin_on_owner(struct rw_semaphore *sem)
 	if ((flags & RWSEM_NONSPINNABLE) ||
 	    (owner && !(flags & RWSEM_READER_OWNED) && !owner_on_cpu(owner)))
 		ret = false;
-	rcu_read_unlock();
 	preempt_enable();
 
 	lockevent_cond_inc(rwsem_opt_fail, !ret);
@@ -670,12 +672,13 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 	unsigned long flags, new_flags;
 	enum owner_state state;
 
+	lockdep_assert_preemption_disabled();
+
 	owner = rwsem_owner_flags(sem, &flags);
 	state = rwsem_owner_state(owner, flags);
 	if (state != OWNER_WRITER)
 		return state;
 
-	rcu_read_lock();
 	for (;;) {
 		/*
 		 * When a waiting writer set the handoff flag, it may spin
@@ -693,7 +696,9 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 		 * Ensure we emit the owner->on_cpu, dereference _after_
 		 * checking sem->owner still matches owner, if that fails,
 		 * owner might point to free()d memory, if it still matches,
-		 * the rcu_read_lock() ensures the memory stays valid.
+		 * our spinning context already disabled preemption which is
+		 * equal to RCU read-side crital section ensures the memory
+		 * stays valid.
 		 */
 		barrier();
 
@@ -704,7 +709,6 @@ rwsem_spin_on_owner(struct rw_semaphore *sem)
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return state;
 }
-- 
2.27.0

