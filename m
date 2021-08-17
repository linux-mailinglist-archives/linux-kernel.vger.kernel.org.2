Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9E13EEF9F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240505AbhHQPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:28 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:4142 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240405AbhHQPte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:34 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkEMb023526;
        Tue, 17 Aug 2021 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6GaMKR0ahvcEhve8kvy1qZz4sHehBIPoWV1URH+ozTc=;
 b=kQjvicUHAY4hmJkjOy9OnYgXRr0y+cLGK+JzhoQhOu4qplFKjpDVeXPxrmBsAdwbG+GC
 aS/BsChGUwu9d042+Kc7Pl/C+hJlkh5ajIs3cRnuLjP35+hHCmFRtL771Xs4gV31/F8z
 sY3t7pJMECIlRT+cOdefXEiPcuiawVYVymJKPOFVDzNbHWKPuHR4ZnBEDHknR0rj/ehx
 X4PSpSckJp5+k/CxAofuOqEMBCPANxgPeT14fTztSHxdX9VIlR2SrHsG7lFOB/us5n4x
 zHaGyecVTmTejWuB8osV5rC146f0qhQORXwTYJ0j/Ir46Yec8nI4Nb1oCbhgY7xpIyS0 zg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=6GaMKR0ahvcEhve8kvy1qZz4sHehBIPoWV1URH+ozTc=;
 b=obDsGWxR2U3olTR059VYr2tYHNwz7reoNkjDqUAdT9OqC0IzG2AuimzP0CKYfCa81aHN
 IdoDkDFBztEvsOlLiY1RSEgLE4LrQhVdzlZG6nZvZeghsdIe51qYgBVarheDuSpiVFCa
 m1ewEBbHrqjeKB2vbSh73ZPOw52AG6xc/w3vfNwxDOAu6pLE7e4cjV6614LdniYvqW+O
 wriaPuJbMh47NVg8FY1sUD9Eq0Hk0uWIWxPNiC/QNsc9cWk+QWvTYjjLnUTwhNH6m2zD
 GjKmik1cYnsji6oTX4obJEcYtXtF/uJmfgEsXuLdYxANx/ofgs+MaDGuZgTHo1dB4nxc vg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4keh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFj3Oc174039;
        Tue, 17 Aug 2021 15:48:03 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by userp3030.oracle.com with ESMTP id 3ae2y0d2vn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jEea2l668Y3GsQ2DLnVNGiMaCu3OEx0jSHCCd9ufjwXDN5P2zObDl1gS/DL9zE+4cQOQKZUJaKgAos6Z7Tx/beA8iVZGRLrpIl50c2Pn1MZkAbG8mfOZTYCdgK29InDB7xNJnVKoIY5VcDv7WaFYMV0Y73qinDqbfEFpREM3MJcjFp0idJM0nQM3fygGr6Rbip+N5BPXgwwKLjZVtel/6PLDosnWD/gsHhn86FFb/XOEZ7/cBL3HK16Jj/3cAz9IHpj1keYCwbMfAAN4Ry9Q+SB0lKMwaHmSHAe9DXRhcmx3i+7icYQ/gEjkCegpWAUJ0QLQ+lSfHqMKMj+Ey34i+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GaMKR0ahvcEhve8kvy1qZz4sHehBIPoWV1URH+ozTc=;
 b=RiLbwuDz105CD+DTwQPSx5qbuI/YgLzkViiVmV/czt5gTMC2g/TwJSY68nxIO/fkv/ylTdgtFuA0UmHOR28hqIjSf1tqv1+cFz7ESG4lAOCZLi/Gi7Zj5fWYge5NQkgyy3x5ILB2/0VtQNrMObzJaGCfsk1znzXh0LaZIyDiopnR7KZXUfSiSTWwhxs34L2RquVqFDwxflDSa3lEAxPGiPmkeo+bO+n2alcIqBS90EM7uJJxmOvbdFAevjOnJAOCouni1oDXPn4rtzRxjR9jjZafOXefpzSQluz75OsOfkpJXaldCi+z2zSU1Vzi0yirX+QFqcJ72/U67tEo7jQUYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6GaMKR0ahvcEhve8kvy1qZz4sHehBIPoWV1URH+ozTc=;
 b=HCeHt2h6GEY+eG+SUxSmxwz86v5U4SjqQvO6crZRgBe263syFrGrqQqg4KR/MwRunt63dsfP0742+7Nbd6Df8UXtMbzusLzzrqRs1SMvxsiy6yzNHX7WZ/cqgtSKd+pmGhZ8pWz7C1CfyPpdMso7wkequ3qmgINZ/azHd/527Y8=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:56 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:56 +0000
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
Subject: [PATCH v2 50/61] mm/madvise: Use vma_next instead of vma linked list
Thread-Topic: [PATCH v2 50/61] mm/madvise: Use vma_next instead of vma linked
 list
Thread-Index: AQHXk38wwBb25OeVok6nvxJ8B/1yfw==
Date:   Tue, 17 Aug 2021 15:47:31 +0000
Message-ID: <20210817154651.1570984-51-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: e7d5e579-45b2-4a72-8a0a-08d96196622b
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB358062ADAA5CA5E00BBE0BA1FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1060;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: od7xWrrPcXOlI/wBftJejbvjGkchcCm1lCpH2FS9j4zcJQquyYaMpEJOqY6zGFtZiEcZpRrP5Sk2tny76mQd+7Dgw/IRodTlZ3HZlUODEykzh3FiHMqargHec8DnuCzjv0Dbg2C0M469ObMHMI1ORL/Mk1U0d1neDwMs8qARG4row1iMQcz4jAvIYZTLzngmQsE0YP5Az9CJ3h9FEu732KjJCRCtyczxwYfJb8ER9tHq3synn22vrX2cxvhhKjXtRrN3E2D9URCqPFAGrJz6oCL+D7xyi5tR1SSUK9P8ilh5rDrwa/otthbCd1hTp0VlOgSkKFmkQdWtK38XD4zcxqiEQIwmz8tyANvf/YX7nMIGpyrSlObYKXOCMLM4YB0XiC+00Np/MQreypJq7p8id7O5y0hLyzBDWS7L1E0srMxYol2zrCdHGYmK2G41KGKgiQTtHQPi+LL8bE+xiYHXA6cldVzJzL/nMViKN+63TRGlToils14KhzwVHgQAlFn0mUSK5OX49woysjXNtsMuhrbyNip67p1rKEQNbE+gYqucCsv0CcZT6SigneOQhrnXXdwpcDC5FtdgddDOyDUSayRp81wnC/48Nee/BHy/YfcWyyzRyCTW8cpWiTM+R0O0XJTZUVVbwAKDvZef3Mgl1/MDpmodt+zPaN9GesmsXRHDw/vFKv+XE+B4359L4JgXSQZ+SCZakO2Ege5SQJ7qnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(4744005)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?5WfMY89+F/so1b55VrRTF3YlqIulHN4TrngGGtdyjxvdtjgWba8KV4wZPE?=
 =?iso-8859-1?Q?pKrfmxPUOMVqDwEsWmioT/oei6JVDf21Wa5KCJPfc+6lK5D1xgRJPVHlBi?=
 =?iso-8859-1?Q?7lR39PGs8Kqwgm7FofMEarLpjHQtl0xTYpWxtXwZKxe6Ey3M8mroqhNVWj?=
 =?iso-8859-1?Q?bQfKSkwNZLywEf6jubC2OS6iyC6dtcUDCCkNfkLUHlfjirw3Xe058om/ST?=
 =?iso-8859-1?Q?IcMhit1thBptg+iRPFT2OA4imlmyg65+hYKiWAIVvgwVwK7TrKcgl4X+oB?=
 =?iso-8859-1?Q?iHVbLJjGRSUr9o9tz27Mo10PI1zaNDkuWUeK6IFjzEoE1qCMwr9D3r8LZL?=
 =?iso-8859-1?Q?02h4nJ+IJsZgx0FurmsNYOr+HVYVan7OvH86Yu5f0worne5GgUs+M5MgGo?=
 =?iso-8859-1?Q?TlXW3JZEkDpujPAYm2xxMIsXA9YLERNzC1Zuu/RhAvGK7BE3dM7UWHva47?=
 =?iso-8859-1?Q?y+Qo/u60BgQeQoys3ZRp41WZPIE94Ra4tZal5+2izab5/x5gocx1eN7Fil?=
 =?iso-8859-1?Q?2kchzi7PK/qMhekVWtcH6LTxJhHRx5ZpC38L7GqB+GDakFET/bJzGzn4N7?=
 =?iso-8859-1?Q?Kb8X6ufAC9fc7VSgkBuLaBMnyoF8s2iT1znWDW0Omi1Z31leYT9TljTwP1?=
 =?iso-8859-1?Q?vEp/EYYsAfBpK3TCbwvRCm7mDhR0PQP0Tj13+65/NGYfXd1cv9mDsAFg6Y?=
 =?iso-8859-1?Q?Vb0CRBUYUkHfpL1icAOSsgfgPWzblW/u8t87hgJCTNF0zBnByqn7Gc/gcX?=
 =?iso-8859-1?Q?k/xN713DVBYh6PGHjiOMz9Mfy69bKFnim7qN6holZO0Yd3a5hQZ3nP/oy1?=
 =?iso-8859-1?Q?HYUaWIriG4dYDBBS9Etir4TXY1VH9xGkmUHZ35KRoz1AsQNsZb8bBSjbjk?=
 =?iso-8859-1?Q?CNxFIncAh5B7MvZaO2egfiXFLTLbCmd6mlTClE14UhMyTcSiB+hyL7rbGa?=
 =?iso-8859-1?Q?I7JoezwXjFFz7MOG9S+MLBnW3X5vVEyiVBaInEAf8iXsccI4LeER05IJqt?=
 =?iso-8859-1?Q?sK0dPr6YG1ZM94e/EwpCMkYzQPjqnv72rKJaL5iWictg8H9nmMn/pZVNuQ?=
 =?iso-8859-1?Q?e+X1YSryU+OBzWdL/JVedoUhm4zYmy1gxbCCjL5A+P3ghaABTH1wDk8Z35?=
 =?iso-8859-1?Q?EDqFz8dDJX0zYNbI6yibW3rFQ6dEomg/Xr29gBKSOB9Nl6Xnbo2hnJ5NPu?=
 =?iso-8859-1?Q?fOaBRNbVqALQdLMUeuWAH98iEF8qqSdQkAQqFNUPJzZfX5vvlxBv4Njf4g?=
 =?iso-8859-1?Q?9nwwgvX7NfQet0kNLYY5GOqlD/z5x3swswcElweBlZjQOd57oZT9bsetRh?=
 =?iso-8859-1?Q?z7ynIWSYcuZ9NqpMWhmG2Z+zD96euw2rJXhRQ0t8ABB8ZmhLH3o6lIlU0M?=
 =?iso-8859-1?Q?Fw3w9NRdoe?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d5e579-45b2-4a72-8a0a-08d96196622b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:31.3387
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ado6eBRW22x3AhFlp6xw3oU9felCmWBjLBSvj9Sk66t8plkrGOuUqjWCI9cgvx9/Znb+VBAvSYXhHGlWDGbtUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: IKbJ9WHdLdGTxNIV5hcUzqodINrRMI_e
X-Proofpoint-GUID: IKbJ9WHdLdGTxNIV5hcUzqodINrRMI_e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/madvise.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 0734db8d53a7..3a6fe7e1b080 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -1209,7 +1209,7 @@ int do_madvise(struct mm_struct *mm, unsigned long st=
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
