Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2383EEF74
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbhHQPvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:51:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:23428 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240209AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFklTC017365;
        Tue, 17 Aug 2021 15:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=VmngdNA+tLJPXDOLSgCS/2/BWnO+zm2Twzt/4WjyVSXOh5QTVAyNdUdSHL/N7jQ2fH7y
 aalaKAI/vUSLS4XZkveBHSgN2LdoCkPFBqLjzCosRCzSQO5NB4Z5kiEOScQRdixkwnW8
 UixRmm55T400DFnNTTtBCiq07bfvf3JKLj+kYWRF/8Ruog+/zm9/Jo9qwoyE2HN1bfqc
 alr1+PlbiTOMvjR6ZR96gO8jbpz6yG1sTvye/PGH+EtjIFpTclscKQXBWtHIHlwJPWgH
 DVUeAoSt5xXtEngmRTAzw45ZwZ6ConFnF6Mhgo3qpj9MioTDugSPFIR8XldMqNh6jfaR 6g== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=RSk646n5v5CDwJfAkdoBoZ3SoPdo9FbwuO+fkkHEgEdeGQvupNR21/8VZTzFgwVzWPXq
 WAVwyl1OhJ1N0wlKbgqmYXI1VQ/ZUcOQZNJObfrC0ipEDNOi084hF58oQE+ZNTZB8cE2
 CiAPzaYwFbSG7DAwuaZvno0Vl8xSV6mVHLroJ3mA7XpgLdgvaHekHq2NaSY0mn2CfMMi
 tFjFJWKsE8zwfA1D5P87lrhFP3KRU7XKP/eTz5MK32Fhub/HYbQo1FyWmcwZ3Xf1NFDL
 jbqu0T6n8qZLJlTx+UJQpH/Tpm3p+tebl38IMbtexN23bRNPRh0ZxPxnsqy2CmPoLb/Q ug== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g3m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:08 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkt3U094574;
        Tue, 17 Aug 2021 15:47:07 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3ae3vftd2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cg/uJcDPHweD6JS8/wi3+CL8932ICzj5mWwVXFBxU40awKu5thm9M4S4JkKX1RBGpNsPuNYVfFHhI1zyjV/dXK6lu4P8tPq/5At9yhSPuHtkjX9q/2aZz+0HzgUVCIQ1ycKb6I5/4K02bf3FDGUOM16O+ik27DMYSVWfJhwVhYtIQQyFqyVaKMlWJs7NcZ/kcZVfOyhyCILBidNyq7sPRF92tBJvAuKI25i1Ma8CHF6MgnB3kVlvaVVHu+XEnxqWMxWnvXlONAVHeqTrcNxpj+0bwEamM2WvdEGIi/EHMVzRIJyguZ8KrlH9aU1rWE0BqfzU8JA0a/zEgVxwMrs45Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=W/nYQVYFPeeW5ePcdvvbtCcFYzmmCJKfKcjaW3FuzZkJRceKF0U0IEqzh0f80g8wJtYlkoud5hQhj6gsDD+Auo9egxi2sB5M1a1i23ZCMzJexSgno+tF5Tf6E/vT66K/AnCAfuP5Ko/j1967nS+KBC1BH3baq8/MmoHZ0zI+w6JLV0x0zdDf5pKaKbl0KpS+yeNqt9shGZJ4cNAESQWoZY7csvp3hEzuAbXZYQ/0G48NaUBi1e09Z9KZ2usxmgPFoUegfVVG7CrapbF0TctD5Lpm2UZpR/Hedh4NM3Fe6MvMlhD+GDr3nPdn2cY4Xb6cOCNxeS24QNhIxPcRSHHyqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ItUPRb0zMq8VEZ0n19oqYwxXAVcEvUW7ANV5wXB0VJY=;
 b=jejxQYy8DIbL8p6rgGfvfxRj+AjMHpYlw4+Y5Fp8x4qnusk97VPjw5JBIimve1ieZ98azeHvjrjoaL/v65qqTh4iB2j5VxKFykkbMJKtxnhNG9pAMpDztcOrjsTEzI12IH8u5CfBoNM71o72d0ZLjJazm/fNojDes3yTAhdTy8M=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3097.namprd10.prod.outlook.com (2603:10b6:5:1a9::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:05 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:05 +0000
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
Subject: [PATCH v2 01/61] radix tree test suite: Add pr_err define
Thread-Topic: [PATCH v2 01/61] radix tree test suite: Add pr_err define
Thread-Index: AQHXk38f787VE+xDak6iSXTyRGEEug==
Date:   Tue, 17 Aug 2021 15:47:03 +0000
Message-ID: <20210817154651.1570984-2-Liam.Howlett@oracle.com>
References: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
In-Reply-To: <20210817154651.1570984-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de297d61-6da0-4e44-81ea-08d961964349
x-ms-traffictypediagnostic: DM6PR10MB3097:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3097A92A4D651A6AA6AFCE24FDFE9@DM6PR10MB3097.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:361;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jzZWfWXfY1EgvdgzB74eB19mDTPMv97p6pqtaGoBH3zlQq6IA1k3Ih57mSBdbhD1vesL+m/8p6YbvQc03GFqAjA2H3w0pqmErFrLvAmTAX/39NCXQmHDxyseNBhK/ewfcwVQdv11TwrHMo8eYiCTAwzZSb9/WdZpW+IY5juaXvtoYT+NC/INBt+HkiGG+zD+S9n94JrYRPNgi4vLm4diagVB/iLIEu5/bPI48xv6e/L7ruPT4VaGQNye68zLrjU2FzXok6Ey2Qv36Z5elrYkFiX5s/cZNnQqfBDMXC8l01xZhwGB1za/SEGXQXEvvyCn2t5SK0nMrr5PgyXs8SiCnMCBuroMDlB8dOXP+S6a90W51cLJ+2idEmTTaNL70msHnVkqBP0EVx6gTeGDvsRqoPese/HPIIbD2gVZyrVWLX5ENlrdIyROA8JmEjYhkI6LTgr9Vee1+huZ0NkpfJYwqRI9buXmYirxh/bipJMJP5uVve7TUL6xvjWVGA1VPLYqxGrdH49zd1H6Uwxirm8guk8+jBAdodKzfzNTHfEjNPKF4Nx8NqjpsLwahgEUhTKOBFjLbwcPzywCyp0SSwHY4efvF1clp45WaNHgxPEFInblS+0pcyksqwMt87B6txO+k1V1HBoRgAUrfkRJ6PmqnLoVrGtXeI5VxlgIyMDS4VKynY6xniqQJ9tz2qAy4S1g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(39860400002)(396003)(346002)(136003)(8676002)(6506007)(2616005)(54906003)(8936002)(478600001)(26005)(1076003)(38070700005)(110136005)(316002)(5660300002)(36756003)(4744005)(6486002)(71200400001)(91956017)(66446008)(122000001)(6512007)(38100700002)(7416002)(44832011)(2906002)(186003)(4326008)(107886003)(86362001)(66946007)(64756008)(66556008)(66476007)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?lE977OckUP0GtxohhZTNFELm1aszBeYH0unB0/zRyCirJPYFMhcfIbf+vz?=
 =?iso-8859-1?Q?voKA5aLy0oT3QMhQWnWXT/EecrmZK73v3Q1JhsBQOC4UVfFJS00e9lhKzg?=
 =?iso-8859-1?Q?b4VQF4FyCqOYqbrrBYzGWJ1ZPYdHsKo9HvAaP9JDlyeKbuCrsCoYf8YkDi?=
 =?iso-8859-1?Q?tULNOnqWo2Z96ibdo5Si7d+RMtkQDyPnTClWNdp2+epQW0W1L6QL+LkNTB?=
 =?iso-8859-1?Q?AtRV0XKLKwltXd919sGQYIZcLQs6fyEyZtMXQbaqKa3JIM23yGjQjfkJSw?=
 =?iso-8859-1?Q?bYJNaJMCxjPhP/psorf8nPKjjKnah0cuLrVE+FAj8F+3d0tH62tt3X7KVL?=
 =?iso-8859-1?Q?9JF90N1d0PQ44s3DgXvI9taPNUunm8nBrQpSR+g8RFTzWRZnh1nJ9CV3gJ?=
 =?iso-8859-1?Q?ByJGETBfWtkNMvcFAGkpwcFoOwNf5VAcHM/K4csw/twXwDpfYMUl0PGChb?=
 =?iso-8859-1?Q?7NGSDxwbv6+ImllWOwGMnoY10tNn5wH4BeY4RvepvNTXlxgRJWJOu0qpp/?=
 =?iso-8859-1?Q?VwOCjDV1Q1s8YSR22uwWIWYTgDr5dNSSwAyuVr/Kv5YzQ/iKt5f6S7wf5r?=
 =?iso-8859-1?Q?MIvdFUtyYe1XzDLGG9UDGSNhUcMiipeXBQnGN87kwoXOT98c187yJdnL3j?=
 =?iso-8859-1?Q?+f7z3P8PcCzTTDjfF9XcGLj//fb5LQYaZLwDq6K4m/4j2oOb5ZHPhQ7lyr?=
 =?iso-8859-1?Q?ROs7NN8aHOVtmzYkXkYSOM1iImSTL4BKSKZt5WoUNFIZe88DGzyv3pHU7s?=
 =?iso-8859-1?Q?+H2mVLgCGnaJEIbOwfrw6HY7fiEoKIjC2DXqq6ixdAM5A6eRAOGd1uD+vF?=
 =?iso-8859-1?Q?nf2xPkRFwdMGlmfoX/hniDsEFx91AqO8CT8QJ5nfjYzYU6W11ZV7D1rDQh?=
 =?iso-8859-1?Q?khM9b0jmwLb9IuN9kqK3GXZEnH3HtgKjeUs9KCuVdVHPiTNKSqKXHIMXZB?=
 =?iso-8859-1?Q?/6zXbG1NJrXkdgVFZ7hsfahtNglKFjek7jltpAOVFTgR2EIyb9DZwtZYFv?=
 =?iso-8859-1?Q?NZg+EGm/DHk0DPThx9Rwd/uZ8GWaNxM7hqQpto8j5gIiEvMM2m9ZzN1G5q?=
 =?iso-8859-1?Q?HxPQP9mfeRPPcesQ/3CBkCYKheCIhzRKNfeQv9KHdZVnbsPTbKzQzs3ySo?=
 =?iso-8859-1?Q?J36/SV+eKAC1uC23s9dLyE9HOxX4TaADG9sPrF+vmuy6X0PY7SF4LTg5rd?=
 =?iso-8859-1?Q?FpnuP1o568tPbsbCdZcocE5/m3x8PzdzhWnYr+ylDt+iUHmy3/f1NRErOI?=
 =?iso-8859-1?Q?rUcgsf38PbUHYTrEwAJ9BVgpabl29kEyl0DhUlXygP6jng5gE/7lolzjk1?=
 =?iso-8859-1?Q?wV8B1tUXttigCCRNIEl1SkdXyKYu6edLJsVcgqYOllwh0FRfbPEcvMDTjY?=
 =?iso-8859-1?Q?yqatlehptt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de297d61-6da0-4e44-81ea-08d961964349
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:03.7357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZXnFJ7PMc2txjJMk9eFBK31jGjXS7T+7xbH/epZcALhlYG/z6IU3nFhuAoJS3tiDIZIor6kjCIHYKO1desqf7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3097
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: op2n6jQHEht328bYH_WUTjq3SHmHaM-n
X-Proofpoint-ORIG-GUID: op2n6jQHEht328bYH_WUTjq3SHmHaM-n
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

define pr_err to printk

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 tools/testing/radix-tree/linux/kernel.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/radix-tree/linux/kernel.h b/tools/testing/radix-=
tree/linux/kernel.h
index 39867fd80c8f..c5c9d05f29da 100644
--- a/tools/testing/radix-tree/linux/kernel.h
+++ b/tools/testing/radix-tree/linux/kernel.h
@@ -14,6 +14,7 @@
 #include "../../../include/linux/kconfig.h"
=20
 #define printk printf
+#define pr_err printk
 #define pr_info printk
 #define pr_debug printk
 #define pr_cont printk
--=20
2.30.2
