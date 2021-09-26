Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33F9418814
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Sep 2021 12:17:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhIZKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Sep 2021 06:18:41 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:55698 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229962AbhIZKSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:18:37 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18QABSw8003717;
        Sun, 26 Sep 2021 10:16:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=k4IMvgfpW7zeGLnNaIx2oX4j/5vfX34NkUfCy0Mte4w=;
 b=i4jEdFw4v6VeSgmokYQYoon8kYe05LhA7BVID/h0e73OxAh2joo3mECrlNjm641Drb55
 fpAvobmJygv56omSWsjgd0LIA0IxQVQj23Z+Qfz9bq7pNXICLhTZ6UBFgBAEGFVo6mt3
 l9WJVUwnEeFlPn479dVT4QWSaTm/HydRpdMY/+JO3RIM1kbfDWQbgundkAGujsKPldSp
 Zo6GMPNfIODcNJ35xZ9V7p6itN+Qy7zh4V7pVkWJ1fh/h3wOos+c/Jc+Vfi6Dg00NLt5
 OEpkM0FIp+IziSd7jRA39yFa/BYnekE8v9TAIEnEk0HD+TqyTEvYxof2wi2BoNFTLalV uA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bacqmr7ux-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 26 Sep 2021 10:16:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GntWyK5Wyg7zNIcN2odyiuIVV6NBgAH2WP6KBWpc3s4BZ0p41Jlk+kvxPgKcaqe+t0OvRWl2RJK8isCm/CInDCUGGE+5mpr8/5GoNMYSht9YjIjSfy/Ja713ApdNv7efjvGIsaOiEMb+mSR0GCENQj3fzRQHH1R29QUZhO0aWKjxWtT438sym6doE2RPN0OaOyRqIQiPDQT3Cey39TtwZEIswRWU+V732l9//8ronCvcfq+NG4QaBtAwkHByxbnwQHyjr9/Imjz7oo0YEosZE1P/GGEAoaeKT3MRwewOZZM6z/7HUiOiXtvEhJKu1PJrK8dAowjcXSOPW14IH73GMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=k4IMvgfpW7zeGLnNaIx2oX4j/5vfX34NkUfCy0Mte4w=;
 b=aMWLXjqm1Si6UBSnLsnRMuqCDVVjb9r3QVcXNWSbTnqcMWATzvty8Vjq3UfYAhM/WpEkft6NpGstLAYQesFrt/MtcCORujxzW0ZvRF9IvuVCOsvmR8szKcs5piuFnSDAF3D9MGky4w1nFOSHGdruX2BsErLFVAIMt6z9xWOscooK/gpU7Zg8mLyRrbhH5aWblt4eBCaAk9o0b3v2mYJTA/FOJXBjcYKgEcztN/9SUwNW7Hb3soqtsoQo0nE2S6Pi7IE1JvAq5Z0XQzZsHHDMyaLVztbsKCdWN5NzZRwvaI6IlUT7DozugKuF6coXWQxnMjwykcVjrVo2O2a3kxB9Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3148.namprd11.prod.outlook.com (2603:10b6:5:6f::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.18; Sun, 26 Sep 2021 10:16:48 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4544.021; Sun, 26 Sep 2021
 10:16:48 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] locking/mutex: remove rcu_read_lock/unlock as we already disabled preemption
Date:   Sun, 26 Sep 2021 18:16:23 +0800
Message-Id: <20210926101624.2460704-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0166.apcprd02.prod.outlook.com
 (2603:1096:201:1f::26) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR02CA0166.apcprd02.prod.outlook.com (2603:1096:201:1f::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.13 via Frontend Transport; Sun, 26 Sep 2021 10:16:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95ef300b-6926-4037-d62e-08d980d6bfe0
X-MS-TrafficTypeDiagnostic: DM6PR11MB3148:
X-Microsoft-Antispam-PRVS: <DM6PR11MB314839AE9AF04252A5902206E4A69@DM6PR11MB3148.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hWmX8xRRkwjfFuFzIL4AkThENHE4dxLouxr+YyrtkZpDMDnLCzeF6EzWso7LR6GchW/KDk1DK5SXJLgT9rNHzVL2/bXoUtlV6MRtuuPl9wRrcBsrNREJQ2kULNtuAyHV7IkHz+yxRY3uCz1RY4WxgBFibgS8tywyHYubkiyw3zHiP38HKOW2q/QQfrKZ3dX6dHPLYP5BejogJkn8osEnxC5eJu/anon1S+M7wqKRhHQ0ol7M9C/GBp7lGMWxP6P1TTfergPJvGElwZEJsaPe9SfpExYERRGhqR6AUrRDN8UA8gAk3JDheQlAOZpIxVuNmlFG/gVletkhzdIMp2GUPgAZALB7Joije3XchxaH1FPZ25I1cW/2GH2zO8jkWoE52O81lxY2vrCqAYqhNzAETuq+8ujWv+SiTZ6RKsrmqwLpmMgoAElUDveycWHgBxUe2dwgIMio/bScvek8gel+cK+sUQnP4XIMD0aYiMVFttIZtt5jjLfTfhh/0EnK5oSVnGFYlmB5K1dxq4+rWxJBwSm33t2XU4MsEYEBfPDvglmjh5rZPA/0rF3rlNoFryhPMaMlwzMnuYGo6A/V7oacyO/NyNMw+fVXdzr8V8+Zx7AfoxPYj0LMxmu1ovGo+dRv4aFw2BSNK8rwdec0ltw6csU9PSeeZvV8vSvAzVht4HXrc/6HiEVMrz44wHv1qLI6mDKj75joBjlFYflSw3Rvig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(83380400001)(52116002)(6506007)(6486002)(4326008)(2616005)(956004)(2906002)(6512007)(38100700002)(38350700002)(316002)(26005)(5660300002)(8936002)(86362001)(36756003)(66556008)(66476007)(44832011)(66946007)(6666004)(508600001)(1076003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HaIszXx7FmjPJAJJqOXlunwywrhOiNgnGxvZvtF6GDIxWETAiPmt6/bDhRLw?=
 =?us-ascii?Q?f6HoNKfEDB/1oh2hcKuWhbVirvKoYylMdjfdnzKNGzrDqjlV00gg2fnzGYX/?=
 =?us-ascii?Q?o/qaEGm2PYdE3rxEH6+DGAeTxFy8DJ+Y1ozx2bmucPYSU16QaQbt3jcKyQY8?=
 =?us-ascii?Q?hDRTVx0mqj/4SE5rvzAGnz24NVLZYY3ZBv/WMxVB7mfwF7S4QmKckoH+Qk7R?=
 =?us-ascii?Q?T/2NcMWTfQA7cVlk/mmNKa2bkwSOIG/D++cwHqUFVQo4ZS5q66J/GMl/t37E?=
 =?us-ascii?Q?4XotcvxsVf31RwvCMtyDHyqZ6pTHtXxfVPCq993Pzcc/Rpo3zuloUXQvm774?=
 =?us-ascii?Q?JXkrGTXTOnfnSz5XdePKPZhLnEfoiS1Z7Ed45ta0idjnYZFlVboPHONxEhTW?=
 =?us-ascii?Q?LoLHlV8WInUkioQr5SoX/lwxLGYXU+T44BCsLsmX5rIwyfgWiVtTLYS46prZ?=
 =?us-ascii?Q?iHZFm5neSgE1bortVFI3dS0H6KnWd+9pJz4zA7wmpYS+3BuRaKXiCHk3pCYE?=
 =?us-ascii?Q?Ao8G//F4p4dqTFAcZELZVkUdwz9Tj1XrJvcAHX1dTjZmRUlZAce/hlZqdeWv?=
 =?us-ascii?Q?357tMlKFC8rTGd5SFmpufeqH1OJiZ+hhnNkZ64h2xF9EQeXXbBeD8QbM6NDe?=
 =?us-ascii?Q?AhYm4qc15tP18mZqzOJhraBBs0ZJAOgbIYVBXVk6CRShteRdX4zUvMy1urb3?=
 =?us-ascii?Q?jN5X6UZVZmBVLbY6bSl4bPNKotJml0mEliiBVdlJBoo6lxJYkrPLwoeaNBrQ?=
 =?us-ascii?Q?2Jr9Bg/jmbFvjl19eJs0HekuODPZvwO9nbaM77/XN4XFppMgu5vGxx1Rikz9?=
 =?us-ascii?Q?w5aagc9RngH/f2CpKM6r6i2ry1PCrtrfDQ07mrMWpbWk0uaQZFV3Sfx9gqSZ?=
 =?us-ascii?Q?6RZ2Kq5qOWGufb1IpZUuR0gfqzmtvm0t3WzwLnvvoLwvxO+SPx7iN9CtLwGl?=
 =?us-ascii?Q?W/tWoZ29dd8rmq0750+CGuENEmTpsBn8ArJZHgnbrQKfuwGGT+yXZkcVOFbn?=
 =?us-ascii?Q?eA+uAqyl0Q31zF0LmAu22a6Lj/YNNlxUro2ewC/NhVyI3ESC1FVnaptEk0Bn?=
 =?us-ascii?Q?ZWkc2D1o1xGPY0xvc6DyEcvOaC5GcpRYROy8y920ZRtY1Rmtv+og82VXNWgi?=
 =?us-ascii?Q?v+qp2ne+PQeh3kfUMK9c7Dve5xXP8grbXnAaSGT2lrNGgSJpgf55tq4/I5/6?=
 =?us-ascii?Q?kmfGDDjtuc/cLIv0Fhh2Gdt9Ju5j66FuptDY6DtzVcWpMYuAvcACa4vcuRPq?=
 =?us-ascii?Q?dAbr/jgTZ2em67DzIvirozkfWLmFtMeW8tWuK882BH1HdDY26d8cArNqvshk?=
 =?us-ascii?Q?Vgnlev4dy9Me7bxMcl2cUDoW?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95ef300b-6926-4037-d62e-08d980d6bfe0
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2021 10:16:48.1818
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C9SSiZK7Tza+3b4ntjbVCcb8hpgLA5moFvcq8dNljAPkyVgDupMPvQREetSeYtf9HD1X++8oXPbCgKlE1BL91g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3148
X-Proofpoint-GUID: _d5LK_YWZHCA67jGFr5cA0coRFIew_J-
X-Proofpoint-ORIG-GUID: _d5LK_YWZHCA67jGFr5cA0coRFIew_J-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-26_03,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=875 spamscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 impostorscore=0 suspectscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109260071
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preempt_disable/enable() is equal to RCU read-side crital section,
and the mutex lock slowpath disable the preemption throughout the
entire slowpath. Let's remove the rcu_read_lock/unlock for saving
some cycles in hot codes.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/mutex.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index d456579d0952..54658c5db7d0 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -348,13 +348,13 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 {
 	bool ret = true;
 
-	rcu_read_lock();
 	while (__mutex_owner(lock) == owner) {
 		/*
 		 * Ensure we emit the owner->on_cpu, dereference _after_
-		 * checking lock->owner still matches owner. If that fails,
-		 * owner might point to freed memory. If it still matches,
-		 * the rcu_read_lock() ensures the memory stays valid.
+		 * checking lock->owner still matches owner. And we already
+		 * disabled preemption which is equal to the RCU read-side
+		 * crital section throughout the entire progress of the mutex
+		 * lock slowpath, thus the memory stays valid.
 		 */
 		barrier();
 
@@ -374,7 +374,6 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.27.0

