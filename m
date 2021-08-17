Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE883EEFA8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235158AbhHQPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:00 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20846 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240316AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkIpU018121;
        Tue, 17 Aug 2021 15:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=C5m8ICqbT8QcbPDkU7CycSDuiGQ7WEx/MzrPgjELuw0=;
 b=WLHDpbsG0AAtwIHTtjUNBG6qDjX/A8+UR8vYUCtt9GG0M83jNXjARYcUXPwSWrP3gnws
 xZdWhGxf0sZvCSW+OYUMjHtzO1fJb9Z0TYFi9wBXP4kOaJ+RgBnVjGt1r/0CNOAKaYCo
 BqzkaJrCNyCI/R4bms8S1SjBqTs3vgCDc2aIw5A5aHDUwMcLNOUZ+Sv64flfaMJ4JLVn
 5BSNS6Xn7AeUObvn8xMUgf5Nya8kIUtjfX44jvXOC+McuezKhxDcwdSVM4+h55+5ipdN
 l2dvq/ldFvtTbBqBj/5zMUrzLAr3GZv6NTMcVMyZ1rRB6rerqso94eoMBCr/gzw7qPBm aw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=C5m8ICqbT8QcbPDkU7CycSDuiGQ7WEx/MzrPgjELuw0=;
 b=y2jz8L8iZZo6CU5/PWb9afkShrspUQ7SW/PVStvTql1fwxsyGNCtvsK7T46ELUQGy3Tj
 rnpFHeCsI2U8/TxCEERJjmo9NNQioUBKY5+QIORVQ/bPKTiL5S0PoMm1l0ZLGPkXiZUI
 S3VCZ6o9FebM29ds6NVOeD3ysAH4/PDddfKACNs997Vw93Er9TNrGLtlg6ogEyl4a5XC
 EWW0XO9KESZxauMfsnC4/BELZXSgdw0Fuc3nE+RuAibQS7RHNT6+e6qboEMaX66FOl/Y
 ScTUl6Gw2PvsSh17p9s2FHP6dyi9qemNviQ9VzPeNnkS0T0RRq8bTvxLFe8r+rjXnz+0 Eg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7mrc59-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfb158706;
        Tue, 17 Aug 2021 15:48:01 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U88Th9z9CUaLW7mAa+0au2Cit5+rEce2tdSR3hxDEwW+YZ+H2yxPfHsI7d8klMrtrwhybWtPtRybcCgw8KfCrsWtvglPT0XLiYpPYxM/AtnZnQL7F0JJS7Q0YX5tiJCWTs7wtkfqWFoHOK/9g4apZkQw5aQ1WsdYTm2dakvJpugN15haUtqAQcLujpYCLsfrZi9R2K2Fhl78EEFQsjX9roiXQTiKqLRfM9hSYgSVCNengdFqRCQVUKw1K8Acr4SuXDIdUCjiHo+NmFJiEqKHo/dtMbspqzZzlvk4kCrLb/9GjJuuzcsbNTdo9bx4iIM5gtd9aj7PWbRbZJFxTyVsZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5m8ICqbT8QcbPDkU7CycSDuiGQ7WEx/MzrPgjELuw0=;
 b=UiY3hEBEOKzKMM2jw2HrQQWVPryxvez60FxJscFCaKPbKHShrev9yx7fBFWN+Frtjv3WfGLDOrTBykoC9pNN7IL1xSs/d5caYxKjnYbOhN+H1jK30AQBZ4oquW7JrhtZH0Ids8o3s9UjsicsBQZcDZ63xQm/9Xt8g/dC9TUL/H/3jxIxNAWsVityJsbM8KX0GT09Rv+OPnlj2fRPj2tYR/cpjdVnoJHWxv+e+b+r7v2avlQWoc7Rup0BON+ZgcTaiBRVMbFVb+GxzSyiBGbnOP5lHC3PY1guoGxgHekDnsomXG139yDxEdV7CyouTdWPHPVCHaHpHfU2xlYKQzsUJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C5m8ICqbT8QcbPDkU7CycSDuiGQ7WEx/MzrPgjELuw0=;
 b=NVzkF0rc9zVdRAjfuAuuibHbSJvfmh2LqwrcrNMzHHxmt6th+8R3btsYH/GRwgXGbEgJNQRl/N3J2HX91vCrugjRdtM5TLawRqOS1nhGa2DwqKIhflqen6hmvKQd0Q8AvxZO72EPTpPwbTax7EPywVBzxltpZ5L4/k1ZKRsfAKc=
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
Subject: [PATCH v2 46/61] bpf: Remove VMA linked list
Thread-Topic: [PATCH v2 46/61] bpf: Remove VMA linked list
Thread-Index: AQHXk38vD1aWz6euekW9ZmI0SwjGGg==
Date:   Tue, 17 Aug 2021 15:47:30 +0000
Message-ID: <20210817154651.1570984-47-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c2abe983-f10f-4cfe-9802-08d9619661a1
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580A775AF1042A82EAAAD7AFDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: I7/QWk4Ii8n+I+gN4tusdGqoCi8WZ8jPhu14lQrLLb2fDIlHb12O3/t98HxUM4OSPkUDj3tYxCB5Wb9tc5nHjM6SVayfoyuASXyY62IJCW1nXrSwu5b1lwXdCyeTGCBk7wf8csTS6/8yypAzZhjgCq7Swwc3OcAno7qpA724DP+RewvwbuUonJno1Wcpm9TyBEPzOF90w/3cMSa0nzdHsJP8oHaMtpekjNAycjVrOmdk4zI+PMEDR4S0rSs6LLExkH50PYlLV5hpW7ATJeBDuvA1tz6FH8MALEfsVtjiptffcgWq8a4qhuLSepzTe3C7I4WLQbhy866M5VEKmuG7e14i7fxG7DM1WrbSOFBSl8bKssYzx1HesLmDQJKbclq75Axdyyh6S8GC6PFoTJ7t7LQTm/5eu4uedyi2GzSQF4vBnCYrkDciKrcxyaDTYbsvJCKNbQY8+586L//miVV4CPwOIOX2S9S6L5mG0aeP7TCvJ2cv8M2zTygif5sRHabi1JW5nRhpcIvNJfuQJZ5cAsM+2A49l55jtUljX+8Ha0VjU1u8dnEMdE7sbNVA0Dkr6sckljKV3T4nooysT75opxP9ru4e+QgbmeXUSHorDWAZRUQ3j4ABm/Nm/exzPwf1ttwZykiD5Ztr+4OCwQQMeww+Py9thy0bH8frEN4ZRD2DNaU7b7HRhVdi1wpqpUVIpHQDbC3+I3GdVBRYxmUZYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?0G9SglM/0pm7Hp2EK5/UKdxR4Nf34eT/Lzi2Q5T8w9jHDkIbZUFYL46bd4?=
 =?iso-8859-1?Q?x0FtWznGKCzHQu1tKko85F/V559dVlAlGFJs8TnUwc+4A3pEyRF6UPeitF?=
 =?iso-8859-1?Q?A2Ffh6VYyZn3ElGxedzqUDXU//zwMBhlMap8QhmMxVR00iEH2weV7spv3f?=
 =?iso-8859-1?Q?eVpKORgLfe16DNyXqO9U6qIWT4P9rdfEssnicQvHOqFpSMm+pWUlPSAR0/?=
 =?iso-8859-1?Q?dIO84bz8baTBy94AcUvgblTrDgg1USrfoq93q2rP3IqVDlL3+eMQDg2nJK?=
 =?iso-8859-1?Q?/Jb303/Nrf/tAfeJn8DSEt3ZaQKp7yvFMHOZhORymB2oTW2aLbK3Uoyy/R?=
 =?iso-8859-1?Q?I7m6gUIhQRox0z9BAhJtPWT7JozlxgC0wVnDIs4Bd70pWpANrrASNQCTgQ?=
 =?iso-8859-1?Q?bTpJbVU3JRW1X7v5PHlNt9V114QUVAIibYIulQ8pa8ceWxnB4NfOry6gnR?=
 =?iso-8859-1?Q?ggY+x2COoEMmLs2yYS2oTydEDrnpildLwUn/gwFRlYbDNDEfbQHx89d4KZ?=
 =?iso-8859-1?Q?pKEVg3ESGZ23iPNTISZlaxNGD2ztZlTQN21rlrIrXOdPo6T22gai56gX+K?=
 =?iso-8859-1?Q?0uRc2Q34dZ2f5CMfULQv2JmRM4CJa3qtuVn0isZZ18KhtV6ejQUoUjoVPk?=
 =?iso-8859-1?Q?774b5MBInWMw+QgXCyxkRy1kLDkIWLzMX/N7AAdYx9QHUB/0Wtaq/kEPmj?=
 =?iso-8859-1?Q?8OUxi/6STajMpWwWLgbAYO87p9cpv26z306sNTNzyXIo75iBxTBC5ABWFU?=
 =?iso-8859-1?Q?0D4uStDRpOZ+gHCcvbOwX+h4nJ5ICjWZ+1pMnTtEEKmeJOBP9JEumh+ag/?=
 =?iso-8859-1?Q?uuuQ3hIDXigo/2mcTHWPFtLeYcrJH4uOFyjdzLZ+uW9+j0ZvreAAFvkCD6?=
 =?iso-8859-1?Q?uzJKXQbJ0i0lyVXZg/7QSMXW+sH6HS/IINioqiQR+tiKpNCF4E1XeQt2ij?=
 =?iso-8859-1?Q?dCHk7XkuOTV6wuC0QHZ+wf7n9R926dTU+M2Rvgz3PaKLdZt13Xiix+AILH?=
 =?iso-8859-1?Q?PKPpxEO3p0anf+FC61VhKRYvRBHwzuE6kDbKQBUVJDgjVm89v2BHlR3IQF?=
 =?iso-8859-1?Q?OQaoAUJ8pvyc5v9JhJwyvpaVMssmxIhQkTKzhv3X2psBRu3XqIQDwiazU/?=
 =?iso-8859-1?Q?XlYJ6kJwGRKxxEbnv2t5rBsiaKlpjhCv+DoAvhD+gw7ezwD3cFTvodWGEw?=
 =?iso-8859-1?Q?mdOw69g9OsvLhOskbn6rcf5lCWh2guRc7x3J0QUMoNGH0YQJ/HO5ROoIkB?=
 =?iso-8859-1?Q?vGw4iJNWq4DvDB+3137hCojoDW0tUQufDCCAYBIa4isR1v8FcJSbkpn3vK?=
 =?iso-8859-1?Q?9iLvvXenG8l6RDXoXlBboQTLB9tm7jZd5XbSuW8tXRHDZbJHDSPaTNX8Tl?=
 =?iso-8859-1?Q?oaDV4LO25b?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2abe983-f10f-4cfe-9802-08d9619661a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:30.2465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4YdyLNzRKNCWrqaf5lGFEBtGlt4uFp3KCpip1dcyJa+KY9qweuxKttN3m3Mnm0joZzKhZzQxZXnrdjZ3NOvtyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: MBlb3vETBdHpC82guW83qfdTXUR5djG4
X-Proofpoint-GUID: MBlb3vETBdHpC82guW83qfdTXUR5djG4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_next() and remove reference to the start of the linked list

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/bpf/task_iter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/task_iter.c b/kernel/bpf/task_iter.c
index b68cb5d6d6eb..c1c71adc7c1a 100644
--- a/kernel/bpf/task_iter.c
+++ b/kernel/bpf/task_iter.c
@@ -400,10 +400,10 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_in=
fo *info)
=20
 	switch (op) {
 	case task_vma_iter_first_vma:
-		curr_vma =3D curr_task->mm->mmap;
+		curr_vma =3D find_vma(curr_task->mm, 0);
 		break;
 	case task_vma_iter_next_vma:
-		curr_vma =3D curr_vma->vm_next;
+		curr_vma =3D vma_next(curr_vma->vm_mm, curr_vma);
 		break;
 	case task_vma_iter_find_vma:
 		/* We dropped mmap_lock so it is necessary to use find_vma
@@ -417,7 +417,7 @@ task_vma_seq_get_next(struct bpf_iter_seq_task_vma_info=
 *info)
 		if (curr_vma &&
 		    curr_vma->vm_start =3D=3D info->prev_vm_start &&
 		    curr_vma->vm_end =3D=3D info->prev_vm_end)
-			curr_vma =3D curr_vma->vm_next;
+			curr_vma =3D vma_next(curr_vma->vm_mm, curr_vma);
 		break;
 	}
 	if (!curr_vma) {
--=20
2.30.2
