Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0A5333362C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 08:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhCJHKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 02:10:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:53896 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbhCJHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 02:10:05 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12A6opWB096739;
        Wed, 10 Mar 2021 07:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=1ePyXECUX+pVcAqbGJM1xIH3KLP3cSv+eNMs4PCcHxU=;
 b=VI/gt0jhhfAdrnuxomHdVCINvOYGi05F+9KMeRFxMEbWKOCiC+gjDrFxVL9txOiv5Qpl
 mGK+rsrUZy+O5tsn9BRYuVZ37aSIL0LCGDvDTncd8DluVsIXSqwkloU72YjsFwDmpjsC
 JN6lt4o9wC1iijvHy2HeeWgBHZ1IDRqvPgWNmTo9hRKAqvuOOLVBSwKyOohZnk8pfGsY
 mPvx4/7J3Wpa8Hg1DElJFcHZwsKBmLtkhVojHenM8NXeQAz3RNbsB3z1u3f64Ad0I8P7
 keak0soeBxrnqotfAGfo0oVQj10pbhVD3//7q3E+DhVgRCD7RnlUz9jYmM2on7Co/VXz zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 37415r9xmt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 07:09:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12A6p5dH109555;
        Wed, 10 Mar 2021 07:09:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by userp3020.oracle.com with ESMTP id 374kgsx7fa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 07:09:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dQ14cFphLVI6hGFYf1Ss6mDFy7QHzwGF7QdOV1gWcMUk/YU5yVAlxhrg9j40+8CQ5uWAKCrTc7rwvNvHaW5wynfAiu85WyfJCeCKL0vdqcQsHfFelX7ccqQoo/Yrl1mG1ow3xt5IyBiAiJbLQmS5gsWIwiAqNZJQQRsQcJ/HQ++GVScfd1lv/CEJ5Es9/Qv0jHLkr+Z/rjIx+k5s1n5TGBA/910i90Z/9QW88e61rM3vvfzTG88wi9yNf0DO7rxN4ypiYabxhcSkt19xxpL5qpn+im482Kn2NFiKoNqt4GEq8xMDJyWrSMX3dpTk1FjttwH9THEIkkXZrzg8P7VLbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ePyXECUX+pVcAqbGJM1xIH3KLP3cSv+eNMs4PCcHxU=;
 b=anfiEu2UtXnDD9SPcGvNAby3Pn2Y8/dW8+LfZOPb4juTMTDVaFoazrAPxJFxn9G/V/yGlgB9vpQHQm8M3egGUDJSlISrEHErora1eGLQfCdwNYfDu0CblGw7NaWci7TLOOddXhvo3mQaEhyft+2fDLDkh3QE50rKUswWSmv7OFoWPygKvwqgma4Ba/3bwBck9UA/mUl5zxIPeVCZX8CCHeRxoJO9JvN+O43ROiERijI6MgdBZ6MLoLvgZVBHWntcMNEpQS0gEBHjThD0iAz2K+FZcExH+XfkI+klCq9TelWDEdFxFt/JHg4bleexe2YRkkN28ulUukA3mFgVW/0CVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ePyXECUX+pVcAqbGJM1xIH3KLP3cSv+eNMs4PCcHxU=;
 b=z3kLLoIqCmA0UYpqA77+ReuSPzv8gSaE8XL2dj/krryKaIAPYHMfxPSo3pV4ADck9HS2ecSFwRrsgQ3RhGr8IjyEKZKxLI59TWU3k17MHNC6prCuR/nJmQaJxVlSszluEbQOBQ74tHrRB0K2wPONcrMjRsQsmU7iuL//8ufMVVs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by BY5PR10MB4211.namprd10.prod.outlook.com (2603:10b6:a03:20c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 07:09:14 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::44f7:1d8f:cc50:48ad%6]) with mapi id 15.20.3912.027; Wed, 10 Mar 2021
 07:09:14 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, qais.yousef@arm.com, peterz@infradead.org,
        mpe@ellerman.id.au, aneesh.kumar@linux.ibm.com, ethp@qq.com,
        npiggin@gmail.com, joe.jin@oracle.com, dongli.zhang@oracle.com
Subject: [PATCH RFC 1/1] kernel/cpu: to track which CPUHP callback is failed
Date:   Tue,  9 Mar 2021 23:08:37 -0800
Message-Id: <20210310070837.17674-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [138.3.200.16]
X-ClientProxiedBy: CY4PR1101CA0013.namprd11.prod.outlook.com
 (2603:10b6:910:15::23) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (138.3.200.16) by CY4PR1101CA0013.namprd11.prod.outlook.com (2603:10b6:910:15::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 07:09:13 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07788d35-bb33-4dfd-d825-08d8e393695b
X-MS-TrafficTypeDiagnostic: BY5PR10MB4211:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB4211B1F13EF026B953658A2CF0919@BY5PR10MB4211.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7t9fkFxrqMGFWL9/44qmcFzvuZAD7v3peCa0EmJZVYPQ1unfRC+nmn0172vzT+S4IR0Jd/5OaXwi2y2eaf1/zWDrdJUj2DVOskGdXs7MLG+b98ZLOQ4eZ2ArnYDXkZGh1heDTCnF0nfTnuC9wnR2u026RCeGlhQ5jhwYcrLpe0rkciVNgTWY4QNWaMaNAQ6Bkf0UTH+M7Uh7Oot88Z/7T2et8B410zA3Vkl3wW4P2Xyen2EUB7JwL0LjEPFVG6g0DHG7NPRgPYJE5ZoEbfkhxQXsFUkTs4aF658933TVYynqWKxAXPenzy+YZE0Iz+IUxSYYuSRIvWpDmSJ1Mqo/64WKCXw7TQ+XIaRmxEfThxVxWCSL6wMUVqluRKXxzo6AL8tLPDp0e3e+v2o2fXelBRuprwnw4wPpRgsRPdwoNymib03NZXrQd+SVVlSYVJpROgCZkrZFaz3rgcH3thtcQ7qVEOXT/IK/Y3Klq6YlujYvh9N7xLCL2vau2ElyVVtKprxFM/7Qv7szEhS0ukjNEmmpDXY3ErzRJu/5pmg7MQemkd3sLnL131uYyYrz1SqOz+7eb6Rm3+ZJ9fxgqNgF0w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(366004)(136003)(376002)(39850400004)(186003)(6666004)(5660300002)(16526019)(26005)(4326008)(44832011)(36756003)(6486002)(6506007)(6512007)(316002)(86362001)(107886003)(8936002)(69590400012)(83380400001)(6916009)(52116002)(1076003)(66556008)(8676002)(66946007)(478600001)(956004)(66476007)(2616005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?sb+G3l1NtxnxBFznwtZzvNc2A81yN2XWPbVili9J9TGS4slYepqzRElxfmxB?=
 =?us-ascii?Q?9MubhGgNNfAwLkpZ7KRD4xtUZgWos0ZYkm/1Lvp9MJtHfGGytXcXNfSLF79B?=
 =?us-ascii?Q?6Q+K2USJtdB5L46vtQk6uPfKTZBtHJ6xa62kd7pgp9OwI5Klh5Q6EgNDkZ+5?=
 =?us-ascii?Q?pVrJ1s1f5KQXCURBALtrg5+1wDAE8cfgKLn06Y0sbsWObUXRorJtUeMicxd+?=
 =?us-ascii?Q?jrO+hHjf+zsX1JtiuJphCzSBSBCSv4yh5PZHoTtVs3pxMdbqhop0UhvWT7OA?=
 =?us-ascii?Q?xzfxTmKsLjMxAtX+lhOOTKQ4xjhZEqB7iu0Hn4Hj7ilWsCCMB1PrjF4pgkMI?=
 =?us-ascii?Q?vjsMeq/XvefSbCt1J/IIlKnS7SxJP2srzaLMhJ+BHXseXQxb0QfBNF1FAuDu?=
 =?us-ascii?Q?0tzBXzfSsW0ZuvvzUkgcJUOjaY2hzR8njIZmL7fivcAXCGT+RfXZ71kD07HW?=
 =?us-ascii?Q?XxaelwW3qK6eh85whpJRDvvdvsaBBVyFYOsGArxfkoJKWr3QG+uGKNJeg8Kf?=
 =?us-ascii?Q?JezyQZuJioNiWgP23uAq7ek2n6cXZ9ZdeBf0R2lsXqw0liLbfKvA1B3SSCm3?=
 =?us-ascii?Q?ViiLkYtbzPeeeNsWmQZma3vI4iJLJ36NidopiKiusPS0zc/2/jpfQOuDj/Q+?=
 =?us-ascii?Q?VvyrOMHbDGlw4VVxS/FTbUBXG65XT4n8ZJtGIVO6wR/sNQwqyh/4Hmo6/08V?=
 =?us-ascii?Q?xJxHl6UuQU/hqKKELeX2fdsS0gNhw+TovFgbsULXFuGFQHgZryuE8Hh8SGTX?=
 =?us-ascii?Q?uE+TFWiPybtZT/43Mk32Tlso8rlPU/LY9mONudlxjj3iQMHs9pss2UtDKrJ4?=
 =?us-ascii?Q?zu/AV4fOm4oomIrGiclwBF6yKcCPYV9nanoIl/g7gOw6DFCoz6lsVDMP4P0w?=
 =?us-ascii?Q?clsW7IVswmG4Zcau+/JX22NazD1K06kJn05cJUaUB0BcX218yDQvuKK8s3aq?=
 =?us-ascii?Q?JAHXOGwQYCog06ZaGw8jJHiGVGtMXvV3FF+kI7efl+ycOg9I2i2N2thWB0P2?=
 =?us-ascii?Q?d2tbvPYdKkeIPtiScPgr+ajeWVQ483FQu6fAeswgljbS0NLxx/szo3wdiFLE?=
 =?us-ascii?Q?MSFDKpWIqptm1KP6gWJTCKAig0ziAQobsqPT/dlSjoeXLH0BYUQMgTfDqIHW?=
 =?us-ascii?Q?Kj5URShnMEj4bGejuU0Cu3ji/OHQBPB5jSjiNEFk4EQ5RCnMflcasUglFqdE?=
 =?us-ascii?Q?m7tED9kOkQNWwMqHSPrJWbg3wm52fSwiw/vu0luXH1bHEVkcZEt3q+lPOdbR?=
 =?us-ascii?Q?mF2E21jUVEOWEbVRlsA10y0kBNGnKILRpy6E4cD2dNQjUsnQnO1TRnyaHCh5?=
 =?us-ascii?Q?EitMwJ8kxaln18p2B2AabA3C?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07788d35-bb33-4dfd-d825-08d8e393695b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 07:09:14.2458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQkuYyC18J/qHFTEXa4J9v1MQm0GiCIX9yms1cKuEP7ldpii6nz4CwDa3peL2wazaNUCylW/1NMEoV/5sQihUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4211
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2103100033
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9918 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 adultscore=0
 phishscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100033
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During bootup or cpu hotplug, the cpuhp_up_callbacks() calls many CPUHP
callbacks (e.g., perf, mm, workqueue, RCU, kvmclock and more) for each
cpu to online. It may roll back to its previous state if any of
callbacks is failed. As a result, the user will not be able to know
which callback is failed and usually the only symptom is cpu online
failure.

The error log is printed for once to have confirm which callback is
failed.

Cc: Joe Jin <joe.jin@oracle.com>
Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
I used 'RFC' because WARN_ON_ONCE() is always used for the result from
cpuhp_invoke_callback(). I would prefer to get feedback from
maintainers/reviewers. Here I prefer to print the cpuhp name and state
value to help confirm the specific callback that is failed.

 kernel/cpu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 1b6302ecbabe..c7a719079272 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -621,6 +621,10 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 		st->state++;
 		ret = cpuhp_invoke_callback(cpu, st->state, true, NULL, NULL);
 		if (ret) {
+			pr_err_once("CPUHP callback failure (%d) for cpu %u at %s (%d)\n",
+				    ret, cpu, cpuhp_get_step(st->state)->name,
+				    st->state);
+
 			if (can_rollback_cpu(st)) {
 				st->target = prev_state;
 				undo_cpu_up(cpu, st);
-- 
2.17.1

