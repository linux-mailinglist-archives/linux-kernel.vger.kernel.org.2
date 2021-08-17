Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A423EEFBC
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbhHQP4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:56:03 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20898 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240317AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjXnv006885;
        Tue, 17 Aug 2021 15:48:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=iMg3B7uuCHKOKtZL5pSMoIkBipoLPiqsUE4VDMZHIM8=;
 b=x6c7iE7tLq+yJwD2b8LTGRAYTUpYiofcZQjEuxd5hwKDeLgSS7IToaPaZOGgP7y7J7RT
 6mjLfg0X09q1STqs71sOypxn3sE6hXb/KOTG87yhr30lCmMjUXMuDEtA9Cy0qSAyXAWc
 X4VDLrtBXKv9hbWjMlW+uaOmcwZRUlN9O2nzLv0Te+5/rZrncmVmGiJ4OiLuLeKmFa0S
 x7fybU4lLOcf4+fsFfOuCJQFuE3z1IdW6XyPW/yFcYLm9BoaXoQcgp6BAjC31kx4amr/
 xSaLzvJgPImBhNjYAMcmFkSaY6+6AA3CXLaZNOrb7iClDM11zprqiPo9tqnAbz3OiGAd Dg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=iMg3B7uuCHKOKtZL5pSMoIkBipoLPiqsUE4VDMZHIM8=;
 b=hyOLqirFXPl/UvKXC0THYa+KFBw3dKQaYqtqLkXKFltJm07BzpZ8ptYUUUO7ZCE3c5+j
 XWQdSPY3gMhghddfcQFQ8jejpsLtGvT7qbzvWU+s5XhAOj0i0gzlI0hPByF4/tWPivan
 YgFM1Lwok8AnorCXnGKedfG9RcCJRh+2kjyjssWMqX7GOQRb1O9pSiQnt56iUJwBgV6r
 aNK/e54uWPlfrQhTLw6+mArnXfeKMdHRCmtPIO3AXa7Mu7VluAUYdxelBJP3vFRA0hO/
 x79MX5qqGy3pVzE8uRsD6jE8T3r4tUVq8u3OPAr1SwJP1azWP67vIL8E3P6QzU/jxw+e bQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9wk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:03 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkt5N094615;
        Tue, 17 Aug 2021 15:48:02 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2103.outbound.protection.outlook.com [104.47.70.103])
        by aserp3030.oracle.com with ESMTP id 3ae3vftea7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:48:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ADXNoosDJgPGuryokUD7oo8F8v3tBo2FRUMlhizegNneStlOYoFv32z2z0NhjY3B6Qx3Px6aOcQX8dVNcDivn/wmy4y8fNAGIWRG8/lm3KkiyR9uEo7HJHf3lWE0en9OMKlQSPO76PdAwQ45aKm7tm8cAuziejTJx6OMY9QDC8I2IMjzLpSOmbL5lSDGOYxqSiJj+HrUFZITUMNeZKrJKOYnN0b06Uk2ab3SYMtyt7PWBmuBaORz6rDNqh4BQQwapO29JUe2VjtfKCSGWBY7SbXTamY4ayIpk4uMrOrPHimbvI6SKzuOUcjdKIe2crCnL/nZ0LeQ1+mhTUjBg3qjLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMg3B7uuCHKOKtZL5pSMoIkBipoLPiqsUE4VDMZHIM8=;
 b=DZWMQDxreUv6B/LI2wl2W2sTHyH1lf8qcPDOWrbD1Wjcbekw2cNgyg5NxhskJffG39bGszJzV028HYlgv3pcmTQOMy07RShRPx5Wq1qsEz7AU70SurfH0J+nBX9wWX3yUDl1ec6lHoeuORnKe7IG3D1uou5dd1OywcQGitQUi/MGu14G3YioaJeBFB1RjDZWd1heEYKYT5DmlOH8Axx9mqyhJ+Q2VFJrk2yFBB7824JBpZRmDjPtMg5DahtlNs3ADtP2NxoZFfm6mo9Me9hwDA77mHdclTec9dUPCEjWxXnCQC+8HX3NRUp3eRgBfC+QgesAI/Nlr+uF4ZtsrOCOTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMg3B7uuCHKOKtZL5pSMoIkBipoLPiqsUE4VDMZHIM8=;
 b=PZE0QiCWj31gvkv3yodBNpe9LZeXyWMsTMfzvHNYRfrlYbNhUTMYSiSqUV6rzfJmuZyx/QuNP1NRZBbPB3V7klO1bPI+RpPWj1u7tGIaeJfMYdnbCbsACslzpkIrPZeAGdv8L3TibuQhUQSnafw+iXa52BOMSdxkqmRv9m1GoFc=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4091.namprd10.prod.outlook.com (2603:10b6:5:155::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.16; Tue, 17 Aug
 2021 15:47:59 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:59 +0000
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
Subject: [PATCH v2 58/61] mm/pagewalk: Use vma_next() instead of vma linked
 list
Thread-Topic: [PATCH v2 58/61] mm/pagewalk: Use vma_next() instead of vma
 linked list
Thread-Index: AQHXk38xPDd9MJnz9UeRQYLjFDtBZA==
Date:   Tue, 17 Aug 2021 15:47:33 +0000
Message-ID: <20210817154651.1570984-59-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: a4a1dc66-e907-4fe5-194b-08d961966384
x-ms-traffictypediagnostic: DM6PR10MB4091:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4091595DA8DE3F93E057695CFDFE9@DM6PR10MB4091.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:346;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zgx6XYqfIJ/Qcpj6MeJE7VtMSAbwvWnk04H5TmUEAtTf35JuFDA29WkSXTFmW0nIzci8ZLYsfi8KJMJWwGUfcM7Peag+Na3xHMT39MrSLlxXFiIzuICkQ4vHtG3PuqUa4U5AaxRyMsxVxXd+HaYP6FDm2G9kW4LQB/LGKeTkDZrbUzSVJcIKBE1SK6Lpxzi+wRJrA0eQhfIjVpWHeL068QCwNLKZN4m1qxrFSXQoQLx4hBntfobK8R/sbt/aYyibScerp4Di9rl/fZayGxMnjQPEvXry9cNzbRSR4M5OXxk4H+PnUDXUYISltmUdEIZAJfIuMEQ1nEqg8gOBR2ArhbghiYvwOQbwwdekGD4hBHqHCe5uvDpVQWwhVimyu9JO9wJXiaiDLVUv6SqoXEpnjTUCzT2hFEgxig1B238f9GUoflxcEmzTYaB3d0zN6iWADA1URC+43aby6xYIGKta4n4AwxygdChd6aeEbcWLl1Xm/Jbx0wxAOOlDoSgUE6CZEicyOChxptXHqKB77kG5g93OqUgPs18q8CzyZGl/KuuzmrtFaLRCyItF9qbnTZPnP4U61WJsYWQVMg8/Ei7JokHgzm5gr6InUyPLibD95s1DVMFb6ouDQj5ER9yNbVH0mHuBIlrGQuPKLMgFlVlpYwEQ7QdxE5080dbUkvTi1kfXwwgf7Mu/YQjAUpcvEPNV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(346002)(376002)(136003)(396003)(38070700005)(6512007)(4744005)(107886003)(4326008)(44832011)(7416002)(66476007)(66556008)(64756008)(66446008)(71200400001)(66946007)(8676002)(1076003)(76116006)(91956017)(8936002)(122000001)(26005)(6666004)(54906003)(186003)(5660300002)(478600001)(6486002)(2616005)(36756003)(110136005)(2906002)(316002)(38100700002)(83380400001)(6506007)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PWlQzKFdUw1Z1U1xHUq0rhT2D/XQMcdeXnsa/g3+m/XLOcp7WLK8hK1LYW?=
 =?iso-8859-1?Q?PJyRuQGoWddW2uFfOJCYp9eVMzwrUO4efUBLPVs9ucUepQvhhTDbgpTIEO?=
 =?iso-8859-1?Q?0UFT8u/N74j9wkCtyh8BxELpGOmP1jORWidej8k5BfHfABe4/ZknvVJcLa?=
 =?iso-8859-1?Q?xgojTasxqjtGGBYwvgwI9Dcs3zIaAg2jsfl4aGbDsXebvKt8dPxgi3SZap?=
 =?iso-8859-1?Q?E0l0rXYXb7q6PMIVPE+sTx8o+TIIk6FvPWTNBr9155nO+SZYG5QWHoC+NG?=
 =?iso-8859-1?Q?E2kKRjmv1zKSpjtXAHNhm6B9HVNuriaH7aMXFsck1tzfMGBsMOtp2M69BS?=
 =?iso-8859-1?Q?ndowk7lxmOXnSAFQFZpcyq7HG7+adJ23hr+iu++aTyHja1ZefJhfRM89Kf?=
 =?iso-8859-1?Q?TLLb9bYhklR6pec+aGqyDce/2Km/xWANNQaHiEJChDpqoX7nd9mFLxpbDZ?=
 =?iso-8859-1?Q?6s3UfTwXBhM5RfDgXKE6enGxwc+FRDfELhFKwjnZPYe5r+o70JQ+fIkrHF?=
 =?iso-8859-1?Q?yYsyN5Ptkh0hUWvalZ97Xhsg8F4W3G4QDMGdlxYJQqbpWDxpOGMjMm1Wcs?=
 =?iso-8859-1?Q?u7/g16trNIJvXIT7s1kiK45lCGYXDYBenmj+PAX4fiachgHdbyf7yUSdvR?=
 =?iso-8859-1?Q?7gT4d8pg0ObTK7h9k3gCy5Zxi5qpj4rDomsbTQWzAsIy6J9T6hNQmwX8fV?=
 =?iso-8859-1?Q?D9QzUTS//Bg2YjoCeHHnFr5bqP0+4m/JTlyNYpdlxmNNjkKYxi+1ojhpVs?=
 =?iso-8859-1?Q?UaK/47XP+G0ortX2HKBKPQYKgjT189pQtq0CFH4YEF3b2JrwGaAWv/kjhG?=
 =?iso-8859-1?Q?TdDGX9i2/ue9z23On3SV5EGi9eQD1EQZI2aPwSaivDT0/9I/rc6a/4DcnA?=
 =?iso-8859-1?Q?S4+V/wGSFs4KiM3c1YfIdmG++2fB5FBIZy3V8x8konwdw+wLQ3XfOcf60l?=
 =?iso-8859-1?Q?wMXllQObEbMhLfYA4gLQvwoI9/9jTTYGr5LatElRAnxTdSBb7HzuFd+yI4?=
 =?iso-8859-1?Q?xWfML/J99mIFXHQBKXR7/cU37/3uuTepAhl+h0aSb+PoIvnKWKcsjgb6uQ?=
 =?iso-8859-1?Q?C2qnk0fTGQXnHbr+xdcxBXwCj39DPiBRVcTEEFhHL6rKLSnzis+cZy3F/N?=
 =?iso-8859-1?Q?JNKxNoEXy+bP4ZIR0KP4fT4JYRsJsU8LCZMeMpI6BF1jHGC2XkOezH5wr7?=
 =?iso-8859-1?Q?o49WUzvcpVY0bNNfQi1sV/enKz0dFS/gh3tXFQpd4sg1xTP9xugXvTzP20?=
 =?iso-8859-1?Q?WZfWXYmycpYTfe9frbxQ2fVWadV/OYpkIyHSZm9IfqSCiV5B0/yRw7fLSZ?=
 =?iso-8859-1?Q?FseMp5ikx4m3ly8Ge53Ji2CGDCDnVEE1Dxhhc2JwI4JrJxpDDrqX0S/kQO?=
 =?iso-8859-1?Q?Z4Tf80oMMg?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4a1dc66-e907-4fe5-194b-08d961966384
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:33.4704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PhefBX8qy7+fYzFjmnmfon4xpsk8zNpmZcdEY3s9oc5TT0+uc22TOuNVYvJ5PI0UmfREzzUOXpWb9KwRAE9vmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4091
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 mlxscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: EevBBZtcAzBG8ZrEpre_5zQsn2KD2fsQ
X-Proofpoint-GUID: EevBBZtcAzBG8ZrEpre_5zQsn2KD2fsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 mm/pagewalk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/pagewalk.c b/mm/pagewalk.c
index 9b3db11a4d1d..d3c65a45fca9 100644
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@ -456,7 +456,7 @@ int walk_page_range(struct mm_struct *mm, unsigned long=
 start,
 		} else { /* inside vma */
 			walk.vma =3D vma;
 			next =3D min(end, vma->vm_end);
-			vma =3D vma->vm_next;
+			vma =3D vma_next(mm, vma);;
=20
 			err =3D walk_page_test(start, next, &walk);
 			if (err > 0) {
--=20
2.30.2
