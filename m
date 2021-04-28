Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0549836DC14
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240954AbhD1PmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:42:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45470 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240615AbhD1Pid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:33 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOcnc011645;
        Wed, 28 Apr 2021 15:37:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=JZTdcmtDA8prqcTZmLsw20MmFhInr/KW99e67JqsdSo=;
 b=rhIhNd4wzm3wqUdxwLYfQzlPVPvtjtZHQGEyfSRmxxZktOHBm2xyY9lUlugzVxFuM3B4
 sHdp6dGzR/vH2DLaM3+ZL2EdUY3R9l3JsZ5SCcna54RYGYlg7eRUbM2x9HoAyjKboWcW
 btd2AnrYGF0NjabHV0ZushomCYB72/sEUBo6h9inQIk3ENs+LIUKhyjciiCNpjPu+3/D
 E+eL/lgYno6RRj6AvNVdY0VaMJCnuOpw/T3QA80z1sz3hSN+Sv8xF4tSMP6xK8mPeYn6
 s9W5I8oKRNTNNfAw1LiQ8eJ/WfJA/gpCtYnvCq0NjyZRr7cfl8tYlrnDhZiZ4HYL2QW+ Mw== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 387891060h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:30 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbPcf024423;
        Wed, 28 Apr 2021 15:37:29 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by aserp3030.oracle.com with ESMTP id 3874d2765a-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fUA3j5HTFaiO0esDCxnIAEel/uWIj8XBGMXxT8KWY3rXvdiZTKUfewMsnkhC0cBgQJ2UJ0jOqrpcznkCCaV8iMVq115MPqSb4ai090wrgnDxEHYapuIdKeRV8tR6qjktWZFoRYe4Hc/4ejYGeoqryiSTcIEmR+Y6+HsNIVk3J8g2aZr/V9Ratvvr79T5z05gWG7zYxyK0cLxsYNJqALpvUAXDIaqeUGbJ69KQFhzGXDuiE5OdH8/jNB8YhYR5LfSv8xpyqNDNJ9/JqHY//+SPZU1T6Ug615bq1dqRxeKSv63qxkWCZf/X0BdhFmVev5FrwdjASyyc60MvxBaL8khaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZTdcmtDA8prqcTZmLsw20MmFhInr/KW99e67JqsdSo=;
 b=Pa05k1k4MkMDlxsNXPqty/3jRbRmwn8cx1LGLZrXO6p1ChbrJXWkll+HvBPCn8AePtP/RCIcGxKSMCvzzDMhkfaMerm8zDsMvtCmS+XRt9TyvgjjaM57A/MViRjt5GkpiSRG5sb4wRS9XMoH20PjGROBl7swVkN0JBKPQznjpb+tI0bAP77p+4BmfXFrqylvHIjrvJD81BelhZsYMDTa/yY4FQDPZRVov9uwcxaLcbQprTvjVfkqkxFtwDFUVR755qxYRHSRsL/g1xyOibjfUbrVAkwRj3O2skg3Ewod4136xWin4YqnXzNgprJOdHDs3N3PhLBmS2ahcw1q7WUnag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZTdcmtDA8prqcTZmLsw20MmFhInr/KW99e67JqsdSo=;
 b=i4zD6l2MfSWZuVhA3+IXOiq4kz2HdOXfGse414/to2eAsnmVOBLFpm0/JwaJ/hKNNM4ydimLgIwUQtL96IKFGsCu4Z1y3dh4ae8cJ2gvcr9oZRk7NY3AfHpzgpFgpxRsh06IvLAeQwhyJZqVGqL3AMa0AIWX69+plGE9TzPb7NE=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4548.namprd10.prod.outlook.com (2603:10b6:303:97::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:37:25 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:25 +0000
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
Subject: [PATCH 78/94] mm/madvise: Use vma_next instead of vma linked list
Thread-Topic: [PATCH 78/94] mm/madvise: Use vma_next instead of vma linked
 list
Thread-Index: AQHXPEQ/pgZFtCJrLE6xTS+4DKkf8Q==
Date:   Wed, 28 Apr 2021 15:36:25 +0000
Message-ID: <20210428153542.2814175-79-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 6bd95723-fd9c-45d3-c9ad-08d90a5b8603
x-ms-traffictypediagnostic: CO1PR10MB4548:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB454800A61A4CEF806E0DE653FD409@CO1PR10MB4548.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WDHVR6R7NaJ/v1wkIu+Vs1teaiFblylRKyQNfFC/V0t03RpQLbsmbUMGOF9r2hCTj/9iDfUZB9iOhZB/vc0UxUglB1wBy88QYXj/BaROvp1qfLwjoKC4N0M9OMpf1k0HX3bbVv84RFP8/Wj1+rPyPIOgUSZEdyhX+CN4DB5pIfnlKAxWqKBdBd9Zbvz5zjUS7YwOga20kMjP1jjXCTFtAwRgiiSdaSuEolOzQWk4f81LKd74B5+U16fQdMRt/Ai0RVgL164/Uf/FT18zvAaWAsXY4t95OJ9Tlw9MnMGUIvDbqHlLhcw4XaN+ZLS5xMbpTJQ7tLzibR1JQfgMyFV2R1vDUhJ0yO+JH4cqrjTLaC9x/p8dsPqMh27irF9ewr6/ptQeYvvMpOST1lXQlymntbZceXOqdxQCi3ZTlPCeQMIbusv0msc4K328SuCl/BNlX9VUEm35lHBElJgXb189Mmg/5oboBWL1gYoNINgFurviB1NvAa0bi5FkNt9gsbIIqFF5opG9SFaOWi5CswpQ/LS3ikr2TvfTiQo75NuBBfBuV9j0k/3NVTBX46rreE2iekh2Gc+0LhqcbxMUAnldFZRLHnn2oGD38oQ33m+BJZU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(136003)(396003)(346002)(39860400002)(6512007)(66946007)(8936002)(186003)(83380400001)(54906003)(86362001)(478600001)(122000001)(4326008)(76116006)(1076003)(107886003)(7416002)(110136005)(38100700002)(26005)(2906002)(2616005)(8676002)(66446008)(6486002)(71200400001)(5660300002)(316002)(4744005)(44832011)(64756008)(91956017)(66476007)(66556008)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?yFwVm/1KeG06Ux+hgTicT7B7dtTcktxCNqtV1pQHDgpPSQEIF8+BtrdtHb?=
 =?iso-8859-1?Q?NGNKOXC+oPCcaR4ft7aewFVCPs8npAPZNvnU4exhNzjIlraqtExHyWSdDL?=
 =?iso-8859-1?Q?Zcp4GifTObs8I/1i5+STAFTbvdS/LbzNOcM47TfaxsgXunIKHBvLXBcg4w?=
 =?iso-8859-1?Q?HbVyAcY8SqSw4fBPiFM0pNNuGdnpcd0n9YMKT7Um0s60N13ulaTWENWU3b?=
 =?iso-8859-1?Q?ZLq3cEs8s3PjOZff0zR3DVIZa/IHZv/ZXPUfN+E8Bxz0TCKMh8uTUt+6Qf?=
 =?iso-8859-1?Q?cjeO4CkgYwJMm5HixKsUR+wRhNU+2C9mW6XLxvxZLntW4HLBNcFEeo62uN?=
 =?iso-8859-1?Q?umXwVthfE/XsQ2waSPxQsbfBTfboABK7f/0xN6UahNGpJ2I6Xuc22/k0zB?=
 =?iso-8859-1?Q?EVh0ueZ7wlsf/d9xC/qZ+K+7k+1377hsO0hbSK9WcEkGM5bebzjRvN7wvp?=
 =?iso-8859-1?Q?nkGw2fvQAuXo2wBnyXrnEB4QBat18kPdGUvOwT6I+WM/Oq9VknwYX14N5N?=
 =?iso-8859-1?Q?QuCrzE4Km7G3KopZIsfXrsCLxNhdOXkE6nFF7lMpLn9GIQZ8xhcem/80fE?=
 =?iso-8859-1?Q?5ADnUJ+aP+PtXjoHsgUpFRKfww/UFtOaBltqGA1q/pUV7AmX2ebkvTGz9B?=
 =?iso-8859-1?Q?0Bqt4rhGHUqYuBVkgeu1th7m+0LiGxP162FLm7tmFb6cIPUYyzuiUkeSrK?=
 =?iso-8859-1?Q?cHxT6Bg5j4e5/LHGUDttdmzHTQNX46knFvEIDhqqhk/oTtizDp3TmH18iT?=
 =?iso-8859-1?Q?ywwVIstQ8YTdWMfbWPPACCnGtm8mqKyEhIdELfYGHaA7S1WkzfOH2RBzgm?=
 =?iso-8859-1?Q?IaV2nKNgCcQjajKNUdvFNaKfJ4SR9DQ0zvk1bNmgOvk9f+4IRPBLgTT0T/?=
 =?iso-8859-1?Q?lL7vDRezZgDykAKwORg3jJQdPy40XUYWft06Sawsc1GQnhvDtox753hnpk?=
 =?iso-8859-1?Q?iCbj8fdX/VolNWyfGtj7zaQ2gDDHr7TbNGlO4k/jt20oLMmCZu34BfdDlo?=
 =?iso-8859-1?Q?9TwvhV3EG8PdPLXlONBcfKHMl+k+Fq830zuh7bbP8Xzm0OQERgP4coiZ2g?=
 =?iso-8859-1?Q?HUfk3hXz5if4ZJWrBHT7oNp1UIa0IsoFlXw9jg6iKBsLcEU63BAU3iEetQ?=
 =?iso-8859-1?Q?ElthssN6CR7bSVBYrX1s+XkF02fOJfgszJ3VdR7X/3YhqjuxvrYxVGy00S?=
 =?iso-8859-1?Q?Epq/j4zXuygNY53LvrWNvAwldY2fuelcioiFM3B8GppQl7vCQZRPd24Qr8?=
 =?iso-8859-1?Q?GuIvy6QRH4EveAt5UosJD+gG+/bXtMQtvkd/jX9TykuEdlVPCC6yhVZP1c?=
 =?iso-8859-1?Q?vPlGNFiCXhTNA0ce2GNzsVlpfyxRFGbOulfIhCeZXlZQtb5SHDfH0uIqvp?=
 =?iso-8859-1?Q?L08KdERN/J?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd95723-fd9c-45d3-c9ad-08d90a5b8603
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:25.6747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqSxdJ40b2tXv77Erxa6MwGQmjp7UeKzmfPjvr1FsCf0xGY358RESTYtEJ220V3s7bLgqJ8fMxTAjz1CWh1fSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4548
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: XCZtUq6l7LQzSo7QAf5G32anMt9IOYuM
X-Proofpoint-ORIG-GUID: XCZtUq6l7LQzSo7QAf5G32anMt9IOYuM
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 63e489e5bfdb..ce9c738b7663 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1140,7 +1140,7 @@ int do_madvise(struct mm_struct *mm, unsigned long st=
art, size_t len_in, int beh
 		if (start >=3D end)
 			goto out;
 		if (prev)
-			vma =3D prev->vm_next;
+			vma =3D vma_next(mm, prev);
 		else	/* madvise_remove dropped mmap_lock */
 			vma =3D find_vma(mm, start);
 	}
--=20
2.30.2
