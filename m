Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 592913EEFB3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240339AbhHQPzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:55:32 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:5342 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240285AbhHQPtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:49:02 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjTpZ006863;
        Tue, 17 Aug 2021 15:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=SzqjF9XuUTyRYmpRqJM+iI0SxnYmWRcrs7F28xHL8GE=;
 b=lEWbUJ/QxPwfM1Z5lglODen06WIh8kK/pQ7Z570Jy9jXqGJ270uHoUrmmKym7GhEofnr
 3hmCMMqKbpnFYgABk2TEADntGP/AG1z48q7tr9yPFB9Ek9J5qkDhYu+Lj/mhQ/LlQtVH
 I38dQzga1vKFc8fkwRrNkludl4xb9C3vQplB1AtsjATLonG2r75tDbu59P6e7t1jzc8P
 Ba9J4bnyqK+qkiS5OPUb4rHKiIjnXP/BjhGHEiBXl/XeLTfuPU2x+f6VEuZBs3HhTpXS
 oEJdPoD5KHtEXKY4D9Qh86sy3UaBkZSuuOHMCHOvRYKwhKNC0pU3XA3ci7bx12s/V3j8 vQ== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SzqjF9XuUTyRYmpRqJM+iI0SxnYmWRcrs7F28xHL8GE=;
 b=ahQTleUy1GmbRTgmGrCnje8uiVi3vVG4IlcbyR0slcF55cC+/qnIRQcvcnU2DB74z7Rq
 QE+1Yjr+qAPBjLw+ljiXYVRp+MxRUV/sYRSFCO/2q+qE+jDwrfCtO4bbGWQFklerCeRV
 5RCFTLcRIRDCOMvDf1Dg9Q+pNTjNBhP5SbLFZ6bHCs+bFziqpldmyXlNlADacPVuoCig
 x0eNSPABMOChyEs2l4UVnEbmOc2Y8TgIeero0nGUki2+CbVO6g5OHv271BnyybF2pyJM
 wbYdad8GXmZwPSQgVZaJq6jqInIGw69EvibqWYH/YbOhQcymV6aShUpTsJ54eN4v2IKg WA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3afgmbc9w8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:57 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmfW158706;
        Tue, 17 Aug 2021 15:47:57 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2172.outbound.protection.outlook.com [104.47.56.172])
        by aserp3020.oracle.com with ESMTP id 3ae5n7sv2h-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ee2DEDrNYTiXXTSfzJ6iMBgBMoeSFeapzhAcB+07D60BgVo1BFtBsbVp/N33D2R4VoL6HlikaMsHEFiuFRp1jgGIrQClUPz6aqGxeEuYpWO+3t+zKgy6DGWXQQ4ojvuV2r2hsCBAj65dt6dJ7pfQeBT/RzVwiP1b9ucXa/h4bjWD+Ip66YGddbtVTKJwJ47/IU+ogteN72QFvTvw8GhWNoy5l70Bk2epdEk0qN3o8eDBnQSJt1V2LPTcvMyGGTd9fHaIHxuAGAXbiDc3eXpacHzl79YM3AgIMPBRLYiLPU7riDfLjHYbpWFCdyXopBegXOoD/2Sd71xykzz68WCcpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzqjF9XuUTyRYmpRqJM+iI0SxnYmWRcrs7F28xHL8GE=;
 b=oLB0n+IezS6GtJAynsAeiVVwhKyVi1nEJKkccJn+M8ALiaDpTDle2xt8v+s/wTNYalqfZQpgqAI0E0j8GUU5zxTDoa90vtmC684/i5xq0UnUfcYUhciz2lJ5h/1huyAJ/rcUc3LEy2TDGn0QW2Z7uVgdl6ediFsI1KPcHnXEX7F6GvK97M38YcKSV0tyYZNr69ZGaEFPnZ2LBxk7LEobpBbyxORu6NH2u6EcOdz76WaZurehvEFVdNY7iH/grR42m55eU/ocJxw+jpQDl/s21mZf3m6hulIlwXbGsxhCWYCJzGg6rVa/DuJ0tR4BQpNAZGAZiEfFLKP2ygWNrul60w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SzqjF9XuUTyRYmpRqJM+iI0SxnYmWRcrs7F28xHL8GE=;
 b=lNRu/AMgfGkhlL8A9Djc4N7RWqVFhVG9iti+4643uL1CmDAwTI+PzGSD1qcOsvmQAefcrCUiWW0KrQws3cJhoHFcnskW6Kf4UzDMf4/2RGh3h9QE896xpJihr+9Om0RXy/mmB1tnv+NF7u8jEi/vOJfH7FurTzx/Z1Tz6vg0HGQ=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3580.namprd10.prod.outlook.com (2603:10b6:5:156::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:54 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:54 +0000
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
Subject: [PATCH v2 40/61] kernel/acct: Use maple tree iterators instead of
 linked list
Thread-Topic: [PATCH v2 40/61] kernel/acct: Use maple tree iterators instead
 of linked list
Thread-Index: AQHXk38uihgrHczfxEyqOy5svIpfig==
Date:   Tue, 17 Aug 2021 15:47:28 +0000
Message-ID: <20210817154651.1570984-41-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 33123e7a-a396-4cc2-e2ba-08d9619660af
x-ms-traffictypediagnostic: DM6PR10MB3580:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB3580E0254CF260ACD75757EFFDFE9@DM6PR10MB3580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xVbBkD5ZECsI2eQGCBVYBmZ64b+4YPU2hZPVAlm9sl+dB9PTGEdjydO2zRfQXZeJncTeTOnN/wqGsnSWk1u4+/+4gSgQRDKAcj30ctLypVleskBwFpPfmDjL9qDvmww8vy+4zioYQanSaRN9JsnpV6uqZfUird9tBfelDbo3IgjNCV76wPiXun3sYQbRiAThbLI/6S5AagJ/SIs72KEWuYNV62qYCH9riLoF7FiQg3uls3/dklUs4kfuqHb68j8dckanCKaaplBDxg+KGezuHVte+Ixbcpxn53tTwVO5VOpQYmxUrGYCBvyvitn8MJxCRtyxG712b8YR829HarzkVSgNE8OZQk4xM6wgnYdo0nhHKxogYklB6NLJJuIlOsbTZbMn4EErOPjgiyo1MawmvxhA99VVgYF7OLT7imprx5Nt2KLg2Go3G4ebHh9gcbqqCFvriM0LLpTTc+MtHULJtA8Z21ayuSxoFRCrRjSGiQ9yP8DaPbEi218cr6rwIDU2bgC1V7A3Q4caM8fgfosozHbgyKn3GMn/MMc4jTu61HNBdpez9cR1GaYdLedWeXTUqDrcPMKpTw3XO9xIu8T5B8B0JhqGGoezpTCbwTJpoy/PTxm8ADALflvEJxKq/llW39rqucpZSPUIvi8unAO6Dn8EZP05X9uvvKCZU1z7BoEgwlYd4h4QAvVszhN7UnAAKDD0yVey/JpG01xyipAkAw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(39860400002)(366004)(136003)(396003)(38070700005)(6506007)(6512007)(2906002)(83380400001)(4326008)(5660300002)(71200400001)(6666004)(44832011)(8936002)(64756008)(66556008)(66476007)(76116006)(478600001)(66446008)(2616005)(66946007)(91956017)(36756003)(4744005)(6486002)(1076003)(7416002)(107886003)(186003)(38100700002)(26005)(122000001)(316002)(54906003)(110136005)(8676002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?LOSTEUHfckL7OJZsWhenUVMg2QDodGadp6p8Xbn4OwdQDhYo3Wo9def/Hq?=
 =?iso-8859-1?Q?FbbEylfUcF0WFjRuhLGw9thj5ohVd9ExsMRRs1jMg8N+TwSTFEyNBhBanY?=
 =?iso-8859-1?Q?3guBH7ths5fAk06DEfYm3yFwgEqRWNO5w/QGV2+6Own+J0I7dlx+Ln10OU?=
 =?iso-8859-1?Q?4mdT0Y2pPoyA2Npu3zNX6fGRPDdvd2VGhossICggB/jceUn+8R8kdUCGEL?=
 =?iso-8859-1?Q?hOARGb3uFszz1ZWy4S1oBZ3xgO+5b2+EhUBFHKL4KBqT8JbGLHHh21lWJ2?=
 =?iso-8859-1?Q?9Qt2MhZxrAikzr+hu+dUMfeNZEINYIfcJJUl6G6mZ676ILwfDXubzCFLFJ?=
 =?iso-8859-1?Q?8T2Bw94LqZieGlOQxxNuDhuZrUCqpG1ZJUOtPLXxVfanLypUOiFOeU8hq3?=
 =?iso-8859-1?Q?aoDn0KuRbP//t5+LgV6TqQdS2hNrQ1GroJEDv37Ij6S5TjidAJxdeCFJJj?=
 =?iso-8859-1?Q?PY6ymPT1hNJkQjcsBRDiqHIh3tjbT5y0Uzal49oOyJsgMa6eREp+Bvm/2L?=
 =?iso-8859-1?Q?YZa70i21Aq3+uwhWLEl1ZL0VVEsiTZjefpHaxSfgxkZT4akbjxh1mONchI?=
 =?iso-8859-1?Q?u3z+Pi4U/aqrE0S0VVzEt/RqeKiNDPqrIkFnLZhRxdjc9F7lPC57CmFCyc?=
 =?iso-8859-1?Q?Dn+3NO2IDhhl4UzMGKl8O1DofN751InHsy0IvgBYQStwdAOxtjRHI/86g2?=
 =?iso-8859-1?Q?GU0QGxjfLwyZzJRcHj2IOcCjRmFUpyNmrtzU+zaomv9CsbnqDOnijCf6lM?=
 =?iso-8859-1?Q?7hodScctm48WwCDUWrfIZ5yngzG1B62UM0cJNYTWNKYAkkzmDw1SKPcKTD?=
 =?iso-8859-1?Q?CxMcsg796eVET4fp5GGVDWWN3PH19UmLGxjZ20QfU/k6bkVFPkdTdxQIX9?=
 =?iso-8859-1?Q?yw73sSDgT+PSCQcat/8CD7YaoOJj/U51irJdWxg479Tql1CQUFemUoE1ML?=
 =?iso-8859-1?Q?jxd/1l4TsCtpmZoYXyhJfUQJShaEacpmeRJHiFwaEQl3viQKG69vvS0zIg?=
 =?iso-8859-1?Q?0HoZJjFe9JUAMFQrF6Gy23urLymtxDI5R+YHwgBuw7AIe4GBSZI/390v2H?=
 =?iso-8859-1?Q?T4fwox6N2rWHELvyDc93DAdhqr1bdsyz45MkDEPu46A8TLg+vCw5mm0/9v?=
 =?iso-8859-1?Q?E6/yY4LAUWjFQ+iNBb5I79E6giNnIF+JeUKyNfIp0xECcaKIXgxShKEDQz?=
 =?iso-8859-1?Q?atSjalk/6L2SeJq3n2TQ7fk5ZJuZ50xqlj+1kr1vcepXHc3ba7qVFZaqCk?=
 =?iso-8859-1?Q?IKjjK7bIAEM8I7ueslzaufMnQJx+xTz0aD8jj/qd9/9Qe8T28vhfrPUNy4?=
 =?iso-8859-1?Q?jv2j16o+yL4HwqfJP+7tnvFUMskmpJNZPo4DKI/ApKAuai4cvvf6co3ZUk?=
 =?iso-8859-1?Q?aMTrqA9DHA?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33123e7a-a396-4cc2-e2ba-08d9619660af
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:28.4385
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD89KR1UWqUDH4D2PozescZ8Q3WeqtTgbTtNomLrCRBFKF0Ax5JQ3RlXEfpFzYSOXrUQvvjyN8PqGrruEjfVCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-ORIG-GUID: yNJRgfg-QQvGAUoQgIjbLE962SzK3K2u
X-Proofpoint-GUID: yNJRgfg-QQvGAUoQgIjbLE962SzK3K2u
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
