Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D904421C12
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 03:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbhJEBga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 21:36:30 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:22406 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231222AbhJEBeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 21:34:08 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 195188NI019448;
        Tue, 5 Oct 2021 01:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=OxZsd7TEuSAwMOXADvT9Jj4X4nJwBfi8hSMMe+HIEHE=;
 b=FilWOzh7kApcHhelpRdSQxhiVOHEgMxMNoz0QXQoVUPwuoNem3dGW7gmwkdhWP9bE8Ey
 MsH7b8iY7Jnb1U8cMGy56vS4lnsnbIlQNBCukRnY8cFfSIkqrQZxUIuuQXcPoSpSV+Cq
 d+EUQK9TCA54taflWCnpfDN6uJaeSGQzIuZuKkrjPhNIBSMryXRTB24k4ydYUP6wxMbl
 GjNz0Uvgdu2EAfBIp1RTcKJQ917NGrT97GD3wYZy1Ad2TrD43IuBulHyJ5QAnO2RBcBD
 CbCc+e7mIvDpW6KpKsehSsqSn22fQBJeu+OeDx5h/2RHCp/Vwrq3KoVgjNzVy32qZmpz sw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bg3p5c9ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:01 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1951UIEd178435;
        Tue, 5 Oct 2021 01:32:00 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        by aserp3020.oracle.com with ESMTP id 3bev8w03ud-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 05 Oct 2021 01:32:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSrieonyj6AS0oneS7SzmMd72xMdm7PLDq3i+6aO5ewSh7o3nuLBSQkindkYAu96ht4GL3vLRPtcyGo6ksPjBTSStekC3+qLCRcrUdefQOufLc1WqeJzlCSMYMxonno/lhgZlxt2dyLIbJO4PNBTSBGqqO1zidFQRHCWuUOIshxFZbRf2aOUHTXoR8yqj3cMTz5EuaFI6Z7/EO6vKlJOnxP8ZMeQB4Kfime5NPypZ39J32O6sy1t1xcFgzPavWSvso5SGoE6WevqQ474zJJuQV5/ZwL0DBcXe2YsY7IQsJnIPYQO64Z1WjpuwDvtYUp8wfXwpYiARM0wLf7VLGRPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxZsd7TEuSAwMOXADvT9Jj4X4nJwBfi8hSMMe+HIEHE=;
 b=VD4g3gXebHteS0nnt+m883wvH4spu7fMnN5Jdg72s5zAwcGJmlqL61HOOja8sOGYRpke3CMYvYZnngAOx8w59dP3OZCoA/9NO5AFuB2ZD8bsVs3pHuvLlRpeFPV721ktExshDFM7BlB6nl8XKNLqzRaZIj4ikL7fyCTRZN1w7BhKkQvZDCMpaTA2xoH9yvbScQ9QZIR2R6Y01dYq+D/pF3D2sdmjJWjf37+I0q3NX+fEvm2n2PUoabVyblsrfw9zy3UBGHmGuLMEqsMFp8VqoBVXTmGu3euT1W5Aw/p+oeaoA9dzNYyNo9qzjg+Ox8kHAsYcBsQWq3btG1tH8ncczA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxZsd7TEuSAwMOXADvT9Jj4X4nJwBfi8hSMMe+HIEHE=;
 b=TD7g55MdzhucxCF8JUsNa3drNY/3xARJjJTp4hFfcYKCcl+kZOM9M6cRtJbrmvapLG3uC41G5gJtoPD60QU91Y4RRmsdGIZLkiYHMAr8OxMLjGWcCU/TVkEuK7QtTdgtS033QoEdcrMKqnEF1Arshuh5V78seYNsyl7mQYcxAPs=
Received: from BL0PR10MB3011.namprd10.prod.outlook.com (2603:10b6:208:7e::29)
 by MN2PR10MB4288.namprd10.prod.outlook.com (2603:10b6:208:1dc::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17; Tue, 5 Oct
 2021 01:31:57 +0000
Received: from BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a]) by BL0PR10MB3011.namprd10.prod.outlook.com
 ([fe80::6d61:54c2:40f0:93a%5]) with mapi id 15.20.4566.017; Tue, 5 Oct 2021
 01:31:57 +0000
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
Subject: [PATCH v3 61/66] damon: Change vma iterator to mas_for_each
Thread-Topic: [PATCH v3 61/66] damon: Change vma iterator to mas_for_each
Thread-Index: AQHXuYivNyTM3gULU0eqMNPjowhAag==
Date:   Tue, 5 Oct 2021 01:31:13 +0000
Message-ID: <20211005012959.1110504-62-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 58ee9ad4-bb79-47a6-ae3a-08d9879febd2
x-ms-traffictypediagnostic: MN2PR10MB4288:
x-microsoft-antispam-prvs: <MN2PR10MB42888F49EAA94DA8C54CA35EFDAF9@MN2PR10MB4288.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1468;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t8MrSNVEenBaH/Wjfal5FpEDMj4gUVev2+uAIf5rMwvgp4TN9uOD1ykv90CpDGGb4NnM8qU0uRkS7wpb+1JJkBfy5iLeXwkPXWFiEtA6SFQU+3/zLCMkLPGLgoJ1vJVkkgcwKjQuGI9oaRtMwtop5+1q7ZuYs7pTch62GIzyFrMMp4yW+w6iG5LP/PFsKILQYSxSBv4+XMcfTt2zD5ZpuQA/5wM43fQ2+r4uH6+TyJWqQW2uKYzy+EdZUdkxe5LzDjW6uOkh3aKImGdlBoJTxrIJaK013p66qNWuYUZpHwhyW8MxQ7KRQRmOVye+lNg40Shw6uW3cI2s0XUcH+NKR+XFJapQv8ERo5E7ZM+MfgpPRSMLAPKKeB8FXuyQqOO37xogg9xE1oj8DoDV2jYLZ3h8x5GRuk68u219AAKK+CaL8UrFtmCldvBmEkpu9kWxt0zdGNo5kmJL4WiiPhonX7rm0Pn7OmO5gVEp51Yb8a0c2Gv13jOdLxM6yshvghRaCAM/xYZbYjZs1sbRWKJdtFjoSh74V5NAsqVCnCFyvm94U/VLv3bKDzxdwwzdOf9rRKdcxS96eaDDcexAH8YgbW93evEJ6MQLkFGDvFRRwK0YYdFdVUhq0cuptjcnefpA8i5dEZ+9mB/tsp9N31EoaYkjlvPaOu5+MiCcQ1l63xxxfM5/By4f5onHJ0Z+7x9C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR10MB3011.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8676002)(38070700005)(71200400001)(8936002)(76116006)(6506007)(1076003)(122000001)(316002)(2616005)(44832011)(6512007)(6666004)(6486002)(38100700002)(508600001)(66556008)(66946007)(66446008)(26005)(86362001)(83380400001)(5660300002)(91956017)(110136005)(4326008)(2906002)(66476007)(54906003)(4744005)(36756003)(7416002)(64756008)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?oIQa/6M9lNq5MBes1EYSv0+0VCxDR2F9nAyXFeC1fR2KFDeAiy4c/O6ptC?=
 =?iso-8859-1?Q?WtNqzhb3gG+L4AU1Zqn2WnyfQz0t/UAaUjOFFRGt/EQ4uUMiHIuLEg/2Fm?=
 =?iso-8859-1?Q?Xznwx2BkYt25QvRBsQ6yBmEdtKynLaG1fENAn+HkuPetZBV0R0zE7ZNcdg?=
 =?iso-8859-1?Q?UZI6owM+mpdaENzJdKCkOuM5yVifAJ4causqRJGU0P0aaHwX+84jk99Of8?=
 =?iso-8859-1?Q?AmGEmPRm5qLmXe6VLjiE/ebhQd/XhIb4FeXI1U87Vz/nBfi4G/XRZhvvUV?=
 =?iso-8859-1?Q?sjl17LM6OSLSjyvlZWz6l161g1dsFO6v2MSHs5Ga/iyQoVf0ZxYWHSGVDm?=
 =?iso-8859-1?Q?vSFjMadmZeW1uBL4TzbdMVFozuV3S8RKklDdGYOlSaw+SlqfZ364UVwzD2?=
 =?iso-8859-1?Q?OLbZNm31t/qvj4jZJpV3v0qdrvyZB5ErnnkvtDUtvrqqRsyNe7fiqPON0I?=
 =?iso-8859-1?Q?7UP1Wlq8BTBMzE5HnbV8CHnwx+lpwb2TXTB4RzvRM/7qsI2m1FeoaNnpqo?=
 =?iso-8859-1?Q?HznYKlXfzvXOolIyU61YGKL0hTHWsUYWu49UPXcXmuGv6qRRUyEi5/bxQU?=
 =?iso-8859-1?Q?8r73ev6ZRXH8E2coZh68ho3FgpPlD89TyF+qPf1aZsnCtCvTCGwsbv5Cf+?=
 =?iso-8859-1?Q?JgNjJFhT5ChTiQtqWGMvr+ZEdDsIOufz+ZtPQaBOe2lA6BCY5nz8Vxu+HQ?=
 =?iso-8859-1?Q?yRkXkUICqMb/LDt6wg9GqNL3GtruSL1u6ayenjyhaxz9iLNotEmQso8nK4?=
 =?iso-8859-1?Q?0k4nYgx2zrZxOgoDbODcfRkhRuZtm0EC4oPGmzoshnzwUYvC0EEvJlwaSQ?=
 =?iso-8859-1?Q?KVOA088OBn9On55vyZb07yLwsbHlY+HzT7QagCtLhIIoBsYzetNBb8KceK?=
 =?iso-8859-1?Q?jtOLCeo4WfX62HiQxeQ6NUytcC5e9E0dH9+gfVwooAXhx6tLtHL5K/nlj7?=
 =?iso-8859-1?Q?/OxbK2k67AQrG28uJKGGwBhzO1EV2lrdLApcacS7Fbx9QpzDn0Xmz6jVjN?=
 =?iso-8859-1?Q?uBwnDSZUNmReXHl2Gs4VbmNFnoVCrCsKO4QRTClDYpamL5eBdiLKw/LNhc?=
 =?iso-8859-1?Q?gPmnH5RTf97pgoqHPCQj5fRAWJmPog3bQvQvdmzw8u3PeDViw+IC6Fm6le?=
 =?iso-8859-1?Q?Mbc1Y/KlHP3nKe7hv9lpwsbQih2iKhSSU/4zo9AjqlpsZEG3s6n1FRxzLM?=
 =?iso-8859-1?Q?fhaJO1C/A53x0ecn16ivwlHmaOfkEApOaCFdIe6fYn2WdxdLHJQbJ3IrWx?=
 =?iso-8859-1?Q?bFju8p6I4eYuEc2+uxQ37tBFs4AWgtteUulcBBZeMsvinh5NWUW0O7903t?=
 =?iso-8859-1?Q?l0ZAs4+rsXMMGuRLTqPSwiu7UAJhvP+IKIO994UlHeoN0uXxhA0R8UMjqk?=
 =?iso-8859-1?Q?DLjxqm2xFh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR10MB3011.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ee9ad4-bb79-47a6-ae3a-08d9879febd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2021 01:31:13.6028
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9j/HrvWKYnJc1xIAdHBp4IwqIhwvZbOsnulx4kp572d9yY8eY7C37HoEy41iu/BYSnGMl5S+7WOrRHhekimByw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4288
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10127 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 phishscore=0
 spamscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109230001
 definitions=main-2110050007
X-Proofpoint-ORIG-GUID: 8Nh0HYkXcqFeOY_YwtkMVPBrTjX6-g2c
X-Proofpoint-GUID: 8Nh0HYkXcqFeOY_YwtkMVPBrTjX6-g2c
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/damon/vaddr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 58c1fb2aafa9..e3b5b5a7948f 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -132,9 +132,10 @@ static int __damon_va_three_regions(struct vm_area_str=
uct *vma,
 	struct vm_area_struct *last_vma =3D NULL;
 	unsigned long start =3D 0;
 	struct rb_root rbroot;
+	MA_STATE(mas, mm->mm_mt, vma->vm_start, vma->vm_start);
=20
 	/* Find two biggest gaps so that first_gap > second_gap > others */
-	for (; vma; vma =3D vma->vm_next) {
+	mas_for_each(&mas, vma, ULONG_MAX) {
 		if (!last_vma) {
 			start =3D vma->vm_start;
 			goto next;
--=20
2.30.2
