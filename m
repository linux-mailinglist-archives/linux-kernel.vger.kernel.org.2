Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F14FA36DBDA
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240499AbhD1Ph5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:37:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:63936 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239986AbhD1PhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:37:01 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFOcnR011645;
        Wed, 28 Apr 2021 15:35:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=lDuu09wJBa7YYQ7mxXae6D1w6Qf6gC8hA8PyBKDo+wQ=;
 b=KFpf0MPlxHRbQMFn1Sn6duQTG7NWbFkimXgOgn75/gANA6yO0wMVECx3DJpBm9teh8KD
 arhFcKgawc9Rrz93gGh1sdbR8ubPqJmWaF2y631y4lj6jOnMWf46R6F9Heg0qBBsPcqU
 C3BJqR8eR+QL4zuRcRbFjqdCrzM7Dr86GRD9mWnqMW38Cxvykys7fdjXt2ltT22YekvJ
 jJozJ1Enn6Oe1izb9apjR5J9TY1Y14/g1vsljfWoBuK1BjpmeX+bwSeefiMDufUrObpL
 TcEOpEWxJbIN8nFc0WBU0n6Yti3X3JrABRQ8GOiPeq7tw+FADb6j0SQ2/3i6IZqGik4w DA== 
Received: from oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 38789105xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:54 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFWkAX003673;
        Wed, 28 Apr 2021 15:35:53 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by aserp3030.oracle.com with ESMTP id 3874d273w0-11
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:35:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=magtRcIQoSyxI3a0UZOct+yOU7vTB5KaSSnasl67ApboNla3nZsEpuCR+KMnnB0+9h9fAAbZeDV0I3jm+uh/PHlMnrt8XgA839/M1mxJSvY5/U8FqhZi36XByk4Y7APCj5GVVfHFFDKOGdwD1jzKhUicSBGV7D8E2jFwingfgshunYfYP0nLo74+gmcDubdUu32ePjq93b2Oue0Q+amGpuMvozjVA40DxUuLiYh/Hh4+jNZZ3Vh+ets7qDvsqp3QrcH823pztkHZQ+6Cg+W+rjyby17/2RM4jaML2r/VLixIGzdXhxhF3owmgWts94V2SdNoanvEo+zVHjejw6bRQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDuu09wJBa7YYQ7mxXae6D1w6Qf6gC8hA8PyBKDo+wQ=;
 b=YuvHb+nSLshCuvQzSS3fPkVTX/UyCbZzJvekvOwY6PEPOKZw0m/AU21XMW5wrRwjKvozWN7ucByLk0VMd8+wraI9VeR5andGZHVOFkZkupctuEgLfg9R2RDewjwHYl2gzhvwUtXyGHTtr9mAlD36PQmgcKlyT6TI3q394QHj7hS5BqbtFR3DCQtOQTAvjDSQSNntQ3bT9RgT6UT9x9uBohXaPBeO5GJUGuzrNjMLGQWEdUTw+Ss/NtsmkRhd9qrgFOlLh48x3lbybsRg0AVkvIxpRelMoc6rn/FQIsBw9N05zEtYuefQUiI/Ajqe3pJCfK4H4I/VbQbQq1SObbBt7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDuu09wJBa7YYQ7mxXae6D1w6Qf6gC8hA8PyBKDo+wQ=;
 b=ryi0HstakZgpOjLNIWeuREvoKMOEJUAkNWU2vFEfXpAQJcPbUQNKXJsUgIrCbGJmtIng5eI5TYDhwlMq1sAh90f/NhgjFqsv6wfYV8at5+E3MM/tYzHIcU+A/Pmx0dLKnVJFzO4Phs9KEMVI1+kNFfDHyeNwqZzBaO+i8TDbAGQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4497.namprd10.prod.outlook.com (2603:10b6:303:9d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Wed, 28 Apr
 2021 15:35:49 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:35:49 +0000
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
Subject: [PATCH 14/94] misc/sgi-gru/grufault: Use vma_lookup() in
 gru_find_vma()
Thread-Topic: [PATCH 14/94] misc/sgi-gru/grufault: Use vma_lookup() in
 gru_find_vma()
Thread-Index: AQHXPEQqv0xpXkdFOUSgDNoqmZdW8g==
Date:   Wed, 28 Apr 2021 15:35:49 +0000
Message-ID: <20210428153542.2814175-15-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 8d8126cd-a17b-4955-6fc3-08d90a5b4cc9
x-ms-traffictypediagnostic: CO1PR10MB4497:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB44974C3D82E5B40BD700A816FD409@CO1PR10MB4497.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: T3F/5Bz173Z6YLBdB83bXRecvvtZyHMhF206GxOcpd3J5634om4cVIeocgXdW6/6VOQRMfIYD+2upF+C8u+zmPdlQWTgLCD4MNJYkRuaK/SeOG9JgJ6OnG+fQSuQLPNkuy89qnn9HWZa20rzlY/C+t54sTh3dUIHnJzJevAL0Rn39GQkQ1UYwpRWKXRmTjlXfSDnjo1OP/2c5XVMywq3BzSSkXKTZprHva//5B99svtrXzSxT8mlY0MmDexUj79t/JUeRQ585Rr+TnhR1Ubu5SQjjzRxIsxjUGgc9GLGjlCcGChtj8KE7KJDEgpAm/wNnNko5qS6Mfpxsiz0+SMCb5KOSgZmrFkVKwCVEah78+gnYTG42tdpi+9Jq1mhR3N0Akv0r7DGrOqWzJYEa/aT+dhJBT/lfqhNaSF2eqgOmk4ElaAkXMBs2JU8vEEfUgQwT3IgYKyuN+zR1pyH3w9TN25iKTFKW8R+RmRLCc6/Hi6C6UBc70bx2WYAhDXCYXaWfX4BT2pQw0fI209rDV4pDnTMJKAnvfmeDXSmtf5s2AXvJgw0wdM+LyT9jHINd0rafBt+nkUf2BTOT5X3DnYO5f4g7qfXTAd9aLybc/ZhfRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(136003)(346002)(376002)(366004)(39860400002)(2616005)(54906003)(4326008)(110136005)(36756003)(4744005)(5660300002)(6486002)(26005)(6512007)(6506007)(86362001)(38100700002)(76116006)(478600001)(2906002)(66446008)(71200400001)(91956017)(64756008)(66556008)(66476007)(7416002)(66946007)(122000001)(8676002)(1076003)(83380400001)(8936002)(316002)(107886003)(44832011)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?BRTVWXV2bkmtcteGmni+aDUJQdl856lsgM3YFiu+dnUrwWxWo1b3U/GeMn?=
 =?iso-8859-1?Q?gE8NEbUR+rR+cbF5Y6JAmwzQmBM+rGkFdBOEcQZjOaoUNYYBwnkqfieXdR?=
 =?iso-8859-1?Q?8XgFBQ9WObFgjmyDhJN1Xjz3a91SA7GhhmcDEBV+v1VnLaeF42du8o1kkD?=
 =?iso-8859-1?Q?MMtJtewplSwIes9Fv4I3UvNuRXza910WCwvJwvHzOus9zooP0cr9FZWtu0?=
 =?iso-8859-1?Q?1I/OGI7sx0+SwmvIiIV4i6Ioq2hIw7BzAqW6zFGLlEnAMfv+rZOaYTzIEg?=
 =?iso-8859-1?Q?KqiafomVfPQgNetkvAWSsvzBdNFQUTsvdAQlE5lnJmDGjkOGDkoFBHW+TC?=
 =?iso-8859-1?Q?f2i/qAQjiw6wLvUO8L85Xzk/CoQfRliTtPYJqRh/EjkIWwO5IRl/gCd7gd?=
 =?iso-8859-1?Q?X9hQIMml86dDoUqxdWQPHSiiz12uJNgnJarKRS7EN30pLeH8cdKwBuSLhA?=
 =?iso-8859-1?Q?cmi6Knm7BPxXZhpLP9Km63kPxYJ5IF0jeI97r707dlRbqCmNneXlcz/+xv?=
 =?iso-8859-1?Q?8GZBhIUBwTPQ3rCAoU8l6Kf8lxyEWCK1yK6zZ6Ztfao5g5dHqka9pPfxSv?=
 =?iso-8859-1?Q?byRp7jLTe/qZ4SnIECmdRxDb6BcQcrhIpuKzQ53HWb6d3I1Ddu+jGw5IaZ?=
 =?iso-8859-1?Q?w9a3DBFNpkt/jM2GuqmwoXRxmV9n9go4tEoyIzJDThpeTzWZtb8mBEH/Mr?=
 =?iso-8859-1?Q?ykYewMkB9ggfbbSZQqAD0F1bKPyGW8p/QkezHUK+EgA0lE7rlQjneMC9Ge?=
 =?iso-8859-1?Q?l3lJEMvsr26U4wj2wCPBoL+/MiecbFdpEiz7wggV0hC7f3DfVYQjj3NEBe?=
 =?iso-8859-1?Q?Oi4Ddm8Xdy946k/IP4/JIKmx5RGi2kxOKuI6PMXMRwRTFRfY7/onrIiurw?=
 =?iso-8859-1?Q?iY7mqAiUj7EpHa26+5ZDfFrSoJ83/P5wy5NdjgpzbzzD5qoKhva0M4/eSn?=
 =?iso-8859-1?Q?nUMa97grtm91MmAzH7psU8xpoIu52lqOSdoZas9De+ATpDljSo+4MUXsxV?=
 =?iso-8859-1?Q?kF+q9zBQgPo36QyZvsoSGCxl2VxnA9ru8WkmEZpsz0Ccb+4tjrnfOm2M95?=
 =?iso-8859-1?Q?DIgX4F/ecS9e6KkwkQc87Fkas0PBh9JY9Uf1kqlSRtP/5XW6MbQwzpQ5rE?=
 =?iso-8859-1?Q?R9AubjrcauXxN/YpYgoB0/pJ9csHcToIlRgHnbZZ/t4zRdT54/eg9MgfVZ?=
 =?iso-8859-1?Q?p5rhhMm94BU2u2hoFgmZQoBHaHK8KTGrRUO8oGC3+RtYH37OVlqXZ9T3ze?=
 =?iso-8859-1?Q?nSHPl85YMzxbE5O4O2iooYRcctf2768FLPM9m3VLCsKgtzA3GfZLuFIlSm?=
 =?iso-8859-1?Q?mojKI55mwBjgNQyLZg0P85WavvaxGHJrPX/rQVuefYcd/KU9Wmu4NU9Ayf?=
 =?iso-8859-1?Q?zHXcSntXVtCijGFGEDVacZc0y6bczwMQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d8126cd-a17b-4955-6fc3-08d90a5b4cc9
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:35:49.4837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nmaO7KDRQD8rK9+oRqYfXc7A9JTeP3JOmunZteRSmKtSOqPgD5M8C8qt+weqfkNvPSWgqlHex8VaK16WUQ2eeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4497
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: laLYbALudghxJYE8cRw524dRSE3r7J9q
X-Proofpoint-ORIG-GUID: laLYbALudghxJYE8cRw524dRSE3r7J9q
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use vma_lookup() to avoid needing to validate the VMA returned and for
easier to read code.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/misc/sgi-gru/grufault.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufault.c b/drivers/misc/sgi-gru/grufaul=
t.c
index 723825524ea0..d7ef61e602ed 100644
--- a/drivers/misc/sgi-gru/grufault.c
+++ b/drivers/misc/sgi-gru/grufault.c
@@ -49,8 +49,8 @@ struct vm_area_struct *gru_find_vma(unsigned long vaddr)
 {
 	struct vm_area_struct *vma;
=20
-	vma =3D find_vma(current->mm, vaddr);
-	if (vma && vma->vm_start <=3D vaddr && vma->vm_ops =3D=3D &gru_vm_ops)
+	vma =3D vma_lookup(current->mm, vaddr);
+	if (vma && vma->vm_ops =3D=3D &gru_vm_ops)
 		return vma;
 	return NULL;
 }
--=20
2.30.2
