Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBCB3EEFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240639AbhHQPwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:52:53 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:36710 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240233AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFkn1v017380;
        Tue, 17 Aug 2021 15:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=c+AwrPwqg1Hy+1SJqh3puIx6uvECbquedchPrA9wyi0=;
 b=p5T1aDIiffSy+lMaWPZGm7wBOn3CR2/8aPCjQ0L8gOi+DpBPBhxhhL+hNuvEr+LYjV8z
 UfCqntsSMB5/c9YJaWChHWtsP/kNs/Yww/8wiZAUnUpv+LKi2ktgm2xkuBfsHgKzaNei
 mU8813dL3MPZ09oMKjb/hWcvQDGQ9r1MldrRPjig0T99dRdnZhErXhAgix4gb+cbevA1
 Pv1vwOrVbTLj6LkKd0nXJqZdGg3hKDr1BRTJkUbMjRePuuuCZbOl1yf7WdrCfzuxxyq3
 TSC26D4Zt2h5OMcM4mLvpUqAvIhYa8/UdX2F0on8FfDIh189XD93R+iNk7+KwJWe+0oI Zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=c+AwrPwqg1Hy+1SJqh3puIx6uvECbquedchPrA9wyi0=;
 b=LikW8buM6AEOvHRlhMBlv9jWFGM+Brpn/raCN29dtwEwkg6txDMhxT1K/Zg/GieXx6Rh
 PcesAZedLRPRyFvXAykLxeUAW1fphUrvetnCOAtiFJAD//Msn0P5kCq/mX/tqJp+1ppi
 r5NTEWkLTNcZkJtf/vhdDxJKtOWGyjnKs4G5CS8rvx27ioEfElkJbrRB4iyX91hZ9AaH
 dR/+0QdHirK3VUQfcWyuu0eit7rYa0EZDmcv7rMbZPet9+NUz83pO2RO+DvxMUrBwz3T
 Vvu+P+JOM9HjkYuwtc1tBXaZytz9jCB/GhNtAXtGpcC8qOsfRLBX8e4VKCVygvNePwuh ww== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3agdnf0g46-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFkmf2158706;
        Tue, 17 Aug 2021 15:47:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
        by aserp3020.oracle.com with ESMTP id 3ae5n7styr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kp4wl6TU7JPSiGFoSWFdYoe8Y8OHAtbCIqE1QqoEFyo9FTwnZ4FQ36pak6pG8HT9/BKKsPdhOlyJGkzvl37GjNyEE4KuTBC4SWzbT1EpOH20TgbMG9q7QcfoAawyHN9doo0mEJUAyW3gBJourhMsKjuAEnNqMiMkfG/nBBzbHrhBN0bEfW/TPT+TcT58j0X/LFadCypaSqz/hIy0FZa8AJviYtuzwiNDsB76mlawmKaDyqhSXKSvHC9vmmzml3LfPlobx334RIW6MheR0FT6hTAplmgnzgu1zcu0XfPeusKiR6eexPciAazJkW+q8lKRLTYnQj5whXHYLUkgoTVBsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+AwrPwqg1Hy+1SJqh3puIx6uvECbquedchPrA9wyi0=;
 b=FTdKldgpblVb+q7MOACgpy5KN3bsIonr4QywphrA5YCb85spR4h/li3wKfMXRQ7saC/0oGFP/MZwfUBXCnIu80aYxquYz/bRYod1lUaBVpjfwOcS1s9sSu++nQ5KQsx5EMRkqtGhZ3nJZLgM/IwQOESDwdxOS4fnFpJKw0+KLQSJTRkOhRS0/svQd6rjSRqpqq3jl9kaPQAuXzpPAFPt1Upms0YqIaX1GHByQ7W2JA16ENhBNagqFu3f4JMsPTmIGEn8iIYR4bHnAuo9wus2FO1MKjfPQxAQjo6dgd+D4tCLi6xdGp0TbONfNFeHVgImxotMpAxBNOb5M0zwfHU6Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c+AwrPwqg1Hy+1SJqh3puIx6uvECbquedchPrA9wyi0=;
 b=VjctmGF1E8WywoszEHBRsQzf04PBsAk8TxQr7q8oC0TbytUwtSZRvFiRu1OtTH0MscSKhCmV72anmMRYuG8lJjlcFGj95EHZ5almW0tqoz764VruVmB3rbXUA3NVgyEb8UUsD3JrhHHrgeZTllOFaqQ7Mdwy8C6LPe7wnHm4Vig=
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
Subject: [PATCH v2 13/61] mm: Optimize find_exact_vma() to use vma_lookup()
Thread-Topic: [PATCH v2 13/61] mm: Optimize find_exact_vma() to use
 vma_lookup()
Thread-Index: AQHXk38lC3jw7PbXT0m1XDrJ7HsvZw==
Date:   Tue, 17 Aug 2021 15:47:12 +0000
Message-ID: <20210817154651.1570984-14-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: c7060913-4c96-4209-9e2b-08d9619647ff
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB423673D116CAB3E659639164FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KhOngiGOBywrL2TujnYuCTeHVT/yJ8HF6hlDiP9mZ6/RVzY4DkU3I2sDl+MiQLhTQr3xQPkt8uMTgItOlC8ipn+k2tLZoE5Z9yaPy/OEUw7bDf94xnlcnw41zBpF1V9decA9bL2icypmZYYvnO4dVfsb0Frg5dJpfMXSB4Wli8L+n4rYdCKyYBCxnzBpi9GDbLTUhbvadrpmyH3qNSpVg80rKLGZc8HwKEwgnwmIij3iCiEiu5qHurYbg0sBlE8LwVYJHiST594mn5YogPQWCVwdWSa2vLANXgJz5O2CDMhEVBty+l2/9Yao74SwQj9CCBQeau7P03WM44vhl6aQ9w9cv9w96RhZdN3Hv5Vc5yfyZnRE+XJyB8t5WsUF7KcgDWqHamrXKAHpf9MAT3DiMFgkAdfd6ucmxDrFC8lyxp2MpyXQL+dy4LVllBhLWjEtxCE1nA6bwJTyyGJPPnoOJH60tYL8PgU+INAtStyLJ+aEBSna/dtHAoO+1BJEjyF61oOaS/6dF8MGtoSY8tA9VbPcrC/E8wHH6qq5Yffn/GjyvO57Zi1g8rZ/PgMmM03gkz2aIbDPFYv6dvLC4OGZR3bfu4H5hYhMuCz6Cz9zvhGm+mMpl/T4NRy/JQ+qKrkIiVGSVqR4eSOGUcQRCgGDqjv7CgOPziLnCtKAKxvlQ3ywPRmn4mtVU3h9mm0jNz5mkPNhkASgq6ttoumwZoFg+w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(4744005)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?NxR8FIjAXB6v7JlMdaeIaA6GyIVsTxY6Uj1Xw9+8NWpe+9sMIE0AqtxPf7?=
 =?iso-8859-1?Q?dJO11BEByVEzAMhz6NBQwTPVs2Pl0PNnMA0EunmEmLXYOoauN2ZAAYMy+p?=
 =?iso-8859-1?Q?oW7B/p9chxNYlYe5F7QsHWWUwuGguacQ2rfptRgl6Zn4enXEvW7suGzU+h?=
 =?iso-8859-1?Q?CxoXHujFK2F2ugKjovLoqx7a702tBdoPTQugExHfpTlsVsw83GE86zxz/Y?=
 =?iso-8859-1?Q?1NiOWCgrXH2zWKk8MLOhEFLoELx9ug8Eo8RHtHm6bQS9Z4FgEoQy03s9Dn?=
 =?iso-8859-1?Q?RTT+siH2YsoCToFLOxDa0rinr/o/eNORX4EfCbc6b0xU9n1oit3/FLGRDv?=
 =?iso-8859-1?Q?U2MpRtHFD+osPq/phXycoYdGpDVjkMYetv1im5XwWHuSWATvP+/REN/01k?=
 =?iso-8859-1?Q?K+FrhvljIfm4Ex/iz4/Gk3qqBBTZzlMz7DPbnArl9NIfU0wDTPjnbYCsNi?=
 =?iso-8859-1?Q?XE8aHDXgFxy5vGCCBf8saQB+kHWrcZB1B+mIkNIug5Gli5gAM0vRdk8xMI?=
 =?iso-8859-1?Q?TUaDZRCqKOJ0PovbcAeHHo3y/rvdPMp0mgfLx5VTBU20Go7+iB40XmzYGz?=
 =?iso-8859-1?Q?3cHvISAMzTlmVeYm0koN/dJJH837Mmtji7dSaCkJV9jOhgBcUGijL548Ms?=
 =?iso-8859-1?Q?/ozSq10tOPf9F2hYuZrGE2s2gqn6xl4HSASqT9EkvwVq0eQBPWFJiFtSYl?=
 =?iso-8859-1?Q?gSYYD88TkP0nK0XrWRU8jZDiLscR5oz6/ghbMuDno2ki/XxIqNxyYQLGBW?=
 =?iso-8859-1?Q?6xtTxfDPR7KvrOArdE7+cKFLF6bqy9KKyb/XwgSvbCFizrgkdT6vyuEzEf?=
 =?iso-8859-1?Q?ujNC8xcxDZimq6eqDIgLOQvQl3/c2WHNT8c7z9rlju+1gm/zR8b/ZLQaVo?=
 =?iso-8859-1?Q?yXawKcnhGkRLt6cM5IfvxWRRg44vnyy2DvRfkvpdrgxhmeuaDpxlZwBBvE?=
 =?iso-8859-1?Q?HIwGrb8DJyPgHIxTi0tUbNw2EtIfyi77MrOIGbUhisEGXe8gC2E8GgoCqo?=
 =?iso-8859-1?Q?dEDjRjHoQOgGbv2fpeUKYKH0rbNq1OeBPL5uX3uv3Q27W9nn0+X3IfS6VJ?=
 =?iso-8859-1?Q?PiSKzei3WC1ONdNWeAKcXRgq1Ve4Sn6RqAM9LoGj9ApITjgHJDuoT1MBBa?=
 =?iso-8859-1?Q?aMJivs7q6fFnVomRAxdpt90w23B+TAtYfBGRX3j2wPrtpCVy0Kg/0We6Wo?=
 =?iso-8859-1?Q?Ihyh5bVgMf4ENp84qaY77CEUoXH92t04DnncCvv+2xjjvBmJ7yH1HqprF7?=
 =?iso-8859-1?Q?P4T5CrCnDjhB6BErmFCX4Hfig6BxOxqBCHY5nlmQwa14mVvsfcPNOtu9MV?=
 =?iso-8859-1?Q?LFo7KjUCNU66aN1iousXeU9T7jIpQw+tWl1gMwYwhs9kFYffejK9i+Ugo8?=
 =?iso-8859-1?Q?ehF4fCkY/b?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7060913-4c96-4209-9e2b-08d9619647ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:12.7641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +P352sKBe4hCy3oJt6Ovq+jb754CXNQjv0TY2rQuYNUP76S1HunZSHEalJqo4qWv/yfvIU4qJpiIyO/Fp6HqGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=859 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: O6nFwtxYvr_gZ24tkOPAE0HY4rrmDo_e
X-Proofpoint-ORIG-GUID: O6nFwtxYvr_gZ24tkOPAE0HY4rrmDo_e
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

Use vma_lookup() to walk the tree to the start value requested.  If
the vma at the start does not match, then the answer is NULL and there
is no need to look at the next vma the way that find_vma() would.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 701cd8fa7750..a3086474d8d2 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2841,7 +2841,7 @@ static inline unsigned long vma_pages(struct vm_area_=
struct *vma)
 static inline struct vm_area_struct *find_exact_vma(struct mm_struct *mm,
 				unsigned long vm_start, unsigned long vm_end)
 {
-	struct vm_area_struct *vma =3D find_vma(mm, vm_start);
+	struct vm_area_struct *vma =3D vma_lookup(mm, vm_start);
=20
 	if (vma && (vma->vm_start !=3D vm_start || vma->vm_end !=3D vm_end))
 		vma =3D NULL;
--=20
2.30.2
