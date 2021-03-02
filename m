Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67AD532A688
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 17:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574374AbhCBPPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 10:15:36 -0500
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:39486 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1349312AbhCBMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 07:55:45 -0500
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 122CentX024208;
        Tue, 2 Mar 2021 04:47:55 -0800
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com with ESMTP id 36ymau98kk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 04:47:55 -0800
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 122Cepcu024233;
        Tue, 2 Mar 2021 04:47:55 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
        by mx0a-0016f401.pphosted.com with ESMTP id 36ymau98kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 02 Mar 2021 04:47:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KeNxN5E8ptuR2wMtRvTHbyLUAQTZvvXlk9rfKXPIm8Uddg72TJ1DWn8BMeFf+cw9XAmkZYNKKaXUQNTQ/mwHILeezChyYnWs7PLls0nka0qxeDs5VySZ1W5gMwgoN37AZne+CN68wj3yiFKFfGS9KBpBcgLixwCpJtYIUB1125x9t8cWzPAWsMsJGFdCncRoxoWTO7CWbvT/WMuWc2eGY1wLLNteneWCs3U4vMTlte7TEBV5eA+kU7d6wf6LGWhoFHt9tB3k5mVSNav7Y/Z/fmcqc0LY/OXIDI0g6CH2zT5AO1qstAeLm9N1hR0t9VAaFpoNBttprPrJmbfhe8r+uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovb7OrFaO+Kv1XwqI5UqiABX5VFE06XQtIFb4YVd/8M=;
 b=V8/8a6LmqBH4J+jafsAdQQ7+mSW86N0YWWh+HL8ELWhxz+hQAjSduKXsQwIQog1wxMIPrLvQzwo4PjerOvDcZoWupmiZnRhb3tGlDsKK3HZOSFZNcP/TGjtcsksjXsEEa8yfQ9zbtI7KHZm5vq2q5ZHlVszty6anOTgnKETLA8nq/3xZWSrT2kd7hkI/YpfbqMHDlVFwKFq+5NhasKMzV//eHBnPtIcsOwk7G5AZa/A1OJGKTh5ZmCuhou0D0CNUmdpAytjMhJTeTAjHPSGcTn7Z9CEHG2sq13/njlQPkysDvL+lrJnngMmZgmoO36UnWLeNO8Oh+ofQ8KqCdtI7kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ovb7OrFaO+Kv1XwqI5UqiABX5VFE06XQtIFb4YVd/8M=;
 b=N2r6csvjzM7dMqAgRuWubsq6M+FHYjJ5nGKHJ92I1BPpnsB7FUkTVfBPWDf1hlBJVdkk7A3mFwGpVTnqzQmv41VtORjBpgTTfQG+QqGxVo2peozzRhFNb5X2PIRd4IhCxWvpAe+yKRqNb4FlRP8Gb0hh5KlCQHS2JdLqxhn3F00=
Received: from DM6PR18MB2698.namprd18.prod.outlook.com (2603:10b6:5:16d::28)
 by DM6PR18MB2874.namprd18.prod.outlook.com (2603:10b6:5:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.28; Tue, 2 Mar
 2021 12:47:53 +0000
Received: from DM6PR18MB2698.namprd18.prod.outlook.com
 ([fe80::91d3:d926:9cb3:4ab3]) by DM6PR18MB2698.namprd18.prod.outlook.com
 ([fe80::91d3:d926:9cb3:4ab3%3]) with mapi id 15.20.3890.028; Tue, 2 Mar 2021
 12:47:53 +0000
From:   Bharat Bhushan <bbhushan2@marvell.com>
To:     Ankur Arora <ankur.a.arora@oracle.com>
CC:     "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>,
        "terminus@gmail.com" <terminus@gmail.com>
Subject: RE: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Topic: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous
 calls
Thread-Index: AdbkRnC96D9dwqxzR0eR3ijlJSqy4gAEULUAAnocGfAAW82ggAcKnP6AALubABA=
Date:   Tue, 2 Mar 2021 12:47:53 +0000
Message-ID: <DM6PR18MB2698B4CB0114D7D1FCE74B4BE3999@DM6PR18MB2698.namprd18.prod.outlook.com>
References: <20210121043907.76037-1-ankur.a.arora@oracle.com>
 <20210226005333.1576246-1-ankur.a.arora@oracle.com>
In-Reply-To: <20210226005333.1576246-1-ankur.a.arora@oracle.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=marvell.com;
x-originating-ip: [122.172.196.126]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f1608bfa-762b-477b-a197-08d8dd796573
x-ms-traffictypediagnostic: DM6PR18MB2874:
x-ms-exchange-minimumurldomainage: proofpoint.com#7146
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR18MB28745A751E6DC87A765AAF37E3999@DM6PR18MB2874.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pclLXiDyNJtSer5RXakEbrR9Ip568jQbmGh8leryFgoC0Moku+5SR8sxUGYMidmRasKG0tQLIQRJGBt5nIhtzinP1EnPh7uO5LgojccHkQUeGengpq6TjmFtEgSpa50q0pLyb9pMeM8o158e/tv/5JfYKK1oLWCLwXgqW5q6xiGBKu6g+DAQzLNKuUwJ8E+QpPS6Tb6BdGKVCUVjwKJyG7WqtkgOFCtCG3nu51fsQmmeKIfZovX488i5fs8JAhxW5yLnMWNDhidgrG+b/JMKFmwDezthRHjaM/R5f5vIvM61tGLjL0yyBfuT7kvKISVtw6SBzDV/ghvDqcoLE55Ddae5CP1KFsS103qlf2pA5KqPhg6NwygWglqdVxnRptprjNOl+CIZG12iI3x91uDLHQ96nZtZ0RBJrYsRcq9yH2RGBaOjpnPurp9PtZ4yATOqm37EUp2saAkmzY7mupL+PjrQZdQGQ2VAr3uiSN54lcSa3Wn2CNYBmF9daCrQoMyTOMCzEAiQehukZMW7N9+YJzF+X2605Q7vXD8e1o2iuHPUKpgxE6HLWiPv8V9MGFbwEKeUMPTwpBPuWwqes2LMPMA3jFfY0J1VnrBGWvPRsWA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR18MB2698.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(346002)(39860400002)(396003)(376002)(8676002)(64756008)(66446008)(6916009)(4326008)(186003)(7696005)(5660300002)(66946007)(26005)(71200400001)(8936002)(66556008)(478600001)(55236004)(966005)(52536014)(2906002)(66476007)(76116006)(316002)(53546011)(86362001)(55016002)(9686003)(6506007)(54906003)(33656002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?xUq1PDhMF177Qi/32NqRxKi0/7+n+nktk4zxCocVHZGNakUVOIwm2w8acny8?=
 =?us-ascii?Q?djUKL9z30alVp/wEjMzX3aAYxuiG9MCDYkQE2Mu0wVDM0M9tBvqnZjBGtDos?=
 =?us-ascii?Q?s2bRoDX5nfgzzcdhZV//tC+nBD4yu1dnSixzii/B78t7XD8NtGKIz/f0Eu/e?=
 =?us-ascii?Q?A13ZFPqZASFJLWeH+U6cURNzYERRfpmrqrRAFbtj0reL5pZrc8nRqZISaDuf?=
 =?us-ascii?Q?MviaD5dBUTKs0TAC/b0xtWJ8f6pf37iiQPoSV8424oo0rE9XhtFRM+0j5/dB?=
 =?us-ascii?Q?hxMPz6E74SmrTSGx+7o0MRLsmxvh9FOxToKxp3vUFalkmspaCByXJSkK3ysO?=
 =?us-ascii?Q?4BQj58yAM3cNAow1tI+SBhKUT8GYKEKcl+hnxxqvDZy7CDzjRaYX5gN9Kxok?=
 =?us-ascii?Q?P1LQiZZWdj4eEoknPjVTCSesfssT+OzgFWgBV9V0R8QCjDsnwpAgkTEUkt3D?=
 =?us-ascii?Q?fLwgTM7xFYPuKTJWnNM3LCpBEcx+Na/NIRlc4ghp8xldHGwaexAeSzIaV8Mx?=
 =?us-ascii?Q?YTJmOO/yJCfoyTj3NQiaV6Gsvy2gJL63gKNLVEBtITnKSvGVrzxu5JgrL2jy?=
 =?us-ascii?Q?S/u+Zf4RlwrhiDaqwdPdtTmyo1y/MyTH/pZfVzqUR3iomhYgKhP/shI3cFnL?=
 =?us-ascii?Q?8Hkx1wlERhszrrwSAfoLFWjSChOg89F1hoC/Cy5Mxm1UqvNZhbE0D3HY/nOn?=
 =?us-ascii?Q?sstNxIgahFJTL4TzQrbsYDqa80HB6CEzcpptEv6XQ8hyE7TmiIFEGjVaOzbP?=
 =?us-ascii?Q?66dNoS1qOdid+25MZtVemwtqx2dEedzK99n7mkTELJbYLH81sIOmo6PFZkzP?=
 =?us-ascii?Q?1bqXWXxy0lfxCCzCTrtRvOwy+2GPoN0guX8nNX67NmP9iDcEhyzGHVnNyZfM?=
 =?us-ascii?Q?lz63SvcKjgltSib0xfCyB0Wg9xJeCTfBvAL4Z1Uh1rZ4MR3gHjKOqJDeCH4J?=
 =?us-ascii?Q?LPnqVKIgPXN4PPsfRnGcpd5LhlxrdW8Xfp+DZNZ3R6Fhh2UnhBmBi2+Sy2c8?=
 =?us-ascii?Q?jrQ+n5NNi/5AKunySHlVvFSmHs/j+zuhJfSsrpwyWt0fUMeKk38NpTF7h9aS?=
 =?us-ascii?Q?pL6caoc1LeQ4iGZ7bynwXnGlI9JqDXiPIGHqnkPg+gZ6/dL2a6mDVc4+qQNK?=
 =?us-ascii?Q?nXnKrYTcdhRF5/BghF47Nz8X8mbcWcGEjVQseGSbT4nXZrCJoenUyxR8x7Cb?=
 =?us-ascii?Q?dLxKqBMtIh9NPMY4DOM5y1tZ5kXU7isGq1QRzZJaIyGAieXq4u+/WGaSSH/6?=
 =?us-ascii?Q?hcxTJ+g4UX1dApeaL/JPatOz/Du/RLLZsLBVmHuaSbYzUSpt5H1zSNHevT4w?=
 =?us-ascii?Q?L/oIYm6npBocujuJ3UQrKDPs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR18MB2698.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1608bfa-762b-477b-a197-08d8dd796573
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2021 12:47:53.4683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CryX2SebubFSzJpNtQtE5iw94Eb1zALwPM+D/EiFMKOmxZn68bPRCpDI2n+Ief4IsHGDE/Rv7FMAdd1ErInUmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB2874
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-03-02_06:2021-03-01,2021-03-02 signatures=0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ankur,

> -----Original Message-----
> From: Ankur Arora <ankur.a.arora@oracle.com>
> Sent: Friday, February 26, 2021 6:24 AM
> To: Bharat Bhushan <bbhushan2@marvell.com>
> Cc: alex.williamson@redhat.com; ankur.a.arora@oracle.com; linux-
> kernel@vger.kernel.org; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> terminus@gmail.com
> Subject: [EXT] Re: vfio-pci: protect remap_pfn_range() from simultaneous =
calls
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> Hi Bharat,
>=20
> Can you test the patch below to see if it works for you?

Sorry for late reply, I actually missed this email.

Reproducibility of the issue was low in my test scenario, one out of ~15 ru=
ns. I run it multiple times, overnight and observed no issues.

>=20
> Also could you add some more detail to your earlier description of
> the bug?

Our test case is running ODP multi-threaded application, where parent proce=
ss maps (yes it uses MAP_DMA) the region and then child processes access sa=
me.  As a workaround we tried accessing the region once by parent process b=
efore creating other accessor threads and it worked as expected.

Thanks
-Bharat

> In particular, AFAICS you are using ODP (-DPDK?) with multiple
> threads touching this region. From your stack, it looks like the
> fault was user-space generated, and I'm guessing you were not
> using the VFIO_IOMMU_MAP_DMA.
>=20
> Ankur
>=20
> -- >8 --
>=20
> Subject: [PATCH] vfio-pci: protect io_remap_pfn_range() from simultaneous=
 calls
>=20
> vfio_pci_mmap_fault() maps the complete VMA on fault. With concurrent
> faults, this would result in multiple calls to io_remap_pfn_range(),
> where it would hit a BUG_ON(!pte_none(*pte)) in remap_pte_range().
> (It would also link the same VMA multiple times in vdev->vma_list
> but given the BUG_ON that is less serious.)
>=20
> Normally, however, this won't happen -- at least with vfio_iommu_type1 --
> the VFIO_IOMMU_MAP_DMA path is protected by iommu->lock.
>=20
> If, however, we are using some kind of parallelization mechanism like
> this one with ktask under discussion [1], we would hit this.
> Even if we were doing this serially, given that vfio-pci remaps a larger
> extent than strictly necessary it should internally enforce coherence of
> its data structures.
>=20
> Handle this by using the VMA's presence in the vdev->vma_list as
> indicative of a fully mapped VMA and returning success early to
> all but the first VMA fault. Note that this is clearly optimstic given
> that the mapping is ongoing, and might mean that the caller sees
> more faults until the remap is done.
>=20
> [1] https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.or=
g_linux-
> 2Dmm_20181105145141.6f9937f6-
> 40w520.home_&d=3DDwIDAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DPAAlWswPe7d8gHl
> GbCLmy2YezyK7O3Hv_t2heGnouBw&m=3D3ZDXqnn9xNUCjgXwN9mHIKT7oyXu55P
> U7yV2j0b-5hw&s=3DhiICkNtrcH4AbAWRrbkvMUylp7Bv0YHFCjxNGC6CGOk&e=3D
>=20
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  drivers/vfio/pci/vfio_pci.c | 25 ++++++++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
> index 65e7e6b44578..b9f509863db1 100644
> --- a/drivers/vfio/pci/vfio_pci.c
> +++ b/drivers/vfio/pci/vfio_pci.c
> @@ -1573,6 +1573,11 @@ static int __vfio_pci_add_vma(struct vfio_pci_devi=
ce
> *vdev,
>  {
>  	struct vfio_pci_mmap_vma *mmap_vma;
>=20
> +	list_for_each_entry(mmap_vma, &vdev->vma_list, vma_next) {
> +		if (mmap_vma->vma =3D=3D vma)
> +			return 1;
> +	}
> +
>  	mmap_vma =3D kmalloc(sizeof(*mmap_vma), GFP_KERNEL);
>  	if (!mmap_vma)
>  		return -ENOMEM;
> @@ -1613,6 +1618,7 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fau=
lt
> *vmf)
>  	struct vm_area_struct *vma =3D vmf->vma;
>  	struct vfio_pci_device *vdev =3D vma->vm_private_data;
>  	vm_fault_t ret =3D VM_FAULT_NOPAGE;
> +	int vma_present;
>=20
>  	mutex_lock(&vdev->vma_lock);
>  	down_read(&vdev->memory_lock);
> @@ -1623,7 +1629,21 @@ static vm_fault_t vfio_pci_mmap_fault(struct
> vm_fault *vmf)
>  		goto up_out;
>  	}
>=20
> -	if (__vfio_pci_add_vma(vdev, vma)) {
> +	/*
> +	 * __vfio_pci_add_vma() either adds the vma to the vdev->vma_list
> +	 * (vma_present =3D=3D 0), or indicates that the vma is already present
> +	 * on the list (vma_present =3D=3D 1).
> +	 *
> +	 * Overload the meaning of this flag to also imply that the vma is
> +	 * fully mapped. This allows us to serialize the mapping -- ensuring
> +	 * that simultaneous faults will not both try to call
> +	 * io_remap_pfn_range().
> +	 *
> +	 * However, this might mean that callers to which we returned success
> +	 * optimistically will see more faults until the remap is complete.
> +	 */
> +	vma_present =3D __vfio_pci_add_vma(vdev, vma);
> +	if (vma_present < 0) {
>  		ret =3D VM_FAULT_OOM;
>  		mutex_unlock(&vdev->vma_lock);
>  		goto up_out;
> @@ -1631,6 +1651,9 @@ static vm_fault_t vfio_pci_mmap_fault(struct vm_fau=
lt
> *vmf)
>=20
>  	mutex_unlock(&vdev->vma_lock);
>=20
> +	if (vma_present)
> +		goto up_out;
> +
>  	if (io_remap_pfn_range(vma, vma->vm_start, vma->vm_pgoff,
>  			       vma->vm_end - vma->vm_start, vma-
> >vm_page_prot))
>  		ret =3D VM_FAULT_SIGBUS;
> --
> 2.29.2

