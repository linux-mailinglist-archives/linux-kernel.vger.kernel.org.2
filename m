Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA24421BF0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232758AbhJEBeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:34:16 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:23638 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231345AbhJEBdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:35 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19511ntn024407;
        Tue, 5 Oct 2021 01:31:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SzqjF9XuUTyRYmpRqJM+iI0SxnYmWRcrs7F28xHL8GE=;
 b=IKX5VW4/5DHqXknbjoQrE89GbWSV5hMxdTdemGFL31+3rCZ1j5+T1TyRdOyA5EvDgtOK
 Wc6cjEz0HHwc2GCHzYJ3gcwi+nfcR4A5BitQ/vGky9cS7tXIEHhgOfHs8DuAZJnu0CqB
 o8QkrLlQWXM/17Cf9prEGddLPCqi36kiPai3ystBlnOeuHrrg9YNApaFiAAMqixWmcBy
 ww11QuRu6kmapCEiRLA3+c+9zg0QOV4RG8wUiNx1dzb9VZ6dPfRhFvHsUPEzWo5mcOle
 yrtHUqK8ftHsD2AqAI+8yDGtKZtA++qECV+LDJuu5VahYdyZI5q2zbPCVLLIJ3zaOOlq Dg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg454bvpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIDN178386;
        Tue, 5 Oct 2021 01:31:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by aserp3020.oracle.com with ESMTP id 3bev8w037c-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=deQRd4VzIGLGczGDHRQwtlfRy2ErDnymVtg9wyEWJzURkharI4lUgtHqhnW++kCHdqxFNB25zBRYFqvAN6hFmiMNz53Rize0YEBbFvdi7KzB/F9BCfFZ5kcsLw5umYya819fNhMVzCidQEwhPQx6sNnnm3WG5BqNrWPR+MedNEg9oZyER/RvhP8uttVPZq0rzgjHmxmttsjpZUQM6qWs1e0Ih027ARMqsC3fMo7FytmWq4tDv0LCDy+bSs9a3mqJ4J8miHwMGVklJn0SkJPMudH/XSGDje6VAFKZnJuq+42y+BUqmzFIoIi9XkglqHQmOdMyx95GMAqSWMQKPVM1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SzqjF9XuUTyRYmpRqJM+iI0SxnYmWRcrs7F28xHL8GE=;
 b=Ujs0fL9qXpHCmYg07mreTRVtaKAceRWm3PEyp9+4qKLiZm2QeNAmq7Mvo/uzrDdRdix0qiXDRZ7MOJm/9DIwHI9Sxz6QrUe19+yMeiGAuIwpHs/iuH0DLgo9f5ugBzgrftEbH/yJWYqIxc+kuS5y5kh+WR14kLHnFLE1Lof1DbJM2bRmPeYjdO0khyKDvgMu4nick0PK2kTRvkoOhc4u2NWigVgB499AJmhCqw2StYQSvM7l0R0FwVax33xXFmvE82OyQfQvTY/ao13ylNmwyE/dSprBRnZHZsFm5PTWpRTD6SsMmtrp9MMVIN49AcPQ4J97GrRtPoQL66pcjl3ATQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzqjF9XuUTyRYmpRqJM+iI0SxnYmWRcrs7F28xHL8GE=;
 b=oaiW9J4a3JGLTckhEUTPePTnXFHuivSdYJVWDqzf6lHJ3yBH+WSnR0URNQFOevhVE6LDvX5EDNkNG+Qjq9ZoVctJmUA0oMOsS3Y/VkvcJoKm4FZiE+s1910K7tEeTg01FA5uQ0TPN3V2twm4UnJ1Q69CDLcGvzyGRiq3hmJgNus=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:22 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:22 +0000
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
Subject: [PATCH v3 41/66] kernel/acct: Use maple tree iterators instead of
 linked list
Thread-Topic: [PATCH v3 41/66] kernel/acct: Use maple tree iterators instead
 of linked list
Thread-Index: AQHXuYioq1oE11TL6k+Emn3MIDiMJA==
Date:   Tue, 5 Oct 2021 01:31:01 +0000
Message-ID: <20211005012959.1110504-42-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 528c509b-c98a-4b4e-0c86-08d9879fd71e
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB50443E49521B055F51945E2BFDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aSR6tL7291vC0GrvteFskIImU58kEiy2NbSyvYkX85l5NBy/r4CObxEnqsw7QmHeFiy114YdZ3+11Q/ZBwEhG4cSZi0dSf3yffPlEsAwX7N3oa1gIlBWEU8LPtsNQkki/uNBq1VVa1m20U7h0qXddo3re6XYf76uB4oIzt5hpH7Dj4sjvuvK+LmEVv+w7KPpuyLFcZn7214drikexM3Mk8QpoxGf4HNLGhuwXYnfLAfl9WuaIFnw6JhPheXRnuPRccCBZLog9DLznu5IiZfu2EB2OM5APgOCeIoxTycT2iMa0+d2mfIFvK10MXLlL9ZfqZoSQuFORKePnLh4MiJDFoHB2ersbaGFwgAfb1bifDK/7Vs8nIiuIIBp3dNlT77xnZWs9a9qTbqe0OUVrQmaaJvGeOW/xDAjmnGB2ih6z7rTmllKcZ7z29WKNDPtEl9fp25MFwbIAIjy7/0GrMZPJUpKS5Iv3MUDXA3pLemd/qY0+V5ps1jbWsT43yARG8dj3OKapilDPFq61q6bQhCH3iUWFXDuC1Hcw3oYwRY1FN/EH6ap5oY+A00aNGAJJISGs5PVdR8C6XppSvwnyZ/Ei4OEiKo/AH1N/VTidi4UCww/gwsbZhF5HRUiFExB+A0rpBKVvM6lK4zAkb80ek3UlgoE6dw0dT1XfRoaX4rqTLuz/hMJlXdfe0BTm55sx5zNlZf+vWJXyF5tU6s/Bchbvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fiFW5hkLk2tmaLir+B0nHT2y25qdpSw3BpeCwQQNQuHqO7x9//M7V/VHp8?=
 =?iso-8859-1?Q?/40rEHdb1GKggcXmxIMzhMFfhkjpFrKVIIehZLad/O3mQCecCF5uadkb2x?=
 =?iso-8859-1?Q?oQN/J32rBMpPbN5cyoaZJp4KbTZivh5yHLuHggwtd7mZj/RZ8Lj6d9jTpm?=
 =?iso-8859-1?Q?QwteW75BKFCFZco8RWo/6zg1ROwrOj4gg4xb9zxOqoM3MYrz6r60m1WnhC?=
 =?iso-8859-1?Q?Yfe+E2EceM5AcVFQTWlukvK6qw7xaUDEU3vuXZiI9jqIEHsNlflHLl0Ct/?=
 =?iso-8859-1?Q?vL4QhY9AJ7a72ZFTpiHQ1gXDZuM2FvrqfnPj4QTMQLxMQrZwFKY+udSSrt?=
 =?iso-8859-1?Q?4LpAuu6VtKBPAZ+LzUqWd7yCmyYZsTdDUkfEf3qQ2+GbT3jFrr70xmWXP0?=
 =?iso-8859-1?Q?qtNzjMkMkd/TAcuFsx8GBLv5wJW5g8BKVnrysChb4OmYTeKRWE79ZQ6CVX?=
 =?iso-8859-1?Q?th65L6JOKUM1Wxb86izQdRK5QrDHq7tdd7HZuhKu7+4ig+jEaj0eJTSvC7?=
 =?iso-8859-1?Q?jhAH0FRXLhj46w4OvheoI+4r4XHaPtp4vq4xzd6O5yGiatpuQpw+7VUfNS?=
 =?iso-8859-1?Q?BGrK6jlgM3P9HyUa2Ip+2y4mmeCNStp1/PdgkYH+X7iLTChAM27XXihLO0?=
 =?iso-8859-1?Q?Cc6bzoiN1Ly7u8RTw4XDKR4iNqj17l/otuN8GLF/bu8YE7Enf/9v2BWIZi?=
 =?iso-8859-1?Q?AdYIrwPpGaMMXXcsd78ut8AaHr1JHRuG31eLBpeD5QxR7+kSo2Yd8i6AlA?=
 =?iso-8859-1?Q?8T7w8uT6zGqaISrORJjTxW/QjdD32C/Gwbb9gmCMvFRuqxwM+CKkniGCj/?=
 =?iso-8859-1?Q?VvDD8UgSBA59NQqJO4xybstnoYTCV8OrDYaEp5iOlLIVaORRWieY0FvEal?=
 =?iso-8859-1?Q?vwqjDhOybIewR6jcZyTrzobtyk27TYI/jd8yeh17PMxSz8Un70Ms/vdAmd?=
 =?iso-8859-1?Q?/8WZTmHzLYRjsL1gKw02WRY9VxtKjri5k4PF/cqUsrB0KjJxSnArLPgqK0?=
 =?iso-8859-1?Q?+0YOzYrbChkUHuzfPIwUoHaukhGH8qa0AGVPFQYifsYsG7Xtp0+E/0I+Tg?=
 =?iso-8859-1?Q?X3Ms/jgJuAEk0EyN/3JKNbdCJiISky2VUudsHnwJOL/YDqiQg+lGE3jYr0?=
 =?iso-8859-1?Q?SBz6YYYlFCVPXCot+/RDQE26VsGFFm/AioPB3ZwtjAX8fQTs/ETv5RQg5g?=
 =?iso-8859-1?Q?Zs/P5Keo9KmuGvWFsKMO8MrYGepgzKjhf+Gg3sdZNo/+j2nNO94k0ohzxH?=
 =?iso-8859-1?Q?95UtPfgUyiKCsjt0Fgw+gL7eVZZS0vRIQLfcJ1UY4jxnBWM+WnBuxXMxjE?=
 =?iso-8859-1?Q?biaa36x8heNPzszs2pTfs3F9XZH1HRLS6JVfJMVw8NYO3szk4NLLeo0cRu?=
 =?iso-8859-1?Q?34ZpMY1djj?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 528c509b-c98a-4b4e-0c86-08d9879fd71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:01.8455
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bYSqmZ8e8suraHdW1IGlrFOBrqOF/c26WhNS+2pQIvk2sGGDFokCQbQkKxeDVpSNeiy29fIvmjJskS/uqmza2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: u18U2Ucu0rKAqSS2Zawv9xhLn4ojFlss
X-Proofpoint-ORIG-GUID: u18U2Ucu0rKAqSS2Zawv9xhLn4ojFlss
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/acct.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index 23a7ab8e6cbc..32343edc7330 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -534,16 +534,16 @@ void acct_collect(long exitcode, int group_dead)
 	struct pacct_struct *pacct =3D &current->signal->pacct;
 	u64 utime, stime;
 	unsigned long vsize =3D 0;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
 	if (group_dead && current->mm) {
 		struct vm_area_struct *vma;
=20
 		mmap_read_lock(current->mm);
-		vma =3D current->mm->mmap;
-		while (vma) {
+		rcu_read_lock();
+		mas_for_each(&mas, vma, ULONG_MAX)
 			vsize +=3D vma->vm_end - vma->vm_start;
-			vma =3D vma->vm_next;
-		}
+		rcu_read_unlock();
 		mmap_read_unlock(current->mm);
 	}
=20
--=20
2.30.2
