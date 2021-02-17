Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 117D531D8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 13:01:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbhBQMAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 07:00:16 -0500
Received: from mail-eopbgr700071.outbound.protection.outlook.com ([40.107.70.71]:36689
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231694AbhBQL7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 06:59:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ISS1dVM7+Csyu8ltnZq1vYLf30CJ4pXd85Vb9F5HR9sH7rQ/IlKyGRT8Acp418R6GOluOplqzFcgJrO/Ydx3eySuMfXodM0jGLEdxGy6yTQXCTzcqLNJeyf1JYE1Oj0G4btX0bSvxT9BD69Gs7eYgvGgED/rgeg2LUe1BJuvOlmHK8KM4sYSMEtKeaVwyNkdi/UydIYQ3Q3rPHcMYBCn5Joj4Ao+EAdPFSREDibTW5fj+07ewSKbrHRZJlYk58XAqQkotlxKzi+xOH2uI9H48nXK6Nf/lLf5H1QbfBNE+ntxYtex59MkUb/EwdV1Z/rXAVV4QgI0VHKjIkV6OLFVmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI5JT2IPPVdiBZLbpqidVtpFz02BVsVfB+4Jj58essM=;
 b=i5wGy0W4GZDTUKJ60wVBfq5w8EiL8YL/EBBVfUwKJtjDqfWqvKD6s0X/d6PkryW5zqWj+jMOYWGZ/hd16ouwrHoTMnFWMX82sy28I4XFnVqQYW6skgbWuHU2o1xGNepFkAQJodJzsFbgV7F3gj9nXRMvc10QgCC/aotcZjpUkWAHRvyzQU77GA2++jMlrtj/c0B57kLrF9lRG4kpNtXYIRzbK0dFsoU0QRRSp2+z2jXCAE5Bp9u9JqXrhrhVqgQGCHJQKZ4lMlr1/7IJ2nXG/mChdKBBvevxLD8ikQbbAyEmfVE0TOWNalymPLo7heMnouIyOvisOQx6cOKJ/zNFtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=windriversystems.onmicrosoft.com;
 s=selector2-windriversystems-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KI5JT2IPPVdiBZLbpqidVtpFz02BVsVfB+4Jj58essM=;
 b=BK8RT3H1dcrOl6vpeo7GNl4ztH1tx5hZTOJKbTmhP76k0GeTcDFM/cDEi2vaST2wPdMZkFR+nkhBMoGOwlVKRLGFprFkcd3Xm+06gVyrQfnvzpYWO1aHCeT2texWZgG3Dir20GSCD/qOQN9bu+w72I6Qnb4+rky/igh2nu19I/A=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=windriver.com;
Received: from BYAPR11MB2632.namprd11.prod.outlook.com (2603:10b6:a02:c4::17)
 by BY5PR11MB4006.namprd11.prod.outlook.com (2603:10b6:a03:188::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.29; Wed, 17 Feb
 2021 11:58:15 +0000
Received: from BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd]) by BYAPR11MB2632.namprd11.prod.outlook.com
 ([fe80::89a3:42c3:6509:4acd%4]) with mapi id 15.20.3784.030; Wed, 17 Feb 2021
 11:58:15 +0000
From:   qiang.zhang@windriver.com
To:     tj@kernel.org, jiangshanlai@gmail.com, htejun@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Remove rcu_read_lock/unlock() in workqueue_congested()
Date:   Wed, 17 Feb 2021 19:58:02 +0800
Message-Id: <20210217115802.49580-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.39.148.242]
X-ClientProxiedBy: HK2PR04CA0076.apcprd04.prod.outlook.com
 (2603:1096:202:15::20) To BYAPR11MB2632.namprd11.prod.outlook.com
 (2603:10b6:a02:c4::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (106.39.148.242) by HK2PR04CA0076.apcprd04.prod.outlook.com (2603:1096:202:15::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 11:58:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 533219c0-329f-4fdb-e60e-08d8d33b4eb6
X-MS-TrafficTypeDiagnostic: BY5PR11MB4006:
X-Microsoft-Antispam-PRVS: <BY5PR11MB4006148BCA370ADEDB525412FF869@BY5PR11MB4006.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:546;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2r52J4n59XX3vGY2V4+IkTkiz9Y0IgLGK5IWpD6IW1YwTO19353Um4L8lNfnnm+3xCSmG87x8ydmyCGAToq1XBIFrwHxEqejTJ2y1rQ4/NwwRIEjRsFWbMmCqW5+4zkvjY4KxQRx+V219hDWhzMkqQZY3mh8Ze4Ci6WZ96azUWYpxuoVKsTiT/Z1aVG2z6Ih1bfqhAzD0uP837D7f5aQYQ+D5o9KP0xB4ITTxCyJ2upRxZz4VHS0OGJtqqo9VoO0v1SGa3Rrct5SAn63X/7LeOk8seaXjdjQFDoyFV1gV/9JvbjYtrN6/SxQ49IAhPq2L0cq8FzRPv0SBa/BnlozEJFzdIfKDn3TS75MIm3aL8O0BIWNOwucq1bB1jIJImKpV9rqIQ0QUxrLp9xVUfR+E1ZG7OS1tuOMlaBYvuK0DSRnSmoog2X6FZd9YtZPAvDtgGBTUdfhBN93YJ6FbOcNFtaBA62Woggrw2xwyBcBSi3vqCTUSPQQrfV0mWX2s4tJZcjT3XRnbi4NCfwIxHey0WwegW21ujAWRE2bR44kTswS4LAqHCHJ47l7IxXdQYw6uh+ZxPr7TlNv1C87Wlhijg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2632.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(396003)(39850400004)(136003)(376002)(8936002)(316002)(478600001)(52116002)(6486002)(2906002)(4326008)(83380400001)(36756003)(69590400012)(9686003)(6512007)(66946007)(4744005)(5660300002)(1076003)(16526019)(66476007)(6506007)(26005)(2616005)(6666004)(186003)(956004)(86362001)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mmEk60io+n/jcDT2q+qfskV9E88IpSk2gYMl3gEftT5lkRJqI9xFnydYqiHI?=
 =?us-ascii?Q?5zq6YSOhKbwiNNwG5fQ2JUHXIvhBjW8sjZEUw+Ihh3juuGGkXk41Mhcfb+jb?=
 =?us-ascii?Q?rTvPo6Se5j0tFB+UVJO6ODhBsxv65HvmgszNEeblfjRSGdpan5N3Mp1aHIen?=
 =?us-ascii?Q?slpvGL0dQ5NwWq6YUjo1aNBs4q4Luv5mGe/3x4PzT3nRjouuy7ueQqqvqjod?=
 =?us-ascii?Q?eEZmce70XDMci0C2IDIUVafOI+55dq4yiF5xGzxFUcbI7vm+ESYJ7u+mPDCx?=
 =?us-ascii?Q?iSnLldEFkRSH2vDyqIB3ZuC8bZ1uq5jDn/GaW7ZE0fr2rnhPjmpANB145cqf?=
 =?us-ascii?Q?8sNgmn/xzyrHzVQTrIzA4nd8rAtZ+kAlFHKEDSJzrl42A/xZejpwwFnCNF8v?=
 =?us-ascii?Q?S+XxlJlditV2draJq5oRRD6gwD759Bc3+QYj0LwrQSM5zjguGV3CHap2lFeo?=
 =?us-ascii?Q?nAJabQa7O8hPCx1PZgrxLAB5jIgcgpxcrEVF2tJCquwmTUzmDeaYpci1PcUj?=
 =?us-ascii?Q?a7hNeTjn6voBJzgXlMTSug2nFDZFBwT9CWxHyRwYbs1iuQ+b7O0CLlfZ+OQx?=
 =?us-ascii?Q?fmYLM28VCS4JCsL+UEahxscAEFIyNZegWDXQC+ek3m9OCvCEELbK1IbM8542?=
 =?us-ascii?Q?u3XS+b79h4EPpCrtQz28fC/DYBc6Ey5COMwt97Bk5L8uYmrVk5x+PapEpIyN?=
 =?us-ascii?Q?RLA29c6UqJQ8LdtudmAnXcYfea5CALz9fzFx6MNwpXpWnrG7H60XWeqziK66?=
 =?us-ascii?Q?GKQ1SrAPnwsK2KmwXZDVadadeB4owSatktffTQkuN09ln9xgOLDiJ1HrSzbf?=
 =?us-ascii?Q?eQP61t7eP5G6/JYyj3fKmv5ELcJckGgilFet1MnBMXU8eNab/yy37Q+lqn6h?=
 =?us-ascii?Q?nqmCdeBvoHmF9HmJvTYwKSnGp5M9NMuQ1NFIzzBkc7oMl+TnjvNfreXfNP8I?=
 =?us-ascii?Q?+XdekwPgGaGDKm6a+X+rof9A/lWs8PBD5xRE22lGGXpg2CNHy9dTFoNODTLm?=
 =?us-ascii?Q?drEaWcdAM4kBYSbP9NJ4QZ1RFu2BBSM9C1Sf8LEJlvC6wGgIOD1iaAbKibej?=
 =?us-ascii?Q?LXuF/ccY5yM//cQ5MPmgVJpIZ50mBahBVO3EcujY3tnOEDs1Rfrgtg632SID?=
 =?us-ascii?Q?aaITGcbrFFSX+DF3iyjB6ovN4gkQFuUpPidLGv98a/VnWldv8xUMUIs0v+8d?=
 =?us-ascii?Q?AFp8OOZ8PsMIQUX7eCaQNA/K97ASCeW7jicbug8rk5Bumn1fKpih0Qkj9GJp?=
 =?us-ascii?Q?CHUUls1Z0NEAttYg7oLTIkEtk4BYo5bxmo9zrJ4SxWq7hMakbhCGXMK7U9P8?=
 =?us-ascii?Q?Ot1CwaGIPwboldVcYnWgg5O+?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 533219c0-329f-4fdb-e60e-08d8d33b4eb6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2632.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 11:58:15.3253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UxVpFZ2IWfa61I2TKXkGTA3Q2SkJpes0X3dKwGsBuoA2hmBHOkPucDO5W1ui7gVZ4fi6KKgkAmFTLttF3W48CcFhAXfSFsPIRMMXntwZjfw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zqiang <qiang.zhang@windriver.com>

The RCU read critical area already by preempt_disable/enable()
(equivalent to rcu_read_lock_sched/unlock_sched()) mark, so remove
rcu_read_lock/unlock().

Signed-off-by: Zqiang <qiang.zhang@windriver.com>
---
 kernel/workqueue.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0d150da252e8..c599835ad6c3 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4540,7 +4540,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 	struct pool_workqueue *pwq;
 	bool ret;
 
-	rcu_read_lock();
 	preempt_disable();
 
 	if (cpu == WORK_CPU_UNBOUND)
@@ -4553,7 +4552,6 @@ bool workqueue_congested(int cpu, struct workqueue_struct *wq)
 
 	ret = !list_empty(&pwq->delayed_works);
 	preempt_enable();
-	rcu_read_unlock();
 
 	return ret;
 }
-- 
2.25.1

