Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE8E3EEF9C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240419AbhHQPyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:54:18 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:49512 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240358AbhHQPtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:15 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkF7P022508;
        Tue, 17 Aug 2021 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=HwcltoXE7rjaktXRjcyLKPWH0/Nuafdlj7+TJiUAsms=;
 b=K5TVwGbjXd5YYIRdtSCnl9oSVgz8oayEcbXfJvf3AIBkhGya2xtjAwUdFEv89EPquFaA
 grmVNWf8gWho6NAhtUpUbj5j29wa6HNOe3trNCMrOIOk/0dpn4B6UBuG/2wPM6jkFqHY
 cMfuSFvZ/uAdi+khYxQ592kf3+RFjEIucxTIJzh2OEQlqOBUsBtG9kZXnJjCvLjmxe4w
 U+GYME34EV4kSQnGOeYNxFxlL+9tyChdjvP+ZTL6NAUm62fcBSnJhDYvSsuo8V40Wgws
 cO92YPcSPMycWy0sLU4zI2iBg89Pjis/eaUXlrOwaX8/h3F2dGQZTtLOVA6a36EvIHRR Mw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=HwcltoXE7rjaktXRjcyLKPWH0/Nuafdlj7+TJiUAsms=;
 b=GUsJUUmgNU0QqIu53X9+6Jo2p0FAmuZ3fXO6UZw/p+mmBMOqjmf+tgOb9+RycEDYMTlX
 7B1lJrVcjrr3EO4j0UgduzSZqO6IdLyDdLOyB7bp6RjdtFjxU/3w2SYqe9gPXjgErBbQ
 AFTEwzjE5BX4RSrWvjLUjWG6xxvDOmM2kJ6Wg9sknIHaIlkEbaRE/4yVHTCzVG4ZjTD2
 0vHwzeq0M9gLH79g2SSUO4tWdwQ8s0Z4eiUEJIvTN58a8kY55JIbYkefUKwfpZ3OOcb7
 Nnb6DPucmqQeaIaRmj2g0ea/0h+q4c5RW7Nab2iZY4k1FM/7l8atGZin4xIzeoXq3uKI Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgpgm90e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:05 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmff158706;
        Tue, 17 Aug 2021 15:48:04 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2+W1DbXTVDyaELMoei8VY4wHyONs9RDLC65+11tBUIeP0k5nfM7JtU9Bwexz/bYUKkzLPAhQ+OnzE5OfqNoDM2ohpVsEPA8jPGODWa4G8Tfq5AgW75TP6R40jyIhdU57vRqnucKfYAzfX53r4D0HV1BaExqAkdWksVFO/fqXHkYhtGq18RtdQW88Pxl+5MJSSDMxDKEEAwlpmpEyo8OC9MGUU3HXo4HgL+mKtt4m5E3xWi5fQ3AX2PzaGnqh0KMlYSonMJHgAM5bQcmVIZxbA+vKQYnYYfVJSKs4FTJxpOwCEQYwljbMrZVnkH8mkelSF8Bqa3AAyUGmDt3UWL5QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwcltoXE7rjaktXRjcyLKPWH0/Nuafdlj7+TJiUAsms=;
 b=EnJ99xQLjwjtest4vKMIpuCPWVnj3Kx/PcDQykKE6DyYxUVvA6X4T6PI+e6ZawuVJvXBSfgahom4eqLkibcmLKeOA7lj+GXQIRASLJjWj6BkMBATl7uYbXouxmjt/VIQi1vSftZNSlyKiQzb9cd5nzR3bVRycr108yp7p5gJQsOODOktWJcpTg8KD02PDqga/C82O5uX9rmceYRNIFFwSjN9hzXxDASi89w0mfTanJYegiiZxp43MpqlxJy01fVmsdYokBu9XjerUIRz8vtw4JuVTnyBiYpvRMxkhtIDKjo37LXY3w+AiHQXQH879E2VQyFpK64nsoGaDOEVJI3MXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwcltoXE7rjaktXRjcyLKPWH0/Nuafdlj7+TJiUAsms=;
 b=JYP7hnbJCeZ/IjU2ZWDRwJzyC9nTFPlXbnh3YiUbyALTHHC5knMmftGwBgwnR6iWyPs+wBIRwP4dVs/Y2+/HSZcJl5IWnURzNBYQ9+lWVJeK+PsqG1auTl0W14zSTw0cJqOKm+WB94U/sPmWMk2oFPFlphEhxwC4AluByogbviQ=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:57 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:57 +0000
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
Subject: [PATCH v2 51/61] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Topic: [PATCH v2 51/61] mm/memcontrol: Stop using mm->highest_vm_end
Thread-Index: AQHXk38wEBQPYnWWi0ON9fIrNrNqeQ==
Date:   Tue, 17 Aug 2021 15:47:31 +0000
Message-ID: <20210817154651.1570984-52-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 872defac-c52b-4c46-cbf1-08d961966247
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB35803CB0F2E8F54BE3A0A1A5FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3383;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DdFe+Iiv0tu+eB5zPFK8uHfONYQSYwCTX7menjFXXfs/ptQcP8W/X0/uBtyHiccvJ26+K4EMXY4o3k9sEFerQ/MCfvdVPgO7fhM55ElKslrGD1hJxu2Qv8va9nW5+Ej5YrMD58jXINhJeoEbAMCm3gJfEUOJXBHv5TwV6dazNhyBwBYtxzSdr4CpnwFkZCuW2Kq0eP8Zl6Z9nQTpiSin1Ga5D+wmaKXoUsbXVbCOjwyVhxcaKzTNYKahqgfNB6IWFV7aaEMysqN95TIFXCIyEqf/vL6v+Fq8sQ0vIfbdQL5xYAWzQtLyPkvxB5GcA6gMu+zjcbbR/PnE12Kr34XOIDw6zVi9ffL+mN6eRvR1XiL5NnVZbdZoHkw94LkNN4FQOJ70ZS7cg4kTRofJpMUMlsROl9VBde6V/JhgTZ/KMCCUQz6GMhz+xJvXtd5ejEvawlXmwDcIa+L8es1SbQHO4/ZyHf3C0YmN/NHD6aeVYHRPWPKgKOzFEnlwao9E/e5CNT4EdqBVQxyM7cVyRWNuAe2iIY/uMe/f0MRmAsUPXx3V8og0ufVWzn0Eax3omuLeYTgi3eKXFeQxxNx97bMmhd79QMA9gjyIjxa5fwBYU3cW9oJhhNXnbVZctMAVhomTmBzy+oe/iQpigA+EfJTRvXM4zuXPJKJELz0x25n9/BQS9COo0qbD/l5/eqFxciiaeMJx5idkpIt3mnrFX0XN/g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(4744005)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?XcLxLG3fz+XCLITeh3Z1FoT5ctFv3CSdfYlLFGTM2ONWbIRjxqW5Y4MbTb?=
 =?iso-8859-1?Q?6Gh/Tk0WMzCPqu8J27vuttNPvyDoeSy1i/1tfKgiiyKZV+8OPBoY3RVPNN?=
 =?iso-8859-1?Q?SxOL8M84EoFVe9DzOByndG7l8176w/UHiK9mTd87QBMeAgGQuow2ESzngM?=
 =?iso-8859-1?Q?iA6JH4k7CnN7SsZhM2tYwH/YztXnwGX8Le7L3gliwlsACU/X8FL37mNaO3?=
 =?iso-8859-1?Q?2QBF+X5cMGvLVoTQkREsADMz9C4IkwCW9NY3F7cjRYGRVlanVRkHyMuutK?=
 =?iso-8859-1?Q?+dbTFc+L3wOcZ+J+lBfZwz8qg8YyXOYUwdYoKnfej4/gfz7a9eY0Y1M5gs?=
 =?iso-8859-1?Q?sCK4FXKTtZwkYaeIYISMFYxL2hoMzYpXWIAXnIqhTVaALTAWAbVyQC5dyG?=
 =?iso-8859-1?Q?hIJJr1CHROxPP97sv4Tj6nAdua8/eQFP8bq/MYlLpcC1yGi4bPjnC7yQQ4?=
 =?iso-8859-1?Q?duLGwiq75rKcRlr33BiAJpOHCCalo+bzT5l0eriScYewkA0okttnSq03DI?=
 =?iso-8859-1?Q?pm3m3G5dyCnUbpEVzvtxZfsOa5ufg6TNw6Gmfk7oMPGW71K88lZNBj8z+f?=
 =?iso-8859-1?Q?xUD8nojeo9/LBZIrMfGzJ2y9FxoUq6f3ahz8tvJAMcsI5VV4Xmezo9IFmv?=
 =?iso-8859-1?Q?lX2g2YwPBAJzF9/jyTEo7CqY6lkiyZn+mUC2GztiEnoSVey9Y/U/E4Yi3/?=
 =?iso-8859-1?Q?//pnOqQpVFsXD5JIfYIOIS+VZM3IVJs2E0RskI5P0qLUrCNj8+UJIcE7Kl?=
 =?iso-8859-1?Q?M5KiZC7qIi1LWC0kcMWtTsOsW5SFxLTCq+vGuciWy8Qd6vT1G7Xnbyt/BN?=
 =?iso-8859-1?Q?jRmNDmgnwqjktKQXc/+KCyQ7ZQjxGV/qxqR6S1G5aOgkhLf7rOCEABjHgr?=
 =?iso-8859-1?Q?5ufBdQDtTvPtAe0cHiC4x+ZV2QruYKAV2QJuCD7ql/IWPn5hPTLGzlthP/?=
 =?iso-8859-1?Q?1LH4kVZOBUCA8kpNzwQk5dFgjYZaETk00yf1J8EWO4QEzofxQCCufjGojS?=
 =?iso-8859-1?Q?tdt1fEBiSqIlp8Kjo/56XKPO5MqBq5+S3QZwIGDZ2jl4sWmk4myWwRKHz5?=
 =?iso-8859-1?Q?niefJasB1Fe3e5PtOujUxmX/8sDhNwIDxBoHdZpiQvZE1XjrRpIfZZN05R?=
 =?iso-8859-1?Q?JHHnRVsc5Os8TPnbYnRU2jGDkorLGVftX34K/PwvQJoAnJ66klo+lfh9L/?=
 =?iso-8859-1?Q?li4l/uXpNwqx3f39WzWE4kY+zR1zVUmQydQ5C6b8sxtnRpkKnX5VB7isiW?=
 =?iso-8859-1?Q?1iAIx2ifF5rAF5WQa1JhJMfSPEAFillcb31vISkSgiSFNUPyZI6XJgzsiR?=
 =?iso-8859-1?Q?phJFo0yfPM8/uIobFdfF4P43rhzNgdH8TUAnGWC+ytTAfrrGp8HOheteBk?=
 =?iso-8859-1?Q?Nh6Age5GZc?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 872defac-c52b-4c46-cbf1-08d961966247
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:31.5837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OCDhufdiZvsy8HFah6C1hRUrgdVve70yKQRZCvIuojUG6gOojDCDYAc8eZwZOhL7Et/f8Fj4Nx0OhJUxr7Nz4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: 5gPgkbHpXls1eVn0RTfZgXKJzUMfJ0Xk
X-Proofpoint-ORIG-GUID: 5gPgkbHpXls1eVn0RTfZgXKJzUMfJ0Xk
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/memcontrol.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 3e7c205a1852..943e8554a4bb 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5830,7 +5830,7 @@ static unsigned long mem_cgroup_count_precharge(struc=
t mm_struct *mm)
 	unsigned long precharge;
=20
 	mmap_read_lock(mm);
-	walk_page_range(mm, 0, mm->highest_vm_end, &precharge_walk_ops, NULL);
+	walk_page_range(mm, 0, -1, &precharge_walk_ops, NULL);
 	mmap_read_unlock(mm);
=20
 	precharge =3D mc.precharge;
@@ -6128,9 +6128,7 @@ static void mem_cgroup_move_charge(void)
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
