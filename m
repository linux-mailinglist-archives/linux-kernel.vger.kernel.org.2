Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB1BC3EEFCF
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241158AbhHQP46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:58 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53524 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238459AbhHQPtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:12 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkqVP017407;
        Tue, 17 Aug 2021 15:48:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aQJbV9te+OlvLjiD2ATfs6zVoYJClVloPuGLEfWxg+Y=;
 b=rSpEW2Rcz53lXaW+l/lA+wTojRcYCjUdYkjwmWhNsNJOF4on7cJyYFJi/ojhRlW5ziDQ
 VHzSmEijxp7i7+xSICLZscf2rd2dZuUrjwaZIvA6eOzCjCpsssgiKdp+hDthWLsZqE+3
 O6AbC6sVyl+Ylx7qTLbop/Wq7Z8o7WsNS9jbh2PDHsjQQb329+3cBbTR0/LniPlNbhoK
 ethRtKmORFiKsa+y2iUcTD7lEjlPBPGxGmvAwtw7yI1HfUdOVWK29fMPNMQavHjuEl80
 No6qy6AmN9fwxdZJPK4B0nk/qxhn/vfS4Tg9PVeDgGGY6luroIlDQBt0pZ8OZXxQRBmD ig== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=aQJbV9te+OlvLjiD2ATfs6zVoYJClVloPuGLEfWxg+Y=;
 b=R8V+nV4X0SLdpNIVXgiMSHxiVtmGMNu2hpt6PxpTNmkLzv5+C57ypqMTXCUhbfl2pYWd
 7FN/XYwwpl9QokXsb9onYzHXoQLefWkIyjwWYnUY21lOEbIKxC3Cg8pxCoiW7C6ASsM/
 wq71haFzHN88RVHn1FtnGRKRrLPvfeuSR+9TvzcRAhH7eQ8jpKiPf6HwlKrBR5YmMvcb
 CNjkt9Zgc6vFJfQ0auisZ6UwIScAayGRXy7n1toX3yeUQrocSEKZsRpkKCQrnTtAyUZ+
 bBaiHvFbSFThDKz5ZCy4ch7DTYdV/DuGLHmx0/Nag3lesu+nDzhQgLOh+YA1LA9d0EVU sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g6u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfh158706;
        Tue, 17 Aug 2021 15:48:06 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-13
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FOj3v+P+EnMM6GkYmqW3KHJCLIuFp50bYTeIumdwGZwwBRRIPCdP2pkOGnxW7Ai8y8qEBzBdXyjFzPBnony4RuaGIiW3GAXDL/UPahxdiBn1okqWKLqcefrvaZkaBoIdElmRbavqdmT44Gy2vAgsArKr+YOZu6oDTah8Ik13XgSf931iApAvKwVe2LhGOSPp/F1epmpMOeB0ccPOqZqcixEVJy0nGX66y7M8JlMBSuSpwbGGmkYN4Rlj0i202+sIEtUxa4pOyU/3+8vChEBqCebbHBamx/A86w1BFsa+pGxXPtZvtT2V5T8U109fnsWR3pSMf5ip9eNl0ybEbYoL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQJbV9te+OlvLjiD2ATfs6zVoYJClVloPuGLEfWxg+Y=;
 b=VswxoXhNUGXmXNRf4BaM1FnfbRX/eUpl+9incvXhZBLEipv9v/2e0Ig5itGR1XjPv2Kbf+LMmfLtgS+1U7MN0XJG5NEPVUuZrWL+cInRsngCz5AJiSeoMRjLbj8EOB6SgKKqJUY5TeSF53SiQpovjh1dscZwFQ3DPczh88guniRPeSfEDzzeAXz1lE/IBdlY69cRHuGuFP89cz32jswE1RICa1xn3/6PGpu2ljFsPCMMOaMIIpms89+QOwNAhlUpK10muI3h5oCD289EU/8ahOpQW80gVuGqeJ5eHrqtAPGucQkCMVk+wAa0P8+E7bepy9Gf4hHajJvDtRRyfTjfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQJbV9te+OlvLjiD2ATfs6zVoYJClVloPuGLEfWxg+Y=;
 b=DSRDWJH7U1OPfLo2UAsUM02CKD2wVLE4H37XqvaLtiX8EdS57AAiugdYh+o54eksZ0JwBSM/h7K0itWS9zKm1Spiw/i6utORBwqfpKXzZpAq60rtMZrR35tGwJte4gPjpswtwaHV+RmXxTyXVtOTF5+t9KHcWbwm/TLgjREs61E=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:58 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:58 +0000
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
Subject: [PATCH v2 55/61] mm/mremap: Use vma_next() instead of vma linked list
Thread-Topic: [PATCH v2 55/61] mm/mremap: Use vma_next() instead of vma linked
 list
Thread-Index: AQHXk38x7Ltx+V1ytUO+LJTC0PTPUA==
Date:   Tue, 17 Aug 2021 15:47:32 +0000
Message-ID: <20210817154651.1570984-56-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 9c673ed2-5d31-4a45-9fde-08d96196630b
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB35802DB3A8A94656B8E5DBE1FDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:431;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8ZFbm2ymeazi/nQBzuE3hv/t2sVv6vpsMVQjqXl2b5chxbKdbir567D4DCdKtn/HQ6mL/Z0O1UNl0C55yOHO4kNqw7kqvEMlvOnR86PDD+NSFBTovw1XM31O+wDiPnUH8NZZfCrcWyPf1r3DwyU9jxWgf7N0W1JkAkoj+08RSHPDsIxoI0qO5YE4cRhhCyHFlFa2QeEsmsMLMqTVXO6QPj/SftdnL+/i1OPuyvZDy6riC+9T/ydluxoKgqzMlqoM9A9KttG5JS/QYoxFcsBd6/QQmS1ikVA4y1loW845EWk121KlNl+/fnAplXP8re9iK1y90KlHZEO22Vj8+LE3dJqLfdZuqYkFjwLfk1PQ758rzE+w4evJc+aiaGfMb37bTuqdR9sxwnsApk+ba6YqsxszxVPAdp4QiujHekOnC0xFlnJd0sxL1zxFK09LWTvS0JUToeVylQI9AZzL2kFkglGQex2kYR5HEZ/ORsibAuAoJO0uedAk1rM2eScjFloCBddQ0KQzC800X1OVYgybRryUvqrYtD/WUXt0sU8hBSRFu2oWUMOIHGzfdjbfrytHct3Ks5L7kRaCM0RCnYdaWjtGOfJRoEpmkefKJ1YWkQtngNlGymlHLyKM1MDel6Q2/Y34jAI3WUFANRFJLjufZDkwDuYdRQKJUXwWk4vohD8pKoyjFsveX6i9hhjYWUuU1UIthOazpicka5TsInUPg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?65t6BhTSjBE2auZ8twrkN/CMz+HppGCglhTj7K6R31R4yREb+2qccOYn6V?=
 =?iso-8859-1?Q?GcsWVoVDFtCZN3/A4zmMN568j/Q441dfPuiw5sEnknXP2fqnlmGTTG9KmT?=
 =?iso-8859-1?Q?pNJTDc+PDzYbtG538Gq7SmPJPBnKl0CUrMMw0bB7XMw3TjgHsNQdRlNKqg?=
 =?iso-8859-1?Q?1RlioTMirypeQ41Jel38I8+/Hn7CXRSxwSKiyCfBqyxkUHp8WD0BRdpmxk?=
 =?iso-8859-1?Q?CFFNnXq+L9C0WNAgm5RNHWA6uC102Swgn7JEljXgwBm66b/Vq/r/L89oMl?=
 =?iso-8859-1?Q?Usw+Mbp5rskaRrtRhlS5TIIK50SInDY5c2p85H5hf00TzQLbyDbnXMx38H?=
 =?iso-8859-1?Q?6arorGMdGRDyQQ4TYhGBcXpeHukCXTTSzPTp1cyvjOaOUCPa9EpocDKAQI?=
 =?iso-8859-1?Q?D2bdvo81Q4iNHW81NEopSGY6vM8/Dz4sirV1SVAVVknDzh9/vvl4cZMOcj?=
 =?iso-8859-1?Q?aMAJ3Vdevu4T+IjmWfj3OowJfu/YBlHRDQFhEJxw7aP/NDWaKQTDPNRU7z?=
 =?iso-8859-1?Q?ysokRcB7TujEHS8xmlz0jbhruUiaBjXyooQXOiFw4d6KvM3jE2FdJmVXUJ?=
 =?iso-8859-1?Q?hTld1uvCSSODV7j3BN8gAp8F7cjrTLSWx00b8NUGC4SGifSIzuMqUDElEi?=
 =?iso-8859-1?Q?llcE9jVE6GujD8Klsf1Pe27jeSKjHc0/tgEtJFDaReibGtd8n6W22ccuMr?=
 =?iso-8859-1?Q?oq1HdNm/N8wquoun3yF5muD3Fu96/F3k4z7KSEKCLtYpguTC0u+h9PhIBA?=
 =?iso-8859-1?Q?EOLlyoxq5MSOkISLs7ei9j3iYg6GTMMvQH3qDLGNlBoSryzL7FUGS3ljz/?=
 =?iso-8859-1?Q?FxPka4mBYtTHyUk3kIporCgTfzYmtB3t+1cJYUBylKv3Xp4cgfGkF+JdyO?=
 =?iso-8859-1?Q?lJfbZ1H1hLWFm8FFBhBy4x60J13hH6zK6G95qwH7zrUZboLYbJiOcXaaEV?=
 =?iso-8859-1?Q?zhIRyMotW28Qfhr/kUQIkio9h/DD3QqsJ0mPhS76XGvjU6KR+wcoyVJCUK?=
 =?iso-8859-1?Q?oaofPLLSuNyIRhyqPYEpaJ+jiLJ22tNO58UcOKqIQgItHv9JOL70mFmKfd?=
 =?iso-8859-1?Q?Oo/1/Vc018BfKnXxsDrL6pE75jNSzH7+Kwvx4i2HYWQk73BD6rRI+s+FDD?=
 =?iso-8859-1?Q?VeQaPihSxq+pQfUslPeJ4ALpTmKzanDs+P2I6PccM6v/4XMUmgCla4cNOb?=
 =?iso-8859-1?Q?O4G/ySMaIM4tQz57DUEvLyg7xk7euSE5gRfb0alpMlVsHutGeBlNb4CvL2?=
 =?iso-8859-1?Q?zWjadGpqOllbe+b+vscoi/maKTUnuRfBE0K95hy9ovDOi4liOBCFJqgbr0?=
 =?iso-8859-1?Q?SMJj7lW3CcsxW9VSatOSg5jCJFXm4Q1SzQ3mUn/AZUmihujEidzElooGib?=
 =?iso-8859-1?Q?dNGQk/X/yB?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c673ed2-5d31-4a45-9fde-08d96196630b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:32.6789
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1hx+JuAlnfMnq3lNzHBCQcJJuNR6ad7guRZfv81qJ3DFHXjHnm+75puNqgakEUd/dd2i45DeD3cb4bG3zcD5GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: VBStzAD4tv0BtKwBw3QRD14-MswWZwJx
X-Proofpoint-ORIG-GUID: VBStzAD4tv0BtKwBw3QRD14-MswWZwJx
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/mremap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index f48ccfcf3217..b364d08673b4 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -705,7 +705,7 @@ static unsigned long move_vma(struct vm_area_struct *vm=
a,
 	if (excess) {
 		vma->vm_flags |=3D VM_ACCOUNT;
 		if (split)
-			vma->vm_next->vm_flags |=3D VM_ACCOUNT;
+			vma_next(mm, vma)->vm_flags |=3D VM_ACCOUNT;
 	}
=20
 	return new_addr;
@@ -864,9 +864,11 @@ static unsigned long mremap_to(unsigned long addr, uns=
igned long old_len,
 static int vma_expandable(struct vm_area_struct *vma, unsigned long delta)
 {
 	unsigned long end =3D vma->vm_end + delta;
+	struct vm_area_struct *next;
 	if (end < vma->vm_end) /* overflow */
 		return 0;
-	if (vma->vm_next && vma->vm_next->vm_start < end) /* intersection */
+	next =3D vma_next(vma->vm_mm, vma);
+	if (next && next->vm_start < end) /* intersection */
 		return 0;
 	if (get_unmapped_area(NULL, vma->vm_start, end - vma->vm_start,
 			      0, MAP_FIXED) & ~PAGE_MASK)
--=20
2.30.2
