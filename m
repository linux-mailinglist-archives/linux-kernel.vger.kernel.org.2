Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E60C5421BFD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233254AbhJEBfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:35:06 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:33946 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231822AbhJEBdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:33:44 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1950qIPi029448;
        Tue, 5 Oct 2021 01:31:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=GAVWnTOOyrsyxmJkkbPRDh3WuMhnQfoALqkP/54vH8o=;
 b=t3p2ToCD23tYAWU5xQwpzJIZGa5owSiGCon42+E5UgW9zdBSYbEWeg8YQVLX3MXpJ6bP
 xRnBOyL1vxzlc0jT3WIXfunAY3jDtLSRrW/hzVhLUiz8KjR1hbzF5FrlLNcKrOqjHrWi
 R/gHpEEAcgulz1eYjGjUB2+GolhU1MWJH4df2z/85DBLdo1T9OYeGCGgHv1HlrTzDgpG
 2+6O4SlyKSWixV9CmyFk0SgeY1ZByQ5JP/rbZVCyB4CwYxbzN2GySfl21lZieN0H0Gcj
 JLitkQ5H66mcMfAgT8G8WAlyIuwRz8VDNVxiU+u6Ba2l/C+jBsAHCVyeMg6+F6nvft66 uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg42kkydj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:31 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UHTR178361;
        Tue, 5 Oct 2021 01:31:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by aserp3020.oracle.com with ESMTP id 3bev8w0386-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JkXOTI8cz/GD3o2RFNBEuJJIjFFVZVBvgdvCKhV7E7Nz5O/WJlaAFdc2CIlwVapWbHCVfmVW6CCiXuDlurikI3nIK5EiTzU/VOFSSe5pDmGTjyNIf4XQfkSGTJ05pxHJTPYsN0+qL1LERPdJeuJqB1X0ryyY1qddVmDFBqK6jCHKVCft+feWq0rOWf/gKRL5sVgj7vrRvpGLOVMw0Bai7Wkaj3jQxy44MUW5FnvkJkU3YDPiP70M7kPG0nkSwgjeuCFoXSSjPw3iW9GvorQkoGBqI6Aba7EDVfGwts5CXfTKi4T8Gkqj1SDiZCEsvmXDk9bBgBLGi0fy4786ZEyFlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GAVWnTOOyrsyxmJkkbPRDh3WuMhnQfoALqkP/54vH8o=;
 b=Pl+9Jt1fYUsdb/mW2vcCZP5DxsCzju6l51gcgsKeNDV8DHTdQN6kcXjGULgt/s0C27XpJtRYjbm8gZ60RkAZpXYx12c8sENAG0vR4OKn9K69pqViyRHFu4fnoys7RXpSlnUsOEUJ2ixhd5YVXPBkiOr2tjryxQUN01YnTvZDJuQk10gCkSt91OTzkdN4DEUJRbELUpaVqk51QIC7Qn580A7zmYpJQz2fgnFCCTCjdJ2p3NS6Oz+JlgKV3Az0+E7x2RdgWm3FvT8/9AyAmz30mhQ/Ctxf9J5Oa9QPHy+A9KYrol8RaaWJG977uocPDvWm+VvJMbrlrTZ6NBkdf1ow3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GAVWnTOOyrsyxmJkkbPRDh3WuMhnQfoALqkP/54vH8o=;
 b=f0NZ5Ut2191JCkfbu5WG8rvvPoGGE2ttx5APorl1qYUPvv4DazWq8AK/RV3C9tHqu0FlJUQ6Ai8LIQjzY1vUaZh/wZCgdQJOx3moPMMKqZE9E/7wvu6iYZWA3+V3s5/6uPtqksUWTz9ZPAevZ2f3fIYX42gsXUsVf+DqUpjElvo=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by BLAPR10MB5044.namprd10.prod.outlook.com (2603:10b6:208:326::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.15; Tue, 5 Oct
 2021 01:31:25 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:25 +0000
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
Subject: [PATCH v3 52/66] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH v3 52/66] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHXuYiq0UcwveXwU0KXVlYW12GMmQ==
Date:   Tue, 5 Oct 2021 01:31:06 +0000
Message-ID: <20211005012959.1110504-53-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c4635838-55bc-4d3f-e449-08d9879fd8a6
x-ms-traffictypediagnostic: BLAPR10MB5044:
x-microsoft-antispam-prvs: <BLAPR10MB5044548C21FBE64C4122B429FDAF9@BLAPR10MB5044.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2MDe9clKito3fo7TK5PwwYizZNrP17pxsa4GHOBEJxRJBf1uawhhTLlP5EYU31WG6WE5pQ6yd9JKNBmzK+S3t/DtqBK/nuaYPrf/c5im4f5xWNxH/IYPxVyspP9GMxoZt7pd9smAMhFitXWT+ZutldIKGTITpXv+8gTv1zZIXitjkSb3FZ5bENqZTCJzTnMVXJ9y9PhBp4/myCv8CRfZcZS79i3A5xLYPk+qJtQuzf5Vp/AyhomyS9tw2hri7K71p51M1hmJoV1AUpXA0vIaOSRgSO0bDcarXQ1ZXz62yMRLWTnJ7uGNnwRvGB9UsXqW6cWxLwlX8voiW+mfmUEfSW6LwNuY9exxuiPSOGdq9XuvRW6glQnn2Kkoe5SyqyDiS/feZHQiDxKG6g6hu1QalE0WqEs5gpNwxAHHUTNWwzRuOQ775aeqj9eD/HjwL+JNGmbwcDc7TC8ZzFTSqFcB4N5ggg+nND+PSjRB0BMXTTSTV878lzFZLS9yM8lRovMi3PSYGRdHXDNmWjpQYiAdl+2X+x3/yz0yzWxYzMTkFHNwsjQNymaRbmb3LTNWABlSCt97Tk20ejmlpe3R94WVCol3ddhGQzbaKkY1tlqKKEyACxCVt65VoCC53rV7FLHLKFoizrjT1kvmkq3iKj1OYS+9aPXsVPHQq6lr1G/DdlhTmoFEpMwvu2l/tqLHyGEq9Np6qEwW8UCCq3llZwJW3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(110136005)(71200400001)(8676002)(86362001)(6666004)(6506007)(6512007)(4744005)(36756003)(316002)(8936002)(54906003)(2906002)(83380400001)(186003)(66446008)(122000001)(26005)(7416002)(6486002)(4326008)(508600001)(2616005)(66476007)(44832011)(38070700005)(76116006)(5660300002)(91956017)(64756008)(66556008)(66946007)(1076003)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UQRAzZEBdDBU4+8b0JHczU8HDQgN4jxhLI3qHqhQL6mO1zsIII+PMgLmU1?=
 =?iso-8859-1?Q?Bo3v7mGEIZrNNqGYxHGnK1Nptaf4tGlHzuJAZMI2eZODfa6NcAs5adB7Fc?=
 =?iso-8859-1?Q?Mlm+ZxFOePfevMWULCEFtB8GStSRkdFFGJGzf6yKyEBLtOSPPRYxiIPqU0?=
 =?iso-8859-1?Q?g4HXSjoCtt1LG7zHVFbhFq7q8R0XkilCpws0iq65rCPw66ChHAkAR+1JWA?=
 =?iso-8859-1?Q?kP87VMJwPqt54Qbt+cSEIaGVMXrbY06w1Fg4r+wPrmb39abHGL/8xL9XLl?=
 =?iso-8859-1?Q?Y9ujYJUsC9OhazC7Y7GXcnUbywjIXZwkuccKolnqXjYs5XaAZ+LFEPMT2o?=
 =?iso-8859-1?Q?nj/XMZGuPNOo52y9J9G9LgcX/HoSFVqRWtA4oC+uoDTdEPCGe4uHUxRzlW?=
 =?iso-8859-1?Q?BRBUKWEQf4ZrATtBf1RgmFPhbNMfrTD6R/HJ+r64cEf2V5OJTqISre8ObV?=
 =?iso-8859-1?Q?wRAWmUaV+kPS8R2ZO7FZIuavXm3xaqJOUF2zWVEJ3I9uZIpF6SpuHpkRcI?=
 =?iso-8859-1?Q?AezfTzclIWP9mKjl8YBl7jeJsBoNDrh7T7IjBQ34PriJso2ahbW8AukdWZ?=
 =?iso-8859-1?Q?ma0PUwkV/rLsJHMOuz5iYv+v5/qwNVOHAqhr+uMJu6Kn40qX22l9p70d0+?=
 =?iso-8859-1?Q?Hmziu7rhlsdebjB3Cc8Wz/ugx45U8JVwlXZc0Ch/8BkU+FtdfV4ThLsC+m?=
 =?iso-8859-1?Q?aMivA79dq8ZKkrFMr8CIKYjgHxWbWxC4zuuov8iVBNvbN0xgPyStwEtPP9?=
 =?iso-8859-1?Q?z5rx5VIa4lHOumVUpvo4Kn3XjgaU8YPP2VR2aKzohwtDsPJLSh9ddd0E3V?=
 =?iso-8859-1?Q?TQF7GIDEj8AaB7l5Dl5VdelPTR9brf5m3hkrvjyG28tFXn4a4wGQfHF7MD?=
 =?iso-8859-1?Q?kMVWiBTJ0W3JHkHP2Lvlit5KgiH+HwGSiDZs+aIkOMeEMuRfpQm1SQZjMO?=
 =?iso-8859-1?Q?R08kb9EqjTUO4uw90UgJ+3j/Rs38UxYRhHrxk9///mABD768chx1XBgHUp?=
 =?iso-8859-1?Q?xsCb2riQpuGIyxsyK9BREKum9YEaLP5fX4Pemokbt1eKWqSsfLLfs5Z9Oh?=
 =?iso-8859-1?Q?5v5WUt2h3nlpQesUxWHCpXQSFCK7QG54cRjH5iY9RvGlWNNYEtcyKOWhYD?=
 =?iso-8859-1?Q?E7TLdu6R657AuaOknUWD/thp27Hciy3wKivCqCYuIU7fl4x2GC1WshUQsQ?=
 =?iso-8859-1?Q?3MsbKxJ8ZbBioNScDq2Yi/AlPdjuyT3g7e8WtDb0p9ckkl/k3XZJ75NVBQ?=
 =?iso-8859-1?Q?OepRgTaxwjcTfDOZZR/EpAPmMLzhwBoxknrdyjU8/nilJOubG0aTEms8wi?=
 =?iso-8859-1?Q?P0QAac7nY6+dY9VVdO4NDyhMH5e0jJmtpkKwrtU9jNyR6ADgRhG3Z4UhMk?=
 =?iso-8859-1?Q?D2S2katcsS?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4635838-55bc-4d3f-e449-08d9879fd8a6
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:06.2460
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FHyr22TxZhxU2wlIcAS/6HKIQZH6nQOhJCXhRmTrGpmjUE2geQlazy6a04IL6EYGQ4eWyD4O/t8frTJcQePDcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5044
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=996 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-GUID: WkWzlezxyANUevwPSjcQCtZscdfUiHp4
X-Proofpoint-ORIG-GUID: WkWzlezxyANUevwPSjcQCtZscdfUiHp4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 6da5020a8656..1bdcda3fe492 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5831,7 +5831,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, -1, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6129,9 +6129,7 @@ static void mem_cgroup_move_charge(void)
 	 * When we have consumed all precharges and failed in doing
 	 * additional charge, the page walk just aborts.
 	 */
-	walk_page_range(mc.mm, 0, mc.mm->highest_vm_end, &charge_walk_ops,
-			NULL);
-
+	walk_page_range(mc.mm, 0, -1, &charge_walk_ops, NULL);
 	mmap_read_unlock(mc.mm);
 	atomic_dec(&mc.from->moving_account);
 }
--=20
2.30.2
