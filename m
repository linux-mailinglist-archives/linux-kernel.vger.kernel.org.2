Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5E7136DBF9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240765AbhD1Pk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:40:26 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34860 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240433AbhD1Pht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:49 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFMvOW009401;
        Wed, 28 Apr 2021 15:36:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=XOTNjS7E+tEDnUq7HfSP7x/TEj2BPak/qE1wxLhaqPU=;
 b=qFBb/DgAucH98d2mKOqUiRy8AKSVnokxCxwtN2T06gGMFZP1bHC8/QrYOYBcYmzSxijN
 oNxt8PJCRl6yNyt/1PE9IOIfzFxDlIEll9mdS7SA6Hxy4j0hSZiDrz+uLZPa1/Jcj+GI
 JbGYK3e1L8TRNYZUb7lcf/1gNtKdU1OWfVSArdbI8eygGXVID1Mc2dCPabVcmg1kdHZU
 X2mGh5PXqe+FoJAmFoh3EJ1sNCdWy0qhyNlbPOcFXGaCj5qfQMn/xx4nLnGVkarb22Ki
 mknzXPWqMSHBYsDtIjLfxms2IjhNPgrmiptZTImuK2oleIElMtZTsR7DOy+OKQjECSkJ SA== 
Received: from oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 387a2mr0v7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:45 +0000
Received: from userp3020.oracle.com (userp3020.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWJwM016127;
        Wed, 28 Apr 2021 15:36:44 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
        by userp3020.oracle.com with ESMTP id 384w3uuaj4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IueFaOsjoh1y0PcC9TtkSlx0yRGPWLkNoHun0Ad27jOTyftd/L9PtmL4/oCDm9KF5e3FIrs5zSAPoGjSb7ai5ife1F42eV2NMlO5pq0DW+wl39ggi4q85kJf3Wws4eC2SQq6zwXwVPRw3pyse9wSXPhYspdA58vYTvNsmUhi5B+XRuIsaSMttpmia7+QrhgRiMhC1R+HpenElYGzwi0vVqPqOB9sRQ8vqJ71HVwQCylHkcqw62iH2j531cumCB0M2Hz2m3W/Jmq88LnECOVchzV5fC6Evz2t0mzYJ+MLwlHfuh1ECT5eUC0rMB/NV2iOxw6b0aFbYgKJrqAQ3yjVyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOTNjS7E+tEDnUq7HfSP7x/TEj2BPak/qE1wxLhaqPU=;
 b=Has7l1IlfjIOSjaMF8C3p9wCkP42jYYglllUf7erTSw+u6Jjvs2zxResDRv2njaqvQo5lESVhdgEJ0DyKm3hSMHjSq9Is+x2joySCApjzCQK02OisR2rY9ltmlO9yBEI3G1t/wUUnpDyiGgg8WHcUJn6KZKzz+xwGs8BLh2Ui7rDGYBjIW9TKNwAEIRBqY4KByyd09jvWzGmkXgJQS+jiATOFUoFLHLuw2oDPYEiSNF/SN/DU2RdEQ38SI0niq53upOJbkE4lktlqeET/IR7IAjJuWVig1ZbGsrwksO/A4mF1TdwgD71fG63pbhGOJeLOsj3t9Swbs66/m2OPO7XrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XOTNjS7E+tEDnUq7HfSP7x/TEj2BPak/qE1wxLhaqPU=;
 b=KvwEnH2R7Va7/niEz2mNWh1zSnlJFeSbdUb4vOVA8ShphGExptGmAuqgDTQD06VqGdL2pJvDW/wE0X+mu06hcLW/5RE8AXx3JDXRtpWrv8xWPc5xvDLyyzZTuYlIlqcImTfkTXQi6UH7OiWruXA1KxTyQH/ExCcJBYnQZvKb0ns=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by MWHPR10MB1982.namprd10.prod.outlook.com (2603:10b6:300:10a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Wed, 28 Apr
 2021 15:36:37 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:36:37 +0000
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
Subject: [PATCH 37/94] mm/khugepaged: Optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH 37/94] mm/khugepaged: Optimize collapse_pte_mapped_thp()
 by using vma_lookup()
Thread-Index: AQHXPEQ1PymdabimTUu/A4Cg2b34EA==
Date:   Wed, 28 Apr 2021 15:36:07 +0000
Message-ID: <20210428153542.2814175-38-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: cd91c41f-4868-4d87-ebb2-08d90a5b6989
x-ms-traffictypediagnostic: MWHPR10MB1982:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR10MB19822EBCFD428DC362534347FD409@MWHPR10MB1982.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QU/0TOwzq77x8213QJopVWg+WMJZ/AYd08j73gD125xcL1Jl0k7FmlprbWgy48U+zPdTRPPlScikmpYWXaF6qsX50QXKeQsu/KY4JkWCWxHPyV5CAeSxhzQDEt5zyVDpXgSKSAukLqZv/wCV7DrWGlZzU1dIyk/DRi8VnJvuJderWBOTwKJse1Li2c/Zwz+z7dBmrFxXE52SbKNUaHXdarLUzTrKQop+pj9z2uLCPQppw80c3Rry/TU+h9bnTXaIQZfZnUaYpgNruBfmi6mQvmdAeBqF0n4RmXtqzQYBucsbOwwIwkaocD2ippbcbarxPn+tojDSCX+aLIgmqM2X2S2+25kBWtCMcyfpssnYEGIFlZ829NrDwVg7ntc7bfkfOkEBK6QpCvUSh0eU1Y9sqe1pIRI2dyCkdZswiEv33Net4S4g+xlTCzM2DzAZQeSsw17lWulEnhgZU5x78Pkbc0NJdQhZdvI1QaKjRKSjftzqT6SS3tor7x4dGP+XijSx2BqlBTu3aa0h5Cc9X4k4kf1KjYxEkTrhDqfdWdwhuUawiRzNtJhhrgYQ5KxWslWkuYrFp7GnhzClDz/vqkblwt7eVCQpETrXW0AQ0hGWNaQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(396003)(376002)(346002)(39860400002)(2906002)(8936002)(6512007)(1076003)(66556008)(76116006)(83380400001)(66946007)(6666004)(2616005)(7416002)(186003)(26005)(4326008)(110136005)(107886003)(4744005)(66446008)(54906003)(6486002)(71200400001)(316002)(5660300002)(38100700002)(91956017)(478600001)(64756008)(6506007)(86362001)(44832011)(8676002)(66476007)(122000001)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?4vPZNpLSXKHrhg6E5oCC6Uc3/95lVAeTB7ReGDm7SLPFOhVdMSzhV6PNSH?=
 =?iso-8859-1?Q?HanoMMcWyKwKlbRxCbfhdVAihHFZBti0V9nkgkJSNHrLe0Roib/li9vBGx?=
 =?iso-8859-1?Q?/CK5ldrtbaZqAlzUsQXclXnkn20x3EXAPaocQ4AxAC74XXkrwno/O0KITb?=
 =?iso-8859-1?Q?Xb6WfdTvLsFmbqxJQ4oSao//51metxCUm70FDpMmoGZsFmVGyCujSETWVE?=
 =?iso-8859-1?Q?unK6fqAHMJ1JSTxb7/f/G3nG1/qvTKYxhQh+dBVCk0Oe1YqA9yo/B4WEXd?=
 =?iso-8859-1?Q?yCrq4t53DfY2iYKhTICmN492/Ck2qus52o6WHWXaZ5eU44MBsLivQla7oH?=
 =?iso-8859-1?Q?dG9m6Qm36J70yarIGvtlWD15CR31wLiL6XcoHQp7OfHRO5/dzz1wbkSLDS?=
 =?iso-8859-1?Q?x7C/7GGK1IlF5H6ic9e83GgcncXWufhxIoCoBYHirjMRBvbMxPZtqMrLk8?=
 =?iso-8859-1?Q?aWIwH424USRUJfj0kugUMsJs73ssqAlqJuKHSuTfD4fFgIj0o71QSsa2Bb?=
 =?iso-8859-1?Q?8CP+TgAeU7L9eMVEGJjP55HkJmjw7A3jQZmP8VmRD1kI59D+IRMVC5tUpx?=
 =?iso-8859-1?Q?bnu3yt/x6UiQFUarPGfL1jvEud2NnQpIUd9KVEmnKQBrOHI/rqKRqvW7ar?=
 =?iso-8859-1?Q?aLNPHGYTOVb90K2Sw0PTrkL9kmwOmnheV+sssJu/MIxPCphXl+CSTsm0Pe?=
 =?iso-8859-1?Q?TgT/+LL0it+YDGmTGGoCUf5ljyozHAJr5x9dagGxNOq1JjF1HQI0+3KXb0?=
 =?iso-8859-1?Q?9Hg6W56AmxnEzliS5AeBK8c44Vrp0pEBm+57UeCRUmhGA5aaoRmPMMhNfB?=
 =?iso-8859-1?Q?9XAzyj2NdVYnCN61OIs6pRoX0IiOUPsnlLSW9mnq0kq97o0r8epzqV0AcR?=
 =?iso-8859-1?Q?2xPmsdUYZkRAnDDiYuM4vxJ6nVP4H3RYUzuxsuW+QGwzXx3esDR+U431hQ?=
 =?iso-8859-1?Q?ZC/cD3S8QGEl+1Xb1YDC6qGGN1T9urYgpjjjjEb4X6XoTXwvGZx14DhmBX?=
 =?iso-8859-1?Q?z2FyhbXlCGznOKPmYk9zinrejdsmEZy1bARFiKhhyX5/Cr63djuC2vme0R?=
 =?iso-8859-1?Q?li+FBusRXQV22tYLlvy9E/eC55JscgOI+r+hv9SkzqnvCQf7YwiQ/TYtS6?=
 =?iso-8859-1?Q?IN6D5FWhGzKMBrwe8dBvDuURZdRbz8pU2rYL8Q9q6+SYLVWQps50BCa8/p?=
 =?iso-8859-1?Q?mNysuNUsDJe5RLj8DPTlB6rfcYjtZakayKnEcvaan33q3yZIUNcEn6pn7d?=
 =?iso-8859-1?Q?0bIPkCoaQmMbWwSs33RkcM2vEiq7WFPDlh59wg1gtfmU93LrPiHRB3/bs5?=
 =?iso-8859-1?Q?XRkhL+ESPYYO6Ew0CknaouTePToW2KMpc3Gda9/6TKl0eUmIyzoNn+DWFb?=
 =?iso-8859-1?Q?A4mcK6UAm4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd91c41f-4868-4d87-ebb2-08d90a5b6989
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:07.7007
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVn3TYuSyLwWQVE30WaxQPzUQJN8S4Ziqr0K9D5nB592FivQT1EpQ/VBW278k9x0id7H1H4gFYXNb0R3T2Pb0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1982
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 phishscore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-ORIG-GUID: yVckVIz5jEUXHDxtdxTb-ISl1hudBCbz
X-Proofpoint-GUID: yVckVIz5jEUXHDxtdxTb-ISl1hudBCbz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vma_lookup() will walk the vma tree once and not continue to look for
the next vma.  Since the exact vma is checked below, this is a more
optimal way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6c0185fdd815..33cf91529f0b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1431,7 +1431,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_st=
ruct *mm,
 void collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr)
 {
 	unsigned long haddr =3D addr & HPAGE_PMD_MASK;
-	struct vm_area_struct *vma =3D find_vma(mm, haddr);
+	struct vm_area_struct *vma =3D vma_lookup(mm, haddr);
 	struct page *hpage;
 	pte_t *start_pte, *pte;
 	pmd_t *pmd, _pmd;
--=20
2.30.2
