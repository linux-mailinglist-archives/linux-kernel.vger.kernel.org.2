Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD21238152D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 04:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbhEOCbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 22:31:48 -0400
Received: from mail-dm6nam10on2053.outbound.protection.outlook.com ([40.107.93.53]:61761
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235657AbhEOCbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 22:31:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OfO3jizKEyfcSo9Kz/kIPxS0RwX+Vukx9aCka98lBK2pSfUGawEX9aw4pvTyEqvo1+ZEr1iSIlqK0qUXkxMzxtD6o6X0CAScr5l85AE/16UTNs136RiI4kMrGO2FycONCuIKNmjkrWv9jo8lsjJtakzZB/JWt6YAOnzm930FVnfzU0DxIijOBJyycyMVEEi2NkmmohroGKvUfDKm2U1JnO8QgfSPW2B8ryB4MVYaL8YXPR2MK5zaluORjR6fkGv6xlYtqnLz8ndoo5JRW+KLIU8h9DoBn+ut49WIrCNieoYcMOVSJaVHPJD/XItsWGYdPs8JCLqhyj3AJR406YQVdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcr/Ahta7KyXR8hYkz0v5fZrI472D2A+teU+2jRvpe4=;
 b=i9hHaznymn3PSBVaK/bApFW4oN8xkS6v4LdN5XiqUS4BiS1gM3bA/dCdJOwGxrRDr4PQb2gLrSMxY+dfpO2Ha4wbKNWj53FfHSK2dv83Z6FWYDvE+yyTs/NwDNovMLU57dyRnW2NqJCPi0d81WCe/vXrc2cw4+YW64J8I7dPubazH37WtRLhan6TOP3ZFZqO01Yu+FDl5A0irCJRwGDsWEpGV7x+vwsllQqpQf0Ac6aGFkaD4b9BSaXB6D+/PN2msdseeHiFpo2kbA5Sx91eNIj1xK+dW5uEoEdsvBnGEiu0XYvGE8awwPwbHnICRmm7/dmazIkO8eMaZ3IQFpUsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fcr/Ahta7KyXR8hYkz0v5fZrI472D2A+teU+2jRvpe4=;
 b=iiru79qewDo/FAhk7pJrCdPtyf5x3ROp0m39TcequpKbGuOSf1kXMy+9SI/boC3v/tT8oquSsOJogVVGsmVYCfim2EhBAOBUsnJ/bN75+FAM5Nh3MDvDqMAgJz6HkbgMiHUNcX2D8FjljGae69QMg4XLA9LH8Xtszw9tEQ+GD4M=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM6PR11MB4202.namprd11.prod.outlook.com (2603:10b6:5:1df::16)
 by DM6PR11MB3420.namprd11.prod.outlook.com (2603:10b6:5:69::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.28; Sat, 15 May
 2021 02:30:32 +0000
Received: from DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274]) by DM6PR11MB4202.namprd11.prod.outlook.com
 ([fe80::60c5:cd78:8edd:d274%5]) with mapi id 15.20.4129.028; Sat, 15 May 2021
 02:30:31 +0000
From:   qiang.zhang@windriver.com
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal
Date:   Sat, 15 May 2021 10:30:10 +0800
Message-Id: <20210515023010.102985-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [240e:304:8181:8460:98c0:7881:2aa3:e507]
X-ClientProxiedBy: HK0PR03CA0099.apcprd03.prod.outlook.com
 (2603:1096:203:b0::15) To DM6PR11MB4202.namprd11.prod.outlook.com
 (2603:10b6:5:1df::16)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (240e:304:8181:8460:98c0:7881:2aa3:e507) by HK0PR03CA0099.apcprd03.prod.outlook.com (2603:1096:203:b0::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend Transport; Sat, 15 May 2021 02:30:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e033bf61-5022-4f09-d322-08d91749691c
X-MS-TrafficTypeDiagnostic: DM6PR11MB3420:
X-Microsoft-Antispam-PRVS: <DM6PR11MB34205025229BA7A48CDF6BFEFF2F9@DM6PR11MB3420.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:33;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGBrZCclrFdxxqvx1zAxeKiIDIP9d4Mm5GWoiNGR1dKEINtZ14pPY55h9Dgq3xbPuCbnSTBOlsoJC3kZOffMJyxta29rUwJFV2vhFAZA26DgUNnwws7hNLLYDkoTApdieyZMcjzO/Cr35msnDFGlMF8Vg3V08VnEvdTDgMZUzJDpGOOJ9LLQ231tF4rDzZ88y1QLlpWBC/iN+r357a34CnLt5baV2oxdIj34eTpgZJH1xM196YukMqE7MfX5sRJeDwr2bbf1gho06n66PJCR0SU66LK/6V2AjJyc9hnaKDV7IaN/QIHSv1kTnkYJJ501P/4J6WZiXEVi/kKAkyKX/PLNiekk6ScUtHkqDUHGZd662Xoqyt6zy+Bs2blu4iH78YHcJQqS547YGnPbdJSwDwigpKvP47B4mh0fW4IUzjDgAG7eQbEB41Hxzlw2JZdiCqgCWK8+MOSbZlr17iDev0qrG3bd3P+EgYZtIOONIV8cy0O1POt8e4iF4A0vIyD8UGE54ySmP4fzlq3mlI0w0P/vr/OVGNasobtShmIzPoTm8OFd8515ewiAZi8iCs6PpyxzNAxpGcOl/Ug2DEkzIIgUEX0di2BF6ctvni3DGZsWFo7+jW4p/7iNlO0pHKu6bUyR9gKyNWrc13fPGzC1DQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4202.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39840400004)(346002)(366004)(4744005)(186003)(16526019)(4326008)(1076003)(316002)(2616005)(2906002)(478600001)(6486002)(6506007)(66946007)(5660300002)(66476007)(66556008)(8936002)(6666004)(8676002)(36756003)(6512007)(9686003)(83380400001)(38100700002)(86362001)(52116002)(69590400013);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?FTSnB6ylv0vRNL/sYfXw5M9nStcGeHDg6E6CG/SapnQ7QkxdbR+j+VXNx3Ho?=
 =?us-ascii?Q?O4+zt0XlYN34/K0y7c/OdKdcR/aV7G7p8rkAiSyuGHT2OwZVkvvFYRWw4VXF?=
 =?us-ascii?Q?mB4uIhd0wMfg4O6hs/TT1PBUdawwBFPAfriS5iMOOeVNMIDMVaepYvT0F+Mw?=
 =?us-ascii?Q?aqW4KzqG9QVpqM9zvGEN9TeK0BiNJSMB9S9Zgni916SBfKBMOVackNlAs0Ws?=
 =?us-ascii?Q?/AQkr4plsXCKB9pyuhbzOVrVbvIKpSTmsVU+AQWrUlQuiJRfpSSs8etrLIYQ?=
 =?us-ascii?Q?5Mt1rLSvBRARSdcOpgx0/KqNqjWw/cO3K/dfcOGhzR/JbxGGfVMUs6S5Ozba?=
 =?us-ascii?Q?PhDqo7jKag7iNEXMpcwAQTI3GBZpq6OosWoTY1AsabNCqnJmNNtmzrfEDN3z?=
 =?us-ascii?Q?03AreBbkgJ8EeKZRI0LSzow+mz/mXSlE80h5B5iSbUuXIf0gMsMouOpSqyMn?=
 =?us-ascii?Q?VF4kzhF1T4JQq+h6rIQcFcIa6PTN4jYLSWCEhhaPQXGuI/3VxCzTxLn4rIAC?=
 =?us-ascii?Q?q0icd+pab4ilUe8RJbLgIpEl0+YdMSS10+YsLGxX+ZhzDBYviAIjk54UpHF+?=
 =?us-ascii?Q?IBRD8I4XQhcw1BqjLIgKBvQ2LgJLD0ubM87bzcLPGobzmExx0doSSurgiBQn?=
 =?us-ascii?Q?Hlqwc5xOzJa806txvkUtGErYZzjQtz34RLhMjB1EyjhtdYe52t9ki3xQQD/u?=
 =?us-ascii?Q?czpQyHnUu1Szp8lN2N//e/0sK6my9/GPlMvr6JfHHiduCLA+Hy/WQztIG0bm?=
 =?us-ascii?Q?HRos1DeDF8HWRtU/hdgTuqTHR1fDgV4EMSp8KFYfls0WDZgMSyD1hbg+mcs+?=
 =?us-ascii?Q?9yNVqmbcPwYxmtJVVqNj5xdyK/zTQbY8HzPGA42gc3ieEe2194CYNbpEEUfF?=
 =?us-ascii?Q?fWHZB+Ogm1u+WdEDU8xOKfaqWQb6apUVA9H9fJBj/gc7nBe/vExdmzGrN5sM?=
 =?us-ascii?Q?zigNn1sfuR+1JorjWI63s2WI9vBjlvPDucxsn3k3/MSGYXBO6M4bfnT2dC0+?=
 =?us-ascii?Q?FKGPZk64MgilZm3mpTylzfo9ZvpfeArwO46P8U4xoYL3qwiTy5NU8NsM0osy?=
 =?us-ascii?Q?jBH8rk2aK8V20zEdmiUnIJ2X26lWAph1YB9yHlKH8gjlHo6x0DXquEemIQMC?=
 =?us-ascii?Q?Gnn9smlsQZif/NTMPftBUn2jUHA83HVUxGYOvkDWvYINWhVxyIxTjuX9vmrU?=
 =?us-ascii?Q?jrZQ0HbTh+zwwQwjU75g29PQvhwZYWdlvJlFod8klY8JxsV6GQfTuzzef5bC?=
 =?us-ascii?Q?CDqR5zRCI4LEbJADlg/6WUw97j4s5gd4jXfRRSBkltsIKMqdCowBg1GDcAP4?=
 =?us-ascii?Q?F/2+vTREQ9oGTKhApnd+GFRI+3XYpdYVAj2QypCaS17Sc3xScnOk1XPb5HiY?=
 =?us-ascii?Q?BoPWD4mI4cUPvXrUDRgeMicvmXWu?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e033bf61-5022-4f09-d322-08d91749691c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4202.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2021 02:30:31.7801
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RK2q1zF17CEAoE9LRHdqnaHX1SHNNJS94LPG2i+T7+2pvY5RhsJl6Di9jHFxD/2PiiSqj7v59UKUVyXDt43GwqCS9w+juXnxF6DandEiyh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

Clear MUTEX_FLAGS when call mutex_lock_interruptible()
interrupted by a signal and the lock->wait_list is empty.

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/locking/mutex.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cb6b112ce155..4ac354ca092b 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -1081,6 +1081,8 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 err:
 	__set_current_state(TASK_RUNNING);
 	mutex_remove_waiter(lock, &waiter, current);
+	if (likely(list_empty(&lock->wait_list)))
+		__mutex_clear_flag(lock, MUTEX_FLAGS);
 err_early_kill:
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
-- 
2.25.1

