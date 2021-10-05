Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E218421BE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhJEBdf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:33:35 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:26544 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231290AbhJEBdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:21 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1951Awbm019258;
        Tue, 5 Oct 2021 01:31:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=qxtTeGCUds/04T4FwrH8+21nYX8A1Qqp7Uqq/HsMC0k=;
 b=gLmrYOHz0/9QnuEPNphn4ixqKovYyBCU/BWHiD1HFvrTc8AdAaGYVf7Ifcxz/Zhfv/wF
 ODxetC92ycPge0fpOYWL3CVC/ibHLKufwj0ZJI3GeZxevCH0MgJXyOWR0ZtVEg1fnOIn
 fm3H/TNwp0hgiQ2W+THz+FYR9pVHPrCBSb0JfQDHYLpEcWXtXf3fn80HzogrNdIzQNpe
 mPeOmiw+YpEvbgMtinKRzS7Zj4Ca4CQwu0GX4VxPwcrI5T2TEOPv9XmeUPWFh4SbdxVC
 2Z2fipOn3aPQSoZbj4yPxxefduEznGlgjx5kvGG7RqzZXFiLqxyx4IsMVwKdoXzcF+nj 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c983-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UdGH141634;
        Tue, 5 Oct 2021 01:30:44 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
        by userp3020.oracle.com with ESMTP id 3bf16s9dx1-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:30:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7pM38MSdUfsMZyiM16DujpGq0NXuGfvWj7kcXSN0Zg3HEAVPd+Smk5bn+/3ucirYVllG5dJu2N6/kMi5KoEDYYXKkbW1tl+dc3bgKnGUHxBxro10MnviswLJsf9moeltt6SM+9ZLoB1nxfOye+vG5ELFzUI8GasqxtkfOij4ZNJ/LzjrHVxUYpVopidhL36jUovMiWOD9f96tAEC1Xd5OdJINQxf9jTbXszVaOFGWdVWrsY2SnzKdwnjRW9VfecrROv8IKaIJ1G97PkQ3HhArnCMkDnkwExoOSN1/u25MaWooS1/XzmQLku5dPU/LHSfAJaQap2tMkwS7gP6FtfTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qxtTeGCUds/04T4FwrH8+21nYX8A1Qqp7Uqq/HsMC0k=;
 b=B9G4Eb4ZbeZUPBtsATILmdKQCDnuTfW0wicsgmL9fqqcXPlP5XIlPpGZdcWwMgcGFbbhYE3yyhiUI7INUPC2ic50PnROMf9TAtht+sc72QVoQjTfPnpyXfmofs1gpaAmxTJQw/ZhYCBfONbj0LkToFzVCQ3C3m7pbu2/MioN51pqfaJu3XGeVyasRPNmjGHkogsTP6C0ea7eAAM37/uRwYIcV2bw1B9lJbnTEpBl0hk4scqI2VDFAcX4B/XTO1P2A9cvLDYXg1Q1VDGIfAdrOZJwsbYS29BZjhKfClotKC5JV8u+BFTC17CWMFGcLvdxkdJIn7OtMIICSExkDm8z9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qxtTeGCUds/04T4FwrH8+21nYX8A1Qqp7Uqq/HsMC0k=;
 b=tqxV4/1RZFjlp+BG+CdZDlYqszbwD9fyoMyAkH36HQeRm6G+3mSNxrmjE7xfzbV1hn3x/SpovxN9IQIeZ0SfQwes/px+srAi5nyC16Picf8Y958ygUp3Fqd2jc/o8ipkdxTPpuUkTWZD3qxkdXPoP+W17wJxnroNoiUijvU6yyI=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:30:37 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:30:37 +0000
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
Subject: [PATCH v3 14/66] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v3 14/66] mm: Optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHXuYiZ3KYlGR8qyEeEYFBgvKGAsA==
Date:   Tue, 5 Oct 2021 01:30:36 +0000
Message-ID: <20211005012959.1110504-15-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 744a0a90-aef7-483f-49ac-08d9879fbbf6
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50441D499365D035D3FF7979FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XdtW8ZTHAhd1fjLwAtp/I7w221EsdA7Cwvh5OtohKXsAEtuAhGPdwToH1dhs5gykmYP/eT/PFpAtDwaWB7X6/5mhD/oWgIDynsJH38vSizNzNpAF6Nxfr1vGU8FYLVCAMbyK8z8Dteb6QuVtXql8IuCKxuc+Xap5r9G/FczcdPxYYrlFqBIr4UDAe1N5i//tSR7J4jgd+6zdVmX0CVwiU+0o0BxEoI9HYUkDnd+5uDa1YMhuyHxxC726lGVVtxK/DapAuFJZ3RD/mQk7EBrpkPzuAqWwQgbUqvMHaSZkV/2ecsXZ4D1eJcMCa8UjNEVr/awcr8v/y9f13aY/LB65N2Ona3M46ndBZO2bmuKgMbm9ZxPzIxEebgeN3I9Pih2tUNEzTQgCwIucnRVu5z/IZjPXK3RwA26H+BnBjLzmVWdHNQyCS39zUZEC9mCz0piEBpv/ZLjb557qrwACoF3+US2J7QZzwbmnbNjnq+nHTq2WhhNZQrX04aTRGL5RkA6sGsl4GUN5mjZFlhEzGEulRQxBdD8AYgCrrGCepjLCao+ynM5I2IyFR2u/opFv68H2c6+GHaViEiIEwq1elPiMAgEkQd/Hhxcd87GykNQzNsDvAE7SHGTjgF+x+qJdaiDErgrQcnRlakD0BYvwLp3sWvUUusCrJm46m0zBS9zE+peIhn0d/9KOCPryEckGmWa4kWpW15gApNQ1xdnp8ltGIw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6486002)(66446008)(122000001)(26005)(7416002)(2616005)(4326008)(508600001)(1076003)(38100700002)(91956017)(64756008)(66556008)(66946007)(5660300002)(66476007)(44832011)(38070700005)(76116006)(86362001)(110136005)(8676002)(71200400001)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(6512007)(4744005)(6506007)(36756003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?QUdIhiVX7jUXtuaSQOHNvy1bqeTdSeSrhZ9hb6yKEptw5Cj6Hct5VKc0E9?=
 =?iso-8859-1?Q?UH0yPZOTx7MIit1FDEWI3ytM7SkIRmK83aT1iIlrCycc/AVnE1NF/ASznF?=
 =?iso-8859-1?Q?SWULgZmqblcaomP1Ruq9yKNyY+6a/vCeTgTCwfCv2sFep/vlf6DzWfA0Yi?=
 =?iso-8859-1?Q?A7WatbWjM40Eplt+5A88wxM7HWYDwhXDybabRRHS+zxcpuDCZXLoSblPCg?=
 =?iso-8859-1?Q?OqObQw+LefmUIDvgsllEgpwA7QNBkUvgQPBk0Z0MicvrlvpEjoGICMsQZ0?=
 =?iso-8859-1?Q?0GzucL6kK2X7hk3mNPlxRymMYpZYVX02cIFvgjy9bfSmipMqwdnTzj29L1?=
 =?iso-8859-1?Q?XApXrR5U0gcijVt4PDX+R3Gx2YBsv2/PSrEmZomKnRpfDoUw42/OMnvqlq?=
 =?iso-8859-1?Q?6fAWNKpkYZEF95H7GpFBU7iLEIvSH5JUV0LWA6P4ZkC10TOZsgrGV91xzi?=
 =?iso-8859-1?Q?Xw/vFs2pu+JtRe2tdRzjthBteC+Gke/AUd2PBYG7wV76bj+zCp6c32p8xZ?=
 =?iso-8859-1?Q?VHIM/qqPid2mjaXQk8YoX1cqhNjFj+b2lz8qko1Lf6/yW37vFUkvrPuslQ?=
 =?iso-8859-1?Q?lYEdKek4hV5efs62cdlYFGfYhugUPiHZEuBIPspgDeINNiwl4flSieuzk0?=
 =?iso-8859-1?Q?7gG/xKfxoXtnEmNILdmp6lUnPRog0qtof8CzRSvWVvM7mBVdC4+TA3BrBe?=
 =?iso-8859-1?Q?4z2s/7yNbz1zplbEQdVHbAd0HiRVPopC/dMLfVqmGxbGzUn03cd78et/8J?=
 =?iso-8859-1?Q?geNs4b9zjezaWLDOoc7EinjkmjJTf841tC7u7Kw/3M1KqVkcMAf4pjsV30?=
 =?iso-8859-1?Q?z2+4kAHOA+orphg1Vp6zOjV951yvQqr7iRYvgsRMF5NsayjG6JmRHOZ0VV?=
 =?iso-8859-1?Q?cbqEU8W3/SpqQN42x+UVIJaxty+fKslfjUZA9kMRPLGGJNko9U7ldHfJXb?=
 =?iso-8859-1?Q?qp3OenwV7XyLj7A5l3tOc0cleEin+DCyWF5eFvZGG1cCiTGKa3qeV7iXjz?=
 =?iso-8859-1?Q?7jyoa5IsT8yIcirwVNlD1MDGvh57vrwTtaWL3unIXsP8EKfbquryrYlmNj?=
 =?iso-8859-1?Q?errOicoVd6vbgFDr1QcrakyqAf1HNWCU/C5qH3o3skmzkmqi135KhGzNqz?=
 =?iso-8859-1?Q?2/ckaHrXTmx0FRzvu0VAQN5W0PlAfTCmX/xRE+aojDdqK2H5q6Z+rWvLDx?=
 =?iso-8859-1?Q?+RjzAmHYQTbyroI1x0jJR8RuLa4jfYxWtLLzqzmQZLvlaoRibfJ5Z5+lcB?=
 =?iso-8859-1?Q?MlTuq+TUTLtRmCVKI8ZmK60ShscY5zVfWx21Fc6/2EnLCMS04NjA721LNa?=
 =?iso-8859-1?Q?yKQBiah9ALwZwjbpF+UetSlLYkWLYnjn+2aggXLe9IjqLmMiKCxAE1E4Rw?=
 =?iso-8859-1?Q?OBQs9jLR2W?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 744a0a90-aef7-483f-49ac-08d9879fbbf6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:30:37.0656
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6P4IfqyQd8kiU9vgW9nDYzvjLLo+zFszV4hZhd0LpjecrEanz1TeD+5wOT54Zhz4wDl6Jki8rSN4L8PhK5JXNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 bulkscore=0 mlxlogscore=715 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: tlTh7kkFiACCAV_j1GC5CHJo6Q8r5uXB
X-Proofpoint-GUID: tlTh7kkFiACCAV_j1GC5CHJo6Q8r5uXB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If
the vma at the start does not match, then the answer is NULL and there
is no need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index f2d608283a9a..10a997fb60dc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2746,7 +2746,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.30.2
