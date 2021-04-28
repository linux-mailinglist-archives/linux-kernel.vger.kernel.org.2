Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0195D36DC10
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Apr 2021 17:41:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240063AbhD1Plr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 11:41:47 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:44012 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240612AbhD1Pic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 11:38:32 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13SFNiXT032601;
        Wed, 28 Apr 2021 15:37:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=ROweTUnfvt7pDCe6CEGVDYAJeVJ78rD1b3V+lwXd0p0=;
 b=VnTWbcAIlqLtSa8sMXI8Qfg95IP92DBnO804wyYWFg8t7G2q0nLjJ441ImDDpZxDGlJG
 /sx6I/whon8BfFqnl4LeH3fJGtt3Ad7syqqdw4SoHxMuscxHJD1aR9oLdvFQNDX400U5
 8Ux20QfqjZfcqQrfCOTFDhirAv8w1BzNasA+zUCLdRvIKs0KqJgrq6PGnVHLbDM1KV+F
 hitrHqJAGjXSSkfR6Xrg6mg6ydaHD6OCd1IKhMVYT0uLoMReDFf9b2YhmFjzqdIfstzu
 dz2YajQzwpohuTZ0ITMNh1OqFEvKEQScO/xvveprD6RTGr+h5e2KjglagI0Jg0jvLmd5 Jw== 
Received: from oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3874kn0eqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:28 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.podrdrct (8.16.0.36/8.16.0.36) with SMTP id 13SFbQoV164727;
        Wed, 28 Apr 2021 15:37:27 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3030.oracle.com with ESMTP id 3848eyqyn2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Apr 2021 15:37:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K+q0oB0UEAlvgF4p5RiJjv+z3WAysi1Mdf8/NAT+1iQ0d0CV9S4EUEBIZarhusZ44kYMfqaDud1lCLY6Y2ZFQRqxOWYA1uwfoK4XMGM3j8xk+whpf59YnffzKEsv1AqbzK9+zyNTe1yA+rYTtGV2PxKnZpsYcotH5m9rV5nVa+8CgEArDX3TpUYwWb1CxB9ZlRSNhNAV1Mo9Zqz3bosJ1IPibLCDNs3tKe54BHbT2x0/LB8sSnz6wg15JptGHbWni825tPsomFEJ77T+Xl2rgm8AVTPO6y7yBhF5bkhIf53nADtMIHRrvD1cn+yj4Wy/OqqwfFQgabwPcsJCkO+2aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROweTUnfvt7pDCe6CEGVDYAJeVJ78rD1b3V+lwXd0p0=;
 b=UkscmMYTOKXp3tChEFrRdIkSiVbj1JcXZ+HgDn3cQBfbRHNUfU4luZOG2T/dsi4+Z0rxYXDBxOXbmnXGocGK6ReveJuzjkDGTbCqbvYDUZNFbvw9m+3UfdSAFF0Jc1886hr7bHp3Lr4uVgTgMvdpXydusUzS5dK5ocVp24oBtpWIsGJ86vslCU4vI1M0UvLLx5KDaM5QhjqHVpY4oALi02F7/wVgLtbIO6TryhxfeWaznaETIl7wjS07fr8TauplzCuhh3vOghXHU2isTvSTPgQOuGAuyG2yp1aWFTwpaGNmNKfaUn9vMML7DyAkCbvFRygmLODITze7D6q7SWKwbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROweTUnfvt7pDCe6CEGVDYAJeVJ78rD1b3V+lwXd0p0=;
 b=uGCUJSmq3KPGG1nFKEE7t0I0+P5A5zZWJlHpD2Gfdg9c101b7YeiE3bUZ4uCVazjYTpwmTdeZy5dgttsqdhrx33Psi+HWCCOruncfY1N9c87HewcBPV5w2HvPnrOXVN9DaGr1HWUIh1qMLHFqTOOKlzJECTP4Cc3Cnfg4ElhkZQ=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4515.namprd10.prod.outlook.com (2603:10b6:303:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Wed, 28 Apr
 2021 15:37:22 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4065.027; Wed, 28 Apr 2021
 15:37:22 +0000
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
Subject: [PATCH 69/94] kernel/acct: Use maple tree iterators instead of linked
 list
Thread-Topic: [PATCH 69/94] kernel/acct: Use maple tree iterators instead of
 linked list
Thread-Index: AQHXPEQ9tY/56IFiC063oZwYqAVPwg==
Date:   Wed, 28 Apr 2021 15:36:22 +0000
Message-ID: <20210428153542.2814175-70-Liam.Howlett@Oracle.com>
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
x-ms-office365-filtering-correlation-id: 7314be04-8273-4567-5206-08d90a5b83fa
x-ms-traffictypediagnostic: CO1PR10MB4515:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR10MB4515EBC5B1B575EE5EF435B2FD409@CO1PR10MB4515.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1303;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+U1WwXxDVZKt679zkwzKK5tBEzRXuZ/mqgAJHkU0Enttfe+iJ3rfzerI6TQxrs5KHHqsQCU/pyubj9Of1R6dvseM2XLcxiC9BwTfluB5K5xfIWS2lHkanr8Rong77KLUZ/0Hm8zmNjOGq/U+GmiirlSiHkH5KYGiQKvY5DwMLUztvBQG0UT2AE4HqhoSykxpzoBuG1O6SS6a8NdPMXDseAKXpT6v4duZA1hbkQ5UW6L9WTrwDLtTh4OniOuosNZM2n90tyM/Mm6w9xOq9S61uPjJmRL0mwRLQAVz4Wx8DYIRLxBm9ZPaAYV21o6DNIHtWo9BRxoh/WlXA2RrJWKNWRc1Xhl+sdm5OYOvWD8C8wwBhe4Njfjgkap8WtmYK8+bo3vITaeu1bpPFQ8caAhVXavyef6i0WSXRWlWY4JwBmwCLL2ADFsUdvOl1CveJrdOAZFZ/UkTAB8aY6ESgeEW+lswPDGJvwEStf+Fw6xh1imnrTPkPjNDEIWeTCh1TBUDM70WE/pIO0BaN4byFxAkw2ea+u3W2GW8dnD+LichhRxDLcqy5ZVYS+y9UOkRzdAKqIF8I/V6qVc6X441Tq/wq4Zx7Dg57Z8KdltLJPJrpk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(136003)(39860400002)(366004)(6506007)(4326008)(36756003)(54906003)(71200400001)(26005)(110136005)(316002)(8936002)(186003)(44832011)(7416002)(2616005)(4744005)(8676002)(76116006)(2906002)(91956017)(66556008)(66946007)(478600001)(66446008)(1076003)(107886003)(64756008)(86362001)(5660300002)(66476007)(83380400001)(6486002)(122000001)(38100700002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?USdg1RbZZkDO9bP3KCxHh+VOeb3lnC7yn5zstdjJ/51N8vqIQiJptYJMH1?=
 =?iso-8859-1?Q?EbwlDFP+sY6FEkDU/5NHrsN+r6D/hT1i4EiHL+WrgPmCzN6ldiNPYVTWw7?=
 =?iso-8859-1?Q?e99/FgC/Hd5HxfbQg3NIpyD0xz6l2aGG33F9hd/+Np9oTsDFmarBAjz7Dq?=
 =?iso-8859-1?Q?gMlfjf0s4zwc23A4u4x0GtNXGF2CJ9VrL+SP0PgHa/06i9L/lQ9DSKwxWc?=
 =?iso-8859-1?Q?z4juAI1hGfSntM/KgEcFcx6D3B76cOF4JGIOB+BCZA33PkqopQxr0jSz1P?=
 =?iso-8859-1?Q?soKMy0du9glSOTVcDCNaOLiK1fjtP3JsvFjulzz5w2UiZ3FFOpoCXWUKdh?=
 =?iso-8859-1?Q?IYvyme8DsGIst9o47Yo2XO8m6OAWgxsGesbuMJj7lWG4d/ODbN8Kh5zM7K?=
 =?iso-8859-1?Q?lIj8TC670yLFJFNRaGZFY+jpMUJSpDznkTAouWUCGKA0lj9eG1rhvr9Yc5?=
 =?iso-8859-1?Q?KyQXEnrk50dtIlZdYUhN0ruVsK2VDj+w9M+gXP4K+flgcsOxPnNjnZapv3?=
 =?iso-8859-1?Q?egQthlpGAFV82jmPJ/gdw98mHxav3u9awkuOaKQJr8htAkFTFFcEGDv55x?=
 =?iso-8859-1?Q?nsDcxPoN2DB00Vzscv2D8GbbkNie5tePoTBhIlS+VGEeFg/z/k0dXT9w2S?=
 =?iso-8859-1?Q?8oUGO7RV4csnYLSus72dNYrItb8cSFp/naYNaHXr6/QvBiBHWaPYij0cxY?=
 =?iso-8859-1?Q?iFXMr+ghdW6Kxv7u3xfxSvYEQIuBtMN+tXfoCqISbTPPcYEr/3BBHQOzuH?=
 =?iso-8859-1?Q?1hrKUce6lp6qpB8DmRu/btci6PEnLyrJ3/E1mUPa0fMBoD8j86oouFjpKL?=
 =?iso-8859-1?Q?+zjC39NCmTGdgsLT8yqpyDR/9J1feeXKulV5eviM362xTqs+t2DhNEtArX?=
 =?iso-8859-1?Q?zTQ31wUPhETVegVNML7umcyDnHq+Xp861xkbFO7iRid2L2CiQpfpMy59wa?=
 =?iso-8859-1?Q?qk0tMIjZF/l8Ks2MmTOg9CLSvbmJPKAEajrP48uHJ7MUMbA6J4tw4gr59g?=
 =?iso-8859-1?Q?F47wKZVhMY9Blol5BWluRN1vBSJyAizIow7xh+xDD45zZNbXaYw2vUUo/p?=
 =?iso-8859-1?Q?nbVrWtqxayOGQG/NXPR9GPDWxlRy08TA5BbsHnFZIxFqboV2+n/3voanFs?=
 =?iso-8859-1?Q?AZF7Bpe0E15LsOxDspVJ3Gjvm5xMvKbM5GtAdIyr2MEW7bShGmUsxu6Kps?=
 =?iso-8859-1?Q?Vv2mprL4AGL8Vto9gcFUAbVkFRsSrW8p2kZoNA3dlPmpC+xka6YJbbVHV8?=
 =?iso-8859-1?Q?zpumKwTDQ4hgDHbqclDseo/J7PGwOAbtbqOF7Wbdmc9Jq10az3VkCWMSYM?=
 =?iso-8859-1?Q?dmD3zqmaslQtVZEBTAgJs9DWvJCDnVGqcZBPfBn5MYxp5s04NjJk1IdCgK?=
 =?iso-8859-1?Q?lehAY6wzOo?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7314be04-8273-4567-5206-08d90a5b83fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2021 15:36:22.1173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2YmGP8fHtdd6RhdhOlk7G1uRtBSstTaD9fp8y+QO5/ajmJw9uA4Mtr2t5VZWY8W5AxpHMBTIJH/rr1j2WnPw2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4515
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104280101
X-Proofpoint-GUID: DjvgGnqbNpVzvhglmzZDsN917t_CAyFN
X-Proofpoint-ORIG-GUID: DjvgGnqbNpVzvhglmzZDsN917t_CAyFN
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 kernel/acct.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index a64102be2bb0..82c79cab4faf 100644
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
