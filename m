Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12FE9421C10
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233403AbhJEBgV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:21 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:20062 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232476AbhJEBeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:06 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19508Mdn004481;
        Tue, 5 Oct 2021 01:31:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iMg3B7uuCHKOKtZL5pSMoIkBipoLPiqsUE4VDMZHIM8=;
 b=D7XDTcKVs/SQyOeqLSYVtPklOHQFW+LOr7nXX8Mkhw45FbEvL6+ZP4IByNp7cicsK91r
 ZY3+lJ3v+uC+BwC/qYuhRR7JS9XysqkOtRfqULVMA4FMrhus1w/n0rg6u1H8YDIZ+CUA
 gnxvzraBaY7DGZ0FslMjKyjJxe5KquewJA3/Q6k0MrCUxsfIqMrcK3AGtqzmi765H1P8
 NtP/6u45FQJkzIC4/0vTqzkVE7F/FCW6WlrsAwnRJcC8UxlSWZAPgzxhJ0eef7MdxJBs
 UyeLiJRuXKmLRxmBtbvQd9ZJ1ujfSLlgQyDFwWZ9ubw1YBFs9Yfah3zB4gvtXvnuv4y3 4g== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTY178361;
        Tue, 5 Oct 2021 01:31:35 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cIKYxUelrdTz3RGYfCOOQJM66oJMfAS2ruaiXE6CkNrESciRvFvZ1C7MDroaSMXHORlJdXMquCQ8jgfRMNJnV81FHCy+vUVyE2EZ7VJkjxDGX9FdVgBs7UZALTe4YKz+Ii0xae8chL6CSxjH64lYuP/UjZkuE80hQx2HdglYJUj0imz+DIT5n0cnau5mW4lL9pIGgkE0lem2RIUXBOQcU5LyeCJzMKTrlpADnoHd/JXYMuHRyTXuNjbsiwZZ/FqvIQmMBLfQpE/3rzK3BOUmNQ4qWRsOkhG/V+q3QaUCE0B1Q8zS3gm1bVbycoWNPTliyOehf/p9FxFDIqxLk1OTIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iMg3B7uuCHKOKtZL5pSMoIkBipoLPiqsUE4VDMZHIM8=;
 b=bxaqeGROK3HBUIfk8KQ3CX2ccbNf4m+JaQ25DWlx094neOXvG2zJ+uWpEJel52RkWcBQLUowxM/zgkUpf6wgKGfYrd5hhw7+J6b9wzd5X0pMsCC5DTyCBV0owev6WOpeDxi3SO1nJqTeBnK6pc5qCd2UQHpGvN044GXom1DQwpGAiJDOm4gS2YzimkFVQgk7/s7B6wBtWxEYAJNhmqQRT2d0e2G+a2+uftR84qoEX6aOV2Mv4tZNGl8PqPcJeNlj8EmwqnwxLAXvEVvhsnXRd7Igf5qjJrDtFD9OID72cYVpzXR+8Qv0Zd0UmWslI9wcQ8uFYwKO653VDAw221w81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMg3B7uuCHKOKtZL5pSMoIkBipoLPiqsUE4VDMZHIM8=;
 b=FE/Qo1S/cjjzSizdqAzvIYolAbDO4AC9c+9kzIPRW2osOS524oAn/t3m/E02M0fpNdzmCuHgr7q3gClPoG/y8QVD8QyB4h3XUJbbxZ7o1KUGUU9ypYwpoDfwmX7gvnSCW6kYxSOPPHMR58N+r6nCwHD39YzSSMeHo4a/tDXig+E=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:27 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:26 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Douglas Gilbert <dgilbert@interlog.com>
CC:     Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 59/66] mm/pagewalk: Use vma_next() instead of vma linked
 list
Thread-Topic: [PATCH v3 59/66] mm/pagewalk: Use vma_next() instead of vma
 linked list
Thread-Index: AQHXuYisoM7mNSFMv0OKmB+sc7oDOA==
Date:   Tue, 5 Oct 2021 01:31:09 +0000
Message-ID: <20211005012959.1110504-60-Liam.Howlett@oracle.com>
References: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
In-Reply-To: <20211005012959.1110504-1-Liam.Howlett@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.30.2
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1951d266-ebcf-4112-bda7-08d9879fd99a
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50440554688040E4B2A96CBCFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4AUVMQ0/j3zhDZxmzSfxraCfC0OVmL4Fyww2wPuMfxpCecKgijZFt202eOVxoCWouGYeRVYFNHFO4jZ6ahQbTYDPs4qgZA3MKS8N+/a7oR9f94vPWvz84TxwUMoa8Ur6dG/+9UxlbT0YLvhwsQEUuPRiFDA1h75rMaPMl+Aop0tQAb2JxmkrFG4oISnJLKKzYSh88wewx36zzq6GSbSL+3YZ7SWvwPjuUZZKJc3K5JqcjjM9HhQBO9GFdhvCv5GYOOZZXfSox/4EUijUSDRgNaCvzCW/haHMs1fLmu3cuonrmYOZwG9K+75d6bJ40EvvEQHRaRvzYOV62zjoueyGl+gZuFxOBe6D56v4NI2xBRiZtMsfsjvugdspy4NWvdcNS6HX72vHHUUcUDHuxs509MqZdTHt/1+jvhpYfXEf9TdCctkIDjBci42tie0/9MjKFvenz486pUhA03iw2AJKfh8n55VOJmaX+TuqkdQS08Uma73ijr4iaOlFQc2GoHSqRKsKZwZDTnUaWjL5KcDYMUNLjL+H1cMStux2iIe/ihog28pN2zNrgxmFkAjq849Servc2xUAGdCQZ+12/65HPSpZ73xU+GGr2lnmSrZEDx5OXUbn1lAs0ufQ9JAEo2GTmKvioimH53CxI86rV/MB1IvADT76WJL7O4iZ4xZGfmZaxfAVifX53hJP4edJPHsW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?liFRqnRi0Tf++S2Od8VUFIj6DrVCjhxOV0ZV0J4viqxMGjvuUbrfgjHobV?=
 =?iso-8859-1?Q?hxlCkltuz7lvyUVhh60J6V4qEaJjgMa5ER9wFMIdiCWMNsLY1QRKamdPIx?=
 =?iso-8859-1?Q?kdj0uhe7rWPPdjBBFMkimmsiFO2GoXPE0mz98kdgp3ZSbDSChU5+WUoEAX?=
 =?iso-8859-1?Q?mPvCPB/OLdIpPNJrhlb/qeLXTW9nLnKgBZ/wwg/DNcJUbOv6wxsBV6nb9h?=
 =?iso-8859-1?Q?pCCDgalLsUiEjkRfl9Lj2PyAbuwj2Dxj5mKhKXL1WvWsONkiYtcI6GvkQ5?=
 =?iso-8859-1?Q?+DGdkXfF+ZIG6lttZPOlCG3634zd54uJkk+vUVasDdzHV3L+ZbfawxcJNc?=
 =?iso-8859-1?Q?RRFh/r/0gfrT2wu0BJtZtav/Z0irynmt5hveS9BDb9BzCrSIjLQxAXmx77?=
 =?iso-8859-1?Q?9jxFDJkvbjwey/JIeOjoVtx+w4Mke9vGINQuOlge5jfjtdRiZEcWK/dPxZ?=
 =?iso-8859-1?Q?Y/bHYKytXAuipv3i+J9LWBgVt1YvEo8EQVGyj7MyhGGCNVZpZhvDfZUKWY?=
 =?iso-8859-1?Q?r38YPagxua+DKjC9FRtssmLK5T7e04nAAg4OR4N0f/UJdyRk1CRa60OH/v?=
 =?iso-8859-1?Q?FL9a9BEqPC4gcdLx5Ve2zs0EAJzDP7xIbA67x6+YI7l/mDA1I121GKpvjw?=
 =?iso-8859-1?Q?i5cmBcwRG+gc/XKrXpF4cOR5C26k/XZUp3toIsZBRbmefiLr/NufWu8a3H?=
 =?iso-8859-1?Q?QI3UGJ+9LCarjtm4lJc2yA7J4PWDsCE7XUMtgz4+WBqCcpvybwAsnUjuAO?=
 =?iso-8859-1?Q?W2jfeHxM0in9+ZbBE7IqdhRiIw6j0UgjuIWXu1a1lfVL9qmkA4F2sjPV3W?=
 =?iso-8859-1?Q?3FXVxn+kfbXGh+I6EvC8fd/qRwg4+h/LcTWFhnwzBn6D9kw3A2HbSop5xc?=
 =?iso-8859-1?Q?j/GAImpIhkNY08Oa2NBR2EkuEaVMZzXc3zhBmhsw0073eCEIPk/XpEdjeO?=
 =?iso-8859-1?Q?ZQ6Gu/LCpOUcpS8rWSpjxRGBjpiVX9nSq/XFB1rqf7eYlPE6u8s9bnEGZi?=
 =?iso-8859-1?Q?MKtIPAEXl426LDeA764klVCgoXWuOThTr7JMDyXwdECl42uJbrSdW3G4m3?=
 =?iso-8859-1?Q?PMBkoV6LprY38z46R9bOObaK6TPBwth6NrSqaqiqKjqFnH7OMNYEQFqxvN?=
 =?iso-8859-1?Q?y1a4od7JQPt7A+8aZF/qhOkpFyR2ZqFk4cScGmzwnIH5AQdE7e1sF0FdaY?=
 =?iso-8859-1?Q?MluQ6aqfTfQwbKHpSz6X/hKaN3Y9EPr4xlWnnEx4Ape4II+zCiLhIU6IHw?=
 =?iso-8859-1?Q?s/dT119YnuFeRf9ZQmq14POxp/eRYz+NSN0RxCFsdRYHrP5wh2VTzRCKwn?=
 =?iso-8859-1?Q?os6CPDblUyf0ddkdXs5LOLYBvRbim97zduE6+A87ulQU2Pt+NxbCodgwbI?=
 =?iso-8859-1?Q?J/NCyZOY5l?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1951d266-ebcf-4112-bda7-08d9879fd99a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:09.1684
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YMzd9dhA3KkUMfWq21I6igINmdZiIBryp+y0eJNisGp38o2UX38XdUfUlFD4IDjU7teP8LyFcek4ZzCB4lKGBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: Tid4meKnnHtcSIygybmt6LHEdiRUyebw
X-Proofpoint-ORIG-GUID: Tid4meKnnHtcSIygybmt6LHEdiRUyebw
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..d3c65a45fca9 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D vma_next(mm, vma);;
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.30.2
