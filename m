Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138673EEFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241070AbhHQP4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:08 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:14874 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240301AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkHqO018099;
        Tue, 17 Aug 2021 15:47:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=y0ZQvZ4Xn3sPJJeqqMBOrXGrsWGvvGbdveSIxKMztnw=;
 b=iqGCuAfUhdIq9f51RDeUBZjibwrQhhfSFKVNrN2zSZI+tzK6yUlz6u/3ZqYP64nvPqer
 IeF6AUqkAFRqxVbVGKAu4AKEWtGkJU5icRApwTzCLMkprInzNAppSZANfaFont60kGy4
 zSorqZ2GdwY3CF4anULZDhbGYblF4K50Xcq7h0GRoJXm5Ul2b7tMOqrofoAyZKbONgIP
 7zY6MfA+GCGCY/Paw+osWW1QyxA8sqo45ByHwl6W15IbexDtAg7I/cQtPlG7i90ak9SR
 kgx1ZOvmvS0B0/zkKcKnnSKlSZHkKZjjzjBY5FpeIYNSMZ5ke7czpLCPfzHne8C4F/h9 lQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=y0ZQvZ4Xn3sPJJeqqMBOrXGrsWGvvGbdveSIxKMztnw=;
 b=sTCiYkb6Wmuts2Q+1jNtOVHkQNwvDTWO2w7X5glKine7xOvEbaZy8YbnkCNy9hSgLLyE
 5PU5fcm4G7z3JISZucRnry5EtKvkQp9UJwlI8wkfo4p2fXdlirzgplhNxUqPlxrmGgeW
 Z66dyh20W8oAEXQC1BgkYDniygi8WNavCIFeQV5zVIEBOJh6lUhax9oJXcrTf4twr4Z9
 VQfax9ArhPlW/BFeL71fyu05gzgF+4pgSsDnwQpIP1bKpK6nnox59ToQ7qL5WeUFmO9U
 cvG5GMdfWS7MRx4bSlaC29vOfjSWV4TmTfRwYEc0eOtS8s/gghqbcDo/2r8Zv3hNMij5 lg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc53-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3OT174039;
        Tue, 17 Aug 2021 15:47:58 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2r9-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fx1Xhe3opByA3qoG+poId53nvOhe+HeadFWSYGSz/ZyxwajVUweiQqS5dBHaRN7Skag7pOIHs71BhrJwz9gtJlSA/iCOFLIqCxj056GnS4vDcn6vG/Gj8rvL6od60hFQgglR4dzWLpYe5JaS5Tdf0jHr2yg8Bi3uilnbo1FkcXLR9txaMD/ne1Av+DmuC0j4iiYyBYkyVA1d4vmGBcE40biV6kyE8RMUPlAUE1SZUUWut2p8LK9WzRRdjOSCz3lD60D3d/PhpfL2U+ez8d4LRS9uAM+2unJ88G9ViA5WgV+A4Y/gftjAV1MehD4lpu5ILtdXf0XDZ04lvgH5ZAb9Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0ZQvZ4Xn3sPJJeqqMBOrXGrsWGvvGbdveSIxKMztnw=;
 b=kyOWw2dq8OcbjgZJVmOlVt0JFgz/E9UUAWca2F8BdCKHgS/O7BSk7Thclj6DrtXZXLKRXHhlf8ORdk8sJXK5uUzYm960fHjDbFxH23AXWSPtWhFVpytCdw3Z4UNSVAvCUzWOWG7LUNqJb4gPC7w0jBUyQNXOUStFj8jgIeQTruelJntzOu0JMYTOmuDfRfSBbB/D+GRP0T3QmIzjS+tRDqP7+QBcVuMVZpYQoXru9CVaUv6oOYJ723/wHIfe8IstpDwMS9Lknn8NsYwDehdCnC6h4GRV+EhQQNcO6toB6TEtzBAWacWGo+64HdDqhwiM4eCEDizlSgGY7YdJJjM6IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y0ZQvZ4Xn3sPJJeqqMBOrXGrsWGvvGbdveSIxKMztnw=;
 b=w9+1qwj/Azs7upzHWKqUk3SaLTvWEhXXnYUbM9X9R2mcEGAHGU1NIuc8O7mOH98VvgQcmw9Trv5lnMfc51Amfy5ILVQN27TXvSZ3lg+13hLtcdaadaBzz6tzGIAyE1w4AfI0mEidzE/VJVnv/BvvUFYT//2+sZ/GojD8Q5sooU8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:52 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:52 +0000
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
Subject: [PATCH v2 32/61] drivers/tee/optee: Use maple tree iterators for
 __check_mem_type()
Thread-Topic: [PATCH v2 32/61] drivers/tee/optee: Use maple tree iterators for
 __check_mem_type()
Thread-Index: AQHXk38rFEPim5Kt6k+VQj+Z+wBAPg==
Date:   Tue, 17 Aug 2021 15:47:22 +0000
Message-ID: <20210817154651.1570984-33-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: ccfd622f-1717-489d-8506-08d961965fc1
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423688C48B615E357EA7C6FFFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:843;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKvXuf/fk5E1XZYEQ84bsEq7m9eddzXCXuAlyazpf1dufUnjajaNs6inJyRfm0npZEphBZkjpw7LQQpzKnUXkmrimFnQdblSadgX93VVAqZ8OD0X5wL7jEyjDRa+eUp756/6dQ0VzDeiX28Jh/hylKu6WjeuwG04T49qMMwQvpVWxf5eufJrgvpmA4txtN+xR0i+ffEqZrqhOT0KCV2Q2Yu2wPEFkRwWf3NLcTpkZM7FMkVGKB/v80LGYfnyx6LvKu4qY0VA2iLC6vDOoWkO5pBY2Inl5ZkSs66qE3dcBI/SaW8o0NUSKUHE3o/G/a3KCCz92mgOqQK07GpIr74Wj/0WZ9LoEenbAqQEDxT1bbRCt/no8TkHcV197fO0Ok/4ZtJR+03Et6oCW8Z+RfmwQN+qaQMSSUKSg+P8b05EzyQpvDhll56d4zuaDsG+yZkEYSDLGYKeYpEPlxR2O35DGXfNGU7b0LhCoKG2SiCviOaKSdUtArtydJvI41QX8o5L4KiRQG6WvYN/k2h56T3s4uW3+jpLzf3Vo3rB2lMtNRtNj67gAQSLEUKWRwt+r+q6oeIRBezZL3vzLTLyBQkGmj9hKpjfgkaD0TdncUcEbP0OgsQ5N0hQOwt4UGlO0yzBP+8ZFyKEaFPvsJnoABw9wz7gnsXfeXzvW3ly2vexm9YwNjAzF+RDrwIgiSifaYdhN3uuXbvlAzKV9Jm2vjkMkw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(4744005)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6666004)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ZGTL0hzGXR3mcimnizfsA0QwXNNxJCnoZXP0504Riimrp56aXb/WCgwzA9?=
 =?iso-8859-1?Q?oUfxQSGTvkIVsGD7tR2/vAj+9VjJDeF9c6RgfCQ6dt98MOEkaYpDfJxXAB?=
 =?iso-8859-1?Q?M+XWU95mrEsSPgv4eET9A9REWnFNDv6aBEZovC52gmGyl2wp85Qmt2f2Ru?=
 =?iso-8859-1?Q?cydt11ViJspZ2rz3NAojII3ZsC/Rag5tZvV86vZ4QnRdW9531oidRo/aa7?=
 =?iso-8859-1?Q?UfvxEyd9Y5DXsBqH7ZSC9I25yAsYBE+I1N/mKDSNlpvdrZZLlJUZEzn1XT?=
 =?iso-8859-1?Q?QvvMQd1o2RSnPHYieFOlVaVBQ9q0AzzDLMMD0zAqBsns8TYGg6aNhzH/K+?=
 =?iso-8859-1?Q?/dNw1I76zqbdjLyQ1YLgNCZ/Q8gUH4LUIfC+gzXeCIyfW1NAHdkpZYj194?=
 =?iso-8859-1?Q?MY31kvjtDcHTLg+4zTCZZWxPjo47ewozRo+dbqpLZHFThAZLRDW8wlAPJR?=
 =?iso-8859-1?Q?xluG0tXaNaB5zWFDbKOvO5XkEh9UBPXE2NH4ckSKWtoiH98xIlQYdOo/rc?=
 =?iso-8859-1?Q?KZ+LyHLISxIUzF0AZDnPmuzWE5LS8i/mWr9E9MegQETrNtfmac8uK+jPyc?=
 =?iso-8859-1?Q?TNqY6X7zkp4OY0fEEY99YJxWpdx2Hi0eSINBPIZ9B0o75HFvfX6NVJhi67?=
 =?iso-8859-1?Q?BYjXuWrdprozZhjqlCJpcp9zjrBunPI06KzokKM+A41i3ACKO7m85K3zdj?=
 =?iso-8859-1?Q?quNIi/Gh4pe709PHhVfaZYv1p3g1u0sgyXNU3afx4LJ5KZKy/82Ck3fi9W?=
 =?iso-8859-1?Q?QMu60o6IraRv0tnjeLM0Yj0KfZWiqxqiMdJvT0yRbt3f9R8x6mR7bgYHjb?=
 =?iso-8859-1?Q?FOK5Zs8mX35nUndZHEBKRZZdVN1fU76iOZGtWzapiJmKK+Ez+LI8KJodaB?=
 =?iso-8859-1?Q?fIob0zYXq0a1Z9Fk3qnsu1oEAt6WLU7oXrAd8e80GF7+kzj5LvxBlDrmgz?=
 =?iso-8859-1?Q?r2G3pWOYE2dhYcWzWjd846AgmlsiXtnSjryBa8W6ss2aJ0nbdG38UenE8F?=
 =?iso-8859-1?Q?ucu2Ibt8emUUCxtv/7tnrMOYjyK+PQbeep2t2JtWJDaELIqnjIdjg4ZPvK?=
 =?iso-8859-1?Q?c2W2ta9qx5vjN56qUSKRXeBNYjqRxPZ1U8tKeHWUjEN1YiL61UrjfgSpHK?=
 =?iso-8859-1?Q?hDWmLAjhnYWJeM1vjKgA4fX+Ku9jm5LFoO6jh5A1TrcaRechZbBDxxP3tv?=
 =?iso-8859-1?Q?u+2Dakq//11yhgdR7dBWCYjgOXB3L5wn21rjEycZ97jcyn7g2n1Db6zMs3?=
 =?iso-8859-1?Q?yssxZV2QVRdmr4ZmiC8hEDKnOuHIjwV/cGHv+nZZSVZUrNwEMMHOU3ZqvN?=
 =?iso-8859-1?Q?woDrofM/qzSlFfjv3NEh8utFcGK+c5b9PHkN1Igj28K9bBAQpPhNWEmTt2?=
 =?iso-8859-1?Q?sQF0OuUcmy?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccfd622f-1717-489d-8506-08d961965fc1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:22.2854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4huOYenWhC4Gy7dFVecnWrABTum0k8kP06F4tgTtDdSnm9VOD2lCcb1vL1ln0yKwJwJMxv3G7w1r4jZv5vjRrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: vnKQC2O_Wf4EsSQchPbFEEkk7h1PN-HV
X-Proofpoint-GUID: vnKQC2O_Wf4EsSQchPbFEEkk7h1PN-HV
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/tee/optee/call.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
index 945f03da0223..071ff5d9c059 100644
--- a/drivers/tee/optee/call.c
+++ b/drivers/tee/optee/call.c
@@ -582,11 +582,18 @@ static bool is_normal_memory(pgprot_t p)
=20
 static int __check_mem_type(struct vm_area_struct *vma, unsigned long end)
 {
-	while (vma && is_normal_memory(vma->vm_page_prot)) {
-		if (vma->vm_end >=3D end)
-			return 0;
-		vma =3D vma->vm_next;
+	MA_STATE(mas, &vma->vm_mm->mm_mt, vma->vm_start, vma->vm_start);
+
+
+	rcu_read_lock();
+	mas_for_each(&mas, vma, end) {
+		if (!is_normal_memory(vma->vm_page_prot))
+		    break;
 	}
+	rcu_read_unlock();
+
+	if (!vma)
+		return 0;
=20
 	return -EINVAL;
 }
--=20
2.30.2
