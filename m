Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C47403215
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346399AbhIHBNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:13:33 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39802 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230162AbhIHBNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:13:32 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 187LTMNX028195;
        Wed, 8 Sep 2021 01:12:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=kFmhm1ABWqLMM/zWBcvhH0UxNIvV4/q0sFEoTN6UWnc=;
 b=TTVvLaJE77GElnSzb3rRJWP2T5lfxd8QbED05KYCVHfc0M2/dxPrlnavrCtf9WCcJSp3
 6xdZLfVk3aHv2mt86fU2jfLV1YYUwJHYQwqeGvORHLbALFkWhJiy7LfRdjbtM/ZjtFGh
 BXylyaG+QfSPsTCpHiWYQvNsOgS50FIwf5OCaFbQKETDRFLCcBhQL1Df1BCloocAPjF9
 RzlUj7uv7u7txcBPxktzlY+oDKthHGWx/IHxkktslh5dtSiBccp+9wnNevCdzdU3KkXP
 0YzY30EnnVXqRfI8K1stYM5H7RIwkUkq/CEttTx7XNdPdKWLUijclbsHhOH6aVprgTDI wg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=kFmhm1ABWqLMM/zWBcvhH0UxNIvV4/q0sFEoTN6UWnc=;
 b=HGRuCdVGoouiMQQjOTNF9oMPRiRWAprUwj+DpC5FDW5++jeRzdfrM1CflKoFjeI3o5Gx
 HwtKnNr0L4lr0DMwx3ta21StAjqpUKGlD/IB9gqInHgrGM6LMYBGVdvpiznGvjk5HMoA
 Y8jmmQ5m4ZNC/awMYOYolm2lzPmeZJAB7zUWrxDEkrR6eg+APNYJTmkh9sICkk/2TDLG
 hPork0TG9XUGqevTZvLaqAaElMWcNrZ+T2siD8rNejkVfk+KPUuPeDUgW2m2QnlKYKk8
 OovYmrRJqpHEHkUgGhDEqZs6u6ysr1MCoD/PCpqsKBrMqGXvcIe68Y8uksYUh2dte13b qg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw68xem-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 01:12:09 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18816B6Z072770;
        Wed, 8 Sep 2021 01:12:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by aserp3030.oracle.com with ESMTP id 3axcpn0emu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 08 Sep 2021 01:12:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sf1Gi4lWSXSPvNQg9YjuCN+PoiJfRtre6goYuqa+8GG+N4l6D8AYgt86OjwwUQFg/JEOz4bqEGhTpoiN4gNp0QPwnYw6HEG7a33BjcBYMx9xWoxjJWocBiHmVzl16/4FHhfgYr5G/SirFWN1HtbV1bonyrcA0XxE1Q8oaAzAA0SJkTQRTS2EKUtYSPrUVsqX30MsDDe78RvOprdhIGGPhP9zyobNmchc2hkbG9CrD7oIWkdcfbSTXjAT+jNXiojlTfv25UiP0BXEca7briqgyaEs8bi25t4L6hn51ZpkqHJAGkAdqxZjT64+uMhV8oq6JinddU2JOh1+obChPSVZmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=kFmhm1ABWqLMM/zWBcvhH0UxNIvV4/q0sFEoTN6UWnc=;
 b=L5oKKd4YTknZ2C+jHTMb6+D+g3dpJGkdtaNPKXpkN2cuaAtFCHuTD9QinSNyvbwtqgAfwR7C7v1sSuvam2SLy6ikDNRrQZKo/pL5ZlXcM07EWI6f86q270+Duc7MV4UQ2iLiDinLFDpyA/TqwWY1z/1kcAiwRWxwgwjaAZRV+tfCfy0gZHkxiSlk22zwVf8Ir4Mwd5fxG8uSiYieXtKgqY0Dem3kCxFK9SnrSU8t53ColYi1Qboc+GA4h7iC3u1u79+D34qzFP2bbLAraQ7kTZkHuoUSJv4qnVMNwDz7jahhwUlWJpAExDDPxCEKMSG+7lNKuOWUPl++tD2rbywVbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFmhm1ABWqLMM/zWBcvhH0UxNIvV4/q0sFEoTN6UWnc=;
 b=I6DeB9pXVNwNMUdvt+E6KrL63xsY639Dm8G/8qyHyZWLKdpqvvqgNmgIFle1F+Suv45RTZXGwu3QKJkS6TRtCqcqpvLVXlrxrHfYyBUeoeOiPrMAz8sRToGXJkc3G/Q0IvlUYfETAfz7tq8EdMTYDpgpOYU3vZ4KfViqGAs5iOI=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM6PR10MB3500.namprd10.prod.outlook.com (2603:10b6:5:153::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Wed, 8 Sep
 2021 01:12:07 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.026; Wed, 8 Sep 2021
 01:12:06 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Peter Xu <peterx@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>
Subject: Re: [PATCH v2 2/5] mm: Clear vmf->pte after pte_unmap_same() returns
Thread-Topic: [PATCH v2 2/5] mm: Clear vmf->pte after pte_unmap_same() returns
Thread-Index: AQHXoDeTYP+fGFkfH0e0l/X6hy0xiquZXJqA
Date:   Wed, 8 Sep 2021 01:12:06 +0000
Message-ID: <20210908011157.5p5djdrjaxqqwkax@revolver>
References: <20210902201721.52796-1-peterx@redhat.com>
 <20210902201721.52796-3-peterx@redhat.com>
In-Reply-To: <20210902201721.52796-3-peterx@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f16a664-67d6-42fb-7c56-08d97265acf8
x-ms-traffictypediagnostic: DM6PR10MB3500:
x-microsoft-antispam-prvs: <DM6PR10MB35001832AF11720A3CD39B11FDD49@DM6PR10MB3500.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VHBn2/xUzhdZERs6/7KQmFVT3kvn/cmt2gKTKSeTDZJ1+CMXIejVLt9oVPgOZK6NfsRtNoYlcD0TF/7CYbNyfrcc4ebqzNvMLGjFF6OQqvR/PW2NXL2ibJPdREt50SOG1Su5LFLMUbKmsaLgpTGA6anmM7mo6nkaAxruDkbJWnlYpRb3rZSU5Y39K57f28VmQ9jJ1yAMxtea6XZMluBq1jA2IDpp0xWOLVnNYVPH4KID/wdqjQvbFdimTqlMWR9Wvy1hCF4ruE4SskH3UEDkuVlNtTr8Dbvbh6mpcGullkGrFvyw/vWyPAnlzu5ZTicn17+P9KoWzTtALEWZuYeDThhBVU+ebRoKeMlH6slseeGpPQ/7bKQ2Ku5gD2JnS62AdS2zHZhxZCO20z37Loy/99/42+oCyC186Fbn4R2elxLkTdQjclxnJsIw8broEeTx9r67m4o/qMRZzcHm/G4o24YzqEWDav9mA2hyKgvjniLCHdZ3K9BKmiZ2lxOpnHVtMn+xY36sy9HvnM/yKEPS2quzdNKUBO4hwWR8mLhcZoOXroazBReKi1luoY7v22Qd0j6y6ytjrnkk+ao1pqACV3CUlY2P720j7mUv44IzZ6/BLZq0WiE+FUKFz35TMl4K+aXMMbqyrAfAv0QohDt/TLUDr8tTPW0XyI4famlEfIJwTT8vwzFnSwClE/Myp3G6PqX7H55oMXxrtPrrkR2vDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(366004)(136003)(396003)(39860400002)(346002)(6506007)(44832011)(2906002)(5660300002)(76116006)(91956017)(4326008)(6916009)(83380400001)(33716001)(1076003)(8936002)(186003)(38070700005)(26005)(7416002)(8676002)(38100700002)(316002)(54906003)(86362001)(122000001)(9686003)(6512007)(478600001)(66476007)(66946007)(66556008)(66446008)(64756008)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?K/0pxOewITrOltszLkeZCy5QFixTXjhH/5yLtxpjLNkiaf8lG77ITb33uVox?=
 =?us-ascii?Q?ee1lrk3ycZte1gxQwCUvQHuBIPxlCXsgtZm0hZ/Qw27ks1lzsNRJHRizTqZt?=
 =?us-ascii?Q?4ne/2kg0WZqBXC5u24WcmDYJ7t0exyoqakO/xC2+BwdmxUviqIWQZ39hDZGE?=
 =?us-ascii?Q?oWOf+ah5xyrj5m6HxY2Wv/KXP0/XryafLHIhhWN6G5q1FlcdsVD/+UhhY0OV?=
 =?us-ascii?Q?xfeBZn9lH3w7mlhtTXN+Aw63NBDvTNtwVXCAzNSH3ngkUz9LdzVZlnvDpv5s?=
 =?us-ascii?Q?M63LQQUnVwC33knakvBkpfLkXxuywPFDim9CB4Q98e0WZ6nXy5BLuEV63idL?=
 =?us-ascii?Q?JSyjvsMhCZw5nABohTeCtnj+MdRlSmRsDrlnzylXS9FKOxoQxAnUJMSGwmZs?=
 =?us-ascii?Q?4EHxVGQaplc2W9UpJVb9llmVmxfQBWyARgrnL25yEHlbscH8wBJDvaEwjs4Q?=
 =?us-ascii?Q?/xuZjyf7/o9zS0u7BRtNzraGz2AuQ0RgE7HIG4bCfjhJV9/rHMTQIb63oWhQ?=
 =?us-ascii?Q?GBRdQaCzq7Qk528bH9I6HFfRLnvcCkH0k2FZac5NuLjlmw98qtoyRv7NYJkQ?=
 =?us-ascii?Q?XMW+k4chu2VnweTfAELlEPwyOUwu5NHPS6Bwq+7vEjQH/vts049JtYXlvZZu?=
 =?us-ascii?Q?r5Jx6j95hhy5pV073IEgr7lOKv4vSRfzi6l6Y1aB2kr/7GJzS68mQ+eajdA+?=
 =?us-ascii?Q?Y6nTw+FTklLNzga70OgvcHE6D3xJKz1GrJSyp55p/YsVL5A1SH4SOrtmmSpN?=
 =?us-ascii?Q?RDYTlxSKmbJYGoyWQ9tsXzLwwblLj5ddWHJl9xEv6hm1ZGkiYPBTOl06wuyn?=
 =?us-ascii?Q?QENaVyK/wyO33U5RMz2wbtIrSPUqihn4eivFbSUq9kQVQWeXQN89Cm+5yZCd?=
 =?us-ascii?Q?e9lahZDrcBtcbRIDePNtQVumDqCKZOwYB0tBQ12FPvbUEf+CPf3eAECCwgDU?=
 =?us-ascii?Q?upwhrQNCx+QFggx467EZ/SmC8YqLkhO+2s6oDCwCDgVJAWitaHFfh6HHC2CB?=
 =?us-ascii?Q?TElw0Ok1vQ/evNjj0dGHyozhIqXOrh1FnT4LUjveSAqt1Qe1U4derdjA7Vwo?=
 =?us-ascii?Q?KjbcxHSmz9ov0HITN9u1+1T1KnRqtpAPrDRjnHw4yNOGsXU2oYwAqZygMytb?=
 =?us-ascii?Q?g4PcPiXiQh/7mh8KoeY4C3/k4Pe8bcWTwwKb+bdHTMzbwCYq95VD0dbhWMZo?=
 =?us-ascii?Q?wyAwIZ8kRvXcyyiCHgVUgnkhxg/j8zdLXtSa41D5k01LIM0wqYUHNSY3kHXU?=
 =?us-ascii?Q?Q4eUqx+MYSZbVxRzGg8GqZYKWokw8ETbSmps32/n8hs8YVDj0cWOzTmx8t73?=
 =?us-ascii?Q?bWKLK0q1VTairlqzRTNDdtIh?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7D511A2985F9A44DAA8E287CD22B65E1@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f16a664-67d6-42fb-7c56-08d97265acf8
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2021 01:12:06.7750
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rcAwZxuJyxEhbHdGAh77zkySxYPBbNMJbfal5cemA3YMEskIqENwEPj4Cgpj911ZtU//thV/epTwK3/HOVsnGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3500
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10100 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109080005
X-Proofpoint-GUID: EBu5FBJ9zrQ_JzPoknvFlKf7_jUGqLkf
X-Proofpoint-ORIG-GUID: EBu5FBJ9zrQ_JzPoknvFlKf7_jUGqLkf
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [210902 16:17]:
> pte_unmap_same() will always unmap the pte pointer.  After the unmap, vmf=
->pte
> will not be valid any more, we should clear it.
>=20
> It was safe only because no one is accessing vmf->pte after pte_unmap_sam=
e()
> returns, since the only caller of pte_unmap_same() (so far) is do_swap_pa=
ge(),
> where vmf->pte will in most cases be overwritten very soon.
>=20
> Directly pass in vmf into pte_unmap_same() and then we can also avoid the=
 long
> parameter list too, which should be a nice cleanup.
>=20
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/mm/memory.c b/mm/memory.c
> index 25fc46e87214..7b095f07c4ef 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -2724,19 +2724,19 @@ EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
>   * proceeding (but do_wp_page is only called after already making such a=
 check;
>   * and do_anonymous_page can safely check later on).
>   */
> -static inline int pte_unmap_same(struct mm_struct *mm, pmd_t *pmd,
> -				pte_t *page_table, pte_t orig_pte)
> +static inline int pte_unmap_same(struct vm_fault *vmf)
>  {
>  	int same =3D 1;
>  #if defined(CONFIG_SMP) || defined(CONFIG_PREEMPTION)
>  	if (sizeof(pte_t) > sizeof(unsigned long)) {
> -		spinlock_t *ptl =3D pte_lockptr(mm, pmd);
> +		spinlock_t *ptl =3D pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
>  		spin_lock(ptl);
> -		same =3D pte_same(*page_table, orig_pte);
> +		same =3D pte_same(*vmf->pte, vmf->orig_pte);
>  		spin_unlock(ptl);
>  	}
>  #endif
> -	pte_unmap(page_table);
> +	pte_unmap(vmf->pte);
> +	vmf->pte =3D NULL;
>  	return same;
>  }
> =20
> @@ -3487,7 +3487,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
>  	vm_fault_t ret =3D 0;
>  	void *shadow =3D NULL;
> =20
> -	if (!pte_unmap_same(vma->vm_mm, vmf->pmd, vmf->pte, vmf->orig_pte))
> +	if (!pte_unmap_same(vmf))
>  		goto out;
> =20
>  	entry =3D pte_to_swp_entry(vmf->orig_pte);
> --=20
> 2.31.1
>=20

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>=
