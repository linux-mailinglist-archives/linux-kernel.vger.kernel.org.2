Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C593F4043C9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 04:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347880AbhIIC4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 22:56:41 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53120 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349175AbhIIC4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 22:56:19 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LKw0d028112;
        Thu, 9 Sep 2021 02:54:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=FkcOHFUfJFI/wakXoKXv8rgLDHTYgf9ZYijwUhDhBhs=;
 b=hocq3HwNoX40OstEVEJIHCUTrh1xyrU9Lt0d0Rez47oujbMlqonwQtLwtHeZzJzdpzg4
 /bKObxH8cOwEDRxdYkfrBsqRxrPpyRLDx3ob77l2ffcjLYVB5asYHP/iXkaUL/Q1q7aO
 Fh+BzJX0A64QTJal8xFPgpmnC60ePok37Nx/mYOYlbYruLde4668jBKXq/rqU77ksbra
 gKPH+VCOP6oFBrtBO+6lpIG3/Sw44JPE16vR4EUqfOMTDaxH065Q3Z80/IAK4wNMIEiX
 ekUBGj47zf6kpybFgheYVDVrQ/cdP6LQOHHKx1Czl0Il640MT1nR+IiCRSbaKcrBO8KR 1Q== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=FkcOHFUfJFI/wakXoKXv8rgLDHTYgf9ZYijwUhDhBhs=;
 b=Og8wpIUjzo3doE8btvVXnX+RptcOTaArXt12FGFR6ZZ9i6qZ0JvHYqounc1rqnkDF3/j
 abr5bWuQfQP/L1QY3QF/URnPlHi78Z2il0/8SvbRkG44dKeaIH2xGWBDRW8GOgq6jL2u
 ZejQHvFCvV52GEJidU6fjRg3ZqgdcS3gbJxS5PA3laKWKvmrLGGWOfVHA19dAdq5ifph
 zhFBqwZ4QDHq+uWMIkWlj4/2mUCMCW0dsRieR//aNQXZ3fSk9B2g+OjLTeidDemsNEQl
 79dVk+LVtATdHbRP5PeCL4fC/+2NGBFH0mNDan6ih6wOohkxVGA3qjyC2+RMYEmGNvbR KA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axd8q4t54-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 02:54:41 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1892o7xp140999;
        Thu, 9 Sep 2021 02:54:40 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by aserp3020.oracle.com with ESMTP id 3axcpn3d8r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 02:54:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ESBzbXAlrJ5/kgdIOLC2EID5P/mmcFPPVDJCh8pm71B3Hj8wX8JG/fsCQpqRlP4ZEZ+2/zMHXyljMWaERMZz8atsEm3a3FYdoPxEK6hvD+x6mV80lcCOJaobj5L8BwfVIAnGWNPK/wwL8cqnOnkqqSF/3CF0Xe/lhIM1NbQJnss4Et1RUsVzRruCmaLcezJo7cisHRGiSQOd8eSxXMxxKagoTprrBxAC710I0x2mYUTDPypxkKNfuJi7wUAveas6++tJHYbM0jzoxMyRQ3yJf+0hZvv8DDVoHd2J0XyNo0OF09TwWTKKKBC7qZZZX4LojSiKclJBrFvMfQ9KTXpyCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=FkcOHFUfJFI/wakXoKXv8rgLDHTYgf9ZYijwUhDhBhs=;
 b=Xi84xRc3ZTJeGON4z946L0myE5wAO/bM9ICK/8+WLBNv1zXHszuFTDJRWjIDv6Z0AkARvrkDgEqFw2zZZDjqlC4/NbHGq6GhYbPlO7eBd61JVRHynUyMkq41NnGG1Dlf5oozb16bgXnHDV5ndwWPXSoT06k05ZjsEAPuuuSiEZkGvlUyAcDHrDbaAJqU/xztpGYdbWXgW0pK0amxKU5cOgGy1WbpZ0V3cojlhAkSjrpQQoRwvsJsTgnDM5kKPqjvtGJAZTsf5OkhMKj+EpGVvdYyC5wn8VPCxt4zxX0hVZNLL2lG37xk5CFmxfpI1AV7ZjTZIQ4J215Phd6D86W2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FkcOHFUfJFI/wakXoKXv8rgLDHTYgf9ZYijwUhDhBhs=;
 b=g0qYKg4gwpLCpJ/yk7CRWDcPKLdBrKzN/KjstHtxtwXIANMK4zZb7rbJ9dFQqeB1gXnG0uNE2hH1Xg0g5mM4yaMpYPTSBf3lKFQMG/Bzyjq/aekcd5wd6Iuh/MDa74mG1peSYXWA8NumQUVzln13rwJfRJsaI4vU+dN9qnuUi2s=
Received: from DM6PR10MB4380.namprd10.prod.outlook.com (2603:10b6:5:223::19)
 by DM5PR1001MB2298.namprd10.prod.outlook.com (2603:10b6:4:2d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Thu, 9 Sep
 2021 02:54:37 +0000
Received: from DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3]) by DM6PR10MB4380.namprd10.prod.outlook.com
 ([fe80::f4b1:d890:7745:30a3%4]) with mapi id 15.20.4478.027; Thu, 9 Sep 2021
 02:54:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Peter Xu <peterx@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 3/5] mm: Drop first_index/last_index in zap_details
Thread-Topic: [PATCH v3 3/5] mm: Drop first_index/last_index in zap_details
Thread-Index: AQHXpM+t6SoyPoleFUevz9lOGahY2aubAlaA
Date:   Thu, 9 Sep 2021 02:54:37 +0000
Message-ID: <20210909025417.occtqoo6l7x5tnuy@revolver>
References: <20210908163516.214441-1-peterx@redhat.com>
 <20210908163622.214951-1-peterx@redhat.com>
In-Reply-To: <20210908163622.214951-1-peterx@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2384ebb0-9b03-40c2-e339-08d9733d2978
x-ms-traffictypediagnostic: DM5PR1001MB2298:
x-microsoft-antispam-prvs: <DM5PR1001MB2298E12CAE08C0469753CC9BFDD59@DM5PR1001MB2298.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: awM3JoXLYsmORzGEtkzff90b7ur8vcimiwZ+nPI0M0+w9os2lH+Vka3E/VBD+v0xfkEb07nNb00HeyJ0pjJMJMgv2sdtx+WgCxU8I698nChNR5MXNZ7aEYh8LMkZRfCy0qoBBojqjlxdmi5EAzsyq2vc9hlZfADYcZpRmhNVfRF142l8Sl58iC+c3/xXu8Y3IY8obN6dtD1Mh8vZgxJpZ1dXMIyyzkSSsNObj6Zp/DBF57c2D2bUf6D7O1OYKpUEWqRTvH9XTNCXXE0xbfKWrUn/TGQamMhU+9xfB8X8ilobZXOr+OsVoGmGzrUoD8Zq1R2YzVkLryNLxvj/PHiQRVxUsO4Utl2coMGPt5hReTkOX2GxbUG2XpqF2FCxAPkLfP6OOvPuJQbV3IAwhBSCZ9D91Y4Dn8dFIKJ3kdROn/nIQ5TJI1b92mvXL0iYTGViAXQnr7jDkzeYcTo/y95xkR6n0ZlV/HMXZefxP12hB9EUjFvmXn2UaYpZFl3gFvhvMfvGTN7mWIvkfNLk5pa7+QLdql0zXO+eWUwhRlWBW/HeON84y68B8C5UpR0tgjDdy4+3ys/gq/VHFlq1ElWwViB60OH68t739i9L/9rXOZipXOE54zbbaURrRDXtACr/BxfnJd7/AR9Pw6zEb3D3VnC7oM0iNuazfThNqfS4K+ho7BipidFRdC9kUAKDBe4hMXs9zGFdn88iYyq8lo5dpg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4380.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(396003)(39860400002)(346002)(136003)(376002)(54906003)(4326008)(33716001)(91956017)(478600001)(7416002)(66946007)(71200400001)(66556008)(76116006)(64756008)(6486002)(66476007)(186003)(6512007)(9686003)(44832011)(26005)(6916009)(2906002)(8936002)(8676002)(38070700005)(316002)(38100700002)(83380400001)(6506007)(122000001)(66446008)(86362001)(5660300002)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Et+yjArVTxXmn/1woOSovLPV1/xosdjk485EzZWjZ3UEh9NrVzY41WiFnekR?=
 =?us-ascii?Q?rM+RMGeDfhAMxviozROFyv3cuUH/NPXO21bAxhfXxZo6z9TMNum0OHiLh/fo?=
 =?us-ascii?Q?lDyWO132ygldNHKykZMIMmvgQEbgLrF2ElPONArippe9iY2c631dBeLXKRdo?=
 =?us-ascii?Q?nVEie/gXIBj+MHgOVHjvxc2ygVMrTevQPta0wohh6QDxidtpkX7etR11T7AK?=
 =?us-ascii?Q?sxdAb3aHGsi2rGn/i1LsanUWiCJw0kpVUOYRpQa/1E5qAlp2k0iv1mY+auhx?=
 =?us-ascii?Q?FcI38HnOFpFgsDHMY0nktSYss9x9tJbIa/y769jHacCC6U8HQLu0bYD6Zl9Z?=
 =?us-ascii?Q?6Lg99DUdZYU7T3jBTxdpj4p1+YUoB7T2fOPxv/fg7gkq/bulTr3ohGpB7AVd?=
 =?us-ascii?Q?XC5O+8HoNkghb0wVHvZWC5yhA4yfftAS0vnfNnvEN5wswuhLbWJeCuH0YK0U?=
 =?us-ascii?Q?bpFGyj3bs38l5qjhPioI5rANFodMJXimrtcc55TpyVxuvMmCnoUJE/u3zaTP?=
 =?us-ascii?Q?lppr8cmIsHdiBniDw8vuWvjQf/3OSzaAGbyK0/awK6EhvpJfKdCpeKjvwNVO?=
 =?us-ascii?Q?UsJT1O3PXpn6k9MenB953Tg5IolIpYG8L39KHTM+VUcmUBhfqqArcjdFlIil?=
 =?us-ascii?Q?fcOL1tPJv1tYt8EVd4quKRTZnwMmQpq1lUrdRwNgmGMwkODu7tLZsuCCoBNK?=
 =?us-ascii?Q?/t/a1I4ynYoDsZrAEecBt3WNYZvVcNIY9pkA0QNDImKkTfQ7cEBp3fVdmL5i?=
 =?us-ascii?Q?SOjtDMPRJo6nUdnEOkpdDU+aMEg/a5fX7raMKzRrr06JMfzmEcjhFOfU0Sf5?=
 =?us-ascii?Q?jV4NtGrvDfUi5zPOxalF9SqMqClSh7UCKl8RSi7xTOTuZpdvu1Dzkxdoy5qK?=
 =?us-ascii?Q?wrXzqVecOyV99A3TRVEtlq4s5EhJwvBf64Tm5nbb72GRnrKrgjz3Ig418G51?=
 =?us-ascii?Q?87Egga+j5+TCaFDoTatMwEnVruwWglC/i0fTD+NF7CQENQrcUThcM8VCa2+h?=
 =?us-ascii?Q?vY69iLalQzn8R9cCFnG88vGwaD9BaqbuYDQwUQwl7HrtsG/dy4uJSiqACnoD?=
 =?us-ascii?Q?uLkJKqDVmDl28EGlIOYgxFszc4RfS8AhggNZkCKrTR2gVcRTxfQlfQ6iBwUN?=
 =?us-ascii?Q?YAsFJxwA53DzMtKa1lLYijlw6ltmzHdMO/E04rc5OUaqDK5aG9GuMOKmZZrS?=
 =?us-ascii?Q?zzlpuAji5+3mW+J1rzNXpdpOQjl4vdCx+dNK8ifQb6oNL0TVKMM2kcikB82h?=
 =?us-ascii?Q?HzVl8+uKo3CXjoI+0IFksRj4PRzpVPC1VtnoQzqNp4hN2Rr5JhDAvSV+q1NE?=
 =?us-ascii?Q?lk9sDCt43Z5VVAtUlIGYcv1e?=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F47B35DCBAFEA6458FA366367DB0AC9F@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4380.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2384ebb0-9b03-40c2-e339-08d9733d2978
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2021 02:54:37.4060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZIlhzW61bn6N/7Poi4LrURtB4PIt3UYzUbIweGmX2T6uGjZF7AGiXML9CarDUqS0OLCQVXSysULkGoU94Ie1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2298
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109090016
X-Proofpoint-GUID: gbWarkCb8vNmg3GpaCZv2GGxSdzGCEvX
X-Proofpoint-ORIG-GUID: gbWarkCb8vNmg3GpaCZv2GGxSdzGCEvX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Xu <peterx@redhat.com> [210908 12:36]:
> The first_index/last_index parameters in zap_details are actually only us=
ed in
> unmap_mapping_range_tree().  At the meantime, this function is only calle=
d by
> unmap_mapping_pages() once.  Instead of passing these two variables throu=
gh the
> whole stack of page zapping code, remove them from zap_details and let th=
em
> simply be parameters of unmap_mapping_range_tree(), which is inlined.
>=20
> Reviewed-by: Alistair Popple <apopple@nvidia.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  include/linux/mm.h |  2 --
>  mm/memory.c        | 29 ++++++++++++++++-------------
>  2 files changed, 16 insertions(+), 15 deletions(-)
>=20
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 73a52aba448f..d1126f731221 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1722,8 +1722,6 @@ extern void user_shm_unlock(size_t, struct ucounts =
*);
>   */
>  struct zap_details {
>  	struct address_space *check_mapping;	/* Check page->mapping if set */
> -	pgoff_t	first_index;			/* Lowest page->index to unmap */
> -	pgoff_t last_index;			/* Highest page->index to unmap */
>  	struct page *single_page;		/* Locked page to be unmapped */
>  };
> =20
> diff --git a/mm/memory.c b/mm/memory.c
> index 7b095f07c4ef..6bba3b9fef7c 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3321,20 +3321,20 @@ static void unmap_mapping_range_vma(struct vm_are=
a_struct *vma,
>  }
> =20
>  static inline void unmap_mapping_range_tree(struct rb_root_cached *root,
> +					    pgoff_t first_index,
> +					    pgoff_t last_index,
>  					    struct zap_details *details)
>  {
>  	struct vm_area_struct *vma;
>  	pgoff_t vba, vea, zba, zea;
> =20
> -	vma_interval_tree_foreach(vma, root,
> -			details->first_index, details->last_index) {
> -
> +	vma_interval_tree_foreach(vma, root, first_index, last_index) {
>  		vba =3D vma->vm_pgoff;
>  		vea =3D vba + vma_pages(vma) - 1;
> -		zba =3D details->first_index;
> +		zba =3D first_index;
>  		if (zba < vba)
>  			zba =3D vba;
> -		zea =3D details->last_index;
> +		zea =3D last_index;
>  		if (zea > vea)
>  			zea =3D vea;
> =20
> @@ -3360,18 +3360,21 @@ void unmap_mapping_page(struct page *page)
>  {
>  	struct address_space *mapping =3D page->mapping;
>  	struct zap_details details =3D { };
> +	pgoff_t	first_index, last_index;
> =20
>  	VM_BUG_ON(!PageLocked(page));
>  	VM_BUG_ON(PageTail(page));
> =20
> +	first_index =3D page->index;
> +	last_index =3D page->index + thp_nr_pages(page) - 1;
> +
>  	details.check_mapping =3D mapping;
> -	details.first_index =3D page->index;
> -	details.last_index =3D page->index + thp_nr_pages(page) - 1;
>  	details.single_page =3D page;
> =20
>  	i_mmap_lock_write(mapping);
>  	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> -		unmap_mapping_range_tree(&mapping->i_mmap, &details);
> +		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
> +					 last_index, &details);
>  	i_mmap_unlock_write(mapping);
>  }
> =20
> @@ -3390,17 +3393,17 @@ void unmap_mapping_page(struct page *page)
>  void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
>  		pgoff_t nr, bool even_cows)
>  {
> +	pgoff_t	first_index =3D start, last_index =3D start + nr - 1;

Nit: If you respin, can first_index and last_index be two lines please?

>  	struct zap_details details =3D { };
> =20
>  	details.check_mapping =3D even_cows ? NULL : mapping;
> -	details.first_index =3D start;
> -	details.last_index =3D start + nr - 1;
> -	if (details.last_index < details.first_index)
> -		details.last_index =3D ULONG_MAX;

Nit: Maybe throw a comment about this being overflow check, if you
respin.

> +	if (last_index < first_index)
> +		last_index =3D ULONG_MAX;
> =20
>  	i_mmap_lock_write(mapping);
>  	if (unlikely(!RB_EMPTY_ROOT(&mapping->i_mmap.rb_root)))
> -		unmap_mapping_range_tree(&mapping->i_mmap, &details);
> +		unmap_mapping_range_tree(&mapping->i_mmap, first_index,
> +					 last_index, &details);
>  	i_mmap_unlock_write(mapping);
>  }
> =20
> --=20
> 2.31.1
>=20

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>=
