Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A6C3EEF75
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 17:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240549AbhHQPwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 11:52:38 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:38520 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236651AbhHQPsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 11:48:30 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 17HFjeLx011246;
        Tue, 17 Aug 2021 15:47:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=gkR74Hz92KwKaW2epPKPK4AQxShbKVrFIj+NGFDmnXA=;
 b=TrRkApQtCDDTTSwZXfwtwAjdLzLSbAc1cZrprHJ5RKRYzVSPcIEsCUh9svsHm+KAFhhZ
 vpTsJyfGJxkK+YjWUonD+VPmHg0d4RCJcOfnLinkvGcdJtqa2yc86rJ0o1fSx1TMivPA
 SjR/Np9Dw9vgUtmTVr9nIYdQfG2mynEZMeZYAl0+HlG6BkrXvJDTpMGNjhnJa9KZKdnd
 /W1WFWYaF7JVe6q9dyYPcEmb7gxUFdClVqnLkiZiu/x5klwPbF9f3stpDy6EtM3fc0F5
 VsFbr7zupWFqpM+PD2a/EhOERLUXirjkASXODpFlg539YZLMR37jltmwkZRcoRvZYroc 2A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=gkR74Hz92KwKaW2epPKPK4AQxShbKVrFIj+NGFDmnXA=;
 b=inadipfUrXtnb4TZwHGxUStSF8zQd+LHZ4h2dPRtVA9d0A+EeuiBD4r+RMuGetYODCx1
 yTMnnX2+TQtLVrnFhBu/rZ1v3GAdw8+REY2Pc1f9oZLJbm1JwpvgU+46b3YnsQ8cXBn0
 FFi+bIyE1f5NJ+xe+/Dszslm9A3sJrj2+OkEnNY0gm4YdkNo42iv1pIncvMhwRjJ40Xu
 g1QmIHJHeGIfFM4aoYJih9yQQ0i2y7QUzfs8P8ZnYGKPI5mfoDGtiiQBCV3Du8C6/Ngr
 TbRmisXRN5uaRS1qik7NqOA77BBWDFcHZ8F6fCeMvivLgi8VbQI3Kskaahj8XgfIPzek 9A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3age7d8btc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 17HFknHU158854;
        Tue, 17 Aug 2021 15:47:15 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by aserp3020.oracle.com with ESMTP id 3ae5n7su10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 17 Aug 2021 15:47:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fMq7Do4IvPV4qq9CWidMP7b1kckgDgAvtE76g2ile3KdqFWTCaqvPgtu6wLyjo34+QPo99luqKJFel2PB/HbMnJrj71Y95w0VDXeITmxrzHvm/ZuhkHpXx6n+EQCAK2lJ378Y2E3gZYeVZ738en2ukyDp//8071y6+34pj+GSAfk8/D3QdXEvcGoa7jR59c2W22yCRh1I6m0T2Toi4DPmNQSMK9hLQjxTIfGbp1wyfrO1e5Ju2UwYC7yV+zduamI0XCSdmYUxaXq7oq3vPNEyieGUBFvjtbj5/qqnV4wm36/MMjXt8sWOmPzGnOMNBKxwqIxEGR8jn/vF453k8TpBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkR74Hz92KwKaW2epPKPK4AQxShbKVrFIj+NGFDmnXA=;
 b=mg+cYXJSkfIpJBhg37roXR3SiMKoXeu8BIC1ih+oo7bPC1aKDj2a6z2aKO0/5ooJOGF5QJGEgwWw2ADgRzj/dRq5+5dJ2QVSli/PQ7P2qRudITJ8Nu/z4suzqCM7zulxaEV/JBW9gRsIcq+0J0UDPJHe7OLKZQ31Kn+ljqS2dTHyDl2oP73C4b1AXmYd0Rmx+LeQJp+Kd+nE8y2fE9A5AHI962HoRJhPf9O0HS7mmXvdu/8/p+Mgs6iLXDIQ4Hcm17VEYLG7g/tSuTghA91AO/psrgjGBmF2i8DJQ0wzb6jZGIz/0sCqkVMali2X2ECVvcFrXR8XHMXYU/6qUX5Ekg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gkR74Hz92KwKaW2epPKPK4AQxShbKVrFIj+NGFDmnXA=;
 b=Qhl2pKLhqeji/fZe7CEzoFinjrB9BoPTdQ3TwAkI/gIGFPQqbg5kBh0LFKja/TkGGvzxfRA+CM1e8YxE582zB/VQHaWyMSP7r6utvaM1TTiWZ/ioqdGYHgyiZPLFyS4/urM4Tc8Rwn2KnvwtNE+POisghtfxtzVCe7hUlmf8Sho=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB4236.namprd10.prod.outlook.com (2603:10b6:5:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4415.17; Tue, 17 Aug
 2021 15:47:12 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::585:1aa0:6582:92f3%6]) with mapi id 15.20.4415.024; Tue, 17 Aug 2021
 15:47:12 +0000
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
Subject: [PATCH v2 12/61] xen/privcmd: Optimized privcmd_ioctl_mmap() by using
 vma_lookup()
Thread-Topic: [PATCH v2 12/61] xen/privcmd: Optimized privcmd_ioctl_mmap() by
 using vma_lookup()
Thread-Index: AQHXk38lv8e7i0JsTEKNP7E/dtaO3g==
Date:   Tue, 17 Aug 2021 15:47:12 +0000
Message-ID: <20210817154651.1570984-13-Liam.Howlett@oracle.com>
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
x-ms-office365-filtering-correlation-id: 48da3f6c-ad80-4485-f170-08d9619647e5
x-ms-traffictypediagnostic: DM6PR10MB4236:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR10MB4236466BDD68BCDC9EBFEE06FDFE9@DM6PR10MB4236.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AX/+5TIc5RlRoB+x/45NJxGqw2fXMZxV9KingDuiYbZ35kjOStmUpUclN8+Qrh5iOJH7+3LlnZEBles3aG1ikd17L33zXwyM2okHhoohECmOIMeTvCciOEAzH8cLjINiA03JRcvXdslj2KrG9WKtlliVBl+DCQroeqolLq+mDFH9gfaWPH9xNbew8CR7XvFEFoV1ADMg4ZpFNWREr0SqeK/aqAba6ph2bm03QwIcWTa+min1N/VSHHIs3cRr06TyiHKAbueQbKbmdUb+/Fn+10D7601sihPrmhuYlanDjMT4npW6TzE6LGVAZshu9S30WPulhFXPoqL5IfC4xgXZ4EkFXg7NsBxSMYGFjp00BmFiQ8vzzYd/FJTm+ulfReR9Ojq4v+/ytKeX6iWDj5XNAGqngq1p36DgHKLS2k4yj20HNS2zCvVneWhWZpBPPR5xWaW8Dr0CVsFB+d4+SXHvQfMTT53ax/P1DYro0KYc3/7BDW7ZqviC1II99vWMKjY7GV+keiuVoVNtF7jwgx+WpPMHI+2u5S33GWCXOhOgPsqM++Vlvz88mHD0WpPI55ivCO4J9RaIvjF7SP1rQ9meD+y6HL3evV41wwAWLPG5JuG7iDmPN4qIWr8hjM7McZF0lAMaoQ23ytpghrsuKFfxkJcXsy8Sn2oVjCdUZKzlCUTNKabcLJMUw+K6JH7EI1mYeKFglpncJYMk+vFIfuGxfA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(54906003)(4744005)(110136005)(1076003)(5660300002)(38070700005)(6486002)(36756003)(38100700002)(478600001)(83380400001)(2616005)(4326008)(91956017)(76116006)(6512007)(122000001)(316002)(44832011)(6506007)(66946007)(2906002)(7416002)(107886003)(66446008)(66556008)(86362001)(64756008)(66476007)(8676002)(26005)(71200400001)(8936002)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Rfe3bIuxEHm23ucXID8Vgvr2TGYHBjxuT3xI8Db6uu3Mi8T30cbhRKAp8E?=
 =?iso-8859-1?Q?FyKcvsp2T4/Tn/x5OpqY6fhHZy7i1CrAg0pnl3NgVXZumSMiysqW+k20VQ?=
 =?iso-8859-1?Q?Y8H0lLNRHn48IO/cbKI4A6pLkJIu6DUepNHuZhPUxW2yaTWcOx49hs2CuH?=
 =?iso-8859-1?Q?kC87hajwhAGh7d7oPthEUgtgFGI8Tk9xwBHNx4MPTA7oW5+WMny8tr4z1p?=
 =?iso-8859-1?Q?jpYmML6tgPW/QDjj1E0dN7rtyYT1532atgsLP6/EMRW/dd6cgL/OtB/fG8?=
 =?iso-8859-1?Q?YOc1pWr+eoUvqMY3/1ZJtDtxyn9/1l8RjYIo4Tggj1NA8I+UfR8I8gi1i9?=
 =?iso-8859-1?Q?HjMKU+HkA7ePjpsXt0GjrcSqrY43GQAGRYMO3FVTSAraKgnv6NSvYf3zZ1?=
 =?iso-8859-1?Q?ldifqLerqGr7FoOEs1D5HYaOOSiHsNz0DFIK7cRwYn5axqOPKTi+rtaQLH?=
 =?iso-8859-1?Q?3LXDjDdg+VX2wBDxqcS5c06s0UbliRvx4QpVZHU6sklKVWZvYn0E+d67C1?=
 =?iso-8859-1?Q?xmXSFGp0jNXGisGy0I8QlyEEqOGcabG5B9LK0a4G6ItW8xUIAleN+nnuCY?=
 =?iso-8859-1?Q?aNluo4vkS/ppS6LeRG4j4r5/TxglAHVgzUWDOb2Q/1wES5NwwnRTwiqxBb?=
 =?iso-8859-1?Q?zXHDkg5LXfQY6pyJh2qrA7A22ql/7rv28YKKken54DiykRbU/jQ//9ywZJ?=
 =?iso-8859-1?Q?cSb55gUj25g/Y88G+n9iuBCRbdT7QCj3vfOlduNdZjY+VJ6VHEuqtKsTnf?=
 =?iso-8859-1?Q?qCo7BxrwuuwscT2UK80919JumNr96BgOP7CpSXffy8CavuvSRlV5sZZFoH?=
 =?iso-8859-1?Q?dR5UdRuFlJRetTiP0IkimIjj9Xa+8GTded/6JPEwUXdZ/zjXtJ/mA+HNr3?=
 =?iso-8859-1?Q?8TpmtE+68MJlVkB29+hfcSkEbbjClj2NeD3GWZXk6p0GpL6D3J7Z9AxbI5?=
 =?iso-8859-1?Q?KboT/j9n6uScFMwSzwBtXTvOIljOplsOA4DYT89cF6E81z1nSALGWTOUiy?=
 =?iso-8859-1?Q?5pq8JLeaDV8s1ZjYu1eTF7yvlI+YjUTAC/x2IjR9gQ1zAYkiHVMPgGQ1W+?=
 =?iso-8859-1?Q?IoiDwEuovCeODKsCYsKoKLh8rkpGsy3FMyy7ym6IOTHOHbcuttm4jsAomx?=
 =?iso-8859-1?Q?BCyLZVHyVfl6G1SszUq7+2X5er/vUNaiuhOnrwUD2EFmsxz2eXbMfhP3+W?=
 =?iso-8859-1?Q?hzJIm/sJ5LrhpABK00i6o3HkZY46s9dCpgXr6E2VACpyuPu3X/DUDmofxq?=
 =?iso-8859-1?Q?9VJjoXWyrgpY6v/MdoXur9ABCT17AjDYutOZ4j6rXUV9NKtT1p263ZLlOp?=
 =?iso-8859-1?Q?E1jNHIgqaYuQz1IB1Sl/oLE7f/wPc3RF7wD6h9cAToSrAU8A5002d2V8/G?=
 =?iso-8859-1?Q?J1z7avNJMk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48da3f6c-ad80-4485-f170-08d9619647e5
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2021 15:47:12.4993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FoaCw3l9M+YjgQDEUOyejhHGIkQsRVufVmIku4AAbBDDmIHj+WV0Ipo02mvGM1wfVSxVme+SihdA7UHkLtbfPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4236
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=10079 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2107140000
 definitions=main-2108170097
X-Proofpoint-GUID: iuusRumquYnEpkIuf0G_QpHyY0y-zeNf
X-Proofpoint-ORIG-GUID: iuusRumquYnEpkIuf0G_QpHyY0y-zeNf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>

vma_lookup() walks the VMA tree for a specific value, find_vma() will
search the tree after walking to a specific value.  It is more efficient
to only walk to the requested value as this case requires the address to
equal the vm_start.

Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 drivers/xen/privcmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 720a7b7abd46..5f903ae9af7e 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -282,7 +282,7 @@ static long privcmd_ioctl_mmap(struct file *file, void =
__user *udata)
 						     struct page, lru);
 		struct privcmd_mmap_entry *msg =3D page_address(page);
=20
-		vma =3D find_vma(mm, msg->va);
+		vma =3D vma_lookup(mm, msg->va);
 		rc =3D -EINVAL;
=20
 		if (!vma || (msg->va !=3D vma->vm_start) || vma->vm_private_data)
--=20
2.30.2
