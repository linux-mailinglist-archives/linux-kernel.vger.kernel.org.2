Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5236DBF2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240898AbhD1Pjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:39:55 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52684 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240404AbhD1Phm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:42 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMtdN020250;
        Wed, 28 Apr 2021 15:36:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Gt1QxISyDo2H3wnIuUW86Ocm9kPFsj3AVeTg/anI5mY=;
 b=uD9pZFjDXTYfEKXRRRth2u8QB7baqMgha9WUSHzDxeGcdidDNAzWyrAXdGKJuaeOjzku
 bCU8w+pWOTX5a4IFbppYLWnB5lFnBdhtwrRv+MbU2YCjhf7kxnHfd1gQ2mWHCIZdHV1E
 Dp9B46g3ajOMw7JdxQT0gUQp1CVZm69ZDTxEKZ1/1Mpj/dM6T7LPMuT/cSj3Bb4BzOqb
 oT6K/R5Q4s68s0PYvFQWrkHNlOBhbNozuHnvNLAuB49hlJhTwvN3AGhxe+fBZ2A8+n9+
 etkTBAPOZ3JQqR/63/jhDnIqB5PdBrYFin5Eon1UCTMRJzO4bJEWrR6ywzSwg+GoPH+s KQ== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3878kgg529-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:42 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFaASq030176;
        Wed, 28 Apr 2021 15:36:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 384w3uuag3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EMO0w4QN8NJcM2zMAveoeBTxxarGJoaXM8DatT6/vdDX1XTK8P3e+oHKCxgIcUE2MqwxCzIkwByoAsPh3d7YYp/OMJ5XU9w2ylW2hZ5f7wwkalU3nJ0l5uZg8+Up+qlZTwx8Mo8s2nbLAa/TDZu15EQam6y4a6f7hggZ3xb9cze6s8qm7BhJkN2QvEPAV6CrZNQMM0oswTfE4DEvZqWrq38F3E1pRgVBT5L+kZ5+SQyhq/TiqjlHv+rPfkN3ta5EN+IYzpp2kF5tTuifX8S3l1no/taLg0oYl064Bs1+jRrKJjckSlEyDJO/DxC3QtMo2e0p6B6KxJBhAKvnNhQ89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt1QxISyDo2H3wnIuUW86Ocm9kPFsj3AVeTg/anI5mY=;
 b=jzrid/rVMOLBVL35qhIRRTYGzisDChiULvDi9XgW1UdPwW5rjfNmNmZNpMzPOOfYzjbDqFL+l7Ve3nrEIY3mGLYRNaQid+78U3oYi5K0wKxwhJAoB3rqspTAH564fWhRyI2DjdkJ5aDJRvW/TDfzkUGFE0qN4MHA/PgU06hXjY3kkMY5m+wmmU1aJ5dnkInj8K6O2Qujfv6ZlH7dlAScujPjL2kmZ8+/oGzjDmClh8MQivIbKCHUUVwGVwNWtbzjtC7Bz09Ot+5U39ilFl4n36QYwEJ5DkdKceSI7Fs0crW1OhY8iDB59ONK7DO4Uoar+Twz3kd/rEGdeLGZzfN9zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gt1QxISyDo2H3wnIuUW86Ocm9kPFsj3AVeTg/anI5mY=;
 b=Y3jO+R2SCNM1SKwd1hGiA0x5Op/qJ7Yu7K6LCbsAOn5yuMBIPam+U3V/PUJNWW0r+GENQBMBr/Qp4u+ZZNhJVHpebYS7TSGPi9gOczjypxdV5FEn1A05Jd1ivQsznhpfV8Ey6GLMlKO5wuNxbDOzsnpmsiu+uqCa8XEhip4XR7g=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:36:39 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:39 +0000
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
Subject: [PATCH 40/94] mm/mmap: Change vm_brk_flags() to use mm_populate_vma()
Thread-Topic: [PATCH 40/94] mm/mmap: Change vm_brk_flags() to use
 mm_populate_vma()
Thread-Index: AQHXPEQ2XYWKadS610i4YIBEkuNTlg==
Date:   Wed, 28 Apr 2021 15:36:09 +0000
Message-ID: <20210428153542.2814175-41-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: f9448412-2f0f-4b53-9651-08d90a5b6a4f
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4515D8B6403DC81AF44C4B35FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JWsq/2OG3PnAY8b2Z0jQuysLtqsG7HQV8qZbpWeP/GINFHVmiyCw1q9998piI5THtOUcjOW/xfnu/Vj4W4b6ZFYaHzts5Qz9aHQbAkFlXb1cZL8h5tQagbfMytNekt1q4pLWc5JUxqCYND/2py66CPNvL5+Wjh2HRs+H7LHjhoN0+C+bNZqgzOVRDzjnOZRT+D1DvK/5hrj+F1AQs1h/ZlEqnvpDrv6wx6dobBCKAH6e+GL81rmjIu1T4ktzr1c6sBwX7qnetmCds3euIh5/trBNAcKQHRJ/2I2gIw4GINkhT+CRB7KoFhKHwTLJ/hLdpyEV65MvaJ7xvog4JlLfolG/YUoxZ2cCPazHzs4fwb/3YYdjqqa/A+++pPJBJxD1pTLv8gLpFeNjB0mdRr3sgJ1jaD9gguGWx3wxfACH85OzPVeTXr2s/Gq1ueehaCOGLHVe0Fn0XjWfO5dJ0LwkZ8mzvGIhVlJogB0q+vyNqXIMeFRVNJzwzhoI/Te6TxH/Ii2nM5H6emNI01ERXeeFuyF2O4XUQQcUEt/nZJWOL5t8M4ij9DuxpMqiFy+9NFUhSRmhK+XpnU+vysGzCDXEJIQdOj5PS60NrnoHVPdj8nk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(6666004)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(4744005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?3yqleaCLo6fK8s8LYGbyWGd0ai2qUT0ByUf9vZtziIS0UltKMUmMywoCBg?=
 =?iso-8859-1?Q?IZfHKKWQCthYL8UJbPv9pYP0ghNrg9BZT3+fOfuL4lnXobh5ytbSYZzQZ/?=
 =?iso-8859-1?Q?6plVkMznl6eT2GAbEMMsVfuANhw5annBavCM+Nf3cGD5mAdKUN9X8K+RWj?=
 =?iso-8859-1?Q?Y39z9c+ofJ/4MnP5n6p69RvbkZ7aO/dKqYQwoci1GALULCuCNEFeD+icWi?=
 =?iso-8859-1?Q?lWm7oun7FFE6E/5WxA2HRGrJV892FhLBELNS4U+Za1xNKbVetUekcb4F1Z?=
 =?iso-8859-1?Q?uJjIputBycl4byd/I0gZiRaXYQFXN6I82P38PhC2x+f6qDfOY1cLLSwAok?=
 =?iso-8859-1?Q?VIzZ75qUSZRAl0rP7JYi+T+Avyu87nzea3d6rr27nROD02UQs88Pcgq9LA?=
 =?iso-8859-1?Q?CYbzap1nnxxjv+e+bcZ1MqWqUPVXWDYD8BW3IGYx08O5VlNK49E7wk/ygO?=
 =?iso-8859-1?Q?YM3/9ipb3+TGnJPkesQcswhpvRNACXz4DdcfFDN4ys3MTh7sFs8Yj4g5Kr?=
 =?iso-8859-1?Q?xE7NVRaC8n40hv7epCZfcuaPkzGEeyB/Ec+Pmyuo5ueIJgrB7Upw/8ZeT7?=
 =?iso-8859-1?Q?5C65bJVj4eZQaNvjXQPt2htpCcYYl8Bq4+Mi/4DUZcP0UEefG4x+rGZrvO?=
 =?iso-8859-1?Q?3ghUMpXmvV0j2cqRVwekTWn2A6Qv+MUB1C/GlCakGZsebasJQ2Q/bTLD4O?=
 =?iso-8859-1?Q?FufkAGb82HZTHvWsBqYT/stkuI5CGKqkZnNRm9I3Fpph+kiCLQZGxDsOKn?=
 =?iso-8859-1?Q?S5O5ds4QJu8nfa4MuMqcP09+Zm7s30niDL1oVsRYGquR6MK9R2we6slyRl?=
 =?iso-8859-1?Q?9lFvRrWy3GXAOX0MJ54KSa2OaQNRIhd2izc7nZMCOW6kvtlENfdZeMm9Wi?=
 =?iso-8859-1?Q?Hz4+iCs/imgLHjGRHXDlZQljBBiMoKg96ijmsLl8EbwEldB5LB7hyQ7Xxr?=
 =?iso-8859-1?Q?OsjdcJCWJZ/+g57JhF8Ac5+mXdNHWGmmOAtUrWVkCPaMYJbgAwEWfmHJrN?=
 =?iso-8859-1?Q?nTAzl9CuhVmyp6wlPyAtgAZIsnOQ9Y34xHsjhspMcH5+79XNWZjmLUxsqC?=
 =?iso-8859-1?Q?vhTLop6v9NlfW/Ce2dVaihTkjc8DWeAzTQtLi5S4ZMGPXE3s2rhtrlpyU7?=
 =?iso-8859-1?Q?VmcuA6MPvWBYFpHA66cALBOuS5lWnO2Ii1vD9S/W4bu37ytPiVMpVp+ZJM?=
 =?iso-8859-1?Q?1gee5UJU1AO6dDzzfY6I3petTXFN1leZVIjS/Q9I/pp81+p1PAE6ZSVBMm?=
 =?iso-8859-1?Q?dodwyHaSDSANe6T8oQi4mTZgjmTkdiiB2bSfIvXuChJ6rHaY7l9vMSNQ6u?=
 =?iso-8859-1?Q?gU84bkPcrjyxHjzfnod3J2MhrwmeCksB5wzTMICQ0MIuTJFWye+j9ieaBH?=
 =?iso-8859-1?Q?FRv1Q6hX8O?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9448412-2f0f-4b53-9651-08d90a5b6a4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:09.2650
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hh+Ofq9LSdgi7Ns4RxYQsWX61YWcLv9aZefYEhJ6Jdhg3ffZTelRQ+uZ3cHaZfOUovCjKXx2U1QGss/q2BXUQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: Mgbz5hzFI0ksyiR1V-DYuMEb4yGyE3cX
X-Proofpoint-GUID: Mgbz5hzFI0ksyiR1V-DYuMEb4yGyE3cX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip searching for the vma to populate after creating it by passing in a po=
inter.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 6671e34b9693..7371fbf267ed 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3004,7 +3004,7 @@ int vm_brk_flags(unsigned long addr, unsigned long re=
quest, unsigned long flags)
 	populate =3D ((mm->def_flags & VM_LOCKED) !=3D 0);
 	mmap_write_unlock(mm);
 	if (populate && !ret)
-		mm_populate(addr, len);
+		mm_populate_vma(vma, addr, addr + len);
 	return ret;
 }
 EXPORT_SYMBOL(vm_brk_flags);
--=20
2.30.2
