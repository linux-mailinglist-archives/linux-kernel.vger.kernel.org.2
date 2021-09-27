Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC739419955
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 18:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235516AbhI0Qlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 12:41:36 -0400
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:47412 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235705AbhI0QlE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 12:41:04 -0400
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18RBaCHV003009;
        Mon, 27 Sep 2021 16:39:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=PPS06212021;
 bh=q3+WGhSsP/DZB3jCXRYA9vv/kyaEbaEekWbQSW6WHUk=;
 b=N0wkEhSmMtxygqvYOt6wXiUZ8DRyoSGm25QR0+sJpyX/fLgEOWG4dykE9nhlauG1tRPA
 62bNjlUdd1dZHoewCvHiNSmTh6Lpvll9ygkwSy0gmAv7td9V95mm95GyQ633B5X3DHaR
 PyBQlIm0h//XKhVKxxfAnzt9sfrlfqA+dcv+WZkh/NFo+5kJ1uuH5Fc2xkskbwty6FPJ
 QsE/Ba41xJfnIfrhDSnxQKr6UjL1BtYDawEC6e0zJI338xAdNm+MRsu/rZECBvrpVt6z
 /tzC9Wx3pXYmNhHCmDlcrRGrVDZCCwOrqe6uR3tS4HM9BZ0qS/EyxgokVkfPhW2X6uBn fQ== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0a-0064b401.pphosted.com with ESMTP id 3bbbxh8977-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Sep 2021 16:39:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YR7ZptCeZwXPrlIf6iW3ns8PnG1PFBMX6nh8rZAYJmhs0kh9Fr0IUWs61MP+P7uEGitzKV3mJ+3ofxgLZ8X3VgAfb6z5ihIb1/3fULZejhCgZO+el8fmOWzshbEq6+6JVFRJgkn6VV3jj7EdlrkUiWwrpqt6WKsstK9WZOsNBCaIXuKkZmJHZOTQYXMz1FDK5jITaF3N5X2VXe+JwiSrrZfpm0igWK4ytvokAnvvyq7TTZ1mdx6acxDVAql+RHsFik+pCnv7DJhQGTJ0kmzb0vYap8uMRyLvAdy4/rYIfRg7sDUIc3docz+Hm4n6F00HTd9LKqJWQjB8qQ+t7Csb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=q3+WGhSsP/DZB3jCXRYA9vv/kyaEbaEekWbQSW6WHUk=;
 b=Pev59zYq6KSeELOgtM9Cio0mfhQOzXWKL74Aw65gyvFiQFa/XzbX5FrsvdehAelfprJYhb78LRI5GKcLn3aSls9f1UYBXIHMrcVg9dZxpeXL0FpMMxwdkeGBzHM4U/fF7Q7aI0xh4WOMTSi0j+xbb1ftf0VocJ5cbXGVgwmCtX3jmb2rpvJev+vu/8SUDGNy/+44itNSEbFfNEg1kYrPJIq9I5cI4jsnoUQfGxWYUsxoU2dD/G3ijdt84WORxGZiXKnOClC57rfqaC2Goh7yu3vcrv6k5zrY3U2xDfkuZo2UIgSWcyd8l6DSadeYpVrt6w+HycM1KmDg15qlofBKTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none
 header.from=windriver.com;
Received: from DM8PR11MB5734.namprd11.prod.outlook.com (2603:10b6:8:31::22) by
 DM6PR11MB3593.namprd11.prod.outlook.com (2603:10b6:5:138::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4544.15; Mon, 27 Sep 2021 16:39:15 +0000
Received: from DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5]) by DM8PR11MB5734.namprd11.prod.outlook.com
 ([fe80::51b7:91e3:7c34:57a5%3]) with mapi id 15.20.4544.021; Mon, 27 Sep 2021
 16:39:15 +0000
From:   Yanfei Xu <yanfei.xu@windriver.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] locking/rwsem: fix comments about reader optimistic lock stealing conditions
Date:   Tue, 28 Sep 2021 00:38:46 +0800
Message-Id: <20210927163847.3308333-1-yanfei.xu@windriver.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0064.apcprd03.prod.outlook.com
 (2603:1096:202:17::34) To DM8PR11MB5734.namprd11.prod.outlook.com
 (2603:10b6:8:31::22)
MIME-Version: 1.0
Received: from pek-lpggp1.wrs.com (60.247.85.82) by HK2PR03CA0064.apcprd03.prod.outlook.com (2603:1096:202:17::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.7 via Frontend Transport; Mon, 27 Sep 2021 16:39:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33970dc-3e50-4609-2412-08d981d557b4
X-MS-TrafficTypeDiagnostic: DM6PR11MB3593:
X-Microsoft-Antispam-PRVS: <DM6PR11MB3593409D9C1B694EAF54FE38E4A79@DM6PR11MB3593.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:473;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q+RTHQiwAjS/r2ived4gcpSd4N41BCdCaSkBUaWm8hH0xHsVYYF8ce81HJqaIP67m0btaEMX8qDE7sgVtqvYcRDCytzqNGHne0k2+HLJAA2/8WSxn1yzJKMQkPqu1mawDQ6b8Vc6fIUpIbWK1ErwrqdVfZBO4bW3n+0fmpDM2mncWXlvpNaqACCFOZm2CwUBueIKmkSRJq1ef1VfA4+lV4fHmkv9H01q74y6wyBeR5Nmq+ySP7TNlYRa2fvsvudSqGBVxgYejSzNeXhX2dr1xGisvNwyab1voTNob/XRAOydw3uyNFpxPTyMIEKv1u+0cSxGWRUXAkJG97nisafBRm09oEQePgSRrKUDxWKJnS+c43s48mXXV+2rf5GSqVAzPhRLXTraxbI5+g7b3gEfG0sDODEPHFywC34xbWrLK4WEgh4ahWyVXjAoWh0SFAhmuR+KB0O9zo5itXj/y9CCTxOOfh5xd6UVdRvq3fXDcpAtl3Li7F3/7XLAOi0t2yMfx31wbC5ZJHaV9HMEU77LjQzN36SRBBM15h0nbUTL6y9CzwNYUGGEyOLYUu4inZlGCxupt/nyUY851oKhhmiWLrONRPwS7yWfx14kafuWw2A48RdHlu0T1ugnPegSJ2M2Xm9MJcWOh+jxxNS4AH4OFVHTua6WuZvnHX5BMluGdymgnVHUw8yaJelkWJWzQa20
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(52116002)(44832011)(316002)(6486002)(5660300002)(83380400001)(6512007)(38350700002)(38100700002)(6506007)(36756003)(4326008)(26005)(66556008)(186003)(508600001)(66476007)(6666004)(86362001)(2616005)(2906002)(8936002)(66946007)(956004)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z72fSg1aqEc2XzlAfg2skn9Ywnjh0bmLY23dHe4ThrTHc8IcQN1RtZx8/Tpd?=
 =?us-ascii?Q?co+cocmVT1T3eDwxC3x4ec+/l1kY/uModDkgUIqPB+SKc2umIhjVzcIcj/a4?=
 =?us-ascii?Q?FMvL5WZmbaXkVYktWOTfmjpXWoeeI3ld2VXAcf+CKWdaNhnA7j9ZOguaCN6a?=
 =?us-ascii?Q?K/QwFDwymAUE3kbWpwkjII5ujJAPfTBHoPj30RHrhlRIWTT+gi1vrm+/Iqzi?=
 =?us-ascii?Q?SYHy6fceZXEChsCIPGkZuLmRY2hpzUo9GmN0D07RA320+BnNJxkzVBZcQ+9f?=
 =?us-ascii?Q?JCrAUhkD8XzGHwIDwBejhzP1EKFTcgg8aV8bzgQPx3OsDZVDOzJl6U1Tf3os?=
 =?us-ascii?Q?bu0T5KlP8Rt3VnryahN6zYsgQ2Qt0QYjLn34Z6S5xFJyHs9geqHvqDtJAIi9?=
 =?us-ascii?Q?0txdCJ21DOoFlkRzOX3kWnT04od2nsaE0vVWvt5bHrkr7uAy4aivsPYi/h2O?=
 =?us-ascii?Q?qZsqmgmcJIN5DqcEVKz3YxBgQtgbFes8UE+byuI7dP5/cuIg2rccEAfrNDzk?=
 =?us-ascii?Q?UrwlvSunJDjWjAkHGBSRe4PHcwJwzhiUUGbGM2vPSwyN6xLK0ip+RRuE1Png?=
 =?us-ascii?Q?IEdVrYBxpanPty37/YpcDQ4DBKwLwHuSHVzxDkCkNqt64x1KX/ZlCdk0+clW?=
 =?us-ascii?Q?BTK4IQMJI4d8BWRZYsoJQktG+fLPhDjPbjysOz5LGzGgdj+r8QhvUcx7eKfW?=
 =?us-ascii?Q?1q3OgcMa0CAZKEN74ajnSYrzUvbHUc26rCW7+uQ+qtDZjhRjv+LVp6HjVNCl?=
 =?us-ascii?Q?Gt03tslpIDoDuUvFEZ9jnwTlPytiJ/6ryqU7fmQAtMS6KnkS/8u9CoFmCdZV?=
 =?us-ascii?Q?cQeuPE8uITcDJeyDgfMfM7YqmpQoFaPv1YI6BeLKcOAnbVPm24NGReH2f6/d?=
 =?us-ascii?Q?csjxLPb78XH2v+kinQEpY0Yp1npGaDK4BJ9aSHA1U2QLG5b1ngv0MNi6lVvJ?=
 =?us-ascii?Q?xYh1aWUPGwlcUA9qowg8jQTO4+rvMwllZoSpWqATPm3gWrMsQNZrWIkVpjHw?=
 =?us-ascii?Q?VoRN28QWa8WPkjNJldR6LJgg83AxCdsx/MPsMmt9VyylnJQozKtzXSjfP5jg?=
 =?us-ascii?Q?uc5iiFaA2sMzEvuVeeZOODthghs8WEmf8zItC8l1XH/ILnPwq0iy3L362T5g?=
 =?us-ascii?Q?xmL1FBNRpp+idbgA42j+n3COAgpkEvXlckUVx7+UaGqrwm76wBfQ2Fmpk9Ed?=
 =?us-ascii?Q?eJei92lwixw30VKUZi20Uj7EIhB8uToiQ2Vyyem3dXe5DqR9xR5EzcrmU3IC?=
 =?us-ascii?Q?DW63pStRWF0PMH8CWZ5/EhDD7zZ8yfjodYD/KzdFLMB9Gwqnx19FXCDrtC7Q?=
 =?us-ascii?Q?5gkgyf+NGjSFB+5BDN+LoFh9?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c33970dc-3e50-4609-2412-08d981d557b4
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Sep 2021 16:39:15.2630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUhPTIZHsndTbqzoK7sSG6IjgG7jMVUf1cz6btZdiQooDrPzCezklkU5CljjZY388aGSJOsY9U0OZSXZl+WjBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3593
X-Proofpoint-ORIG-GUID: qr7ImPI4pIaWmI265-JvjBD_Jkg2KYid
X-Proofpoint-GUID: qr7ImPI4pIaWmI265-JvjBD_Jkg2KYid
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-27_06,2021-09-24_02,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 mlxscore=0 mlxlogscore=929 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109270112
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the commit 617f3ef95177 ("locking/rwsem: Remove reader
optimistic spinning"), reader doesn't support optimistic spinning
anymore, there is no need meet the condition which OSQ is empty.

BTW, add an unlikely() for the max reader wakeup check.

Signed-off-by: Yanfei Xu <yanfei.xu@windriver.com>
---
 kernel/locking/rwsem.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 000e8d5a2884..2907f9d8e4a6 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -56,7 +56,6 @@
  *
  * A fast path reader optimistic lock stealing is supported when the rwsem
  * is previously owned by a writer and the following conditions are met:
- *  - OSQ is empty
  *  - rwsem is not currently writer owned
  *  - the handoff isn't set.
  */
@@ -485,7 +484,7 @@ static void rwsem_mark_wake(struct rw_semaphore *sem,
 		/*
 		 * Limit # of readers that can be woken up per wakeup call.
 		 */
-		if (woken >= MAX_READERS_WAKEUP)
+		if (unlikely(woken >= MAX_READERS_WAKEUP))
 			break;
 	}
 
-- 
2.27.0

