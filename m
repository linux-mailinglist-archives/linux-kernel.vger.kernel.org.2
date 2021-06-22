Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDC33B04E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 14:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbhFVMpH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 08:45:07 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:29106 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229999AbhFVMpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 08:45:02 -0400
Received: from pps.filterd (m0250811.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15MCdIst024637;
        Tue, 22 Jun 2021 12:42:43 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0064b401.pphosted.com with ESMTP id 39bdsc82w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Jun 2021 12:42:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VcbJ/ueneU6rdJxV3MwURG2lTHgt8Kin3QEMbgcn1ZLUQEDWqk3DvXyyA++57wT5j6nH0nVG6ZmkfWiszAbuXre9mw6lAwkeeTLhMzUcG4CZlvtZ2FVHhLOW50rrTD5sHKki11qe6ItpoD5y7LWXVnxxRxGrK8LDGbHu760/YxlPDOT/D2zZ0ouDIc9mkJOl7BI6/IfTD2eYua5FWSewwJJXWuUObiFuJbhYXPwtcZwP7JLcGH0vANvuR9HKItxdp2vUyGr6trL0bjoVGJZb/lgebXVTkENnhOG8PTjuHNwv+PULk6kPzv4uWgd7Non3znl18hcV0rOSY1kNNu3Lmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja0rjfvYCCnZtjGRNgrPJaVgp3l9gr/uiQuCk5zUi4s=;
 b=P4krSsYpkunto3DorUv5dqlJLf0xPsiVsUq2uRK9eYMqYoYHPcEjr8gV4Ic7A/wParj4yit8lyB3DGdhT+FX77Y5lZbConyxCbWNHohcKo059Qoch0+v5gc4E0JUsZEcB9yr2B/3aXBEv7CFO4efLO9OgthwsppqDUH7xgH7+vKl30TWDdy3uSe6i6/lon7kFhMZsMibkFef2cFfc7sNHPU4DUwelRTkbGNmf/qRrzNLWinA3VX8lrXe4iYdVz/UUMvPeGuopK2xQ4hLClvGiInJjqvc84UENwB8RCJuX5+Xa2b68tMeVSfxnoICvnSAdxseG8bbEIQ1FCdfnwRSyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ja0rjfvYCCnZtjGRNgrPJaVgp3l9gr/uiQuCk5zUi4s=;
 b=U3xuEZxn/N8QE2CeWXAgY72tBCeLHGE9VfTtCXlOh3lzM10tUSTFxgZzHXn4LB32RwCWJEbJKFEaK3ecQEmEy0JKqlLAtEkQ7dhnBlWZKiR6cIrdJsSromjpi3r1NHGef07KMMSpEsv2cSCFbMIX19XAzff+AiQLRTC9Z/Gi+EQ=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BL1PR11MB5478.namprd11.prod.outlook.com (2603:10b6:208:31d::12)
 by BL0PR11MB3473.namprd11.prod.outlook.com (2603:10b6:208:6e::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.22; Tue, 22 Jun
 2021 12:42:40 +0000
Received: from BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93]) by BL1PR11MB5478.namprd11.prod.outlook.com
 ([fe80::9967:5190:1cd4:bb93%6]) with mapi id 15.20.4242.023; Tue, 22 Jun 2021
 12:42:40 +0000
From:   qiang.zhang@windriver.com
To:     tj@kernel.org, jiangshanlai@gmail.com
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] workqueue: set the rescuer worker that belong to freezable wq is freezable
Date:   Tue, 22 Jun 2021 20:42:11 +0800
Message-Id: <20210622124211.715378-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [240e:305:7882:cd8f:d411:cf14:bc71:d5c0]
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To BL1PR11MB5478.namprd11.prod.outlook.com
 (2603:10b6:208:31d::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (240e:305:7882:cd8f:d411:cf14:bc71:d5c0) by HK2PR04CA0061.apcprd04.prod.outlook.com (2603:1096:202:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16 via Frontend Transport; Tue, 22 Jun 2021 12:42:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c446c35-ab28-4302-6938-08d9357b38c0
X-MS-TrafficTypeDiagnostic: BL0PR11MB3473:
X-Microsoft-Antispam-PRVS: <BL0PR11MB347334290FD5B73B86F845A2FF099@BL0PR11MB3473.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2HltM6Z8BltReYlNixjjswyycu/DCSPnorax3l3q1ggLXbYScWIPJIw4qJl6C57OXFSg5S4BaRUO8kBEVOr3+sxfW2pGmVuX0LEJfA9zw2d2I3dL9ebK8HNZO7ZGgzCMpAh/2c7tbyY4PgRxoHQe8ucLMFiFGWHNWODuvfXJbJuUr5FLPzh2VbgBMFtxJ3pJSSTiTvm8T2BlMw4OabaDrGXy0GXt90d6jGJfD0j0vw3QMkWudU6p0hdEzG9G4hXUvqWkyKepI7NCieBTA/O2mM+lXyFDOlI8m+a/0nZNkAElm5GZnFqAMCfdYs4rvDD30gXZ+tkXciP9PG/VdM8kXdt+zEb2SXJM/3eCG60N+ls+e3EVc0erVwZxH7e8GKGWnl89kp/Q6bMN5NxO32Fj5bV9ZC4085WZDQCcyfgLQE7VnRGsK65dsEvWwq3/8tRXAGR37CrT78Ps6TM1wAOUXQkE3VTwyifHL43X0hiIFNj/fg5rx5TXWHgFYvLOnar70X2k2lzJgNXW+/RyuOcJ+xc+mnY/aLjRzhcy0HhiVOXHxiRU0V5LrzsF2afvIJIed9bpllwWsXZlXJGxRC05CLI7+k7mp9J17utNbTrCIk5AKJvde8PIH5TmxfajEA00NZYGq11Z90+9/8ZMFpNN4i2Kc37nGIo200SpyhvhSEDjyVlSkB8HufBKFlMrLVwombVogWC707ui24JgLJM3sQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5478.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(366004)(136003)(39850400004)(83380400001)(6486002)(6512007)(9686003)(8936002)(1076003)(66946007)(36756003)(8676002)(66556008)(66476007)(6666004)(86362001)(2616005)(38100700002)(16526019)(186003)(5660300002)(4326008)(52116002)(6506007)(2906002)(478600001)(316002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?esO1wvuQoEXvPwKly+3ip18MCNryooOesh0w+ItCOcq3OqQlpmApBpR4h322?=
 =?us-ascii?Q?iEBL83USdAtqTF7jk59fH9XPouCjA5NIR6HUL+gvu/LlwmuZGtxdHSelhUKF?=
 =?us-ascii?Q?L4n4clHznO+kk49X6+fboaXlV7ZxlJTkfu1JplwE4xYCAL/vUKKNio0xXmQI?=
 =?us-ascii?Q?8nIlLdzzlVVpJueW5rKk7lPItmFgn+BV+suYUY2YL+NtMNtB7ipfoVpmKX4S?=
 =?us-ascii?Q?20E3s0tNFjsdgSmf5kGUUUW832KpQ0zdPwVfSiged+RKjFqYs8jqev/63N5z?=
 =?us-ascii?Q?mQ3tmA1oa1syA+oIU4bnaT/DIg04d/GvDNCu3azGVLAIxkvkCLZbUJf/RDl8?=
 =?us-ascii?Q?zCu4EKdjeshEm2oHXJDFH0fgbEezcm2+2MPDg2v7wnfaluH3kkDR6/B3wNol?=
 =?us-ascii?Q?j0D0BJx+5zihEjoyZcPzqPZQLNL2J/OitKVhfVeE/JJkO5QGcnERzcH8uo+p?=
 =?us-ascii?Q?DdJq1UiDBDscJD0+QDB5Y0L1HGwAOLV9W5h+bNYeq/RtfmgrKBAOttgPeSjN?=
 =?us-ascii?Q?RvDTYFFJC5bO+OHb0q/1D5q/hmM/igBfM6IvL3VvmJLwfDa2TWUFk9+IVlyA?=
 =?us-ascii?Q?BUIQSdzDrUnDYNzlr6HHoON8qY2wFipuvocqPPt2ChSNBMzQsI9syeqBSoIY?=
 =?us-ascii?Q?zfH80CE20ONd0r2B+n/EGHSRIsAMLKM7ioTkAztMzYT05b9LnNNTaL7DVT3d?=
 =?us-ascii?Q?3VJHts2iVrm/Zi5BiCn0CJSM8+1Jtc1Dl3lVNPvG/YCAOkbEZ1rD1AJLwooj?=
 =?us-ascii?Q?o3IyOwVQdieqUYxQ7hLbpYAa3yPjOrc91NA4TCE93v6l2usjYEZugzU9mwAh?=
 =?us-ascii?Q?Of7cDzoNTqQUJBRuHB50y3izQ4l+QHNlEP+ynVH7JRFdrkG8pyEepjz6YnR8?=
 =?us-ascii?Q?h9DU6UeiFNDu2RNI24mYrspR4r31t8qkzUwncDSQHQFwn8ogBY32v5SVxT8v?=
 =?us-ascii?Q?MBtGRM3WmJp5B2KIV+RQn5i/tPkjJYwkNx+60xtv/pRgiuacU1UFBaTMdMTl?=
 =?us-ascii?Q?jTSQOMgpcS79YMvKOwqPpHIxY/Om6yDUZaBCIDHxuv1W6goEiOjUQfvJ4TJs?=
 =?us-ascii?Q?At5trdqEZgSHelT3+ZWy8xqNKavzcEX4LFldV13/rNByJqVfk3SP2Fg/W8fp?=
 =?us-ascii?Q?yaEG10oVZ0d5oEx0c1I85IraiDHwXGUpC8MdVodBkPve41KFt4WRcQAhwanZ?=
 =?us-ascii?Q?YCFFPqLBlsMD8QPc3OWE0RG43jed/A6pQpxMwEu4HZaUcJArJV4YgD167vZM?=
 =?us-ascii?Q?MZKRz1YgVFBe6Wg8fq5NEUXj4o/pFzi619VbOfaxahUK/nMuly1czkbERMA1?=
 =?us-ascii?Q?a0WNwT2d1/ARXR1Tp6W9aYwr+2Uvr31+Y3Ah3uJfFpka0CVsYn3YzVCHekoe?=
 =?us-ascii?Q?aI/9+beZoobHJsLgQNXgiBVu3mLx?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c446c35-ab28-4302-6938-08d9357b38c0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5478.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2021 12:42:40.3658
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vPi9I9fPlF95XnDbE++JWrGoPrtUoP5yhH/VpTmyX1jIgC8JyuyUUUEH5lpVW4QtdiUFrTLHfvaqhYSQL53WULlKlrqwO7AeIbnvGAkoyGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3473
X-Proofpoint-ORIG-GUID: WHeC0dvR0bTSfBieml-8Ultoy2WwHZ9k
X-Proofpoint-GUID: WHeC0dvR0bTSfBieml-8Ultoy2WwHZ9k
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-22_06:2021-06-21,2021-06-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=330 mlxscore=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2106220080
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

If the rescuer worker belong to freezable wq, when this wq is
frozen, the rescuer worker also need to be frozen.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 v1->v2:
 use kthread_freezable_should_stop() replaces try_to_freeze(). 

 kernel/workqueue.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 104e3ef04e33..dd7b78bdb7f1 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2476,6 +2476,9 @@ static int rescuer_thread(void *__rescuer)
 	 * doesn't participate in concurrency management.
 	 */
 	set_pf_worker(true);
+
+	if (wq->flags & WQ_FREEZABLE)
+		set_freezable();
 repeat:
 	set_current_state(TASK_IDLE);
 
@@ -2487,7 +2490,7 @@ static int rescuer_thread(void *__rescuer)
 	 * @wq->maydays processing before acting on should_stop so that the
 	 * list is always empty on exit.
 	 */
-	should_stop = kthread_should_stop();
+	should_stop = kthread_freezable_should_stop(NULL);
 
 	/* see whether any pwq is asking for help */
 	raw_spin_lock_irq(&wq_mayday_lock);
-- 
2.25.1

