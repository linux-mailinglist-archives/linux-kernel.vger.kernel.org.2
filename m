Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E04FA36DBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240165AbhD1PhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:20 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32436 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237798AbhD1Pgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:36:54 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFM3Ig013796;
        Wed, 28 Apr 2021 15:35:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=QgY5SnXXHOrfMA9J5dUeif17SGH+0DdB37rjp0co6T0=;
 b=DjOjfkry1lPlrzcotE9r0cRqPZYAFyotTZ/ae8AiKLEMRDlGRn0sy6pS4Gasl1MJ+NB/
 aXNp0CfM9JtgGJEGHfKhvM15lBNyhiOG77cgQnjXlA4IQEzNcbSdX/r/4ju2Q/6fwxbK
 tIhHUeif3s96KUH//DKIcmwGtq8j/yfXjGFXxg66QwxRSTXl2YESok8q2PzeI4833D4L
 FeZ5mHMx4eJ02O/77Zg8S/jE58nkxF0OS1Vg10O6YGlmQ+R2y4hiwo8ek5YvjeVxmQUB
 irecXhpFasDiwdBQswSq6R+J+hVP/sktCZVu8Yv0ScMn7Eq3gZxE04oksl9rwkc6HIIp Cg== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878pk84rv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:49 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAQ003673;
        Wed, 28 Apr 2021 15:35:48 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cNo6ucMhK2SEq/hpo0i8e46f4Y2pWzvdclOgg/W34kRrKcl20j8EV5GYprngkPgIB+6AAEezGifDLeMuh808AIm2jnjJxGETdtCZu3ACqhywHSupOGhxu2e4xOJCu0SLvjIk37hhMd3A+G1oGaNeSmHyREhlCPlbhcFAHot7t9YmHoWQG08x9HAIpvzSJilGmlTopiRj9iy28drhab4sCcxS7zDbIhJ10YuNPtfOHG9mNJb2i8NrLAluiJaLvDv1Wr45zp3pfeESQbP25j1yQ9rKuFWdW4/expq86D4tAhuZgnO2LHx/pi3uqzO3YGDa+1gN4Ta5NY0k0Tek8Yj7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgY5SnXXHOrfMA9J5dUeif17SGH+0DdB37rjp0co6T0=;
 b=UPPhUEc+SxQWkloBgagzBg/jHadtXebiMf9w8y3NAkA9OG1BGj7GDVA7ZfheJO+X1TnZvBI1i4aCnjcF3QRcUDoW1SnZcPltPjYhnkfQFi1LvFTM0e8nPwSrc3X+v9IsbkJekdS/xVQQ8K7MrvW31UAIiSMqIR4EJbkyOZKrLK5zygj1Z+RiJvPhiP0K85Hj9okjLHURXOJtnF+fndaW+z2fltX4bL6iyHR4Kb4efHXRw1oC7KJ/1WUmLbh6bxC7WmWo6QB1uC4BoqfXlD8eOKlh9qif8MgbcoAxZFW7yYHbcZ/eAdONhpSrLy0cVjNtfcrDx8O08tEcO2Nlw53eQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QgY5SnXXHOrfMA9J5dUeif17SGH+0DdB37rjp0co6T0=;
 b=rGgcYFXQwJeA4eZgAq2sR9UdDpv6Fm8KlBkuDnVkt3q0QEmE3jbAvcIsOmEJ5+K5bNQmNhvQVW8TsfLo5M9LCjX77L6qQTIpvDxwPMLyirdIRUwcZ2Vdlc88JCYuN/EWafj/gtQkoN+EJz/Y934iVmCyONYRjNKrdpIB3fg/cws=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:44 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:44 +0000
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
Subject: [PATCH 03/94] arch/arc/kernel/troubleshoot: use vma_lookup() instead
 of find_vma_intersection()
Thread-Topic: [PATCH 03/94] arch/arc/kernel/troubleshoot: use vma_lookup()
 instead of find_vma_intersection()
Thread-Index: AQHXPEQn5Dl7qeasUECRvVXiX1jTOw==
Date:   Wed, 28 Apr 2021 15:35:44 +0000
Message-ID: <20210428153542.2814175-4-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 9a9a78f3-8064-42b4-0d4a-08d90a5b49e2
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4497F9190413C008361567AAFD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xuwck6nyhFeuITNbTc2/+0wUpgluCne9h+F6QuAvfUJSGA8VOBx6HnDQ4WKIv4k6ppTp8m9/tcCBFwINOgD6eOsQ81tiP4Cu5x53q8oJnMZKnVVR1oV3GSl/jHpb/vEvxog0t4xJX2zLm9sPlEr7chin9XEE9z73ml3jdurp0bHky4zXobdehmPPd/NCU9dUmFapR50GzpTKe2+tGePMK56Xl2o0/OzPqO+G5ACQmDmK3ZaMVXNPWQEpomb0lQDA5VDh5L0/dHQEm+G5OKHl59QTQG9w7dQgj1nwO6WPT9NkU/5tfHJz4RVoB7zGXPSf2cEc4UGEbYwU3Qa5w15wpgsZULFQ9zF/IAALmqtbQkc2RSziccl2PSEUgEBa8J9N6e+CFpioT3koL29q+K0pdZ1X9oNTGdOWge8bm3mx2l9aNjK1EacCLeh5Zp+al5AFpbLngVbUQxoqidDKDVRdEc0yfhnO6JD93SFxTW47lH00DeQ0QeW9V9ZqoxOVJPKiYY2WGx+luSs+kAE5I+w7JOHL0HoEMqoFHjZO+vyNJ7WEowwTH1zT++wznY1Ex+sEWax8mvtvHlPkxbyW41AUwFUsrrliesBX880Qk/fyaTE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?5ysIfKIM8FPiou9HZzvRuwHaiVV5kR2uaf1LcLvYs9pubDz+7Ipu/3+VL4?=
 =?iso-8859-1?Q?Y/DapdlYoZCn2ikb9nWZ0dT3OXxCoWBxvoJMN7EXF0iSO/ysoUh1jdzXr+?=
 =?iso-8859-1?Q?zQqRKbA0gx/jvyp5Io/OzL+TWCd/QnkUamjXVETE2CyUUZjqOFuYVYNXyH?=
 =?iso-8859-1?Q?Z+93nRpPzZX2kORNCbXATCoa6DMHFwgt5fkTH9E80ZXzibeSI/VXo8501b?=
 =?iso-8859-1?Q?kqgmAtnt43Ed+TbuO7u+IlEsI3H+6ele+uNTqZfC12Y+KyLty7c3seWVcN?=
 =?iso-8859-1?Q?OXd4nSivDWbb4+augrnNTQx3XfketzCxgIjxIOht6BZ6LjznlqTy7TZf+r?=
 =?iso-8859-1?Q?wyq2ZhdE66OZyQYkVhfHVIdwwfeMERZZuTn8sna2JbAIKiC0y36U4zcxfp?=
 =?iso-8859-1?Q?B3Qj3hSlFETQuqSA9tjk2xcLY0Y/ay0GRBafafWHmD6BQc1/VRjjvMBmh8?=
 =?iso-8859-1?Q?L7V0Tje24aNcRrDSjmwMEFFLVwSvPCEd9l/jjev8kHMDmKDnxRHXkDqx+2?=
 =?iso-8859-1?Q?CjzS5YHS3C5D6EpWL9Va5MbZ36PspY7L3WckvMAF8xPIKD6mFu3jUUTi5+?=
 =?iso-8859-1?Q?z9/3/eH0llGq/51ixdrampl/Dija8owOyKFBlHVXewHBMNcd1SUBHoz1h7?=
 =?iso-8859-1?Q?B8KGDUljzaju8yeT4nW2cX0v/wZpmTijtrt+G6HZy07vB0FxrMMTjuFvs7?=
 =?iso-8859-1?Q?YjPHPncGPlb1/Xd7iQ1dteCvprO0aUJYL8S3oGm7xc555LvS8VNkSgrZ1a?=
 =?iso-8859-1?Q?j/2sNEAdOmujhe1mzDWbR93cUawlZjpAN00TQ6jy5T2ZNXexePDk1ah9aB?=
 =?iso-8859-1?Q?IwWyDNHCzNaJy6el0lkt8YXFpJyrFQjNUSm4rbM/WUZzqQnQQHD0PQjx7W?=
 =?iso-8859-1?Q?+pIw4/vBr/I2aClN55H4rNemHa2hCr6NE9vr+pb/r4PXLLgsJoIsGNHRKt?=
 =?iso-8859-1?Q?yZBRl51cAlYWB1wutjJrddNxgwe3ko7CS75KcP3m4vlH1KbF3CTbL32m+t?=
 =?iso-8859-1?Q?Wd/CfJByhL/RdsFn6yOpyxS+1hX8SXsktFHOs447lhxmph4IaI66gKojs4?=
 =?iso-8859-1?Q?TPm670sCGZs6ijYgfCDDejKNVMQZCKpV1WRCI/Fw1WJrdiTru8xlYt/JXl?=
 =?iso-8859-1?Q?wiBepptL7bOqSIGWuMY6mwSvRlHIT5GmvWVKRsAaHhqT3T92i03hnHRTPA?=
 =?iso-8859-1?Q?5RFN8b2AcVk0KX1lQeYldBX76Yg1Ci6LB3qrAJ5gxODh1ugeFkhMBFb0EX?=
 =?iso-8859-1?Q?z1N9wDFCwlBjPgI1r26wKfuEnlyXMhNXiWzncIUKCgDOsarVU28gAh738B?=
 =?iso-8859-1?Q?2x738Zgiy5hZ0x1Hv7VB778eXBJvglrkjJeLdCHuy5UhBMPvNpJ0fbew9z?=
 =?iso-8859-1?Q?szAFvG5E0QWVx0QN9j8Kx5mZ1ThqW05w=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a9a78f3-8064-42b4-0d4a-08d90a5b49e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:44.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jlOoKlWFmEU7HVNABhxdBhQpbN2p1b2vKafq1nF2YOzlhZ8B60KpyY4ElxWn97R+tU+6qZS/oEOTNcBWHgGxnQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: E_K9eB9Q1iMw7hxCltVxSXjnHIn0Wocm
X-Proofpoint-GUID: E_K9eB9Q1iMw7hxCltVxSXjnHIn0Wocm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new vma_lookup() call for abstraction & code readability.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 arch/arc/kernel/troubleshoot.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arc/kernel/troubleshoot.c b/arch/arc/kernel/troubleshoot.=
c
index a331bb5d8319..7654c2e42dc0 100644
--- a/arch/arc/kernel/troubleshoot.c
+++ b/arch/arc/kernel/troubleshoot.c
@@ -83,12 +83,12 @@ static void show_faulting_vma(unsigned long address)
 	 * non-inclusive vma
 	 */
 	mmap_read_lock(active_mm);
-	vma =3D find_vma(active_mm, address);
+	vma =3D vma_lookup(active_mm, address);
=20
-	/* check against the find_vma( ) behaviour which returns the next VMA
-	 * if the container VMA is not found
+	/* Lookup the vma at the address and report if the container VMA is not
+	 * found
 	 */
-	if (vma && (vma->vm_start <=3D address)) {
+	if (vma) {
 		char buf[ARC_PATH_MAX];
 		char *nm =3D "?";
=20
--=20
2.30.2
