Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FDF38C937
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 16:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236772AbhEUO3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 10:29:40 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:42060 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbhEUO3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 10:29:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LEPMdY062841;
        Fri, 21 May 2021 14:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : references : in-reply-to : content-type : content-id :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=mCn7iPRg0PtCsdYMQHuz7zvj4GGWZBXOVifveHno2w8=;
 b=a8/fBk1lUE2b31qf+PkbQNEEx9AySiLfguiDnwvk1yaYP9bAbd2j64ZXIZpUV5jVipaU
 RpspElyQWdSsl2Rvjfdk9wmDsjRR4glfJi74o74iAOPo8nPKpTIa9+NXA0Na3KU0xkXd
 O5+LP7phs3JVWvsJf+fw4HqDStKJyCahjla1qekIPRBKuXq83X4EG+YQv1DvZ9Cs90EO
 frxeI71qmbxCgUV/93fcI+ZqCIO2jf9ZeZ1X0T+MeBAVnFGLI4cmlz95OIXooMRw/5Ge
 KNNMelX/9xGLNJevFZa4xtqpPKVZW2b9b+jkGE+8OQ8VgNfrlAy0RpIagXwX+HQ6jTU5 ew== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 38j68mqt94-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 14:27:53 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 14LEQKCL010869;
        Fri, 21 May 2021 14:27:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3020.oracle.com with ESMTP id 38nry2xvb3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 May 2021 14:27:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YCiPpozNaLtcftAUNYKHJmsvPoQEYn4HPsZXJp9bXXncF9vaHgGfwQaoXwVCI7JdK5JkthbU4UsViqJi0i2y7/btYpM8SvJH8Gf+qs2dHif4faLnkwGGBv9oNd5zuj19+Dlb5UwPoCcbdU9KwvYfzGH00bAIOBNesGxHI3/+NxK5ec8S4cY1HgpmsVhxcPrgZeIRfvnvp6ButXPOIZCXEXyr8yzj6GOvhQXlfxz0n73+B2yR1xHjt0YYlxxpUzi+8CYPOs7ZZZi05QCUPHHz3V5OdA0Ig4LSPIyDb2yOHfucNRILBxUEZzagCJQQ299IlJJOUYRJKUaPDDnpXC03gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCn7iPRg0PtCsdYMQHuz7zvj4GGWZBXOVifveHno2w8=;
 b=kEoX5T1CezJyS2aahuB7Q5JqHYmA2Mzp+RCARwp4Z1EflWB+uM78H9ShzqUG/6A3pCUfQwzGvPeumW79ALLgM32e5gOzadEt103p6ftp+VkASfV+1bmD1r/e4G7v7SeiH7Omf2dAUZTKLpWEoTflHLrkFJgmRcs1MCJ9MuIq/LebP4rLA6F7/WZINMRwU/BB11ddFn5c4uUeWVf3gfoyCenwvb5MKuPsHlU3/u/+FOfcfAMXKM9N82xIg7K6KCKC666Ed2N5BiC1SQeHn4U/ttSmPdzET0ivqt4o0160JNPU+8iyTKg7l2n4wos9Vrn3xDq4EZir+6uwhY+UdBpmiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCn7iPRg0PtCsdYMQHuz7zvj4GGWZBXOVifveHno2w8=;
 b=Oan+Un6Jtl+LwUURmkqp4OLFmMhcQRqiWA3RhHtIyNZMa7+sfBqz//qzQkBOm93aQx9SSUfM0E8b1EOuZJFv1draCHuTHQTT+lBfTXGZp+bVYA0iWcXmA29pQXyZwrlSTJyTe2C1J14nCZ4XzvDYWYtMngW8BrhOk1uyZ55NswU=
Received: from MWHPR10MB1582.namprd10.prod.outlook.com (2603:10b6:300:22::8)
 by CO1PR10MB4580.namprd10.prod.outlook.com (2603:10b6:303:98::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 14:27:48 +0000
Received: from MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811]) by MWHPR10MB1582.namprd10.prod.outlook.com
 ([fe80::353a:1802:6e91:1811%8]) with mapi id 15.20.4150.023; Fri, 21 May 2021
 14:27:48 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Song Liu <songliubraving@fb.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: Re: [PATCH 20/22] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Topic: [PATCH 20/22] mm/mremap: Use vma_lookup() in vma_to_resize()
Thread-Index: AQHXRb3EvCCiex4CdkS+XkdMnKxOcqrtXIOAgACy5wA=
Date:   Fri, 21 May 2021 14:27:48 +0000
Message-ID: <20210521142738.d7pbsxv453ebhrrz@revolver>
References: <20210510165839.2692974-1-Liam.Howlett@Oracle.com>
 <20210510165839.2692974-21-Liam.Howlett@Oracle.com>
 <20210521034719.fkaotqikwisie4kq@offworld>
In-Reply-To: <20210521034719.fkaotqikwisie4kq@offworld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lists.infradead.org; dkim=none (message not signed)
 header.d=none;lists.infradead.org; dmarc=none action=none
 header.from=oracle.com;
x-originating-ip: [23.233.25.87]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2205c113-ce2e-4d8e-4289-08d91c649bf2
x-ms-traffictypediagnostic: CO1PR10MB4580:
x-microsoft-antispam-prvs: <CO1PR10MB45804192EE542A2B96BB79B1FD299@CO1PR10MB4580.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rSiac/DMW8WBtxS/RUPEO5eFdo7fcYqFeDFLlv6ypZwqn0f/QAYOrBvBcP2Rp5LYayvdqJsj6SlFdjD2k6Kc3z1+4OPkS/ALt9UudGbtC1Rxic4hiY4AtXjJL3AZg9Yyx32uGTIPBu2u3FAwkg9RvAeg/lSmpu3LnpKfCK6EGT4EV3GQWrulyTApqLzKcLtrFfCh+SVHlsEREagXqSjx9m55u/iExgrZQNL38bFwUxTp4oHlk2ngkdaVjJLAIb+QUBR8OJHcjDitSxOuRiP9qs/jTntemuMYUZEHPtlysFEVlRKZ+N3qD08dRbWKkclnfJvdqKsychRthHcjPHmoMTZWIABXMkvWSkyVS4BSfu73Vq26ZlMFYYpQwuCf7C/r43DD/J0quRuBizi8J2GXh/BscwaazWGZ8mtiWH8v3dL8ywsoc5xnTAo92wkY8y3C+SdEPrVUwakZrR8LYvopTg37JGr9a0svosVWhgBmgI8IuR5jtlBSpQ5Au9PyXIHNvDO3hE6TgTbtdGblruGDEyrud+QD2pk9jaiiuTM8UePDfSb/2HkNkd2kL1DQAHin8QwBrLwOTPGeRidJ8Wf+N2A6vUdW9xP7j+R4V6eMNsKlHiQNSPCMtw7RztbIwPm9NUN07aclstGGhkuWPtEdsg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR10MB1582.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(376002)(366004)(136003)(346002)(396003)(39860400002)(71200400001)(5660300002)(921005)(186003)(33716001)(44832011)(1076003)(83380400001)(122000001)(91956017)(66476007)(76116006)(2906002)(316002)(38100700002)(66556008)(6506007)(66446008)(64756008)(7416002)(110136005)(6486002)(26005)(8936002)(66946007)(478600001)(6512007)(9686003)(86362001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?n8265GKt4CM2wmBP4gxRJDCCjwhVACVBLd/5FelXG28IEDQs+tu+QSeKXUrB?=
 =?us-ascii?Q?EC8X8yC1q2a5rg4W8Hm18iwjKDe/GuCF/jg5tEPeq3pwLjkYvamM6ZbdJzb8?=
 =?us-ascii?Q?yppzSpf+rHDWLmfmG/K1R8XvEbj6tbveMl2Ux/21yBVG4tIUyIFEH5Aw7uc/?=
 =?us-ascii?Q?r/MM1vnnJlF5FMrwc8vmTciCtn+ks5O8wgmx5oT5ASoMezMGdw1tlkYqkpRm?=
 =?us-ascii?Q?KkRprdgMgeSj7FlsFHB8g5BmsLR8rnqmtNbqHy4Cxxpn9moyjN0kXFaN+a4R?=
 =?us-ascii?Q?5IUS7X19/uOZt0VJ6THFlYBzF2+d2A0eWQFoqgug9yaSp89r4X6D+Z9yKVtb?=
 =?us-ascii?Q?af653hptzg5dMF+SPo5ZyAkAcOVXm+n6n9zrN9RuNg+7i1W7Kd+JQfKR2/p+?=
 =?us-ascii?Q?vuoeU/fCJdmdsvpvdscgctYjhtWF6t2bcspO+RZ3RIAFZHVt8cungPh/Jsq6?=
 =?us-ascii?Q?+GIyEoduM+KS5F6YQO8869JiUp4HnDvMi9wWIq4FU6TcAC0Wa5/QUNG7R1tH?=
 =?us-ascii?Q?eeXoQt2vtTT1Ot0roLRIBMFhwHz702W41lMIm3vMTCVLyUuNBvA+3vLDh882?=
 =?us-ascii?Q?8KYQ+UkFJQJhaHyBWBt5T/epMCiMJwtzAyO1KXV9i/msUIt+Kg7SuwkvLcS0?=
 =?us-ascii?Q?/nG2d1E3n7Hc004hyakt4FIEFssoUfGRzQJEPr2vUulvttSjFYkppGcZhXGo?=
 =?us-ascii?Q?zIx5gVf1hvSTwe9n9GNZFVFm4Xs/5ujXjY367FD+yhvCXfCMTS1g3ywrkp6z?=
 =?us-ascii?Q?WwBtHrzA61Amh2fHKc5SY2808Ze6QEZIZP+aIfwYeQAQFaciWKsbcSTlt9Wx?=
 =?us-ascii?Q?saDV7XDrc6u0tkTVDizZU9ALbqFnkHd6OvT3c2RUBo2kl88vyWyoAvlrpFUt?=
 =?us-ascii?Q?HGeZ/SjJ/U+h5q7sRIFiNA6OVKOE3ebi17iddVyaaotVUfJ0Now507POziSx?=
 =?us-ascii?Q?BzjafJB6+1VAguSsPs8Wa9IHLb1VNGJIEYN1NGbUzbeTPiFWLjYaj3jKvChj?=
 =?us-ascii?Q?N0MNch/zisi1qCy/0PYz5wUbRp2hQH8CY+0nV80UATmD5JsOTh7VpJbUKk28?=
 =?us-ascii?Q?IIgd8JeZzVPIxga2tD+3712dTjUaWQnjJnQ/7107GQ8y06O4Xmv2dMb4NaTK?=
 =?us-ascii?Q?O5FSut5HawncPrT9BUpTKzgVFOGv0LASOiWdNdKMWQENKotPr3jonPhZdOyT?=
 =?us-ascii?Q?z6gGATuXSAcqXWN7M9nPcxqvRGa69ntNJPmstz9lPEx4wbdfMDEd6g2uK29w?=
 =?us-ascii?Q?rHyKWvtTewnj2QDqDkNHoCMW2IQRjq36a5CClIpdD2xfWkowjYvY4N7xGi4g?=
 =?us-ascii?Q?rWDboBBqOUJIQnJgoI3CCs/M?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <689EA8EF99A9DE4191303239B5F157AC@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR10MB1582.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2205c113-ce2e-4d8e-4289-08d91c649bf2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2021 14:27:48.6589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tDHVRDZR1j7lZta0FyiBiwTx+zCjiUs9lbzgbK6sdmy8D3MGmZuTUADAUf+ZL5OeMl/zQsuxA9tbqG7UJK27+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4580
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210081
X-Proofpoint-ORIG-GUID: XcNvzKzggXUKzfz5gXG3DAlbHs-bpiob
X-Proofpoint-GUID: XcNvzKzggXUKzfz5gXG3DAlbHs-bpiob
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9990 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 clxscore=1015
 adultscore=0 bulkscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2105210081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Davidlohr Bueso <dave@stgolabs.net> [210520 23:47]:
> On Mon, 10 May 2021, Liam Howlett wrote:
>=20
> > Use vma_lookup() to find the VMA at a specific address.  As vma_lookup(=
)
> > will return NULL if the address is not within any VMA, the start addres=
s
> > no longer needs to be validated.
> >=20
> > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > ---
> > mm/mremap.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/mm/mremap.c b/mm/mremap.c
> > index 47c255b60150..04143755cd1e 100644
> > --- a/mm/mremap.c
> > +++ b/mm/mremap.c
> > @@ -634,10 +634,10 @@ static struct vm_area_struct *vma_to_resize(unsig=
ned long addr,
> > 	unsigned long *p)
> > {
> > 	struct mm_struct *mm =3D current->mm;
> > -	struct vm_area_struct *vma =3D find_vma(mm, addr);
> > +	struct vm_area_struct *vma =3D vma_lookup(mm, addr);
> > 	unsigned long pgoff;
> >=20
>=20
> Nit, but could the vma_lookup() call be separate from the declaration
> of vma?

Yes, I will make this change.

>=20
> 	vma =3D find_vma();
> > -	if (!vma || vma->vm_start > addr)
> > +	if (!vma)
> > 		return ERR_PTR(-EFAULT);
>=20
> Thanks,
> Davidlohr=
