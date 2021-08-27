Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85963FA1D9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Aug 2021 01:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232433AbhH0Xfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 19:35:37 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:55964 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232547AbhH0Xfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 19:35:31 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 17RLwKIO025345
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=Y9mV/klf9pR5WbE2dibyxm+y5LRAkahZN/AyYOm15CsEANmDUabL6m+WwDXw2ELZCoYC
 7QqMA6y87izFWllaizpp8ToYWHzbnB9ORJ3uiOes5hJjOK9/7q8HzmxLq85isp8goehG
 uDcC5NaHsvBzdapQxycWOufky4KZLgy27cqoWCR1U5IwAq91pmC/lwXae/WxhIF2eSCw
 lQZsFOH+ulTkwSTygjgJ1Vc0vkOpHaALXLgbRBWy51addT8ywpGlYnL27OfGo3z+YuvV
 tV7LhRVVcBl3Io+056Zy0SRBFGNECdyVB9au9gdhxpfdYo1L5GKi6kjjzRYPv9e5zdDA dQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : content-type :
 mime-version; s=corp-2020-01-29;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=yxQBz7KwCZcDE/3uo8ddNnTYA7wLiEaAVuXdAxDiX5RRF4R9Ab0eATtSWu5ynKMWuGR0
 U9iFJ8PtPaXm2eKCy7XgxpS8r1y8j6oMChfMHRfWOcMmexauTxjmjkQCeQkFevQSId5K
 foS2BU/POIIFBqpDv6Sr7TzEBtHjBgtxW06V04OMPZJtoYpU0vaK6f7feSlxNIxKNvvo
 ASfI2qo2W42GO1Kw+BwHtNG3ORpYun+hKBoVj44Ff6UOOTKWORiv/eNHfiy2qLMdoVbK
 iPVjO3zx0yJb+kQ2ELJXtNJ0K60JlXy4gxqU6U9RvZ6Omh3V5MwABMSTQHXeO13mb77X EA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aq1kvh1fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17RNFe7o124537
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172] (may be forged))
        by userp3020.oracle.com with ESMTP id 3akb92yg6f-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 23:34:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KnrOIjFWeI6PGDjg3FOoYHFeypZY8qTGBSN3dhGf7WuABHxv0GwENjc6DFtlUr+Q8EWUkYDfF+Gi4jyMer3QFl3o5Ms84nUT2QSocxzVl0p7FV11J4aoTZMVGgiYxA4b/GND7gq3qNR/HPqPimbI9D/Muno9erTeZAKBzg5jsWrObLYIrvHKhx1k1w/bcIWdtdW5YaaKfbLlKDoYSn+zLSMCtLdDob+ARRbGUWrHZv+lKUt29ilyaQNOIbDSI8DcE+1M6/WIT6Uslx9nXN2H+tyeN4WHg3SznemtoE2OS2ejbbNPLnUCIJ7TghxLtmXKSMPYyy9l6J0I42UBqY1Dbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=P1nvm3gojchoI/sltek78T+D33GJfCKhAYz8RwTKQiHcIouGpH7YVkH2Qxwn6SKsu5Q/U8zVZ9W4ubI6JrIxNL8GuMtB9uk7kd0yMzZtHJ6I3o/mZT34PR3AfygM6KGd7KGb++Ldv+cpSOV+uWV4jsb8yuI0voJd02S2brM5RKR1LRoHlSGyFy45ozzDeMUwOTEWyBe0yG0YCfkeJTWzF/2XTev5OcC3NbhLTLYrJHS1Heb7nNh2/DSAR9W2UAqoibd2jIJt3Ctf8d5BNWbirI++4tCtQs4yAwPy5xPbgY3T9D22nlbTlnqRMDxaQHv8J1K7kpnwzHq1ylFsJH3oWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiNHCvW8j9EtIsfwJ5mPzwMPH3ZxaIUjcFJjqO5hVPQ=;
 b=VN66+PcavbTU9YQxLU6e8EClcnoXqTk1nt+vW9SsehoU4HbmK7HYapF4cKbxi1sQ+Mf5EvO8nZtQyeBkpk6FbaNF7ORAZwLbNosIT6RZkSQywVR+5h7CDVhRdGpMPOTDiveu0nXTp05MsHfZY/xyWjL4XbOVctMsw3Y5iSHBrtU=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5520.namprd10.prod.outlook.com (2603:10b6:a03:3fe::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.23; Fri, 27 Aug
 2021 23:34:39 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4415.024; Fri, 27 Aug 2021
 23:34:39 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     prakash.sangappa@oracle.com
Subject: [RFC PATCH 3/3] Introduce task's 'off cpu' time
Date:   Fri, 27 Aug 2021 16:42:16 -0700
Message-Id: <1630107736-18269-4-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1630107736-18269-1-git-send-email-prakash.sangappa@oracle.com>
References: <1630107736-18269-1-git-send-email-prakash.sangappa@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0701CA0034.namprd07.prod.outlook.com
 (2603:10b6:803:2d::15) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::1501) by SN4PR0701CA0034.namprd07.prod.outlook.com (2603:10b6:803:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4457.19 via Frontend Transport; Fri, 27 Aug 2021 23:34:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8fa4766-d6c8-4052-c560-08d969b33ca0
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5520:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB5520823B886045C512F92E30E4C89@SJ0PR10MB5520.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +3uY1TgaKzHp2wDm9a25SNvjFaDZhF5ZOskDIbFvivIjBiLLx+/fqtltP42SygWdapGE2PNPB0gSLDl2BawAivIh57LhKDjJap5xyWraiTnksfFAg5xUBgCSWUJTIgcGpFhgrZei/z2Uz7l8HXtJECRH3YIrDmdRKheWqGMZbIq+Y5PgjUVySdtWiTky3yp+KO6lowPVHLTYDb6QrUlPSAq8ZcqCLznaTIsv61SsxltEHVgq05m3cU7pJrzTPuuah4ptO9s4SD9kPmYqid+0mNC+uVUUKFDtdJp/4YL729P9Yjti1W/6C2ReycHU65Ik4n6qvj+hWINjvhfgG2F/A4qdxI3EymrEUPJzcktl1FE10GfPKetPtzreAlNi0pQ0wqI3tfleIbojzRzaB6wkwKvunSOWu4eeUVwOFEZssoS4tKorNiOEiZ8+BbJwoGXUgHAja2NkR3wYIUyEUhO7oirQBxmCvn6zNAPkiBYVaqcaSpwaK4PU7sYcflQ8NB6FtqxrfjQfp85/7qcZGS0I4mBH71t3utxCx8JFfVkDpdZ8d7v1WlUjLFK7oTckVImLubt6ipLvPezR+wEugINLw25cxOyfhCpc87n35sgarcTgU8DQJmG03+9GcuPhV+wprBxs9FijLnMcNZ/zH0aZXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(39860400002)(396003)(366004)(346002)(136003)(7696005)(52116002)(38100700002)(8676002)(83380400001)(186003)(6486002)(107886003)(4326008)(66476007)(2616005)(44832011)(2906002)(6666004)(478600001)(86362001)(8936002)(5660300002)(66556008)(36756003)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZU0cqZt4uLT+kYbZ/oI6tm9pRYUo7X5tJJfCzyFaKmZaVWh8ToVnhxdc2o7J?=
 =?us-ascii?Q?Uo+wVY3ii6RXX/LlFpWBcnmdOfhJxmeg5A0+aDuvy+z4a3K8+bci8y4QbbDE?=
 =?us-ascii?Q?F69u70ZWCNKKBsfVpBgox3dHqSfKx9RKB2SoHa3wxr86VxlCq/CWOwq8Bcnt?=
 =?us-ascii?Q?l3T5AljTti/BlBef6ydVoRmK/RmEiITUVuzcyrcS3r9XdrbBRkmVCLgkiWTM?=
 =?us-ascii?Q?+JYsAWSPt0QiV70r6hGWMHSyLlgzoGCzdFhq8nsMK+ud8HfYA3v5mCdImRF9?=
 =?us-ascii?Q?oNeJMmKx6UhRr00SThnnzJBV0e3s4rOIEtm6lB65UuTpW5B7Y5CR2FFj3KJL?=
 =?us-ascii?Q?0hBosj9gHRWrkMvSxU5alZVBccT0BSYc7NiNQwQBPvORSOnmV0cNWphSLP0D?=
 =?us-ascii?Q?kD8kSlHkQYk6Ahn3G7grFdP8j/WF7ztvHbipdOHlMfCx8ZDPXbmE5+G+V5EN?=
 =?us-ascii?Q?iPH3pHSvo2ihto5GM2nogyRLY46BLLviHnTTNjaqziBFOGizgGGuIzMw3fzE?=
 =?us-ascii?Q?U8EW28i6fUfCGDiVJYuzZSo1WM+K9M8QdnvfIKaGrShRNhl6RqbYJI0XvDM9?=
 =?us-ascii?Q?mdj1AlueJye7zRXC2xqqtJ+DcoGOK/d3FdOgeaGqg88ZdfW/0NhZyxX67BKS?=
 =?us-ascii?Q?lEyf6cu2serUvkJg4nS47YNhqBXvh4yeJGaFg0cbOEZGJCySu7UmgIjH29D7?=
 =?us-ascii?Q?dYeatbVElHdS26dlT1Ce7FtBODMVA9tjhzfhwZQ6pE0pmfaLX2Y0k2OTHrvZ?=
 =?us-ascii?Q?mXszVADfkBCmg7LGdbibe3c9YHn5BARfkdETMHzKL9zZXibaoyEJJZbyp7x1?=
 =?us-ascii?Q?iXE/+K0VAHz7LA9/wMKH5ogzdavRPzN1WYCOoKVYKcM/1jFvtC8WXiOwjpYd?=
 =?us-ascii?Q?Ym2nfy9bq0XW91GTOyogHn9N56B/Ul8VjktvlZlMtUY6oMPefSUgjcn3XnEn?=
 =?us-ascii?Q?okyX/aqda/E1B8rNcQSHEyMqc85gh8t8MRD50zN30SOPyjFMXF6cAHzYFjat?=
 =?us-ascii?Q?ekz8CJlWRG4GgP/N0rmv8877YSyltSKwqMWqhjFUnAqjrmqPFd4sR0F7t1tt?=
 =?us-ascii?Q?/0lN2GIualicwVFI3sMV0+FiMkHh+SMKVn6hEg6MtsvgJJs5S0mUAuZvKBoo?=
 =?us-ascii?Q?iDnELPq0tM/53VKe1PDzx5/Hc53BEC+7eZkkgRWnDApa+eg+NpUnIWCtwBxy?=
 =?us-ascii?Q?k5lr+3jmNdlyAnZRdI4PoYl9AnUmTCciEwJlIOYOK0r6gbwor6T5d3u2sB9y?=
 =?us-ascii?Q?NAGvb3azKBeBMjXczLvTcXGMjVOZ+VuqA1N9C2tCBt4CcKILw9tFmUxIThoX?=
 =?us-ascii?Q?tE43PB/QSftp1B5Lf6iga/GJWSvSxwqkR80RyrzS7EMNcFXMYaYVZSZ0cGBA?=
 =?us-ascii?Q?+rjV2KY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8fa4766-d6c8-4052-c560-08d969b33ca0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 23:34:38.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pU1H1+w7KO+mPc8TsYTBdsvNqqaweatPKJE+CTYFa6P1OLePkAtQFWE6zfTjfFaHQWALiW6TZzr1I/gdqZcSzXoBs7iw8N0PYv8UuVQUW4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5520
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10089 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108270139
X-Proofpoint-GUID: NNNe_TeG2kRcb9lnjCZtrMXtymEHvhfO
X-Proofpoint-ORIG-GUID: NNNe_TeG2kRcb9lnjCZtrMXtymEHvhfO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a task's 'off cpu' time in nanoseconds to sched_info, that represents
accumulated time spent either on run queue or blocked in the kernel.
Publish the off cpu time thru the shared structure. This will be used by
an application to determine cpu time consumed(time executing on a cpu) as
accurately as possible, by taking elapsed time and subtracting off cpu
time.

Signed-off-by: Prakash Sangappa <prakash.sangappa@oracle.com>
---
 include/linux/sched.h            |  6 +++++
 include/linux/task_shared.h      |  2 ++
 include/uapi/linux/task_shared.h |  1 +
 kernel/sched/stats.h             | 56 ++++++++++++++++++++++++++--------------
 4 files changed, 45 insertions(+), 20 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 237aa21..a63e447 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -311,6 +311,12 @@ struct sched_info {
 	/* When were we last queued to run? */
 	unsigned long long		last_queued;
 
+	/* When did we last leave cpu */
+	unsigned long long		last_depart;
+
+	/* Time spent off cpu */
+	unsigned long long		off_cpu;
+
 #endif /* CONFIG_SCHED_INFO */
 };
 
diff --git a/include/linux/task_shared.h b/include/linux/task_shared.h
index 62793e4..ce475c4 100644
--- a/include/linux/task_shared.h
+++ b/include/linux/task_shared.h
@@ -70,6 +70,8 @@ struct task_ushrd_struct {
 		if (shrdp != NULL && shrdp->kaddr != NULL) {		\
 			shrdp->kaddr->ts.run_delay =			\
 				 t->sched_info.run_delay;		\
+			shrdp->kaddr->ts.off_cpu =			\
+				 t->sched_info.off_cpu;			\
 			if (p) {					\
 				shrdp->kaddr->ts.pcount =		\
 					 t->sched_info.pcount;		\
diff --git a/include/uapi/linux/task_shared.h b/include/uapi/linux/task_shared.h
index 06a8522..c867c09 100644
--- a/include/uapi/linux/task_shared.h
+++ b/include/uapi/linux/task_shared.h
@@ -18,5 +18,6 @@ struct task_schedstat {
 	volatile u64	sum_exec_runtime;
 	volatile u64	run_delay;
 	volatile u64	pcount;
+	volatile u64	off_cpu;
 };
 #endif
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 6b2d69c..ee59994 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -159,17 +159,24 @@ static inline void psi_sched_switch(struct task_struct *prev,
  */
 static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long delta = 0;
+	unsigned long long now = rq_clock(rq), delta = 0, ddelta = 0;
 
-	if (!t->sched_info.last_queued)
-		return;
+	if (t->sched_info.last_queued) {
+		delta = now - t->sched_info.last_queued;
+		t->sched_info.last_queued = 0;
+		t->sched_info.run_delay += delta;
+
+		rq_sched_info_dequeue(rq, delta);
+	}
 
-	delta = rq_clock(rq) - t->sched_info.last_queued;
-	t->sched_info.last_queued = 0;
-	t->sched_info.run_delay += delta;
-	task_update_runq_stat(t, 0);
+	if (t->sched_info.last_depart) {
+		ddelta = now - t->sched_info.last_depart;
+		t->sched_info.last_depart = 0;
+		t->sched_info.off_cpu += ddelta;
+	}
 
-	rq_sched_info_dequeue(rq, delta);
+	if (delta || ddelta)
+		task_update_runq_stat(t, 0);
 }
 
 /*
@@ -179,20 +186,27 @@ static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
  */
 static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long now, delta = 0;
+	unsigned long long now = rq_clock(rq), delta = 0, ddelta = 0;
 
-	if (!t->sched_info.last_queued)
-		return;
+	if (t->sched_info.last_queued) {
+		delta = now - t->sched_info.last_queued;
+		t->sched_info.last_queued = 0;
+		t->sched_info.run_delay += delta;
+		t->sched_info.last_arrival = now;
+		t->sched_info.pcount++;
+
+		rq_sched_info_arrive(rq, delta);
+	}
+
+	if (t->sched_info.last_depart) {
+		ddelta = now - t->sched_info.last_depart;
+		t->sched_info.last_depart = 0;
+		t->sched_info.off_cpu += ddelta;
+	}
 
-	now = rq_clock(rq);
-	delta = now - t->sched_info.last_queued;
-	t->sched_info.last_queued = 0;
-	t->sched_info.run_delay += delta;
-	t->sched_info.last_arrival = now;
-	t->sched_info.pcount++;
-	task_update_runq_stat(t, 1);
+	if (delta || ddelta)
+		task_update_runq_stat(t, 1);
 
-	rq_sched_info_arrive(rq, delta);
 }
 
 /*
@@ -216,10 +230,12 @@ static inline void sched_info_enqueue(struct rq *rq, struct task_struct *t)
  */
 static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long delta = rq_clock(rq) - t->sched_info.last_arrival;
+	unsigned long long delta, now = rq_clock(rq);
 
+	delta = now - t->sched_info.last_arrival;
 	rq_sched_info_depart(rq, delta);
 
+	t->sched_info.last_depart = now;
 	if (task_is_running(t))
 		sched_info_enqueue(rq, t);
 }
-- 
2.7.4

