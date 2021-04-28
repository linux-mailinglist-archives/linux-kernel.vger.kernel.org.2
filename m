Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0C3F36DBFD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhD1PjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:01 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:4566 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240152AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM7Fi009825;
        Wed, 28 Apr 2021 15:35:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=vKBjDwwfDNF4cdU2AQHzLUVUSQ2ozrhHMyCF8FbW6RE=;
 b=MGUMPRkMLFjqeR5yzWuBz81bzFrcRmJOxeuh3jv8B/RalTumYLdPKahgRygN3wqxlPLA
 ZadIIWRYaBexbCtgLc5DYGZvOLyONvMySHXNibFu2tsFR11BYO5VKZUQSwt+39g49sq1
 24KULgWzCUHUZN+2pfdH76Sx2IAwR+cG6cRzAb87G4PSsia2M/tD4lMzcieO/a013mzx
 a+pfyoqkdvdgLuhueKPfY7iis/hWAr5Fvv546JIC1X82HMiuG4rVVWI9pg5+KahyM4sG
 8IR/FuUymm4hgnQ1S1cmCX+oqdJLmS/FOqovXosQ3kFc1nmUwGL50vW+QV/2Pf7tJ7jM GQ== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105xq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:59 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFRrsT124479;
        Wed, 28 Apr 2021 15:35:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by userp3030.oracle.com with ESMTP id 3848eyqwaq-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iu0CTWDOr7SFQKN2wuu+nC4OG6f9zDIq9GKVw7iqAyV+t7oKYiwjy2jPS3o2zTsMk3f+TRyH45RBqKs5skbB2NHeIPxR25Ie8sfEucgBODmnAGxgI/u/lu/30rxTDMxHed09/gYoQqTJ03GUpaTVQ6p63f80lJRIX5waf7Hs+g9ZHHwzs4JhoDIn9rA10LI677nXE3YES2zCjGz053g/oQNuYVCtK6sMzBaNOU5W3Gb0qkL41nG6QgyrHTSX/6zGcqC8FEkBRCs1UWOgvezga82kiADp+Jf2WkQdVcaqcFA/yuBKyRf+DPYDO63nLHjBAOm5NLf+OVYhAvDsHN1NrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKBjDwwfDNF4cdU2AQHzLUVUSQ2ozrhHMyCF8FbW6RE=;
 b=iIqpjeInxDc8anG/K5qy/WS/eiVMJWAVJYznM5/+R7eaC7MaclDNpq5c9A8PTHfDWxN+DAweESLfxAARopuyScIYewXozeSrU8JdPDXe7snwmTpwwgScpRZhtpA3Zl/CF0si1bXxpVZAfmRl7nsmh/2jkZW0qUFmmOTrdDkCuN52kmCcMfxRTukp5BMAUKpGv2vYW7S8iiTdnnOj3+n62PGZ+fqUycr7sdxKoG78UYAvCwRq+574MeCWMWm2fgVEVQXLsMaq6JMiXudbQsUUmREcnT2INQwtLBsJZyBj4L1L7X8wYOOk1rxJEochfy+pvqDqunpjiWAuQjw72VYCeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKBjDwwfDNF4cdU2AQHzLUVUSQ2ozrhHMyCF8FbW6RE=;
 b=DQsDPM7oaUZwlHjUj2PQs6jtglvInTRnsht4g4sGZQpXg51cZnQV0mERIoLTNMoWQdBwPGIWpntLXL9f30jFIC2e04zK2/h6gnaHoAb95veiHy8NsaRMFhPtyUo0ICxQN8Y8rq6e5JwyLWv7PerqfKcxUztU1J0c0j/MrlfdXcI=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4769.namprd10.prod.outlook.com (2603:10b6:303:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:35:55 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:55 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <walken.cr@gmail.com>,
        Liam Howlett <liam.howlett@oracle.com>
Subject: [PATCH 22/94] radix tree test suite: Add support for fallthrough
 attribute
Thread-Topic: [PATCH 22/94] radix tree test suite: Add support for fallthrough
 attribute
Thread-Index: AQHXPEQtyHBRJ05HZkuRuf50C6UIbQ==
Date:   Wed, 28 Apr 2021 15:35:55 +0000
Message-ID: <20210428153542.2814175-23-Liam.Howlett@Oracle.com>
References: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
In-Reply-To: <20210428153542.2814175-1-Liam.Howlett@Oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de1f7d80-ea67-4ceb-41be-08d90a5b504a
x-ms-traffictypediagnostic: CO1PR10MB4769:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4769E24C6BE0DFB30E829CE7FD409@CO1PR10MB4769.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7zqAeWaa+yt4E7rgC4iigLjNT0bjt6uEYAWT63KaQ5QBczkOtcL+nYcz1nIBveXZiIXX+GkCFFa+ejnXAvx6QS9T7vNBFQogOp+mzYdr6XQHTexcHKDvWxwDgdQV+fvRxP/nSahYvAeL8N2bsTWdTXpW8cztTVyLyBe1ppXgxkjtQPMftnDhpMHGMBHtd9h/PDU8w5tYtql0JNuRV+IjEK6XXvm1jrD4WMTTGiwvBk9rFPHesVIA57iDitD1jbhqhxorsMEK5sUEgl1llnPW1vE8m4MX0qU0T1hDpIkYOjge/kpOD3AzEIopfVuJ0rwV/6ZhnYJYp9T681QFqa5JD4UzfKvHuZXz6ztaO66g3+QCMvnCEXcxEsldWHfwiiQATOpTRsJOCR3lY6l0urY/HX4FGO7v1MybFd+54+QCOxUp6Lqz67+5VVZheYhfmWIgdz+kJtWPQ9IK4mHehvPKkv9XCc+7cVtC5SYe+NBiV3ciXTRLlWeTs3tRqKi4pCGuqDenSj/gE52TUoJTY8ZJQvMQM/8yTYuTQmVu1zNIS4/1a3B+iPbQFnj76tNNI6pAtnIk6MLPFCBo2FHwEvlOr4fGN9AikTZLm/uz7kmE24=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(39860400002)(376002)(366004)(6506007)(86362001)(4744005)(2906002)(110136005)(66946007)(38100700002)(66446008)(66476007)(54906003)(8936002)(2616005)(8676002)(66556008)(76116006)(478600001)(36756003)(4326008)(44832011)(316002)(1076003)(107886003)(186003)(6512007)(7416002)(64756008)(91956017)(26005)(5660300002)(71200400001)(6486002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?DQT2rRCUGTOhfAEPWvpji/xRU5eqio6UnIqAeqaPREZGZvnDahYJDdlrky?=
 =?iso-8859-1?Q?Pk/Ss7tWznmtzBlTUU6kK26t1b8O6yLn2zkb6OCKW1Tek5NAySUNcX4QyX?=
 =?iso-8859-1?Q?9biKOeeA6kOq7vMcmz68FsRQuOM0CAJ6n7p7xo48EvKknAvEJEnusNhVDo?=
 =?iso-8859-1?Q?Bc58sgL8kIDfqNc8tY0RmzKnbUmzZwcEEYJIx5BE55c01NCFtSy2xdSkqK?=
 =?iso-8859-1?Q?8Y9EQbOSduXsEFlBo0BwPChD7CVTVf2xQVLXuAGjlsP5EXJ0VsocqhFN9C?=
 =?iso-8859-1?Q?eF5OclitI3PjZ2m91qGLgBoRcuSk+vmZ9lTtesD2x27fXKt45B9mbFfAu8?=
 =?iso-8859-1?Q?Urac1CXkr2w0SK+u+nOmxvDjAHOG6W6CP85ApSDweZaalho2HMcfJoIaj/?=
 =?iso-8859-1?Q?7elqWv2h8CPZNpkuQ9D1t72azhGYqpbnu3bGLcL54GAs9GpnzEiQmqJ+Sh?=
 =?iso-8859-1?Q?A57as/Z420dG2vdM76R/Ksr7iiEHRl02hrOSLJpg/Ix5hIj7CnPikh/5Ev?=
 =?iso-8859-1?Q?ckOf9KdGQXvx4XcVs1ZSBP3OK9/dYvno5rvhvtw6EIIFGnsibBfY3Yj/hx?=
 =?iso-8859-1?Q?lFrMt0xZbnKkrPjS2iVNGhSKXeS4QROfqMBMIkikaTOrcDo9KQprWRVli1?=
 =?iso-8859-1?Q?sydWxJowknfd61Bl72VoIbu9ozkVSsTj1Y1SC/WR5wPXrDbleMbz2Y/vKR?=
 =?iso-8859-1?Q?N+lWotFky90qQB9rD75EqhHDWPdFPvJp1nw3T6m5wpOksY6fD78PRb9lJt?=
 =?iso-8859-1?Q?JCtkg+qSu9B8IN8qu21DHI9IfCf3z73Ljm/nAAzWR7RQTWvcSB7TMtqFvM?=
 =?iso-8859-1?Q?uwmIobWL0Zvz97tS++DQAr48lLOXD3GjHPkLOpfegJIsohAoWfuAuXb8Uz?=
 =?iso-8859-1?Q?mBg3dVuVrkp7pDLkP2Z4a92wdXy0yK/6Vxyr+q3m/mlQOZj8u40eDgmZbG?=
 =?iso-8859-1?Q?s+pvetCLQhbOj5v4PT/J2xlLBVyHqFzNhX28pG2XKpZ3gMiEZruy8zUXpc?=
 =?iso-8859-1?Q?8w1OZ4gqGABSkmv45LxvrPUenZQrjzXu2RXUCfyBQC8nMZuy6O36dwOqu2?=
 =?iso-8859-1?Q?XCyigGZNZJvvL0ZZTNqZAe+QtAs5ZFt69QCqB5sgWLOtvx5vsPIBJiIlVv?=
 =?iso-8859-1?Q?d2otfXdkS2bvtGG0B27Kn7uKcbjpRLhEprwDPPzCfbgQcGgMfp8FKjbOvh?=
 =?iso-8859-1?Q?dg1Cxh6tbIw2cINcplwXZFZOpENTxJXlI0aReHfXNw5txzXguNujjLTzsb?=
 =?iso-8859-1?Q?REeHX53mfiog+jzifKJ+lyNZ2XQBUxNnJFGm9dce78L0ilekB25V/6FN20?=
 =?iso-8859-1?Q?EuHfbrRNEpMDxy0Gfp3bHwly1cKpuVpnxnPiOMEaLRjVv0sMLw5DrJiiV5?=
 =?iso-8859-1?Q?98Fu4bSJjp5GtkctTrYTlpmRFkfSNMhQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1f7d80-ea67-4ceb-41be-08d90a5b504a
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:55.3741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tts7ftl70OI0rKb7OC1hK3SUMM5lywmOEMTFKXb3vqW7nf3R0EZpCqT90nX0bn2nlFnay1H1jMky6YFJwHVMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4769
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: btvzb2rAZnRllkA90Rmq6pMAynp-9J4r
X-Proofpoint-ORIG-GUID: btvzb2rAZnRllkA90Rmq6pMAynp-9J4r
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for fallthrough on case statements.  Note this does *NOT*
check for missing fallthrough, but does allow compiling of code with
fallthrough in case statements.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index c5c9d05f29da..99979aeaa379 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -24,4 +24,11 @@
 #define __must_hold(x)
=20
 #define EXPORT_PER_CPU_SYMBOL_GPL(x)
+
+#if __has_attribute(__fallthrough__)
+# define fallthrough                    __attribute__((__fallthrough__))
+#else
+# define fallthrough                    do {} while (0)  /* fallthrough */
+#endif /* __has_attribute */
+
 #endif /* _KERNEL_H */
--=20
2.30.2
