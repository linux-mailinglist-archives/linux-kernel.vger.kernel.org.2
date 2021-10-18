Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632344318BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 14:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231659AbhJRMSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 08:18:35 -0400
Received: from mail-eopbgr1300094.outbound.protection.outlook.com ([40.107.130.94]:60576
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229833AbhJRMSc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 08:18:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=geB7/Boa9YMqjUAPno1FPH0+WBRTv3H73vB6ixzrTu8IYtVxSUcoV4u+0R7BVXfUl4GPGvZpdb7Edr7DnG6WhkbUFNwN8dz/csQaukT0pSUEwdEe0XwuDFnjMPzMs+EOHeYh2eO04R5eGZOuSxO26Aym2Cgmp50YBpNpCAqLSeOvJsSFA4gYXYN0Hugbk8fIBDtsGKJr3rU8IwTbXinG0s7r+VW4HQmF/J1K4H5CS+mqf2RxBJ/YhfgMvzQx1FCbkRil5j7SXCGLpHZOOeYy8M6sral/8yWHJ5SbGkemD5jivFKPvCjkjLKuEYnudPKiIA0W57rTpLCuJ225Aud9Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6EzZX8lLtQUsCxvJ81i9ESFb68DjEE5LnEW2IKfsxI=;
 b=f05UAUwvVAsEYzmufCKEowyd3KDDmEKWtcjhYGMx2+7kp34Vzvda+4lHEo+sBWUY6nX2ygR1QBYXa1/mF57ZQ9F99WCQxC6N8VFlqdnRfcMQruxoE0QmjstQnfwA5JFbTO3RLmnP/XWitv2reKD6etExZJyCZ5AuMnLeeiyYmpsRT0gSOsnzZ0wYOo5sx2JwgvGWvkRsgIlTlamapYOlU21LoUAk8dzHlDBpZaB8Y7I0VtfrvYWCshYEEB7/NowU8sA8DrGhbLmc9/lrsbLxPHDf9I+M5cdtEM8KfkQ5yMZAmF2yqrsUhmgIOqipCgerl7CBVzn/Aj7vo1UUc11t4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6EzZX8lLtQUsCxvJ81i9ESFb68DjEE5LnEW2IKfsxI=;
 b=URfqMCAMw8iGy4gmDCA6GaJ8D/Svd93ZZxHC0vcLfImvhbUkimQPQ3UQoic33PzkI9MsrEXWPuFtuJApd/p3vBv2HzGE42ceMG8qVX7mpHJYSJpfZ3PBq3y5BvXFDB82xQFMR+ncjQWcFkpZdgxdztnzUmo1FL0QG3dTHflxSgs=
Authentication-Results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2123.apcprd06.prod.outlook.com (2603:1096:4:e::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4587.20; Mon, 18 Oct 2021 12:16:17 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::fc12:4e1b:cc77:6c0%6]) with mapi id 15.20.4608.018; Mon, 18 Oct 2021
 12:16:17 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kael_w@yeah.net, Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] hwmon: (tmp421) Add of_node_put() before return
Date:   Mon, 18 Oct 2021 08:15:37 -0400
Message-Id: <20211018121538.16482-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0061.apcprd04.prod.outlook.com
 (2603:1096:202:14::29) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
Received: from localhost.localdomain (218.213.202.190) by HK2PR04CA0061.apcprd04.prod.outlook.com (2603:1096:202:14::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.16 via Frontend Transport; Mon, 18 Oct 2021 12:16:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 127a649c-3642-4602-cd00-08d9923115d2
X-MS-TrafficTypeDiagnostic: SG2PR06MB2123:
X-Microsoft-Antispam-PRVS: <SG2PR06MB2123691B424065B3997A463BABBC9@SG2PR06MB2123.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCm9Ad+qoyLbhsdtkvuTNx5f5Ge2D/59yDco6Nehf5WFyMKFVVWF9h4nr9tmVVaG4IhJvOut4hXxVJuAcc2gx0QvVQ8VXq92EdTDDQRWfnrS6L4Z3Hu9CyeoK8ExAa3PpK+QkORpYK22m9oQnbIlknUN4M9WnMjQBRzRmXDho7Fpn4YEsuh+myn4pNUUmisJ9phQFJYLbF3zHzSb3w3GjywJkLHOVBtaKH47WILmsegGl16fV07HQf4oL/cTUgUVRKR6KRgV+NRsdBcZY7r4MFURVBaoKCoYQTb/ahnflbEiKAlIqmFN5vL4BrwWQUDBv2pu878p2PS6JSx++0tQ1qfz74Sb5bcFBq/S3QJl2gzYX8vUwu+Q8wA58ihSFnBqaEaEqCe3+Lu+uirJhO71+1clGs5lXXwGHhT2Ru25BS0KGoHMNlNApipTPXVB8kdUp8XWetjoiUXiHWkN8xec71DS4lQaZ+pMphhBoP4g1fYvD+E2vzbz5m94IdELZR7Uzg2fFc0ZKPYDNvuS9H9tvQKc0bAVh7XGNwjQRzovKllsnqYuKrzAPCoJaDZaInMyZAc4ExwiEBBxVZwH76FKqNu2+7hpfF1qHj0RU7ldYVGrRUceki5ONkYQ9RbyKJzEd1cFzRVqLscSKAWH9LcqCpFZjbn9fBC1+1EqePgHf5SPSb/bOyMM68wVjo1fqgJ0GJEWkzRqfoDxIgzMU9lx8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6512007)(186003)(38100700002)(6506007)(4326008)(36756003)(4744005)(86362001)(1076003)(2906002)(52116002)(5660300002)(6666004)(508600001)(6486002)(83380400001)(956004)(8676002)(66946007)(38350700002)(8936002)(107886003)(26005)(2616005)(110136005)(66476007)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S2EdTVMfQpvtGWh20vwugMu8jzFwmTh0J35cFw/ZNuaXumEwvPvZgWCnP5Re?=
 =?us-ascii?Q?3A6mtPjpEokAUPfQfRc++K7ATzP/WvpxN9+80li3Zet+fN+hdsOyZn0u//fS?=
 =?us-ascii?Q?iMMLHe1gl1wk8JYUp+azuHd3KHQBICDLWkCGzp0Baia+ec8VLNg8NWTdXajl?=
 =?us-ascii?Q?sqyewLGJh4sU/pAmsj6InI7xkVdJaHSrZaX3lcdRuJ40yNNPvJ1PiXFrHt/F?=
 =?us-ascii?Q?JpL1aEyEM/ZeKB1IRYAkWVFv892pi7XUamXCwpXMhcf+Frqags/eLRYD594R?=
 =?us-ascii?Q?WaXceAWZv18wK6mGSbgi4XKjcxL1zuxT4RDXoLnEVuLumLyyIFgM3TUEQjFX?=
 =?us-ascii?Q?A7O4VbI1u/7b4gVglJesRN1JQo8VZghyCGiGABQEkbnvMFxIkF3V4IyG3BEq?=
 =?us-ascii?Q?LMS6cOh5ylIceU6qoTiyoGOYWP5lYMTLyYv38mxJ++f9OQXoM0hZBrDPnJyK?=
 =?us-ascii?Q?xLh2DPaLQMz2gscBUKZ97+nJ0nUqYl4K0KA9Bi6Fo8+X+vVdRT5jnAdEKBzt?=
 =?us-ascii?Q?6RwYQBuzaPFzthtlc6G3hOD9s7Yq1KE5KYV9czxYE8wAynL57WYEWW334loI?=
 =?us-ascii?Q?D6tcksA/J5uIGB8b2Lo1joDFFwCAvr95/Wml9bw+WZHYJ0d6RNd3S2rr716Y?=
 =?us-ascii?Q?mk1O908dkcLD/ebMceqEvwbPs5TyljSy3/6SclNBP5UW1XyepwA1rGUNUslW?=
 =?us-ascii?Q?rWpF1lczxv8NCLfZkdFSsNB0QxQ4KO1plFEAy6hTcYURjvTmNgsboULwFQzL?=
 =?us-ascii?Q?gNLuhCRD1GzixbWryZP8UXNFwO5S9TnT9nlE1G8FcpClCJWRBbZH9Z2w0djr?=
 =?us-ascii?Q?RXAm7V2KCMSTT/escp0Me/5lLmf+dFK8ryDBHAuAiQk/Icg94Sl6kIisfkBo?=
 =?us-ascii?Q?DYV2DcP/txquZTHMJkMWYXHBcUdlfy111dt6sJj44YPrU14RoM+cXhdX9GfR?=
 =?us-ascii?Q?8VIu/pmrGqovjZ1VVL4ckgY93X4pQVWJf4Rdh+NJoHgrIjzTTdkhVIuolpVJ?=
 =?us-ascii?Q?56UUvRE5iEJd7k3xZyGAkBq4MrvMUZ1dUJU5k+QMU48C4PhR7CoagS4Ly77h?=
 =?us-ascii?Q?uxtdOrXt2edNDKMEmuGm7M29oGdBd78Xsh+Kg3bilv/PV6FcAFAvytLFGndG?=
 =?us-ascii?Q?dWgkml0O5dvHO0KQdyOl6WFZ+JcCX6KavrKW4o0/7ImwY+1SkloArDH1wxDL?=
 =?us-ascii?Q?5DgW8Kaukjw71KjGPA9UGKaetSCzLod+fwmvE0jmJj6SX246hpEgXwWNqT3s?=
 =?us-ascii?Q?wrpdI6mxAD6c1KIiWZMSgREYDPC1MPpp81qJXdOSBx8kFCoSIid1KHx0b3k3?=
 =?us-ascii?Q?ynPEWsmIrev7RjFz/cOQ6qNY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 127a649c-3642-4602-cd00-08d9923115d2
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2021 12:16:17.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GJupaujZ0RBa8IdVRRBAQ5s8ZoORCCqh8sYZf3qOH9JFlP14pZ7vI43TJiD2jLSDWP9fgH/q5QjPTjwpqY4Hhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2123
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/hwmon/tmp421.c:416:1-23: WARNING: Function
for_each_child_of_node should have of_node_put() before return.

Early exits from for_each_child_of_node should decrement the
node reference counter.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/hwmon/tmp421.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/tmp421.c b/drivers/hwmon/tmp421.c
index 31e95b5749c8..1fd8d41d90c8 100644
--- a/drivers/hwmon/tmp421.c
+++ b/drivers/hwmon/tmp421.c
@@ -418,8 +418,10 @@ static int tmp421_probe_from_dt(struct i2c_client *client, struct tmp421_data *d
 			continue;
 
 		err = tmp421_probe_child_from_dt(client, child, data);
-		if (err)
+		if (err) {
+			of_node_put(child);
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.20.1

