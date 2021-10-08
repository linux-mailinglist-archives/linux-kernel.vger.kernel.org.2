Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E14804262F0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 05:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236315AbhJHD2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 23:28:10 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:30956 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229501AbhJHD2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 23:28:09 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1983KnH0020229;
        Fri, 8 Oct 2021 03:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=H8VNP3ElOFYvH2spDdUb4Oho00ZHxh5S6sEX+XCPFDk=;
 b=i3AKopFW6TUCt9QKqQ78OnrXJzmGuRUTij8xQ7xBRM6A6wWu/IBwfawnBvum69gHR55c
 Yc9y4AWFdz8mmptU4lin8keum3z2v6TSq1tBYHr6tJA+s0rBqTQmUh1bXpPAA9UyLvMt
 oCX5RKUw19YSO15LCkFXQg68HSkAUx2FcuqX8X5zr4q4tzioT8/+pCacmAZpEgBbYwMg
 CvHWMLEfGCh87YILw/Y0/r/Da6dt6oYAUVXrXQ6vtreUZpPNqIr5wyPw4kC8v3b2EC/6
 J8DxfZiYPY2EJEcEhyOu3nQYNAFgA1kjaigK5gIGvv31YEGvRlVx0iWVtKdGJ3p8+dE1 Qg== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2040.outbound.protection.outlook.com [104.47.74.40])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bjdt9g0ce-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 08 Oct 2021 03:26:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C17GsiuVPcBFnwPsngrD1BzjfzRTTigLe+WujusoYZ/1qw3QK6WuXUCDRiPZhccOjudq+HqgPXcVhRqSAbLjJcydy7C2TbSeAbakcAt3tyn6yC7JWJ98yJYJKl5ZB2J8L/0XOyW47eE1pXtVDgZ9/FUCLzizluMHmmCwn0HKfsEQf3jP1ZwUvxjaY3+/dLbRFhtYEsG/DFwS9EYGoKn8fgw+A9ctQXUb1MHDZoz09jyadwjyh+sfJWybVuHS7zBNx/Bj4CpziCZHjm9G8zQ1gBUbjwqiEPQEFDmvPYEAa/ukxA0nZHmnY4XGArlkqkM+p/uhreOOa7otwX7A1YMXqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H8VNP3ElOFYvH2spDdUb4Oho00ZHxh5S6sEX+XCPFDk=;
 b=ArjYitx567rqURlqGlOEfWq9h3Mtttjs5EI0AZE4HLwF2zDwj2auvEMjUOfrpV6zCS0aE8rPa4Bn0Le8To0QFY/QmsC/XLDNLzjXAgMdOfU/Ak0y2VbevMudZu+PSbXQwCPCVwhIgFZok1OydKR1AtfD2/uh+mKO/VgmzxEc2p5CIWeiagje47KfW9YSmQiZ40gIT4Uu8x3+/hgaIQOdw2V8TjEBiYgayTAm83T8cshvzH5uf+KilgCcOZk744OMbxHsu46Jtu4VxTgk/nVZ+GvCiHwD36N5wA7jXzrqCvpn/iT8s+s8aR1NT4phPOgFG47cvOEYuC8aU0PTcSdhJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4566.15; Fri, 8 Oct 2021 03:26:00 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::5db7:737e:8ef0:c831%4]) with mapi id 15.20.4587.022; Fri, 8 Oct 2021
 03:26:00 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] locking/mutex: remove rcu_read_lock/unlock as we already disabled preemption
Date:   Fri,  8 Oct 2021 11:25:18 +0800
Message-Id: <20211008032518.1298372-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:203:d0::22) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HKAPR04CA0012.apcprd04.prod.outlook.com (2603:1096:203:d0::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.20 via Frontend Transport; Fri, 8 Oct 2021 03:25:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d98eebf6-2a51-4115-b4f0-08d98a0b59c5
X-MS-TrafficTypeDiagnostic: DM5PR11MB1434:
X-Microsoft-Antispam-PRVS: <DM5PR11MB1434A4A1E5D2C4D76340B089E4B29@DM5PR11MB1434.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:813;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: R4J+XbJbQvGM5rvQFo5SMbvBuDgRVdyb6ifW+UbL3+IkqOjN57IrsJuj9hx/F31JZ9AhN5zj0jt3LtY1yDuIFuD/iUCbN7zLir8d183P6BEOc9tvIbyhZUbKrMXvX6Nd7hiWmLLQQkjxGZu3Qr//0LElQmkM0WJY/z1nLOj8NhMbW5krwxuadYMBoPB2eAPP8bX0tpXaNZNBFfKasZf+QJ26SoDnH2R5kYm7W5ldmxZKtJyA3yDi6WbNxth7k3EHrQ86gUkUMv4XtAEQpu1ZBrYN25bofMdJQH5cKWK5URO7iwWtiaxcS+kbWyI3OgXMp7flAvfhdnOrY8rV1lcq2LGdB4BfLlHC20A7PAiA/fqXRyCIVjN3EMKEdPEwJ8O1oYKINVSsQrwJWdGOkHmadeWhOYU1f4q3JPxkFbW/kK0XdCzHI/QDz8wCN4crgO4hl91RSMJXSfFT6UhuPr9t4qQwYIFSaxF6a9AooK4YWRSZBPFtHN4+zZi825xZo2oaoX1Fn/jvd6tg6cH1wJHzDDlLP2JE8wbTX/qK3Lf7HoSAodAq8Rvi7vfarz8skOVcOx2GaUfUTgIq23RUpFqqsyD5hVWdCO9DTpsCRA7bAPsuZCgfda8R+hI/OLPovYGdFiLv2EemfnYbPiYFKB0TRRPlwsG6NKEvySAeLuaqEr13cDQxoJ3m6A6rfwk/k4rjGOOF+QawrKxjD6TfH5TMXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(6512007)(6506007)(508600001)(5660300002)(8936002)(8676002)(36756003)(26005)(52116002)(44832011)(66556008)(66476007)(66946007)(38100700002)(186003)(6486002)(1076003)(83380400001)(2906002)(38350700002)(316002)(6666004)(956004)(2616005)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?2NXynuEZJZY5F/IPvtq6MA5vDLhMMtzsVon97WCwFicHfdOlf9n3AKUWYwM3?=
 =?us-ascii?Q?UkWnlFLeV97NlsKvzJKRfo+vXkP3pWonRRH6bxNlDr+H9gA2K3WlvD1Q7Uns?=
 =?us-ascii?Q?pkTYA8b51HUgNOkOrcZX1G0XJ+0OAQK56t7KQphHCYZ0P8ft0ZY1jjWnJcr9?=
 =?us-ascii?Q?WEQtoXeHydD+LKbnpSLRXbEa/fkw49Uk/CfdC8eajNP03m/mQQogZkL/f6Mn?=
 =?us-ascii?Q?ONWoEEQAoGc0DDuNkYw9MOfH4ORVC7qc897YnEvI9VTmP0j5/vOpeBvG3ACR?=
 =?us-ascii?Q?R3NY6lGkss6mylOJNWXAyXgIcH1YWR7kq1HCbPunt35D1/AvVKRI5ReRehAT?=
 =?us-ascii?Q?lywMwhUSkFC43qyhL1syLYdcWGfFKW2fL423+T6Ya3FDnTqYX0sEWp3EDX7c?=
 =?us-ascii?Q?qVWhNXJm4M1fXttfUmHkeNjAmvNY7PdoC6A/ZDuZhfBGGtISmje3LtWg9ENM?=
 =?us-ascii?Q?A+PMNawiegjVsXUKt7oJ7qL6GfKqtMqDmeLJZd2rxXOINyKB00gCEDQ6Nmck?=
 =?us-ascii?Q?cj3rWhmjluDoWjpGd5ftbmtGO5dX6Jlt2PRVddOY435vurwQlOTWMCrFqpv5?=
 =?us-ascii?Q?CcTr/gEE2zCIIPFgYL1VRxBy8LR+wPAipIuV2vYQEgChCuiShBQck7TJnJsR?=
 =?us-ascii?Q?uDBLv89LGHofdFUyESYYw9X73eeHoRuv/p8mRUrdmBHNsXVkgtdSM5TR89/l?=
 =?us-ascii?Q?Sixg73lVnUPzPRbWqqZi3gPy1etLGgB4Fob5SlCrCR1UnKvWt8GjV8HErZ+r?=
 =?us-ascii?Q?8gjtW7Ch6F04YDpRZ2ShiR9r1xvgB8vNj9DyzpYQDcwk5QTUdBXp2gZi3BHP?=
 =?us-ascii?Q?WZcpnfwac5y0aXmK6aZ8fTubsf+RHCkA1C/ylSp+KYAL26eLQn/iaWYi5kbr?=
 =?us-ascii?Q?AuuIpaokt8oftZMn5KYJSwsJlEWNOMfVdFt9pfJesY21PVPufcToJOsMpvwH?=
 =?us-ascii?Q?ODQoIp8mixJ7hPj8AOT3SgbURp+URuRdzzopcVhglXC0u6CqM920ek1D2PNn?=
 =?us-ascii?Q?HcZqbCBSY/AI1pD9AhyjzD4qNGO7V45jG5OR01hWXDeHpKjVoElmms+VKPm3?=
 =?us-ascii?Q?qQIPEpEgWjawbzV26sXRfWLaY9PJWiPXDUK7WfzK7qZJRMOy49hTn7ORNHjG?=
 =?us-ascii?Q?StJyeM2iBKWIqcPQb9lKrn7+GdrGNcATa/YdKuAWcEYQybSRpV4TaDTveMRl?=
 =?us-ascii?Q?t1ZZkgPqtKZD31cmG52KTNAhR1aWQPmFpogTmP07bi/E4Hc9TAgsQlGy8yM6?=
 =?us-ascii?Q?IQkQm2saS0Z/fm/bRldhHHSHyTV1X+JRLccGJdsUAgnqeicv/aklj12OkAqY?=
 =?us-ascii?Q?JZhW01btFBT+e3bpsAXGI4xa?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98eebf6-2a51-4115-b4f0-08d98a0b59c5
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2021 03:26:00.6243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vqP2wCCR1Tt3/80Sj47FHWxDORC2e9/enEIyukbkj5yfZux3gplpwj2dW/74oCupmMzqq7fhPtdsEDAzbloCzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
X-Proofpoint-GUID: iwjCEu84yWv6UvjyZoc2pb-ch-gDx0Bp
X-Proofpoint-ORIG-GUID: iwjCEu84yWv6UvjyZoc2pb-ch-gDx0Bp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-10-07_05,2021-10-07_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 mlxlogscore=999 suspectscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2109230001 definitions=main-2110080018
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

preempt_disable/enable() is equal to RCU read-side crital section,
and the mutex lock slowpath disabled the preemption for the optimistic
spinning code. Let's remove the rcu_read_lock/unlock for saving some 
cycles in hot codes.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
v1->v2: fix the incorrect comment in code and commit message. 
        thanks for WaiMan's suggestion.

BTW, sorry for this late v2 due to a long vocation.

 kernel/locking/mutex.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 2fede72b6af5..2f654cfb10d9 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -351,13 +351,14 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
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
+		 * crital section in optimistic spinning code. Thus the
+		 * task_strcut structure won't go away during the spinning
+		 * period
 		 */
 		barrier();
 
@@ -377,7 +378,6 @@ bool mutex_spin_on_owner(struct mutex *lock, struct task_struct *owner,
 
 		cpu_relax();
 	}
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.27.0

