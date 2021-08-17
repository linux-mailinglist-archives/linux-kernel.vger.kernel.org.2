Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB7443EEF70
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240384AbhHQPtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:49:17 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:12248 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240186AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkEMJ023526;
        Tue, 17 Aug 2021 15:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=pcAcV8IiSD3IAcN0hV/HENrZiwHnWgMKuPreLm1GNo8=;
 b=lIS+WvZ3uvat0B49Tri/TemmPkgG2p+zDCjLH7d6eAgL8Gjo3jg6woZCyWWwv2rfUusN
 Y6VwBIpQFO5B/J3g4m1zE8Ngl/CZIQTAvDaTD/kXEYxPSziV0CBH9Cc4m8beMloztQD1
 PPHvJJoYlof8dxmyIjHgnLH/m3uH82vQbBqnXu7BDuEl/eoUDx8E46SjvfHdWzgB7pIR
 TEvwJk9BwBG8bFpj5yDLzOkTVuOkhklw3ULXyUajoaGT7adxSCK6PqXdNv7x3CxidInG
 drty4B1FuGRKqg+AWkqzD/6xsKV4MOHaEFKkeDOvAJHotlo79s7VqChekoz+43anWMZa Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=pcAcV8IiSD3IAcN0hV/HENrZiwHnWgMKuPreLm1GNo8=;
 b=PwunVpbacKUYgAmMH+DiPce9XLc6nq/FwuLA750r2jkBW1K6cUyCLMJyTV/7cCMXTKF1
 E6G9dT5K4LXzAiJreuxtlow5Gn9Nu1ILqLsWx60lijA/E6kOPGoZ6UcmvQEhb+WjayNX
 IIg6BBsLnRmkTtA0a7ED9PeY9xRVSU+K2F3bSt5aHvGTxi/1/v7gClWK8O9uFIm0Gc/6
 m/DRLa+2yOLD43hyWGzTAxlY4BpW46UbF4ICNinUuVcUHn8fHgt8o5wUrtPmwTJ7sk+v
 XGdPjqr0eyXWWMcyfrvsNNaAGnJGYSOcGtC/62VmIE5Jvu/ZlkZsAF7uUQo2ctYkBvU5 9w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afdbd4kc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:17 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf3158706;
        Tue, 17 Aug 2021 15:47:16 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PLk1rJjC2kN3Z6iuZt+DhYMRhq8dakYXTeEghuH/1SRAJB4uKL654Y6ZnnUp47QXn9oGQ7ocjaaU9z3MnTNI42iWbdNxw/l/1awXeLLyE6T/4to9qjD2iKbvPpgxo2/mKuE0KSG3w1J8fC2ud3Gt4WBPjqQ/gvbOelUvOruWypr7DKy/4Hy3+OQaSIe84c8ZxkCr63RPHSKgdjNVDyLKk06ImHhsKbiWKGO7HnIs6fM4APUMeMCx3YKfoyqlMyR1v/D+c6LJPjeGGFi7NCY8S3jsI/BjsPaPDkEhXCoQw/NvQll6bB+IzNQvUAoNFmSnZ6/nM7rDhhf86lMMTrA7qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcAcV8IiSD3IAcN0hV/HENrZiwHnWgMKuPreLm1GNo8=;
 b=BQy2eulpmMemAklOvLUH5SEM4QZrWJN1RuwDUspF8M1m4VJcD6v9vTuAc3eowBA/8jhGE2sw0Gm0mv0ZaGadmWa4ngCc4YurSeQjEI8lfiE7CA9utIsVcsvgOU0vBcEt/DuD3O49FFgS8tQt7J8Qlme3hbVfa4qW6X2VKY2yERqD1mszBe20tqrpZIsIuKrLGkUNwPw+ddQA4ilhyGJXcFW8YllseYVtTfjLaU3fwruo+jn3p8hKSI85kvRZl/v6feklZk/pSzAMRbDbcZaYTKEoZJV8fzhPPecaEw8Z7s4ugQpAFR5alQLe3WLniEfsw4rq9WO80dHLG6FIPOZFlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pcAcV8IiSD3IAcN0hV/HENrZiwHnWgMKuPreLm1GNo8=;
 b=jUY9TMlI0ckQwZNSs3eW/AlH4t7I8CBs7MX014VyZ84eGtQQMtUVOPEubN0rpLnSqH38e63lbkhbH4Ckoe/1qrUWO2S71VTwdQzKSXPlR8yPh/f07rh1LZEc0KQLZFVMEtO8b/tFUer9vpFqQOAYnkN9W0vfX91DUwiRRBP+VQc=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:13 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:13 +0000
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
Subject: [PATCH v2 14/61] mm/khugepaged: Optimize collapse_pte_mapped_thp() by
 using vma_lookup()
Thread-Topic: [PATCH v2 14/61] mm/khugepaged: Optimize
 collapse_pte_mapped_thp() by using vma_lookup()
Thread-Index: AQHXk38l+MQvwNmmjkS0SQCoj4k0aw==
Date:   Tue, 17 Aug 2021 15:47:13 +0000
Message-ID: <20210817154651.1570984-15-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 6d1e7407-86fa-43d0-411c-08d961964816
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423620086849B9346FC46C4FFDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ow9MoQ9E8USrF97cA5Ttxh4Nf6xLlGfn+Sc4MJvxcEu+LiCode6Zhp9qgQf5BvPqMiDcpAQ9IOG6Um8jBRuJOQcPhZA+LotgZHxoUHfqSJZI3bGz77H0IPGZpselY12VGr05Zy4LDxFRd3MC+OmSwm959iT2D2JIOEEeSUJ0yjXZd348LJo8BZy/vqjyHqki0jNaBwN2QxAm5GoNQpLseILfR0dgmSDfRn9cUJEA+2kSKMYvDwbXJNO9WaLLtuuDp1mrzxmJF8e7jsLztYjuTnAOVabtoryX0wKh8iqk9OSP+ZzhrNto/TKtpBU4GAXGSwYDVcq8zLHpBwg5BSJye4j3gYUUxbJpGrjB4Yo0u4ouzq/Lks5reJV1ICF/dHr1rwho/KqDhQ8F4hDSzAriM3f+PO3aIWUBsPnWzjqd/iKNQE2ULueprv38ZZRbh6/dyyB6fROevh8TD4JO8o9hCkD0tgk6zkq9I7fUpL8CrJ5mOQ5Bfkm0z4KmTBscrQ0W/iXMRQ2Jb8j/3VY7MlWJtrsToipe86Q+dv8JTWoZWSDGG0vvwQtdTfZ0ynstMmJB8rEkMGx8cmmBax5NZ0e1eQDYMTxYBuDJPEiH4DwnrQfetPbBcKqEiicjYKOhabnQsD+TkhzdWMDd4hd1VpwkDaUVQ1Zn9amhJoWZCOp85quFsJmrIAWOAhKte0FeTKJendTnlCjV+pdML0iDnBGjmA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(4744005)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?y2b+oaVEPrXe/khHPj2cd5PCkMT7Tjcp2qJdavfChMMJbzk2ZdmiqI+ODH?=
 =?iso-8859-1?Q?GqnkwRt7zDm1s9v+EjF3ocUZIFjla66ee0V4qPKK0hyoatkwdkYGTPSJaE?=
 =?iso-8859-1?Q?3btypKuWaDggOsNZKbBTkkJWvzX1VOnIyT9YHYyp/vlvBwE0azjOgJ+jO6?=
 =?iso-8859-1?Q?VMPd3DJ4JOp6moR/kGCjU9Itfzq7X8A36DBLuArIZV9PI/W9Y+IRieCGRZ?=
 =?iso-8859-1?Q?yUZSK29FwhMY0Ir/aA2cnNT96wApn5DTV6+8z2Z5i3/ec5hhqCcuCOzmG5?=
 =?iso-8859-1?Q?w9Xf11WUo7Vrl+TwUd7X0AeX2I+tX/MDWgzZqwFl3WXofb8vPaWtmiQd0H?=
 =?iso-8859-1?Q?K29+7cJ+smn2Ka/yPv9FoBLetAKdp8Cdtkw3XeHWJB+dyuB7sBnFYQy4yx?=
 =?iso-8859-1?Q?vz9N4Tl5zSwwDKNp3ve0Y0LCzGNUKB/uoZDHt1ILCzx1sEHuzTE+33aZ5y?=
 =?iso-8859-1?Q?CJCcd/KJbv4hvseW/mZNHbOwcYI0QuJk4Sz3/YtreBsHao5tQrhlZEdg2Z?=
 =?iso-8859-1?Q?fQDjNaKAXDv2XcHV6wBQCn+gHdTixEkqM1FEh9BQN7cikAzFupmvN7wrlF?=
 =?iso-8859-1?Q?IwuuLT3WpSbAl3qrzTRvqkKkq8WZIt0iNMYaNmpLJrMA9p9FJXzka15VTp?=
 =?iso-8859-1?Q?S+LBlx6pz9wctlnE+aYAF3gQ1iWjfHwgZ6erb6jGFGXv9wJfjmEcdb0G5N?=
 =?iso-8859-1?Q?H8rsG/z7PDKg9fxspj6KhY4OzWKe+5WlOK3J9V5iiLlE/BOzmY86hxmnSZ?=
 =?iso-8859-1?Q?o99LVa7eG8JNGEV7/ufkRvtUL6bT3U1RwcV9z+JSRmbgzCMYUWn6Kk1iIM?=
 =?iso-8859-1?Q?cSk4+LEuqrZNsfbRx5WrNCo9Y/LTwvdRQH/S6JnFW0r8row6Ieiqn2SUDa?=
 =?iso-8859-1?Q?ltLh/P7V8xTesj0f0GratBz8AynPSHc63vssOFb+WD/lWpgoTHStZqbprj?=
 =?iso-8859-1?Q?QFI7S6IC4g0/cPWRapkGU2aEpBpst/SY2UYRMENRwugtP89YNBFuK2fClM?=
 =?iso-8859-1?Q?QjZbxNx9pdjIxqccRFuchPUbw4rgbkWqFfY/isK+KlBv/zSvj6f6/KQjJq?=
 =?iso-8859-1?Q?cKzLh68EHgJGx/CA44vppC4NlaJzlzhT1pml4baiAg46fhJ59WlBXRvsSE?=
 =?iso-8859-1?Q?9GUBUFaUcufIAaYcdcGX4IziDV7wImRxSi3AKdebSaWcBSuJyjToPxmell?=
 =?iso-8859-1?Q?XmuzsWpUuXFidcxsSpDb7Kz7bAa758ek7/o9HfTjZdtmXGPp4fcgRkEoF8?=
 =?iso-8859-1?Q?Eve+Cz7v0g7FVTbPcricTLkoiwC2x1HBJl/QYb06R6CtvVbXlX2tCJ89mQ?=
 =?iso-8859-1?Q?z2URLvRO/Rcw56FTT9DtbER/S9uVSrCG8S6takZPSe1p4mguxx+7g4YZLw?=
 =?iso-8859-1?Q?wKYate094z?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d1e7407-86fa-43d0-411c-08d961964816
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:13.0638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UOVpoEjLmlHleWKpsft3PH+zDVirjzeTnRIe8FRr3k/iZVtJAO1H/T/TlDBpRQD8wQIPu4f3ec5zUMvu8QR9sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: QuQnFrvZNMGRdER5vuPDPMRArCxUrCCA
X-Proofpoint-GUID: QuQnFrvZNMGRdER5vuPDPMRArCxUrCCA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() will walk the vma tree once and not continue to look for
the next vma.  Since the exact vma is checked below, this is a more
optimal way of searching.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/khugepaged.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 6b9c98ddcd09..3a43610141bb 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1430,7 +1430,7 @@ static int khugepaged_add_pte_mapped_thp(struct mm_st=
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
