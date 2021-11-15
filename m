Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87CAA44FDB9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 04:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237267AbhKODvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Nov 2021 22:51:37 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:49336 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237073AbhKODsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Nov 2021 22:48:19 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1AF3d73j019732;
        Mon, 15 Nov 2021 03:45:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=PPS06212021;
 bh=r5MZs/osQ2EsdhXSS1rGXpKkYuZbn1Oh3XvfI3qs5yI=;
 b=tAp+G3mlIZzEHZ+45A1L9jjpzErAMmVz7JsNjOaWUuirPGWlT+LTOUya4Po3QS8RRpKP
 81n2xfskp/UiPNSZsfmB19XUyVs1uph7Jw4h7vsOl7Z7pOsVl9RGaQkiLWKXVYUlXXFk
 k/Z6Gzj3wjMH6zrP7CfnNXdSW0XbRWwjESYKfvTLzIVukNMFQOKesxDGbbnuG+uSsHG2
 uF/LRewIoCgvVyFNbN9SsexPZ9g4ECpIKdjbizduh0NA8A+K9Ot9KU4wbHSknH6YcmAN
 5pdom8c27dQP9daC7ShrZPBsxBcFlZSM61VbLWQpdF1Cwo0X5NQh+fvEZRgQ8lNsRoJ4 Sw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ca4b81e95-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Nov 2021 03:45:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5b2J+OxBICSeRW7YcyT0Uht3RSOW0XPw/+V4PjgjwRrHm6VjHsU/O66fuvPfM4n2WpuzJaTllLITJXM313VFeOYRyZ2Ufj2/1Hlpz0UDdm76OXqrfkV7oOewr5Zi41YIahe17I3SxmOwcDRw3q7Kfcif8gqw15HjZtsz5MbZYKGCdtWRVYeIHzLyfrtHV2KVdCMs+88qrJM0KU/96lOel5zpnvaC/Ap48vX3UO+h/1rcD/SlX6cQ1yc5zQm5IlEPt9ha7MYdnhWgKyupdO0pfjzH9aCOWNdyQ8yttmBGy+nze5Of65IIG2w5XqPNOgRuIcQHg/U3ADHzy78jasyxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r5MZs/osQ2EsdhXSS1rGXpKkYuZbn1Oh3XvfI3qs5yI=;
 b=UykWIP9Y2cMmg2nJOelakiEiodO7BMMh6aV+5qgW6r/eobO3598XO1s9JHW31uMPm+WjmtWnhGeLClhYUZk59eGkDMPVGIJaF9zADHOq/OzeolG6zAxVirKEZtWau89O4afKdZod9Esv67w+AxnW+T0Hz0OPzZfnW4+nFzrXfJq3RY5j4Q6Y34bmBsa1AiJvXq5kQUq9lVCSiTG3FXUPCKMmK2zv78g87xzXrAKzvL/O0cNOVLWUJDgLvd4v4aITncHPRVfn6I2Q5j+E1syJdZTpF8pMHAeQEN60xDOrxgY8OLOK9b5Rl6Z9Au7ASfRJaq4n5Rlq/5QqpypJHW5Wzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from PH0PR11MB5191.namprd11.prod.outlook.com (2603:10b6:510:3e::24)
 by PH0PR11MB5048.namprd11.prod.outlook.com (2603:10b6:510:3d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.19; Mon, 15 Nov
 2021 03:45:13 +0000
Received: from PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a]) by PH0PR11MB5191.namprd11.prod.outlook.com
 ([fe80::a090:40db:80ae:f06a%9]) with mapi id 15.20.4690.027; Mon, 15 Nov 2021
 03:45:12 +0000
From:   Meng Li <Meng.Li@windriver.com>
To:     thor.thayer@linux.intel.com, lee.jones@linaro.org, arnd@arndb.de
Cc:     linux-kernel@vger.kernel.org, meng.li@windriver.com
Subject: [PATCH] mfd: altera-sysmgr: enable raw spinlock feature for stratix10 platform
Date:   Mon, 15 Nov 2021 11:44:55 +0800
Message-Id: <20211115034455.19240-1-Meng.Li@windriver.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0083.apcprd04.prod.outlook.com
 (2603:1096:202:15::27) To PH0PR11MB5191.namprd11.prod.outlook.com
 (2603:10b6:510:3e::24)
MIME-Version: 1.0
Received: from pek-mli1-d2.wrs.com (60.247.85.82) by HK2PR04CA0083.apcprd04.prod.outlook.com (2603:1096:202:15::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.26 via Frontend Transport; Mon, 15 Nov 2021 03:45:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c7a2222d-d226-4544-0102-08d9a7ea5437
X-MS-TrafficTypeDiagnostic: PH0PR11MB5048:
X-Microsoft-Antispam-PRVS: <PH0PR11MB50481612EC1952C737019759F1989@PH0PR11MB5048.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ne68m+zZ1ofExjJsAIn3NXno2Im4ODN9qMcBtfLs2BPwMyBEXHSHd0+9c9QM3i0ZJkSAHMut2ZLVf7CpDHYXE6VB6YLYAvwIugVZYFO6Eoo7d/7b8gPF4NUHm+rpF2sBz8EaHH6pTAM5X70N1uOO22j2UVPWeTEpPZ8xMZ94FR+7tpMLJWfRRbqYSREK3P4zZciYwuOozru4ji7eBx2OAri1/KQB74/r81FotktWqyjvUv0E+ehmqUa8ZafdtaU5ERmJXURF85+vDvQg9F1wWQGMWUuvwT0LDrOZDPuOo9xU9j7pGO+d9U+1JS4aa/x1ZjlbhJLiP8wr1mctI9Jly3Ozc2uoXQmz0sMbQJpo6PGUfLpgiOQGfncLWAHCrBXIwyOwc26Ap/4Di82JsPamlc+nWSZecyt+xLE0si01tt/ESv8BSb8kvoYWwbL7e/cZour+norbhsr+QigZ1pLHKg80IdKCGnr4mmrFscD00W/4qaZPZgL01rHXRzGJkcnNhl/9WvNFyf2W/C+u/7BUyLAjhkYHt3j6nSpYdh+q9Fc9kkbkK0EAlM3Tj+lRvwG9ZvqP4ag7s6AWMDn7XjSlQfOu4RMmnXgNMhks5QJWodT2NdXF/hqtip1eIahLmxAGJpiynDBYVcb7cfNkwYF9b164ekB7o0E4jT/eMmvbR6KhNHQz5mRdXH+uWzttZ+wLiudZV+XowQX5PZUO7ZzHoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5191.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(316002)(4326008)(186003)(52116002)(6486002)(6512007)(26005)(5660300002)(38350700002)(38100700002)(508600001)(86362001)(8676002)(956004)(66946007)(36756003)(1076003)(66476007)(2616005)(6666004)(66556008)(2906002)(107886003)(83380400001)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ysdIELAyzgS1W6ZLyteZ7M48I2hhEvOVEZNSU9DZogR7KKQYRNoOuoCzEAKA?=
 =?us-ascii?Q?IJodnAqVEFbkST/GCE10znXT0KuLZOb3od3+sp38CxumvATKBKdJrq1q/ogT?=
 =?us-ascii?Q?KRjsm5uhsDEM0TBrN5UNiWkT++PMkhRLKI4zdfiuyrekc/IQLs+O/a9DmRWJ?=
 =?us-ascii?Q?WPO54wM1whJ67axZYxxAC7er2dt5vRJbhFIBNJK23F5k7Oo3hhw/n6cJ/XpW?=
 =?us-ascii?Q?66DzMth/9nKIsZe0eWaj+cWn8/x/VVPdmIIz5R9A4uz7tPp2hYRY8y/+LmSs?=
 =?us-ascii?Q?MsKkm26mT5AiOL0sF64Tmh3zWazz2khJEYuwU+kDPxbQJp/8CXhRFctnK0jW?=
 =?us-ascii?Q?6HdV5hX1HgOtB+90n1ImyzUhGO3n/MpSMI9KDbf/1QDlgE2hBjmxbKkm3N4S?=
 =?us-ascii?Q?fYO9/RjCFOuIqPBuWWHtyfQfG5o5u/kxDSbV1NwiPfDXPr0FMg/uOb6DrcpX?=
 =?us-ascii?Q?44WX0jJ6ltrbK6WtdUa9HoLKsk83HCreppQvdHsgOm+YMGLOUGNJomWjWYig?=
 =?us-ascii?Q?DNShhuUbaaUKoUBwZUtCmc8Ol20mQcGC9+/2p53Yrcoeg/j8hbHawexhhmuu?=
 =?us-ascii?Q?rgl+DDowVAKGs0FmPaIRtMWPBs0HOji9CzPwUT+s3XVL+CTvxsoyWq1IZj03?=
 =?us-ascii?Q?FveRrbl4oeFvN8rz85pRFU6FCZsHbqrQYEpMEChRSazBijW0wiNzHv3EzC62?=
 =?us-ascii?Q?sY0vrwUUR7nNL6J8Kr06ddSUDvGxGRbL7CMXPZiIwdnctQm9bRpUawRkPMM8?=
 =?us-ascii?Q?SnmXk9GIa+MyeienYYoD546BV2culp716VLJ1+LnnqZIMWh5JXoXZ7Z/3/2j?=
 =?us-ascii?Q?dzgPwdt0dSY+TzEHT4SmIDSaP2A3S0o9MgVVzKqCzziaA0nyFYIGPqkhBLeY?=
 =?us-ascii?Q?9O+J/+xbH6s22HfSU2BhZls7465JzoKvoAR1u8cQzP7DXytWwoBjWnuau/bs?=
 =?us-ascii?Q?kkgUV8Lze5vCwg0nnAkZHZdguocnZPhdVViRvPqzFJj3XNMWIxpqU+nmOEOj?=
 =?us-ascii?Q?I+LoekxAQWMSzEmlLXcoqwM25QKJ/aAWoc4QycxbWC79urPIn8WssLsGACHB?=
 =?us-ascii?Q?lhybHltWy2VzZqGMRvVbpysPZfdnBy8uSNtUX67JTj8ooVlmbX63hAEhGFaj?=
 =?us-ascii?Q?dijr5WpK9CO4CKZVdnLmyfcEx8F1JnGI7lRuA9mqHBBw0EDnVb+5mjnOfO1K?=
 =?us-ascii?Q?fwJ7XyEPUjrBca/x2a5zUjmL+eQkbJH80TlHuQT5FBzY3R/yySODw2jwlDrZ?=
 =?us-ascii?Q?HVi2t4F7NJGyUQpfwjj71z8vn84kefJeXdVNwp3WIJdM6VrfB31Y5uq4nse6?=
 =?us-ascii?Q?Kvyb3TtyLCgy8m0CvLst9HFf7wSo/HU6WodEn1fAsS7EUVAyWeqd5c5vie0n?=
 =?us-ascii?Q?YxoilpcOfDkI0Q5cxxwTotNx80YTCJR2W7qcX/iPyw/GpFSJlHv9Q4OQfLVw?=
 =?us-ascii?Q?EWewN6QGxUsANB9wOy4CEow7grFdOdmvILuMqlH5TrSQghks0vINNz8csNX8?=
 =?us-ascii?Q?d7YFOVSieT+cOu96wfnFgfajWUVNr4wrnFI4tAA3BNgv9mpkt3SMM29jlrTC?=
 =?us-ascii?Q?+wKpmQBiU8nvzBkTKKVhev3JXuxBRA73cfK7SViLjcVObTPVkKS/tQnS9LXn?=
 =?us-ascii?Q?tp/J+Xr6FjAX/eKuClbDHPA=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7a2222d-d226-4544-0102-08d9a7ea5437
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5191.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2021 03:45:12.8554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cS4V1HosTS8czZMnZJqEWuDkT6EvVdQ3QJ0hYxgQubvgexh6Ewi5uJgrwuhjgeBPM5Fin85ioU83X4/cjsanFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5048
X-Proofpoint-GUID: FY0IhUNR9SUm7vaaSHW9Im5INHE_La9R
X-Proofpoint-ORIG-GUID: FY0IhUNR9SUm7vaaSHW9Im5INHE_La9R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-15_02,2021-11-12_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1011 bulkscore=0 mlxlogscore=942 lowpriorityscore=0
 suspectscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111150019
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting up preempt rt kernel on stratix10 platform, there is
below calltrace:
BUG: sleeping function called from invalid context at kernel/locking/rtmutex.c:969
in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 1, name: swapper/0
Preemption disabled at:
[<ffff8000100b25b0>] __setup_irq+0xe0/0x730
CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.10.78-rt54-yocto-preempt-rt #1
Hardware name: SoCFPGA Stratix 10 SoCDK (DT)
Call trace:
......
 ___might_sleep+0x144/0x180
 rt_spin_lock+0x34/0x9c
 regmap_lock_spinlock+0x24/0x40
 regmap_write+0x48/0x84
 a10_eccmgr_irq_unmask+0x34/0x40
 ......
 altr_edac_a10_probe+0x16c/0x2b0
 platform_drv_probe+0x60/0xb4
 ......
 ret_from_fork+0x10/0x38

Because regmap_write is invoked under preemption disabled status, and
might trigger sleep. So, enable raw spinlock feature forcibly.

Fixes: f36e789a1f8d ("mfd: altera-sysmgr: Add SOCFPGA System Manager ")
Cc: stable@vger.kernel.org
Signed-off-by: Meng Li <Meng.Li@windriver.com>
---
 drivers/mfd/altera-sysmgr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mfd/altera-sysmgr.c b/drivers/mfd/altera-sysmgr.c
index 591b300d9095..8aad5bbb13b3 100644
--- a/drivers/mfd/altera-sysmgr.c
+++ b/drivers/mfd/altera-sysmgr.c
@@ -83,6 +83,9 @@ static struct regmap_config altr_sysmgr_regmap_cfg = {
 	.fast_io = true,
 	.use_single_read = true,
 	.use_single_write = true,
+#ifdef CONFIG_PREEMPT_RT
+	.use_raw_spinlock = true,
+#endif
 };
 
 /**
-- 
2.17.1

