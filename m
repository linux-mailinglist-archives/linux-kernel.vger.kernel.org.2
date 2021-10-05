Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809AA421C1D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhJEBhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:37:13 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32680 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232778AbhJEBeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:17 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950Cu32004475;
        Tue, 5 Oct 2021 01:31:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=deZTEqPxVn9n/v7G/J/W8/HDLRsExa8gUNvxO4VDWKA=;
 b=HEad6halbGY1fHINEyStAaniUE6k1rjmJj1cgW78JR26R7Q+0fiymocZjKvih0OfKvvk
 VER/qLgqKDMv8DR38r8M7lQMS0CWSeTUneNCs04FPMISbVKyR/k1fsDvHOmgoiNs/K98
 c3bywbyGY66iP1I0cieHvb7bE3mlPSluFwMWYIieITUkguXpRSIYgLFsBS3Um9Ns/Jcu
 f7kt940EedhT/AEBZnt4CUvnpMxcwMV11oka3kWV73PQ4w0wgRWCx3/kK4Unimc8JPwS
 MwQfVC4NmELrBEckkpMlEAFNJphZEoTX1FTNX2hhzTvprkH1ynHFAiMnYOJmEDXfYkrZ 4A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg43dumqx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTW178361;
        Tue, 5 Oct 2021 01:31:34 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCVFxWFnhMUtP0wjmuGwdQPGf8fS2IGtHWAceJMtk8LOZ7rEhR3z18B58ivg6yhhBiOJDRsksT4MvItRt0AhNYdBkJuTY2anJWRbpHq6faKbu/OMO+kTbkgSrJ8k1fC/Sj+qSeIWo0ez3fjNovruHdbItue38Fd++yZERoicW9QT3KIlZTA6En2xi9/bv8lecXD2G8C6RNzoGjkNSn9u+hZsgtoA1u/WBA55q2q+eqipYs9bhB5f48MEntF5q4xfnkbZdIWA7gZP4oss/Jm2e2h2cP9B959vizYNCViVp7zbNP1lhu0Jt36L7MmbzbLAzChaH1VpT2VkRimxWc4peQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=deZTEqPxVn9n/v7G/J/W8/HDLRsExa8gUNvxO4VDWKA=;
 b=l34l2Jq83CG2rFmiRDVjlbuCUj4/eph05ShwJE7765hSe2JwDAqvuhLu1kc05ec4XUJFRc0aRLtlv2XqcVvbiOgJD6oPL46Uy28OscgQSgelayP9s+tLpnaWDEHa4920aMWgbj2dAzOabw8bmvRYYZ5hHhEodf4Tt5rpWUdZZM+9aZBgn8kxiLzeAdWwG8tE/Jfo/mubxcEYvUA+Ip4Pc1/qUHuttCXheQ/VH52kl257mNlzzr6WwtK1QnVB7d+Myrj58pYC3FOI7oPrlFnkaWU9JekEZTm+Aj/0V5HbP9c1jjkVfvRYNA2LHLYI8JDqpyAcjIbmezt+vbSIrfIGRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=deZTEqPxVn9n/v7G/J/W8/HDLRsExa8gUNvxO4VDWKA=;
 b=eHxD6Gpl4fBf1kkYuZgc/6y8fgt/kbLuX9lVQey0XktwT/ET2eGwaxQjEh9u7V3jvBZikvBREQyfxswVuJp74KgDmPaHqM6UjDWqWdSThZN1bD08ffSbk3pSouB/2n5cv++laBUF4l4uxi3NdDghCwd5ioXGwi6ySmxNj5VIfMc=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:26 +0000
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
Subject: [PATCH v3 57/66] mm/msync: Use vma_next() instead of vma linked list
Thread-Topic: [PATCH v3 57/66] mm/msync: Use vma_next() instead of vma linked
 list
Thread-Index: AQHXuYirW3pkAeBvP0OX/KRGhEbhdg==
Date:   Tue, 5 Oct 2021 01:31:08 +0000
Message-ID: <20211005012959.1110504-58-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: aac2d533-fa7c-452d-0c3f-08d9879fd955
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50446D0823C8EBF36422D788FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:296;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q9oQhk9PObsXrwOTT9CQunJc7BtR2tlNsUx7YUMGuh5vTevuEkyvSaobgL8QS44vguacvHs4w4WO5C5UHi9hsbYtFIyEdGrqSlsswPw1SwGVV77CmR+Qk8L41PO5axqPpoGtlwwLnPOhne/v1FXL4lSyZ8CyYYPHbOczes4fMvmNKzlmNhYYxP8RJufA9s1UAQNoC3r3/f5nYndLwvteu8Ggb9rLE6RenHR/tArtC14ar7Juw2MVnpBQ7qYVkBT8DBmox79u/C1g1biC2j8KA7TKW8ZNzKgkd7kOUATN6cSRrZif0TSmxtnfVr3NP9bv/jWNqAPOBZFtvbiJNeFXKgVTvCYiVUffdVsUccfVEiv5V59s3nWu3MLG0oaA+LDXXMZQb34RVkrmGSSBxrSUU7d7ngmp9Odtn/OfttVZT+Dkz/eRaPrPmITbw99zoZ7QGG7uZvum7Ife60fs6uyI6tMNrNgJXRD3c3Pa3JEy9iRFrkCMd9OICXyjMGHdHLrFJSPr2p35lUNCTO5qG8AZ0fGthHZ9ZNfsNafdOfVLN7R1T7WkTHhaa0ykRIxCXfr3rjzOlC1QjCUwfQudCMW4GpZPezHuX+82OzMbjMtgef+u7imNMBlT5UXf10SkUI2H3jUXRSbIkkuKB/2ubNUO2hvmw4tLoz10AXuO7x0PajtXb2+JB4j0cBm+0vV/X48WhaOF3NBylJaBxKBkb79HnQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fhgOYG/HQmRAVYfaZpOB1EnXH66J7A1sChdicTo93wVu3VCTdcjygytjVJ?=
 =?iso-8859-1?Q?08IF++wNml81IbD5Fgd5lkNlpuRICgvs5vy4nUt67RenIAGcFEQgpbfHSG?=
 =?iso-8859-1?Q?fS144cp/+bBBBB7f/gziglNDYiVv5yKftNWJNLIs0nbDeVmn2OrZXmxL5p?=
 =?iso-8859-1?Q?LAR2EpYpXX+DTyZA/3/bRcVYmr5uCps06Q2KCoLRIQ1XfcnxCTYSEClBLp?=
 =?iso-8859-1?Q?N4O4R8+ri5T0RDtXAzdDiz0bvHgfz0D63gfzaBK+jRB9NS4NTEwreZFlXF?=
 =?iso-8859-1?Q?HEgXX9/YLcCvAYGGu/DngHXwMtJV84KNjd6NxWC9lbPsPqftvBJeknmVNe?=
 =?iso-8859-1?Q?s0PW9xj2RRFhuj2l4iRsQDpZ8tXgshPAdZgRBlui7TIZXttt3CsHJ1iKol?=
 =?iso-8859-1?Q?8qE3H1HT8SEwB8RILGTTov7cP0OHPCRiWdG65CgLq/kfr8sL9IqJeEjVuH?=
 =?iso-8859-1?Q?ljPQCZBDIwFm8deZAXH+maeC561kPq/k1CtcMt/X7BlNyU4UqUYgq6Ml2N?=
 =?iso-8859-1?Q?Trz1gNh2NetIdz6OQ8DXPb/Sa9NsGrwJTbxTOHjR4uAv2YHFnAovLliAKQ?=
 =?iso-8859-1?Q?NtIM+D6Xy/lpzjROVZRKh9tpsmn9M28Z5deZjQS8k4tlQBAgz0kyEr91Gw?=
 =?iso-8859-1?Q?C00rlX/uOCHG/9mpiF1xolRdiFj51Sa1+CHNQ20RnbD+uroUjY/pDGCZ99?=
 =?iso-8859-1?Q?18bedv7SdRaBFyBbLn5Ta5On/UKIvPZ9pbXN2mYxwdbCwYVnZIOrxS6Qsp?=
 =?iso-8859-1?Q?JFFS2iWfMYDv+H10m1zQw+QF21fSyU0y18EAEkwoX8oubOofdm0fRrASbp?=
 =?iso-8859-1?Q?u9uYglDvN6YpFleglqCOqP9WuEWjHJzNF4i1jA2k4JiuEIbl4Po0bDVnfl?=
 =?iso-8859-1?Q?yrlwohuJOqnUpZOfpkoBW8wPvoqb+pD472aJkFrv2qd+MRXdji0n0W9/UC?=
 =?iso-8859-1?Q?ihjtwO5U0kdZRxlDEtLJiurCKTEooi1573oql7AQCa2xTXllrl74i3KaUY?=
 =?iso-8859-1?Q?gqgKnwzsB7HVcbs/vySR4YuLIE2equ90K28rD44RoK1CHW3r58J63i4R3p?=
 =?iso-8859-1?Q?PzLPYpfbP2wpfntRZ7We5RySg7OUOruuQFPlVesnaXWku8hdgf/h1HN7GJ?=
 =?iso-8859-1?Q?VRrKGB530oYn9fFZzodU+eAWRgJykKCxI5M3y8ZRIH8stgetR2U+ArNg+7?=
 =?iso-8859-1?Q?omjBzzaJodNp2IJEF+Tah4jrPwWaB9GfKGrm9iwoPajQVn+0nx4fHSjv4W?=
 =?iso-8859-1?Q?IYW4akhUU38mQvF/aV+fh+M3VVP5JTXj1rFyG+DHaB6x+zkhm1/hdukp65?=
 =?iso-8859-1?Q?riUDuK6zmzCC/H5XbD8mYK+f60RMB0ipBL38wbrpVj9GZqQW6dP062+rAE?=
 =?iso-8859-1?Q?kkLTjdmLWM?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aac2d533-fa7c-452d-0c3f-08d9879fd955
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:08.3868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x414/bd/2XAAgykgL6g43+OzMzswJd9q5EksGtWGRtuuQyRC5azQygc3Nb4yhom54XJc57DHcVsTFbB/xIgqqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: rUOIWTkA-eEGJasTfZ3GGJVGyncZVxvO
X-Proofpoint-ORIG-GUID: rUOIWTkA-eEGJasTfZ3GGJVGyncZVxvO
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/msync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/msync.c b/mm/msync.c
index 137d1c104f3e..d5fcecc95829 100644
--- a/mm/msync.c
+++ b/mm/msync.c
@@ -104,7 +104,7 @@ SYSCALL_DEFINE3(msync, unsigned long, start, size_t, le=
n, int, flags)
 				error =3D 0;
 				goto out_unlock;
 			}
-			vma =3D vma->vm_next;
+			vma =3D vma_next(mm, vma);
 		}
 	}
 out_unlock:
--=20
2.30.2
